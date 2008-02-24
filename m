From: Clemens Buchacher <drizzd@aon.at>
Subject: [PATCH] http-push: add regression tests
Date: Sun, 24 Feb 2008 19:03:40 +0100
Message-ID: <20080224180340.GA11515@localhost>
References: <20080218130726.GA26854@localhost> <alpine.LSU.1.00.0802181339470.30505@racer.site> <20080218155546.GA8934@localhost> <alpine.LSU.1.00.0802181733400.30505@racer.site> <20080223212843.GA30054@localhost> <20080224085830.GD13416@glandium.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Eric Wong <normalperson@yhbt.net>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org
To: Mike Hommey <mh@glandium.org>
X-From: git-owner@vger.kernel.org Sun Feb 24 19:04:28 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JTLD5-0003c2-Nk
	for gcvg-git-2@gmane.org; Sun, 24 Feb 2008 19:04:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752757AbYBXSDn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 24 Feb 2008 13:03:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752573AbYBXSDm
	(ORCPT <rfc822;git-outgoing>); Sun, 24 Feb 2008 13:03:42 -0500
Received: from fg-out-1718.google.com ([72.14.220.158]:55156 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752103AbYBXSDk (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 24 Feb 2008 13:03:40 -0500
Received: by fg-out-1718.google.com with SMTP id e21so985723fga.17
        for <git@vger.kernel.org>; Sun, 24 Feb 2008 10:03:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=domainkey-signature:received:received:received:date:from:to:cc:subject:message-id:references:mime-version:content-type:content-disposition:in-reply-to:user-agent:sender;
        bh=dYwjZF8kiJkMziP7A6Z2hHm7YWx4ESulQHHr+RswlRM=;
        b=AsP0vSGTOaCWyzZYwbsBfrsRmC8Yop+ojpBxorfL0d2U2Iykm9lEOgSrcoVJXZzNtJWP26TfgYZBWHL9qaq7zm8RWGTsMtb7lexGerEGprUBtWFfkB4mDEyxCbvg4MIILWVturTA/lbpimJYUoFVxVGEJ+ux93j2liaHUeQKnF0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlemail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version:content-type:content-disposition:in-reply-to:user-agent:sender;
        b=LzaEkj+rkBtvwNkrgklasstX3NBQLyB2fAGZMCrbgGOu02mxfY1Q0/oKJMqJcpkVbHf9PPJEI9bkyG0eiKF3G7jRPJr3LUaAgVcGc5e6+18c8xx7eXS8Q12zmjldM8ao7/4WXkg1ABdHPjlDdbtAsH5CmNp7X5UCnMxbkWSuB64=
Received: by 10.86.59.2 with SMTP id h2mr1880821fga.19.1203876219098;
        Sun, 24 Feb 2008 10:03:39 -0800 (PST)
Received: from darc.dyndns.org ( [88.117.114.241])
        by mx.google.com with ESMTPS id 4sm3973537fgg.4.2008.02.24.10.03.36
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sun, 24 Feb 2008 10:03:37 -0800 (PST)
Received: from drizzd by darc.dyndns.org with local (Exim 4.68)
	(envelope-from <drizzd@aon.at>)
	id 1JTLCO-0004pt-7T; Sun, 24 Feb 2008 19:03:40 +0100
Content-Disposition: inline
In-Reply-To: <20080224085830.GD13416@glandium.org>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/74948>

http-push tests require a web server with WebDAV support.

This commit introduces a HTTPD test library, which can be configured using
the following environment variables.

LIB_HTTPD_PATH	web server path
LIB_HTTPD_PORT	listening port
LIB_HTTPD_DAV	enable DAV
LIB_HTTPD_SVN	enable SVN
LIB_HTTPD_SSL	enable SSL

Signed-off-by: Clemens Buchacher <drizzd@aon.at>
---

On Sun, Feb 24, 2008 at 09:58:30AM +0100, Mike Hommey wrote:
> > +LoadModule dav_module /usr/lib/apache2/modules/mod_dav.so
> > +LoadModule dav_fs_module /usr/lib/apache2/modules/mod_dav_fs.so
> 
> You'd need something for these paths too.

Indeed. If Apache or the DAV modules are not found, the test is now skipped. If
Apache is older than version 2, the test is skipped as well. I had some
problems with WebDAV "lock tokens" and couldn't get http-push to work. In
principle, however, lib-http.sh also works with Apache version 1.3.

If LIB_HTTPD_PATH points to an executable, but not to an Apache web server, the
test fails with an error.

> It would be nice if the httpd setup could be done in another file so
> that other tests could use it. Also, an https setup would be nice ;)

Good idea.

I also added SVN support. I simply tried to mimic the code from lib-git-svn.sh.
It should be straightforward to integrate lib-httpd.sh into lib-git-svn.sh now.

Regards,
Clemens

 t/lib-httpd.sh       |  181 ++++++++++++++++++++++++++++++++++++++++++++++++++
 t/t5540-http-push.sh |   83 +++++++++++++++++++++++
 2 files changed, 264 insertions(+), 0 deletions(-)
 create mode 100644 t/lib-httpd.sh
 create mode 100644 t/t5540-http-push.sh

diff --git a/t/lib-httpd.sh b/t/lib-httpd.sh
new file mode 100644
index 0000000..7fc090e
--- /dev/null
+++ b/t/lib-httpd.sh
@@ -0,0 +1,181 @@
+#!/bin/sh
+#
+# Copyright (c) 2008 Clemens Buchacher <drizzd@aon.at>
+#
+
+LIB_HTTPD_ROOT_PATH=${LIB_HTTPD_ROOT_PATH-"$PWD"}
+LIB_HTTPD_PATH=${LIB_HTTPD_PATH-'/usr/sbin/apache2'}
+
+if test -x "$LIB_HTTPD_PATH"; then
+
+HTTPD_VERSION=`$LIB_HTTPD_PATH -v | \
+	sed -n 's/^Server version: Apache\/\([0-9\.]*\).*$/\1/p'`
+HTTPD_VERSION_MAJOR=$((`echo $HTTPD_VERSION | sed 's/\..*//'`))
+HTTPD_VERSION_MINOR=\
+$((`echo $HTTPD_VERSION | sed 's/^[0-9]*\.//' | sed 's/\..*//'`))
+
+if test -n "$HTTPD_VERSION"
+then
+	if test -z "$LIB_HTTPD_MODULE_PATH"
+	then
+		if test $HTTPD_VERSION_MAJOR -ge 2
+		then
+			LIB_HTTPD_MODULE_PATH='/usr/lib/apache2/modules'
+		else
+			HTTPD_VERSION_SHORT=$HTTPD_VERSION_MAJOR.$HTTPD_VERSION_MINOR
+			LIB_HTTPD_MODULE_PATH="/usr/lib/apache/$HTTPD_VERSION_SHORT"
+		fi
+	fi
+else
+	error "Could not identify web server '$LIB_HTTPD_PATH'"
+fi
+
+fi # test -x "$LIB_HTTPD_PATH"
+
+LIB_HTTPD_PORT=${LIB_HTTPD_PORT-'8111'}
+
+if test -z "$LIB_HTTPD_SSL"
+then
+	HTTPD_URL=http://127.0.0.1:$LIB_HTTPD_PORT
+else
+	HTTPD_URL=https://127.0.0.1:$LIB_HTTPD_PORT
+fi
+
+conf_init() {
+	test $# -eq 0 ||
+	error "error: not 0 parameters to conf_init"
+
+	: >"$LIB_HTTPD_ROOT_PATH/httpd.conf"
+}
+
+conf_write() {
+	test $# -eq 0 ||
+	error "error: not 0 parameters to conf_write"
+
+	cat >> "$LIB_HTTPD_ROOT_PATH/httpd.conf"
+}
+
+conf_load_module() {
+	test $# -eq 2 ||
+	error "error: not 2 parameters to conf_load_module"
+
+	if ! test -f $LIB_HTTPD_MODULE_PATH/$2
+	then
+		test_expect_success "Could find $1 at $LIB_HTTPD_MODULE_PATH/$2" :
+		test_done
+		exit
+	fi
+
+	conf_write <<EOF
+LoadModule $1 $LIB_HTTPD_MODULE_PATH/$2
+EOF
+}
+
+prepare_httpd() {
+	test $# -eq 0 ||
+	error "error: not 0 parameters to prepare_httpd"
+
+	conf_write <<EOF
+ServerRoot $LIB_HTTPD_ROOT_PATH
+PidFile $LIB_HTTPD_ROOT_PATH/httpd.pid
+DocumentRoot $LIB_HTTPD_ROOT_PATH
+ErrorLog $LIB_HTTPD_ROOT_PATH/error.log
+Listen 127.0.0.1:$LIB_HTTPD_PORT
+EOF
+
+	if test "$LIB_HTTPD_SSL" != ""
+	then
+		cat > $LIB_HTTPD_ROOT_PATH/ssl.cnf <<EOF
+RANDFILE                = $ENV::HOME/.rnd
+
+[ req ]
+default_bits            = 1024
+distinguished_name      = req_distinguished_name
+prompt                  = no
+[ req_distinguished_name ]
+commonName                      = 127.0.0.1
+EOF
+		openssl req \
+			-config $LIB_HTTPD_ROOT_PATH/ssl.cnf \
+			-new -x509 -nodes \
+			-out $LIB_HTTPD_ROOT_PATH/httpd.pem \
+			-keyout $LIB_HTTPD_ROOT_PATH/httpd.pem
+		export GIT_SSL_NO_VERIFY=t
+		conf_load_module ssl_module mod_ssl.so
+		conf_write <<EOF
+SSLCertificateFile $LIB_HTTPD_ROOT_PATH/httpd.pem
+SSLCertificateKeyFile $LIB_HTTPD_ROOT_PATH/httpd.pem
+SSLRandomSeed startup file:/dev/urandom 512
+SSLRandomSeed connect file:/dev/urandom 512
+SSLSessionCache none
+SSLMutex file:$LIB_HTTPD_ROOT_PATH/ssl_mutex
+SSLEngine On
+EOF
+	fi
+		
+	if test "$LIB_HTTPD_DAV" != "" -o "$LIB_HTTPD_SVN" != ""
+	then
+		if test $HTTPD_VERSION_MAJOR -ge 2
+		then
+			conf_load_module dav_module mod_dav.so
+		else
+			conf_load_module dav_module libdav.so
+		fi
+
+		if test $HTTPD_VERSION_MAJOR -ge 2
+		then
+			conf_load_module dav_fs_module mod_dav_fs.so
+		fi
+
+		conf_write <<EOF
+DAVLockDB DAVLock
+<Location />
+	Dav on
+</Location>
+EOF
+
+		if test "$LIB_HTTPD_SVN" != ""
+		then
+			rawsvnrepo="$LIB_HTTPD_ROOT_PATH/svnrepo"
+			svnrepo="http://127.0.0.1:$LIB_HTTPD_PORT/svn"
+
+			conf_load_module dav_svn_module mod_dav_svn.so
+			conf_write <<EOF
+<Location /svn>
+	DAV svn
+	SVNPath $rawsvnrepo
+</Location>
+EOF
+		fi
+	fi
+}
+
+start_httpd() {
+	test $# -eq 0 ||
+	error "error: not 0 parameters to start_httpd"
+
+	prepare_httpd
+
+	if test $HTTPD_VERSION_MAJOR -ge 2
+	then
+		"$LIB_HTTPD_PATH" -f "$LIB_HTTPD_ROOT_PATH"/httpd.conf -k start
+	else
+		start-stop-daemon --start \
+			--pidfile "$LIB_HTTPD_ROOT_PATH/httpd.pid" \
+			--exec "$LIB_HTTPD_PATH" \
+			-- -f "$LIB_HTTPD_ROOT_PATH"/httpd.conf
+	fi
+}
+
+stop_httpd() {
+	test $# -eq 0 ||
+	error "error: not 0 parameters to stop_httpd"
+
+	if test $HTTPD_VERSION_MAJOR -ge 2
+	then
+		"$LIB_HTTPD_PATH" -f "$LIB_HTTPD_ROOT_PATH"/httpd.conf -k stop
+	else
+		start-stop-daemon --stop \
+			--pidfile "$LIB_HTTPD_ROOT_PATH/httpd.pid"
+	fi
+}
diff --git a/t/t5540-http-push.sh b/t/t5540-http-push.sh
new file mode 100644
index 0000000..9706f30
--- /dev/null
+++ b/t/t5540-http-push.sh
@@ -0,0 +1,83 @@
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
+ROOT_PATH=$PWD
+LIB_HTTPD_ROOT_PATH=$ROOT_PATH
+LIB_HTTPD_DAV=t
+
+. ../lib-httpd.sh
+
+if ! test -x "$LIB_HTTPD_PATH"
+then
+        test_expect_success "skipping http-push tests, no web server found at $LIB_HTTPD_PATH" :
+        test_done
+        exit
+fi
+
+test_expect_success 'setup web server' '
+	start_httpd
+'
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
+	chmod +x hooks/post-update
+'
+	
+test_expect_success 'clone remote repository' '
+	cd "$ROOT_PATH" &&
+	git clone $HTTPD_URL/test_repo.git test_repo_clone
+'
+
+if ! test -n "$HTTPD_VERSION" -a $HTTPD_VERSION_MAJOR -ge 2
+then
+	test_expect_success "skipping remaining http-push tests, at least Apache version 2 is required" :
+        test_done
+        exit
+fi
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
