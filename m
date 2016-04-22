From: tboegi@web.de
Subject: [PATCH v6 01/10] t0027: Make more reliable
Date: Fri, 22 Apr 2016 16:38:28 +0200
Message-ID: <1461335908-5013-1-git-send-email-tboegi@web.de>
References: <xmqqegblor2l.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?Torsten=20B=C3=B6gershausen?= <tboegi@web.de>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Apr 22 16:49:45 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1atcOu-0003H3-JM
	for gcvg-git-2@plane.gmane.org; Fri, 22 Apr 2016 16:49:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754101AbcDVOtj convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 22 Apr 2016 10:49:39 -0400
Received: from mout.web.de ([212.227.15.4]:64639 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753404AbcDVOti (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 22 Apr 2016 10:49:38 -0400
Received: from tor.lan ([195.252.60.88]) by smtp.web.de (mrweb004) with
 ESMTPSA (Nemesis) id 0M5Jip-1bepE13d5b-00zXka; Fri, 22 Apr 2016 16:49:34
 +0200
X-Mailer: git-send-email 2.8.0.rc2.2.g1a4d45a.dirty
In-Reply-To: <xmqqegblor2l.fsf@gitster.mtv.corp.google.com>
X-Provags-ID: V03:K0:wcKa1ArarYM4QCEJJfwMJAqdb0ann4WTlOZ8xpRw5CiqievcHRy
 qqatwgLR0yIIyP7ZGmiAORM90kfIXSeX1u5Vw5dzNNntEQ61v6c2Vw8hLupZfLC4YoMczk8
 JIvZrY4vrk9gIMNqpQXqah9hw7zZT38JTu2u3wG14fEJpEHlKh15g7mHvTJckpSoazFWi21
 V9Gcdh+OKt/noxYmLpm+w==
X-UI-Out-Filterresults: notjunk:1;V01:K0:Em89y09xnsg=:Ti02AyBpLS2wC4cjY3ddkh
 C3b+ru3eJr/ut76fWKR1rQPoKYaxONf9y9BRjqRdL+kzE4umlMPvnCdNQsUJWGNWN9t4xKYMP
 t4T+LKdMhnYZa48N/j5aDDRDIeZVoTh0GL7P6U8Fpu52YZAdRovVxBmctmZhtwvDMNVEyL7iX
 XdDvTFHAf7GQyMPc6efGVkobe8BEt3HsnS4cPg0GGNatXWLW5uAFaqjEnanYB7s6GoW/5cNki
 QJucLw81VJAMB+7+ihVcvMD4R1cfPIN2oPAN0kuCbkEAdL58fJWOLq0EOQwcBGUCSAun6jXCH
 jYoL5g4Q8VH+c0Tlxko5SsbwrmO+x9x/chK7/NGOLBQrFOa5cKr1YClsmIhtr3JWNtdBLIvoE
 VBEZtPyXWXo5a5HTD1FXsc/QM9YQm6wE2daChMZTWYj2FLiT8X+lYVopH0mT6ve4+IOoCUf6/
 WYjp+kjT/jO3UdqA0sMLnvA9XBkBX30GKi4Rgk/j65OwGBm62/aBopCFm8OSZU2K7tUFN+os2
 yeygscw6G9Bj6ttPFtFD0qLpS3gOc3nn+NAmdnYrApNi/ltbewwA1C9b3vLqxTz210B4uX8oq
 hO4ckEIMuBKl9X4nvI7FAxC95uQKXKKvj/2kDsyfundrwx2oCDFsfTp1YwrMRElEonbu//dIk
 U4bKOHtdQBYYZ+i5+II+6nUD4lRjodOcrgz5tP0heKW8s1d6YL0S1csPkaxHWPxlZ0aHxNm3U
 YbA3OXpVsLho4QYuJtJ+5k75i1Z8ctq03wE2rBbt2/Pj8+KgqSmcgBT+00liUhJhY0ge3tFa 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/292211>

=46rom: Torsten B=C3=B6gershausen <tboegi@web.de>

Make the commit_chk_wrnNNO test in t0027 more reliable:
When the attributes of a commited file are changed and the file is othe=
rwise
unchanged, Git may not detect that the next commit may need to treat th=
e
file as changed.
This happens when lstat() doesn't detect a change, since neither inode,
mtime nor size are changed.

Add a singe "Z" character to change the file size.
Ignore it when comparing the files later.

Signed-off-by: Torsten B=C3=B6gershausen <tboegi@web.de>
---
 Changes since v5:
 - send the whole series, now 10/10
 - Removed the "will change in future" in one commit msg
 - Don't leak the filer in 4/10
 t/t0027-auto-crlf.sh | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/t/t0027-auto-crlf.sh b/t/t0027-auto-crlf.sh
index f33962b..9fe539b 100755
--- a/t/t0027-auto-crlf.sh
+++ b/t/t0027-auto-crlf.sh
@@ -12,7 +12,7 @@ fi
=20
 compare_files () {
 	tr '\015\000' QN <"$1" >"$1".expect &&
-	tr '\015\000' QN <"$2" >"$2".actual &&
+	tr '\015\000' QN <"$2" | tr -d 'Z' >"$2".actual &&
 	test_cmp "$1".expect "$2".actual &&
 	rm "$1".expect "$2".actual
 }
@@ -114,6 +114,7 @@ commit_chk_wrnNNO () {
 	do
 		fname=3D${pfx}_$f.txt &&
 		cp $f $fname &&
+		printf Z >>"$fname" &&
 		git -c core.autocrlf=3D$crlf add $fname 2>/dev/null &&
 		git -c core.autocrlf=3D$crlf commit -m "commit_$fname" $fname >"${pf=
x}_$f.err" 2>&1
 	done
--=20
2.8.0.rc2.2.g1a4d45a.dirty
