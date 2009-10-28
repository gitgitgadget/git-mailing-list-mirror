From: Clemens Buchacher <drizzd@aon.at>
Subject: [PATCH] t5540: test both smart and dumb protocols
Date: Wed, 28 Oct 2009 18:52:26 +0100
Message-ID: <20091028175226.GA10264@localhost>
References: <1256472380-924-1-git-send-email-drizzd@aon.at> <1256472380-924-2-git-send-email-drizzd@aon.at> <1256472380-924-3-git-send-email-drizzd@aon.at> <1256472380-924-4-git-send-email-drizzd@aon.at> <20091028001737.GN10505@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Mark Lodato <lodatom@gmail.com>, git@vger.kernel.org
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Wed Oct 28 18:53:02 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N3Che-0001YA-59
	for gcvg-git-2@lo.gmane.org; Wed, 28 Oct 2009 18:52:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755390AbZJ1Rwq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 28 Oct 2009 13:52:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755388AbZJ1Rwq
	(ORCPT <rfc822;git-outgoing>); Wed, 28 Oct 2009 13:52:46 -0400
Received: from mail-ew0-f208.google.com ([209.85.219.208]:35921 "EHLO
	mail-ew0-f208.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755336AbZJ1Rwg (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 28 Oct 2009 13:52:36 -0400
Received: by ewy4 with SMTP id 4so993334ewy.37
        for <git@vger.kernel.org>; Wed, 28 Oct 2009 10:52:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=domainkey-signature:received:received:sender:received:date:from:to
         :cc:subject:message-id:references:mime-version:content-type
         :content-disposition:in-reply-to:user-agent;
        bh=sqarO9gx5jAGUO/9e5ECSCscryl1etjnI6fsHFn4KWs=;
        b=Eb3nLBYbsorxveTQ7FT32seDVOoGHx5GT9YI1G6gy1hTO4UXQOWM5xmd+fbteMi//d
         Pmc4qxbK4m9YHCr4Jy4iZ2H+xpSdtd8bS0KQfmVK4VnXFsLBNFqJhTrg1nOwZdks0ysc
         2jBHWwi4xPJs71fBIO5vcxteIW+wVxoLUVQKM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlemail.com; s=gamma;
        h=sender:date:from:to:cc:bcc:subject:message-id:references
         :mime-version:content-type:content-disposition:in-reply-to
         :user-agent;
        b=JHI9FuFHHd2GJC7rnG6E9dXrT5VQcKobpCWRALs7E9ujmJQrqWRPGlZXxzI7dabpbF
         Ixnu1GxjZQ5A16UdfPueLn4pNjDvzWjnrW03TUlSfH4LXjoWjLIJGRjVyouO+Lk/M5yX
         BGVWlkVhKTxaZJZPn+r8Q5wySrdrzxLVBwnxo=
Received: by 10.211.147.10 with SMTP id z10mr11252452ebn.61.1256752360312;
        Wed, 28 Oct 2009 10:52:40 -0700 (PDT)
Received: from darc.lan (p549A75A2.dip.t-dialin.net [84.154.117.162])
        by mx.google.com with ESMTPS id 20sm3961844ewy.65.2009.10.28.10.52.38
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 28 Oct 2009 10:52:39 -0700 (PDT)
Received: from drizzd by darc.lan with local (Exim 4.69)
	(envelope-from <drizzd@aon.at>)
	id 1N3Ch8-0008F3-SX; Wed, 28 Oct 2009 18:52:26 +0100
Content-Disposition: inline
In-Reply-To: <20091028001737.GN10505@spearce.org>
User-Agent: Mutt/1.5.18 (2008-05-17)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/131482>


Signed-off-by: Clemens Buchacher <drizzd@aon.at>
---

On Tue, Oct 27, 2009 at 05:17:38PM -0700, Shawn O. Pearce wrote:
> Clemens Buchacher <drizzd@aon.at> wrote:
> > Set LIB_HTTPD_GIT to enable smart HTTP tests.
> 
> My concern here is we have to run the test suite twice in order to
> test HTTP support.  We should only run it once, with GIT_TEST_HTTPD=1
> set and have it all run at once.

How about this? The original code is not touched except for the test
description.

Clemens

 t/lib-httpd.sh       |    2 +
 t/t5540-http-push.sh |  160 ++-----------------------------------------------
 t/test-http-push.sh  |  159 +++++++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 168 insertions(+), 153 deletions(-)
 create mode 100755 t/test-http-push.sh

diff --git a/t/lib-httpd.sh b/t/lib-httpd.sh
index aaa0a71..cf1f1df 100644
--- a/t/lib-httpd.sh
+++ b/t/lib-httpd.sh
@@ -121,4 +121,6 @@ stop_httpd() {
 
 	"$LIB_HTTPD_PATH" -d "$HTTPD_ROOT_PATH" \
 		-f "$TEST_PATH/apache.conf" $HTTPD_PARA -k stop
+
+	rm -f "$HTTPD_ROOT_PATH/modules"
 }
diff --git a/t/t5540-http-push.sh b/t/t5540-http-push.sh
index 049e129..a156f37 100755
--- a/t/t5540-http-push.sh
+++ b/t/t5540-http-push.sh
@@ -1,155 +1,9 @@
 #!/bin/sh
-#
-# Copyright (c) 2008 Clemens Buchacher <drizzd@aon.at>
-#
 
-test_description='test http-push
-
-This test runs various sanity checks on http-push.'
-
-. ./test-lib.sh
-
-ROOT_PATH="$PWD"
-if test -z "$LIB_HTTPD_GIT"
-then
-	LIB_HTTPD_DAV=t
-fi
-LIB_HTTPD_PORT=${LIB_HTTPD_PORT-'5540'}
-
-if git http-push > /dev/null 2>&1 || [ $? -eq 128 ]
-then
-	say "skipping test, USE_CURL_MULTI is not defined"
-	test_done
-fi
-
-. "$TEST_DIRECTORY"/lib-httpd.sh
-start_httpd
-
-test_expect_success 'setup remote repository' '
-	cd "$ROOT_PATH" &&
-	mkdir test_repo &&
-	cd test_repo &&
-	git init &&
-	: >path1 &&
-	git add path1 &&
-	test_tick &&
-	git commit -m initial &&
-	cd - &&
-	git clone --bare test_repo test_repo.git &&
-	cd test_repo.git &&
-	ORIG_HEAD=$(git rev-parse --verify HEAD) &&
-	if test -n "$LIB_HTTPD_GIT"
-	then
-		git config http.receivepack true
-	else
-		git --bare update-server-info &&
-		mv hooks/post-update.sample hooks/post-update
-	fi &&
-	cd - &&
-	mv test_repo.git "$HTTPD_GIT_PATH"
-'
-
-test_expect_success 'clone remote repository' '
-	cd "$ROOT_PATH" &&
-	git clone $HTTPD_GIT_URL/test_repo.git test_repo_clone
-'
-
-test_expect_success 'push to remote repository with packed refs' '
-	cd "$ROOT_PATH"/test_repo_clone &&
-	: >path2 &&
-	git add path2 &&
-	test_tick &&
-	git commit -m path2 &&
-	HEAD=$(git rev-parse --verify HEAD) &&
-	git push &&
-	(cd "$HTTPD_GIT_PATH"/test_repo.git &&
-	 test $HEAD = $(git rev-parse --verify HEAD))
-'
-
-test_expect_success 'push already up-to-date' '
-	git push
-'
-
-test_expect_success 'push to remote repository with unpacked refs' '
-	(cd "$HTTPD_GIT_PATH"/test_repo.git &&
-	 rm packed-refs &&
-	 git update-ref refs/heads/master $ORIG_HEAD &&
-	 git --bare update-server-info) &&
-	git push &&
-	(cd "$HTTPD_GIT_PATH"/test_repo.git &&
-	 test $HEAD = $(git rev-parse --verify HEAD))
-'
-
-test_expect_success 'http-push fetches unpacked objects' '
-	cp -R "$HTTPD_GIT_PATH"/test_repo.git \
-		"$HTTPD_GIT_PATH"/test_repo_unpacked.git &&
-
-	git clone $HTTPD_GIT_URL/test_repo_unpacked.git \
-		"$ROOT_PATH"/fetch_unpacked &&
-
-	# By reset, we force git to retrieve the object
-	(cd "$ROOT_PATH"/fetch_unpacked &&
-	 git reset --hard HEAD^ &&
-	 git remote rm origin &&
-	 git reflog expire --expire=0 --all &&
-	 git prune &&
-	 git push -f -v $HTTPD_GIT_URL/test_repo_unpacked.git master)
-'
-
-test_expect_success 'http-push fetches packed objects' '
-	cp -R "$HTTPD_GIT_PATH"/test_repo.git \
-		"$HTTPD_GIT_PATH"/test_repo_packed.git &&
-
-	git clone $HTTPD_GIT_URL/test_repo_packed.git \
-		"$ROOT_PATH"/test_repo_clone_packed &&
-
-	(cd "$HTTPD_GIT_PATH"/test_repo_packed.git &&
-	 git --bare repack &&
-	 git --bare prune-packed) &&
-
-	# By reset, we force git to retrieve the packed object
-	(cd "$ROOT_PATH"/test_repo_clone_packed &&
-	 git reset --hard HEAD^ &&
-	 git remote rm origin &&
-	 git reflog expire --expire=0 --all &&
-	 git prune &&
-	 git push -f -v $HTTPD_GIT_URL/test_repo_packed.git master)
-'
-
-test_expect_success 'create and delete remote branch' '
-	cd "$ROOT_PATH"/test_repo_clone &&
-	git checkout -b dev &&
-	: >path3 &&
-	git add path3 &&
-	test_tick &&
-	git commit -m dev &&
-	git push origin dev &&
-	git fetch &&
-	git push origin :dev &&
-	git fetch &&
-	test_must_fail git show-ref --verify refs/remotes/origin/dev
-'
-
-test -n "$LIB_HTTPD_GIT" ||
-test_expect_success 'MKCOL sends directory names with trailing slashes' '
-
-	! grep "\"MKCOL.*[^/] HTTP/[^ ]*\"" < "$HTTPD_ROOT_PATH"/access.log
-
-'
-
-x1="[0-9a-f]"
-x2="$x1$x1"
-x5="$x1$x1$x1$x1$x1"
-x38="$x5$x5$x5$x5$x5$x5$x5$x1$x1$x1"
-x40="$x38$x2"
-
-test -n "$LIB_HTTPD_GIT" ||
-test_expect_success 'PUT and MOVE sends object to URLs with SHA-1 hash suffix' '
-	sed -e "s/PUT /OP /" -e "s/MOVE /OP /" "$HTTPD_ROOT_PATH"/access.log |
-	grep -e "\"OP .*/objects/$x2/${x38}_$x40 HTTP/[.0-9]*\" 20[0-9] "
-
-'
-
-stop_httpd
-
-test_done
+LIB_HTTPD_GIT=t
+export LIB_HTTPD_GIT
+./test-http-push.sh $@
+sleep 1
+LIB_HTTPD_GIT=
+export LIB_HTTPD_GIT
+./test-http-push.sh $@
diff --git a/t/test-http-push.sh b/t/test-http-push.sh
new file mode 100755
index 0000000..c557541
--- /dev/null
+++ b/t/test-http-push.sh
@@ -0,0 +1,159 @@
+#!/bin/sh
+
+if test -n "$LIB_HTTPD_GIT"
+then
+	protocol=smart
+else
+	protocol=dumb
+fi
+
+test_description="test http-push ($protocol)
+
+This test runs various sanity checks on http-push."
+
+. ./test-lib.sh
+
+ROOT_PATH="$PWD"
+if test -z "$LIB_HTTPD_GIT"
+then
+	LIB_HTTPD_DAV=t
+fi
+LIB_HTTPD_PORT=${LIB_HTTPD_PORT-'5540'}
+
+if git http-push > /dev/null 2>&1 || [ $? -eq 128 ]
+then
+	say "skipping test, USE_CURL_MULTI is not defined"
+	test_done
+fi
+
+. "$TEST_DIRECTORY"/lib-httpd.sh
+start_httpd
+
+test_expect_success 'setup remote repository' '
+	cd "$ROOT_PATH" &&
+	mkdir test_repo &&
+	cd test_repo &&
+	git init &&
+	: >path1 &&
+	git add path1 &&
+	test_tick &&
+	git commit -m initial &&
+	cd - &&
+	git clone --bare test_repo test_repo.git &&
+	cd test_repo.git &&
+	ORIG_HEAD=$(git rev-parse --verify HEAD) &&
+	if test -n "$LIB_HTTPD_GIT"
+	then
+		git config http.receivepack true
+	else
+		git --bare update-server-info &&
+		mv hooks/post-update.sample hooks/post-update
+	fi &&
+	cd - &&
+	mv test_repo.git "$HTTPD_GIT_PATH"
+'
+
+test_expect_success 'clone remote repository' '
+	cd "$ROOT_PATH" &&
+	git clone $HTTPD_GIT_URL/test_repo.git test_repo_clone
+'
+
+test_expect_success 'push to remote repository with packed refs' '
+	cd "$ROOT_PATH"/test_repo_clone &&
+	: >path2 &&
+	git add path2 &&
+	test_tick &&
+	git commit -m path2 &&
+	HEAD=$(git rev-parse --verify HEAD) &&
+	git push &&
+	(cd "$HTTPD_GIT_PATH"/test_repo.git &&
+	 test $HEAD = $(git rev-parse --verify HEAD))
+'
+
+test_expect_success 'push already up-to-date' '
+	git push
+'
+
+test_expect_success 'push to remote repository with unpacked refs' '
+	(cd "$HTTPD_GIT_PATH"/test_repo.git &&
+	 rm packed-refs &&
+	 git update-ref refs/heads/master $ORIG_HEAD &&
+	 git --bare update-server-info) &&
+	git push &&
+	(cd "$HTTPD_GIT_PATH"/test_repo.git &&
+	 test $HEAD = $(git rev-parse --verify HEAD))
+'
+
+test_expect_success 'http-push fetches unpacked objects' '
+	cp -R "$HTTPD_GIT_PATH"/test_repo.git \
+		"$HTTPD_GIT_PATH"/test_repo_unpacked.git &&
+
+	git clone $HTTPD_GIT_URL/test_repo_unpacked.git \
+		"$ROOT_PATH"/fetch_unpacked &&
+
+	# By reset, we force git to retrieve the object
+	(cd "$ROOT_PATH"/fetch_unpacked &&
+	 git reset --hard HEAD^ &&
+	 git remote rm origin &&
+	 git reflog expire --expire=0 --all &&
+	 git prune &&
+	 git push -f -v $HTTPD_GIT_URL/test_repo_unpacked.git master)
+'
+
+test_expect_success 'http-push fetches packed objects' '
+	cp -R "$HTTPD_GIT_PATH"/test_repo.git \
+		"$HTTPD_GIT_PATH"/test_repo_packed.git &&
+
+	git clone $HTTPD_GIT_URL/test_repo_packed.git \
+		"$ROOT_PATH"/test_repo_clone_packed &&
+
+	(cd "$HTTPD_GIT_PATH"/test_repo_packed.git &&
+	 git --bare repack &&
+	 git --bare prune-packed) &&
+
+	# By reset, we force git to retrieve the packed object
+	(cd "$ROOT_PATH"/test_repo_clone_packed &&
+	 git reset --hard HEAD^ &&
+	 git remote rm origin &&
+	 git reflog expire --expire=0 --all &&
+	 git prune &&
+	 git push -f -v $HTTPD_GIT_URL/test_repo_packed.git master)
+'
+
+test_expect_success 'create and delete remote branch' '
+	cd "$ROOT_PATH"/test_repo_clone &&
+	git checkout -b dev &&
+	: >path3 &&
+	git add path3 &&
+	test_tick &&
+	git commit -m dev &&
+	git push origin dev &&
+	git fetch &&
+	git push origin :dev &&
+	git fetch &&
+	test_must_fail git show-ref --verify refs/remotes/origin/dev
+'
+
+test -n "$LIB_HTTPD_GIT" ||
+test_expect_success 'MKCOL sends directory names with trailing slashes' '
+
+	! grep "\"MKCOL.*[^/] HTTP/[^ ]*\"" < "$HTTPD_ROOT_PATH"/access.log
+
+'
+
+x1="[0-9a-f]"
+x2="$x1$x1"
+x5="$x1$x1$x1$x1$x1"
+x38="$x5$x5$x5$x5$x5$x5$x5$x1$x1$x1"
+x40="$x38$x2"
+
+test -n "$LIB_HTTPD_GIT" ||
+test_expect_success 'PUT and MOVE sends object to URLs with SHA-1 hash suffix' '
+	sed -e "s/PUT /OP /" -e "s/MOVE /OP /" "$HTTPD_ROOT_PATH"/access.log |
+	grep -e "\"OP .*/objects/$x2/${x38}_$x40 HTTP/[.0-9]*\" 20[0-9] "
+
+'
+
+stop_httpd
+
+test_done
-- 
1.6.5.1.208.gd7b37
