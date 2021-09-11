Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D66A5C433F5
	for <git@archiver.kernel.org>; Sat, 11 Sep 2021 19:10:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BE78A6108B
	for <git@archiver.kernel.org>; Sat, 11 Sep 2021 19:10:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233912AbhIKTL6 (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 11 Sep 2021 15:11:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40528 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233842AbhIKTLp (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 11 Sep 2021 15:11:45 -0400
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E5E5BC061756
        for <git@vger.kernel.org>; Sat, 11 Sep 2021 12:10:32 -0700 (PDT)
Received: by mail-wr1-x435.google.com with SMTP id w29so7056452wra.8
        for <git@vger.kernel.org>; Sat, 11 Sep 2021 12:10:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=syAJmUhreFzopqoYJhQcfitV/eI2y5YCAhJluEEmw7Y=;
        b=WAixBUP3ua8uJAXlHB2z6pU2N88ck1HYqZuCi0cDNhUPkW2tSUQmS2oC8Z1n/HW12q
         VTR5T0bs44nT8Gp5vIGqsF1cFBYlJ5+M5b0NShxD5Z9hI1u88GUv9ggAHuk93lPQK6B7
         BiDnzz0ZgV1XUMDgrmuviXfuUbI+O48mI+GG4Ld9/A2CXaLCWZ33hlUWws11i58y1Wn/
         9ctS1jNhCRWa1D9Wo1GAa8ykXHlzAFGAd6TfxQ20uWHySrO+UIirkayiusRs6ZAKwWl7
         hgYnZQ46urMnnDm0kfrnPDANhbIEL+KPHSWomonUCw7oQ2qZYwDu0mWHyw0lq1VFFh5D
         R7IA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=syAJmUhreFzopqoYJhQcfitV/eI2y5YCAhJluEEmw7Y=;
        b=XcZRI0Y/4duh+Rikar/ZyD3hbiBvIVS1ppVeIWIFES8Wwcd7i/zRJ0rSwyptJxliw3
         Wl9JWykqbFFubR/QILc5VPTR+o6WeWjC/yf3juxVOkHkc9qZM/VtvES1ckWpY5G+pGu7
         OV3GJFps2dF40hRa8vx1UiNMy+GPGDVpVeM80OJAIykDkqa9p1YmSZgQriIbcVcyJPTO
         w3oypgiOxOhS0EQfV3/YN+9qvoJMPEI2ruJlqGEXVZdUBpjX+WMmhI3+Pnbgc8392Q/3
         SsB4pHx9cSMSGEk8daKr8RC4J5Vd3wWvNLJN8S8h4A9KU5Hatv2jNAO0YUYz+HpoBxki
         SfWA==
X-Gm-Message-State: AOAM531jHwODskCtdVPpheyVwEuuwYV0JVGDZR3BSv+62+WPVpggVSkS
        EDt0wjngA6Oo7bVOS1gcJiLDHCRs5lm+kQ==
X-Google-Smtp-Source: ABdhPJyxvHtxkTdKRu28Qqeagm1k4ea7nsdLA7OvCctK1FFM+ts1alHqhU60ydmJWbm2JmLEqSiXQQ==
X-Received: by 2002:adf:fcca:: with SMTP id f10mr4340568wrs.304.1631387430888;
        Sat, 11 Sep 2021 12:10:30 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id g1sm2256822wmk.2.2021.09.11.12.10.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 11 Sep 2021 12:10:30 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Carlo Arenas <carenas@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v3 6/6] parse-options: properly align continued usage output
Date:   Sat, 11 Sep 2021 21:09:05 +0200
Message-Id: <patch-v3-6.6-0df2840ce4e-20210911T190239Z-avarab@gmail.com>
X-Mailer: git-send-email 2.33.0.995.ga5ea46173a2
In-Reply-To: <cover-v3-0.6-00000000000-20210911T190239Z-avarab@gmail.com>
References: <cover-v2-0.6-00000000000-20210910T153146Z-avarab@gmail.com> <cover-v3-0.6-00000000000-20210911T190239Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Some commands such as "git stash" emit continued options output with
e.g. "git stash -h", because usage_with_options_internal() prefixes
with its own whitespace the resulting output wasn't properly
aligned. Let's account for the added whitespace, which properly aligns
the output.

The "git stash" command has usage output with a N_() translation that
legitimately stretches across multiple lines;

	N_("git stash [push [-p|--patch] [-k|--[no-]keep-index] [-q|--quiet]\n"
	   "          [-u|--include-untracked] [-a|--all] [-m|--message <message>]\n"
           [...]

We'd like to have that output aligned with the length of the initial
"git stash " output, but since usage_with_options_internal() adds its
own whitespace prefixing we fell short, before this change we'd emit:

    $ git stash -h
    usage: git stash list [<options>]
       or: git stash show [<options>] [<stash>]
       [...]
       or: git stash [push [-p|--patch] [-k|--[no-]keep-index] [-q|--quiet]
              [-u|--include-untracked] [-a|--all] [-m|--message <message>]
              [...]

Now we'll properly emit aligned output.  I.e. the last four lines
above will instead be (a whitespace-only change to the above):

       [...]
       or: git stash [push [-p|--patch] [-k|--[no-]keep-index] [-q|--quiet]
                     [-u|--include-untracked] [-a|--all] [-m|--message <message>]
                     [...]

We could also go for an approach where we have the caller support no
padding of their own, i.e. (same as the first example, except for the
padding on the second line):

	N_("git stash [push [-p|--patch] [-k|--[no-]keep-index] [-q|--quiet]\n"
	   "[-u|--include-untracked] [-a|--all] [-m|--message <message>]\n"
           [...]

But to do that we'll need to find the length of "git stash". We can
discover that from the "cmd" in the "struct cmd_struct", but there
might cases with sub-commands or "git" itself taking arguments that
would make that non-trivial.

Even if it was I still think this approach is better, because this way
we'll get the same legible alignment in the C code. The fact that
usage_with_options_internal() is adding its own prefix padding is an
implementation detail that callers shouldn't need to worry about.

Implementation notes:

We could skip the string_list_split() with a strchr(str, '\n') check,
but we'd then need to duplicate our state machine for strings that do
and don't contain a "\n". It's simpler to just always split into a
"struct string_list", even though the common case is that that "struct
string_list" will contain only one element. This is not
performance-sensitive code.

This change is relatively more complex since I've accounted for making
it future-proof for RTL translation support. Later in
usage_with_options_internal() we have some existing padding code
dating back to d7a38c54a6c (parse-options: be able to generate usages
automatically, 2007-10-15) which isn't RTL-safe, but that code would
be easy to fix. Let's not introduce new RTL translation problems here.

I'm also adding a check to catch the mistake of needlessly adding a
trailing "\n", such as:

	N_("git stash save [-p|--patch] [-k|--[no-]keep-index] [-q|--quiet]\n"
	   "          [-u|--include-untracked] [-a|--all] [<message>]\n"),

Or even a mistake like adding just one "\n" in a string with no other
newlines:

	N_("git stash list [<options>]\n"),

This catches the cases already tested for in cmd_parseopt(), but this
covers the purely C API. As noted a preceding commit that added the
die() to cmd_parseopt() I'm fairly confident that this will be
triggered by no in-tree user I've missed.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 parse-options.c | 65 ++++++++++++++++++++++++++++++++++++++++++++-----
 1 file changed, 59 insertions(+), 6 deletions(-)

diff --git a/parse-options.c b/parse-options.c
index 950a8279beb..ff28869d2c9 100644
--- a/parse-options.c
+++ b/parse-options.c
@@ -917,19 +917,72 @@ static int usage_with_options_internal(struct parse_opt_ctx_t *ctx,
 	FILE *outfile = err ? stderr : stdout;
 	int need_newline;
 
+	const char *usage_prefix = _("usage: %s");
+	/*
+	 * The translation could be anything, but we can count on
+	 * msgfmt(1)'s --check option to have asserted that "%s" is in
+	 * the translation. So compute the length of the "usage: "
+	 * part. We are assuming that the translator wasn't overly
+	 * clever and used e.g. "%1$s" instead of "%s", there's only
+	 * one "%s" in "usage_prefix" above, so there's no reason to
+	 * do so even with a RTL language.
+	 */
+	size_t usage_len = strlen(usage_prefix) - strlen("%s");
+	/*
+	 * TRANSLATORS: the colon here should align with the
+	 * one in "usage: %s" translation.
+	 */
+	const char *or_prefix = _("   or: %s");
+
+	/*
+	 * TRANSLATORS: You should only need to translate this format
+	 * string if your language is a RTL language (e.g. Arabic,
+	 * Hebrew etc.), not if it's a LTR language (e.g. German,
+	 * Russian, Chinese etc.).
+	 *
+	 * When a translated usage string has an embedded "\n" it's
+	 * because options have wrapped to the next line. The line
+	 * after the "\n" will then be padded to align with the
+	 * command name, such as N_("git cmd [opt]\n<8
+	 * spaces>[opt2]"), where the 8 spaces are the same length as
+	 * "git cmd ".
+	 *
+	 * This format string prints out that already-translated
+	 * line. The "%*s" is whitespace padding to account for the
+	 * padding at the start of the line that we add in this
+	 * function. The "%s" is a line in the (hopefully already
+	 * translated) N_() usage string, which contained embedded
+	 * newlines before we split it up.
+	 */
+	const char *usage_continued = _("%*s%s");
+	const char *prefix = usage_prefix;
+
 	if (!usagestr)
 		return PARSE_OPT_HELP;
 
 	if (!err && ctx && ctx->flags & PARSE_OPT_SHELL_EVAL)
 		fprintf(outfile, "cat <<\\EOF\n");
 
-	fprintf_ln(outfile, _("usage: %s"), _(*usagestr++));
 	while (*usagestr) {
-		/*
-		 * TRANSLATORS: the colon here should align with the
-		 * one in "usage: %s" translation.
-		 */
-		fprintf_ln(outfile, _("   or: %s"), _(*usagestr++));
+		struct string_list list = STRING_LIST_INIT_DUP;
+		unsigned int j;
+
+		string_list_split(&list, _(*usagestr++), '\n', -1);
+		for (j = 0; j < list.nr; j++) {
+			const char *line = list.items[j].string;
+
+			if (!*line)
+				BUG("empty or trailing line in usage string");
+
+			if (!j)
+				fprintf_ln(outfile, prefix, line);
+			else
+				fprintf_ln(outfile, usage_continued,
+					   (int)usage_len, "", line);
+		}
+		string_list_clear(&list, 0);
+
+		prefix = or_prefix;
 	}
 
 	need_newline = 1;
-- 
2.33.0.995.ga5ea46173a2

