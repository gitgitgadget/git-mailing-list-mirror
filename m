Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 506C0C433EF
	for <git@archiver.kernel.org>; Tue, 21 Sep 2021 13:30:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2A1486115B
	for <git@archiver.kernel.org>; Tue, 21 Sep 2021 13:30:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233055AbhIUNb7 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 21 Sep 2021 09:31:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50522 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232953AbhIUNbv (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 21 Sep 2021 09:31:51 -0400
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1B7FC061574
        for <git@vger.kernel.org>; Tue, 21 Sep 2021 06:30:22 -0700 (PDT)
Received: by mail-wr1-x42e.google.com with SMTP id q26so39154829wrc.7
        for <git@vger.kernel.org>; Tue, 21 Sep 2021 06:30:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=IBd5PU15YHAHVdHf62x54aa16G3NCIhGQ2tbmtxgXqc=;
        b=Ydb3jiOwbo9+Brary8AmBCM1GLNhbmu+SrGFm9u/nxp800knqL9iJFvyEe/mcgepG0
         2i5dc6KhZenH58OsDXGl0TecjR/h6T46MWmC7fRbx/QRelYLRdSqtWlpprn4XS9bqGup
         eTVeKJdUkt68RXq6AcvG/U8TrVne27/F0xFMyvb8omjKwH/r8SvNGMedOiT+t6FosK7F
         80NFQ0RV0dBxvVIDK4gWutZVDA1coHBQXafUhjezbC6fkttKIDZcHdhx8DskModDyf+k
         fmbb2WKyBCeIukEtSxdPd3Gb6jYN2A/4z6QtSd3o0ChwSe7HfsT2mOfzWo/ma5BMyDH1
         ILSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=IBd5PU15YHAHVdHf62x54aa16G3NCIhGQ2tbmtxgXqc=;
        b=i6sYfgIXLXM7MxfsDDb6WXs1yPFaHQZA66zBoE6zvmoXJ+4cLvAh0h/dcRTKL6tfg1
         NgnmcVQQGTb/li4z/o1ilpzeDfP8ZxTt2in9EZuROFtb56jEKvTGJKBZtbGj8Wl8mhmG
         8kvT/64OadGx/aCxavWziVESaf9PtKJOfYJ8ObkexOArLQD2JfVIGOFZFPgjrx7GTFJw
         JRZEK+uZ7HkXuIymOfvi4xenxAWAKIhINrBIUoNV14e7m7hgxGZbbWQCtvDbBOUTE/ES
         T7yeOiUMvIQy61HwZGtmkHMcURfCGnYgcPwKptiDrJAjhWWnxSZx0VwBdcqZ983V/vic
         hZnA==
X-Gm-Message-State: AOAM530cISpndjT/G8AmOpday21PQ0tBSr9urKAPCJ7fhd1jJexssQVM
        PcUTaJ/v7SjlbhzcRsolMUa3Z/cVNEpXYQ==
X-Google-Smtp-Source: ABdhPJyM2Awnjfy9jfMBg6/0nqQuL+W318I5pvA/la9XvAsXtI6GCFMjyHpGoHe4tCYD/UjV1lZc8A==
X-Received: by 2002:a7b:c142:: with SMTP id z2mr4859057wmi.10.1632231020693;
        Tue, 21 Sep 2021 06:30:20 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id 135sm2926891wma.32.2021.09.21.06.30.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Sep 2021 06:30:19 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Carlo Arenas <carenas@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v5 4/4] parse-options: properly align continued usage output
Date:   Tue, 21 Sep 2021 15:30:11 +0200
Message-Id: <patch-v5-4.4-9f7f3f8b4ed-20210921T132350Z-avarab@gmail.com>
X-Mailer: git-send-email 2.33.0.1098.gf02a64c1a2d
In-Reply-To: <cover-v5-0.4-00000000000-20210921T132350Z-avarab@gmail.com>
References: <cover-v4-0.4-00000000000-20210912T235347Z-avarab@gmail.com> <cover-v5-0.4-00000000000-20210921T132350Z-avarab@gmail.com>
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
might be cases with sub-commands or "git" itself taking arguments that
would make that non-trivial.

Even if it were I still think this approach is better, because this way
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

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 parse-options.c | 76 +++++++++++++++++++++++++++++++++++++++++--------
 1 file changed, 64 insertions(+), 12 deletions(-)

diff --git a/parse-options.c b/parse-options.c
index 2abff136a17..75f0a6c81c5 100644
--- a/parse-options.c
+++ b/parse-options.c
@@ -917,25 +917,77 @@ static int usage_with_options_internal(struct parse_opt_ctx_t *ctx,
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
+	int saw_empty_line = 0;
+
 	if (!usagestr)
 		return PARSE_OPT_HELP;
 
 	if (!err && ctx && ctx->flags & PARSE_OPT_SHELL_EVAL)
 		fprintf(outfile, "cat <<\\EOF\n");
 
-	fprintf_ln(outfile, _("usage: %s"), _(*usagestr++));
-	while (*usagestr && **usagestr)
-		/*
-		 * TRANSLATORS: the colon here should align with the
-		 * one in "usage: %s" translation.
-		 */
-		fprintf_ln(outfile, _("   or: %s"), _(*usagestr++));
 	while (*usagestr) {
-		if (**usagestr)
-			fprintf_ln(outfile, _("    %s"), _(*usagestr));
-		else
-			fputc('\n', outfile);
-		usagestr++;
+		const char *str = _(*usagestr++);
+		struct string_list list = STRING_LIST_INIT_DUP;
+		unsigned int j;
+
+		if (!saw_empty_line && !*str)
+			saw_empty_line = 1;
+
+		string_list_split(&list, str, '\n', -1);
+		for (j = 0; j < list.nr; j++) {
+			const char *line = list.items[j].string;
+
+			if (saw_empty_line && *line)
+				fprintf_ln(outfile, _("    %s"), line);
+			else if (saw_empty_line)
+				fputc('\n', outfile);
+			else if (!j)
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
2.33.0.1098.gf02a64c1a2d

