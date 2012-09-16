From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH v2 3/5] compat/wildmatch: fix case-insensitive matching
Date: Sun, 16 Sep 2012 22:27:43 +0700
Message-ID: <1347809265-2457-4-git-send-email-pclouds@gmail.com>
References: <1347710524-15404-1-git-send-email-pclouds@gmail.com>
 <1347809265-2457-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Sep 16 17:28:31 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TDGlm-0004Aq-HZ
	for gcvg-git-2@plane.gmane.org; Sun, 16 Sep 2012 17:28:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752374Ab2IPP2B convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 16 Sep 2012 11:28:01 -0400
Received: from mail-pz0-f46.google.com ([209.85.210.46]:48435 "EHLO
	mail-pz0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752230Ab2IPP2A (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 16 Sep 2012 11:28:00 -0400
Received: by mail-pz0-f46.google.com with SMTP id y13so352787dad.19
        for <git@vger.kernel.org>; Sun, 16 Sep 2012 08:28:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=luYJEWqs77y7Zbrzde/8SVHCZrjc19/OD8DbQ4CtTYg=;
        b=v25QSZQ2Gr+7fxFu7sQ24yKcdSKVOfpAsrdmKhdNz7ZEIB6SxWs6tiTWPrdL0abTH8
         FKoI+cdj2oGHJ0rbyg3zBdqj5TMehv6OVimTsQTQoHJv5v1IJSp251D7euHaU/7m7Z3h
         TFHMl3GPkmfyY2v/chO0AQ68RcEbet7D6IlQVqKDL5FZoB8lf4jwiaDU0z69ZHA7FMTI
         80l1/LAsss+KhwnOCjtXJXrYaTXO/YGwZBzdBn1b+90D1cgpUBv6DBGFYZU+5EuU5itU
         w5yrSkI9JXn3mzkOl5vzG0jyZuoOMZmLxKpxfAhrHd8lBaex9lnSFWTc/EOPkUYK6QFV
         TImw==
Received: by 10.68.221.167 with SMTP id qf7mr17031670pbc.4.1347809280349;
        Sun, 16 Sep 2012 08:28:00 -0700 (PDT)
Received: from lanh ([115.74.50.93])
        by mx.google.com with ESMTPS id ox5sm5185777pbc.75.2012.09.16.08.27.57
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sun, 16 Sep 2012 08:27:59 -0700 (PDT)
Received: by lanh (sSMTP sendmail emulation); Sun, 16 Sep 2012 22:28:04 +0700
X-Mailer: git-send-email 1.7.12.403.gce5cf6f.dirty
In-Reply-To: <1347809265-2457-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/205624>

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
index e824eb2..c7f7f9f 100644
--- a/wildmatch.c
+++ b/wildmatch.c
@@ -81,6 +81,8 @@ static int dowild(const uchar *p, const uchar *text,
 	}
 	if (force_lower_case && ISUPPER(t_ch))
 	    t_ch =3D tolower(t_ch);
+	if (force_lower_case && ISUPPER(p_ch))
+	    p_ch =3D tolower(p_ch);
 	switch (p_ch) {
 	  case '\\':
 	    /* Literal match with following character.  Note that the test
--=20
1.7.12.403.gce5cf6f.dirty
