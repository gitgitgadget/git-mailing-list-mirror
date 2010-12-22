From: Thiago Farina <tfransosi@gmail.com>
Subject: [PATCH] attr.c: Use ALLOC_GROW instead of alloc_nr and xrealloc.
Date: Tue, 21 Dec 2010 22:35:50 -0200
Message-ID: <3c6870c390110bd1bf5c5f59a99928afc86cf188.1292978127.git.tfransosi@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Dec 22 01:36:12 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PVCgd-0002G3-3a
	for gcvg-git-2@lo.gmane.org; Wed, 22 Dec 2010 01:36:11 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753908Ab0LVAgF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 21 Dec 2010 19:36:05 -0500
Received: from mail-yx0-f174.google.com ([209.85.213.174]:58924 "EHLO
	mail-yx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752865Ab0LVAgE (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 21 Dec 2010 19:36:04 -0500
Received: by yxt3 with SMTP id 3so2000328yxt.19
        for <git@vger.kernel.org>; Tue, 21 Dec 2010 16:36:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:date
         :message-id:x-mailer;
        bh=C4ikidOWPM1/pRgVjsVorj3yJTRgVJNDfdzVqESSXW0=;
        b=kaR5/Y6gB+42Lndx4SonZX7FkiEfHsMcqRIHV9gIQNxC1KxKe7GemGZSiojTE3FGef
         iKBIvutsYuwP7Fp7Ucr5Xbg9MjnR+CspCC1KMVrEcxfaPuMelt/xzIDsiw9N49Kh0bEW
         OGwmwEkd9XFotZujuiuPt0zKhyro130/dqrUI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:message-id:x-mailer;
        b=QDOBWRJc+nEdiumhyxQemWN3c6xlcjCVVv/1tIFobRho7vIpEnLbTrIkrC+we5J+KH
         vxs4QXDenhIaYlEWDaDIhZUNLtFXjerhzuUlGUvEBQDE9GbkJ++Iw/sLPf/xf71+CMWS
         0ffT6e01Z8K1pEyofKHUofuNLkZOLMccbQHLg=
Received: by 10.90.70.2 with SMTP id s2mr7770172aga.184.1292978163521;
        Tue, 21 Dec 2010 16:36:03 -0800 (PST)
Received: from localhost ([186.205.6.151])
        by mx.google.com with ESMTPS id b27sm10361455ana.8.2010.12.21.16.36.01
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Tue, 21 Dec 2010 16:36:02 -0800 (PST)
X-Mailer: git-send-email 1.7.3.2.343.g7d43d
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/164063>

Signed-off-by: Thiago Farina <tfransosi@gmail.com>
---
 attr.c |    8 ++------
 1 files changed, 2 insertions(+), 6 deletions(-)

diff --git a/attr.c b/attr.c
index 6aff695..fdc0515 100644
--- a/attr.c
+++ b/attr.c
@@ -305,12 +305,8 @@ static void handle_attr_line(struct attr_stack *res,
 	a = parse_attr_line(line, src, lineno, macro_ok);
 	if (!a)
 		return;
-	if (res->alloc <= res->num_matches) {
-		res->alloc = alloc_nr(res->num_matches);
-		res->attrs = xrealloc(res->attrs,
-				      sizeof(struct match_attr *) *
-				      res->alloc);
-	}
+
+	ALLOC_GROW(res->attrs, res->num_matches + 1, res->alloc);
 	res->attrs[res->num_matches++] = a;
 }
 
-- 
1.7.3.2.343.g7d43d
