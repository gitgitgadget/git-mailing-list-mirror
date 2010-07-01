From: =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>
Subject: [PATCH v2 4/8] t/README: Document the prereq functions, and 3-arg test_*
Date: Thu,  1 Jul 2010 20:17:54 +0000
Message-ID: <1278015478-6920-5-git-send-email-avarab@gmail.com>
References: <1278015478-6920-1-git-send-email-avarab@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	=?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jul 01 22:19:52 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OUQEg-00043E-Jm
	for gcvg-git-2@lo.gmane.org; Thu, 01 Jul 2010 22:19:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757188Ab0GAUTm convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 1 Jul 2010 16:19:42 -0400
Received: from mail-ww0-f44.google.com ([74.125.82.44]:58918 "EHLO
	mail-ww0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756672Ab0GAUTl (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 1 Jul 2010 16:19:41 -0400
Received: by wwb24 with SMTP id 24so222550wwb.1
        for <git@vger.kernel.org>; Thu, 01 Jul 2010 13:19:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references:mime-version
         :content-type:content-transfer-encoding;
        bh=nuOHN0i3B5y4dRID++i12324bVBTVYE/ms9dEV/6hdo=;
        b=lRLN0xx79Y5YV178xAU5swleCG1a+Upu4cHABm00nEogbLH/ooPDK9BHetIcuwzil6
         10jcKbS+rEa3P11henAlD9opzca6RWLYxLWTiaQvqDXPkoawMMVYnqmVCkMwtuTWngd4
         TcW2sMRzzz7xC2hrzP/R8K4H/jEaoI+B+78p8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        b=Sw+QI14QpcaDarTr9SseUWO68EG2AdYkHiQARb/PGcpyPEe6T8UV6CEr4V6NMR27N1
         B8Yh6PY3NGf5gyS8TM3h26qBp4OJ0d+sp7fmeRoUlDPR3FM911U6OECz/4ffCv/mWZTY
         ppVXvdE3kQULHPITY7PPG0zOKYSVOa3PcFPfw=
Received: by 10.213.25.138 with SMTP id z10mr2971863ebb.84.1278015515736;
        Thu, 01 Jul 2010 13:18:35 -0700 (PDT)
Received: from localhost.localdomain ([188.105.94.3])
        by mx.google.com with ESMTPS id v8sm261986eeh.14.2010.07.01.13.18.32
        (version=SSLv3 cipher=RC4-MD5);
        Thu, 01 Jul 2010 13:18:34 -0700 (PDT)
X-Mailer: git-send-email 1.7.1.251.g92a7
In-Reply-To: <1278015478-6920-1-git-send-email-avarab@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/150079>

There was no documentation for the test_set_prereq and
test_have_prereq functions, or the three-arg form of
test_expect_success and test_expect_failure.

Signed-off-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com=
>
---
 t/README |   37 ++++++++++++++++++++++++++++++++++---
 1 files changed, 34 insertions(+), 3 deletions(-)

diff --git a/t/README b/t/README
index 1d0fd18..2df56a8 100644
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
@@ -258,7 +258,14 @@ library for your script to use.
 	    'git-write-tree should be able to write an empty tree.' \
 	    'tree=3D$(git-write-tree)'
=20
- - test_expect_failure <message> <script>
+   If you supply three parameters the first will be taken to be a
+   prerequisite, see the test_set_prereq and test_have_prereq
+   documentation below:
+
+	test_expect_success TTY 'git --paginate rev-list uses a pager' \
+	    ' ... '
+
+ - test_expect_failure [<prereq>] <message> <script>
=20
    This is NOT the opposite of test_expect_success, but is used
    to mark a test that demonstrates a known breakage.  Unlike
@@ -267,6 +274,9 @@ library for your script to use.
    success and "still broken" on failure.  Failures from these
    tests won't cause -i (immediate) to stop.
=20
+   Like test_expect_success this function can optionally use a three
+   argument invocation with a prerequisite as the first argument.
+
  - test_debug <script>
=20
    This takes a single argument, <script>, and evaluates it only
@@ -299,6 +309,27 @@ library for your script to use.
    Merges the given rev using the given message.  Like test_commit,
    creates a tag and calls test_tick before committing.
=20
+ - test_set_prereq SOME_PREREQ
+
+   Set a test prerequisite to be used later with test_have_prereq. The
+   test-lib will set some prerequisites for you, e.g. PERL and PYTHON
+   which are derived from ./GIT-BUILD-OPTIONS (grep test_set_prereq
+   test-lib.sh for more). Others you can set yourself and use later
+   with either test_have_prereq directly, or the three argument
+   invocation of test_expect_success and test_expect_failure.
+
+ - test_have_prereq SOME PREREQ
+
+   Check if we have a prerequisite previously set with
+   test_set_prereq. The most common use of this directly is to skip
+   all the tests if we don't have some essential prerequisite:
+
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
