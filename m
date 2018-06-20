Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIMWL_WL_MED shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id AC3AB1F403
	for <e@80x24.org>; Wed, 20 Jun 2018 20:05:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932998AbeFTUFv (ORCPT <rfc822;e@80x24.org>);
        Wed, 20 Jun 2018 16:05:51 -0400
Received: from mail-oi0-f68.google.com ([209.85.218.68]:36032 "EHLO
        mail-oi0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932978AbeFTUFr (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 20 Jun 2018 16:05:47 -0400
Received: by mail-oi0-f68.google.com with SMTP id 14-v6so763117oie.3
        for <git@vger.kernel.org>; Wed, 20 Jun 2018 13:05:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=nDot6NiRfxRnTMtOpD8zVMwcdD6vzBgF91VLY/tcAC4=;
        b=gKsJ6QEfkAR2wWw4h8j3hEiFWK+bJRMyqblRDVYikNOEncwhccun0Qj3ZCj/kwFB9c
         GId+O6LhXxwJz6fVfMOGc54VygtkaCrP+ETXzxS+dTdP8t6YG6KPB90lSS5RaAB4NFj4
         FSS3SJdpy59CRarlkTSn+jhvYawvLNZrn3F4SJuiz8+fwSpriqC9Hi8A3bEbttE/B0y8
         QXLC0F0ks+K43Obj3iYFbTOKunmzEn7cAT4G96MlRBxxVGx9mXhJNqf4poo1lejdDsuV
         VZC3ugs52cJema6/KM+qJSMU49O0/ci4qwLCadPMvh3l1pwFx+yWBqKjFvuR4pkcV9Az
         DlkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=nDot6NiRfxRnTMtOpD8zVMwcdD6vzBgF91VLY/tcAC4=;
        b=CnYlYxCODmw5pjLPoPR833L+ee55uS+raZFluhqJzyxxkljhJ0K4BbCepIxFX2Q5wE
         Z0Vdo9HDIUQXwyFPXJDD6Ggu9gF3bfwX9SGJlXgcFtcZ9KBLV/UEdNjGdt9A4Mc8iuof
         axM/hC+SwQvfpV8IVgyELnskW4Y9+Xxm72OlPB7ie/d1ALnal5D7380CkVJ56xmad4Yy
         HFsj2qRpN2A/JntAJoafswt5fAI/Ti64uTQE7AKgV1MvQyraeyUz2tOcV5dbl5ZziN7B
         aV0LjhPIG4yv4O95jmQBrnq6HryfLaHOHueukBQrsU8CK3rOm1XDFaYtAxXu2CpPVGsv
         vzmA==
X-Gm-Message-State: APt69E1A19+3fHFiVKZ5y7ldY+FttpmtDaoD6YesRNIjffwQUXl3a8ay
        UGNx6H+bK1gdkOqQEBsmOwpTG+0655E=
X-Google-Smtp-Source: ADUXVKKjFJw1mopfmuN8Hn8rT7nDISKu6DH9CBTx0USdUc4E7xqHZf7FihZ+7uv70K/QBs1a4quZ2A==
X-Received: by 2002:aca:d886:: with SMTP id p128-v6mr13527635oig.180.1529525146708;
        Wed, 20 Jun 2018 13:05:46 -0700 (PDT)
Received: from localhost ([107.217.158.181])
        by smtp.gmail.com with ESMTPSA id a14-v6sm1371959oia.20.2018.06.20.13.05.45
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 20 Jun 2018 13:05:45 -0700 (PDT)
Date:   Wed, 20 Jun 2018 15:05:44 -0500
From:   Taylor Blau <me@ttaylorr.com>
To:     git@vger.kernel.org
Cc:     avarab@gmail.com, peff@peff.net, gitster@pobox.com
Subject: [PATCH v2 5/7] builtin/grep.c: add '--column' option to 'git-grep(1)'
Message-ID: <ed1c197cc2cdbcfe7fce14747b8601d1488f89a9.1529524852.git.me@ttaylorr.com>
References: <cover.1529365072.git.me@ttaylorr.com>
 <cover.1529524852.git.me@ttaylorr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1529524852.git.me@ttaylorr.com>
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
 Documentation/git-grep.txt |  6 ++-
 builtin/grep.c             |  1 +
 t/t7810-grep.sh            | 84 ++++++++++++++++++++++++++++++++++++++
 3 files changed, 90 insertions(+), 1 deletion(-)

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
index 1797f632a3..bf0b572dab 100755
--- a/t/t7810-grep.sh
+++ b/t/t7810-grep.sh
@@ -99,6 +99,90 @@ do
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
+	test_expect_success "grep $L (with --column, double-negation)" '
+		{
+			echo ${HC}file:1:foo_mmap bar mmap baz
+		} >expected &&
+		git grep --column --not \( --not -e foo --or --not -e baz \) $H -- file \
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
+	test_expect_success "grep -w $L (with non-extended patterns, --column)" '
+		{
+			echo ${HC}file:5:foo mmap bar
+			echo ${HC}file:10:foo_mmap bar
+			echo ${HC}file:10:foo_mmap bar mmap
+			echo ${HC}file:5:foo mmap bar_mmap
+			echo ${HC}file:10:foo_mmap bar mmap baz
+		} >expected &&
+		git grep --column -w -e bar -e mmap $H >actual &&
+		test_cmp expected actual
+	'
+
 	test_expect_success "grep -w $L" '
 		{
 			echo ${HC}file:1:foo mmap bar
-- 
2.17.0.582.gccdcbd54c

