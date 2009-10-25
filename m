From: Clemens Buchacher <drizzd@aon.at>
Subject: [PATCH 3/3] add smart HTTP tests
Date: Sun, 25 Oct 2009 13:06:20 +0100
Message-ID: <1256472380-924-4-git-send-email-drizzd@aon.at>
References: <1256472380-924-1-git-send-email-drizzd@aon.at>
 <1256472380-924-2-git-send-email-drizzd@aon.at>
 <1256472380-924-3-git-send-email-drizzd@aon.at>
Cc: Mark Lodato <lodatom@gmail.com>, git@vger.kernel.org,
	Clemens Buchacher <drizzd@aon.at>
To: spearce@spearce.org
X-From: git-owner@vger.kernel.org Sun Oct 25 13:07:23 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N21sZ-0002H5-BP
	for gcvg-git-2@lo.gmane.org; Sun, 25 Oct 2009 13:07:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753456AbZJYMHN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 25 Oct 2009 08:07:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753432AbZJYMHM
	(ORCPT <rfc822;git-outgoing>); Sun, 25 Oct 2009 08:07:12 -0400
Received: from mail-fx0-f218.google.com ([209.85.220.218]:60846 "EHLO
	mail-fx0-f218.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753431AbZJYMHK (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 25 Oct 2009 08:07:10 -0400
Received: by fxm18 with SMTP id 18so11402422fxm.37
        for <git@vger.kernel.org>; Sun, 25 Oct 2009 05:07:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=domainkey-signature:received:received:sender:received:from:to:cc
         :subject:date:message-id:x-mailer:in-reply-to:references;
        bh=/S+sOKdaXdwRYzYvDhusmhTE939GL72WiK4efoyE0uc=;
        b=SmGW+VPPi+03AJgptTTOePYbdwLY+GITYEo4BAeeUGtUPH6YUwS92WwYo0Fg8qDdkL
         ryWB37wqJqeWX9IEvqEwX9JIvVcuT77epJ1Ba8yM+Z4M7qV3PYWvf2YQOTnR4gBoI0Jz
         23RkGlRygfi8jAS6oTGcMHbD6ndiYflpLtnWU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlemail.com; s=gamma;
        h=sender:from:to:cc:subject:date:message-id:x-mailer:in-reply-to
         :references;
        b=WgTMk5efGY2F/V96v7DVBoma3CzDtEz/ipa2ACeA1o99OhBB4vm02ncqmxn+7HmtEP
         1ZH0rWmJ5iVTX5X+FP1TdmsIcw03AAWINmqte7VE96p9PN7gRgvSHgcwAM6emiv4XQFr
         e5RTcnjwW06a+WyxGmoJ9VI3laKfNj1RgrsZE=
Received: by 10.204.34.13 with SMTP id j13mr13076326bkd.32.1256472434099;
        Sun, 25 Oct 2009 05:07:14 -0700 (PDT)
Received: from darc.lan (p549A3880.dip.t-dialin.net [84.154.56.128])
        by mx.google.com with ESMTPS id 3sm6833120fxm.37.2009.10.25.05.07.12
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sun, 25 Oct 2009 05:07:13 -0700 (PDT)
Received: from drizzd by darc.lan with local (Exim 4.69)
	(envelope-from <drizzd@aon.at>)
	id 1N21sW-0001Po-DA; Sun, 25 Oct 2009 13:07:20 +0100
X-Mailer: git-send-email 1.6.5.35.ge41a3
In-Reply-To: <1256472380-924-3-git-send-email-drizzd@aon.at>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/131203>

Set LIB_HTTPD_GIT to enable smart HTTP tests.

Signed-off-by: Clemens Buchacher <drizzd@aon.at>
---
 t/lib-httpd.sh          |    9 +++++++++
 t/lib-httpd/apache.conf |   36 +++++++++++++++++++++++++++---------
 t/t5540-http-push.sh    |   46 ++++++++++++++++++++++++++++------------------
 3 files changed, 64 insertions(+), 27 deletions(-)

diff --git a/t/lib-httpd.sh b/t/lib-httpd.sh
index 6765b08..aaa0a71 100644
--- a/t/lib-httpd.sh
+++ b/t/lib-httpd.sh
@@ -88,6 +88,15 @@ prepare_httpd() {
 			svnrepo="http://127.0.0.1:$LIB_HTTPD_PORT/svn"
 		fi
 	fi
+
+	if test -n "$LIB_HTTPD_GIT"
+	then
+		HTTPD_PARA="$HTTPD_PARA -DGIT"
+	fi
+
+	HTTPD_GIT_PATH=$HTTPD_DOCUMENT_ROOT_PATH/git
+	mkdir -p "$HTTPD_GIT_PATH"
+	HTTPD_GIT_URL="$HTTPD_URL/git"
 }
 
 start_httpd() {
diff --git a/t/lib-httpd/apache.conf b/t/lib-httpd/apache.conf
index 21aa42f..d8505f1 100644
--- a/t/lib-httpd/apache.conf
+++ b/t/lib-httpd/apache.conf
@@ -10,15 +10,15 @@ ErrorLog error.log
 </IfModule>
 
 <IfDefine SSL>
-LoadModule ssl_module modules/mod_ssl.so
-
-SSLCertificateFile httpd.pem
-SSLCertificateKeyFile httpd.pem
-SSLRandomSeed startup file:/dev/urandom 512
-SSLRandomSeed connect file:/dev/urandom 512
-SSLSessionCache none
-SSLMutex file:ssl_mutex
-SSLEngine On
+	LoadModule ssl_module modules/mod_ssl.so
+
+	SSLCertificateFile httpd.pem
+	SSLCertificateKeyFile httpd.pem
+	SSLRandomSeed startup file:/dev/urandom 512
+	SSLRandomSeed connect file:/dev/urandom 512
+	SSLSessionCache none
+	SSLMutex file:ssl_mutex
+	SSLEngine On
 </IfDefine>
 
 <IfDefine DAV>
@@ -39,3 +39,21 @@ SSLEngine On
 		SVNPath svnrepo
 	</Location>
 </IfDefine>
+
+<IfDefine GIT>
+	LoadModule cgi_module modules/mod_cgi.so
+	LoadModule alias_module modules/mod_alias.so
+	LoadModule actions_module modules/mod_actions.so
+	ScriptAlias /git-http-backend ${GIT_EXEC_PATH}/git-http-backend
+
+	<Location /git>
+		SetHandler git-http-backend
+		Action git-http-backend /git-http-backend virtual
+	</Location>
+	<Directory ${GIT_EXEC_PATH}>
+		Options None
+	</Directory>
+	<Files ${GIT_EXEC_PATH}/git-http-backend>
+		Options ExecCGI
+	</Files>
+</IfDefine>
diff --git a/t/t5540-http-push.sh b/t/t5540-http-push.sh
index 2ece661..74ca08d 100755
--- a/t/t5540-http-push.sh
+++ b/t/t5540-http-push.sh
@@ -10,7 +10,10 @@ This test runs various sanity checks on http-push.'
 . ./test-lib.sh
 
 ROOT_PATH="$PWD"
-LIB_HTTPD_DAV=t
+if test -z "$LIB_HTTPD_GIT"
+then
+	LIB_HTTPD_DAV=t
+fi
 LIB_HTTPD_PORT=${LIB_HTTPD_PORT-'5540'}
 
 if git http-push > /dev/null 2>&1 || [ $? -eq 128 ]
@@ -34,16 +37,21 @@ test_expect_success 'setup remote repository' '
 	cd - &&
 	git clone --bare test_repo test_repo.git &&
 	cd test_repo.git &&
-	git --bare update-server-info &&
-	mv hooks/post-update.sample hooks/post-update &&
 	ORIG_HEAD=$(git rev-parse --verify HEAD) &&
-	cd - &&
-	mv test_repo.git "$HTTPD_DOCUMENT_ROOT_PATH"
+	if test -n "$LIB_HTTPD_GIT"
+	then
+		git config http.receivepack true
+	else
+		git --bare update-server-info &&
+		mv hooks/post-update.sample hooks/post-update
+	fi
+	cd -
+	mv test_repo.git "$HTTPD_GIT_PATH"
 '
 
 test_expect_success 'clone remote repository' '
 	cd "$ROOT_PATH" &&
-	git clone $HTTPD_URL/test_repo.git test_repo_clone
+	git clone $HTTPD_GIT_URL/test_repo.git test_repo_clone
 '
 
 test_expect_success 'push to remote repository with packed refs' '
@@ -54,7 +62,7 @@ test_expect_success 'push to remote repository with packed refs' '
 	git commit -m path2 &&
 	HEAD=$(git rev-parse --verify HEAD) &&
 	git push &&
-	(cd "$HTTPD_DOCUMENT_ROOT_PATH"/test_repo.git &&
+	(cd "$HTTPD_GIT_PATH"/test_repo.git &&
 	 test $HEAD = $(git rev-parse --verify HEAD))
 '
 
@@ -63,20 +71,20 @@ test_expect_success 'push already up-to-date' '
 '
 
 test_expect_success 'push to remote repository with unpacked refs' '
-	(cd "$HTTPD_DOCUMENT_ROOT_PATH"/test_repo.git &&
+	(cd "$HTTPD_GIT_PATH"/test_repo.git &&
 	 rm packed-refs &&
 	 git update-ref refs/heads/master $ORIG_HEAD &&
 	 git --bare update-server-info) &&
 	git push &&
-	(cd "$HTTPD_DOCUMENT_ROOT_PATH"/test_repo.git &&
+	(cd "$HTTPD_GIT_PATH"/test_repo.git &&
 	 test $HEAD = $(git rev-parse --verify HEAD))
 '
 
 test_expect_success 'http-push fetches unpacked objects' '
-	cp -R "$HTTPD_DOCUMENT_ROOT_PATH"/test_repo.git \
-		"$HTTPD_DOCUMENT_ROOT_PATH"/test_repo_unpacked.git &&
+	cp -R "$HTTPD_GIT_PATH"/test_repo.git \
+		"$HTTPD_GIT_PATH"/test_repo_unpacked.git &&
 
-	git clone $HTTPD_URL/test_repo_unpacked.git \
+	git clone $HTTPD_GIT_URL/test_repo_unpacked.git \
 		"$ROOT_PATH"/fetch_unpacked &&
 
 	# By reset, we force git to retrieve the object
@@ -85,17 +93,17 @@ test_expect_success 'http-push fetches unpacked objects' '
 	 git remote rm origin &&
 	 git reflog expire --expire=0 --all &&
 	 git prune &&
-	 git push -f -v $HTTPD_URL/test_repo_unpacked.git master)
+	 git push -f -v $HTTPD_GIT_URL/test_repo_unpacked.git master)
 '
 
 test_expect_success 'http-push fetches packed objects' '
-	cp -R "$HTTPD_DOCUMENT_ROOT_PATH"/test_repo.git \
-		"$HTTPD_DOCUMENT_ROOT_PATH"/test_repo_packed.git &&
+	cp -R "$HTTPD_GIT_PATH"/test_repo.git \
+		"$HTTPD_GIT_PATH"/test_repo_packed.git &&
 
-	git clone $HTTPD_URL/test_repo_packed.git \
+	git clone $HTTPD_GIT_URL/test_repo_packed.git \
 		"$ROOT_PATH"/test_repo_clone_packed &&
 
-	(cd "$HTTPD_DOCUMENT_ROOT_PATH"/test_repo_packed.git &&
+	(cd "$HTTPD_GIT_PATH"/test_repo_packed.git &&
 	 git --bare repack &&
 	 git --bare prune-packed) &&
 
@@ -105,7 +113,7 @@ test_expect_success 'http-push fetches packed objects' '
 	 git remote rm origin &&
 	 git reflog expire --expire=0 --all &&
 	 git prune &&
-	 git push -f -v $HTTPD_URL/test_repo_packed.git master)
+	 git push -f -v $HTTPD_GIT_URL/test_repo_packed.git master)
 '
 
 test_expect_success 'create and delete remote branch' '
@@ -122,6 +130,7 @@ test_expect_success 'create and delete remote branch' '
 	test_must_fail git show-ref --verify refs/remotes/origin/dev
 '
 
+test -n "$LIB_HTTPD_GIT" ||
 test_expect_success 'MKCOL sends directory names with trailing slashes' '
 
 	! grep "\"MKCOL.*[^/] HTTP/[^ ]*\"" < "$HTTPD_ROOT_PATH"/access.log
@@ -134,6 +143,7 @@ x5="$x1$x1$x1$x1$x1"
 x38="$x5$x5$x5$x5$x5$x5$x5$x1$x1$x1"
 x40="$x38$x2"
 
+test -n "$LIB_HTTPD_GIT" ||
 test_expect_success 'PUT and MOVE sends object to URLs with SHA-1 hash suffix' '
 	sed -e "s/PUT /OP /" -e "s/MOVE /OP /" "$HTTPD_ROOT_PATH"/access.log |
 	grep -e "\"OP .*/objects/$x2/${x38}_$x40 HTTP/[.0-9]*\" 20[0-9] "
-- 
1.6.5.35.ge41a3
