From: =?utf-8?q?Santi=20B=C3=A9jar?= <sbejar@gmail.com>
Subject: [PATCH] test-lib: Allow to be used by contrib projects
Date: Thu, 12 Jun 2008 21:13:52 +0200
Message-ID: <1213298033-6086-1-git-send-email-sbejar@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?utf-8?q?Santi=20B=C3=A9jar?= <sbejar@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jun 12 21:14:46 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K6sFr-0005HN-Rv
	for gcvg-git-2@gmane.org; Thu, 12 Jun 2008 21:14:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752042AbYFLTNo convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 12 Jun 2008 15:13:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752645AbYFLTNo
	(ORCPT <rfc822;git-outgoing>); Thu, 12 Jun 2008 15:13:44 -0400
Received: from fg-out-1718.google.com ([72.14.220.158]:40607 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750894AbYFLTNn (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 12 Jun 2008 15:13:43 -0400
Received: by fg-out-1718.google.com with SMTP id 19so2576373fgg.17
        for <git@vger.kernel.org>; Thu, 12 Jun 2008 12:13:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:mime-version:content-type
         :content-transfer-encoding;
        bh=nnS8TJV9c2Iqdk1jDHsfv1h4ple3fc0PAAPrpc4mV9o=;
        b=j57y1RQiJZGu7LYxv4OtPmJ5emlSqybA+OtZzVACUbKfSTyBCvDAHDChwMg+JIo0xx
         mwK/90nV+Ol1/LoroamtRYLU1UMGpeZP8wreTwuqtXy3Q1IFAG1sQuowvqeXZBAfb2HJ
         AFmPjzUUBdXuThxUafZxEgIhyT88kF+mD59dg=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:mime-version
         :content-type:content-transfer-encoding;
        b=NBBQBm63NxNfwUvC+RFLIfAua79wy+Lcm2W/RCKtQLyep7vFmQtZFvFcrhWgzdDCjc
         zth9eGBtRjSsfFxSkNzfKKjC+xm+G/R3h+UrcAHqGYCdjq9V/uFJMDovp6s72HDx9VH+
         z3xhAaZ4D9TNJyMpFeDHDd8VVh3V8YMcy2UBs=
Received: by 10.86.100.19 with SMTP id x19mr2803346fgb.61.1213298022102;
        Thu, 12 Jun 2008 12:13:42 -0700 (PDT)
Received: from localhost ( [91.13.108.184])
        by mx.google.com with ESMTPS id d4sm3462351fga.8.2008.06.12.12.13.40
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Thu, 12 Jun 2008 12:13:41 -0700 (PDT)
X-Mailer: git-send-email 1.5.6.rc2.28.gc1eec
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/84772>

The contrib project can have test scripts like the ones in git.git.

They only need a test-lib.sh and a Makefile like the following:

[test-lib.sh]

GIT_TEST_DIR=3D$(pwd)/../../../t
PATH=3D$(pwd)/..:$PATH
=2E ../../../t/test-lib.sh

[end of test-lib.sh]

[Makefile]
include ../../../t/Makefile

Signed-off-by: Santi B=C3=A9jar <sbejar@gmail.com>
---
 t/test-lib.sh |   15 ++++++++-------
 1 files changed, 8 insertions(+), 7 deletions(-)

diff --git a/t/test-lib.sh b/t/test-lib.sh
index 7a8bd27..62976da 100644
--- a/t/test-lib.sh
+++ b/t/test-lib.sh
@@ -387,28 +387,29 @@ test_done () {
=20
 # Test the binaries we have just built.  The tests are kept in
 # t/ subdirectory and are run in trash subdirectory.
-PATH=3D$(pwd)/..:$PATH
-GIT_EXEC_PATH=3D$(pwd)/..
-GIT_TEMPLATE_DIR=3D$(pwd)/../templates/blt
+[ -z "$GIT_TEST_DIR" ] && GIT_TEST_DIR=3D$(pwd)
+PATH=3D$GIT_TEST_DIR/..:$PATH
+GIT_EXEC_PATH=3D$GIT_TEST_DIR/..
+GIT_TEMPLATE_DIR=3D$GIT_TEST_DIR/../templates/blt
 unset GIT_CONFIG
 unset GIT_CONFIG_LOCAL
 GIT_CONFIG_NOSYSTEM=3D1
 GIT_CONFIG_NOGLOBAL=3D1
 export PATH GIT_EXEC_PATH GIT_TEMPLATE_DIR GIT_CONFIG_NOSYSTEM GIT_CON=
=46IG_NOGLOBAL
=20
-GITPERLLIB=3D$(pwd)/../perl/blib/lib:$(pwd)/../perl/blib/arch/auto/Git
+GITPERLLIB=3D$GIT_TEST_DIR/../perl/blib/lib:$GIT_TEST_DIR/../perl/blib=
/arch/auto/Git
 export GITPERLLIB
-test -d ../templates/blt || {
+test -d "$GIT_TEMPLATE_DIR" || {
 	error "You haven't built things yet, have you?"
 }
=20
-if ! test -x ../test-chmtime; then
+if ! test -x $GIT_TEST_DIR/../test-chmtime; then
 	echo >&2 'You need to build test-chmtime:'
 	echo >&2 'Run "make test-chmtime" in the source (toplevel) directory'
 	exit 1
 fi
=20
-. ../GIT-BUILD-OPTIONS
+. $GIT_TEST_DIR/../GIT-BUILD-OPTIONS
=20
 # Test repository
 test=3D"trash directory"
--=20
1.5.5.3
