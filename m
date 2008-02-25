From: Clemens Buchacher <drizzd@aon.at>
Subject: [PATCH] http-push: add regression tests
Date: Tue, 26 Feb 2008 00:28:20 +0100
Message-ID: <20080225232820.GA18254@localhost>
References: <20080218130726.GA26854@localhost> <alpine.LSU.1.00.0802181339470.30505@racer.site> <20080218155546.GA8934@localhost> <alpine.LSU.1.00.0802181733400.30505@racer.site> <20080223212843.GA30054@localhost> <20080224085830.GD13416@glandium.org> <20080224180340.GA11515@localhost> <20080224184832.GA24240@glandium.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Eric Wong <normalperson@yhbt.net>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org
To: Mike Hommey <mh@glandium.org>
X-From: git-owner@vger.kernel.org Tue Feb 26 00:29:27 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JTmkr-0006zB-5O
	for gcvg-git-2@gmane.org; Tue, 26 Feb 2008 00:29:05 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755581AbYBYX23 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 25 Feb 2008 18:28:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755297AbYBYX22
	(ORCPT <rfc822;git-outgoing>); Mon, 25 Feb 2008 18:28:28 -0500
Received: from wr-out-0506.google.com ([64.233.184.238]:25157 "EHLO
	wr-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754034AbYBYX21 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 25 Feb 2008 18:28:27 -0500
Received: by wr-out-0506.google.com with SMTP id c48so2799721wra.23
        for <git@vger.kernel.org>; Mon, 25 Feb 2008 15:28:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=domainkey-signature:received:received:received:date:from:to:cc:subject:message-id:references:mime-version:content-type:content-disposition:in-reply-to:user-agent:sender;
        bh=0rJaqO1HXGhJFK2efoof3NmJF+QybxR+hMtYI4MS8rY=;
        b=cIYf/UYpl627D+cwismt1mIUHQ6RGwYO8BHsXoPo29kSpJkSMYohmLUYfdCAMxxodM63q6/evTkYfE1Yl3ZrPDn4qsYV9HoYiizaCuGviEYETAZZUFhOuvzV+iB8FP/BGm/9dqR5GL29QRbMSIgZ7ROCB4By/zDzu1BZ+2I0sIc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlemail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version:content-type:content-disposition:in-reply-to:user-agent:sender;
        b=c9API1mEuqdNYu8vo4/MhloP0AxHkyYnaRqf75QTqG1T/PcIeG8ieqbte+7/YDMrxBgVStFTh79/I11WcpP5tjtWF2sfeNMsjSLexYHkvdl8fvriAsd1lgxHv7o8rMFwWpyicvwYFgkcrcSy/m4ROPhps/efsTjM+QzXMAEVx2g=
Received: by 10.78.90.10 with SMTP id n10mr971051hub.79.1203982104802;
        Mon, 25 Feb 2008 15:28:24 -0800 (PST)
Received: from darc.dyndns.org ( [84.154.127.94])
        by mx.google.com with ESMTPS id u9sm7716718muf.4.2008.02.25.15.28.21
        (version=TLSv1/SSLv3 cipher=OTHER);
        Mon, 25 Feb 2008 15:28:23 -0800 (PST)
Received: from drizzd by darc.dyndns.org with local (Exim 4.68)
	(envelope-from <drizzd@aon.at>)
	id 1JTmk8-0004lX-Ag; Tue, 26 Feb 2008 00:28:20 +0100
Content-Disposition: inline
In-Reply-To: <20080224184832.GA24240@glandium.org>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/75090>

http-push tests require a web server with WebDAV support.

This commit introduces a HTTPD test library, which can be configured using
the following environment variables.

LIB_HTTPD_PATH		web server path
LIB_HTTPD_MODULE_PATH	web server modules path
LIB_HTTPD_PORT		listening port
LIB_HTTPD_DAV		enable DAV
LIB_HTTPD_SVN		enable SVN
LIB_HTTPD_SSL		enable SSL

Signed-off-by: Clemens Buchacher <drizzd@aon.at>
---

On Sun, Feb 24, 2008 at 07:48:32PM +0100, Mike Hommey wrote:
> I took a quick but deeper look to your script, and I think it would be
> better to have a httpd.conf with proper <IfDefine> directives, and
> toggle the proper defines on the httpd command line.

Alright, here we go.

 t/lib-httpd.sh          |   88 +++++++++++++++++++++++++++++++++++++++++++++++
 t/lib-httpd/apache.conf |   34 ++++++++++++++++++
 t/lib-httpd/ssl.cnf     |    8 ++++
 t/t5540-http-push.sh    |   73 +++++++++++++++++++++++++++++++++++++++
 4 files changed, 203 insertions(+), 0 deletions(-)
 create mode 100644 t/lib-httpd.sh
 create mode 100644 t/lib-httpd/apache.conf
 create mode 100644 t/lib-httpd/ssl.cnf
 create mode 100644 t/t5540-http-push.sh

diff --git a/t/lib-httpd.sh b/t/lib-httpd.sh
new file mode 100644
index 0000000..2c621c4
--- /dev/null
+++ b/t/lib-httpd.sh
@@ -0,0 +1,88 @@
+#!/bin/sh
+#
+# Copyright (c) 2008 Clemens Buchacher <drizzd@aon.at>
+#
+
+LIB_HTTPD_PATH=${LIB_HTTPD_PATH-'/usr/sbin/apache2'}
+LIB_HTTPD_PORT=${LIB_HTTPD_PORT-'8111'}
+
+TEST_PATH="$PWD"/../lib-httpd
+HTTPD_ROOT_PATH="$PWD"/httpd
+HTTPD_DOCUMENT_ROOT_PATH="$PWD"/httpd/www
+
+if ! test -x "$LIB_HTTPD_PATH"
+then
+        say_color "" "skipping test, no web server found at $LIB_HTTPD_PATH"
+        test_done
+        exit
+fi
+
+HTTPD_VERSION=`$LIB_HTTPD_PATH -v | \
+	sed -n 's/^Server version: Apache\/\([0-9]*\)\..*$/\1/p; q'`
+
+if test -n "$HTTPD_VERSION"
+then
+	if test -z "$LIB_HTTPD_MODULE_PATH"
+	then
+		if ! test $HTTPD_VERSION -ge 2
+		then
+			say_color "" "skipping test, at least Apache version 2 is required"
+			test_done
+			exit
+		fi
+
+		LIB_HTTPD_MODULE_PATH='/usr/lib/apache2/modules'
+	fi
+else
+	error "Could not identify web server '$LIB_HTTPD_PATH'"
+fi
+
+HTTPD_PARA="-d $HTTPD_ROOT_PATH -f $TEST_PATH/apache.conf"
+
+prepare_httpd() {
+	mkdir $HTTPD_ROOT_PATH
+	mkdir $HTTPD_DOCUMENT_ROOT_PATH
+
+	ln -s $LIB_HTTPD_MODULE_PATH $HTTPD_ROOT_PATH/modules
+
+	if test -n "$LIB_HTTPD_SSL"
+	then
+		HTTPD_URL=https://127.0.0.1:$LIB_HTTPD_PORT
+	else
+		HTTPD_URL=http://127.0.0.1:$LIB_HTTPD_PORT
+	fi
+
+	if test "$LIB_HTTPD_SSL" != ""
+	then
+		openssl req \
+			-config $TEST_PATH/ssl.cnf \
+			-new -x509 -nodes \
+			-out $HTTPD_ROOT_PATH/httpd.pem \
+			-keyout $HTTPD_ROOT_PATH/httpd.pem
+		export GIT_SSL_NO_VERIFY=t
+		HTTPD_PARA="$HTTPD_PARA -DSSL"
+	fi
+			
+	if test "$LIB_HTTPD_DAV" != "" -o "$LIB_HTTPD_SVN" != ""
+	then
+		HTTPD_PARA="$HTTPD_PARA -DDAV"
+
+		if test "$LIB_HTTPD_SVN" != ""
+		then
+			HTTPD_PARA="$HTTPD_PARA -DSVN"
+			rawsvnrepo="$HTTPD_ROOT_PATH/svnrepo"
+			svnrepo="http://127.0.0.1:$LIB_HTTPD_PORT/svn"
+		fi
+	fi
+}
+
+start_httpd() {
+	prepare_httpd
+
+	"$LIB_HTTPD_PATH" $HTTPD_PARA \
+		-c "Listen 127.0.0.1:$LIB_HTTPD_PORT" -k start
+}
+
+stop_httpd() {
+	"$LIB_HTTPD_PATH" $HTTPD_PARA -k stop
+}
diff --git a/t/lib-httpd/apache.conf b/t/lib-httpd/apache.conf
new file mode 100644
index 0000000..a447346
--- /dev/null
+++ b/t/lib-httpd/apache.conf
@@ -0,0 +1,34 @@
+PidFile httpd.pid
+DocumentRoot www
+ErrorLog error.log
+
+<IfDefine SSL>
+LoadModule ssl_module modules/mod_ssl.so
+
+SSLCertificateFile httpd.pem
+SSLCertificateKeyFile httpd.pem
+SSLRandomSeed startup file:/dev/urandom 512
+SSLRandomSeed connect file:/dev/urandom 512
+SSLSessionCache none
+SSLMutex file:ssl_mutex
+SSLEngine On
+</IfDefine>
+
+<IfDefine DAV>
+	LoadModule dav_module modules/mod_dav.so
+	LoadModule dav_fs_module modules/mod_dav_fs.so
+
+	DAVLockDB DAVLock
+	<Location />
+		Dav on
+	</Location>
+</IfDefine>
+
+<IfDefine SVN>
+	LoadModule dav_svn_module modules/mod_dav_svn.so
+
+	<Location /svn>
+		DAV svn
+		SVNPath svnrepo
+	</Location>
+</IfDefine>
diff --git a/t/lib-httpd/ssl.cnf b/t/lib-httpd/ssl.cnf
new file mode 100644
index 0000000..8d89a05
--- /dev/null
+++ b/t/lib-httpd/ssl.cnf
@@ -0,0 +1,8 @@
+RANDFILE                = $ENV::HOME/.rnd
+
+[ req ]
+default_bits            = 1024
+distinguished_name      = req_distinguished_name
+prompt                  = no
+[ req_distinguished_name ]
+commonName              = 127.0.0.1
diff --git a/t/t5540-http-push.sh b/t/t5540-http-push.sh
new file mode 100644
index 0000000..c12e2ad
--- /dev/null
+++ b/t/t5540-http-push.sh
@@ -0,0 +1,73 @@
+#!/bin/sh
+#
+# Copyright (c) 2008 Clemens Buchacher <drizzd@aon.at>
+#
+
+test_description='test http-push
+
+This test runs various sanity checks on http-push.'
+
+. ./test-lib.sh
+
+ROOT_PATH="$PWD"
+LIB_HTTPD_DAV=t
+
+. ../lib-httpd.sh
+
+if ! start_httpd >&3 2>&4
+then
+	say_color "" "skipping test, web server setup failed"
+	test_done
+	exit
+fi
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
+	git --bare update-server-info &&
+	chmod +x hooks/post-update &&
+	cd - &&
+	mv test_repo.git $HTTPD_DOCUMENT_ROOT_PATH
+'
+	
+test_expect_success 'clone remote repository' '
+	cd "$ROOT_PATH" &&
+	git clone $HTTPD_URL/test_repo.git test_repo_clone
+'
+
+test_expect_success 'push to remote repository' '
+	cd "$ROOT_PATH"/test_repo_clone &&
+	: >path2 &&
+	git add path2 &&
+	test_tick &&
+	git commit -m path2 &&
+	git push
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
+	git branch -d -r origin/dev &&
+	git fetch &&
+	! git show-ref --verify refs/remotes/origin/dev
+'
+
+stop_httpd
+
+test_done
-- 
1.5.4.2.156.ge3c5
