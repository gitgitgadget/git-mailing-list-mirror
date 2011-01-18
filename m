From: =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>
Subject: [PATCH 2/3] t/t5400-send-pack.sh: add test_when_finished commands
Date: Tue, 18 Jan 2011 22:41:35 +0100
Message-ID: <1295386896-21828-2-git-send-email-avarab@gmail.com>
References: <1295386896-21828-1-git-send-email-avarab@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: gitster@pobox.com,
	=?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jan 18 22:42:31 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PfJJv-00031N-Du
	for gcvg-git-2@lo.gmane.org; Tue, 18 Jan 2011 22:42:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752446Ab1ARVm1 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 18 Jan 2011 16:42:27 -0500
Received: from mail-ey0-f174.google.com ([209.85.215.174]:46636 "EHLO
	mail-ey0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751668Ab1ARVm0 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 18 Jan 2011 16:42:26 -0500
Received: by mail-ey0-f174.google.com with SMTP id 27so82442eye.19
        for <git@vger.kernel.org>; Tue, 18 Jan 2011 13:42:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:from:to:cc:subject:date:message-id:x-mailer
         :in-reply-to:references:mime-version:content-type
         :content-transfer-encoding;
        bh=qWstbrElpq4L4r2f3W9H+Y88h1sXDvDmnOiXG5rCAwg=;
        b=rpsm+nFEefnECKazdEFpPK8fNLkAPRrykT2o6tLJehtAAmjAqWbkGkNX22l6lraqcR
         4gZ0VSshYHBQx9fpS9ymTvLfb8sgFKd6NuwxfehF2/Xf/tnKH6kOvtYM9O9hK4Yd0XXK
         u5NqNxLwjHclk0i+pWrJH3kF0UgA7R/VrcV5o=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        b=ZZtu/z295S2iBcp01ivAboUzXQtd/xjK9I41nO63k6hZRLWdg7sJ/KKoctx1GIv02y
         KxVMULdQjSCltF8zfkiPqaWpRJ0oErXIpuSkq55UHoBHYMbKVp7QhmOU5plV4eQlDA+S
         bR5wiH1J9tBe/NtBaw6eiYpNzuplt/yEZBfHE=
Received: by 10.213.20.78 with SMTP id e14mr6238199ebb.87.1295386945743;
        Tue, 18 Jan 2011 13:42:25 -0800 (PST)
Received: from snth.ams7.corp.booking.com (212-182-132-170.ip.telfort.nl [212.182.132.170])
        by mx.google.com with ESMTPS id t5sm4916974eeh.20.2011.01.18.13.42.24
        (version=SSLv3 cipher=RC4-MD5);
        Tue, 18 Jan 2011 13:42:24 -0800 (PST)
X-Mailer: git-send-email 1.7.2.3
In-Reply-To: <1295386896-21828-1-git-send-email-avarab@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/165224>

Change the tests in t/t5400-send-pack.sh to use test_when_finished to
unset git config variables that were set in the tests, e.g.:

    git config --unset $variable_they_set

This doesn't change the test behavior, but makes each test more
self-contained.

Signed-off-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com=
>
---
 t/t5400-send-pack.sh |    9 ++++++---
 1 files changed, 6 insertions(+), 3 deletions(-)

diff --git a/t/t5400-send-pack.sh b/t/t5400-send-pack.sh
index 656ab1a..0357610 100755
--- a/t/t5400-send-pack.sh
+++ b/t/t5400-send-pack.sh
@@ -90,7 +90,8 @@ test_expect_success 'refuse deleting push with denyDe=
letes' '
 	    git config receive.denyDeletes true &&
 	    git branch extra master
 	) &&
-	test_must_fail git send-pack ./victim :extra master
+	test_must_fail git send-pack ./victim :extra master &&
+	test_when_finished "(cd victim && git config --unset receive.denyDele=
tes)"
 '
=20
 test_expect_success 'cannot override denyDeletes with git -c send-pack=
' '
@@ -101,7 +102,8 @@ test_expect_success 'cannot override denyDeletes wi=
th git -c send-pack' '
 		git branch extra master
 	) &&
 	test_must_fail git -c receive.denyDeletes=3Dfalse \
-					send-pack ./victim :extra master
+					send-pack ./victim :extra master &&
+	test_when_finished "(cd victim && git config --unset receive.denyDele=
tes)"
 '
=20
 test_expect_success 'override denyDeletes with git -c receive-pack' '
@@ -125,7 +127,8 @@ test_expect_success 'denyNonFastforwards trumps --f=
orce' '
 	victim_orig=3D$(cd victim && git rev-parse --verify master) &&
 	test_must_fail git send-pack --force ./victim master^:master &&
 	victim_head=3D$(cd victim && git rev-parse --verify master) &&
-	test "$victim_orig" =3D "$victim_head"
+	test "$victim_orig" =3D "$victim_head" &&
+	test_when_finished "(cd victim && git config --unset receive.denyNonF=
astforwards)"
 '
=20
 test_expect_success 'push --all excludes remote-tracking hierarchy' '
--=20
1.7.2.3
