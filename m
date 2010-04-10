From: Jonathan Nieder <jrnieder@gmail.com>
Subject: [PATCH 3/3] t7400: clarify submodule update tests
Date: Sat, 10 Apr 2010 00:39:41 -0500
Message-ID: <20100410053940.GC17649@progeny.tock>
References: <20100410053729.GA17595@progeny.tock>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Lars Hjemli <hjemli@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Apr 10 07:39:20 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O0TPb-0003Pa-FX
	for gcvg-git-2@lo.gmane.org; Sat, 10 Apr 2010 07:39:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751189Ab0DJFjP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 10 Apr 2010 01:39:15 -0400
Received: from mail-gy0-f174.google.com ([209.85.160.174]:38653 "EHLO
	mail-gy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751115Ab0DJFjO (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 10 Apr 2010 01:39:14 -0400
Received: by gyg13 with SMTP id 13so2017267gyg.19
        for <git@vger.kernel.org>; Fri, 09 Apr 2010 22:39:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=WpeuZzRY3KwS0sgHR6ZRlIeaYpVpyrNyKE9spaj3zlI=;
        b=oU5vfEmhbU9xwPZ209e7g4E6JVfuzS9qN+lBwHU7M+0Aie9cHpvaVuprERZfsRf1kn
         NB5X2+y6QQosRKAAGCr/zlldySnyuCB9CN5OqSturIk4TdmGb94Dlnrn2w/fuK68P5gD
         pnEZEeQ+6Tjh5JzbwTwAwTQM7WU9t1F88RE4A=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=ZRbVYRyqf4QVtJsN01rMUKkQER1bM0UE+WDXcHQhpv3UJdFKmOVfHUaPYfo0Z3jpgp
         SyljKFefg2F4Lzv8LK4ZFx2OLogCBNhjFBvhcKnWfNxOUwsWWV0LLixHWy+sA7C5q4sz
         bU0usIdAKMZh5qr/Xce2DwndT6OgpW5hOYhD4=
Received: by 10.90.207.14 with SMTP id e14mr377962agg.109.1270877952170;
        Fri, 09 Apr 2010 22:39:12 -0700 (PDT)
Received: from progeny.tock (c-98-212-3-231.hsd1.il.comcast.net [98.212.3.231])
        by mx.google.com with ESMTPS id 21sm1508993iwn.15.2010.04.09.22.39.11
        (version=SSLv3 cipher=RC4-MD5);
        Fri, 09 Apr 2010 22:39:11 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20100410053729.GA17595@progeny.tock>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/144511>

In particular, add a missing && to the update --init test.

The goal is to make it clearer what happened when one of these
tests fails.  The update --init test is currently (consistently)
failing on a few unusual machines.

Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
---
 t/t7400-submodule-basic.sh |  186 +++++++++++++++++++++----------------------
 1 files changed, 91 insertions(+), 95 deletions(-)

diff --git a/t/t7400-submodule-basic.sh b/t/t7400-submodule-basic.sh
index dbc8338..55590ab 100755
--- a/t/t7400-submodule-basic.sh
+++ b/t/t7400-submodule-basic.sh
@@ -28,9 +28,6 @@ test_expect_success 'setup - repository in init subdirectory' '
 		git commit -m "submodule commit 1" &&
 		git tag -a -m "rev-1" rev-1
 	)
-	rev1=$(cd init && git rev-parse HEAD) &&
-	printf "rev1: %s\n" "$rev1" &&
-	test -n "$rev1"
 '
 
 test_expect_success 'setup - commit with gitlink' '
@@ -44,11 +41,6 @@ test_expect_success 'setup - hide init subdirectory' '
 	mv init .subrepo
 '
 
-test_expect_success 'setup - add an example entry to .gitmodules' '
-	GIT_CONFIG=.gitmodules \
-	git config submodule.example.url git://example.com/init.git
-'
-
 test_expect_success 'setup - repository to add submodules to' '
 	git init addtest
 '
@@ -69,6 +61,7 @@ inspect() {
 		cd "$dir" &&
 		listbranches >"$dotdot/heads" &&
 		{ git symbolic-ref HEAD || :; } >"$dotdot/head" &&
+		git rev-parse HEAD >"$dotdot/head-sha1" &&
 		git update-index --refresh &&
 		git diff-files --exit-code &&
 		git clean -n -d -x >"$dotdot/untracked"
@@ -181,131 +174,129 @@ test_expect_success 'submodule add with ./, /.. and // in path' '
 	test_cmp empty untracked
 '
 
+test_expect_success 'setup - add an example entry to .gitmodules' '
+	GIT_CONFIG=.gitmodules \
+	git config submodule.example.url git://example.com/init.git
+'
+
 test_expect_success 'status should fail for unmapped paths' '
-	if git submodule status
-	then
-		echo "[OOPS] submodule status succeeded"
-		false
-	elif ! GIT_CONFIG=.gitmodules git config submodule.example.path init
-	then
-		echo "[OOPS] git config failed to update .gitmodules"
-		false
-	fi
+	test_must_fail git submodule status
+'
+
+test_expect_success 'setup - map path in .gitmodules' '
+	cat <<\EOF >expect &&
+[submodule "example"]
+	url = git://example.com/init.git
+	path = init
+EOF
+
+	GIT_CONFIG=.gitmodules git config submodule.example.path init &&
+
+	test_cmp expect .gitmodules
 '
 
 test_expect_success 'status should only print one line' '
-	lines=$(git submodule status | wc -l) &&
-	test $lines = 1
+	git submodule status >lines &&
+	test $(wc -l <lines) = 1
+'
+
+test_expect_success 'setup - fetch commit name from submodule' '
+	rev1=$(cd .subrepo && git rev-parse HEAD) &&
+	printf "rev1: %s\n" "$rev1" &&
+	test -n "$rev1"
 '
 
 test_expect_success 'status should initially be "missing"' '
-	git submodule status | grep "^-$rev1"
+	git submodule status >lines &&
+	grep "^-$rev1" lines
 '
 
 test_expect_success 'init should register submodule url in .git/config' '
+	echo git://example.com/init.git >expect &&
+
 	git submodule init &&
-	url=$(git config submodule.example.url) &&
-	if test "$url" != "git://example.com/init.git"
-	then
-		echo "[OOPS] init succeeded but submodule url is wrong"
-		false
-	elif test_must_fail git config submodule.example.url ./.subrepo
-	then
-		echo "[OOPS] init succeeded but update of url failed"
-		false
-	fi
+	git config submodule.example.url >url &&
+	git config submodule.example.url ./.subrepo &&
+
+	test_cmp expect url
 '
 
 test_expect_success 'update should fail when path is used by a file' '
+	echo hello >expect &&
+
 	echo "hello" >init &&
-	if git submodule update
-	then
-		echo "[OOPS] update should have failed"
-		false
-	elif test "$(cat init)" != "hello"
-	then
-		echo "[OOPS] update failed but init file was molested"
-		false
-	else
-		rm init
-	fi
+	test_must_fail git submodule update &&
+
+	test_cmp expect init
 '
 
+rm -fr init
 test_expect_success 'update should fail when path is used by a nonempty directory' '
+	echo hello >expect &&
+
 	mkdir init &&
 	echo "hello" >init/a &&
-	if git submodule update
-	then
-		echo "[OOPS] update should have failed"
-		false
-	elif test "$(cat init/a)" != "hello"
-	then
-		echo "[OOPS] update failed but init/a was molested"
-		false
-	else
-		rm init/a
-	fi
+
+	test_must_fail git submodule update &&
+
+	test_cmp expect init/a
 '
 
+rm -fr init
+rm -f head-sha1
 test_expect_success 'update should work when path is an empty dir' '
-	rm -rf init &&
+	echo "$rev1" >expect
+
 	mkdir init &&
 	git submodule update &&
-	head=$(cd init && git rev-parse HEAD) &&
-	if test -z "$head"
-	then
-		echo "[OOPS] Failed to obtain submodule head"
-		false
-	elif test "$head" != "$rev1"
-	then
-		echo "[OOPS] Submodule head is $head but should have been $rev1"
-		false
-	fi
+
+	inspect init &&
+	test_cmp expect head-sha1
 '
 
 test_expect_success 'status should be "up-to-date" after update' '
-	git submodule status | grep "^ $rev1"
+	git submodule status >list &&
+	grep "^ $rev1" list
 '
 
 test_expect_success 'status should be "modified" after submodule commit' '
-	cd init &&
-	echo b >b &&
-	git add b &&
-	git commit -m "submodule commit 2" &&
-	rev2=$(git rev-parse HEAD) &&
-	cd .. &&
-	if test -z "$rev2"
-	then
-		echo "[OOPS] submodule git rev-parse returned nothing"
-		false
-	fi &&
-	git submodule status | grep "^+$rev2"
+	(
+		cd init &&
+		echo b >b &&
+		git add b &&
+		git commit -m "submodule commit 2"
+	) &&
+
+	rev2=$(cd init && git rev-parse HEAD) &&
+	test -n "$rev2" &&
+	git submodule status >list &&
+
+	grep "^+$rev2" list
 '
 
 test_expect_success 'the --cached sha1 should be rev1' '
-	git submodule --cached status | grep "^+$rev1"
+	git submodule --cached status >list &&
+	grep "^+$rev1" list
 '
 
 test_expect_success 'git diff should report the SHA1 of the new submodule commit' '
-	git diff | grep "^+Subproject commit $rev2"
+	git diff >diff &&
+	grep "^+Subproject commit $rev2" diff
 '
 
+rm -f head-sha1
 test_expect_success 'update should checkout rev1' '
+	echo "$rev1" >expect &&
+
 	git submodule update init &&
-	head=$(cd init && git rev-parse HEAD) &&
-	if test -z "$head"
-	then
-		echo "[OOPS] submodule git rev-parse returned nothing"
-		false
-	elif test "$head" != "$rev1"
-	then
-		echo "[OOPS] init did not checkout correct head"
-		false
-	fi
+	inspect init &&
+
+	test_cmp expect head-sha1
 '
 
 test_expect_success 'status should be "up-to-date" after update' '
-	git submodule status | grep "^ $rev1"
+	git submodule status >list &&
+	grep "^ $rev1" list
 '
 
 test_expect_success 'checkout superproject with subproject already present' '
@@ -314,6 +305,8 @@ test_expect_success 'checkout superproject with subproject already present' '
 '
 
 test_expect_success 'apply submodule diff' '
+	>empty &&
+
 	git branch second &&
 	(
 		cd init &&
@@ -326,21 +319,24 @@ test_expect_success 'apply submodule diff' '
 	git format-patch -1 --stdout >P.diff &&
 	git checkout second &&
 	git apply --index P.diff &&
-	D=$(git diff --cached master) &&
-	test -z "$D"
+
+	git diff --cached master >staged &&
+	test_cmp empty staged
 '
 
 test_expect_success 'update --init' '
-
 	mv init init2 &&
 	git config -f .gitmodules submodule.example.url "$(pwd)/init2" &&
-	git config --remove-section submodule.example
+	git config --remove-section submodule.example &&
+	test_must_fail git config submodule.example.url &&
+
 	git submodule update init > update.out &&
+	cat update.out &&
 	grep "not initialized" update.out &&
-	test ! -d init/.git &&
+	! test -d init/.git &&
+
 	git submodule update --init init &&
 	test -d init/.git
-
 '
 
 test_expect_success 'do not add files from a submodule' '
-- 
1.7.0.4
