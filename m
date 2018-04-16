Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E81461F404
	for <e@80x24.org>; Mon, 16 Apr 2018 22:42:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753060AbeDPWmx (ORCPT <rfc822;e@80x24.org>);
        Mon, 16 Apr 2018 18:42:53 -0400
Received: from mail-wr0-f195.google.com ([209.85.128.195]:37955 "EHLO
        mail-wr0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753050AbeDPWmt (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 16 Apr 2018 18:42:49 -0400
Received: by mail-wr0-f195.google.com with SMTP id h3so17632618wrh.5
        for <git@vger.kernel.org>; Mon, 16 Apr 2018 15:42:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=rMr2FAce+eSdFuNJf2c72GaC0y/sInc0+S0CstjxB3M=;
        b=tneOmhE+pVdjj8rUgA4p4G0fvxQMAwBWL6tSBIqCIe4MeuxhgjAITXvxnrB7u5wrCI
         sfQZsROFgwojGA7N2ZB5Um1pyhWhlcRYiGpY0720dTBuFYlmOaz9aRXaDLiPspORpBEL
         AFseq+RA4SP8KZKiYRuypwUHhu0DCpPhph+eB8iZbeI5DUT2Pj82VrbzkC5ZAs0vPYgE
         EbUMWzCJ9XfIrLCj3z2/11iXN9a4uJWZKZxV0USh2vdvkp/Y/zRmF9l+o+cei+0Ugmyc
         vBVpuOmP5y3RyZa7GTuv2BcAwr7+VyV7thkfoOkvQvTQbKlygf53Y7pzHE3hhhhQ4nzr
         DqyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=rMr2FAce+eSdFuNJf2c72GaC0y/sInc0+S0CstjxB3M=;
        b=qY451TmheggoRBwgKQPn+UddLjnadkPPJehwMFhLRjh/TX8/wIufCbDTcRgKdEJZ9W
         VGJMi2HmqJwDxhbg/qRoAq1fxZtqsVwP8Txn7S4CrEE/gQZeG86jA8CHj6Ov8z+B+F24
         x/ZBq/U6qHoLTJoOWfHwZ10c/DbKcYByWkbS7nL363NJVjLSBHh+TcCN51I8DjKE4t4M
         2PYO9bkL9X5xYIca1Lv8EWu58SrWdnM+adIb5bfx5Ws5afGtbvgM8R77PL6FaAouAstH
         YbRb7kK2cjRgMZhI3V5wRXr89tvazMzOoL2b7H9AwSG7GU2nRcMtYfzU6znl92TCin7c
         uFhw==
X-Gm-Message-State: ALQs6tDgKWgRYgzvPSTTQqWmjofByi+8kXtWSL4rjL15JuvkgVX711uF
        9Lr9DUWTK4ubXdX4kRLHVwiPZA==
X-Google-Smtp-Source: AIpwx4/ATBfSnqatzoKVXdA5wmCLNqk2tejBtFfEU9ld1ksRr/qTzCfjuyYllhSs+0sFuDh/Sis6nw==
X-Received: by 10.223.157.65 with SMTP id o1mr11541531wre.14.1523918567764;
        Mon, 16 Apr 2018 15:42:47 -0700 (PDT)
Received: from localhost.localdomain (x590d89db.dyn.telefonica.de. [89.13.137.219])
        by smtp.gmail.com with ESMTPSA id e10sm23413937wri.23.2018.04.16.15.42.46
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 16 Apr 2018 15:42:47 -0700 (PDT)
From:   =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Clemens Buchacher <drizzd@gmx.net>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Manlio Perillo <manlio.perillo@gmail.com>,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
Subject: [PATCH 10/11] completion: improve handling quoted paths in 'git ls-files's output
Date:   Tue, 17 Apr 2018 00:42:35 +0200
Message-Id: <20180416224236.17078-1-szeder.dev@gmail.com>
X-Mailer: git-send-email 2.17.0.366.gbe216a3084
In-Reply-To: <20180416224113.16993-1-szeder.dev@gmail.com>
References: <20180416224113.16993-1-szeder.dev@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

If any pathname contains backslash, double quote, tab, newline, or any
control characters, 'git ls-files' and 'git diff-index' will enclose
that pathname in double quotes and escape those special characters
using C-style one-character escape sequences or \nnn octal values.
This prevents those files from being listed during git-aware path
completion, because due to the quoting they will never match the
current word to be completed.

Extend __git_index_files()'s 'awk' script to remove all that quoting
and escaping from unique path components, so even paths containing
(almost all) such special characters can be completed.

Paths containing newline characters are still an issue, though.  We
use newlines as separator character when filling the COMPREPLY array,
so a path with one or more newline will end up split to two or more
elements in COMPREPLY, basically breaking completion.  There is
nothing we can do about it without a significant performance hit, so
let's just ignore such paths for now.  As far as paths with newlines
are concerned, this isn't any different from the previous behavior,
because those paths were always omitted, though in the past they were
omitted because due to the quoting they didn't match the current word
to be completed.  Anyway, Bash's own filename completion (Meta-/) can
complete even those paths, if need be.

Note:

  - We don't dequote path components right away as they are coming in,
    because then we would have to dequote each directory name
    repeatedly, as many times as it appears in the input, i.e. as many
    times as the number of listed paths it contains.  Instead, we
    dequote them at the end, as we print unique path components.

  - Even when a directory name itself does not contain any special
    characters, it will still be quoted if any of its trailing path
    components do.  If a directory contains paths both with and
    without special characters, then the name of that directory will
    appear both quoted and unquoted in the output of 'git ls-files'
    and 'git diff-index'.  Consequently, we will add such a directory
    name to the deduplicating associative array twice: once quoted and
    once unquoted.

    This means that we have to be careful after dequoting a directory
    name, and only print it if we haven't seen the same directory name
    unquoted.

  - It would be wonderful if we could just pass '-z' to those git
    commands to output \0-separated unquoted paths, and use \0 as
    record separator in the 'awk' script processing their output...
    this patch would be so much simpler, almost trivial even.
    Unfortunately, however, POSIX and most 'awk' implementations don't
    support \0 as record separator (GNU awk does support it).

  - This patch makes the earlier change to list paths with
    'core.quotePath=false' basically redundant, because this could
    decode any \nnn-escaped non-ASCII character just fine, as well.
    However, I suspect that 'git ls-files' can deal with those
    non-ASCII characters faster than this updated 'awk' script; just
    in case someone is burdened with tons of pathnames containing
    non-ASCII characters.

Signed-off-by: SZEDER Gábor <szeder.dev@gmail.com>
---
 contrib/completion/git-completion.bash | 66 +++++++++++++++++++++++++-
 t/t9902-completion.sh                  | 17 ++++++-
 2 files changed, 79 insertions(+), 4 deletions(-)

diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
index 70bc75dfc7..e97d57024b 100644
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -459,8 +459,70 @@ __git_index_files ()
 		paths[$1] = 1
 	}
 	END {
-		for (p in paths)
-			print p
+		for (p in paths) {
+			if (substr(p, 1, 1) != "\"") {
+				# No special characters, easy!
+				print p
+				continue
+			}
+
+			# The path is quoted.
+			p = dequote(p)
+			if (p == "")
+				continue
+
+			# Even when a directory name itself does not contain
+			# any special characters, it will still be quoted if
+			# any of its (stripped) trailing path components do.
+			# Because of this we may have seen the same direcory
+			# both quoted and unquoted.
+			if (p in paths)
+				# We have seen the same directory unquoted,
+				# skip it.
+				continue
+			else
+				print p
+		}
+	}
+	function dequote(p,    bs_idx, out, esc, esc_idx, dec) {
+		# Skip opening double quote.
+		p = substr(p, 2)
+
+		# Interpret backslash escape sequences.
+		while ((bs_idx = index(p, "\\")) != 0) {
+			out = out substr(p, 1, bs_idx - 1)
+			esc = substr(p, bs_idx + 1, 1)
+			p = substr(p, bs_idx + 2)
+
+			if ((esc_idx = index("abtvfr\"\\", esc)) != 0) {
+				# C-style one-character escape sequence.
+				out = out substr("\a\b\t\v\f\r\"\\",
+						 esc_idx, 1)
+			} else if (esc == "n") {
+				# Uh-oh, a newline character.
+				# We cant reliably put a pathname
+				# containing a newline into COMPREPLY,
+				# and the newline would create a mess.
+				# Skip this path.
+				return ""
+			} else {
+				# Must be a \nnn octal value, then.
+				dec = esc             * 64 + \
+				      substr(p, 1, 1) * 8  + \
+				      substr(p, 2, 1)
+				out = out sprintf("%c", dec)
+				p = substr(p, 3)
+			}
+		}
+		# Drop closing double quote, if there is one.
+		# (There isnt any if this is a directory, as it was
+		# already stripped with the trailing path components.)
+		if (substr(p, length(p), 1) == "\"")
+			out = out substr(p, 1, length(p) - 1)
+		else
+			out = out p
+
+		return out
 	}'
 }
 
