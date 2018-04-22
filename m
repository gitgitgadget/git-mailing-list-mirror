Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIMWL_WL_MED shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8D4391F424
	for <e@80x24.org>; Sun, 22 Apr 2018 20:47:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753689AbeDVUrl (ORCPT <rfc822;e@80x24.org>);
        Sun, 22 Apr 2018 16:47:41 -0400
Received: from mail-pg0-f67.google.com ([74.125.83.67]:38750 "EHLO
        mail-pg0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753664AbeDVUrj (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 22 Apr 2018 16:47:39 -0400
Received: by mail-pg0-f67.google.com with SMTP id b5so6917192pgv.5
        for <git@vger.kernel.org>; Sun, 22 Apr 2018 13:47:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=SXXveHaHd8D1Q+5l7jozH1acrLYyEKxW5gXo6nOxBPw=;
        b=dQvofcHYph9W0vcgnJ8BZvtQAALb3fZlpkZ2FazniMvcdol+iB73pUy0h4/zVPqt4k
         X/uQAQ+2DwCzn6yEZBnMVk5H79qHVzYBgN9tbwAWlaLngYQ4pDp6tOI8H1eCfy+AssUx
         wH2jrz7kW32yHe1O0iQGljSJqJh3a2fB+HMw+q/cEmQkR6CXoVaNHZ3WR8B07Khu1oeT
         1fWYqVHqa3kkLg0TuAJFyjuNCA+QRNh6ZCxdkvZZO+cOr2atbHqUZGA4b2LsnRCqn9MI
         9xrU0vakTMmIBTooAm7WEx+BRF977yxgbPTStjKFV3YIGk7viGR9B3cnOEINvFUvPKdu
         OEQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=SXXveHaHd8D1Q+5l7jozH1acrLYyEKxW5gXo6nOxBPw=;
        b=FQM5LkM2AkUQIJb+0pntrnyrv6islGoSmNyNl5URJ+klUjEe7kCNcd1E8wq/JybnWM
         9SsELOoPnwL5B+NILQQRfXjeSMCyM0enZOfHOtZqfcqvvaKdvX9DlHyO2bjmpij1nbtq
         XXfOIojX2hqLYEqN8k6R4Vi1/u/Nk1h3QNBODwPmsKwBGf8S8QfrcMenD0f6DH1rsSFx
         MoSy6ZX3sBYK9pFxqg0jGnunPglh5vsH0mj6qHqCjab5RBjS2yuEqbtvi5z2TUkFQrrK
         yrzcP8Any60151QvaQseAcOvTS46Mm9/p4E+y2/gH0D9+4878cuyVFiMn1WTGJ3+uVgO
         tHPg==
X-Gm-Message-State: ALQs6tAoNKvv03VIZBBmNXjuGT3MGQQ938N33uV/fyOmJI5+5P8ZusA+
        FBT1+cG7mu55xVGSNrv7kjEZAMCi6xw=
X-Google-Smtp-Source: AIpwx4+8q7FBMRJXVf8LwlEXP26Xv+bxn9hGGZ5BIck3rTWlbJGoq4Jbv9SCAIxcig3A0ubXDV3Rhw==
X-Received: by 2002:a17:902:108a:: with SMTP id c10-v6mr18253459pla.111.1524430058199;
        Sun, 22 Apr 2018 13:47:38 -0700 (PDT)
Received: from localhost ([2601:602:9500:1120:e8b3:eaad:c134:baec])
        by smtp.gmail.com with ESMTPSA id m185sm20147998pfm.118.2018.04.22.13.47.36
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 22 Apr 2018 13:47:37 -0700 (PDT)
Date:   Sun, 22 Apr 2018 13:47:36 -0700
From:   Taylor Blau <me@ttaylorr.com>
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, l.s.r@web.de, martin.agren@gmail.com,
        peff@peff.net
Subject: [PATCH v2 5/6] builtin/grep.c: show column numbers via
 --column-number
Message-ID: <6dd73ad84cad5a749bf05c500295955970577e04.1524429778.git.me@ttaylorr.com>
References: <20180421034530.GB24606@syl.local>
 <cover.1524429778.git.me@ttaylorr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1524429778.git.me@ttaylorr.com>
User-Agent: Mutt/1.9.5 (2018-04-13)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This commit teaches 'git-grep(1)' a new option, '--column-number'. This
option builds upon previous commits to show the column number of the
first match on a non-context line.

For example:

  $ ./git-grep -n --column-number foo | head -n3
  .clang-format:51:14:# myFunction(foo, bar, baz);
  .clang-format:64:7:# int foo();
  .clang-format:75:8:# void foo()

Now that configuration variables such as grep.columnNumber and
color.grep.columnNumber have a visible effect, we document them in this
patch as well.

While we're at it, change color.grep.linenumber to color.grep.lineNumber
to match the casing of nearby variables.

Signed-off-by: Taylor Blau <me@ttaylorr.com>
---
 Documentation/config.txt   |  7 ++++++-
 Documentation/git-grep.txt |  8 +++++++-
 builtin/grep.c             |  1 +
 t/t7810-grep.sh            | 22 ++++++++++++++++++++++
 4 files changed, 36 insertions(+), 2 deletions(-)

diff --git a/Documentation/config.txt b/Documentation/config.txt
index 2659153cb3..1645fcf2ae 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -1157,8 +1157,10 @@ color.grep.<slot>::
 	filename prefix (when not using `-h`)
 `function`;;
 	function name lines (when using `-p`)
-`linenumber`;;
+`lineNumber`;;
 	line number prefix (when using `-n`)
+`columnNumber`;;
+	column number prefix (when using `--column-number`)
 `match`;;
 	matching text (same as setting `matchContext` and `matchSelected`)
 `matchContext`;;
@@ -1708,6 +1710,9 @@ gitweb.snapshot::
 grep.lineNumber::
 	If set to true, enable `-n` option by default.
 
+grep.columnNumber::
+	If set to true, enable `-m` option by default.
+
 grep.patternType::
 	Set the default matching behavior. Using a value of 'basic', 'extended',
 	'fixed', or 'perl' will enable the `--basic-regexp`, `--extended-regexp`,
diff --git a/Documentation/git-grep.txt b/Documentation/git-grep.txt
index 18b494731f..b75a039768 100644
--- a/Documentation/git-grep.txt
+++ b/Documentation/git-grep.txt
@@ -13,7 +13,7 @@ SYNOPSIS
 	   [-v | --invert-match] [-h|-H] [--full-name]
 	   [-E | --extended-regexp] [-G | --basic-regexp]
 	   [-P | --perl-regexp]
-	   [-F | --fixed-strings] [-n | --line-number]
+	   [-F | --fixed-strings] [-n | --line-number] [--column-number]
 	   [-l | --files-with-matches] [-L | --files-without-match]
 	   [(-O | --open-files-in-pager) [<pager>]]
 	   [-z | --null]
@@ -44,6 +44,9 @@ CONFIGURATION
 grep.lineNumber::
 	If set to true, enable `-n` option by default.
 
+grep.columnNumber::
+	If set to true, enable `-m` option by default.
+
 grep.patternType::
 	Set the default matching behavior. Using a value of 'basic', 'extended',
 	'fixed', or 'perl' will enable the `--basic-regexp`, `--extended-regexp`,
@@ -169,6 +172,9 @@ providing this option will cause it to die.
 --line-number::
 	Prefix the line number to matching lines.
 
+--column-number::
+	Prefix the 1-indexed column number of the first match on non-context lines.
+
 -l::
 --files-with-matches::
 --name-only::
diff --git a/builtin/grep.c b/builtin/grep.c
index 5f32d2ce84..23ce97f998 100644
--- a/builtin/grep.c
+++ b/builtin/grep.c
@@ -829,6 +829,7 @@ int cmd_grep(int argc, const char **argv, const char *prefix)
 			    GREP_PATTERN_TYPE_PCRE),
 		OPT_GROUP(""),
 		OPT_BOOL('n', "line-number", &opt.linenum, N_("show line numbers")),
+		OPT_BOOL(0, "column-number", &opt.columnnum, N_("show column numbers")),
 		OPT_NEGBIT('h', NULL, &opt.pathname, N_("don't show filenames"), 1),
 		OPT_BIT('H', NULL, &opt.pathname, N_("show filenames"), 1),
 		OPT_NEGBIT(0, "full-name", &opt.relative,
diff --git a/t/t7810-grep.sh b/t/t7810-grep.sh
index 1797f632a3..7349c7fadc 100755
--- a/t/t7810-grep.sh
+++ b/t/t7810-grep.sh
@@ -99,6 +99,28 @@ do
 		test_cmp expected actual
 	'
 
+	test_expect_success "grep -w $L" '
+		{
+			echo ${HC}file:5:foo mmap bar
+			echo ${HC}file:14:foo_mmap bar mmap
+			echo ${HC}file:5:foo mmap bar_mmap
+			echo ${HC}file:14:foo_mmap bar mmap baz
+		} >expected &&
+		git grep --column-number -w -e mmap $H >actual &&
+		test_cmp expected actual
+	'
+
+	test_expect_success "grep -w $L" '
+		{
+			echo ${HC}file:1:5:foo mmap bar
+			echo ${HC}file:3:14:foo_mmap bar mmap
+			echo ${HC}file:4:5:foo mmap bar_mmap
+			echo ${HC}file:5:14:foo_mmap bar mmap baz
+		} >expected &&
+		git grep -n --column-number -w -e mmap $H >actual &&
+		test_cmp expected actual
+	'
+
 	test_expect_success "grep -w $L" '
 		{
 			echo ${HC}file:1:foo mmap bar
-- 
2.17.0

