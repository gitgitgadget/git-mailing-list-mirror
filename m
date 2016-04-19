From: tboegi@web.de
Subject: [PATCH v5 1/4] t0027: Make more reliable
Date: Tue, 19 Apr 2016 15:24:36 +0200
Message-ID: <1461072276-2755-1-git-send-email-tboegi@web.de>
References: <xmqqegblor2l.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?Torsten=20B=C3=B6gershausen?= <tboegi@web.de>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Apr 19 15:22:23 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1asVbh-0004Qt-DJ
	for gcvg-git-2@plane.gmane.org; Tue, 19 Apr 2016 15:22:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754485AbcDSNWF convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 19 Apr 2016 09:22:05 -0400
Received: from mout.web.de ([212.227.15.4]:52057 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754032AbcDSNWD (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 19 Apr 2016 09:22:03 -0400
Received: from tor.lan ([195.252.60.88]) by smtp.web.de (mrweb001) with
 ESMTPSA (Nemesis) id 0MIeCm-1auiWk3Hr6-002EZv; Tue, 19 Apr 2016 15:21:58
 +0200
X-Mailer: git-send-email 2.8.0.rc2.2.g1a4d45a.dirty
In-Reply-To: <xmqqegblor2l.fsf@gitster.mtv.corp.google.com>
X-Provags-ID: V03:K0:uC+OoZz8/o/HXlx+ZW1XKX8uQKSdzMReegfDi/RgwIcVN89exbg
 MLnHng8BrqjoLrV3ZaqYzn7MVuvhU4Sk1/oLpRefQvOc1hTG8JvMcGUI0IsH2QsH5DrRSHG
 Zk4Kks7R7obkCAJoyag6LD/Jg3Z7ucCl7iJjTCU6aFndlwijAMyadgZ8+CnxnaG4KbhGnHx
 iIECYTZ5sG6736cCSE+tg==
X-UI-Out-Filterresults: notjunk:1;V01:K0:wZ5OIX7Q4jM=:zCNwUhdb1y4xM6OxBvJXkF
 QqEiSNgxsY3eUcCIeY35KYxBquUwVidpkbBZnBl/8bInRqKvYjyjBWZPn56xEuEKSi47Ughup
 baC22qR4UTs37VivMn7YCHUFgtZN38oIs8OdUw2lsAfmnDFzRQioYFxSs+QoKHw1r/JwbxnTE
 CdV6JaGyE8sJactGtC3pnQ6KWruMLoX+EV2RIOdS0/TBIsecBZdUWOL833N1/2l6igrN9wIPQ
 7T3IjeAtVmsjZt/jqk14SPdAzhp213nVHi8Rhf2+k6G+2TxEB7owoasQ/VMgd8XPsu8iAA1QV
 o2DT3F7QJHQ7nmbNDtKFaKiOskD1NXHUzoSwvoPJXM7F779kh8q7SMfbSVXFJ+lllaY9CL1jq
 8SoJvloLGl9J64qeZXWuizgBbfybRsbd4JuV1/ubMIwycyXbcJBLEf6qfMRp8Ocrp14n48t8F
 QZj7uODH++G1ALyCpDKBTGwdEK9UqrAPtbHgzoLtpgUxoa708ZI4i78+RrzaaJKpuXUE9miJB
 R7r5qoZ2Cxp8sfSkOcOgu/D8OuWCodfaG3/1sJnoWu4Gtg8+9xHzz0gtzIMPnOEXgw8i1utZV
 DxpfU9er9A6+1V/vEfVPlrwB+y5mw1YNBvPaF8uNN9EawIJI5zVhQIvd1XIYNC9fT1Wevbje7
 hAC95MZmrP4yenZdJeIn2afoZ7XoY9F8l1W1xFF3yrZRCMDtS8u/VBO74pw4OlYXwrcxbo/zt
 1zTpFUPMna0bkMYcAswyaoR7d+UAXn2jjb3qkzCa9IyQhuwMsQR2tlDqty3YQdWTbuI276CR 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/291863>

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
Changes against the last round:
- Add this commit, since t0027 become shaky
- Add bugfix in 4/4
- Remove the non-normalizing changes, they will be part of a different
  series. Mainly because t6038 needs improvements, and ce_compare_data(=
)
  in read_cache.c needs to learn to run convert_to_git()
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
