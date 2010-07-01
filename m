From: =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>
Subject: [PATCH 4/8] t/README: Document the prereq functions, and 3-arg test_*
Date: Thu,  1 Jul 2010 15:10:00 +0000
Message-ID: <1277997004-29504-5-git-send-email-avarab@gmail.com>
References: <1277997004-29504-1-git-send-email-avarab@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jul 01 17:15:08 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with smtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OULTo-00006b-Ag
	for gcvg-git-2@lo.gmane.org; Thu, 01 Jul 2010 17:15:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754840Ab0GAPKw convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 1 Jul 2010 11:10:52 -0400
Received: from mail-ew0-f46.google.com ([209.85.215.46]:52296 "EHLO
	mail-ew0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753916Ab0GAPKv (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 1 Jul 2010 11:10:51 -0400
Received: by ewy23 with SMTP id 23so812543ewy.19
        for <git@vger.kernel.org>; Thu, 01 Jul 2010 08:10:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references:mime-version
         :content-type:content-transfer-encoding;
        bh=e4lyNwRhCaHMY/TQyxgJLBOn7cSQHJmBtpl/Ash5Cdk=;
        b=JSIN76boHemfZVH33b3BHlGaF4rM1lsJKFMJgR/Hc2AR2MtFYHe7/JXQESh0kKAD1X
         I3D+mDgXCTBjThPBlOY+jA8eEKyf0fsk1FZKSBZ+c0BOuScFzsyh9u3cFOL1NkiCavK0
         yvkm0l7vTAXPbIsGX9jcslNwD9Lbz10GCYweY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        b=i12/OOfyxF+PPJV5uE2XhV1B5+gS8xH95o7J4joMQ1QEMLI3OphSE6F6WuHTGmUV2t
         vlB7hVmN8cHp+vAquWZJBuUfPIoLlgLdeTby7uW4WtEakamziU18N5uJg7Dqr3fIij5Z
         FmPZS+FQbFOxm81H3DCj3thnxW8Y+QHjV0WTw=
Received: by 10.213.34.77 with SMTP id k13mr5610462ebd.88.1277997049707;
        Thu, 01 Jul 2010 08:10:49 -0700 (PDT)
Received: from localhost.localdomain ([188.105.94.3])
        by mx.google.com with ESMTPS id v59sm10377672eeh.12.2010.07.01.08.10.48
        (version=SSLv3 cipher=RC4-MD5);
        Thu, 01 Jul 2010 08:10:48 -0700 (PDT)
X-Mailer: git-send-email 1.7.1.251.g92a7
In-Reply-To: <1277997004-29504-1-git-send-email-avarab@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/150041>

There was no documentation for the test_set_prereq and
test_have_prereq functions, or the three-arg form of
test_expect_success and test_expect_failure.

Signed-off-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com=
>
---
 t/README |   37 ++++++++++++++++++++++++++++++++++---
 1 files changed, 34 insertions(+), 3 deletions(-)

diff --git a/t/README b/t/README
index 0998bfb..67f8f30 100644
--- a/t/README
+++ b/t/README
@@ -246,9 +246,9 @@ Test harness library
 There are a handful helper functions defined in the test harness
 library for your script to use.
=20
- - test_expect_success <message> <script>
+ - test_expect_success [<prereq>] <message> <script>
=20
-   This takes two strings as parameter, and evaluates the
+   Usually takes two strings as parameter, and evaluates the
    <script>.  If it yields success, test is considered
    successful.  <message> should state what it is testing.
=20
@@ -257,8 +257,15 @@ library for your script to use.
 	test_expect_success \
 	    'git-write-tree should be able to write an empty tree.' \
 	    'tree=3D$(git-write-tree)'
+       =20
+   If you supply three parameters the first will be taken to be a
+   prerequisite, see the test_set_prereq and test_have_prereq
+   documentation below:
=20
- - test_expect_failure <message> <script>
+	test_expect_success TTY 'git --paginate rev-list uses a pager' \
+	    ' ... '
+
+ - test_expect_failure [<prereq>] <message> <script>
=20
    This is NOT the opposite of test_expect_success, but is used
    to mark a test that demonstrates a known breakage.  Unlike
@@ -266,6 +273,9 @@ library for your script to use.
    success and "FAIL" on failure, this will say "FIXED" on
    success and "still broken" on failure.  Failures from these
    tests won't cause -i (immediate) to stop.
+  =20
+   Like test_expect_success this function can optionally use a three
+   argument invocation with a prerequisite as the first argument.
=20
  - test_debug <script>
=20
@@ -299,6 +309,27 @@ library for your script to use.
    Merges the given rev using the given message.  Like test_commit,
    creates a tag and calls test_tick before committing.
=20
+ - test_set_prereq SOME_PREREQ
+=20
+   Set a test prerequisite to be used later with test_have_prereq. The
+   test-lib will set some prerequisites for you, e.g. PERL and PYTHON
+   which are derived from ./GIT-BUILD-OPTIONS (grep test_set_prereq
+   test-lib.sh for more). Others you can set yourself and use later
+   with either test_have_prereq directly, or the three argument
+   invocation of test_expect_success and test_expect_failure.
+  =20
+ - test_have_prereq SOME PREREQ
+
+   Check if we have a prerequisite previously set with
+   test_set_prereq. The most common use of this directly is to skip
+   all the tests if we don't have some essential prerequisite:
+=20
+	if ! test_have_prereq PERL
+	then
+	    skip_all=3D'skipping perl interface tests, perl not available'
+	    test_done
+	fi
+
 Tips for Writing Tests
 ----------------------
=20
--=20
1.7.1.251.g92a7
