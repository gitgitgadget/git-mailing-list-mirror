Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIMWL_WL_MED shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E36A71F424
	for <e@80x24.org>; Tue, 24 Apr 2018 05:08:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755883AbeDXFID (ORCPT <rfc822;e@80x24.org>);
        Tue, 24 Apr 2018 01:08:03 -0400
Received: from mail-pg0-f68.google.com ([74.125.83.68]:33407 "EHLO
        mail-pg0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755709AbeDXFHt (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 24 Apr 2018 01:07:49 -0400
Received: by mail-pg0-f68.google.com with SMTP id i194so9969419pgd.0
        for <git@vger.kernel.org>; Mon, 23 Apr 2018 22:07:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=b9XsBX040sMfZNhDS2n8KEvZcKP6PMy/OsYG8fWAJoo=;
        b=XVxynM3qeFiOg5ND1b9iEP0jaGZ7b+GjmO4NYxN6RZuapq6zGdj/Xm6a2ZTGEMtNfv
         +5seSlM+saQK+AVFw+1zMrJzDcxcl+BiLNPAYrSJdUHfQlPL0Y0Fzd30llJpwZ565dft
         cs6Qz0voZFwXDeAs/4ll9dOheDmEJNMsPsZ1ipvHdCMuitOaVzlUmg6HuNO/O3CedCkV
         xPeooy6hyikX9yMzd8PGGIIgWC+v25bTi8hjXYne8WjCTFKfxlRXuIRcOdMLe1csX2GN
         cDWiv7WNxQ1SUkDr+D2zNwOMhEyw9t7Y/L1pEHLWT+SJePtDBQoAqalnIoaguHhcTjCh
         Yf1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=b9XsBX040sMfZNhDS2n8KEvZcKP6PMy/OsYG8fWAJoo=;
        b=EVx/5Rf4a//jRG5Nf3LMyCOGLC7SEKDcO/hW/biKvV8aHqBhPQI+CZzxX0iRZAw52P
         McHzaCh8Y3NvrbkA2UV9Li4WaaNtPRlG3TsnhINfF1e5eWt/tX8vgunu0C+BOro4mK04
         MFQeRlaUVQsk2HKMvDFGwrdzvAnmMm5lTc2SgcqzsH60vGy6ieby4cnAIfAlIE6913vo
         0w2YbuR9RO5TyfwpQVeUZyce+r3Q0m/RKg3OIzQeZ6cq5NCM1ww0sIdYwTZdyirMSfDU
         UTk/x98I8kZRPDN5lsCWd7u2OH+0w4lFU3vw+81lrub8E/1KDmRZvPdm/F4RjVZDVmMm
         pvZw==
X-Gm-Message-State: ALQs6tBYJGdw9wmjv1e0qVJg52viID05MTzql0N1g8mFSHBNCb7PfKGC
        bPsw0lFl4g8Q83Zv9LdpuRlXivkOXTwtPw==
X-Google-Smtp-Source: AIpwx49cn/fdCETeO7yVcrBxYRL8/lGpOfN37ubBNmzzQ5V2QdjsSY1wTApfynDDJEtRqlquGyA/bw==
X-Received: by 10.99.62.201 with SMTP id l192mr18973227pga.318.1524546468292;
        Mon, 23 Apr 2018 22:07:48 -0700 (PDT)
Received: from localhost ([2601:602:9500:1120:3dfa:3e1b:ab89:1ffb])
        by smtp.gmail.com with ESMTPSA id t9sm28412925pgr.37.2018.04.23.22.07.46
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 23 Apr 2018 22:07:47 -0700 (PDT)
Date:   Mon, 23 Apr 2018 22:07:46 -0700
From:   Taylor Blau <me@ttaylorr.com>
To:     git@vger.kernel.org
Cc:     avarab@gmail.com, gitster@pobox.com, l.s.r@web.de,
        martin.agren@gmail.com, peff@peff.net, sunshine@sunshineco.com
Subject: [PATCH v3 5/7] builtin/grep.c: add '--column-number' option to
 'git-grep(1)'
Message-ID: <21857b3e647f3de0d23253c41fb9aaf9f614d323.1524545768.git.me@ttaylorr.com>
References: <20180421034530.GB24606@syl.local>
 <cover.1524545768.git.me@ttaylorr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1524545768.git.me@ttaylorr.com>
User-Agent: Mutt/1.9.5 (2018-04-13)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Teach 'git-grep(1)' a new option, '--column-number', to show the column
number of the first match on a non-context line.

For example:

  $ ./git-grep -n --column-number foo | head -n3
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
index 18b494731f..51dcfa5093 100644
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
@@ -169,6 +169,9 @@ providing this option will cause it to die.
 --line-number::
 	Prefix the line number to matching lines.
 
+--column-number::
+	Prefix the 1-indexed column number of the first match on non-context lines.
+
 -l::
 --files-with-matches::
 --name-only::
diff --git a/builtin/grep.c b/builtin/grep.c
index 5f32d2ce84..512f60c591 100644
--- a/builtin/grep.c
+++ b/builtin/grep.c
@@ -829,6 +829,7 @@ int cmd_grep(int argc, const char **argv, const char *prefix)
 			    GREP_PATTERN_TYPE_PCRE),
 		OPT_GROUP(""),
 		OPT_BOOL('n', "line-number", &opt.linenum, N_("show line numbers")),
+		OPT_BOOL(0, "column-number", &opt.columnnum, N_("show column number of first match")),
 		OPT_NEGBIT('h', NULL, &opt.pathname, N_("don't show filenames"), 1),
 		OPT_BIT('H', NULL, &opt.pathname, N_("show filenames"), 1),
 		OPT_NEGBIT(0, "full-name", &opt.relative,
diff --git a/t/t7810-grep.sh b/t/t7810-grep.sh
index 1797f632a3..bbce57c8b1 100755
--- a/t/t7810-grep.sh
+++ b/t/t7810-grep.sh
@@ -99,6 +99,28 @@ do
 		test_cmp expected actual
 	'
 
+	test_expect_success "grep -w $L (with --column-number)" '
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
+	test_expect_success "grep -w $L (with --{line,column}-number)" '
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

