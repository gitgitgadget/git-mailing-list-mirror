Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8AD35C433EF
	for <git@archiver.kernel.org>; Sun, 20 Feb 2022 17:54:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244306AbiBTRzD (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 20 Feb 2022 12:55:03 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:35210 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240203AbiBTRy4 (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 20 Feb 2022 12:54:56 -0500
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 363F94D9EA
        for <git@vger.kernel.org>; Sun, 20 Feb 2022 09:54:34 -0800 (PST)
Received: by mail-wr1-x42b.google.com with SMTP id p9so23231701wra.12
        for <git@vger.kernel.org>; Sun, 20 Feb 2022 09:54:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=IEwQOKVfS1z3z4RURBKjrMl0ojCq6mcDnKEPehPFfRg=;
        b=MrmvVl9EhyxSZ/1a0LmbZKpmhGmym2rspTwVOGC0z0son8WsK0oNWhVrqLeREObncU
         DT8qbnpPIHuX8CHUzVPWBQ8otQM2W0drCjKAS0hIfK7Nb9Hi3d3sdjQDrdlbEMpvhiEY
         9wJ3xO0gjigSHVQAXwcyL1f5OovCXMUkLZfZV07aUSdm5/h7bFF2pI8R3ISepZlH9xjF
         mDkKvAervxSPu2TZvhaqMMea63VWnlz7vk12d3Y7Znka7cojTuIRYWo5jIdcFDv63LDq
         MnSyV+Q9ICov8mgTwcXogwuXIEphd0zvsx2Bp/p0IZILJKHqqteg6TDi/PG/kTFH4rne
         Oogg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=IEwQOKVfS1z3z4RURBKjrMl0ojCq6mcDnKEPehPFfRg=;
        b=e3Bw0McKrVcMQATPFRnSlrSXOT9Oarur8z6/lyG5dAclTR+lmEPQbHvPgqbXcoH4UI
         NoAG4vrWZBbKUpXvRc/icHwmhyeLDERlDPptMPGuPgb1oMAW2Hf0/vUTCqdsQ+PjoHyk
         ySXvhEWkV9Gi34dKnZQPXp/B0WEyU5DaumirNRu+E5zT7tuJuk3oNJuu1m7kI4FlrwFj
         PDHlYu48wsbajzYPWTkKmeN9pmxZ/RPhi1B7/1hg9/y7nmgkHYchABhWFkqduIEx5tpA
         QAjeNgCkKf5u63beCSGwKTRSLS3fSesvtPJP2v0H93r+SWl6dyZLSn07/Kx7ngH2s/hG
         4gDQ==
X-Gm-Message-State: AOAM531r2akwPjRCNu8Sm7IJK+1vdzr22bcog6W0lWBWoGN9xljG5zue
        a7MonEGz2Bk+VmDKaoKyT44NzBHXVXc=
X-Google-Smtp-Source: ABdhPJwSUVJznPWgmPb+RUjdcrX+f4205hlkM1Cf7Q83rPl/7B/N9m+YlSo+b+BhA+QN53A8PltIqQ==
X-Received: by 2002:adf:ee8f:0:b0:1e4:a642:5c0 with SMTP id b15-20020adfee8f000000b001e4a64205c0mr12605718wro.146.1645379672628;
        Sun, 20 Feb 2022 09:54:32 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id t1sm57534336wre.45.2022.02.20.09.54.31
        for <git@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 20 Feb 2022 09:54:32 -0800 (PST)
Message-Id: <1e62e4e4fa1a543ad134d70d97740cac5826e587.1645379667.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1154.git.1645379667.gitgitgadget@gmail.com>
References: <pull.1154.git.1645379667.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Sun, 20 Feb 2022 17:54:20 +0000
Subject: [PATCH 04/11] worktree: extract checkout_worktree()
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     "mailto:sunshine@sunshineco.com" 
        <[sunshine@sunshineco.com]@vger.kernel.org>,
        "mailto:gitster@pobox.com" <[gitster@pobox.com]@vger.kernel.org>,
        "Elijah Newren [ ]" <newren@gmail.com>,
        "=?UTF-8?Q?Jean-No=C3=ABl?= AVILA [ ]" <jn.avila@free.fr>,
        Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee <derrickstolee@github.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Derrick Stolee <derrickstolee@github.com>

The ability to add the --no-checkout flag to 'git worktree' was added in
ef2a0ac9a0 (worktree: add: introduce --checkout option, 2016-03-29).
Recently, we noticed that add_worktree() is rather complicated, so
extract the logic for this checkout process to simplify the method.

Signed-off-by: Derrick Stolee <derrickstolee@github.com>
---
 builtin/worktree.c | 26 +++++++++++++++-----------
 1 file changed, 15 insertions(+), 11 deletions(-)

diff --git a/builtin/worktree.c b/builtin/worktree.c
index c806aa2b261..25807e63a25 100644
--- a/builtin/worktree.c
+++ b/builtin/worktree.c
@@ -292,6 +292,18 @@ worktree_copy_cleanup:
 	free(to_file);
 }
 
+static int checkout_worktree(const struct add_opts *opts,
+			     struct strvec *child_env)
+{
+	struct child_process cp = CHILD_PROCESS_INIT;
+	cp.git_cmd = 1;
+	strvec_pushl(&cp.args, "reset", "--hard", "--no-recurse-submodules", NULL);
+	if (opts->quiet)
+		strvec_push(&cp.args, "--quiet");
+	strvec_pushv(&cp.env_array, child_env->v);
+	return run_command(&cp);
+}
+
 static int add_worktree(const char *path, const char *refname,
 			const struct add_opts *opts)
 {
@@ -425,17 +437,9 @@ static int add_worktree(const char *path, const char *refname,
 	if (ret)
 		goto done;
 
-	if (opts->checkout) {
-		struct child_process cp = CHILD_PROCESS_INIT;
-		cp.git_cmd = 1;
-		strvec_pushl(&cp.args, "reset", "--hard", "--no-recurse-submodules", NULL);
-		if (opts->quiet)
-			strvec_push(&cp.args, "--quiet");
-		strvec_pushv(&cp.env_array, child_env.v);
-		ret = run_command(&cp);
-		if (ret)
-			goto done;
-	}
+	if (opts->checkout &&
+	    (ret = checkout_worktree(opts, &child_env)))
+		goto done;
 
 	is_junk = 0;
 	FREE_AND_NULL(junk_work_tree);
-- 
gitgitgadget

