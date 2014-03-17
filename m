From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH v2] index-pack: do not segfault when keep_name is NULL
Date: Tue, 18 Mar 2014 06:07:27 +0700
Message-ID: <1395097647-29362-1-git-send-email-pclouds@gmail.com>
References: <1394965862-8173-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Mar 18 00:07:03 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WPgcY-0003Nx-RL
	for gcvg-git-2@plane.gmane.org; Tue, 18 Mar 2014 00:07:03 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752961AbaCQXG6 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 17 Mar 2014 19:06:58 -0400
Received: from mail-pd0-f180.google.com ([209.85.192.180]:63012 "EHLO
	mail-pd0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751417AbaCQXG5 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 17 Mar 2014 19:06:57 -0400
Received: by mail-pd0-f180.google.com with SMTP id v10so6225681pde.11
        for <git@vger.kernel.org>; Mon, 17 Mar 2014 16:06:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=xatqunwrKOY3HVJDsI/FOeMWhdZqGM5lN2L5cfKmSXk=;
        b=L1uhw9Z58TyX24anOpj6RxskHLQBVEzqDMKS3P9b3V88wu9TxbaMkl8PDfoVCsgFLi
         s7mBL4oNoLMLy5XBvHGkfPqx+nzL4OKyUnHIXTaqrp7y1JYhVWG0ynF1F7dp/M8EXVWQ
         7Nobphl8Z/BirHPzamoZupNp9A1VIa2MNNP+zFhIXNhxyB72su2CVRol6imEYJfpolox
         crbOO9PyKtX1h4TIQcMss6I4WddT1v9VqjPcIIwXuJn0JVv9WKHMLWuUXcRqjDQHttgt
         zUfJMLWizzZKJsp7SigNq4My7zhJqEEx5dY08+JPDU6slwBMF6aYizVPWKi6/VxyXFoq
         aZlg==
X-Received: by 10.66.192.133 with SMTP id hg5mr11584647pac.122.1395097617230;
        Mon, 17 Mar 2014 16:06:57 -0700 (PDT)
Received: from lanh ([115.73.237.95])
        by mx.google.com with ESMTPSA id eb5sm77961806pad.22.2014.03.17.16.06.54
        for <multiple recipients>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Mon, 17 Mar 2014 16:06:56 -0700 (PDT)
Received: by lanh (sSMTP sendmail emulation); Tue, 18 Mar 2014 06:07:40 +0700
X-Mailer: git-send-email 1.9.0.40.gaa8c3ea
In-Reply-To: <1394965862-8173-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/244309>

Use the name that is returned by odb_pack_keep() when the caller
passes NULL in keep_name.

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 builtin/index-pack.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/builtin/index-pack.c b/builtin/index-pack.c
index a6b1c17..b9f6e12 100644
--- a/builtin/index-pack.c
+++ b/builtin/index-pack.c
@@ -1291,7 +1291,7 @@ static void final(const char *final_pack_name, co=
nst char *curr_pack_name,
 		if (keep_fd < 0) {
 			if (errno !=3D EEXIST)
 				die_errno(_("cannot write keep file '%s'"),
-					  keep_name);
+					  keep_name ? keep_name : name);
 		} else {
 			if (keep_msg_len > 0) {
 				write_or_die(keep_fd, keep_msg, keep_msg_len);
@@ -1299,7 +1299,7 @@ static void final(const char *final_pack_name, co=
nst char *curr_pack_name,
 			}
 			if (close(keep_fd) !=3D 0)
 				die_errno(_("cannot close written keep file '%s'"),
-				    keep_name);
+					  keep_name ? keep_name : name);
 			report =3D "keep";
 		}
 	}
--=20
1.9.0.40.gaa8c3ea
