From: =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>
Subject: [PATCH v2 1/4] test-lib: Use $TEST_DIRECTORY or $GIT_BUILD_DIR instead of $(pwd) and ../
Date: Thu, 19 Aug 2010 16:05:58 +0000
Message-ID: <1282233961-27203-2-git-send-email-avarab@gmail.com>
References: <1282138473-15613-1-git-send-email-avarab@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Aug 19 18:07:08 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Om7dw-0000My-7G
	for gcvg-git-2@lo.gmane.org; Thu, 19 Aug 2010 18:07:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752350Ab0HSQGe convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 19 Aug 2010 12:06:34 -0400
Received: from mail-ww0-f44.google.com ([74.125.82.44]:52686 "EHLO
	mail-ww0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751696Ab0HSQGc (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 19 Aug 2010 12:06:32 -0400
Received: by wwi17 with SMTP id 17so2637367wwi.1
        for <git@vger.kernel.org>; Thu, 19 Aug 2010 09:06:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references:mime-version
         :content-type:content-transfer-encoding;
        bh=hbrjp+crAX+tqHgTjhjjWyuatycDpqa72+IzvKigiIo=;
        b=OsbkEIzF3EGIPQvDGv8ZQnqWsBayeRoMC09pKItpISKlwF4YnT2ixwP+Mw400GZWWN
         ZDt+1qtSS1tP1m7FKk1Jd/JLGEcRGggm+bUs2E68leVvKfe7uTk33K5zy2WgeeDAA8jI
         wGj6uGXoridYXn+CYjmXnUV2Iu6tjr9ufR8ds=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        b=WxnS7HheutbxgzjKX3OKsiVmdPBPzcH00uxZLld/G41uZj49/Oiz9isLrbxS5Tn2a5
         jD7mhQM+7+7KGU35bMGL+qH6OLZmQ/aY3kMAKIwPUMUZd+0ScOd52kb4wllnd4R3qmu7
         BkUrEodF5cjd1/naQYBxjarpvb8vqWod1QnA8=
Received: by 10.227.133.81 with SMTP id e17mr8022wbt.186.1282233991435;
        Thu, 19 Aug 2010 09:06:31 -0700 (PDT)
Received: from v.nix.is (v.nix.is [109.74.193.250])
        by mx.google.com with ESMTPS id q17sm470663wbe.12.2010.08.19.09.06.30
        (version=SSLv3 cipher=RC4-MD5);
        Thu, 19 Aug 2010 09:06:30 -0700 (PDT)
X-Mailer: git-send-email 1.7.2.1.446.g168052
In-Reply-To: <1282138473-15613-1-git-send-email-avarab@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/153932>

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
