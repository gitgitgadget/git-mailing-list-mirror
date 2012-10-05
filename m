From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 07/10] wildmatch: fix case-insensitive matching
Date: Fri,  5 Oct 2012 11:41:06 +0700
Message-ID: <1349412069-627-8-git-send-email-pclouds@gmail.com>
References: <1349412069-627-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	Michael Haggerty <mhagger@alum.mit.edu>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Oct 05 09:17:17 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TK29t-0004hR-Bq
	for gcvg-git-2@plane.gmane.org; Fri, 05 Oct 2012 09:17:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751540Ab2JEHRG convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 5 Oct 2012 03:17:06 -0400
Received: from mail-pa0-f46.google.com ([209.85.220.46]:33761 "EHLO
	mail-pa0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751232Ab2JEHRE (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 5 Oct 2012 03:17:04 -0400
Received: by mail-pa0-f46.google.com with SMTP id hz1so1382927pad.19
        for <git@vger.kernel.org>; Fri, 05 Oct 2012 00:17:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=9J7Ecj55qM2p69KpuEAwdbXLBfKlFtjQqU5PbTCh13c=;
        b=RfxhxPm2uuYDgbkahQU/Nu1lS67tiW1SM31lWzRWjefYk18FIVQX942Xs0d1oBdgTX
         KmUrE2K0NBh3EN+LyBwuzKghhN2cVq+CmQXvok7ec3HnG/mwEWOR1Y84PybHO4RbNOUD
         690JMpPq8r3wunv86AazaqZ294Pviu4ULzAYaA4yOSBbmb5MbE/TQWvypSRgYhgi+5s9
         yGWHqkuS2OlgxYersQU2EDyfGXezGGPjTv4HfhOcXZMATPArCoX28yclreelXLJzhS6y
         ioMF4k5To5sJC8Zw20AYEdtgbt6gT/EsNRm7J4s4OII1xa+A2yqLVAs1DK742LxaWF/Y
         wm6g==
Received: by 10.68.200.227 with SMTP id jv3mr27308273pbc.162.1349412104082;
        Thu, 04 Oct 2012 21:41:44 -0700 (PDT)
Received: from tre ([115.74.45.10])
        by mx.google.com with ESMTPS id qn1sm5427327pbc.55.2012.10.04.21.41.41
        (version=TLSv1/SSLv3 cipher=OTHER);
        Thu, 04 Oct 2012 21:41:43 -0700 (PDT)
Received: by tre (sSMTP sendmail emulation); Fri, 05 Oct 2012 11:41:52 +0700
X-Mailer: git-send-email 1.7.10.1.641.g9354186
In-Reply-To: <1349412069-627-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/207080>

dowild() does case insensitive matching by lower-casing the text. That
means lower case letters in patterns imply case-insensitive matching,
but upper case means exact matching.

We do not want that subtlety. Lower case pattern too so iwildmatch()
always does what we expect it to do.

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
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
1.7.12.1.405.gb727dc9
