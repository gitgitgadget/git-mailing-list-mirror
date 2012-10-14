From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 1/4] exclude: stricten a length check in EXC_FLAG_ENDSWITH case
Date: Sun, 14 Oct 2012 18:55:39 +0700
Message-ID: <1350215742-20761-2-git-send-email-pclouds@gmail.com>
References: <1350215742-20761-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Oct 14 13:56:31 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TNMnx-0004hG-NE
	for gcvg-git-2@plane.gmane.org; Sun, 14 Oct 2012 13:56:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752758Ab2JNL4K convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 14 Oct 2012 07:56:10 -0400
Received: from mail-da0-f46.google.com ([209.85.210.46]:44029 "EHLO
	mail-da0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751935Ab2JNL4I (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 14 Oct 2012 07:56:08 -0400
Received: by mail-da0-f46.google.com with SMTP id n41so2104032dak.19
        for <git@vger.kernel.org>; Sun, 14 Oct 2012 04:56:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=px7LCeNKhk+rJKUBtIZT22itci+ieZYsPriDqESdBGM=;
        b=CHxmexbipSrFwVmJ4I+jp7/xiLunKHYpPmQdBnmCJphq+ziWi7NtWn9ZXK6AF4VH2v
         skIxPrWhEhOL9VGrxoo6BEQ2crgcEdtTGW7LsbS5bS5C7CXmibmxLpjvsGl9GcHhuAL/
         P4BQ7ldtKpfvd4ET1mn0cqcaOmXyc/qmL8j6+/iqcEgPL8BMj9rSSmcYcE9ACU0WtuZc
         0Bu+Y5150z0nSbqf1IvVKGnPTdYF/eRkMaU7rY3OCJo/LePs0mf4yAwKgR/ca8rcD+PY
         /2vN+KeeYzd7Gn07YJX21RobdbMZY+uD+k2IYnmdGGoKmh/Dd+iSWVC19llGSsfuYoWn
         qTJg==
Received: by 10.68.225.3 with SMTP id rg3mr28960108pbc.27.1350215768533;
        Sun, 14 Oct 2012 04:56:08 -0700 (PDT)
Received: from pclouds@gmail.com ([115.74.44.221])
        by mx.google.com with ESMTPS id ky6sm7398544pbc.18.2012.10.14.04.56.05
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sun, 14 Oct 2012 04:56:07 -0700 (PDT)
Received: by pclouds@gmail.com (sSMTP sendmail emulation); Sun, 14 Oct 2012 18:55:53 +0700
X-Mailer: git-send-email 1.8.0.rc2.11.g2b79d01
In-Reply-To: <1350215742-20761-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/207658>

This block of code deals with the "basename" part only, which has the
length of "pathlen - (basename - pathname)". Stricten the length check
and remove "pathname" from the main expression to avoid confusion.

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 dir.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/dir.c b/dir.c
index cddf043..d81498e 100644
--- a/dir.c
+++ b/dir.c
@@ -561,8 +561,9 @@ int excluded_from_list(const char *pathname,
 				if (!strcmp_icase(exclude, basename))
 					return to_exclude;
 			} else if (x->flags & EXC_FLAG_ENDSWITH) {
-				if (x->patternlen - 1 <=3D pathlen &&
-				    !strcmp_icase(exclude + 1, pathname + pathlen - x->patternlen =
+ 1))
+				int len =3D pathlen - (basename - pathname);
+				if (x->patternlen - 1 <=3D len &&
+				    !strcmp_icase(exclude + 1, basename + len - x->patternlen + 1)=
)
 					return to_exclude;
 			} else {
 				if (fnmatch_icase(exclude, basename, 0) =3D=3D 0)
--=20
1.8.0.rc2.11.g2b79d01
