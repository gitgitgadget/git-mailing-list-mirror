Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIMWL_WL_MED shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C6FF31F516
	for <e@80x24.org>; Fri, 22 Jun 2018 15:49:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933963AbeFVPtu (ORCPT <rfc822;e@80x24.org>);
        Fri, 22 Jun 2018 11:49:50 -0400
Received: from mail-ot0-f196.google.com ([74.125.82.196]:33974 "EHLO
        mail-ot0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933762AbeFVPtu (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 22 Jun 2018 11:49:50 -0400
Received: by mail-ot0-f196.google.com with SMTP id r18-v6so8018392otk.1
        for <git@vger.kernel.org>; Fri, 22 Jun 2018 08:49:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=1cpVZ/FTnruVUY06k8HLj+kSkLcoIryspXiWpKlulgY=;
        b=rmpMe8X+u3xCODxcS6Dnlzojqs4/C6vmaITPfm3Pqi2se7iyHgfpgXE/nuqdwTbGof
         GDhS1aLHYkaZQWqtkyxrQkgiwwhAlv2czHyFqXgWt1Qsmlo/xZ5pFBaqVT0CP7mBj4Jo
         /3Fj4+BcAvgvVTZns2MtT7m8vFm9+GEaiIO2y5EnM22tgB63fNeGc+TsKXCv7RNbWRsV
         8kwqBbl/WD1lrVefafISLESf1VRN9rRK5yUpm/SKw7kAhbujlHNZ7Foc0DHmzMgCOn44
         60eJEWd8SHchC2SfAiwagHDodMB9TiCGKXYL8+XGmNu7eebujDjoF9MxaJLhQTssn9Ed
         bEUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=1cpVZ/FTnruVUY06k8HLj+kSkLcoIryspXiWpKlulgY=;
        b=X7zAY3U5Xwua95YJzpCnSBWxpy7VyXDbgK462vLUSM11G0bz9iUaTWJjrL5UTQbY+E
         7fsQunvjT2SZ6+0AA4xUexacXnbgQ5PUZgOyB49g6XtapErZ1kBxUieyhQAgD2IAxCZ9
         Zz6a8lFXgefRrbpka/U5KXN+pyi4B3wEX+JfD3Iwtu1babozq58Zo3veY7SjGhjFaYgY
         Zam+x/m7barIJ62tUEwOCM/bw8wVBqZ5AHhXrU2G5Sp3vu8krsCdtuZPLbk2QtHsH7GV
         vEyR1LMSQ3dWbdLsdQi2ezdMlBEFwPVdNNtplm6OIEISNLjVOl3nI3do8zlwIvpbvPtf
         VHcg==
X-Gm-Message-State: APt69E2D1RUM4lsZdAtPlbuWnlB4TPNCYz1vjrLswkvX8LoB0U3RMA2H
        SsH5rGSkbJi9+y/gKMGTFNPfysTOtoo=
X-Google-Smtp-Source: AAOMgpcrl1cS8ug6LNMpeZhKH4WiOTAIYqug9TfXyvKVcnpBSyVP+DgXVUakzVazYVFKgleFNT24uA==
X-Received: by 2002:a9d:f29:: with SMTP id 38-v6mr1356224ott.376.1529682588592;
        Fri, 22 Jun 2018 08:49:48 -0700 (PDT)
Received: from localhost ([107.217.158.181])
        by smtp.gmail.com with ESMTPSA id u13-v6sm3349023oiv.18.2018.06.22.08.49.46
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 22 Jun 2018 08:49:47 -0700 (PDT)
Date:   Fri, 22 Jun 2018 10:49:45 -0500
From:   Taylor Blau <me@ttaylorr.com>
To:     git@vger.kernel.org
Cc:     avarab@gmail.com, peff@peff.net, gitster@pobox.com
Subject: [PATCH v3 5/7] builtin/grep.c: add '--column' option to 'git-grep(1)'
Message-ID: <6d561ab546aff5d45d72039c928471c44a4672c8.1529682173.git.me@ttaylorr.com>
References: <cover.1529365072.git.me@ttaylorr.com>
 <cover.1529682173.git.me@ttaylorr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1529682173.git.me@ttaylorr.com>
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
 t/t7810-grep.sh            | 95 ++++++++++++++++++++++++++++++++++++++
 3 files changed, 101 insertions(+), 1 deletion(-)

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
index 1797f632a3..9312c8daf5 100755
--- a/t/t7810-grep.sh
+++ b/t/t7810-grep.sh
@@ -99,6 +99,101 @@ do
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
+	test_expect_success "grep -w $L (with --column, extended OR)" '
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
+	test_expect_success "grep $L (with --column, --invert, extended OR)" '
+		{
+			echo ${HC}hello_world:6:HeLLo_world
+		} >expected &&
+		git grep --column --invert -e ll --or --not -e _ $H -- hello_world \
+			>actual &&
+		test_cmp expected actual
+	'
+
+	test_expect_success "grep $L (with --column, --invert, extended AND)" '
+		{
+			echo ${HC}hello_world:3:Hello world
+			echo ${HC}hello_world:3:Hello_world
+			echo ${HC}hello_world:6:HeLLo_world
+		} >expected &&
+		git grep --column --invert --not -e _ --and --not -e ll $H -- hello_world \
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
2.18.0

