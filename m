From: Yann Droneaud <yann@droneaud.fr>
Subject: [PATCH 2/4] test-lib.sh: add test_utf8() function
Date: Thu,  6 Jan 2011 15:22:15 +0100
Message-ID: <8559d90bff6fca1c18f1cbf3530f2f4cc695f9f4.1294312018.git.yann@droneaud.fr>
References: <1274193685-5468-1-git-send-email-yann@droneaud.fr> <4BF2BABC.2010405@drmicha.warpmail.net> <1274202486.4228.22.camel@localhost> <1274720888.4838.13.camel@localhost> <cover.1294312018.git.yann@droneaud.fr>
Cc: Yann Droneaud <yann@droneaud.fr>
To: git <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu Jan 06 15:31:25 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Paqs4-0001tn-CS
	for gcvg-git-2@lo.gmane.org; Thu, 06 Jan 2011 15:31:21 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752794Ab1AFObP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 6 Jan 2011 09:31:15 -0500
Received: from smtp02.smtpout.orange.fr ([80.12.242.124]:37294 "EHLO
	smtp.smtpout.orange.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752232Ab1AFObP (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 6 Jan 2011 09:31:15 -0500
Received: from deela.quest-ce.net ([80.12.81.242])
	by mwinf5d25 with ME
	id sEPD1f0055DhHAg03EPDqs; Thu, 06 Jan 2011 15:23:13 +0100
Received: from deela.quest-ce.net (localhost.localdomain [127.0.0.1])
	by deela.quest-ce.net (8.14.4/8.14.4) with ESMTP id p06EMr7f031812;
	Thu, 6 Jan 2011 15:23:06 +0100
Received: (from ydroneaud@localhost)
	by deela.quest-ce.net (8.14.4/8.14.4/Submit) id p06EMr54031811;
	Thu, 6 Jan 2011 15:22:53 +0100
X-Mailer: git-send-email 1.7.3.4
In-Reply-To: <cover.1294312018.git.yann@droneaud.fr>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/164633>

test_utf8() checks for en_US.UTF-8 locale availability using lib-locale.pl.
The function returns 1 if a locale was not found, otherwise it returns 0,
set prereq UTF8 and export GIT_LC_UTF8 with the locale name.

If a test needs to use an en_US.UTF-8 locale, it has to call test_utf8() first.
Then it can do tests based on prereq UTF8 availability and use LC_ALL=$GIT_LC_UTF8.

Signed-off-by: Yann Droneaud <yann@droneaud.fr>
---
 t/test-lib.sh |   14 ++++++++++++++
 1 files changed, 14 insertions(+), 0 deletions(-)

diff --git a/t/test-lib.sh b/t/test-lib.sh
index cb1ca97..3e92360 100644
--- a/t/test-lib.sh
+++ b/t/test-lib.sh
@@ -1066,6 +1066,20 @@ case $(uname -s) in
 	;;
 esac
 
+# check UTF-8 locale availability
+test_utf8 () {
+    if test_have_prereq PERL ; then
+	# output an en_US.UTF-8 locale compatible name
+	GIT_LC_UTF8=`$PERL_PATH $GIT_BUILD_DIR/t/lib-locale.pl`
+    fi
+    if test -z "$GIT_LC_UTF8" ; then
+	return 1
+    else
+	test_set_prereq UTF8
+	return 0
+    fi
+}
+
 test -z "$NO_PERL" && test_set_prereq PERL
 test -z "$NO_PYTHON" && test_set_prereq PYTHON
 
-- 
1.7.3.4
