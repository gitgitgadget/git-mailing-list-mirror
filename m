Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 831841FF7F
	for <e@80x24.org>; Wed,  7 Dec 2016 21:02:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932928AbcLGVCE (ORCPT <rfc822;e@80x24.org>);
        Wed, 7 Dec 2016 16:02:04 -0500
Received: from mail-pg0-f52.google.com ([74.125.83.52]:34808 "EHLO
        mail-pg0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932339AbcLGVCC (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 7 Dec 2016 16:02:02 -0500
Received: by mail-pg0-f52.google.com with SMTP id x23so165785282pgx.1
        for <git@vger.kernel.org>; Wed, 07 Dec 2016 13:02:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=JLmB1bvyzDLJpv+srgKtsN9jiATcamJMV4pY+8RkpGM=;
        b=iGRNp5AtB2kBV/jvGS3DdNrYJ4+jkI/gKjtKKfMRLkRGm4JPLDY5RS3TUw4qFpyTC1
         0p5+gW4ceIp0EmmWGislaJWdDcDQ4fbddLQmUMD5/Ctie5AvWrydFafPM3HkQFqpyR3D
         g7ysRn/1to1zqDznq+j4z/4eUEoTalWu1Isu9gVuRfv45tJ9PQsV65bPP7sw8PlplGl4
         +QgLsym+e7VsWLO0lnw1cNyuPFIvP/1UHEq8r3uzpex3cAvUYqKj3waMgM/aO4+4B5G7
         F2OLT52pptDKuGxZRmKc4FrCoizn709fEWbQ7fpdUwoFKqwUB9Y5VYx2E3x0HXHzE7FK
         9A/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=JLmB1bvyzDLJpv+srgKtsN9jiATcamJMV4pY+8RkpGM=;
        b=dJjtraQTSMspOwqbqcadKVKimahaSBw09X5zdvk8KO+BZFgoE1yRyrbMU6pX9aqlSB
         xNAoB6QCQokle/Eo7GhxmCrGUmbDyrskpb68Gl8bmS1WyFUktpcwsJpk3zI5g2hqGF/j
         RQz4a8xoQ+sbvBJGQ2zzNkHiIBc+mOvzZpLNPyd855SJib/q0h1U75af9rjiQuosggvz
         UYT4+0Non1SmeTFRaHvP9Gom9gl73BG16VGhts/h70EuXjdXiiTCWBbddvLBHDvWHPWP
         5jstEL351z4PoMD9ZA8Uji+OHpA3uVr22y9aZYycAt109MAia1vEWlgMcbJTjocyGEo/
         IRSw==
X-Gm-Message-State: AKaTC026fbugbIOsDbYJ7Nh6TSvbkWdGe4JuRgSWs/yEo8TiQ06UYWM3mEp1qziO+bDayCKC
X-Received: by 10.99.5.21 with SMTP id 21mr124508692pgf.32.1481144521851;
        Wed, 07 Dec 2016 13:02:01 -0800 (PST)
Received: from localhost ([2620:0:1000:5b10:2441:4f9a:ad0f:a8d7])
        by smtp.gmail.com with ESMTPSA id 64sm44734903pfu.17.2016.12.07.13.02.00
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Wed, 07 Dec 2016 13:02:00 -0800 (PST)
From:   Stefan Beller <sbeller@google.com>
To:     bmwill@google.com
Cc:     git@vger.kernel.org, pclouds@gmail.com, gitster@pobox.com,
        Stefan Beller <sbeller@google.com>
Subject: [PATCHv5 1/5] submodule: use absolute path for computing relative path connecting
Date:   Wed,  7 Dec 2016 13:01:53 -0800
Message-Id: <20161207210157.18932-2-sbeller@google.com>
X-Mailer: git-send-email 2.11.0.rc2.28.g2af45f1.dirty
In-Reply-To: <20161207210157.18932-1-sbeller@google.com>
References: <20161207210157.18932-1-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The current caller of connect_work_tree_and_git_dir passes
an absolute path for the `git_dir` parameter. In the future patch
we will also pass in relative path for `git_dir`. Extend the functionality
of connect_work_tree_and_git_dir to take relative paths for parameters.

We could work around this in the future patch by computing the absolute
path for the git_dir in the calling site, however accepting relative
paths for either parameter makes the API for this function much harder
to misuse.

Signed-off-by: Stefan Beller <sbeller@google.com>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 submodule.c | 12 +++++++-----
 1 file changed, 7 insertions(+), 5 deletions(-)

diff --git a/submodule.c b/submodule.c
index 6f7d883de9..66c5ce5a24 100644
--- a/submodule.c
+++ b/submodule.c
@@ -1227,23 +1227,25 @@ void connect_work_tree_and_git_dir(const char *work_tree, const char *git_dir)
 {
 	struct strbuf file_name = STRBUF_INIT;
 	struct strbuf rel_path = STRBUF_INIT;
-	const char *real_work_tree = xstrdup(real_path(work_tree));
+	char *real_git_dir = xstrdup(real_path(git_dir));
+	char *real_work_tree = xstrdup(real_path(work_tree));
 
 	/* Update gitfile */
 	strbuf_addf(&file_name, "%s/.git", work_tree);
 	write_file(file_name.buf, "gitdir: %s",
-		   relative_path(git_dir, real_work_tree, &rel_path));
+		   relative_path(real_git_dir, real_work_tree, &rel_path));
 
 	/* Update core.worktree setting */
 	strbuf_reset(&file_name);
-	strbuf_addf(&file_name, "%s/config", git_dir);
+	strbuf_addf(&file_name, "%s/config", real_git_dir);
 	git_config_set_in_file(file_name.buf, "core.worktree",
-			       relative_path(real_work_tree, git_dir,
+			       relative_path(real_work_tree, real_git_dir,
 					     &rel_path));
 
 	strbuf_release(&file_name);
 	strbuf_release(&rel_path);
-	free((void *)real_work_tree);
+	free(real_work_tree);
+	free(real_git_dir);
 }
 
 int parallel_submodules(void)
-- 
2.11.0.rc2.28.g2af45f1.dirty

