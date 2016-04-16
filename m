From: Michael Rappazzo <rappazzo@gmail.com>
Subject: [PATCH v2 2/2] t1500-rev-parse: rewrite each test to run in isolation
Date: Sat, 16 Apr 2016 12:13:50 -0400
Message-ID: <1460823230-45692-3-git-send-email-rappazzo@gmail.com>
References: <1460823230-45692-1-git-send-email-rappazzo@gmail.com>
Cc: gitster@pobox.com, sunshine@sunshineco.com, pclouds@gmail.com,
	szeder@ira.uka.de, peff@peff.net,
	Michael Rappazzo <rappazzo@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Apr 16 18:14:09 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1arSrI-0003qV-6L
	for gcvg-git-2@plane.gmane.org; Sat, 16 Apr 2016 18:14:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751798AbcDPQOF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 16 Apr 2016 12:14:05 -0400
Received: from mail-qk0-f196.google.com ([209.85.220.196]:35077 "EHLO
	mail-qk0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751771AbcDPQOD (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 16 Apr 2016 12:14:03 -0400
Received: by mail-qk0-f196.google.com with SMTP id u190so5731983qkh.2
        for <git@vger.kernel.org>; Sat, 16 Apr 2016 09:14:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=+wz2bVbM+9LGXv7iRdqPpzeJQcYQGScoQg6NDcifHpo=;
        b=kB0lQ22c37q47br9X8a3RIUT3jQpqDVk+DHKUadOFG1OftpdvKsO73PCtDsGeI9IDx
         cMMVyA7UDCRGrK5PlyCI2NDLDkb2gQ0RXMsQSEZ9fDS3gNP9ERDh5H4llTl5CLlaFgEp
         TwDgZT8fbWHUQDHLqOmredzOYwdtsMLIzBYnsmSqc0e1wKTSvVS4CJKBiTQ79bfOJYC6
         BbkgA4izmzPzcUZWolJkva4FjTtD9e7GzQjYxU4wS85r8fBF7plmVGYiiotO030Zr+sG
         qu7Elt0P1K1V1d0yvUXuF6PMphjhWCYAwvah8dOXvoYD7K/A35jWgL/NPd7C0Q58cfDj
         g8jg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=+wz2bVbM+9LGXv7iRdqPpzeJQcYQGScoQg6NDcifHpo=;
        b=e+DSCVKo6VcKo88ZX0ZHdlkhSOiA3b6DO9DdcMpwSUwp66Mc4yK5rIkCW/vLLe73BL
         jaz3t27DI8KUfCzqhcW10BwrMOWwyPm6wnz3p7ZdqQ/eVlacRWZCZrCDSFlb/aEVsWrV
         9/bILGa8Vr8VNrKUMkoGzKRKB5G3K9W+6zBI+GiePFZQjO8wW/Tzta5YmDJ59yRhzuFN
         +2Q7NMZnx4yu+AJMrnc8Hb9Xl23deGBq+TIg53Uaj5yBeSNChCuJkzLWmwnw0cZpaVC7
         USqtSv7Uujs82gvhhF+iYTTTvcHQeDLEZ25n5/l1Fxi9B0dznxgsiPNsNghZabGIt8Yk
         2fXw==
X-Gm-Message-State: AOPr4FVY4DZH74ngEniwwnDf7PdJTBIjWKttFXSMmep5AkzaOdk0QCCCOPokMkaXuXyTzw==
X-Received: by 10.55.10.77 with SMTP id 74mr26223264qkk.4.1460823241899;
        Sat, 16 Apr 2016 09:14:01 -0700 (PDT)
Received: from MRappazzo-8.local.info (pool-100-35-125-216.nwrknj.fios.verizon.net. [100.35.125.216])
        by smtp.gmail.com with ESMTPSA id w69sm22643384qhw.3.2016.04.16.09.14.00
        (version=TLS1 cipher=AES128-SHA bits=128/128);
        Sat, 16 Apr 2016 09:14:01 -0700 (PDT)
X-Mailer: git-send-email 2.8.0
In-Reply-To: <1460823230-45692-1-git-send-email-rappazzo@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/291731>

t1500-rev-parse has many tests which change directories and leak
environment variables.  This makes it difficult to add new tests without
minding the environment variables and current directory.

Each test is now setup, executed, and cleaned up without leaving anything
behind.  Test comparisons been converted to use test_cmp or test_stdout.

Signed-off-by: Michael Rappazzo <rappazzo@gmail.com>
---
 t/t1500-rev-parse.sh | 355 ++++++++++++++++++++++++++++++++++++++++++---------
 1 file changed, 295 insertions(+), 60 deletions(-)

diff --git a/t/t1500-rev-parse.sh b/t/t1500-rev-parse.sh
index 48ee077..e2c2a06 100755
--- a/t/t1500-rev-parse.sh
+++ b/t/t1500-rev-parse.sh
@@ -3,85 +3,320 @@
 test_description='test git rev-parse'
 . ./test-lib.sh
 
-test_rev_parse() {
-	name=$1
-	shift
+test_expect_success 'toplevel: is-bare-repository' '
+	test_stdout false git rev-parse --is-bare-repository
+'
 
-	test_expect_success "$name: is-bare-repository" \
-	"test '$1' = \"\$(git rev-parse --is-bare-repository)\""
-	shift
-	[ $# -eq 0 ] && return
+test_expect_success 'toplevel: is-inside-git-dir' '
+	test_stdout false git rev-parse --is-inside-git-dir
+'
 
-	test_expect_success "$name: is-inside-git-dir" \
-	"test '$1' = \"\$(git rev-parse --is-inside-git-dir)\""
-	shift
-	[ $# -eq 0 ] && return
+test_expect_success 'toplevel: is-inside-work-tree' '
+	test_stdout true git rev-parse --is-inside-work-tree
+'
 
-	test_expect_success "$name: is-inside-work-tree" \
-	"test '$1' = \"\$(git rev-parse --is-inside-work-tree)\""
-	shift
-	[ $# -eq 0 ] && return
+test_expect_success 'toplevel: prefix' '
+	test_stdout "" git rev-parse --show-prefix
+'
 
-	test_expect_success "$name: prefix" \
-	"test '$1' = \"\$(git rev-parse --show-prefix)\""
-	shift
-	[ $# -eq 0 ] && return
+test_expect_success 'toplevel: git-dir' '
+	test_stdout .git git rev-parse --git-dir
+'
 
-	test_expect_success "$name: git-dir" \
-	"test '$1' = \"\$(git rev-parse --git-dir)\""
-	shift
-	[ $# -eq 0 ] && return
-}
+test_expect_success '.git/: is-bare-repository' '
+	test_stdout false git -C .git rev-parse --is-bare-repository
+'
 
-# label is-bare is-inside-git is-inside-work prefix git-dir
+test_expect_success '.git/: is-inside-git-dir' '
+	test_stdout true git -C .git rev-parse --is-inside-git-dir
+'
 
-ROOT=$(pwd)
+test_expect_success '.git/: is-inside-work-tree' '
+	test_stdout false git -C .git rev-parse --is-inside-work-tree
+'
 
-test_rev_parse toplevel false false true '' .git
+test_expect_success '.git/: prefix' '
+	test_stdout "" git -C .git rev-parse --show-prefix
+'
 
-cd .git || exit 1
-test_rev_parse .git/ false true false '' .
-cd objects || exit 1
-test_rev_parse .git/objects/ false true false '' "$ROOT/.git"
-cd ../.. || exit 1
+test_expect_success '.git/: git-dir' '
+	test_stdout . git -C .git rev-parse --git-dir
+'
 
-mkdir -p sub/dir || exit 1
-cd sub/dir || exit 1
-test_rev_parse subdirectory false false true sub/dir/ "$ROOT/.git"
-cd ../.. || exit 1
+test_expect_success '.git/objects/: is-bare-repository' '
+	test_stdout false git -C .git/objects rev-parse --is-bare-repository
+'
 
-git config core.bare true
-test_rev_parse 'core.bare = true' true false false
+test_expect_success '.git/objects/: is-inside-git-dir' '
+	test_stdout true git -C .git/objects rev-parse --is-inside-git-dir
+'
 
-git config --unset core.bare
-test_rev_parse 'core.bare undefined' false false true
+test_expect_success '.git/objects/: is-inside-work-tree' '
+	test_stdout false git -C .git/objects rev-parse --is-inside-work-tree
+'
 
-mkdir work || exit 1
-cd work || exit 1
-GIT_DIR=../.git
-GIT_CONFIG="$(pwd)"/../.git/config
-export GIT_DIR GIT_CONFIG
+test_expect_success '.git/objects/: prefix' '
+	test_stdout "" git -C .git/objects rev-parse --show-prefix
+'
 
-git config core.bare false
-test_rev_parse 'GIT_DIR=../.git, core.bare = false' false false true ''
+test_expect_success '.git/objects/: git-dir' '
+	echo $(pwd)/.git >expect &&
+	git -C .git/objects rev-parse --git-dir >actual &&
+	test_cmp expect actual
+'
 
-git config core.bare true
-test_rev_parse 'GIT_DIR=../.git, core.bare = true' true false false ''
+test_expect_success 'subdirectory: is-bare-repository' '
+	mkdir -p sub/dir &&
+	test_when_finished "rm -rf sub" &&
+	test_stdout false git -C sub/dir rev-parse --is-bare-repository
+'
 
-git config --unset core.bare
-test_rev_parse 'GIT_DIR=../.git, core.bare undefined' false false true ''
+test_expect_success 'subdirectory: is-inside-git-dir' '
+	mkdir -p sub/dir &&
+	test_when_finished "rm -rf sub" &&
+	test_stdout false git -C sub/dir rev-parse --is-inside-git-dir
+'
 
-mv ../.git ../repo.git || exit 1
-GIT_DIR=../repo.git
-GIT_CONFIG="$(pwd)"/../repo.git/config
+test_expect_success 'subdirectory: is-inside-work-tree' '
+	mkdir -p sub/dir &&
+	test_when_finished "rm -rf sub" &&
+	test_stdout true git -C sub/dir rev-parse --is-inside-work-tree
+'
 
-git config core.bare false
-test_rev_parse 'GIT_DIR=../repo.git, core.bare = false' false false true ''
+test_expect_success 'subdirectory: prefix' '
+	mkdir -p sub/dir &&
+	test_when_finished "rm -rf sub" &&
+	test sub/dir/ = "$(git -C sub/dir rev-parse --show-prefix)"
+'
 
-git config core.bare true
-test_rev_parse 'GIT_DIR=../repo.git, core.bare = true' true false false ''
+test_expect_success 'subdirectory: git-dir' '
+	mkdir -p sub/dir &&
+	test_when_finished "rm -rf sub" &&
+	echo $(pwd)/.git >expect &&
+	git -C sub/dir rev-parse --git-dir >actual &&
+	test_cmp expect actual
+'
 
-git config --unset core.bare
-test_rev_parse 'GIT_DIR=../repo.git, core.bare undefined' false false true ''
+test_expect_success 'core.bare = true: is-bare-repository' '
+	test_config core.bare true &&
+	test_stdout true git rev-parse --is-bare-repository
+'
+
+test_expect_success 'core.bare = true: is-inside-git-dir' '
+	test_config core.bare true &&
+	test_stdout false git rev-parse --is-inside-git-dir
+'
+
+test_expect_success 'core.bare = true: is-inside-work-tree' '
+	test_config core.bare true &&
+	test_stdout false git rev-parse --is-inside-work-tree
+'
+
+test_expect_success 'core.bare undefined: is-bare-repository' '
+	test_config core.bare "" &&
+	test_stdout false git rev-parse --is-bare-repository
+'
+
+test_expect_success 'core.bare undefined: is-inside-git-dir' '
+	test_config core.bare "" &&
+	test_stdout false git rev-parse --is-inside-git-dir
+'
+
+test_expect_success 'core.bare undefined: is-inside-work-tree' '
+	test_config core.bare "" &&
+	test_stdout true git rev-parse --is-inside-work-tree
+'
+
+test_expect_success 'GIT_DIR=../.git, core.bare = false: is-bare-repository' '
+	mkdir work &&
+	test_when_finished "rm -rf work" &&
+	test_config -C "$(pwd)"/.git core.bare false &&
+	GIT_DIR=../.git test_stdout false git -C work rev-parse --is-bare-repository
+'
+
+test_expect_success 'GIT_DIR=../.git, core.bare = false: is-inside-git-dir' '
+	mkdir work &&
+	test_when_finished "rm -rf work" &&
+	test_config -C "$(pwd)"/.git core.bare false &&
+	GIT_DIR=../.git test_stdout false git -C work rev-parse --is-inside-git-dir
+'
+
+test_expect_success 'GIT_DIR=../.git, core.bare = false: is-inside-work-tree' '
+	mkdir work &&
+	test_when_finished "rm -rf work" &&
+	test_config -C "$(pwd)"/.git core.bare false &&
+	GIT_DIR=../.git test_stdout true git -C work rev-parse --is-inside-work-tree
+'
+
+test_expect_success 'GIT_DIR=../.git, core.bare = false: prefix' '
+	mkdir work &&
+	test_when_finished "rm -rf work" &&
+	test_config -C "$(pwd)"/.git core.bare false &&
+	GIT_DIR=../.git test_stdout "" git -C work rev-parse --show-prefix >actual
+'
+
+test_expect_success 'GIT_DIR=../.git, core.bare = true: is-bare-repository' '
+	mkdir work &&
+	test_when_finished "rm -rf work" &&
+	test_config -C "$(pwd)"/.git core.bare true &&
+	GIT_DIR=../.git test_stdout true git -C work rev-parse --is-bare-repository
+'
+
+test_expect_success 'GIT_DIR=../.git, core.bare = true: is-inside-git-dir' '
+	mkdir work &&
+	test_when_finished "rm -rf work" &&
+	test_config -C "$(pwd)"/.git core.bare true &&
+	GIT_DIR=../.git test_stdout false git -C work rev-parse --is-inside-git-dir
+'
+
+test_expect_success 'GIT_DIR=../.git, core.bare = true: is-inside-work-tree' '
+	mkdir work &&
+	test_when_finished "rm -rf work" &&
+	test_config -C "$(pwd)"/.git core.bare true &&
+	GIT_DIR=../.git test_stdout false git -C work rev-parse --is-inside-work-tree
+'
+
+test_expect_success 'GIT_DIR=../.git, core.bare = true: prefix' '
+	mkdir work &&
+	test_when_finished "rm -rf work" &&
+	test_config -C "$(pwd)"/.git core.bare true &&
+	GIT_DIR=../.git test_stdout "" git -C work rev-parse --show-prefix
+'
+
+test_expect_success 'GIT_DIR=../.git, core.bare undefined: is-bare-repository' '
+	mkdir work &&
+	test_when_finished "rm -rf work" &&
+	test_config -C "$(pwd)"/.git core.bar = &&
+	GIT_DIR=../.git test_stdout false git -C work rev-parse --is-bare-repository
+'
+
+test_expect_success 'GIT_DIR=../.git, core.bare undefined: is-inside-git-dir' '
+	mkdir work &&
+	test_when_finished "rm -rf work" &&
+	test_config -C "$(pwd)"/.git core.bar = &&
+	GIT_DIR=../.git test_stdout false git -C work rev-parse --is-inside-git-dir
+'
+
+test_expect_success 'GIT_DIR=../.git, core.bare undefined: is-inside-work-tree' '
+	mkdir work &&
+	test_when_finished "rm -rf work" &&
+	test_config -C "$(pwd)"/.git core.bar = &&
+	GIT_DIR=../.git test_stdout true git -C work rev-parse --is-inside-work-tree
+'
+
+test_expect_success 'GIT_DIR=../.git, core.bare undefined: prefix' '
+	mkdir work &&
+	test_when_finished "rm -rf work" &&
+	test_config -C "$(pwd)"/.git core.bar = &&
+	GIT_DIR=../.git test_stdout "" git -C work rev-parse --show-prefix
+'
+
+test_expect_success 'GIT_DIR=../repo.git, core.bare = false: is-bare-repository' '
+	mkdir work &&
+	test_when_finished "rm -rf work" &&
+	cp -r .git repo.git &&
+	test_when_finished "rm -r repo.git" &&
+	test_config -C "$(pwd)"/repo.git core.bare false &&
+	GIT_DIR=../repo.git test_stdout false git -C work rev-parse --is-bare-repository
+'
+
+test_expect_success 'GIT_DIR=../repo.git, core.bare = false: is-inside-git-dir' '
+	mkdir work &&
+	test_when_finished "rm -rf work" &&
+	cp -r .git repo.git &&
+	test_when_finished "rm -r repo.git" &&
+	test_config -C "$(pwd)"/repo.git core.bare false &&
+	GIT_DIR=../repo.git test_stdout false git -C work rev-parse --is-inside-git-dir
+'
+
+test_expect_success 'GIT_DIR=../repo.git, core.bare = false: is-inside-work-tree' '
+	mkdir work &&
+	test_when_finished "rm -rf work" &&
+	cp -r .git repo.git &&
+	test_when_finished "rm -r repo.git" &&
+	test_config -C "$(pwd)"/repo.git core.bare false &&
+	GIT_DIR=../repo.git test_stdout true git -C work rev-parse --is-inside-work-tree
+'
+
+test_expect_success 'GIT_DIR=../repo.git, core.bare = false: prefix' '
+	mkdir work &&
+	test_when_finished "rm -rf work" &&
+	cp -r .git repo.git &&
+	test_when_finished "rm -r repo.git" &&
+	test_config -C "$(pwd)"/repo.git core.bare false &&
+	GIT_DIR=../repo.git test_stdout "" git -C work rev-parse --show-prefix
+'
+
+test_expect_success 'GIT_DIR=../repo.git, core.bare = true: is-bare-repository' '
+	mkdir work &&
+	test_when_finished "rm -rf work" &&
+	cp -r .git repo.git &&
+	test_when_finished "rm -r repo.git" &&
+	test_config -C "$(pwd)"/repo.git core.bare true &&
+	GIT_DIR=../repo.git test_stdout true git -C work rev-parse --is-bare-repository
+'
+
+test_expect_success 'GIT_DIR=../repo.git, core.bare = true: is-inside-git-dir' '
+	mkdir work &&
+	test_when_finished "rm -rf work" &&
+	cp -r .git repo.git &&
+	test_when_finished "rm -r repo.git" &&
+	test_config -C "$(pwd)"/repo.git core.bare true &&
+	GIT_DIR=../repo.git test_stdout false git -C work rev-parse --is-inside-git-dir
+'
+
+test_expect_success 'GIT_DIR=../repo.git, core.bare = true: is-inside-work-tree' '
+	mkdir work &&
+	test_when_finished "rm -rf work" &&
+	cp -r .git repo.git &&
+	test_when_finished "rm -r repo.git" &&
+	test_config -C "$(pwd)"/repo.git core.bare true &&
+	GIT_DIR=../repo.git test_stdout false git -C work rev-parse --is-inside-work-tree
+'
+
+test_expect_success 'GIT_DIR=../repo.git, core.bare = true: prefix' '
+	mkdir work &&
+	test_when_finished "rm -rf work" &&
+	cp -r .git repo.git &&
+	test_when_finished "rm -r repo.git" &&
+	test_config -C "$(pwd)"/repo.git core.bare true &&
+	GIT_DIR=../repo.git test_stdout "" git -C work rev-parse --show-prefix
+'
+
+test_expect_success 'GIT_DIR=../repo.git, core.bare undefined: is-bare-repository' '
+	mkdir work &&
+	test_when_finished "rm -rf work" &&
+	cp -r .git repo.git &&
+	test_when_finished "rm -r repo.git" &&
+	test_config -C "$(pwd)"/repo.git core.bare "" &&
+	GIT_DIR=../repo.git test_stdout false git -C work rev-parse --is-bare-repository
+'
+
+test_expect_success 'GIT_DIR=../repo.git, core.bare undefined: is-inside-git-dir' '
+	mkdir work &&
+	test_when_finished "rm -rf work" &&
+	cp -r .git repo.git &&
+	test_when_finished "rm -r repo.git" &&
+	test_config -C "$(pwd)"/repo.git core.bare "" &&
+	GIT_DIR=../repo.git test_stdout false git -C work rev-parse --is-inside-git-dir
+'
+
+test_expect_success 'GIT_DIR=../repo.git, core.bare undefined: is-inside-work-tree' '
+	mkdir work &&
+	test_when_finished "rm -rf work" &&
+	cp -r .git repo.git &&
+	test_when_finished "rm -r repo.git" &&
+	test_config -C "$(pwd)"/repo.git core.bare "" &&
+	GIT_DIR=../repo.git test_stdout true git -C work rev-parse --is-inside-work-tree
+'
+
+test_expect_success 'GIT_DIR=../repo.git, core.bare undefined: prefix' '
+	mkdir work &&
+	test_when_finished "rm -rf work" &&
+	cp -r .git repo.git &&
+	test_when_finished "rm -r repo.git" &&
+	test_config -C "$(pwd)"/repo.git core.bare "" &&
+	GIT_DIR=../repo.git test_stdout "" git -C work rev-parse --show-prefix
+'
 
 test_done
-- 
2.8.0
