Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIMWL_WL_MED shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BDB0E1F404
	for <e@80x24.org>; Sat, 21 Apr 2018 03:45:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752824AbeDUDpp (ORCPT <rfc822;e@80x24.org>);
        Fri, 20 Apr 2018 23:45:45 -0400
Received: from mail-pg0-f66.google.com ([74.125.83.66]:36667 "EHLO
        mail-pg0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752809AbeDUDpo (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 20 Apr 2018 23:45:44 -0400
Received: by mail-pg0-f66.google.com with SMTP id i6so4779599pgv.3
        for <git@vger.kernel.org>; Fri, 20 Apr 2018 20:45:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=miV2YTAi++JYuRW1Bhhu9cydt5UfbRAWMjkiAlQV1Hs=;
        b=l3ToggSHc5N7XC8ihuXTJjmVjWLQFqwp/DcjhN2hOH3t04ZO6eNBvFb7pdBhSD9zsg
         WRzuAy6/pJtWDwgB6Vj+IaZEnwVeLyEsUt+WmbSGDNzqjaB1K48uf3Dhy+KO1HfThWW2
         walea9x7smjxR7GSPC0GHlttaihs9AKqckRCO/ve/E54eueX4ayD3uqIRqe/Yd0GbfGJ
         snoJnKNMgZzgyStxvXion17x4UWH/jT9q++1a0l3UMQnWUv/QHVoSgAhB6bk1xjGqyxs
         GZ01MYQdtgApoy4gvakRkxrpIQ7EbVz13bXDfjxiVtpF9XeZ4MV6lHb2XGwKD212HT2i
         Pgnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=miV2YTAi++JYuRW1Bhhu9cydt5UfbRAWMjkiAlQV1Hs=;
        b=ib8C/Y2DR0xLMTyA8jb9GweFQrTFKQPwt6QuBjOdCap9LkxrQVjIyV/JWz++NQbNwX
         MntitwIe5nbTGj7PaDOs7jnjtGbZwo5ryFFU7bLF431p/Lnjz/Dd2oAb6YxyCFoPhlju
         vdicYHE2lCqxDjMpot48aV2Dr0icEIJrae4RMkcCkOOyLpGWxkwosM2uo4UpCTS1zv2I
         o+DfheVkVox0T41ygXpWA/FYd7jFBSwKlkERZ1Hc6CGMozBURmmEIavMXleyIawtljJe
         baX0814LgwqiFtMi2Zx3yInjTqbAWCjqSro7O0nV3ztibod+72ZtF5D5GH2ooClCH5Se
         VLwQ==
X-Gm-Message-State: ALQs6tBPaMf1rESgYIHJdjEXD1oXQYO2xgcjpq8M4C1KXvBvjBNNKxBB
        LJ+zElj5J4hgnn4swGHTuz76kn3G0h8=
X-Google-Smtp-Source: AIpwx4+NwCkdqTGFxrJPk1gcmy+ScLZB9Y9xGPcARvOqtlXmQMz3Wfp8x/XvkTjc9pIFu5bkBkA8cg==
X-Received: by 10.99.167.75 with SMTP id w11mr10250472pgo.351.1524282343283;
        Fri, 20 Apr 2018 20:45:43 -0700 (PDT)
Received: from localhost ([2601:602:9500:1120:ddb8:3db2:8ad2:955])
        by smtp.gmail.com with ESMTPSA id v12sm10130758pgs.21.2018.04.20.20.45.41
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 20 Apr 2018 20:45:42 -0700 (PDT)
Date:   Fri, 20 Apr 2018 20:45:40 -0700
From:   Taylor Blau <me@ttaylorr.com>
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, l.s.r@web.de, peff@peff.net
Subject: [PATCH 5/6] builtin/grep.c: show column numbers via --column-number
Message-ID: <20180421034540.GF24606@syl.local>
References: <cover.1524281843.git.me@ttaylorr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1524281843.git.me@ttaylorr.com>
User-Agent: Mutt/1.9.3 (2018-01-21)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This commit teaches 'git-grep(1)' a new option, '--column-number'. This
option builds upon previous commits to show the column number of the
first match on a non-context line.

For example:

  $ git grep -mn example | head -n3
  .clang-format:51:14:# myFunction(foo, bar, baz);
  .clang-format:64:7:# int foo();
  .clang-format:75:8:# void foo()

Now that configuration variables such as grep.columnNumber and
color.grep.columnNumber have a visible effect, we document them in this
patch as well.

Signed-off-by: Taylor Blau <me@ttaylorr.com>
---
 Documentation/config.txt   |  5 +++++
 Documentation/git-grep.txt |  9 ++++++++-
 builtin/grep.c             |  1 +
 t/t7810-grep.sh            | 22 ++++++++++++++++++++++
 4 files changed, 36 insertions(+), 1 deletion(-)

diff --git a/Documentation/config.txt b/Documentation/config.txt
index 2659153cb3..02fd4b662b 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -1159,6 +1159,8 @@ color.grep.<slot>::
 	function name lines (when using `-p`)
 `linenumber`;;
 	line number prefix (when using `-n`)
+`columnnumber`;;
+	column number prefix (when using `-m`)
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
index 18b494731f..dd90f74ded 100644
--- a/Documentation/git-grep.txt
+++ b/Documentation/git-grep.txt
@@ -13,7 +13,7 @@ SYNOPSIS
 	   [-v | --invert-match] [-h|-H] [--full-name]
 	   [-E | --extended-regexp] [-G | --basic-regexp]
 	   [-P | --perl-regexp]
-	   [-F | --fixed-strings] [-n | --line-number]
+	   [-F | --fixed-strings] [-n | --line-number] [-m | --column-number]
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
@@ -169,6 +172,10 @@ providing this option will cause it to die.
 --line-number::
 	Prefix the line number to matching lines.
 
+-m::
+--column-number::
+	Prefix the 1-indexed column number of the first match on non-context lines.
+
 -l::
 --files-with-matches::
 --name-only::
diff --git a/builtin/grep.c b/builtin/grep.c
index 5f32d2ce84..faa65abab5 100644
--- a/builtin/grep.c
+++ b/builtin/grep.c
@@ -829,6 +829,7 @@ int cmd_grep(int argc, const char **argv, const char *prefix)
 			    GREP_PATTERN_TYPE_PCRE),
 		OPT_GROUP(""),
 		OPT_BOOL('n', "line-number", &opt.linenum, N_("show line numbers")),
+		OPT_BOOL('m', "column-number", &opt.columnnum, N_("show column numbers")),
 		OPT_NEGBIT('h', NULL, &opt.pathname, N_("don't show filenames"), 1),
 		OPT_BIT('H', NULL, &opt.pathname, N_("show filenames"), 1),
 		OPT_NEGBIT(0, "full-name", &opt.relative,
diff --git a/t/t7810-grep.sh b/t/t7810-grep.sh
index 1797f632a3..0cf654824d 100755
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
+		git -c grep.linenumber=false grep -m -w -e mmap $H >actual &&
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
+		git -c grep.linenumber=false grep -n -m -w -e mmap $H >actual &&
+		test_cmp expected actual
+	'
+
 	test_expect_success "grep -w $L" '
 		{
 			echo ${HC}file:1:foo mmap bar
-- 
2.17.0

