From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 10/13] wildmatch: fix case-insensitive matching
Date: Mon, 15 Oct 2012 13:25:59 +0700
Message-ID: <1350282362-4505-10-git-send-email-pclouds@gmail.com>
References: <1350282212-4270-1-git-send-email-pclouds@gmail.com>
 <1350282362-4505-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Oct 15 08:27:42 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TNe9M-0008BO-Sn
	for gcvg-git-2@plane.gmane.org; Mon, 15 Oct 2012 08:27:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753992Ab2JOG1a convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 15 Oct 2012 02:27:30 -0400
Received: from mail-pb0-f46.google.com ([209.85.160.46]:46603 "EHLO
	mail-pb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753839Ab2JOG13 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 15 Oct 2012 02:27:29 -0400
Received: by mail-pb0-f46.google.com with SMTP id rr4so4624959pbb.19
        for <git@vger.kernel.org>; Sun, 14 Oct 2012 23:27:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=XSv8a4WkZY1FAu5AauHoBB/Pt7fMUxumbuN2VwsCfx4=;
        b=M/T/LbbOJRnThRRGnsQ8l9AyczaUoHiVNqVBVjcqtkl6jVMiIkyWKWsdSb7t3NbTyG
         gardjJPe4m5I1eJb2fsO2RhuY7HGXNAfO55VCNDdCZxMTtnzZAP8M+LMDa4qJbGD6C3x
         /Her8x7zv6uc+Uk0mOS7Vr2gpWTP1DST17/0ddxRaII8E42xOrdZvC7KXHuFi1KVK6Ih
         1y9NZ43Agkw26T/URTpI+jeiR5rR9PD6bB+1epbCL7adS0mZcHxj4UEvFiG0dxkk6mam
         TPB3XpCFBD2lveHRIC5mJCmzA+/5W9o/G9r4avjgBYBwI/Gjm/5b4sERTCDalU+WcJwW
         hBDQ==
Received: by 10.68.131.40 with SMTP id oj8mr35109818pbb.40.1350282449397;
        Sun, 14 Oct 2012 23:27:29 -0700 (PDT)
Received: from pclouds@gmail.com ([113.161.77.29])
        by mx.google.com with ESMTPS id p3sm2099286paw.8.2012.10.14.23.27.25
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sun, 14 Oct 2012 23:27:28 -0700 (PDT)
Received: by pclouds@gmail.com (sSMTP sendmail emulation); Mon, 15 Oct 2012 13:27:19 +0700
X-Mailer: git-send-email 1.8.0.rc0.29.g1fdd78f
In-Reply-To: <1350282362-4505-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/207708>

dowild() does case insensitive matching by lower-casing the text. That
means lower case letters in patterns imply case-insensitive matching,
but upper case means exact matching.

We do not want that subtlety. Lower case pattern too so iwildmatch()
always does what we expect it to do.

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 wildmatch.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/wildmatch.c b/wildmatch.c
index eef7b13..5469866 100644
--- a/wildmatch.c
+++ b/wildmatch.c
@@ -71,6 +71,8 @@ static int dowild(const uchar *p, const uchar *text, =
int force_lower_case)
 			return ABORT_ALL;
 		if (force_lower_case && ISUPPER(t_ch))
 			t_ch =3D tolower(t_ch);
+		if (force_lower_case && ISUPPER(p_ch))
+			p_ch =3D tolower(p_ch);
 		switch (p_ch) {
 		case '\\':
 			/* Literal match with following character.  Note that the test
--=20
1.8.0.rc0.29.g1fdd78f
