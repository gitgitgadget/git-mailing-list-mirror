From: Jakub Narebski <jnareb@gmail.com>
Subject: [PATCHv2 2/3] t/gitweb-lib.sh: Add support for GITWEB_TEST_INSTALLED
Date: Sun, 26 Sep 2010 15:02:25 +0200
Message-ID: <1285506146-8009-3-git-send-email-jnareb@gmail.com>
References: <1285506146-8009-1-git-send-email-jnareb@gmail.com>
Cc: Jakub Narebski <jnareb@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Sep 26 15:11:30 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ozr0n-0001r2-S3
	for gcvg-git-2@lo.gmane.org; Sun, 26 Sep 2010 15:11:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757745Ab0IZNLH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 26 Sep 2010 09:11:07 -0400
Received: from mail-bw0-f46.google.com ([209.85.214.46]:33662 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757655Ab0IZNLG (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 26 Sep 2010 09:11:06 -0400
Received: by mail-bw0-f46.google.com with SMTP id 11so2792344bwz.19
        for <git@vger.kernel.org>; Sun, 26 Sep 2010 06:11:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=vWtZm/ZayIxYsO96AQA45XDJZ70V0qHJwfr+XNB1mEg=;
        b=j7/b7He9s6K8iU9s1yQpxTZDn5A1s9LPKdjLFgVAQLoHr0IxDTt+tRnX0xxMTRepfX
         gx8FuujNOmHQS85aL1b+kdJByWWtu9wNgNVcU0zm7dTXNieRb+7GwfoNACcPNmT83qv6
         w8IZpp/8pjHsk+bgpnbuGWTuO6qpmitI1Ae60=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=jBGn0AhQeTgW0HkDwHZYV24uS2eFQFICxhVVBp2rOiv/lUbPsk0Wy6rLGNyUgHYgws
         xZC09Z+q0UQMWHHHoe9iRp9F/MnwGll9Q1t1ljXqoco7gK4cPGq7bdbGSGJf5eiV+zoS
         rhPR+M5P/yGRX1ToqsgRmL2DyvQX93vs94YrM=
Received: by 10.204.73.1 with SMTP id o1mr4084314bkj.132.1285506664690;
        Sun, 26 Sep 2010 06:11:04 -0700 (PDT)
Received: from localhost.localdomain (abwp12.neoplus.adsl.tpnet.pl [83.8.239.12])
        by mx.google.com with ESMTPS id x13sm3388546bki.0.2010.09.26.06.11.01
        (version=SSLv3 cipher=RC4-MD5);
        Sun, 26 Sep 2010 06:11:03 -0700 (PDT)
X-Mailer: git-send-email 1.7.3
In-Reply-To: <1285506146-8009-1-git-send-email-jnareb@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/157225>

You can set the GITWEB_TEST_INSTALLED environment variable to the
gitwebdir (the directory where gitweb is installed / deployed to) of
an existing gitweb instalation, or to the pathname of installed gitweb
script, to test that installation.

This change is intended to make it possible to test that process of
installing gitweb and the modules it depends on works correctly (after
splitting gitweb).

If GITWEB_TEST_INSTALLED is used, print what script are we testing
to make it easy to spot that we test installed gitweb.

Signed-off-by: Jakub Narebski <jnareb@gmail.com>
---
No change from previous version.

 t/gitweb-lib.sh |   21 +++++++++++++++++++--
 1 files changed, 19 insertions(+), 2 deletions(-)

diff --git a/t/gitweb-lib.sh b/t/gitweb-lib.sh
index 8c490c8..8b5b987 100755
--- a/t/gitweb-lib.sh
+++ b/t/gitweb-lib.sh
@@ -32,17 +32,34 @@ EOF
 	cat >.git/description <<EOF
 $0 test repository
 EOF
+
+	# You can set the GITWEB_TEST_INSTALLED environment variable to
+	# the gitwebdir (the directory where gitweb is installed / deployed to)
+	# of an existing gitweb instalation to test that installation,
+	# or simply to pathname of installed gitweb script.
+	if test -n "$GITWEB_TEST_INSTALLED" ; then
+		if test -d $GITWEB_TEST_INSTALLED; then
+			SCRIPT_NAME="$GITWEB_TEST_INSTALLED/gitweb.cgi"
+		else
+			SCRIPT_NAME="$GITWEB_TEST_INSTALLED"
+		fi
+		test -f "$SCRIPT_NAME" ||
+		error "Cannot find gitweb at $GITWEB_TEST_INSTALLED."
+		say "# Testing $SCRIPT_NAME"
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
1.7.3
