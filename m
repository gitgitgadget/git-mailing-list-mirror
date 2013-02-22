From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 2/2] read-cache.c: use INDEX_FORMAT_{LB,UB} in verify_hdr()
Date: Fri, 22 Feb 2013 19:09:24 +0700
Message-ID: <1361534964-4232-2-git-send-email-pclouds@gmail.com>
References: <1361534964-4232-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Feb 22 13:09:23 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U8rRE-0006Re-Uu
	for gcvg-git-2@plane.gmane.org; Fri, 22 Feb 2013 13:09:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755947Ab3BVMIw convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 22 Feb 2013 07:08:52 -0500
Received: from mail-da0-f41.google.com ([209.85.210.41]:59918 "EHLO
	mail-da0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755680Ab3BVMIv (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 22 Feb 2013 07:08:51 -0500
Received: by mail-da0-f41.google.com with SMTP id e20so334801dak.28
        for <git@vger.kernel.org>; Fri, 22 Feb 2013 04:08:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:from:to:cc:subject:date:message-id:x-mailer:in-reply-to
         :references:mime-version:content-type:content-transfer-encoding;
        bh=V4UGvrDxsbili3C4ePUSm/a+G3sZ7mwcPHqJ7zM3BRo=;
        b=Grxh76AOqj3bxPgUwQOM6eD2IbL3OauIodhTIgdQGxOMksFwYlAEBHuZFOdjRthz3O
         Fit+corgErW0w7YqcVTYU38nopcHZoI31wfil7w7auTiFrvtCTm1YplBlGX1GeQE28tX
         mdv787Rbr7ArPeVnfP6XIfgSAX2CxkQCPnTO4rn9TLSp6CcuIURgjvr6Qj0IC1axuVEM
         y0umAGraysDbFK0Xo6EbWzMg9PjMRNQeTjVLh0DaPzZQzXthbaMjsRbz+OZNOzDPWfJc
         7aHTHKAR6Jqj/TN8eenYjuHTQSuv1nr/+5xwDXVb6IZmOGBYm5JLKJx6ESSa6cyhmWRV
         x3dw==
X-Received: by 10.68.41.66 with SMTP id d2mr2630924pbl.154.1361534930650;
        Fri, 22 Feb 2013 04:08:50 -0800 (PST)
Received: from lanh ([115.74.55.130])
        by mx.google.com with ESMTPS id bi8sm2784570pab.15.2013.02.22.04.08.47
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Fri, 22 Feb 2013 04:08:49 -0800 (PST)
Received: by lanh (sSMTP sendmail emulation); Fri, 22 Feb 2013 19:09:40 +0700
X-Mailer: git-send-email 1.8.1.2.536.gf441e6d
In-Reply-To: <1361534964-4232-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/216832>

9d22778 (read-cache.c: write prefix-compressed names in the index -
2012-04-04) defined these. Interestingly, they were not used by
read-cache.c, or anywhere in that patch. They were used in
builtin/update-index.c later for checking supported index
versions. Use them here too.

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 read-cache.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/read-cache.c b/read-cache.c
index 827ae55..298161f 100644
--- a/read-cache.c
+++ b/read-cache.c
@@ -1260,7 +1260,8 @@ static int verify_hdr(struct cache_header *hdr, u=
nsigned long size)
 	if (hdr->hdr_signature !=3D htonl(CACHE_SIGNATURE))
 		return error("bad signature");
 	hdr_version =3D ntohl(hdr->hdr_version);
-	if (hdr_version < 2 || 4 < hdr_version)
+	if (hdr_version < INDEX_FORMAT_LB ||
+	    hdr_version > INDEX_FORMAT_UB)
 		return error("bad index version %d", hdr_version);
 	git_SHA1_Init(&c);
 	git_SHA1_Update(&c, hdr, size - 20);
--=20
1.8.1.2.536.gf441e6d
