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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64785C433E5
	for <git@archiver.kernel.org>; Sun, 21 Mar 2021 16:59:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 391266195F
	for <git@archiver.kernel.org>; Sun, 21 Mar 2021 16:59:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230150AbhCUQ7R (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 21 Mar 2021 12:59:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52672 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230094AbhCUQ6o (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 21 Mar 2021 12:58:44 -0400
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 86223C061762
        for <git@vger.kernel.org>; Sun, 21 Mar 2021 09:58:44 -0700 (PDT)
Received: by mail-wr1-x430.google.com with SMTP id o16so14240792wrn.0
        for <git@vger.kernel.org>; Sun, 21 Mar 2021 09:58:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=s3sylX8C/0CkY7T2dJl90yJrHQwgZE3ujpf8j+jlFYk=;
        b=XawBAEl12BMS4rOYDYjw80kgjTmJq9aFjTlDtg8krCjBjXQhSCksZXdQTcoj/8HF9K
         6pJ7X8AJHp5iB1QIF8fJFmOOjD2D39c8JAu0BbdSeeaZ/mbckkVxqCL0YX9T3bgGZiBk
         jpdOKP8vwowiZKRXdIV2QBYZVH59+WbecuqNXPRMNV2IvQiMVijrKXkOxF1H5gt7fSDN
         0veqRJFxNmLf5513AkC4rYds4W8MwVTgSAM6od3KoekVLyvhy5/TF6icQwlDWjpZ0Eq7
         LBI/MqxnM0hiLKGWfmExZZSB4IiTVTr0OwZUnVVzBEIcu8B0OKCO+4f+772FPHPt6hdg
         xsyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=s3sylX8C/0CkY7T2dJl90yJrHQwgZE3ujpf8j+jlFYk=;
        b=Ir/R6ZDWwB46opbm7TDYambYventFJpAQZdKXi/7Mucm40rNLvQSB064HjtQiCTfHz
         wNLb/IvpAQkm27GvrXFMFaUEfIcK4+AEROmZsqM/LyPEceLECq6WrDPdFD4Y4M4G3HaM
         hlf+T8z8KGHz4NGb3AGiB8tB11RDqX5uv6bl+4nviKYfDwt4tX7E1E+rfu0tXj24lmNe
         xK+fdVsdFTp9H1wI3x5zLtQSGxkTLRx5gZqgzg2vqUUR/sdRgu4alCKPGGebdLJOU64s
         EPkF2TsnqPUb6YBJSOwtLxfjVYOdebN7bq6IY73c/jYzgk55FGdpWpuVUxw8zMeaA5Jx
         myNA==
X-Gm-Message-State: AOAM533T3M22VuMAzAFCDbc01wd7rraVQQJa6CU51t0PmoK6pId4x5Pk
        45rHrIFql/sDQYz9mvotaZI/1RmN40U=
X-Google-Smtp-Source: ABdhPJwj0EyRX2fVzv6/6VUMOeaXdKRRG6vZzM70KqBr+oHdQ3BnZ8RcG4RxyObDrihRB3dX/i7HKA==
X-Received: by 2002:a05:6000:124f:: with SMTP id j15mr14341037wrx.263.1616345923389;
        Sun, 21 Mar 2021 09:58:43 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id s83sm14291566wmf.26.2021.03.21.09.58.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 21 Mar 2021 09:58:43 -0700 (PDT)
Message-Id: <6e46cd332023a579ab0b4c682111c085a634dafb.1616345918.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.899.v3.git.1616345918.gitgitgadget@gmail.com>
References: <pull.899.v2.git.1615747662.gitgitgadget@gmail.com>
        <pull.899.v3.git.1616345918.gitgitgadget@gmail.com>
From:   "Andrzej Hunt via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Sun, 21 Mar 2021 16:58:36 +0000
Subject: [PATCH v3 8/9] parse-options: don't leak alias help messages
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Eric Sunshine <sunshine@sunshineco.com>,
        Martin =?UTF-8?Q?=C3=85gren?= <martin.agren@gmail.com>,
        Andrzej Hunt <andrzej@ahunt.org>,
        Andrzej Hunt <ajrhunt@google.com>
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
that a given option is/was an alias - therefore we add a new flag to
indicate former aliases. (An alternative approach would be to look back
at the original options to determine which options are aliases - but
that seems like a fragile approach. Or we could even look at the
alias_groups list - which might be less fragile, but would be slower
as it requires nested looping.)

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
 parse-options.c | 19 ++++++++++++++++++-
 parse-options.h |  1 +
 2 files changed, 19 insertions(+), 1 deletion(-)

diff --git a/parse-options.c b/parse-options.c
index fbea16eaf5c2..e6f56768ca5d 100644
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
@@ -678,6 +680,7 @@ static struct option *preprocess_options(struct parse_opt_ctx_t *ctx,
 			newopt[i].short_name = short_name;
 			newopt[i].long_name = long_name;
 			newopt[i].help = strbuf_detach(&help, NULL);
+			newopt[i].flags |= PARSE_OPT_FROM_ALIAS;
 			break;
 		}
 
@@ -693,6 +696,20 @@ static struct option *preprocess_options(struct parse_opt_ctx_t *ctx,
 	return newopt;
 }
 
+static void free_preprocessed_options(struct option *options)
+{
+	int i;
+
+	if (!options)
+		return;
+
+	for (i = 0; options[i].type != OPTION_END; i++) {
+		if (options[i].flags & PARSE_OPT_FROM_ALIAS)
+			free((void *)options[i].help);
+	}
+	free(options);
+}
+
 static int usage_with_options_internal(struct parse_opt_ctx_t *,
 				       const char * const *,
 				       const struct option *, int, int);
@@ -870,7 +887,7 @@ int parse_options(int argc, const char **argv, const char *prefix,
 	}
 
 	precompose_argv_prefix(argc, argv, NULL);
-	free(real_options);
+	free_preprocessed_options(real_options);
 	free(ctx.alias_groups);
 	return parse_options_end(&ctx);
 }
diff --git a/parse-options.h b/parse-options.h
index f2ddef18f7b0..a845a9d95274 100644
--- a/parse-options.h
+++ b/parse-options.h
@@ -44,6 +44,7 @@ enum parse_opt_option_flags {
 	PARSE_OPT_LASTARG_DEFAULT = 1 << 4,
 	PARSE_OPT_NODASH = 1 << 5,
 	PARSE_OPT_LITERAL_ARGHELP = 1 << 6,
+	PARSE_OPT_FROM_ALIAS = 1 << 7,
 	PARSE_OPT_SHELL_EVAL = 1 << 8,
 	PARSE_OPT_NOCOMPLETE = 1 << 9,
 	PARSE_OPT_COMP_ARG = 1 << 10,
-- 
gitgitgadget

