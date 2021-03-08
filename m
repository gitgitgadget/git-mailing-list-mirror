Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2504CC432C3
	for <git@archiver.kernel.org>; Mon,  8 Mar 2021 18:37:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 100A965202
	for <git@archiver.kernel.org>; Mon,  8 Mar 2021 18:37:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231148AbhCHSgc (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 8 Mar 2021 13:36:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54168 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230429AbhCHSg0 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 8 Mar 2021 13:36:26 -0500
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B9A9C06174A
        for <git@vger.kernel.org>; Mon,  8 Mar 2021 10:36:26 -0800 (PST)
Received: by mail-wm1-x332.google.com with SMTP id 124-20020a1c00820000b029010b871409cfso4405663wma.4
        for <git@vger.kernel.org>; Mon, 08 Mar 2021 10:36:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=wGG4egWIxxqcq3y4zt/9zTlxYxwt8ggAUlD96Vterb4=;
        b=pRgPyvreCD+S1dpqMSrer6+RqSPZeqcOjDlvWbq4tZfmxf3fAEYYr0dQECzOhuJwZn
         +4I+BIavlOo53YYQSrZUk9w1YmoqYK4xObY1xEpAn5tuTZnMo+N67eNZIHGs67s2xlvU
         JejMf3zBBt1xWePaxh1O/LjpsmDNoW7w0XPXtLihPO0q7Fj+iu7G6twhUydbm7nMlM8J
         sWzRPicECNCmj7hk7cCHFNiF+BuIVE1nF0DH8KeiKYCxnOnn7LwleoJVXaSDB/2VJGRA
         UYiPtLmQXWhQ7FrG3fHCv/PC3pBqmPyK5xoFsOQ/NsGNvMnAm0yLBRUjZNgr0jaVEoXR
         HjXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=wGG4egWIxxqcq3y4zt/9zTlxYxwt8ggAUlD96Vterb4=;
        b=ioN4mpr8jyFqCMStv53OPfyOjbi3PWm5ic+l95gR9cPZvXV90WLRWD0jrQ1S36rwhR
         LbpPV7HjWnatyNwBtavHuseDMQUyEpiKw2lSBmnruAvqAEEoVVx2GEio4vo9USZ6K24S
         3FVIpSgLTAtX9dtJmgiv4fPGl0JeXb4qmdLrVpMeLi01J8UK40lcVhL6iMU0zoD6zxRA
         fEFT06BNQb+QIJYb2K6+76xsnaCLp6iwgJcesP+G/XkBDAvEmF3DOcdvkQu3b0hc5152
         Gj8Kke8LIitl9KpFqv6p8w7vc7yW01wkTWOuOguYVpzo6Dtuvw0s26R8D/Lqrg8aDlcF
         Nv2Q==
X-Gm-Message-State: AOAM533VOeo46DJ4wTXupLMQPLAekQtEhVQzxz6cllKp6u0QVNBFRuNj
        TMyFVcf1fcazCf0zL8DIrgau6o1qnyM=
X-Google-Smtp-Source: ABdhPJz53qhmdX4xAvjTkP4J95n4HK6QZwhut3qQS1fPKZehUaz+fRjobywY0qGoOPSdRzhrxSjXUQ==
X-Received: by 2002:a7b:c842:: with SMTP id c2mr157242wml.100.1615228585337;
        Mon, 08 Mar 2021 10:36:25 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id h62sm229423wmf.37.2021.03.08.10.36.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Mar 2021 10:36:25 -0800 (PST)
Message-Id: <fb456bee0f69e0ca5e596b30705c42cc037edecc.1615228580.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.899.git.1615228580.gitgitgadget@gmail.com>
References: <pull.899.git.1615228580.gitgitgadget@gmail.com>
From:   "Andrzej Hunt via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 08 Mar 2021 18:36:20 +0000
Subject: [PATCH 7/7] parse-options: don't leak alias help messages
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Andrzej Hunt <andrzej@ahunt.org>, Andrzej Hunt <ajrhunt@google.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Andrzej Hunt <ajrhunt@google.com>

preprocess_options() allocates new strings for help messages for
OPTION_ALIAS. Therefore we also need to clean those help messages up
when freeing the returned options.

First introduced in:
  7c280589cf (parse-options: teach "git cmd -h" to show alias as alias, 2020-03-16)

The preprocessed options themselves no longer contain any indication
that a given option is/was an alias: the easiest and fastest way to
figure it out is to look back at the original options. Alternatively we
could iterate over the alias_groups list - but that would require nested
looping and is likely to be a (little) less efficient.

As far as I can tell, parse_options() is only ever used once per
command, and the help messages are small - hence this leak has very
little impact.

This leak was found while running t0001. LSAN output can be found below:

Direct leak of 65 byte(s) in 1 object(s) allocated from:
    #0 0x49a859 in realloc /home/abuild/rpmbuild/BUILD/llvm-11.0.0.src/build/../projects/compiler-rt/lib/asan/asan_malloc_linux.cpp:164:3
    #1 0x9aae36 in xrealloc /home/ahunt/oss-fuzz/git/wrapper.c:126:8
    #2 0x939d8d in strbuf_grow /home/ahunt/oss-fuzz/git/strbuf.c:98:2
    #3 0x93b936 in strbuf_vaddf /home/ahunt/oss-fuzz/git/strbuf.c:392:3
    #4 0x93b7ff in strbuf_addf /home/ahunt/oss-fuzz/git/strbuf.c:333:2
    #5 0x86747e in preprocess_options /home/ahunt/oss-fuzz/git/parse-options.c:666:3
    #6 0x866ed2 in parse_options /home/ahunt/oss-fuzz/git/parse-options.c:847:17
    #7 0x51c4a7 in cmd_clone /home/ahunt/oss-fuzz/git/builtin/clone.c:989:9
    #8 0x4cd60d in run_builtin /home/ahunt/oss-fuzz/git/git.c:453:11
    #9 0x4cb2da in handle_builtin /home/ahunt/oss-fuzz/git/git.c:704:3
    #10 0x4ccc37 in run_argv /home/ahunt/oss-fuzz/git/git.c:771:4
    #11 0x4cac29 in cmd_main /home/ahunt/oss-fuzz/git/git.c:902:19
    #12 0x69c9fe in main /home/ahunt/oss-fuzz/git/common-main.c:52:11
    #13 0x7fdac42d4349 in __libc_start_main (/lib64/libc.so.6+0x24349)

Signed-off-by: Andrzej Hunt <ajrhunt@google.com>
---
 parse-options.c | 29 ++++++++++++++++++++++++-----
 1 file changed, 24 insertions(+), 5 deletions(-)

diff --git a/parse-options.c b/parse-options.c
index fbea16eaf5c2..3fe1dacc08cb 100644
--- a/parse-options.c
+++ b/parse-options.c
@@ -625,6 +625,8 @@ static int show_gitcomp(const struct option *opts, int show_all)
  *
  * Right now this is only used to preprocess and substitute
  * OPTION_ALIAS.
+ *
+ * The returned options should be freed using free_preprocessed_options.
  */
 static struct option *preprocess_options(struct parse_opt_ctx_t *ctx,
 					 const struct option *options)
@@ -693,6 +695,21 @@ static struct option *preprocess_options(struct parse_opt_ctx_t *ctx,
 	return newopt;
 }
 
+static void free_preprocessed_options(const struct option ** preprocessed_options, const struct option *original_options)
+{
+	int i;
+
+	if (!*preprocessed_options) {
+		return;
+	}
+	for (i = 0; original_options[i].type != OPTION_END; i++) {
+		if (original_options[i].type == OPTION_ALIAS) {
+			free((void *)(*preprocessed_options)[i].help);
+		}
+	}
+	free((void *)*preprocessed_options);
+}
+
 static int usage_with_options_internal(struct parse_opt_ctx_t *,
 				       const char * const *,
 				       const struct option *, int, int);
@@ -838,15 +855,17 @@ int parse_options(int argc, const char **argv, const char *prefix,
 		  int flags)
 {
 	struct parse_opt_ctx_t ctx;
-	struct option *real_options;
+	const struct option *preprocessed_options, *original_options = NULL;
 
 	disallow_abbreviated_options =
 		git_env_bool("GIT_TEST_DISALLOW_ABBREVIATED_OPTIONS", 0);
 
 	memset(&ctx, 0, sizeof(ctx));
-	real_options = preprocess_options(&ctx, options);
-	if (real_options)
-		options = real_options;
+	preprocessed_options = preprocess_options(&ctx, options);
+	if (preprocessed_options) {
+		original_options = options;
+		options = preprocessed_options;
+	}
 	parse_options_start_1(&ctx, argc, argv, prefix, options, flags);
 	switch (parse_options_step(&ctx, options, usagestr)) {
 	case PARSE_OPT_HELP:
@@ -870,7 +889,7 @@ int parse_options(int argc, const char **argv, const char *prefix,
 	}
 
 	precompose_argv_prefix(argc, argv, NULL);
-	free(real_options);
+	free_preprocessed_options(&preprocessed_options, original_options);
 	free(ctx.alias_groups);
 	return parse_options_end(&ctx);
 }
-- 
gitgitgadget
