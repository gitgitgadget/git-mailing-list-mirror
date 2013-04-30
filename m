From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH v2 6/8] cache-tree.c: refuse to write trees referring to external objects
Date: Tue, 30 Apr 2013 10:42:50 +0700
Message-ID: <1367293372-1958-7-git-send-email-pclouds@gmail.com>
References: <1367293372-1958-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	Jens Lehmann <Jens.Lehmann@web.de>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Apr 30 05:43:18 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UX1TG-0006Mj-RW
	for gcvg-git-2@plane.gmane.org; Tue, 30 Apr 2013 05:43:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758848Ab3D3DnJ convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 29 Apr 2013 23:43:09 -0400
Received: from mail-pa0-f48.google.com ([209.85.220.48]:40206 "EHLO
	mail-pa0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758796Ab3D3DnI (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 29 Apr 2013 23:43:08 -0400
Received: by mail-pa0-f48.google.com with SMTP id lb1so105680pab.21
        for <git@vger.kernel.org>; Mon, 29 Apr 2013 20:43:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:from:to:cc:subject:date:message-id:x-mailer:in-reply-to
         :references:mime-version:content-type:content-transfer-encoding;
        bh=7difQZ84N4OWO94ALqj2aEUH6akNScxUm/aSXyhlvzI=;
        b=l/6f5LrAwTlTgxvSQ0RMVTEbrPXS3QsIji4l712vZofxMK+95weSE+C9abBA3ixta/
         abeBzES/xxfhlp33EBQIy/ptP7lE/tQmuTuQliP2lJ4PM+NSOMdZI+cCNQY7eMCqJirF
         WRLyEca4LSVdyST089ViOk6BNlHRjNEIcHt7JEnYFPALRpe8DYOHM7zGaMrngPynEEmS
         7YWhLPIMdjpXxW2xRw4x+aug8Ftui2xFW8Odl4ICeowa+0BsWTU0me97Wlb9EwNTIRlr
         Gr4XyadhOv3POQRhMByiig+r4E8uDakdj+ibBbPi3oXtIxKdLTGvfCsFcIHfxdvD38qF
         38cg==
X-Received: by 10.66.255.41 with SMTP id an9mr45331763pad.44.1367293387968;
        Mon, 29 Apr 2013 20:43:07 -0700 (PDT)
Received: from lanh ([115.74.52.135])
        by mx.google.com with ESMTPSA id jw10sm26628303pbb.3.2013.04.29.20.43.04
        for <multiple recipients>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Mon, 29 Apr 2013 20:43:07 -0700 (PDT)
Received: by lanh (sSMTP sendmail emulation); Tue, 30 Apr 2013 10:43:57 +0700
X-Mailer: git-send-email 1.8.2.83.gc99314b
In-Reply-To: <1367293372-1958-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/222900>

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 cache-tree.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/cache-tree.c b/cache-tree.c
index 37e4d00..478da88 100644
--- a/cache-tree.c
+++ b/cache-tree.c
@@ -343,7 +343,8 @@ static int update_one(struct cache_tree *it,
 			entlen =3D pathlen - baselen;
 			i++;
 		}
-		if (mode !=3D S_IFGITLINK && !missing_ok && !has_sha1_file(sha1)) {
+		if (mode !=3D S_IFGITLINK && !missing_ok &&
+		    !has_sha1_file_proper(sha1)) {
 			strbuf_release(&buffer);
 			return error("invalid object %06o %s for '%.*s'",
 				mode, sha1_to_hex(sha1), entlen+baselen, path);
--=20
1.8.2.83.gc99314b
