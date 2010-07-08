From: =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>
Subject: [PATCH] grep: Don't pass a TODO test if REG_STARTEND is supported
Date: Thu,  8 Jul 2010 00:42:15 +0000
Message-ID: <1278549735-19278-1-git-send-email-avarab@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jul 08 02:42:48 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OWfCR-0008GM-1N
	for gcvg-git-2@lo.gmane.org; Thu, 08 Jul 2010 02:42:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757048Ab0GHAml convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 7 Jul 2010 20:42:41 -0400
Received: from mail-ew0-f46.google.com ([209.85.215.46]:40625 "EHLO
	mail-ew0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754946Ab0GHAmk (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 7 Jul 2010 20:42:40 -0400
Received: by ewy23 with SMTP id 23so69675ewy.19
        for <git@vger.kernel.org>; Wed, 07 Jul 2010 17:42:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:mime-version:content-type
         :content-transfer-encoding;
        bh=h/wL0kRGL6OEHs6wt3AEV2Tu1EFYvGzAoTnQGatW6eU=;
        b=RKaudoUbKKTm0PUlkBTlm/80NdazF8qdn3/l73KYwCjKzvFyEmMuCY2qhmpehCZYql
         J0YNNh/Q+E1sKHhVsvobRM4JwpEA58pU6ULw9QfWk5+LklwB4sOaIa8yYmQWsk1QKJG+
         NoNO8Rwv9L0qEaZDwIxPv4hhJzJBe2aOi3w8w=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:mime-version
         :content-type:content-transfer-encoding;
        b=HsRA+OGF9EygEB25b4UobkO3D+ouYfrZZotkp7arSfH8aCVKWlG7ekqqebnYMEkLT7
         h+sTIhHXz1XhBamkXXM50Eb1R/zLiU6Y0cEQOtKN9dVSHOLaqQCd4zsWDzZCOIUFbeDW
         CsJJ/hn+TD2815yQnxZeKllYJEPjNZc0k/lP0=
Received: by 10.213.8.134 with SMTP id h6mr6245357ebh.95.1278549759233;
        Wed, 07 Jul 2010 17:42:39 -0700 (PDT)
Received: from localhost.localdomain ([188.105.94.3])
        by mx.google.com with ESMTPS id z55sm65973186eeh.21.2010.07.07.17.42.37
        (version=SSLv3 cipher=RC4-MD5);
        Wed, 07 Jul 2010 17:42:38 -0700 (PDT)
X-Mailer: git-send-email 1.7.0.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/150522>

Change the git grep test that utilizes the REG_STARTEND flag so that
it doesn't TODO pass on platforms where REG_STARTEND is supported.

Git's own harness doesn't care, but a TAP harness will report all TODO
tests that pass. Having t7008-grep-binary.sh be the only test (aside
from the test-lib.sh test) that passes a TODO test is distracting.

Before prove(1)'s test summary looked like this:

    All tests successful.

    Test Summary Report
    -------------------
    ./t0000-basic.sh                        (Wstat: 0 Tests: 46 Failed:=
 0)
      TODO passed:   5
    ./t7008-grep-binary.sh                  (Wstat: 0 Tests: 18 Failed:=
 0)
      TODO passed:   11
    Files=3D476, Tests=3D6071, [...]
    Result: PASS

And now it'll give:

    All tests successful.

    Test Summary Report
    -------------------
    ./t0000-basic.sh                        (Wstat: 0 Tests: 46 Failed:=
 0)
      TODO passed:   5
    Files=3D476, Tests=3D6071,

Signed-off-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com=
>
---
 t/t7008-grep-binary.sh |   15 ++++++++++-----
 1 files changed, 10 insertions(+), 5 deletions(-)

diff --git a/t/t7008-grep-binary.sh b/t/t7008-grep-binary.sh
index eb8ca88..6fd2b40 100755
--- a/t/t7008-grep-binary.sh
+++ b/t/t7008-grep-binary.sh
@@ -59,11 +59,16 @@ test_expect_success 'git grep -Fi iLE a' '
 	git grep -Fi iLE a
 '
=20
-# This test actually passes on platforms where regexec() supports the
-# flag REG_STARTEND.
-test_expect_failure 'git grep ile a' '
-	git grep ile a
-'
+if git grep ile a
+then
+	# This only passes on platforms where regexec() supports the
+	# REG_STARTEND flag.
+	test_expect_success 'git grep ile a' 'git grep ile a'
+else
+	# On platforms where REG_STARTEND isn't supported we mark the
+	# failure as a TODO.
+	test_expect_failure 'git grep ile a' 'git grep ile a'
+fi
=20
 test_expect_failure 'git grep .fi a' '
 	git grep .fi a
--=20
1.7.0.4
