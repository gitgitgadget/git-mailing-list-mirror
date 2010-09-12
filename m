From: Jakub Narebski <jnareb@gmail.com>
Subject: [PATCH/RFC 3/3] t/gitweb-lib.sh: Add support for GITWEB_TEST_INSTALLED
Date: Sun, 12 Sep 2010 11:41:06 +0200
Message-ID: <1284284466-14506-4-git-send-email-jnareb@gmail.com>
References: <1284284466-14506-1-git-send-email-jnareb@gmail.com>
Cc: Jakub Narebski <jnareb@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Sep 12 11:41:55 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ouj4L-00078b-OC
	for gcvg-git-2@lo.gmane.org; Sun, 12 Sep 2010 11:41:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752501Ab0ILJld (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 12 Sep 2010 05:41:33 -0400
Received: from mail-bw0-f46.google.com ([209.85.214.46]:41112 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752141Ab0ILJlb (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 12 Sep 2010 05:41:31 -0400
Received: by mail-bw0-f46.google.com with SMTP id 11so3684705bwz.19
        for <git@vger.kernel.org>; Sun, 12 Sep 2010 02:41:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=MFMMkBxVseLsOKMX2huvesQNty6XdspzObyQ8fUmKH0=;
        b=i9KFcwoVSL8/t+Zivw4jkxsWMq4DbfjFGGJAvezfUb9adLCi7cbV7A9M5CdALVxtSP
         2nVW+oD2o3ke5vyhQfqUTHbAOD6w+VcfkM5JSUk7NG6p6SdDOFxzQaYn1wku1DR4jORG
         IChyQKFmPuTqjb3Bqv8T6JjSstYJG5/ZayPDY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=QhDiB3cYTTKZSzH7NtEAT4etT/hqMELM/A6f9TJLMC6OI8YZWh67b2MjFVzjsHB495
         7s6yqfeUo3yiVPFymJ9RIHrQATEZYTLBz4SD6r8tmq33v2plabyTzpCX4psIcbP129So
         DJ8ywtOApYkZoNBD64pDwxESH2P8fRlFlVBLc=
Received: by 10.204.127.75 with SMTP id f11mr2170440bks.85.1284284491039;
        Sun, 12 Sep 2010 02:41:31 -0700 (PDT)
Received: from localhost.localdomain (abvl188.neoplus.adsl.tpnet.pl [83.8.209.188])
        by mx.google.com with ESMTPS id 24sm3570708bkr.19.2010.09.12.02.41.29
        (version=SSLv3 cipher=RC4-MD5);
        Sun, 12 Sep 2010 02:41:30 -0700 (PDT)
X-Mailer: git-send-email 1.7.2.1
In-Reply-To: <1284284466-14506-1-git-send-email-jnareb@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/156025>

You can set the GITWEB_TEST_INSTALLED environment variable to the
gitwebdir (the directory where gitweb is installed / deployed to) of
an existing gitweb instalation to test that installation.

This change is intended to make it possible to test that process of
installing gitweb (and the modules it depends on) works correctly
after splitting gitweb.

Signed-off-by: Jakub Narebski <jnareb@gmail.com>
---

It is an RFC because I am not sure where to put documentation,
i.e. description of GITWEB_TEST_INSTALLED.  Should it be put in
t/README, in gitweb/README, or in gitweb/INSTALL, or in
t/gitweb-lib.sh header?

 t/gitweb-lib.sh |   15 +++++++++++++--
 1 files changed, 13 insertions(+), 2 deletions(-)

diff --git a/t/gitweb-lib.sh b/t/gitweb-lib.sh
index 8c490c8..b17459c 100755
--- a/t/gitweb-lib.sh
+++ b/t/gitweb-lib.sh
@@ -32,17 +32,28 @@ EOF
 	cat >.git/description <<EOF
 $0 test repository
 EOF
+
+	# You can set the GITWEB_TEST_INSTALLED environment variable to
+	# the gitwebdir (the directory where gitweb is installed / deployed to)
+	# of an existing gitweb instalation to test that installation.
+	if test -n "$GITWEB_TEST_INSTALLED" ; then
+		SCRIPT_NAME="$GITWEB_TEST_INSTALLED/gitweb.cgi"
+		test -f "$SCRIPT_NAME" ||
+		error "Cannot find gitweb.cgi at $GITWEB_TEST_INSTALLED."
+	else # normal case, use source version of gitweb
+		SCRIPT_NAME="$GIT_BUILD_DIR/gitweb/gitweb.perl"
+	fi
+	export SCRIPT_NAME
 }
 
 gitweb_run () {
 	GATEWAY_INTERFACE='CGI/1.1'
 	HTTP_ACCEPT='*/*'
 	REQUEST_METHOD='GET'
-	SCRIPT_NAME="$GIT_BUILD_DIR/gitweb/gitweb.perl"
 	QUERY_STRING=""$1""
 	PATH_INFO=""$2""
 	export GATEWAY_INTERFACE HTTP_ACCEPT REQUEST_METHOD \
-		SCRIPT_NAME QUERY_STRING PATH_INFO
+		QUERY_STRING PATH_INFO
 
 	GITWEB_CONFIG=$(pwd)/gitweb_config.perl
 	export GITWEB_CONFIG
-- 
1.7.2.1
