From: Brandon Casey <casey@nrlssc.navy.mil>
Subject: [PATCH jh/cvs-helper 2/2] t/test-lib.sh: don't perform python preparations when NO_PYTHON is set
Date: Thu, 27 Aug 2009 11:24:24 -0500
Message-ID: <Rxz2NOwzg1UZ0TgAtOhrAzUAMAnO9FMOUVyBSREU0jlWw8GgmyUyfh_Kw3hSgy17_1U6jTxx7pE@cipher.nrlssc.navy.mil>
References: <Rxz2NOwzg1UZ0TgAtOhrA7e8wE02XwcSzNC9cc1EL_W_oN1BjtZn8ClmG5zKB_DKmTgVP0PlMYI@cipher.nrlssc.navy.mil> <Rxz2NOwzg1UZ0TgAtOhrA7dGx1obNszSQLoUJ4IoUGJk5ekFKeKU4vpg535nyOx20P_IWNiudJo@cipher.nrlssc.navy.mil>
Cc: gitster@pobox.com, johan@herland.net,
	Brandon Casey <drafnel@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Aug 27 18:24:48 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MghmK-0008BN-CH
	for gcvg-git-2@lo.gmane.org; Thu, 27 Aug 2009 18:24:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752778AbZH0QYj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 27 Aug 2009 12:24:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751962AbZH0QYj
	(ORCPT <rfc822;git-outgoing>); Thu, 27 Aug 2009 12:24:39 -0400
Received: from mail1.nrlssc.navy.mil ([128.160.35.1]:53492 "EHLO
	mail.nrlssc.navy.mil" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751954AbZH0QYj (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 27 Aug 2009 12:24:39 -0400
Received: by mail.nrlssc.navy.mil id n7RGOZaG011043; Thu, 27 Aug 2009 11:24:35 -0500
In-Reply-To: <Rxz2NOwzg1UZ0TgAtOhrA7dGx1obNszSQLoUJ4IoUGJk5ekFKeKU4vpg535nyOx20P_IWNiudJo@cipher.nrlssc.navy.mil>
X-OriginalArrivalTime: 27 Aug 2009 16:24:34.0657 (UTC) FILETIME=[DD350D10:01CA2732]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/127172>

From: Brandon Casey <drafnel@gmail.com>

When setting GITPYTHONLIB, a check is performed to test whether the path
that GITPYTHONLIB is set to is a valid directory.  This test always fails
when NO_PYTHON is set since git_remote_cvs is not built.  So add a test
on NO_PYTHON to the conditional that protects this section.

Additionally, move this section down so it is done _after_
GIT-BUILD-OPTIONS is sourced, so that the NO_PYTHON setting is available.

Signed-off-by: Brandon Casey <casey@nrlssc.navy.mil>
---
 t/test-lib.sh |   18 +++++++++---------
 1 files changed, 9 insertions(+), 9 deletions(-)

diff --git a/t/test-lib.sh b/t/test-lib.sh
index a7fbfef..d95c66b 100644
--- a/t/test-lib.sh
+++ b/t/test-lib.sh
@@ -638,15 +638,6 @@ test -d ../templates/blt || {
 	error "You haven't built things yet, have you?"
 }
 
-if test -z "$GIT_TEST_INSTALLED"
-then
-	GITPYTHONLIB="$(pwd)/../git_remote_cvs/build/lib"
-	export GITPYTHONLIB
-	test -d ../git_remote_cvs/build || {
-		error "You haven't built git_remote_cvs yet, have you?"
-	}
-fi
-
 if ! test -x ../test-chmtime; then
 	echo >&2 'You need to build test-chmtime:'
 	echo >&2 'Run "make test-chmtime" in the source (toplevel) directory'
@@ -655,6 +646,15 @@ fi
 
 . ../GIT-BUILD-OPTIONS
 
+if test -z "$NO_PYTHON" -a -z "$GIT_TEST_INSTALLED"
+then
+	GITPYTHONLIB="$(pwd)/../git_remote_cvs/build/lib"
+	export GITPYTHONLIB
+	test -d ../git_remote_cvs/build || {
+		error "You haven't built git_remote_cvs yet, have you?"
+	}
+fi
+
 # Test repository
 test="trash directory.$(basename "$0" .sh)"
 test -n "$root" && test="$root/$test"
-- 
1.6.4
