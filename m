Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE9E9C433F5
	for <git@archiver.kernel.org>; Fri, 15 Oct 2021 09:44:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9059A61027
	for <git@archiver.kernel.org>; Fri, 15 Oct 2021 09:44:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237641AbhJOJqM (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 15 Oct 2021 05:46:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45866 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237584AbhJOJqC (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 15 Oct 2021 05:46:02 -0400
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E9D20C061764
        for <git@vger.kernel.org>; Fri, 15 Oct 2021 02:43:55 -0700 (PDT)
Received: by mail-wm1-x329.google.com with SMTP id u8-20020a05600c440800b0030d90076dabso1288258wmn.1
        for <git@vger.kernel.org>; Fri, 15 Oct 2021 02:43:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=G9F7pIag5NphUtDtIaT4bySfv1lYIGryL5wJ0TRva3c=;
        b=BjwTwMBzrArAcMT2tZGfn0EkEwQR9TyF8TvMnS3mXC0tNORS0Okz+rE1LQm920ThxT
         CAZAjxxFX7kvt0oH4hccVGfhQekZrUte/AYHbkCfPUWdNXITpFBezbK1sJy3R6BB48d+
         J7bFUmk0TWT1J+ubzM1jqKW4jXzbW8SrUg4I/qcz1sP7oqiUfz5lQZJOAOKeaXfwHXG0
         BfSqtHU33aWUs1omGxvlwhToXA+p1WPnQ+kirGxCKsmZvxVWPvteKcdzuTjO7KTbeNte
         sMz81R/ojfxrrhr0ehHyif/DcV32k7SrlzUbBf2u544TVSfiiE1wEVhUKVbuMSpPcdMi
         1AIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=G9F7pIag5NphUtDtIaT4bySfv1lYIGryL5wJ0TRva3c=;
        b=iCKsWTkOAp1h/kV+JI01c11Y2WwuNoY9JaENgUKRVbOd6NSn1+M3BIxwrDKZHEhzxi
         GaO3J/f18qP4tc2f4G2mJHK4r3Hq7BPB5J76a896mGq7RNMOYi6e16FoyeQ9kk035SBz
         TubEek5H2D9QOGDHqTohU/zdfTXyx3eH8c2JdW6uD8gCPmVNrUJ35QqdrTQzvZJES7hy
         rSpGX4twvJ3UuzPFPOncdJnOI9wj9RKmp+OSDuajJfqb/lnG+lvF0z9SC0SJmmTykHB8
         HhzpzNTiy6U3pRDKL1o54jUD5JpF3U7FJab+In8iIJmAUW4Q2B+1IbxBIpmo7/oaU9LV
         9PKA==
X-Gm-Message-State: AOAM533TDHlW9KHQdeNu4M76SE1m79SPaFjToqA9RzAa88KNdifBR6V2
        Acxtqc2J2BI2hyQkwWa9MkMUu3eLhq3ImQ==
X-Google-Smtp-Source: ABdhPJzKhjMccNFqOjikiVkWzb3kiR8zK34ugqHCYHH0cfQ4Fn2OoTDbSfZDeDqqFg+r9mWTVNbGFg==
X-Received: by 2002:a1c:9dcb:: with SMTP id g194mr25522571wme.174.1634291034288;
        Fri, 15 Oct 2021 02:43:54 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id r4sm5963648wrz.58.2021.10.15.02.43.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Oct 2021 02:43:53 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Phillip Wood <phillip.wood123@gmail.com>,
        =?UTF-8?q?Ren=C3=A9=20Scharfe?= <l.s.r@web.de>,
        Emily Shaffer <emilyshaffer@google.com>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v2 11/13] read-cache: convert post-index-change to use hook.h
Date:   Fri, 15 Oct 2021 11:43:39 +0200
Message-Id: <patch-v2-11.13-58b7689e4af-20211015T093918Z-avarab@gmail.com>
X-Mailer: git-send-email 2.33.1.1338.g20da966911a
In-Reply-To: <cover-v2-00.13-00000000000-20211015T093918Z-avarab@gmail.com>
References: <cover-v2-00.13-00000000000-20211015T093918Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Emily Shaffer <emilyshaffer@google.com>

Move the post-index-change hook away from run-command.h to and over to
the new hook.h library.

This removes the last direct user of "run_hook_ve()" outside of
run-command.c ("run_hook_le()" still uses it). So we can make the
function static now. A subsequent commit will remove this code
entirely when "run_hook_le()" itself goes away.

Signed-off-by: Emily Shaffer <emilyshaffer@google.com>
Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 read-cache.c  | 10 +++++++---
 run-command.c |  2 +-
 run-command.h |  1 -
 3 files changed, 8 insertions(+), 5 deletions(-)

diff --git a/read-cache.c b/read-cache.c
index 9773118d078..84cc3d88196 100644
--- a/read-cache.c
+++ b/read-cache.c
@@ -3087,6 +3087,7 @@ static int do_write_locked_index(struct index_state *istate, struct lock_file *l
 {
 	int ret;
 	int was_full = !istate->sparse_index;
+	struct run_hooks_opt hook_opt = RUN_HOOKS_OPT_INIT;
 
 	ret = convert_to_sparse(istate, 0);
 
@@ -3115,9 +3116,12 @@ static int do_write_locked_index(struct index_state *istate, struct lock_file *l
 	else
 		ret = close_lock_file_gently(lock);
 
-	run_hook_le(NULL, "post-index-change",
-			istate->updated_workdir ? "1" : "0",
-			istate->updated_skipworktree ? "1" : "0", NULL);
+	strvec_pushl(&hook_opt.args,
+		     istate->updated_workdir ? "1" : "0",
+		     istate->updated_skipworktree ? "1" : "0",
+		     NULL);
+	run_hooks_oneshot("post-index-change", &hook_opt);
+
 	istate->updated_workdir = 0;
 	istate->updated_skipworktree = 0;
 
diff --git a/run-command.c b/run-command.c
index 7ef5cc712a9..d92e670c8ed 100644
--- a/run-command.c
+++ b/run-command.c
@@ -1323,7 +1323,7 @@ int async_with_fork(void)
 #endif
 }
 
-int run_hook_ve(const char *const *env, const char *name, va_list args)
+static int run_hook_ve(const char *const *env, const char *name, va_list args)
 {
 	struct child_process hook = CHILD_PROCESS_INIT;
 	const char *p;
diff --git a/run-command.h b/run-command.h
index 49878262584..3fa7454cf8a 100644
--- a/run-command.h
+++ b/run-command.h
@@ -239,7 +239,6 @@ int run_command(struct child_process *);
  */
 LAST_ARG_MUST_BE_NULL
 int run_hook_le(const char *const *env, const char *name, ...);
-int run_hook_ve(const char *const *env, const char *name, va_list args);
 
 /*
  * Trigger an auto-gc
-- 
2.33.1.1338.g20da966911a