diff --git a/t/t9902-completion.sh b/t/t9902-completion.sh
index a747998d6c..b9879576ab 100755
--- a/t/t9902-completion.sh
+++ b/t/t9902-completion.sh
@@ -1527,7 +1527,7 @@ else
 	say "Your filesystem does not allow \\ and \" in filenames."
 	rm -rf 'New\Dir'
 fi
-test_expect_failure FUNNYNAMES_BS_DQ \
+test_expect_success FUNNYNAMES_BS_DQ \
     'complete files - C-style escapes in ls-files output' '
 	test_when_finished "rm -r \"New\\\\Dir\"" &&
 
@@ -1548,7 +1548,7 @@ else
 	say 'Your filesystem does not allow special separator characters (FS, GS, RS, US) in filenames.'
 	rm -rf $'New\034Special\035Dir'
 fi
-test_expect_failure FUNNYNAMES_SEPARATORS \
+test_expect_success FUNNYNAMES_SEPARATORS \
     'complete files - \nnn-escaped control characters in ls-files output' '
 	test_when_finished "rm -r '$'New\034Special\035Dir''" &&
 
@@ -1562,6 +1562,19 @@ test_expect_failure FUNNYNAMES_SEPARATORS \
 			"'$'New\034Special\035Dir/New\036Special\037File''"
 '
 
+test_expect_success FUNNYNAMES_BS_DQ \
+    'complete files - removing repeated quoted path components' '
+	test_when_finished rm -rf NewDir &&
+	mkdir NewDir &&    # A dirname which in itself would not be quoted ...
+	>NewDir/0-file &&
+	>NewDir/1\"file && # ... but here the file makes the dirname quoted ...
+	>NewDir/2-file &&
+	>NewDir/3\"file && # ... and here, too.
+
+	# Still, we should only list it once.
+	test_completion "git test-path-comp New" "NewDir"
+'
+
 
 test_expect_success "completion uses <cmd> completion for alias: !sh -c 'git <cmd> ...'" '
 	test_config alias.co "!sh -c '"'"'git checkout ...'"'"'" &&
-- 
2.17.0.366.gbe216a3084

