Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF3E3C433EF
	for <git@archiver.kernel.org>; Sat, 11 Sep 2021 18:21:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 97741611C0
	for <git@archiver.kernel.org>; Sat, 11 Sep 2021 18:21:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233397AbhIKSWc (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 11 Sep 2021 14:22:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58064 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233215AbhIKSWb (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 11 Sep 2021 14:22:31 -0400
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DCDDEC061574
        for <git@vger.kernel.org>; Sat, 11 Sep 2021 11:21:17 -0700 (PDT)
Received: by mail-wr1-x42e.google.com with SMTP id d6so7671786wrc.11
        for <git@vger.kernel.org>; Sat, 11 Sep 2021 11:21:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=sotb76NqJYXJjCuCvLDkpyk54Jg0FWaayjrkPqA3SP8=;
        b=bc1Was7rGyNTZB0I60fL8QvQuwdfua30TY80nt/MQjhZ3gEDNme4CpcR2tteyE+OgQ
         IBi5+4QfrWOaRVwSGSuXl8d1/SPqfgPQWYaVVXIJt2lWSxKFhu+py1dHB5t6/SJzbV74
         ajCKTxLzNXpKJChE8bVFWr0xHH5ZNN5HYAg9L+CyS9TtJNMOp7LKNAF1mPSozEknRIU2
         5/BKFTO9gBFI8qyJUv41WDhkBrmEVxmUpQVEkUYRm+KI9lmmtKom1neY3Nnldr/+Tyym
         inf5MDrFBKKJUh/0cr4yrVLXhHUGkejPALZSEYxI4t7W91xrD7GHKn22mF0TE6GkeGMF
         vKNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=sotb76NqJYXJjCuCvLDkpyk54Jg0FWaayjrkPqA3SP8=;
        b=5CPoQwMb3dM0eKPaywlzhwrStvWajxmy3jKMQcIoi6hQySrYsgxoOT6vKWWgZKSZAo
         y1Cw+NwczgWCa+GUCRHpgIM9ybUiWvOXxlO3hUhJpvHliIhaJ3yJ8SgS0JT8umjx12p5
         gP6/GSol0TbB4kd6MPA+h7W8mG7EPQieJvVH/DKJR3Z9dgiBa8ijxxwnfROK3lCC5ZMP
         oenPu3Bjpjb2rAjHRiDQwX/ZhI4LhktN8dFKQcBRrI5IGXhhcWWtTR1khN8KlQTBDBp3
         xClh+Ztjcw+k9EuLvmJY8A/4Cg+TbxukvDnMUMqaHt29Jsi2YG2Zx7hRDDvi2c78sUSc
         ZfOg==
X-Gm-Message-State: AOAM532u6slW6LhlVIdcKD3esBq94lsLhbFLKV08qwSpcoExzMPqSIb8
        ko22AX/ftlzkdDOaAhG91mqCsdVk+hRDnw==
X-Google-Smtp-Source: ABdhPJyaMRCdtA5kgIIbpXsmAhhhGdsKVbuzTwoWO4+ncKHQfh9g0q3pWDKnqVIl0g8nrpoqtctdvg==
X-Received: by 2002:adf:82a8:: with SMTP id 37mr4188710wrc.409.1631384476230;
        Sat, 11 Sep 2021 11:21:16 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id l10sm2491959wrg.50.2021.09.11.11.21.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 11 Sep 2021 11:21:15 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Jeff King <peff@peff.net>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH 2/2] parse-options API: remove OPTION_ARGUMENT feature
Date:   Sat, 11 Sep 2021 20:21:12 +0200
Message-Id: <patch-2.2-28b43789b11-20210911T182009Z-avarab@gmail.com>
X-Mailer: git-send-email 2.33.0.995.ga5ea46173a2
In-Reply-To: <cover-0.2-00000000000-20210911T182009Z-avarab@gmail.com>
References: <cover-0.2-00000000000-20210911T182009Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

As was noted in 1a85b49b87a (parse-options: make OPT_ARGUMENT() more
useful, 2019-03-14) there's only ever been one user of the
OPT_ARGUMENT(), that user was added in 20de316e334 (difftool: allow
running outside Git worktrees with --no-index, 2019-03-14).

The OPT_ARGUMENT() feature itself was added way back in
580d5bffdea (parse-options: new option type to treat an option-like
parameter as an argument., 2008-03-02), but as discussed in
1a85b49b87a wasn't used until 20de316e334 in 2019.

Now that the preceding commit has migrated this code over to using
"struct strvec" to manage the "args" member of a "struct
child_process", we can just use that directly instead of relying on
OPT_ARGUMENT.

This has a minor change in behavior in that if we'll pass --no-index
we'll now always pass it as the first argument, before we'd pass it in
whatever position the caller did. Preserving this was the real value
of OPT_ARGUMENT(), but as it turns out we didn't need that either. We
can always inject it as the first argument, the other end will parse
it just the same.

Note that we cannot remove the "out" and "cpidx" members of "struct
parse_opt_ctx_t" added in 580d5bffdea, while they were introduced with
OPT_ARGUMENT() we since used them for other things.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 Documentation/technical/api-parse-options.txt |  5 -----
 builtin/difftool.c                            |  4 +++-
 parse-options.c                               | 13 -------------
 parse-options.h                               |  3 ---
 t/helper/test-parse-options.c                 |  1 -
 t/t0040-parse-options.sh                      |  5 -----
 6 files changed, 3 insertions(+), 28 deletions(-)

diff --git a/Documentation/technical/api-parse-options.txt b/Documentation/technical/api-parse-options.txt
index 5a60bbfa7f4..acfd5dc1d8b 100644
--- a/Documentation/technical/api-parse-options.txt
+++ b/Documentation/technical/api-parse-options.txt
@@ -198,11 +198,6 @@ There are some macros to easily define options:
 	The filename will be prefixed by passing the filename along with
 	the prefix argument of `parse_options()` to `prefix_filename()`.
 
-`OPT_ARGUMENT(long, &int_var, description)`::
-	Introduce a long-option argument that will be kept in `argv[]`.
-	If this option was seen, `int_var` will be set to one (except
-	if a `NULL` pointer was passed).
-
 `OPT_NUMBER_CALLBACK(&var, description, func_ptr)`::
 	Recognize numerical options like -123 and feed the integer as
 	if it was an argument to the function given by `func_ptr`.
diff --git a/builtin/difftool.c b/builtin/difftool.c
index e656514bcac..9aa77a91043 100644
--- a/builtin/difftool.c
+++ b/builtin/difftool.c
@@ -714,7 +714,7 @@ int cmd_difftool(int argc, const char **argv, const char *prefix)
 			    "tool returns a non - zero exit code")),
 		OPT_STRING('x', "extcmd", &extcmd, N_("command"),
 			   N_("specify a custom command for viewing diffs")),
