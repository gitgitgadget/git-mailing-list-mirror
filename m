From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 3/5] compat/wildmatch: fix case-insensitive matching
Date: Sat, 15 Sep 2012 19:02:02 +0700
Message-ID: <1347710524-15404-4-git-send-email-pclouds@gmail.com>
References: <1347710524-15404-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Sep 15 14:03:27 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TCr5o-0003P0-SO
	for gcvg-git-2@plane.gmane.org; Sat, 15 Sep 2012 14:03:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753592Ab2IOMC5 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 15 Sep 2012 08:02:57 -0400
Received: from mail-pz0-f46.google.com ([209.85.210.46]:60555 "EHLO
	mail-pz0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753397Ab2IOMCV (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 15 Sep 2012 08:02:21 -0400
Received: by dady13 with SMTP id y13so2989164dad.19
        for <git@vger.kernel.org>; Sat, 15 Sep 2012 05:02:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=tXz+WYIXiMRkL/UpQvzAhb7eEZmS8PEDOVHMrEBcCXc=;
        b=fdGgwiuXW6xUCnhCqaurkYUFUrn9t2/u0avtymqrwMDa5KPZjYpjBubuoRwefokpXn
         M685HEaeShhse+8Yex18/an1GOQ90fpdon2xI75buubsKj1Wuiiyaqbnh/iq/VTj6U7T
         wVKFEsObab8Wzyr6WBFOpdFi0/5h2pMEAp8cVNDlaXXzZZIn+gTDM96H5lPLWgZZkn9S
         TmGhxSCRREGCNvCzvhKI2znT5YqL+QJ9P4C1k/1fyo+R3jVzhPouvknf/Zt/g155AyFY
         jn1cAiwTBScgqNLJU448qcEvFx7OFNPAAxPPQPZwRUo3bZbCLp4S3L4bW1PRXalQ6cVT
         MhDQ==
Received: by 10.68.234.65 with SMTP id uc1mr10123190pbc.89.1347710540746;
        Sat, 15 Sep 2012 05:02:20 -0700 (PDT)
Received: from lanh ([115.74.56.159])
        by mx.google.com with ESMTPS id pi1sm2861170pbb.7.2012.09.15.05.02.18
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sat, 15 Sep 2012 05:02:20 -0700 (PDT)
Received: by lanh (sSMTP sendmail emulation); Sat, 15 Sep 2012 19:02:23 +0700
X-Mailer: git-send-email 1.7.12.403.gce5cf6f.dirty
In-Reply-To: <1347710524-15404-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/205557>

dowild() does case insensitive matching by lower-casing the text. That
means lower case letters in patterns imply case-insensitive matching,
but upper case means exact matching.

We do not want that subtlety. Lower case pattern too so iwildmatch()
always does what we expect it to do.

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 compat/wildmatch.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/compat/wildmatch.c b/compat/wildmatch.c
index e824eb2..c7f7f9f 100644
--- a/compat/wildmatch.c
+++ b/compat/wildmatch.c
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
