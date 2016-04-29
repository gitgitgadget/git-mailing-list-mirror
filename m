From: tboegi@web.de
Subject: [PATCH v8 01/10] t0027: make commit_chk_wrnNNO() reliable
Date: Fri, 29 Apr 2016 17:01:52 +0200
Message-ID: <1461942112-15943-1-git-send-email-tboegi@web.de>
References: <xmqqegblor2l.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?Torsten=20B=C3=B6gershausen?= <tboegi@web.de>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Apr 29 16:57:50 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aw9rX-0006yu-Tk
	for gcvg-git-2@plane.gmane.org; Fri, 29 Apr 2016 16:57:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753940AbcD2O5j convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 29 Apr 2016 10:57:39 -0400
Received: from mout.web.de ([212.227.15.4]:53320 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753915AbcD2O5a (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 29 Apr 2016 10:57:30 -0400
Received: from tor.lan ([195.252.60.88]) by smtp.web.de (mrweb004) with
 ESMTPSA (Nemesis) id 0LkVZr-1bWsO22wZv-00cO04; Fri, 29 Apr 2016 16:57:21
 +0200
X-Mailer: git-send-email 2.0.0.rc1.6318.g0c2c796
In-Reply-To: <xmqqegblor2l.fsf@gitster.mtv.corp.google.com>
X-Provags-ID: V03:K0:wLZDnMk3j5+Ix4SE3PlKymI1fVwu9rnmTIwitGoiK4oyrbkpt/C
 e0oIi8Uo73wdyTaoqUMpGEkSKC46Psvxes4NgzvPy8810D/XT0cNE0S1SxEfvTFbDwSi/fT
 4vrUh9LPlSlxqbgSkOESN9jsrhwYGF4GdJdIqj9WIJAdjScAzZZpmDSxFWx+DDQ32n9hJmb
 VbhbjD1Lc/mnc9neIFFHg==
X-UI-Out-Filterresults: notjunk:1;V01:K0:RhuxWy5YoLI=:U1D7tm7ALpckHwWVe3I3ad
 7rZPFiUD6+N1XWgdQhdhRJWJCmZZNZO/f2+nsHRqpeG+mx/zNHtid+Z2kfuHABaen8iNmbZqW
 OZRXS2L+TRxcaq1uJvAn0VNNJCrNG/J+gY/tyGdlWPNLPynBgvqLDsn73vmKXqEdnHRZ+T+hG
 sr42yZK1jVmEC3rlWE5prfg7i3rcZjqA8KcvJnLBYrmTUGIhpB1duIcxNxjblq7xdfhqS0sVi
 BIevlSe4M8vnGLpRd4PuiXx5U4tS6qvZqeeu/i6jDi8FNFOFJL3dk4zGnSAEh/IADiDIyDnAL
 6ooaSSzi899P8vJ/rIbRib0CAFb0rJXRqgmw7JsWZl7+etGqZm20AGrZCKzp4FJfeC8ZXCWds
 XnzUVqpant9rFx9OMdT0GeN06CXTx/I28ro6W2E6iYk3qat5ZHXQ9euH//XrvuEDHyzEoiLMs
 dcqjSkWmSksqjg1HLSyEF2JfMFxT+dChveKH6fZIxXCB5cl1frzHjR9veo82uZglhdWvsBl/8
 CtZWt+ky9dwDw3H5gM5dQSdFKl/cIu12ea4+a+d+0mzcMEd1FKAZSFI/uNCzoe9Bvx9oZdtPB
 dHp2HfbpF1dkI2jscoXeHEg4autDiONQHitoaWpFanm2h0VNEtPWzYydrSmr7vd/Sc6RdGM7y
 aoWWb86ZQwPkmOI82Yy7rCwXfR6451Vk+Yma3woQpOKDowXqhKikAuto0VpnM+vb3OClZhOps
 uOqu2uhioEyJpXzlT8Z1504yEWnx9UmgOsmDms5aiF2IwPj2x4JqqYGFKa6rgh4dmetaAYWN 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/293013>

=46rom: Torsten B=C3=B6gershausen <tboegi@web.de>

When the content of a commited file is unchanged and the attributes
are changed, Git may not detect that the next commit must treat the
file as changed.  This happens when lstat() doesn't detect a change,
since neither inode, mtime nor size are changed.

Add a single "Z" character to change the file size and content.
When the files are compared later in checkout_files(), the "Z" is
removed before the comparison.

Signed-off-by: Torsten B=C3=B6gershausen <tboegi@web.de>
---
Changes against tb/convert-eol-autocrlf:
  7/10 Implemented all comments, new commit message++
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
2.7.0.992.g0c2c796
