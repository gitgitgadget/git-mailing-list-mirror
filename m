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
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF4E2C43381
	for <git@archiver.kernel.org>; Sun, 14 Mar 2021 18:48:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 993B464EB0
	for <git@archiver.kernel.org>; Sun, 14 Mar 2021 18:48:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234074AbhCNSsT (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 14 Mar 2021 14:48:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52100 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233999AbhCNSrt (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 14 Mar 2021 14:47:49 -0400
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F0011C061763
        for <git@vger.kernel.org>; Sun, 14 Mar 2021 11:47:48 -0700 (PDT)
Received: by mail-wr1-x42f.google.com with SMTP id d15so7582877wrv.5
        for <git@vger.kernel.org>; Sun, 14 Mar 2021 11:47:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=BNKBPmb66bTJusaZWafccerzc6ppVtY4RFdJpsrvV+o=;
        b=Uk7x4FJcE18xNHGM93Z1bmynGAgq7SzD+9Q6FNB+XFFFk7zH6oOK9089ICCxBEaoPU
         rBiefrf4RW0SXFF7bNYcvwS1uSKwCdNRmnyuGkhEdPk3J+rpU+z7rh8YtFhbBVJsofJJ
         BuFeJCwi4hSx7rT37kHJAXiLpuJQMLXwuIrZ/jmOH3kiK50JKR3svVZgmNThYr1YXzp6
         aKLZpNsNbggxcINFr8A5GFdhtchbep/1keyDRY/mqy5Keqnabrw1Rz2j9brU6xxyzpIq
         5Y6zdjAOgjxq6m/7TnUFSmekUs+GMM8R6kV5BEk2OznsCvM5Ve7qOjgsduxvA2u3CkTr
         0rIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=BNKBPmb66bTJusaZWafccerzc6ppVtY4RFdJpsrvV+o=;
        b=cbRSuMXH0/Eeq7cWAPF0pehUWRTq/lVl4WAoZnEZrRnQD7C9Wyc7J+/cL4IeTBT0PL
         76FUcr+aHVZcLNDjw1dxC29XAmugeXkeXo7XGTC+aw716N6X8W6TI0K/87IGfe0rchiN
         f20JWoY8OeroQu6CYOFZRGLZqkwbjptkN5CRbXDK59U+hYLy5t/mo/g7Bj5BpCAdIY52
         l8oAohZ7qUn3542fLQyDqO4DQC3qJbH/6v7ypRXAOttwnWdwccWGbwpumXBLQt0x+58H
         1PK9xU8lY24AHmdweyFzj3c6li0M79AQjfDizyAuv6iEEsmAJM5GpV0S67uNIHsBfn1/
         qr2g==
X-Gm-Message-State: AOAM533kLNwHHabI0q/+lEGX/N5r7RlFOhAVUGSzmtmBi1ezchFylrST
        g9xgoIcpoPXhIE3YPK/g8TRJKUGTbug=
X-Google-Smtp-Source: ABdhPJxlcA3Ini37tdq53PV1alBlvWtGG1t5oT59J9g//+KsWqS7mMYg8Pe6qO/5FdGkf/NxudHzhQ==
X-Received: by 2002:adf:e582:: with SMTP id l2mr24132488wrm.207.1615747667774;
        Sun, 14 Mar 2021 11:47:47 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id d85sm10025107wmd.15.2021.03.14.11.47.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 14 Mar 2021 11:47:47 -0700 (PDT)
Message-Id: <4397c1fd80205d142fbd184c6d13fd07c4dbfa21.1615747662.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.899.v2.git.1615747662.gitgitgadget@gmail.com>
References: <pull.899.git.1615228580.gitgitgadget@gmail.com>
        <pull.899.v2.git.1615747662.gitgitgadget@gmail.com>
From:   "Andrzej Hunt via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Sun, 14 Mar 2021 18:47:41 +0000
Subject: [PATCH v2 8/9] parse-options: don't leak alias help messages
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

fold
---
 parse-options.c | 20 +++++++++++++++++++-
 parse-options.h |  1 +
 2 files changed, 20 insertions(+), 1 deletion(-)

diff --git a/parse-options.c b/parse-options.c
index fbea16eaf5c2..6c7f927240b6 100644
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
 
@@ -693,6 +696,21 @@ static struct option *preprocess_options(struct parse_opt_ctx_t *ctx,
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
+		if (options[i].flags & PARSE_OPT_FROM_ALIAS) {
+			free((void *)options[i].help);
+		}
+	}
+	free(options);
+}
+
 static int usage_with_options_internal(struct parse_opt_ctx_t *,
 				       const char * const *,
 				       const struct option *, int, int);
@@ -870,7 +888,7 @@ int parse_options(int argc, const char **argv, const char *prefix,
 	}
 
 	precompose_argv_prefix(argc, argv, NULL);
-	free(real_options);
+	free_preprocessed_options(real_options);
 	free(ctx.alias_groups);
 	return parse_options_end(&ctx);
 }
diff --git a/parse-options.h b/parse-options.h
index 36ce0a44b2e9..331c6c67812c 100644
--- a/parse-options.h
+++ b/parse-options.h
@@ -48,6 +48,7 @@ enum parse_opt_option_flags {
 	PARSE_OPT_NOCOMPLETE = 1 << 8,
 	PARSE_OPT_COMP_ARG = 1 << 9,
 	PARSE_OPT_CMDMODE = 1 << 10,
+	PARSE_OPT_FROM_ALIAS = 1 << 11,
 };
 
 enum parse_opt_result {
-- 
gitgitgadget

