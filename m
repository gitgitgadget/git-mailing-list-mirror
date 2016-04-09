From: Michael Rappazzo <rappazzo@gmail.com>
Subject: [PATCH] t1500-rev-parse: rewrite each test to run in isolation
Date: Sat,  9 Apr 2016 07:19:27 -0400
Message-ID: <1460200767-32864-2-git-send-email-rappazzo@gmail.com>
References: <1460200767-32864-1-git-send-email-rappazzo@gmail.com>
Cc: gitster@pobox.com, sunshine@sunshineco.com, pclouds@gmail.com,
	szeder@ira.uka.de, Michael Rappazzo <rappazzo@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Apr 09 13:19:27 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aoqvG-0000Kn-03
	for gcvg-git-2@plane.gmane.org; Sat, 09 Apr 2016 13:19:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752844AbcDILTU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 9 Apr 2016 07:19:20 -0400
Received: from mail-qg0-f68.google.com ([209.85.192.68]:35279 "EHLO
	mail-qg0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752836AbcDILTT (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 9 Apr 2016 07:19:19 -0400
Received: by mail-qg0-f68.google.com with SMTP id b32so12165503qgf.2
        for <git@vger.kernel.org>; Sat, 09 Apr 2016 04:19:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=qCH0JpTMBWd1ZwmVJ61mpWkiUILZy4RkqagZz1Z3AHk=;
        b=UbarpuAaN8dydDgMvr4AnWxb2052DdZ4XP/KUafBf/Cq+r/e92DDmzJpWFRlLUx/nG
         FOZt5UvOgFcofLddObjhmo6J1F/WmLRjZstcRYkKRs90FzI7MjDqo6OJjvmTR/YkHonP
         zTlaRkYUoniPJCxHVwen8BqIivMt5veRl6NWm4/Rl+JM4AVBlQ8w2XOFBccVdbrIdEQy
         bQnGnrcKzcJqZFAs8U+0oH+GQ2ahLHw07OJmZB85Zvnpll0buRATiOKXJkAYNC1ARHq8
         vzgvt6He9xsm3pS+pX9L20QyQyMjv5H4CxA62TDfGVU4GG/1fZpqXG1mPoBHEZNZTk1G
         9eww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=qCH0JpTMBWd1ZwmVJ61mpWkiUILZy4RkqagZz1Z3AHk=;
        b=cI4NLkFBWuIFXcO1yBYfaPi7ZgLUkVg2EJs7D96IRezMwsNbOPpgx4WEIy4/QHVlDS
         TnRfXTFYAq9LiKm0Bb0RxpwXjm/cM1dBPZC5NMTb25FejxbKuUTDpYZw7AC21oIAIM05
         mpFDWlXsu29/smNpH2BR7j7qG3k/w9xbeNw/UuHdf/4BWF5GabR8Ulc24uJRQQEN4kIa
         22VmHu3CjQ/q6ufmcBRoYAzo3OBQkiJ+I8R73iEmTEETLGKqj2yHv54xq40trskvknET
         lDQQIslgYOFZ11DC6dqB/qUk9OneUiWJtLCy8eL7AcIEAdj5jwpcuj2oL3YWQEeSoNpb
         iuEw==
X-Gm-Message-State: AD7BkJIU2SCyWQ4qkFlQeVTGMZOqtG8dRUOJiDkiYqoKgeAQDdvFxePfyO3JHhMz9BhpVg==
X-Received: by 10.140.148.134 with SMTP id 128mr17893767qhu.98.1460200757576;
        Sat, 09 Apr 2016 04:19:17 -0700 (PDT)
Received: from MRappazzo-8.local.info (pool-100-35-125-216.nwrknj.fios.verizon.net. [100.35.125.216])
        by smtp.gmail.com with ESMTPSA id c32sm7245961qgf.36.2016.04.09.04.19.16
        (version=TLS1 cipher=AES128-SHA bits=128/128);
        Sat, 09 Apr 2016 04:19:16 -0700 (PDT)
X-Mailer: git-send-email 2.8.0
In-Reply-To: <1460200767-32864-1-git-send-email-rappazzo@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/291088>

t1500-rev-parse has many tests which change directories and leak
environment variables.  This makes it difficult to add new tests without
minding the environment variables and current directory.

Each test is now setup, executed, and cleaned up without leaving anything
behind.  Tests which have textual expectations have been converted to use
test_cmp (which will show a diff when the test is run with --verbose).

Signed-off-by: Michael Rappazzo <rappazzo@gmail.com>
---
 t/t1500-rev-parse.sh | 607 +++++++++++++++++++++++++++++++++++++++++++++------
 1 file changed, 545 insertions(+), 62 deletions(-)

diff --git a/t/t1500-rev-parse.sh b/t/t1500-rev-parse.sh
index 617fcd8..dffa9f3 100755
--- a/t/t1500-rev-parse.sh
+++ b/t/t1500-rev-parse.sh
@@ -3,88 +3,571 @@
 test_description='test git rev-parse'
 . ./test-lib.sh
 
-test_rev_parse() {
-	name=$1
-	shift
+test_expect_success 'toplevel: is-bare-repository' '
+	test false = "$(git rev-parse --is-bare-repository)"
+'
 
-	test_expect_success "$name: is-bare-repository" \
-	"test '$1' = \"\$(git rev-parse --is-bare-repository)\""
-	shift
-	[ $# -eq 0 ] && return
+test_expect_success 'toplevel: is-inside-git-dir' '
+	test false = "$(git rev-parse --is-inside-git-dir)"
+'
 
-	test_expect_success "$name: is-inside-git-dir" \
-	"test '$1' = \"\$(git rev-parse --is-inside-git-dir)\""
-	shift
-	[ $# -eq 0 ] && return
+test_expect_success 'toplevel: is-inside-work-tree' '
+	test true = "$(git rev-parse --is-inside-work-tree)"
+'
 
-	test_expect_success "$name: is-inside-work-tree" \
-	"test '$1' = \"\$(git rev-parse --is-inside-work-tree)\""
-	shift
-	[ $# -eq 0 ] && return
+test_expect_success 'toplevel: prefix' '
+	echo >expected &&
+	git rev-parse --show-prefix >actual &&
+	test_cmp expected actual
+'
 
-	test_expect_success "$name: prefix" \
-	"test '$1' = \"\$(git rev-parse --show-prefix)\""
-	shift
-	[ $# -eq 0 ] && return
+test_expect_success 'toplevel: git-dir' '
+	echo .git >expected &&
+	git rev-parse --git-dir >actual &&
+	test_cmp expected actual
+'
 
-	test_expect_success "$name: git-dir" \
-	"test '$1' = \"\$(git rev-parse --git-dir)\""
-	shift
-	[ $# -eq 0 ] && return
+test_expect_success 'toplevel: absolute-git-dir' '
+	echo "$(pwd)/.git" >expected &&
+	git rev-parse --absolute-git-dir >actual &&
+	test_cmp expected actual
+'
 
-	test_expect_success "$name: absolute-git-dir" \
-	"verbose test '$1' = \"\$(git rev-parse --absolute-git-dir)\""
-}
+test_expect_success '.git/: is-bare-repository' '
+	(cd .git && test false = "$(git rev-parse --is-bare-repository)")
+'
 
-# label is-bare is-inside-git is-inside-work prefix git-dir absolute-git-dir
+test_expect_success '.git/: is-inside-git-dir' '
+	(cd .git && test true = "$(git rev-parse --is-inside-git-dir)")
+'
 
-ROOT=$(pwd)
+test_expect_success '.git/: is-inside-work-tree' '
+	(cd .git && test false = "$(git rev-parse --is-inside-work-tree)")
+'
 
-test_rev_parse toplevel false false true '' .git "$ROOT/.git"
+test_expect_success '.git/: prefix' '
+	(
+		cd .git &&
+		echo >expected &&
+		git rev-parse --show-prefix >actual &&
+		test_cmp expected actual
+	)
+'
 
-cd .git || exit 1
-test_rev_parse .git/ false true false '' . "$ROOT/.git"
-cd objects || exit 1
-test_rev_parse .git/objects/ false true false '' "$ROOT/.git" "$ROOT/.git"
-cd ../.. || exit 1
+test_expect_success '.git/: git-dir' '
+	(
+		cd .git &&
+		echo . >expected &&
+		git rev-parse --git-dir >actual &&
+		test_cmp expected actual
+	)
+'
 
-mkdir -p sub/dir || exit 1
-cd sub/dir || exit 1
-test_rev_parse subdirectory false false true sub/dir/ "$ROOT/.git" "$ROOT/.git"
-cd ../.. || exit 1
+test_expect_success '.git/: absolute-git-dir' '
+	(
+		ROOT=$(pwd) &&
+		cd .git &&
+		echo "$ROOT/.git" >expected &&
+		git rev-parse --absolute-git-dir >actual &&
+		test_cmp expected actual
+	)
+'
 
-git config core.bare true
-test_rev_parse 'core.bare = true' true false false
+test_expect_success '.git/objects/: is-bare-repository' '
+	(cd .git/objects && test false = "$(git rev-parse --is-bare-repository)")
+'
 
-git config --unset core.bare
-test_rev_parse 'core.bare undefined' false false true
+test_expect_success '.git/objects/: is-inside-git-dir' '
+	(cd .git/objects && test true = "$(git rev-parse --is-inside-git-dir)")
+'
 
-mkdir work || exit 1
-cd work || exit 1
-GIT_DIR=../.git
-GIT_CONFIG="$(pwd)"/../.git/config
-export GIT_DIR GIT_CONFIG
+test_expect_success '.git/objects/: is-inside-work-tree' '
+	(cd .git/objects && test false = "$(git rev-parse --is-inside-work-tree)")
+'
 
-git config core.bare false
-test_rev_parse 'GIT_DIR=../.git, core.bare = false' false false true '' "../.git" "$ROOT/.git"
+test_expect_success '.git/objects/: prefix' '
+	(
+		cd .git/objects &&
+		echo >expected &&
+		git rev-parse --show-prefix >actual &&
+		test_cmp expected actual
+	)
+'
 
-git config core.bare true
-test_rev_parse 'GIT_DIR=../.git, core.bare = true' true false false ''
+test_expect_success '.git/objects/: git-dir' '
+	(
+		ROOT=$(pwd) &&
+		cd .git/objects &&
+		echo $ROOT/.git >expected &&
+		git rev-parse --git-dir >actual &&
+		test_cmp expected actual
+	)
+'
 
-git config --unset core.bare
-test_rev_parse 'GIT_DIR=../.git, core.bare undefined' false false true ''
+test_expect_success '.git/objects/: absolute-git-dir' '
+	(
+		ROOT=$(pwd) &&
+		cd .git/objects &&
+		echo "$ROOT/.git" >expected &&
+		git rev-parse --absolute-git-dir >actual &&
+		test_cmp expected actual
+	)
+'
 
-mv ../.git ../repo.git || exit 1
-GIT_DIR=../repo.git
-GIT_CONFIG="$(pwd)"/../repo.git/config
+test_expect_success 'subdirectory: is-bare-repository' '
+	mkdir -p sub/dir &&
+	test_when_finished "rm -rf sub" &&
+	(cd sub/dir && test false = "$(git rev-parse --is-bare-repository)")
+'
 
-git config core.bare false
-test_rev_parse 'GIT_DIR=../repo.git, core.bare = false' false false true '' "../repo.git" "$ROOT/repo.git"
+test_expect_success 'subdirectory: is-inside-git-dir' '
+	mkdir -p sub/dir &&
+	test_when_finished "rm -rf sub" &&
+	(cd sub/dir && test false = "$(git rev-parse --is-inside-git-dir)")
+'
 
-git config core.bare true
-test_rev_parse 'GIT_DIR=../repo.git, core.bare = true' true false false ''
+test_expect_success 'subdirectory: is-inside-work-tree' '
+	mkdir -p sub/dir &&
+	test_when_finished "rm -rf sub" &&
+	(cd sub/dir && test true = "$(git rev-parse --is-inside-work-tree)")
+'
 
-git config --unset core.bare
-test_rev_parse 'GIT_DIR=../repo.git, core.bare undefined' false false true ''
+test_expect_success 'subdirectory: prefix' '
+	mkdir -p sub/dir &&
+	test_when_finished "rm -rf sub" &&
+	(cd sub/dir && test sub/dir/ = "$(git rev-parse --show-prefix)")
+'
+
+test_expect_success 'subdirectory: git-dir' '
+	mkdir -p sub/dir &&
+	test_when_finished "rm -rf sub" &&
+	(
+		ROOT=$(pwd) &&
+		cd sub/dir &&
+		echo $ROOT/.git >expected &&
+		git rev-parse --git-dir >actual &&
+		test_cmp expected actual
+	)
+'
+
+test_expect_success 'subdirectory: absolute-git-dir' '
+	mkdir -p sub/dir &&
+	test_when_finished "rm -rf sub" &&
+	(
+		ROOT=$(pwd) &&
+		cd sub/dir &&
+		echo $ROOT/.git >expected &&
+		git rev-parse --absolute-git-dir >actual &&
+		test_cmp expected actual
+	)
+'
+
+test_expect_success 'core.bare = true: is-bare-repository' '
+	git config core.bare true &&
+	test_when_finished "git config core.bare false" &&
+	test true = "$(git rev-parse --is-bare-repository)"
+'
+
+test_expect_success 'core.bare = true: is-inside-git-dir' '
+	git config core.bare true &&
+	test_when_finished "git config core.bare false" &&
+	test false = "$(git rev-parse --is-inside-git-dir)"
+'
+
+test_expect_success 'core.bare = true: is-inside-work-tree' '
+	git config core.bare true &&
+	test_when_finished "git config core.bare false" &&
+	test false = "$(git rev-parse --is-inside-work-tree)"
+'
+
+test_expect_success 'core.bare undefined: is-bare-repository' '
+	git config --unset core.bare &&
+	test_when_finished "git config core.bare false" &&
+	test false = "$(git rev-parse --is-bare-repository)"
+'
+
+test_expect_success 'core.bare undefined: is-inside-git-dir' '
+	git config --unset core.bare &&
+	test_when_finished "git config core.bare false" &&
+	test false = "$(git rev-parse --is-inside-git-dir)"
+'
+
+test_expect_success 'core.bare undefined: is-inside-work-tree' '
+	git config --unset core.bare &&
+	test_when_finished "git config core.bare false" &&
+	test true = "$(git rev-parse --is-inside-work-tree)"
+'
+
+test_expect_success 'GIT_DIR=../.git, core.bare = false: is-bare-repository' '
+	mkdir work &&
+	test_when_finished "rm -rf work && git config core.bare false" &&
+	(
+		cd work &&
+		export GIT_DIR=../.git &&
+		export GIT_CONFIG="$(pwd)"/../.git/config
+		git config core.bare false &&
+		test false = "$(git rev-parse --is-bare-repository)"
+	)
+'
+
+test_expect_success 'GIT_DIR=../.git, core.bare = false: is-inside-git-dir' '
+	mkdir work &&
+	test_when_finished "rm -rf work && git config core.bare false" &&
+	(
+		cd work &&
+		export GIT_DIR=../.git &&
+		export GIT_CONFIG="$(pwd)"/../.git/config &&
+		git config core.bare false &&
+		test false = "$(git rev-parse --is-inside-git-dir)"
+	)
+'
+
+test_expect_success 'GIT_DIR=../.git, core.bare = false: is-inside-work-tree' '
+	mkdir work &&
+	test_when_finished "rm -rf work && git config core.bare false" &&
+	(
+		cd work &&
+		export GIT_DIR=../.git &&
+		export GIT_CONFIG="$(pwd)"/../.git/config &&
+		git config core.bare false &&
+		test true = "$(git rev-parse --is-inside-work-tree)"
+	)
+'
+
+test_expect_success 'GIT_DIR=../.git, core.bare = false: prefix' '
+	mkdir work &&
+	test_when_finished "rm -rf work && git config core.bare false" &&
+	(
+		cd work &&
+		export GIT_DIR=../.git &&
+		export GIT_CONFIG="$(pwd)"/../.git/config &&
+		git config core.bare false &&
+		echo >expected &&
+		git rev-parse --show-prefix >actual &&
+		test_cmp expected actual
+	)
+'
+
+test_expect_success 'GIT_DIR=../.git, core.bare = false: git-dir' '
+	mkdir work &&
+	test_when_finished "rm -rf work && git config core.bare false" &&
+	(
+		cd work &&
+		export GIT_DIR=../.git &&
+		export GIT_CONFIG="$(pwd)"/../.git/config &&
+		git config core.bare false &&
+		echo ../.git >expected &&
+		git rev-parse --git-dir >actual &&
+		test_cmp expected actual
+	)
+'
+
+test_expect_success 'GIT_DIR=../.git, core.bare = false: absolute-git-dir' '
+	mkdir work &&
+	test_when_finished "rm -rf work && git config core.bare false" &&
+	(
+		ROOT=$(pwd) &&
+		cd work &&
+		export GIT_DIR=../.git &&
+		export GIT_CONFIG="$(pwd)"/../.git/config &&
+		git config core.bare false &&
+		echo $ROOT/.git >expected &&
+		git rev-parse --absolute-git-dir >actual &&
+		test_cmp expected actual
+	)
+'
+
+test_expect_success 'GIT_DIR=../.git, core.bare = true: is-bare-repository' '
+	mkdir work &&
+	test_when_finished "rm -rf work && git config core.bare false" &&
+	(
+		cd work &&
+		export GIT_DIR=../.git &&
+		export GIT_CONFIG="$(pwd)"/../.git/config &&
+		git config core.bare true &&
+		test true = "$(git rev-parse --is-bare-repository)"
+	)
+'
+
+test_expect_success 'GIT_DIR=../.git, core.bare = true: is-inside-git-dir' '
+	mkdir work &&
+	test_when_finished "rm -rf work && git config core.bare false" &&
+	(
+		cd work &&
+		export GIT_DIR=../.git &&
+		export GIT_CONFIG="$(pwd)"/../.git/config &&
+		git config core.bare true &&
+		test false = "$(git rev-parse --is-inside-git-dir)"
+	)
+'
+
+test_expect_success 'GIT_DIR=../.git, core.bare = true: is-inside-work-tree' '
+	mkdir work &&
+	test_when_finished "rm -rf work && git config core.bare false" &&
+	(
+		cd work &&
+		export GIT_DIR=../.git &&
+		export GIT_CONFIG="$(pwd)"/../.git/config &&
+		git config core.bare true &&
+		test false = "$(git rev-parse --is-inside-work-tree)"
+	)
+'
+
+test_expect_success 'GIT_DIR=../.git, core.bare = true: prefix' '
+	mkdir work &&
+	test_when_finished "rm -rf work && git config core.bare false" &&
+	(
+		cd work &&
+		export GIT_DIR=../.git &&
+		export GIT_CONFIG="$(pwd)"/../.git/config &&
+		git config core.bare true &&
+		echo >expected &&
+		git rev-parse --show-prefix >actual &&
+		test_cmp expected actual
+	)
+'
+
+test_expect_success 'GIT_DIR=../.git, core.bare undefined: is-bare-repository' '
+	mkdir work &&
+	test_when_finished "rm -rf work && git config core.bare false" &&
+	(
+		cd work &&
+		export GIT_DIR=../.git &&
+		export GIT_CONFIG="$(pwd)"/../.git/config &&
+		git config --unset core.bare &&
+		test false = "$(git rev-parse --is-bare-repository)"
+	)
+'
+
+test_expect_success 'GIT_DIR=../.git, core.bare undefined: is-inside-git-dir' '
+	mkdir work &&
+	test_when_finished "rm -rf work && git config core.bare false" &&
+	(
+		cd work &&
+		export GIT_DIR=../.git &&
+		export GIT_CONFIG="$(pwd)"/../.git/config &&
+		git config --unset core.bare &&
+		test false = "$(git rev-parse --is-inside-git-dir)"
+	)
+'
+
+test_expect_success 'GIT_DIR=../.git, core.bare undefined: is-inside-work-tree' '
+	mkdir work &&
+	test_when_finished "rm -rf work && git config core.bare false" &&
+	(
+		cd work &&
+		export GIT_DIR=../.git &&
+		export GIT_CONFIG="$(pwd)"/../.git/config &&
+		git config --unset core.bare &&
+		test true = "$(git rev-parse --is-inside-work-tree)"
+	)
+'
+
+test_expect_success 'GIT_DIR=../.git, core.bare undefined: prefix' '
+	mkdir work &&
+	test_when_finished "rm -rf work && git config core.bare false" &&
+	(
+		cd work &&
+		export GIT_DIR=../.git &&
+		export GIT_CONFIG="$(pwd)"/../.git/config &&
+		git config --unset core.bare &&
+		echo >expected &&
+		git rev-parse --show-prefix >actual &&
+		test_cmp expected actual
+	)
+'
+
+test_expect_success 'GIT_DIR=../repo.git, core.bare = false: is-bare-repository' '
+	mkdir work &&
+	cp -r .git repo.git &&
+	test_when_finished "rm -r repo.git && rm -rf work && git config core.bare false" &&
+	(
+		cd work &&
+		export GIT_DIR=../repo.git &&
+		export GIT_CONFIG="$(pwd)"/../repo.git/config
+		git config core.bare false &&
+		test false = "$(git rev-parse --is-bare-repository)"
+	)
+'
+
+test_expect_success 'GIT_DIR=../repo.git, core.bare = false: is-inside-git-dir' '
+	mkdir work &&
+	cp -r .git repo.git &&
+	test_when_finished "rm -r repo.git && rm -rf work && git config core.bare false" &&
+	(
+		cd work &&
+		export GIT_DIR=../repo.git &&
+		export GIT_CONFIG="$(pwd)"/../repo.git/config &&
+		git config core.bare false &&
+		test false = "$(git rev-parse --is-inside-git-dir)"
+	)
+'
+
+test_expect_success 'GIT_DIR=../repo.git, core.bare = false: is-inside-work-tree' '
+	mkdir work &&
+	cp -r .git repo.git &&
+	test_when_finished "rm -r repo.git && rm -rf work && git config core.bare false" &&
+	(
+		cd work &&
+		export GIT_DIR=../repo.git &&
+		export GIT_CONFIG="$(pwd)"/../repo.git/config &&
+		git config core.bare false &&
+		test true = "$(git rev-parse --is-inside-work-tree)"
+	)
+'
+
+test_expect_success 'GIT_DIR=../repo.git, core.bare = false: prefix' '
+	mkdir work &&
+	cp -r .git repo.git &&
+	test_when_finished "rm -r repo.git && rm -rf work && git config core.bare false" &&
+	(
+		cd work &&
+		export GIT_DIR=../repo.git &&
+		export GIT_CONFIG="$(pwd)"/../repo.git/config &&
+		git config core.bare false &&
+		echo >expected &&
+		git rev-parse --show-prefix >actual &&
+		test_cmp expected actual
+	)
+'
+
+test_expect_success 'GIT_DIR=../repo.git, core.bare = false: git-dir' '
+	mkdir work &&
+	cp -r .git repo.git &&
+	test_when_finished "rm -r repo.git && rm -rf work && git config core.bare false" &&
+	(
+		cd work &&
+		export GIT_DIR=../repo.git &&
+		export GIT_CONFIG="$(pwd)"/../repo.git/config &&
+		git config core.bare false &&
+		echo ../repo.git >expected &&
+		git rev-parse --git-dir >actual &&
+		test_cmp expected actual
+	)
+'
+
+test_expect_success 'GIT_DIR=../repo.git, core.bare = false: absolute-git-dir' '
+	mkdir work &&
+	cp -r .git repo.git &&
+	test_when_finished "rm -r repo.git && rm -rf work && git config core.bare false" &&
+	(
+		ROOT=$(pwd) &&
+		cd work &&
+		export GIT_DIR=../repo.git &&
+		export GIT_CONFIG="$(pwd)"/../repo.git/config &&
+		git config core.bare false &&
+		echo $ROOT/repo.git >expected &&
+		git rev-parse --absolute-git-dir >actual &&
+		test_cmp expected actual
+	)
+'
+
+test_expect_success 'GIT_DIR=../repo.git, core.bare = true: is-bare-repository' '
+	mkdir work &&
+	cp -r .git repo.git &&
+	test_when_finished "rm -r repo.git && rm -rf work && git config core.bare false" &&
+	(
+		cd work &&
+		export GIT_DIR=../repo.git &&
+		export GIT_CONFIG="$(pwd)"/../repo.git/config &&
+		git config core.bare true &&
+		test true = "$(git rev-parse --is-bare-repository)"
+	)
+'
+
+test_expect_success 'GIT_DIR=../repo.git, core.bare = true: is-inside-git-dir' '
+	mkdir work &&
+	cp -r .git repo.git &&
+	test_when_finished "rm -r repo.git && rm -rf work && git config core.bare false" &&
+	(
+		cd work &&
+		export GIT_DIR=../repo.git &&
+		export GIT_CONFIG="$(pwd)"/../repo.git/config &&
+		git config core.bare true &&
+		test false = "$(git rev-parse --is-inside-git-dir)"
+	)
+'
+
+test_expect_success 'GIT_DIR=../repo.git, core.bare = true: is-inside-work-tree' '
+	mkdir work &&
+	cp -r .git repo.git &&
+	test_when_finished "rm -r repo.git && rm -rf work && git config core.bare false" &&
+	(
+		cd work &&
+		export GIT_DIR=../repo.git &&
+		export GIT_CONFIG="$(pwd)"/../repo.git/config &&
+		git config core.bare true &&
+		test false = "$(git rev-parse --is-inside-work-tree)"
+	)
+'
+
+test_expect_success 'GIT_DIR=../repo.git, core.bare = true: prefix' '
+	mkdir work &&
+	cp -r .git repo.git &&
+	test_when_finished "rm -r repo.git && rm -rf work && git config core.bare false" &&
+	(
+		cd work &&
+		export GIT_DIR=../repo.git &&
+		export GIT_CONFIG="$(pwd)"/../repo.git/config &&
+		git config core.bare true &&
+		echo >expected &&
+		git rev-parse --show-prefix >actual &&
+		test_cmp expected actual
+	)
+'
+
+test_expect_success 'GIT_DIR=../repo.git, core.bare undefined: is-bare-repository' '
+	mkdir work &&
+	cp -r .git repo.git &&
+	test_when_finished "rm -r repo.git && rm -rf work && git config core.bare false" &&
+	(
+		cd work &&
+		export GIT_DIR=../repo.git &&
+		export GIT_CONFIG="$(pwd)"/../repo.git/config &&
+		git config --unset core.bare &&
+		test false = "$(git rev-parse --is-bare-repository)"
+	)
+'
+
+test_expect_success 'GIT_DIR=../repo.git, core.bare undefined: is-inside-git-dir' '
+	mkdir work &&
+	cp -r .git repo.git &&
+	test_when_finished "rm -r repo.git && rm -rf work && git config core.bare false" &&
+	(
+		cd work &&
+		export GIT_DIR=../repo.git &&
+		export GIT_CONFIG="$(pwd)"/../repo.git/config &&
+		git config --unset core.bare &&
+		test false = "$(git rev-parse --is-inside-git-dir)"
+	)
+'
+
+test_expect_success 'GIT_DIR=../repo.git, core.bare undefined: is-inside-work-tree' '
+	mkdir work &&
+	cp -r .git repo.git &&
+	test_when_finished "rm -r repo.git && rm -rf work && git config core.bare false" &&
+	(
+		cd work &&
+		export GIT_DIR=../repo.git &&
+		export GIT_CONFIG="$(pwd)"/../repo.git/config &&
+		git config --unset core.bare &&
+		test true = "$(git rev-parse --is-inside-work-tree)"
+	)
+'
+
+test_expect_success 'GIT_DIR=../repo.git, core.bare undefined: prefix' '
+	mkdir work &&
+	cp -r .git repo.git &&
+	test_when_finished "rm -r repo.git && rm -rf work && git config core.bare false" &&
+	(
+		cd work &&
+		export GIT_DIR=../repo.git &&
+		export GIT_CONFIG="$(pwd)"/../repo.git/config &&
+		git config --unset core.bare &&
+		echo >expected &&
+		git rev-parse --show-prefix >actual &&
+		test_cmp expected actual
+	)
+'
 
 test_done
-- 
2.8.0
