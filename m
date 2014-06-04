From: =?UTF-8?B?VG9yc3RlbiBCw7ZnZXJzaGF1c2Vu?= <tboegi@web.de>
Subject: [PATCH v2] t9001: avoid not portable '\n' with sed
Date: Wed, 04 Jun 2014 21:42:25 +0200
Message-ID: <538F76A1.4060008@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: tboegi@web.de
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jun 04 21:42:43 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WsH55-0007FA-68
	for gcvg-git-2@plane.gmane.org; Wed, 04 Jun 2014 21:42:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751732AbaFDTme convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 4 Jun 2014 15:42:34 -0400
Received: from mout.web.de ([212.227.17.12]:53635 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750997AbaFDTme (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 4 Jun 2014 15:42:34 -0400
Received: from [192.168.209.26] ([78.72.74.102]) by smtp.web.de (mrweb001)
 with ESMTPSA (Nemesis) id 0MbyZa-1X89Gw3fa2-00JNgu; Wed, 04 Jun 2014 21:42:32
 +0200
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.6; rv:24.0) Gecko/20100101 Thunderbird/24.5.0
X-Provags-ID: V03:K0:Ii/dE5oQmx2uJSODpZSTNhpC28kefhh3EqKVtuHH+r12PfMmVvo
 Mbh5Z6o/70dmsoTOeihThdb5zWRHJPM2g5fa45dXliMkvlZaPRGtA6HsndLpAnP9Re6TbT+
 pWfprjR0vJkUQtNVPwqW1IGWzlvdqdRSp4Cp2ILAQloFEGYaC5j5NIq+Md0rQ8995rn0Vd/
 +RBocjI27MHzLhLU5VrUA==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/250776>

t9001 used a '\n' in a sed expression to split one line into two lines.
Some versions of sed (/usr/bin/sed under Mac OS X)
simply ignore the '\' before the 'n', treating '\n' as 'n'.

As the test already requires perl as a prerequisite, use perl instead o=
f sed.

Signed-off-by: Torsten B=C3=B6gershausen <tboegi@web.de>
---
 t/t9001-send-email.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/t/t9001-send-email.sh b/t/t9001-send-email.sh
index 64d9434..19a3ced 100755
--- a/t/t9001-send-email.sh
+++ b/t/t9001-send-email.sh
@@ -1342,7 +1342,7 @@ test_cover_addresses () {
 	git format-patch --cover-letter -2 -o outdir &&
 	cover=3D`echo outdir/0000-*.patch` &&
 	mv $cover cover-to-edit.patch &&
-	sed "s/^From:/$header: extra@address.com\nFrom:/" cover-to-edit.patch=
 >"$cover" &&
+	perl -pe "s/^From:/$header: extra\@address.com\nFrom:/" cover-to-edit=
=2Epatch >"$cover" &&
 	git send-email \
 	  --force \
 	  --from=3D"Example <nobody@example.com>" \
--=20
2.0.0.553.ged01b91
