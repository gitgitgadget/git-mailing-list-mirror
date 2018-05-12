Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIMWL_WL_MED shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id AA1431F406
	for <e@80x24.org>; Sat, 12 May 2018 03:11:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751398AbeELDLR (ORCPT <rfc822;e@80x24.org>);
        Fri, 11 May 2018 23:11:17 -0400
Received: from mail-pl0-f67.google.com ([209.85.160.67]:38663 "EHLO
        mail-pl0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751092AbeELDLQ (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 11 May 2018 23:11:16 -0400
Received: by mail-pl0-f67.google.com with SMTP id c11-v6so4281719plr.5
        for <git@vger.kernel.org>; Fri, 11 May 2018 20:11:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=CIvsN7yIy+2a/64v3Jce7dOsevT5/8RLMTaKgNr5Rkk=;
        b=Q4rjON/T5olbxnzZia0LzD/Y4sG7M43S9ZMNhr5h3TdeegF2bzqKuTAVAYYuq+1vZG
         9cO7j2ElI6V1eTM70M8IMizwmBAWsbwARVZmZulZPRTyKTerSDMKssdUP5vX8dnn0uiV
         PhQrqBG1zsMahV1QPGzdwDiF/+Dma0l3gjiVAfPC6XohuOa/8agBpdP91mGheJAC/1iz
         Ubwo4WyJJXgjHaNTArzYEpi5KeNvKs3fE+I9kuE1Tp5f9sTlJRG0M22z0fkKheTHwkDl
         dJmpjNPV+L77y2/BVaVPFeV/kpsURZ7AesqW36Ox1LlZgJ/9YWY/aNCN8Z+4EmnWq9S/
         uqzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=CIvsN7yIy+2a/64v3Jce7dOsevT5/8RLMTaKgNr5Rkk=;
        b=PJVRHNIorqhz4T2RE7uJjWoTOZU0Bm76N0xMZWkWacsgw9RDrhjSZeBf9dsH3p9yf0
         6qXR3OJRFy0G3YQx+PKfhjDfhb6PLwmE11War34rh+nv+Foqb8ENrMwZuoZRKZZo+1Zq
         8LcnxXkm/azTJTeno6QSHVn0O5s+OoToOAIclun5sfJq0pyzTwWpFwZ8E2YIfTzdGaHJ
         H1thLXU2G5RNO+dBLi6aCJyxCUphEOFFkZrLWg/uU1/L3yn1nCuC7kZ+VPAYUTrYQdz7
         f6u8PPgtLTZpSk2ppRrqDB7QKVnWb/qOARfEw+4DDfHcLuKmUa+sCk5Ewo/q6Q3730vT
         AyGg==
X-Gm-Message-State: ALKqPwf+ZiHk9CZ2qQ3ryxpASHEzyFRp8pOXhS5rwpMhJ8ij9mCoBzeB
        oRh9gU0V8SZpTg42g+TEaWjqHlJuZkw=
X-Google-Smtp-Source: AB8JxZqvRPmv0xHNot1VOivhvHTsYH3LHOsZmUmzJVbBw09y4rxCxfNsEj1wIBDUDd4KoDV+SzTyqQ==
X-Received: by 2002:a17:902:20cb:: with SMTP id v11-v6mr738577plg.82.1526094675100;
        Fri, 11 May 2018 20:11:15 -0700 (PDT)
Received: from localhost ([2601:602:9500:1120:81b:33bd:f4a4:78cd])
        by smtp.gmail.com with ESMTPSA id c3-v6sm7812390pfn.62.2018.05.11.20.11.13
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 11 May 2018 20:11:14 -0700 (PDT)
Date:   Fri, 11 May 2018 20:11:12 -0700
From:   Taylor Blau <me@ttaylorr.com>
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, l.s.r@web.de, martin.agren@gmail.com,
        peff@peff.net, phillip.wood@talktalk.net
Subject: [PATCH v6 5/7] builtin/grep.c: add '--column' option to 'git-grep(1)'
Message-ID: <cb697d32ee6a2e5d45f331a809bd5e7cb1ba7a9c.1526094383.git.me@ttaylorr.com>
References: <20180421034530.GB24606@syl.local>
 <cover.1526094383.git.me@ttaylorr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1526094383.git.me@ttaylorr.com>
User-Agent: Mutt/1.9.5 (2018-04-13)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Teach 'git-grep(1)' a new option, '--column', to show the column
number of the first match on a non-context line. This makes it possible
to teach 'contrib/git-jump/git-jump' how to seek to the first matching
position of a grep match in your editor, and allows similar additional
scripting capabilities.

For example:

  $ git grep -n --column foo | head -n3
  .clang-format:51:14:# myFunction(foo, bar, baz);
  .clang-format:64:7:# int foo();
  .clang-format:75:8:# void foo()

Signed-off-by: Taylor Blau <me@ttaylorr.com>
---
 Documentation/git-grep.txt |  7 ++++++-
 builtin/grep.c             |  4 ++++
 grep.c                     |  5 +++--
 t/t7810-grep.sh            | 39 ++++++++++++++++++++++++++++++++++++++
 4 files changed, 52 insertions(+), 3 deletions(-)

diff --git a/Documentation/git-grep.txt b/Documentation/git-grep.txt
index 18b494731f..cec4665df5 100644
--- a/Documentation/git-grep.txt
+++ b/Documentation/git-grep.txt
@@ -13,7 +13,7 @@ SYNOPSIS
 	   [-v | --invert-match] [-h|-H] [--full-name]
 	   [-E | --extended-regexp] [-G | --basic-regexp]
 	   [-P | --perl-regexp]
-	   [-F | --fixed-strings] [-n | --line-number]
+	   [-F | --fixed-strings] [-n | --line-number] [--column]
 	   [-l | --files-with-matches] [-L | --files-without-match]
 	   [(-O | --open-files-in-pager) [<pager>]]
 	   [-z | --null]
@@ -169,6 +169,11 @@ providing this option will cause it to die.
 --line-number::
 	Prefix the line number to matching lines.
 
+--column::
+	Prefix the 1-indexed byte-offset of the first match from the start of the
+	matching line. This option is incompatible with '--invert-match', and
+	ignored with expressions using '--and', '--or', '--not'.
+
 -l::
 --files-with-matches::
 --name-only::
diff --git a/builtin/grep.c b/builtin/grep.c
index 5f32d2ce84..f9f516dfc4 100644
--- a/builtin/grep.c
+++ b/builtin/grep.c
@@ -829,6 +829,7 @@ int cmd_grep(int argc, const char **argv, const char *prefix)
 			    GREP_PATTERN_TYPE_PCRE),
 		OPT_GROUP(""),
 		OPT_BOOL('n', "line-number", &opt.linenum, N_("show line numbers")),
+		OPT_BOOL(0, "column", &opt.columnnum, N_("show column number of first match")),
 		OPT_NEGBIT('h', NULL, &opt.pathname, N_("don't show filenames"), 1),
 		OPT_BIT('H', NULL, &opt.pathname, N_("show filenames"), 1),
 		OPT_NEGBIT(0, "full-name", &opt.relative,
@@ -1111,6 +1112,9 @@ int cmd_grep(int argc, const char **argv, const char *prefix)
 		hit = grep_objects(&opt, &pathspec, the_repository, &list);
 	}
 
+	if (opt.columnnum && opt.invert)
+		die(_("--column and --invert-match cannot be combined"));
+
 	if (num_threads)
 		hit |= wait_all();
 	if (hit && show_in_pager)
diff --git a/grep.c b/grep.c
index f3fe416791..7396b49a2d 100644
--- a/grep.c
+++ b/grep.c
@@ -1402,9 +1402,10 @@ static void show_line(struct grep_opt *opt, char *bol, char *eol,
 	/*
 	 * Treat 'cno' as the 1-indexed offset from the start of a non-context
 	 * line to its first match. Otherwise, 'cno' is 0 indicating that we are
-	 * being called with a context line.
+	 * being called with a context line, or we are --extended, and cannot
+	 * always show an answer.
 	 */
-	if (opt->columnnum && cno) {
+	if (opt->columnnum && sign == ':' && !opt->extended) {
 		char buf[32];
 		xsnprintf(buf, sizeof(buf), "%d", cno);
 		output_color(opt, buf, strlen(buf), opt->color_columnno);
diff --git a/t/t7810-grep.sh b/t/t7810-grep.sh
index 1797f632a3..491b2e044a 100755
--- a/t/t7810-grep.sh
+++ b/t/t7810-grep.sh
@@ -99,6 +99,40 @@ do
 		test_cmp expected actual
 	'
 
+	test_expect_success "grep -w $L (with --column)" '
+		{
+			echo ${HC}file:5:foo mmap bar
+			echo ${HC}file:14:foo_mmap bar mmap
+			echo ${HC}file:5:foo mmap bar_mmap
+			echo ${HC}file:14:foo_mmap bar mmap baz
+		} >expected &&
+		git grep --column -w -e mmap $H >actual &&
+		test_cmp expected actual
+	'
+
+	test_expect_success "grep -w $L (with --column, -C)" '
+		{
+			echo ${HC}file:5:foo mmap bar
+			echo ${HC}file-foo_mmap bar
+			echo ${HC}file:14:foo_mmap bar mmap
+			echo ${HC}file:5:foo mmap bar_mmap
+			echo ${HC}file:14:foo_mmap bar mmap baz
+		} >expected &&
+		git grep --column -w -C1 -e mmap $H >actual &&
+		test_cmp expected actual
+	'
+
+	test_expect_success "grep -w $L (with --line-number, --column)" '
+		{
+			echo ${HC}file:1:5:foo mmap bar
+			echo ${HC}file:3:14:foo_mmap bar mmap
+			echo ${HC}file:4:5:foo mmap bar_mmap
+			echo ${HC}file:5:14:foo_mmap bar mmap baz
+		} >expected &&
+		git grep -n --column -w -e mmap $H >actual &&
+		test_cmp expected actual
+	'
+
 	test_expect_success "grep -w $L" '
 		{
 			echo ${HC}file:1:foo mmap bar
@@ -1590,4 +1624,9 @@ test_expect_success 'grep does not report i-t-a and assume unchanged with -L' '
 	test_cmp expected actual
 '
 
+test_expect_success 'grep does not allow --column, --invert-match' '
+	test_must_fail git grep --column --invert-match pat 2>err &&
+	test_i18ngrep "\-\-column and \-\-invert-match cannot be combined" err
+'
+
 test_done
-- 
2.17.0

