From: Jakub Narebski <jnareb@gmail.com>
Subject: [PATCHv2 2/3] t/gitweb-lib.sh: Add support for GITWEB_TEST_INSTALLED
Date: Wed, 22 Sep 2010 16:21:25 +0200
Message-ID: <1285165286-12452-3-git-send-email-jnareb@gmail.com>
References: <1285165286-12452-1-git-send-email-jnareb@gmail.com>
Cc: Jakub Narebski <jnareb@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Sep 22 16:21:52 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OyQCm-0005b0-5H
	for gcvg-git-2@lo.gmane.org; Wed, 22 Sep 2010 16:21:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754584Ab0IVOVs (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 22 Sep 2010 10:21:48 -0400
Received: from mail-bw0-f46.google.com ([209.85.214.46]:40730 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753025Ab0IVOVr (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 22 Sep 2010 10:21:47 -0400
Received: by mail-bw0-f46.google.com with SMTP id 11so464599bwz.19
        for <git@vger.kernel.org>; Wed, 22 Sep 2010 07:21:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=TKwd1qJZpCYF3l1mdyf3ZWFybqaxtE69r/FxPf6emQI=;
        b=fzfZFJ93/6T7A7xzgd04/hoiOcJLAZA6LGr8V8TRGwoOXfylWhMWQNVExFwhHKdqug
         FfYxK4F2JnSAHKne7jkh3GNp583oNL7AJXTAQ09uNreHxkFJLDRmLVm5YBPblyYTh71a
         MIGY1YSsn+hs/+zYmHV8BEZwZZYKZSI72eIZg=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=h3z2t9skoOY4OLNYJiSZIErMJ7EHtinpvuHD9uBXz7HLiY4ZPovqqKyEEjnm8Hg9SD
         HTcNxp4DMPzA8uCN6ZmTFpOeTS7nyQpawKKBvGhU1Bi3zoZDQ6pAuW81HCJdYlYlEShd
         Iwh3qM6dDnE2d3m1ZNq2fbSyJhc4Ngjajcr9Y=
Received: by 10.204.25.207 with SMTP id a15mr141379bkc.83.1285165306066;
        Wed, 22 Sep 2010 07:21:46 -0700 (PDT)
Received: from localhost.localdomain (abva250.neoplus.adsl.tpnet.pl [83.8.198.250])
        by mx.google.com with ESMTPS id x13sm8626411bki.12.2010.09.22.07.21.44
        (version=SSLv3 cipher=RC4-MD5);
        Wed, 22 Sep 2010 07:21:45 -0700 (PDT)
X-Mailer: git-send-email 1.7.2.1
In-Reply-To: <1285165286-12452-1-git-send-email-jnareb@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/156805>

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
This patch differs from previous version, send to git mailing list as
http://thread.gmane.org/gmane.comp.version-control.git/156023/focus=156025
in the following way:

* It is no longer marked as RFC, as it was decided that description of
  GITWEB_TEST_INSTALLED in t/gitweb-lib.sh is enough, and there is no
  need to mention this variable in some of t/README, gitweb/README, or
  gitweb/INSTALL

* GITWEB_TEST_INSTALLED can be either directory where gitweb.cgi is
  installed, or a path to gitweb.cgi

* t/test-lib.sh now prints where resides gitweb.cgi it is testing if
  GITWEB_TEST_INSTALLED is set.


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
1.7.2.1
