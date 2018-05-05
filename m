Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIMWL_WL_MED shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BBEEB200B9
	for <e@80x24.org>; Sat,  5 May 2018 02:43:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751838AbeEECnH (ORCPT <rfc822;e@80x24.org>);
        Fri, 4 May 2018 22:43:07 -0400
Received: from mail-pg0-f68.google.com ([74.125.83.68]:35493 "EHLO
        mail-pg0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751800AbeEECnF (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 4 May 2018 22:43:05 -0400
Received: by mail-pg0-f68.google.com with SMTP id j11-v6so16605392pgf.2
        for <git@vger.kernel.org>; Fri, 04 May 2018 19:43:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=GmKFrfy0IaSLD0HlRtyVv/7RA4Yqdz53SW//WwCKbt4=;
        b=y18Ys3SfeeSGU0yVJJTwHvMu19HWaRztY4fQmfkW54JkzoD1KUyWmob8HnqnBKt97p
         M1PR+PYT4DSiybbHlW+HDNKy5LT+TRI8+ZkmKOPIlnRYu+sNuldgh5GHIzLLFQZaehZt
         3+usUufCPt5JXqAqi5ABmJlG84243gOtmBxW43tCzlvHm8W/pIVK7FBPEkmE6lc4jwkx
         pp7x/tBBgW3j5ZE4eBmVVZ1Ff/pRldCecdAwNWOKhvAkP32KU3K1hgPhcdvrF6oyNA5E
         1jx2f7g9wp6C9r+wceXJBF6toVbG5ifizcjnbunP1/vP/X2Sw/Cv4hV1TXISKyU5r8+e
         y0ew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=GmKFrfy0IaSLD0HlRtyVv/7RA4Yqdz53SW//WwCKbt4=;
        b=lvS6lo97aoqqgjKl4EdZipYTCb8urbrJaykw8gN/Ng9rTpUHOFy7MacUoBHCMdSamy
         3b84EO0+Oa2hKvzWL0+cdGlQg7YIOC1PRua4eJUu2bTXD6UXL3bqvnntoibcZlipmgRD
         0EBC17n1EtKk4D+r7B/Na6t4KRVX5j1XeSY8xjO/dMc0YTujvHpj1VsrXvjer1wp/yUa
         DLG8u7l9JURzMuzIfMtMV14F+MLHNf/ScsH+SoQ03hH2s7AZ0hB/WGgzNbIr33c+d6yO
         dFG3PZNE/WnrIqefbmbqJP6GzTQ50Y5jFYF7PQnAjh2UZ5A2AJ5bjCWn9XyLGUTbqkqU
         EUAw==
X-Gm-Message-State: ALQs6tB2JeJ3FgpRLqETfbbICxYeQxvMuWtfFNMK0ncvExa+/t3IcmQ6
        J+mvdwPXzCQBNwWzHIykwH2tygG4/NdGMg==
X-Google-Smtp-Source: AB8JxZp0vArfmuL9sz1rwTTwGTs7EGMk2iEJRHzLMorAyiWLD1+tOzTer12Yn4g+iuOpoyvjCAknUw==
X-Received: by 2002:a17:902:5382:: with SMTP id c2-v6mr30276035pli.335.1525488184394;
        Fri, 04 May 2018 19:43:04 -0700 (PDT)
Received: from localhost ([2601:602:9500:1120:a961:c277:c90f:2435])
        by smtp.gmail.com with ESMTPSA id k24sm8002083pff.118.2018.05.04.19.43.02
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 04 May 2018 19:43:03 -0700 (PDT)
Date:   Fri, 4 May 2018 19:43:02 -0700
From:   Taylor Blau <me@ttaylorr.com>
To:     git@vger.kernel.org
Cc:     avarab@gmail.com, gitster@pobox.com, l.s.r@web.de,
        martin.agren@gmail.com, peff@peff.net, sunshine@sunshineco.com
Subject: [PATCH v4 5/7] builtin/grep.c: add '--column' option to 'git-grep(1)'
Message-ID: <9a596d53d6b2523bc94e58678aa43e68068859b6.1525488108.git.me@ttaylorr.com>
References: <20180421034530.GB24606@syl.local>
 <cover.1525488108.git.me@ttaylorr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1525488108.git.me@ttaylorr.com>
User-Agent: Mutt/1.9.5 (2018-04-13)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Teach 'git-grep(1)' a new option, '--column', to show the column
number of the first match on a non-context line.

For example:

  $ git grep -n --column foo | head -n3
  .clang-format:51:14:# myFunction(foo, bar, baz);
  .clang-format:64:7:# int foo();
  .clang-format:75:8:# void foo()

Signed-off-by: Taylor Blau <me@ttaylorr.com>
---
 Documentation/git-grep.txt |  5 ++++-
 builtin/grep.c             |  1 +
 t/t7810-grep.sh            | 22 ++++++++++++++++++++++
 3 files changed, 27 insertions(+), 1 deletion(-)

diff --git a/Documentation/git-grep.txt b/Documentation/git-grep.txt
index 18b494731f..5409a24399 100644
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
@@ -169,6 +169,9 @@ providing this option will cause it to die.
 --line-number::
 	Prefix the line number to matching lines.
 
+--column::
+	Prefix the 1-indexed column number of the first match on non-context lines.
+
 -l::
 --files-with-matches::
 --name-only::
diff --git a/builtin/grep.c b/builtin/grep.c
index 5f32d2ce84..5c83f17759 100644
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
diff --git a/t/t7810-grep.sh b/t/t7810-grep.sh
index 1797f632a3..a03c3416e7 100755
--- a/t/t7810-grep.sh
+++ b/t/t7810-grep.sh
@@ -99,6 +99,28 @@ do
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
+	test_expect_success "grep -w $L (with --{line,column}-number)" '
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
2.17.0

