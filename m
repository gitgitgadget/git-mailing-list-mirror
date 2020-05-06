Return-Path: <SRS0=4z2X=6U=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38325C28CBC
	for <git@archiver.kernel.org>; Wed,  6 May 2020 14:03:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 148E020752
	for <git@archiver.kernel.org>; Wed,  6 May 2020 14:03:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Vk6ReyVo"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728701AbgEFODF (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 6 May 2020 10:03:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45974 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728662AbgEFODE (ORCPT
        <rfc822;git@vger.kernel.org>); Wed, 6 May 2020 10:03:04 -0400
Received: from mail-pg1-x542.google.com (mail-pg1-x542.google.com [IPv6:2607:f8b0:4864:20::542])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA545C061A0F
        for <git@vger.kernel.org>; Wed,  6 May 2020 07:03:04 -0700 (PDT)
Received: by mail-pg1-x542.google.com with SMTP id j21so1135642pgb.7
        for <git@vger.kernel.org>; Wed, 06 May 2020 07:03:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=tMx/jrPC20kD0EyLiKM4ahxYU0XxZbvSPvE6gKKGSSA=;
        b=Vk6ReyVogi5Ule9DZGpRI4GsQy3fpKCQcIF5WS3jbSopSq3VkU+tLxLru9R//l2UVl
         k4knYHEL+r4qipsYnFxhti7hnjheFDGO7KKCOgNKvSKFvro4DB6Se6GjPi1Sh3lSHu34
         Hc1Rvo6z8VwvfVKI9SAVPaOS4NPepNOEgaKygn72V6XDuFSRJw9xXzIFFV8kVrd+tuTe
         ehge6twhCc0GvveH9iWkq867Dr1g1YClS+JwXsl8Y9XyzwEABfmvu8e5zvhapl7Nt41O
         bLoCi3dkVsXvT8NSBNFbZoc9U2IaOqsZNZZE/uauu4jD5Jb/RGhgNxlNu/VPrTC1CmUm
         o5Cg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=tMx/jrPC20kD0EyLiKM4ahxYU0XxZbvSPvE6gKKGSSA=;
        b=tFAT2NSo+3tTfYQI2gBfvjHjbO7X/FuyBQgEKRUmy0m33OAzF2zRNrr0HNpneMXgEt
         V9dzoXX6dJ8A+x3pXRKihVeisTO6Ec19SMxZXcltOXx1Ske4u+tpPLIcRX4SGTn3OGFQ
         GW0ZB7SPdwxyiTyeCS34eaSySUPTOTewL+1Mw5+nfHRWI2u//FCUJd/Rcu8cc7KO/L/n
         yCPZx776ykPLLRnvXVDRERSkNm7ZWTLCmdMwZ9H54SNlAShlSfilo65VfYlaHj8rJI3q
         ml08mHdHBbobwI/1zAo9s315N5Yt/EXAN5jpQJA+a+B3NS4Z/aqXUJHC/Eta8sumAJ4Y
         2Anw==
X-Gm-Message-State: AGi0PuYDihrZA1PpODIMKxRpzQFLQdRmNYKNiJQ5+SNrnFIHfquQzVZ4
        08RJgL1NK8ejDf0FnYrUbppfF0UM
X-Google-Smtp-Source: APiQypI29Gud30jujyE+2My5KAap8YDtsn3sIq/BsNFXHOXXq9moWz5gvvT9B8vYYxo9+2XzDUgc1g==
X-Received: by 2002:a62:be16:: with SMTP id l22mr8544095pff.40.1588773783441;
        Wed, 06 May 2020 07:03:03 -0700 (PDT)
Received: from localhost.localdomain ([2409:4064:2013:46e0:6af3:5271:7354:1da4])
        by smtp.gmail.com with ESMTPSA id g1sm4793979pjt.25.2020.05.06.07.02.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 May 2020 07:03:02 -0700 (PDT)
From:   Abhishek Kumar <abhishekkumar8222@gmail.com>
To:     git@vger.kernel.org
Cc:     Pierrick Gaudry <pierrick.gaudry@loria.fr>
Subject: [PATCH] commit: silence git-gc if --quiet is given
Date:   Wed,  6 May 2020 19:31:38 +0530
Message-Id: <20200506140138.650455-1-abhishekkumar8222@gmail.com>
X-Mailer: git-send-email 2.26.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

As reported by Perrick [1], commit does not propagate quiet behavior to
gc if present. While we are at it, convert argv_gc_auto to struct argv_array.

[1]: https://lore.kernel.org/git/20200506094327.GC31637@rillettes/

Reported-by: Pierrick Gaudry <pierrick.gaudry@loria.fr>
Signed-off-by: Abhishek Kumar <abhishekkumar8222@gmail.com>
---
 builtin/commit.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/builtin/commit.c b/builtin/commit.c
index a73de0a4c5..a48e312ebd 100644
--- a/builtin/commit.c
+++ b/builtin/commit.c
@@ -1494,7 +1494,7 @@ static int git_commit_config(const char *k, const char *v, void *cb)
 
 int cmd_commit(int argc, const char **argv, const char *prefix)
 {
-	const char *argv_gc_auto[] = {"gc", "--auto", NULL};
+	struct argv_array argv_gc_auto = ARGV_ARRAY_INIT;
 	static struct wt_status s;
 	static struct option builtin_commit_options[] = {
 		OPT__QUIET(&quiet, N_("suppress summary after successful commit")),
@@ -1703,7 +1703,11 @@ int cmd_commit(int argc, const char **argv, const char *prefix)
 	git_test_write_commit_graph_or_die();
 
 	repo_rerere(the_repository, 0);
-	run_command_v_opt(argv_gc_auto, RUN_GIT_CMD);
+	argv_array_pushl(&argv_gc_auto, "gc", "--auto", NULL);
+	if (quiet)
+		argv_array_push(&argv_gc_auto, "--quiet");
+	run_command_v_opt(argv_gc_auto.argv, RUN_GIT_CMD);
+	argv_array_clear(&argv_gc_auto);
 	run_commit_hook(use_editor, get_index_file(), "post-commit", NULL);
 	if (amend && !no_post_rewrite) {
 		commit_post_rewrite(the_repository, current_head, &oid);
-- 
2.26.0

