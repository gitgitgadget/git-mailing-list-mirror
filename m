From: tboegi@web.de
Subject: [PATCH v6b 01/10] t0027: Make commit_chk_wrnNNO() reliable
Date: Sun, 24 Apr 2016 17:10:21 +0200
Message-ID: <1461510621-20887-1-git-send-email-tboegi@web.de>
References: <xmqqegblor2l.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?Torsten=20B=C3=B6gershausen?= <tboegi@web.de>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Apr 24 17:07:23 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1auLd4-000605-Tz
	for gcvg-git-2@plane.gmane.org; Sun, 24 Apr 2016 17:07:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752626AbcDXPHH convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 24 Apr 2016 11:07:07 -0400
Received: from mout.web.de ([212.227.17.11]:55116 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752583AbcDXPHG (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 24 Apr 2016 11:07:06 -0400
Received: from tor.lan ([195.252.60.88]) by smtp.web.de (mrweb101) with
 ESMTPSA (Nemesis) id 0LqDQS-1bP1fh3AAK-00djeE; Sun, 24 Apr 2016 17:07:01
 +0200
X-Mailer: git-send-email 2.0.0.rc1.6318.g0c2c796
In-Reply-To: <xmqqegblor2l.fsf@gitster.mtv.corp.google.com>
X-Provags-ID: V03:K0:6QXRLmdOjoIjJOEtRldt85FxXEhvRMJtDITxLSJOTg2huEIHqXu
 LP0ViRBB2JiVPI9VPrP3OMujKtpvSa6UlDaGRhrEgKPFn9oKWl+hlHfd3uSy0CSp7OyztP2
 flou2wln2TlIH76ZFYvBQNDCmlrA3t1A3JWFHlEl3NMOt4JHevdjC4viObUm5l8LtyZSl1k
 7M4qLheY4FcZsbM5AMPNA==
X-UI-Out-Filterresults: notjunk:1;V01:K0:mxTL4bDwrcQ=:om2Zh7JA6hLUl7ZxNfrBrv
 AfmkI0DvgAFJGCmPuNZjDObqHRSXldvPpt5AWp9+S+Tn3JYlkle8S1flRqpzCuDAPqXpHvvmi
 ffz9DcbhPf7H5y0JBWSDfbkecWH7HB9s3LVYlnshD82fkZGBhNws6IFTSqyhWFP6LLd4dMWFz
 CZ+reJNmGMXE30AQF2qqZ+EmxAqMZeBEpSJGVqJdHsF51fbfFqbCwD4sWbuYTYqEHQ7XbHqCb
 wnKk8HqRsZLowaU9cjiEM8LLFyfrulNumc+bV76VZz5VrbdMFHTW0bgaQMI9cfJlR6/1nSeMR
 3mB0CTHYBEOhqBA8IClYdhdUSS4ahOAvlM2/diYXnKwvG7NTEQIenr04pNiIPl27vhMVJSCy5
 2oiiGBSP7JxHaxj3WazlZX6M0UnpGocY4/vPghXK5xi4goBckEY0fgg96PL3abuE5B/17pNZY
 vOdediV2ZCUuw5MGrE8IP1Ur0vY/7wZYTxvhRDul5+09BxxBDx1o6IpXuBDddOEPKwh3U6uM4
 QgE+NVrzeZ/gAN8ha/XDnEwjI2urW1TJgTxJzGHC2jl7jfRVOCEW/k1qqKAixAjoXSpVChUin
 zgx0+Z9K6oK92xDym2eGRmfpVgi76Kgxi2uLdeKsK5NtRS0jEooEc/bs1ilu0EyBn5aB95Uvx
 cDMGxN8+mTVd1DM4DUMN/6p8RgTHYGCIGPvm6Om3C61Lq/PqOTAJqjieF0QXPXwvCoOy1Isyg
 GFJJexaIIfZIDSJjcDRhyXnLiFSRH88GZA11P+PpOLUisp0FXmI+DUmD6D80kTgi1UiohhFn 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/292408>

=46rom: Torsten B=C3=B6gershausen <tboegi@web.de>

When the content of a commited file is unchanged and the attributes are=
 changed,
Git may not detect that the next commit must treat the file as changed.
This happens when lstat() doesn't detect a change, since neither inode,
mtime nor size are changed.

Add a singe "Z" character to change the file size (and content).
When the files are compared later in checkout_files(), the "Z" is remov=
ed
before the comparison.

Signed-off-by: Torsten B=C3=B6gershausen <tboegi@web.de>
---
Changes since v5:
 - send the whole series, now 10/10
 - Removed the "will change in future" in one commit msg
 - Don't leak the filer in 4/10
 t/t0027-auto-crlf.sh | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)
 Changes since v6:
 - Reword commit msg in 1/10
 - Add SOB in 9/10
 - Correct typos

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
