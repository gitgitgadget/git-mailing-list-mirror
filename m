From: =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>
Subject: [PATCH v2 1/4] test-lib: Use $TEST_DIRECTORY or $GIT_BUILD_DIR instead of $(pwd) and ../
Date: Wed, 18 Aug 2010 13:34:30 +0000
Message-ID: <1282138473-15613-2-git-send-email-avarab@gmail.com>
References: <7vpqxhaw92.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Aug 18 15:34:53 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Olin4-0005UR-Vo
	for gcvg-git-2@lo.gmane.org; Wed, 18 Aug 2010 15:34:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752997Ab0HRNes convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 18 Aug 2010 09:34:48 -0400
Received: from mail-ww0-f44.google.com ([74.125.82.44]:60840 "EHLO
	mail-ww0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753171Ab0HRNer (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 18 Aug 2010 09:34:47 -0400
Received: by wwi17 with SMTP id 17so841571wwi.1
        for <git@vger.kernel.org>; Wed, 18 Aug 2010 06:34:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references:mime-version
         :content-type:content-transfer-encoding;
        bh=hbrjp+crAX+tqHgTjhjjWyuatycDpqa72+IzvKigiIo=;
        b=Q+i9Qc2kmHZaLxbKQfT0mdsKidWyPUtHXJyDbWdOafqfVlDED7g5d8sPm6tfELWm4a
         EfiG0ESflr4tS9RoQULL9WKK+aIY3iTPiFmlj55PsIHZHtkLZTAVxW4x2kOVUtQ3BJ0S
         8PxI/95RdduPX8FRexlOHyqUnhNK6OGs1BWPE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        b=dv7SSgp6Rwd22nZ8xOTECOeanxUvLTZWrqUzJlxU0d7CuEtZDW7NI+STXOKMsNSZEg
         vmRGEaIiNhWoUvnRjWTMCG+j7TpHgwE3ofAugrxWlyuw5fD+OMt0XVj2tz0uLbN6MSg4
         stcZPmHM9+mnXFn+HPqC5O1Rx9/w9XEXtzI8Y=
Received: by 10.227.128.134 with SMTP id k6mr7211182wbs.23.1282138485920;
        Wed, 18 Aug 2010 06:34:45 -0700 (PDT)
Received: from v.nix.is (v.nix.is [109.74.193.250])
        by mx.google.com with ESMTPS id r10sm230012wbe.18.2010.08.18.06.34.45
        (version=SSLv3 cipher=RC4-MD5);
        Wed, 18 Aug 2010 06:34:45 -0700 (PDT)
X-Mailer: git-send-email 1.7.2.1.414.g9bf49
In-Reply-To: <7vpqxhaw92.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/153843>

Change the redundant calls to $(pwd) to use $TEST_DIRECTORY
instead. None of these were being executed after we cd'd somewhere
else so they weren't actually needed.

This also makes it easier to add support for overriding the test
library location and run tests in a different directory than t/.

Signed-off-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com=
>
---
 t/test-lib.sh |   16 ++++++++--------
 1 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/t/test-lib.sh b/t/test-lib.sh
index 5bb7662..0e460f9 100644
--- a/t/test-lib.sh
+++ b/t/test-lib.sh
@@ -830,14 +830,14 @@ else # normal case, use ../bin-wrappers only unle=
ss $with_dashes:
 		PATH=3D"$TEST_DIRECTORY/..:$PATH"
 	fi
 fi
-GIT_BUILD_DIR=3D$(pwd)/..
-GIT_TEMPLATE_DIR=3D$(pwd)/../templates/blt
+GIT_BUILD_DIR=3D"$TEST_DIRECTORY"/..
+GIT_TEMPLATE_DIR=3D"$TEST_DIRECTORY"/../templates/blt
 unset GIT_CONFIG
 GIT_CONFIG_NOSYSTEM=3D1
 GIT_CONFIG_NOGLOBAL=3D1
 export PATH GIT_EXEC_PATH GIT_TEMPLATE_DIR GIT_CONFIG_NOSYSTEM GIT_CON=
=46IG_NOGLOBAL
=20
-. ../GIT-BUILD-OPTIONS
+. "$GIT_BUILD_DIR"/GIT-BUILD-OPTIONS
=20
 if test -z "$GIT_TEST_CMP"
 then
@@ -849,22 +849,22 @@ then
 	fi
 fi
=20
-GITPERLLIB=3D$(pwd)/../perl/blib/lib:$(pwd)/../perl/blib/arch/auto/Git
+GITPERLLIB=3D"$TEST_DIRECTORY"/../perl/blib/lib:"$TEST_DIRECTORY"/../p=
erl/blib/arch/auto/Git
 export GITPERLLIB
-test -d ../templates/blt || {
+test -d "$TEST_DIRECTORY"/../templates/blt || {
 	error "You haven't built things yet, have you?"
 }
=20
 if test -z "$GIT_TEST_INSTALLED" && test -z "$NO_PYTHON"
 then
-	GITPYTHONLIB=3D"$(pwd)/../git_remote_helpers/build/lib"
+	GITPYTHONLIB=3D"$TEST_DIRECTORY/../git_remote_helpers/build/lib"
 	export GITPYTHONLIB
-	test -d ../git_remote_helpers/build || {
+	test -d "$TEST_DIRECTORY"/../git_remote_helpers/build || {
 		error "You haven't built git_remote_helpers yet, have you?"
 	}
 fi
=20
-if ! test -x ../test-chmtime; then
+if ! test -x "$TEST_DIRECTORY"/../test-chmtime; then
 	echo >&2 'You need to build test-chmtime:'
 	echo >&2 'Run "make test-chmtime" in the source (toplevel) directory'
 	exit 1
--=20
1.7.2.1.414.g9bf49
