From: =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>
Subject: [PATCH] t/t0000-basic.sh: Don't run a passing TODO unless TEST_PASSING_TODO=1
Date: Tue, 17 Aug 2010 09:43:54 +0000
Message-ID: <1282038234-1880-1-git-send-email-avarab@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Aug 17 11:44:20 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OlIiR-0002FL-Ta
	for gcvg-git-2@lo.gmane.org; Tue, 17 Aug 2010 11:44:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757436Ab0HQJoO convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 17 Aug 2010 05:44:14 -0400
Received: from mail-wy0-f174.google.com ([74.125.82.174]:44625 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756784Ab0HQJoN (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 17 Aug 2010 05:44:13 -0400
Received: by wyb32 with SMTP id 32so6819740wyb.19
        for <git@vger.kernel.org>; Tue, 17 Aug 2010 02:44:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:mime-version:content-type
         :content-transfer-encoding;
        bh=rm74Tyh/v3FmmIWFDzxH/gfDeEfP/scFukMVTudhuPU=;
        b=f/yIyJW3hiQ8FJ18JCEyj0zH0wfj+qdChB2K0u86myXwbJfPLI5KQqPqTL2lVVY0FD
         s6pJLb5DDmMWNeKBTFB5AUIv21LioVoWgjj5AoSJ6sgAA1e+0jS06GdQothVRYWfvk2e
         4i8LTbFhkJCJ6xBnZuh5L021e5+vVvxfKMW3M=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:mime-version
         :content-type:content-transfer-encoding;
        b=G9XaSfds1cx3VadzttCEmkyyEiKD78s3e8w+uL7r9sMkRl2HRmlfN3N7ypqjYu48H9
         9PSlExfzceQma2YtRc8uBEANj8XdvTv4qOSyzWhlfAY4bvuSX2WsrbOj/e+pWpjxpWkf
         Bl3q8YKOEldkIdwdL7WFz6dV4Xx4+agqAtZnI=
Received: by 10.227.129.130 with SMTP id o2mr5554560wbs.116.1282038252506;
        Tue, 17 Aug 2010 02:44:12 -0700 (PDT)
Received: from v.nix.is (v.nix.is [109.74.193.250])
        by mx.google.com with ESMTPS id u11sm3928295weq.7.2010.08.17.02.44.11
        (version=SSLv3 cipher=RC4-MD5);
        Tue, 17 Aug 2010 02:44:11 -0700 (PDT)
X-Mailer: git-send-email 1.7.2.1.389.gc3d0b
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/153742>

Change the sanity tests in t/t0000-basic.sh to not to run a passing
TODO test unless the TEST_PASSING_TODO environment variable is set.

The motivation is to have nothing out of the ordinary on a normal test
run for test smoking purposes.

If every normal test run has a passing TODO you're more likely to turn
a blind eye to it and not to investigate cases where things really are
passing unexpectedly.

It also makes the prove(1) output less noisy. Before:

    All tests successful.

    Test Summary Report
    -------------------
    ./t0000-basic.sh                                   (Wstat: 0 Tests:=
 46 Failed: 0)
      TODO passed:   5
    Files=3D484, Tests=3D6229, 143 wallclock secs ( 4.00 usr  4.15 sys =
+ 104.77 cusr 351.57 csys =3D 464.49 CPU)
    Result: PASS

And after:

    All tests successful.
    Files=3D484, Tests=3D6228, 139 wallclock secs ( 4.07 usr  4.25 sys =
+ 104.54 cusr 350.85 csys =3D 463.71 CPU)
    Result: PASS

Signed-off-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com=
>
---
 t/t0000-basic.sh |   11 ++++++++---
 1 files changed, 8 insertions(+), 3 deletions(-)

diff --git a/t/t0000-basic.sh b/t/t0000-basic.sh
index f2c7336..2f6a17b 100755
--- a/t/t0000-basic.sh
+++ b/t/t0000-basic.sh
@@ -54,9 +54,14 @@ test_expect_success 'success is reported like this' =
'
 test_expect_failure 'pretend we have a known breakage' '
     false
 '
-test_expect_failure 'pretend we have fixed a known breakage' '
-    :
-'
+if test -z "$TEST_PASSING_TODO"
+then
+	say "Not testing a known breakage, set TEST_PASSING_TODO=3D1 to enabl=
e"
+else
+	test_expect_failure 'pretend we have fixed a known breakage' '
+	    :
+	'
+fi
 test_set_prereq HAVEIT
 haveit=3Dno
 test_expect_success HAVEIT 'test runs if prerequisite is satisfied' '
--=20
1.7.2.1.389.gc3d0b