-		OPT_ARGUMENT("no-index", &no_index, N_("passed to `diff`")),
+		OPT_BOOL(0, "no-index", &no_index, N_("passed to `diff`")),
 		OPT_END()
 	};
 	struct strvec args = STRVEC_INIT;
@@ -768,6 +768,8 @@ int cmd_difftool(int argc, const char **argv, const char *prefix)
 	 * each file that changed.
 	 */
 	strvec_push(&args, "diff");
+	if (no_index)
+		strvec_push(&args, "--no-index");
 	if (dir_diff)
 		strvec_pushl(&args, "--raw", "--no-abbrev", "-z", NULL);
 	strvec_pushv(&args, argv);
diff --git a/parse-options.c b/parse-options.c
index 2abff136a17..55c5821b08d 100644
--- a/parse-options.c
+++ b/parse-options.c
@@ -310,19 +310,6 @@ static enum parse_opt_result parse_long_opt(
 again:
 		if (!skip_prefix(arg, long_name, &rest))
 			rest = NULL;
-		if (options->type == OPTION_ARGUMENT) {
-			if (!rest)
-				continue;
-			if (*rest == '=')
-				return error(_("%s takes no value"),
-					     optname(options, flags));
-			if (*rest)
-				continue;
-			if (options->value)
-				*(int *)options->value = options->defval;
-			p->out[p->cpidx++] = arg - 2;
-			return PARSE_OPT_DONE;
-		}
 		if (!rest) {
 			/* abbreviated? */
 			if (!(p->flags & PARSE_OPT_KEEP_UNKNOWN) &&
diff --git a/parse-options.h b/parse-options.h
index a845a9d9527..39d90882548 100644
--- a/parse-options.h
+++ b/parse-options.h
@@ -8,7 +8,6 @@
 enum parse_opt_type {
 	/* special types */
 	OPTION_END,
-	OPTION_ARGUMENT,
 	OPTION_GROUP,
 	OPTION_NUMBER,
 	OPTION_ALIAS,
@@ -155,8 +154,6 @@ struct option {
 #define OPT_INTEGER_F(s, l, v, h, f)     { OPTION_INTEGER, (s), (l), (v), N_("n"), (h), (f) }
 
 #define OPT_END()                   { OPTION_END }
-#define OPT_ARGUMENT(l, v, h)       { OPTION_ARGUMENT, 0, (l), (v), NULL, \
-				      (h), PARSE_OPT_NOARG, NULL, 1 }
 #define OPT_GROUP(h)                { OPTION_GROUP, 0, NULL, NULL, NULL, (h) }
 #define OPT_BIT(s, l, v, h, b)      OPT_BIT_F(s, l, v, h, b, 0)
 #define OPT_BITOP(s, l, v, h, set, clear) { OPTION_BITOP, (s), (l), (v), NULL, (h), \
diff --git a/t/helper/test-parse-options.c b/t/helper/test-parse-options.c
index 2051ce57db7..a282b6ff13e 100644
--- a/t/helper/test-parse-options.c
+++ b/t/helper/test-parse-options.c
@@ -134,7 +134,6 @@ int cmd__parse_options(int argc, const char **argv)
 		OPT_NOOP_NOARG(0, "obsolete"),
 		OPT_STRING_LIST(0, "list", &list, "str", "add str to list"),
 		OPT_GROUP("Magic arguments"),
-		OPT_ARGUMENT("quux", NULL, "means --quux"),
 		OPT_NUMBER_CALLBACK(&integer, "set integer to NUM",
 			number_callback),
 		{ OPTION_COUNTUP, '+', NULL, &boolean, NULL, "same as -b",
diff --git a/t/t0040-parse-options.sh b/t/t0040-parse-options.sh
index ad4746d899a..da310ed29b1 100755
--- a/t/t0040-parse-options.sh
+++ b/t/t0040-parse-options.sh
@@ -37,7 +37,6 @@ String options
     --list <str>          add str to list
 
 Magic arguments
-    --quux                means --quux
     -NUM                  set integer to NUM
     +                     same as -b
     --ambiguous           positive ambiguity
@@ -263,10 +262,6 @@ test_expect_success 'detect possible typos' '
 	test_cmp typo.err output.err
 '
 
-test_expect_success 'keep some options as arguments' '
-	test-tool parse-options --expect="arg 00: --quux" --quux
-'
-
 cat >expect <<\EOF
 Callback: "four", 0
 boolean: 5
-- 
2.33.0.995.ga5ea46173a2

