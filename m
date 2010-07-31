From: =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>
Subject: [PATCH] test-lib: Ignore --quiet under a TAP harness
Date: Sat, 31 Jul 2010 16:40:05 +0000
Message-ID: <1280594405-31572-1-git-send-email-avarab@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Jul 31 18:40:22 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OfF6j-0007HF-P2
	for gcvg-git-2@lo.gmane.org; Sat, 31 Jul 2010 18:40:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754617Ab0GaQkP convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 31 Jul 2010 12:40:15 -0400
Received: from mail-wy0-f174.google.com ([74.125.82.174]:44692 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751978Ab0GaQkO (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 31 Jul 2010 12:40:14 -0400
Received: by wyb39 with SMTP id 39so2084244wyb.19
        for <git@vger.kernel.org>; Sat, 31 Jul 2010 09:40:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:mime-version:content-type
         :content-transfer-encoding;
        bh=nd2FXyDdiE4niRPImqpwgLvA48Qh8p5NrOo3CpDuQ2E=;
        b=APkTPNB0b6UkP0k8SvdVB0k1SQ/afzsxui3JYchvv+dXruOObk9/oy0x5nw89kDZYj
         Ww03IaL5abSMrtcSBCmY5Z+Yv1ZoNnvew/mssJtQaRbqxZ0s+k0Rv1VlHPZvpV3UUdcp
         HgmC2fl5lmh+X+ZhFzpc7acAjcE5Jk5h1kxo8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:mime-version
         :content-type:content-transfer-encoding;
        b=FX8Zch4ZAApBHC+jwlzVZBRx8wwEnpH9fhSiDbRnfkdXx9zuag8XuoS/dEF5V9fHmE
         c8bCo+bqDRWE2Yq2grN/RO5SGCOqJS3/f/aqdi7UebmYi0t6PdOiPf/FJWm7mjqc4CG8
         ak3ptAZmUolVNKGQrYBn7g5LNxoHQnxPx6ItQ=
Received: by 10.216.11.66 with SMTP id 44mr2989896wew.69.1280594412299;
        Sat, 31 Jul 2010 09:40:12 -0700 (PDT)
Received: from v.nix.is (v.nix.is [109.74.193.250])
        by mx.google.com with ESMTPS id v11sm1831075weq.40.2010.07.31.09.40.10
        (version=SSLv3 cipher=RC4-MD5);
        Sat, 31 Jul 2010 09:40:11 -0700 (PDT)
X-Mailer: git-send-email 1.7.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/152332>

Running the tests with --quiet under a TAP harness will always fail,
since a TAP harness always needs actual test output to go along with
the plan that's being emitted.

Change the test-lib.sh to ignore the --quiet option under
HARNESS_ACTIVE to work around this. Then users that have --quiet in
their GIT_TEST_OPTS can run tests under prove(1) without everything
breaking.

Signed-off-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com=
>
---
 t/test-lib.sh |    4 +++-
 1 files changed, 3 insertions(+), 1 deletions(-)

diff --git a/t/test-lib.sh b/t/test-lib.sh
index e5523dd..4b95138 100644
--- a/t/test-lib.sh
+++ b/t/test-lib.sh
@@ -127,7 +127,9 @@ do
 	-v|--v|--ve|--ver|--verb|--verbo|--verbos|--verbose)
 		verbose=3Dt; shift ;;
 	-q|--q|--qu|--qui|--quie|--quiet)
-		quiet=3Dt; shift ;;
+		# Ignore --quiet under a TAP::Harness. Saying how many tests
+		# passed without the ok/not ok details is always an error.
+		test -z "$HARNESS_ACTIVE" && quiet=3Dt; shift ;;
 	--with-dashes)
 		with_dashes=3Dt; shift ;;
 	--no-color)
--=20
1.7.1
