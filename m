From: =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>
Subject: [PATCH/RFC 17/17] gettext tests: test message re-encoding under C
Date: Mon, 30 Aug 2010 21:28:23 +0000
Message-ID: <1283203703-26923-18-git-send-email-avarab@gmail.com>
References: <1283203703-26923-1-git-send-email-avarab@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Marcin Cieslak <saper@saper.info>,
	Jens Lehmann <Jens.Lehmann@web.de>,
	=?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Aug 30 23:30:11 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OqBvc-0000N5-Ox
	for gcvg-git-2@lo.gmane.org; Mon, 30 Aug 2010 23:30:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756022Ab0H3V3b convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 30 Aug 2010 17:29:31 -0400
Received: from mail-wy0-f174.google.com ([74.125.82.174]:45001 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755690Ab0H3V32 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 30 Aug 2010 17:29:28 -0400
Received: by mail-wy0-f174.google.com with SMTP id 35so7081766wyb.19
        for <git@vger.kernel.org>; Mon, 30 Aug 2010 14:29:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references:mime-version
         :content-type:content-transfer-encoding;
        bh=B/e9m+G/7oJrcLQVHhoBIsosByBXTW/tTCoprFHJjWw=;
        b=hPhiRFG/BBjAcjBQFLPZv1OPeIbexKPHiJfi/7iNh7OR+RRNxMb4C7AqsKBP16TSAA
         IbObCj3m1uM4wtKapYXm35kwQY6HtBbNn1upS4oBFVoWWAsZiwdO7008+sdbREC3/NL6
         dZz+JHgV/9KHnWgPiLaoDwELPUFPaE8ul92K8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        b=PaEy6AvjAhKnBgF28ywnWGrB0iC/PC9VQ7820w6ZjjW6RtkpUGIsxnySg6y5EcUNJ0
         ELLfd1+6sfHiIsLBRnP5ZspDOYLOLa4BiQm6hx1qYvvtFzGpEonYmGLNEUjQ/RU2xK1j
         KSLfP/FScrMA/D9o0KTMy4/dPPS+9yn2n6RmU=
Received: by 10.227.38.143 with SMTP id b15mr4629131wbe.178.1283203767412;
        Mon, 30 Aug 2010 14:29:27 -0700 (PDT)
Received: from v.nix.is (v.nix.is [109.74.193.250])
        by mx.google.com with ESMTPS id b23sm6923116wbb.22.2010.08.30.14.29.25
        (version=SSLv3 cipher=RC4-MD5);
        Mon, 30 Aug 2010 14:29:26 -0700 (PDT)
X-Mailer: git-send-email 1.7.2.2.536.g3f548
In-Reply-To: <1283203703-26923-1-git-send-email-avarab@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/154855>

Add tests for message re-encoding under C. Unlike the Shell tests
these tests will break under GNU libintl if the recent patch to
gettext.c is reverted. So this serves as a regression test for that
issue.

Signed-off-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com=
>
---
 t/t0204-gettext-reencode-sanity.sh |   14 ++++++++++++++
 1 files changed, 14 insertions(+), 0 deletions(-)

diff --git a/t/t0204-gettext-reencode-sanity.sh b/t/t0204-gettext-reenc=
ode-sanity.sh
index 1a7ea37..189af90 100755
--- a/t/t0204-gettext-reencode-sanity.sh
+++ b/t/t0204-gettext-reencode-sanity.sh
@@ -61,4 +61,18 @@ test_expect_success GETTEXT_ISO_LOCALE 'gettext: Fet=
ching a UTF-8 msgid -> ISO-8
     grep "$(echo tv=C3=B6faldar | iconv -f UTF-8 -t ISO8859-1)" actual
 '
=20
+test_expect_success GETTEXT_LOCALE 'gettext.c: git init UTF-8 -> UTF-8=
' '
+    printf "Bj=C3=B3 til t=C3=B3ma Git lind" >expect &&
+    LANGUAGE=3Dis LC_ALL=3D"$is_IS_locale" git init repo >actual &&
+    test_when_finished "rm -rf repo" &&
+    grep "^$(cat expect) " actual
+'
+
+test_expect_success GETTEXT_ISO_LOCALE 'gettext.c: git init UTF-8 -> I=
SO-8859-1' '
+    printf "Bj=C3=B3 til t=C3=B3ma Git lind" >expect &&
+    LANGUAGE=3Dis LC_ALL=3D"$is_IS_iso_locale" git init repo >actual &=
&
+    test_when_finished "rm -rf repo" &&
+    grep "^$(cat expect | iconv -f UTF-8 -t ISO8859-1) " actual
+'
+
 test_done
--=20
1.7.2.2.536.g3f548
