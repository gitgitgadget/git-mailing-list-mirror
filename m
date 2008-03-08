Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=0.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: (qmail 20652 invoked by uid 111); 8 Mar 2008 22:28:16 -0000
Received: from vger.kernel.org (HELO vger.kernel.org) (209.132.176.167)
    by peff.net (qpsmtpd/0.32) with ESMTP; Sat, 08 Mar 2008 17:28:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751573AbYCHW2M (ORCPT <rfc822;peff@peff.net>);
	Sat, 8 Mar 2008 17:28:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751794AbYCHW2L
	(ORCPT <rfc822;git-outgoing>); Sat, 8 Mar 2008 17:28:11 -0500
Received: from balanced.mail.policyd.dreamhost.com ([208.97.132.119]:41454
	"EHLO randymail-a9.g.dreamhost.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1751678AbYCHW2L (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 8 Mar 2008 17:28:11 -0500
Received: from localhost.localdomain (KBALLARD.RES.WPI.NET [130.215.239.91])
	by randymail-a9.g.dreamhost.com (Postfix) with ESMTP id CA4E2EF34F;
	Sat,  8 Mar 2008 14:28:09 -0800 (PST)
From:	Kevin Ballard <kevin@sb.org>
To:	git@vger.kernel.org
Cc:	Kevin Ballard <kevin@sb.org>
Subject: [PATCH] Make git-svn tests behave better on OS X
Date:	Sat,  8 Mar 2008 17:28:08 -0500
Message-Id: <1205015288-9399-1-git-send-email-kevin@sb.org>
X-Mailer: git-send-email 1.5.4.3.487.g1eab2.dirty
To:	Junio C Hamano <gitster@pobox.com>
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Give lib-git-svn.sh some better defaults for OS X.
Explicitly define the LockFile so httpd will actually start under OS X

Signed-off-by: Kevin Ballard <kevin@sb.org>
---
 t/lib-git-svn.sh |   11 +++++++++--
 1 files changed, 9 insertions(+), 2 deletions(-)

diff --git a/t/lib-git-svn.sh b/t/lib-git-svn.sh
index 9ee35e7..1266609 100644
--- a/t/lib-git-svn.sh
+++ b/t/lib-git-svn.sh
@@ -49,8 +49,14 @@ poke() {
 	test-chmtime +1 "$1"
 }
 
-SVN_HTTPD_MODULE_PATH=${SVN_HTTPD_MODULE_PATH-'/usr/lib/apache2/modules'}
-SVN_HTTPD_PATH=${SVN_HTTPD_PATH-'/usr/sbin/apache2'}
+if test `uname -s` = Darwin
+then
+	SVN_HTTPD_MODULE_PATH=${SVN_HTTPD_MODULE_PATH-'/usr/libexec/apache2'}
+	SVN_HTTPD_PATH=${SVN_HTTPD_PATH-'/usr/sbin/httpd'}
+else
+	SVN_HTTPD_MODULE_PATH=${SVN_HTTPD_MODULE_PATH-'/usr/lib/apache2/modules'}
+	SVN_HTTPD_PATH=${SVN_HTTPD_PATH-'/usr/sbin/apache2'}
+fi
 
 start_httpd () {
 	if test -z "$SVN_HTTPD_PORT"
@@ -66,6 +72,7 @@ ServerName "git-svn test"
 ServerRoot "$GIT_DIR"
 DocumentRoot "$GIT_DIR"
 PidFile "$GIT_DIR/httpd.pid"
+LockFile logs/accept.lock
 Listen 127.0.0.1:$SVN_HTTPD_PORT
 LoadModule dav_module $SVN_HTTPD_MODULE_PATH/mod_dav.so
 LoadModule dav_svn_module $SVN_HTTPD_MODULE_PATH/mod_dav_svn.so
-- 
1.5.4.3.487.g1eab2.dirty

