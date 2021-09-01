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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59A8BC43214
	for <git@archiver.kernel.org>; Wed,  1 Sep 2021 11:13:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3EFDE6101B
	for <git@archiver.kernel.org>; Wed,  1 Sep 2021 11:13:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241797AbhIALOF (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 1 Sep 2021 07:14:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39974 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238988AbhIALN5 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 1 Sep 2021 07:13:57 -0400
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 637D4C061764
        for <git@vger.kernel.org>; Wed,  1 Sep 2021 04:13:00 -0700 (PDT)
Received: by mail-wr1-x42e.google.com with SMTP id q11so3867851wrr.9
        for <git@vger.kernel.org>; Wed, 01 Sep 2021 04:13:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=iwiHe8TxZMRMJdFeD6B9F0RCHk98AKvtBGippsvFH9I=;
        b=eVnYfMOWlZk3wZsJROX6M8azBwcMR1y5M5SK4H1GsheQHwg1pHVjuaVRwGybhJ1xnv
         A1WDDBwMLrhJvgGmbll6efWb/B/Unxv0tN9tnWjH1HGpoIx3wQ8au2644wDgtZvCMqPU
         Po/olKiVbNdHraTm+BsSlOlAuLhQnbeEYTIZRXiFjTyYx7wtorZnF7URp1AWXK1ITkIr
         Kk248O6ZiFWAoHiqzuXjdiLC938Ccl8ioecZZ20/Lb7Whg2aO2tSiWCoUiz9Tle4IQbe
         f2NnrTHSYccVmA/ellq5/fa3Mx86aArN4/0JLt9dhNdHhyhup64PSJjYKaN9UZPzblJ3
         Drcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=iwiHe8TxZMRMJdFeD6B9F0RCHk98AKvtBGippsvFH9I=;
        b=PqUe016VSOu4UOX5BClf7dWfcd3gp6LZMpLNNyQ7wAQmNf/eL/yfoMZ0nSIHI/sPO3
         86yqvV19SgdQNwuVVh2f9amqxRFNIIZnHXFen48ida071af90ltlo73hlcXX8BybcX3x
         RGZXn78I1Om4PiW1WdzCwe9H/xQVB5WJ/Yt38CSNkJsqMEqB4P5jeGDb3HVtphIe7eF+
         l2IeJe8eKbK93DjmapQBM97vI+0do2jBSATRsn5o49c4I/B+TzMjB3icQ4EkD4leKyLE
         VrJofSCAqITm/O2vCCVg2TgFzLDCmg3S6bdim9QksDOChjKfxJiievCK7JLnG4fRhXcw
         xaaQ==
X-Gm-Message-State: AOAM532LkNLHkOSDNVmL0fQfxrQdbDtXZPz3a9CCE4xjZc4up/2+3JJX
        A7q79NyJX65DgR7tHWYe1bsrld5g+2GmVw==
X-Google-Smtp-Source: ABdhPJzT8wU50oJ7+X257kGBe9E3mSYTAUaXhqFsS1RU9imCTc3yxgnGvuSsVD3ByGLT5ny08ibR4Q==
X-Received: by 2002:adf:d1ab:: with SMTP id w11mr28765238wrc.372.1630494778717;
        Wed, 01 Sep 2021 04:12:58 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id u25sm5151499wmj.10.2021.09.01.04.12.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Sep 2021 04:12:58 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Carlo Arenas <carenas@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH 2/2] parse-options: properly align continued usage output
Date:   Wed,  1 Sep 2021 13:12:55 +0200
Message-Id: <patch-2.2-ab4bb70902b-20210901T110917Z-avarab@gmail.com>
X-Mailer: git-send-email 2.33.0.807.gf14ecf9c2e9
In-Reply-To: <cover-0.2-00000000000-20210901T110917Z-avarab@gmail.com>
References: <cover-0.2-00000000000-20210901T110917Z-avarab@gmail.com>
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

In making this change we can can fold the two for-loops over *usagestr
into one. We had two of them purely to account for the case where an
empty string in the array delimits the usage output from free-form
text output.

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
 parse-options.c | 79 +++++++++++++++++++++++++++++++++++++++++--------
 1 file changed, 66 insertions(+), 13 deletions(-)

diff --git a/parse-options.c b/parse-options.c
index 2abff136a17..a06968bf4f5 100644
--- a/parse-options.c
+++ b/parse-options.c
@@ -917,25 +917,78 @@ static int usage_with_options_internal(struct parse_opt_ctx_t *ctx,
 	FILE *outfile = err ? stderr : stdout;
 	int need_newline;
 
+	const char *usage_prefix = _("usage: %s");
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
+	 * because options have wrapped o the next line. The line
+	 * after the "\n" will then be padded to align with the
+	 * command name, such as N_("git cmd [opt]\n<8
+	 * spaces>[opt2]"), where the 8 spaces are the same length as
+	 * "git cmd ".
+	 *
+	 * This format string prints out that already-translated
+	 * line. The "%*s" is whitespace padding to account for the
+	 * padding at the start of the line that we add in this
+	 * function, the "%s" is a line in the (hopefully already
+	 * translated) N_() usage string, which contained embedded
+	 * newlines before we split it up.
+	 */
+	const char *usage_continued = _("%*s%s");
+
+	/*
+	 * The translation could be anything, but we can count on
+	 * msgfmt(1)'s --check option to have asserted that "%s" is in
+	 * the translation. So compute the length of the " or: "
+	 * part. We are assuming that the translator wasn't overly
+	 * clever and used e.g. "%1$s" instead of "%s", there's only
+	 * one "%s" in "or_prefix" above, so there's no reason to do
+	 * so even with a RTL language.
+	 */
+	size_t or_len = strlen(or_prefix) - strlen("%s");
+	int i;
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
-	while (*usagestr) {
-		if (**usagestr)
-			fprintf_ln(outfile, _("    %s"), _(*usagestr));
-		else
-			fputc('\n', outfile);
-		usagestr++;
+	for (i = 0; *usagestr; i++) {
+		const char *str = _(*usagestr++);
+		struct string_list list = STRING_LIST_INIT_DUP;
+		unsigned int j;
+
+		string_list_split(&list, str, '\n', -1);
+		for (j = 0; j < list.nr; j++) {
+			const char *line = list.items[j].string;
+
+			if (!saw_empty_line && !*line)
+				saw_empty_line = 1;
+
+			if (saw_empty_line && *line)
+				fprintf_ln(outfile, _("    %s"), line);
+			else if (saw_empty_line)
+				fputc('\n', outfile);
+			else if (!j && !i)
+				fprintf_ln(outfile, usage_prefix, line);
+			else if (!j)
+				fprintf_ln(outfile, or_prefix, line);
+			else
+				fprintf_ln(outfile, usage_continued,
+					   (int)or_len, "", line);
+		}
+		string_list_clear(&list, 0);
 	}
 
 	need_newline = 1;
-- 
2.33.0.807.gf14ecf9c2e9

