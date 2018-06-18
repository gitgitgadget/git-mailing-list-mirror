Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIMWL_WL_MED shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 938511F403
	for <e@80x24.org>; Mon, 18 Jun 2018 23:43:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S937045AbeFRXnW (ORCPT <rfc822;e@80x24.org>);
        Mon, 18 Jun 2018 19:43:22 -0400
Received: from mail-oi0-f66.google.com ([209.85.218.66]:40395 "EHLO
        mail-oi0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S937005AbeFRXnV (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 18 Jun 2018 19:43:21 -0400
Received: by mail-oi0-f66.google.com with SMTP id f79-v6so16480947oib.7
        for <git@vger.kernel.org>; Mon, 18 Jun 2018 16:43:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=QBiXzgpUeaCRcAAqSPEIrRDCUYBsAlaclbZB58gilgY=;
        b=OOyKI/qdn2p3sxO99Ffz5hEwR1DjmtnmHI5IpNI9LEPpj6WBJlwvebMLSIZIs5Qomv
         dAZpQga2Ktyua7g5C9+yH5YaMpaVuQtPxaZDMjsAuockwDS4JOTn2ZVtj1kQW+RspGSC
         2RdUfdrbp8yzGqrepVopq7vj6IGnMhQYcr2T/Sz3AoARV/daDrF2wXELdgIPA8+NYQEN
         womry827+Ze5cLcAkb7ss7h28IIDjBsG2WprcoxuuW4iEkdwFpk6M9ofG/V6yjRyXIPK
         fdZ9dwsB+w16iofIBZID7rbpJl1mtEBrktpKMSunLf7ssebNiiTqiybmH59T5K1qBHjh
         wC7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=QBiXzgpUeaCRcAAqSPEIrRDCUYBsAlaclbZB58gilgY=;
        b=lE/uYE1pRJ/YwLy+dA9UfiinCKO64cQGsafQFTfjq8dGjVykOTZkRGTsJJ4O06ja+c
         rVpxevlGrd4yRaC3tSnpg+vRJBzENu/71PkngD9EsLf33VhauwB0HDx5G4ctwLfEJIKw
         npV9l+Y9MqCnaG/zvQOeUPaMpKi2wonrdmjwFbT2wYLklKVlE0u83LjkRx9roEhAg4nl
         +Iqlnj/AbgWe6NGAZtAxMUoidD4XuFHM24GlYFERWKJPJLUa0Cp+MEpal7HdY7AIE5+G
         aNJOCOwU8HJlAS5PPXjxA1cHV1Vbp2URFEd4XhmyDzoPMfxZqe2AjzD1IL0noISJ4ohq
         Q4GA==
X-Gm-Message-State: APt69E2Nr+7AXeC7DtwRzjRVwy5Zr9iLNRx1UzRoeSH36ezrL1m44hfA
        AT1nfo3JTYS5B8kn5epPvEe/Eu/VozA=
X-Google-Smtp-Source: ADUXVKJhH6HIc80yBakpFJjfj/NTqS9Pb4DRPVnKE2SDIETsdS37Mv3gwXYZBg8ne/9cfmkNdZfzvQ==
X-Received: by 2002:aca:c681:: with SMTP id w123-v6mr7689341oif.94.1529365400255;
        Mon, 18 Jun 2018 16:43:20 -0700 (PDT)
Received: from localhost ([107.217.158.181])
        by smtp.gmail.com with ESMTPSA id b12-v6sm6707724oiy.43.2018.06.18.16.43.18
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 18 Jun 2018 16:43:19 -0700 (PDT)
Date:   Mon, 18 Jun 2018 18:43:17 -0500
From:   Taylor Blau <me@ttaylorr.com>
To:     git@vger.kernel.org
Cc:     avarab@gmail.com, peff@peff.net, gitster@pobox.com
Subject: [PATCH 5/7] builtin/grep.c: add '--column' option to 'git-grep(1)'
Message-ID: <0374418de5082186468553a21d070907c0e51058.1529365072.git.me@ttaylorr.com>
References: <cover.1529365072.git.me@ttaylorr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1529365072.git.me@ttaylorr.com>
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
 Documentation/git-grep.txt |  6 +++-
 builtin/grep.c             |  1 +
 t/t7810-grep.sh            | 63 ++++++++++++++++++++++++++++++++++++++
 3 files changed, 69 insertions(+), 1 deletion(-)

diff --git a/Documentation/git-grep.txt b/Documentation/git-grep.txt
index 312409a607..31dc0392a6 100644
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
@@ -169,6 +169,10 @@ providing this option will cause it to die.
 --line-number::
 	Prefix the line number to matching lines.
 
+--column::
+	Prefix the 1-indexed byte-offset of the first match from the start of the
+	matching line.
+
 -l::
 --files-with-matches::
 --name-only::
diff --git a/builtin/grep.c b/builtin/grep.c
index ee753a403e..61bcaf6e58 100644
--- a/builtin/grep.c
+++ b/builtin/grep.c
@@ -828,6 +828,7 @@ int cmd_grep(int argc, const char **argv, const char *prefix)
 			    GREP_PATTERN_TYPE_PCRE),
 		OPT_GROUP(""),
 		OPT_BOOL('n', "line-number", &opt.linenum, N_("show line numbers")),
+		OPT_BOOL(0, "column", &opt.columnnum, N_("show column number of first match")),
 		OPT_NEGBIT('h', NULL, &opt.pathname, N_("don't show filenames"), 1),
 		OPT_BIT('H', NULL, &opt.pathname, N_("show filenames"), 1),
 		OPT_NEGBIT(0, "full-name", &opt.relative,
diff --git a/t/t7810-grep.sh b/t/t7810-grep.sh
index 1797f632a3..daaf7b4c44 100755
--- a/t/t7810-grep.sh
+++ b/t/t7810-grep.sh
@@ -99,6 +99,69 @@ do
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
+	test_expect_success "grep -w $L (with --column, extended)" '
+		{
+			echo ${HC}file:14:foo_mmap bar mmap
+			echo ${HC}file:19:foo_mmap bar mmap baz
+		} >expected &&
+		git grep --column -w -e mmap$ --or -e baz $H >actual &&
+		test_cmp expected actual
+	'
+
+	test_expect_success "grep -w $L (with --column, --invert)" '
+		{
+			echo ${HC}file:1:foo mmap bar
+			echo ${HC}file:1:foo_mmap bar
+			echo ${HC}file:1:foo_mmap bar mmap
+			echo ${HC}file:1:foo mmap bar_mmap
+		} >expected &&
+		git grep --column --invert -w -e baz $H -- file >actual &&
+		test_cmp expected actual
+	'
+
+	test_expect_success "grep $L (with --column, --invert, extended)" '
+		{
+			echo ${HC}hello_world:6:HeLLo_world
+		} >expected &&
+		git grep --column --invert -e ll --or --not -e _ $H -- hello_world \
+			>actual &&
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
-- 
2.17.0.582.gccdcbd54c

