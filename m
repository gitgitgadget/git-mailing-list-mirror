From: =?UTF-8?B?VG9yc3RlbiBCw7ZnZXJzaGF1c2Vu?= <tboegi@web.de>
Subject: [PATCH] t9001: avoid not portable '\n' with sed
Date: Wed, 04 Jun 2014 10:20:47 +0200
Message-ID: <538ED6DF.5020505@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: tboegi@web.de
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jun 04 10:20:58 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ws6RM-0001OD-Qp
	for gcvg-git-2@plane.gmane.org; Wed, 04 Jun 2014 10:20:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751281AbaFDIUv convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 4 Jun 2014 04:20:51 -0400
Received: from mout.web.de ([212.227.15.3]:50343 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750932AbaFDIUu (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 4 Jun 2014 04:20:50 -0400
Received: from [192.168.209.26] ([78.72.74.102]) by smtp.web.de (mrweb002)
 with ESMTPSA (Nemesis) id 0MXHoz-1XM1Lx0YnF-00WBd2; Wed, 04 Jun 2014 10:20:48
 +0200
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.6; rv:24.0) Gecko/20100101 Thunderbird/24.5.0
X-Provags-ID: V03:K0:D7Iq8bvDV+CmopEYv8qgparH5cp9waKU+GVGt86eqTkIH9rPAuD
 DEoJch/dfsiaB4QzfGYvpmO9efwAmvgGV9wLGfXuW6ZkouLtu1wZlaO7+ClWJt0PTZLQvrN
 WcN00ZxoDARe3bwihFIjzTHS8tsmV/AhKGSt7RuhkI89ExngE5QmT5knM0E2tC4iiVVJox0
 gTzqKKlSDvx51q6aWFwdg==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/250719>

t9001 used a '\n' in a sed expression to split one line into two lines.
Some versions of sed simply ignore the '\' before the 'n', treating
'\n' as 'n'.

As the test already requires perl as a prerequisite, use perl instead o=
f sed.

Signed-off-by: Torsten B=C3=B6gershausen <tboegi@web.de>
---
 t/t9001-send-email.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/t/t9001-send-email.sh b/t/t9001-send-email.sh
index 64d9434..2bf48d1 100755
--- a/t/t9001-send-email.sh
+++ b/t/t9001-send-email.sh
@@ -1342,7 +1342,7 @@ test_cover_addresses () {
 	git format-patch --cover-letter -2 -o outdir &&
 	cover=3D`echo outdir/0000-*.patch` &&
 	mv $cover cover-to-edit.patch &&
-	sed "s/^From:/$header: extra@address.com\nFrom:/" cover-to-edit.patch=
 >"$cover" &&
+	"$PERL_PATH" -pe "s/^From:/$header: extra\@address.com\nFrom:/" cover=
-to-edit.patch | tr Q "$LF" >"$cover" &&
 	git send-email \
 	  --force \
 	  --from=3D"Example <nobody@example.com>" \
--=20
2.0.0.553.ged01b91
