From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 1/6] exclude: stricten a length check in EXC_FLAG_ENDSWITH case
Date: Mon, 15 Oct 2012 13:24:34 +0700
Message-ID: <1350282279-4377-1-git-send-email-pclouds@gmail.com>
References: <1350282212-4270-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Oct 15 08:25:01 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TNe6n-0005wE-3t
	for gcvg-git-2@plane.gmane.org; Mon, 15 Oct 2012 08:25:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753339Ab2JOGYu convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 15 Oct 2012 02:24:50 -0400
Received: from mail-da0-f46.google.com ([209.85.210.46]:51858 "EHLO
	mail-da0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752772Ab2JOGYu (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 15 Oct 2012 02:24:50 -0400
Received: by mail-da0-f46.google.com with SMTP id n41so2429486dak.19
        for <git@vger.kernel.org>; Sun, 14 Oct 2012 23:24:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=/eqJ2o7xZN4d9hH7vc++DZ1tTmW+KpBSj5NnxBV4j6o=;
        b=eG7hKCJgxK49cJqPI99djQRa5XqxZRVEaBnC/lC8xT1LA0C/iChYxJQE2HXNXrwBKs
         dEEb9zIXaQ1vwKt4Kz45vmKpxGB4YaSnYRr/u026HEzYXFDUpO/6dmzIWq4dKXU0bMKv
         YsIXIGxN1XKu2rIAiuW/8CHmX9Jq1pfzofLiJdIHnn23iSl4GV5m+TsIVhX4z0wBjL3d
         KiPdkeHHbgDtY/v4Po9htrxU8RpIwqy396fJMRTZ117cGR19aQYn3o4HEJySfKPyOODd
         aX7c+BM/q4WtOnQsB3fYKtdbrt1bKdBBsKLQdI2w6SaP3KXAn594GkCokeD3oxuQy8vk
         EuMw==
Received: by 10.68.248.70 with SMTP id yk6mr16432614pbc.160.1350282289758;
        Sun, 14 Oct 2012 23:24:49 -0700 (PDT)
Received: from pclouds@gmail.com ([113.161.77.29])
        by mx.google.com with ESMTPS id e9sm7544304paz.28.2012.10.14.23.24.45
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sun, 14 Oct 2012 23:24:48 -0700 (PDT)
Received: by pclouds@gmail.com (sSMTP sendmail emulation); Mon, 15 Oct 2012 13:24:39 +0700
X-Mailer: git-send-email 1.8.0.rc0.29.g1fdd78f
In-Reply-To: <1350282212-4270-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/207693>

This block of code deals with the "basename" part only, which has the
length of "pathlen - (basename - pathname)". Stricten the length check
and remove "pathname" from the main expression to avoid confusion.

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 dir.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/dir.c b/dir.c
index 0015cc5..b0ae417 100644
--- a/dir.c
+++ b/dir.c
@@ -534,8 +534,9 @@ int excluded_from_list(const char *pathname,
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
1.8.0.rc0.29.g1fdd78f
