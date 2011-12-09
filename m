From: Jerome DE VIVIE <j.devivie@prometil.com>
Subject: [PATCH] tag deletions not rejected with receive.denyDeletes= true
Date: Fri, 9 Dec 2011 09:51:14 +0100 (CET)
Message-ID: <18683796.591323420674000.JavaMail.root@promailix.prometil.com>
References: <18285669.571323420520289.JavaMail.root@promailix.prometil.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Dec 09 10:01:22 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RYwKW-0004MD-Ot
	for gcvg-git-2@lo.gmane.org; Fri, 09 Dec 2011 10:01:21 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752153Ab1LIJBO convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 9 Dec 2011 04:01:14 -0500
Received: from promailix.prometil.com ([87.98.147.193]:53581 "EHLO
	promailix.prometil.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751887Ab1LIJBO convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 9 Dec 2011 04:01:14 -0500
X-Greylist: delayed 595 seconds by postgrey-1.27 at vger.kernel.org; Fri, 09 Dec 2011 04:01:14 EST
Received: from localhost (localhost.localdomain [127.0.0.1])
	by promailix.prometil.com (Postfix) with ESMTP id 49CE71BC8D5
	for <git@vger.kernel.org>; Fri,  9 Dec 2011 09:51:18 +0100 (CET)
Received: from promailix.prometil.com ([127.0.0.1])
	by localhost (promailix.prometil.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id urTjkybnHgna for <git@vger.kernel.org>;
	Fri,  9 Dec 2011 09:51:14 +0100 (CET)
Received: from promailix.prometil.com (mail.prometil.com [87.98.147.193])
	by promailix.prometil.com (Postfix) with ESMTP id 0D48D1BC518
	for <git@vger.kernel.org>; Fri,  9 Dec 2011 09:51:14 +0100 (CET)
In-Reply-To: <18285669.571323420520289.JavaMail.root@promailix.prometil.com>
X-Originating-IP: [193.57.220.1]
X-Mailer: Zimbra 5.0.18_GA_3011.UBUNTU8 (ZimbraWebClient - FF3.0 (Win)/5.0.18_GA_3011.UBUNTU8)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/186623>

Hello,

I have try to deny tag deletion over push using denyDeletes parameter:

git config --system receive.denyDeletes true
git daemon --reuseaddr --base-path=3D.. --export-all --verbose --enable=
=3Dreceive-pack

I can push tag deletions despite what the internet says (http://progit.=
org/book/ch7-1.html#receivedenydeletes). I don't know if it is a bug. C=
ould you have a look, pls ? Thank you


BR
J=C3=A9r=C3=B4me


Signed-off-by: J=C3=A9r=C3=B4me de Vivie <j.edevivie@prometil.com>
---
 builtin/receive-pack.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/builtin/receive-pack.c b/builtin/receive-pack.c
index 7ec68a1..bf91042 100644
--- a/builtin/receive-pack.c
+++ b/builtin/receive-pack.c
@@ -432,7 +432,7 @@ static const char *update(struct command *cmd)
 	}
=20
 	if (!is_null_sha1(old_sha1) && is_null_sha1(new_sha1)) {
-		if (deny_deletes && !prefixcmp(name, "refs/heads/")) {
+		if (deny_deletes && (!prefixcmp(name, "refs/heads/") || !prefixcmp(n=
ame, "refs/tags/"))) {
 			rp_error("denying ref deletion for %s", name);
 			return "deletion prohibited";
 		}
--=20
1.7.6.msysgit.0
