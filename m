From: Torsten =?utf-8?q?B=C3=B6gershausen?= <tboegi@web.de>
Subject: [PATCH V2] t0204: Removed TC emitting ISO-8859-1 from our UTF-8 *.mo files
Date: Tue, 6 Mar 2012 21:39:10 +0100
Message-ID: <201203062139.10812.tboegi@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: tboegi@web.de
To: avarab@gmail.com, gitster@pobox.com, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Mar 06 21:39:26 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S51AG-0001sA-GG
	for gcvg-git-2@plane.gmane.org; Tue, 06 Mar 2012 21:39:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1031005Ab2CFUjQ convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 6 Mar 2012 15:39:16 -0500
Received: from fmmailgate07.web.de ([217.72.192.248]:35365 "EHLO
	fmmailgate07.web.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965262Ab2CFUjP convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 6 Mar 2012 15:39:15 -0500
Received: from moweb002.kundenserver.de (moweb002.kundenserver.de [172.19.20.108])
	by fmmailgate07.web.de (Postfix) with ESMTP id EF061D8F114
	for <git@vger.kernel.org>; Tue,  6 Mar 2012 21:39:13 +0100 (CET)
Received: from maxi.localnet ([194.22.188.61]) by smtp.web.de (mrweb002) with
 ESMTPA (Nemesis) id 0LrbLR-1SWpNV0zvh-013gyx; Tue, 06 Mar 2012 21:39:12 +0100
X-Provags-ID: V02:K0:OTdzK+AC7XedwhsvVNdhqkeX4+JOWlLdhyWNym/hnuY
 oQvPKbLdRfjwzlgpfNK07trwX3+5+OxTbRgy+Y/dflyxSvN4Qx
 5KVBUvrukKuE4uBwX9rhKiTmfTZ73lY0Q9rmSF5ujLZsyKUmCJ
 Q0d7ewmkzM6Ed/zNk3ssYxu0ob5VwtpGm5AHvx/REN7CWANijg
 jydDHD1iO6e/MnJUZrHAA==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/192389>

Removed this test case:
gettext: Emitting ISO-8859-1 from our UTF-8 *.mo files / Runes

The removed test case tried to show UTF-8 encoded text in a ISO-8859-1
locale with code points that don't fit into ISO-8859-1.
Some systems convert these code points into question marks,
(that is what the test expects) while other don't support
an ISO-8859-1 locale anymore and use UTF-8 anyway.

Remove the text case as there is no reason to insist that the fall back
behaviour is to convert code points out of range into question marks.

Signed-off-by: Torsten B=C3=B6gershausen <tboegi@web.de>
---
>This is insane.=20
[snip]
>I do not see any reason to insist that their fallback behaviour must
>be to fill them with question marks.  In other words, I simply do
>not see the point of this test and the original "pass runs of
>question" to begin with, and this patch makes things even worse.

>Why not get rid of this single test that only tries to check the
>output for an impossible request?
>=C3=86var, am I missing something?
I don't think so.

Better a good remove than a bad improve

Junio, thanks for the replay,=20
I tried to convert your comments into a commit message.



 t/t0204-gettext-reencode-sanity.sh |   14 --------------
 1 files changed, 0 insertions(+), 14 deletions(-)

diff --git a/t/t0204-gettext-reencode-sanity.sh b/t/t0204-gettext-reenc=
ode-sanity.sh
index 189af90..b0628a1 100755
--- a/t/t0204-gettext-reencode-sanity.sh
+++ b/t/t0204-gettext-reencode-sanity.sh
@@ -26,20 +26,6 @@ test_expect_success GETTEXT_ISO_LOCALE 'gettext: Emi=
tting ISO-8859-1 from our UT
     test_cmp expect actual
 '
=20
-test_expect_success GETTEXT_ISO_LOCALE 'gettext: Emitting ISO-8859-1 f=
rom our UTF-8 *.mo files / Runes' '
-    LANGUAGE=3Dis LC_ALL=3D"$is_IS_iso_locale" gettext "TEST: Old Engl=
ish Runes" >runes &&
-
-	if grep "^TEST: Old English Runes$" runes
-	then
-		say "Your system can not handle this complexity and returns the stri=
ng as-is"
-	else
-		# Both Solaris and GNU libintl will return this stream of
-		# question marks, so it is s probably portable enough
-		printf "TILRAUN: ?? ???? ??? ?? ???? ?? ??? ????? ??????????? ??? ??=
 ????" >runes-expect &&
-		test_cmp runes-expect runes
-	fi
-'
-
 test_expect_success GETTEXT_LOCALE 'gettext: Fetching a UTF-8 msgid ->=
 UTF-8' '
     printf "TILRAUN: =E2=80=9Aeinfaldar=E2=80=98 og =E2=80=9Etv=C3=B6f=
aldar=E2=80=9C g=C3=A6salappir" >expect &&
     LANGUAGE=3Dis LC_ALL=3D"$is_IS_locale" gettext "TEST: =E2=80=98sin=
gle=E2=80=99 and =E2=80=9Cdouble=E2=80=9D quotes" >actual &&
--=20
1.7.9.rc2
