From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH v4 08/12] wildmatch: fix case-insensitive matching
Date: Wed, 10 Oct 2012 17:40:47 +0700
Message-ID: <1349865651-31889-9-git-send-email-pclouds@gmail.com>
References: <1349865651-31889-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	Michael Haggerty <mhagger@alum.mit.edu>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Oct 10 12:42:05 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TLtjo-0002uk-7g
	for gcvg-git-2@plane.gmane.org; Wed, 10 Oct 2012 12:42:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755659Ab2JJKlz convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 10 Oct 2012 06:41:55 -0400
Received: from mail-pa0-f46.google.com ([209.85.220.46]:49272 "EHLO
	mail-pa0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755619Ab2JJKlw (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 10 Oct 2012 06:41:52 -0400
Received: by mail-pa0-f46.google.com with SMTP id hz1so466174pad.19
        for <git@vger.kernel.org>; Wed, 10 Oct 2012 03:41:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=rroWdoQfCwzW3nbJLGENHwc12+n0r+0s1IuHwRN/oZo=;
        b=QfJACG624pumP9EClzNRTSp7Gn7WGz9JtTIG6iEl5ZzEZNNYSPn+693AJpVl/YBomh
         1fZh6obB85FIxNWqWeFhlmeARYIlQJXrpNfqeGPHkPcgWw96RVKClbszEpoiBwLaU38M
         DLVKQr2JT7aAhaqjC+lWWMQsATtsjhEi1FQsakzUkNI7n+k5DpAMN1+WvToFmcf3vAyX
         zJ4i/NRSAKpqIMYKQSG7pUrqiHabKTSadxhUM5Be5fLRorTNZnc7pVfpwq5Ftvv/0vSF
         ApTJULQjI/8x64GlrujptW4O5A77IoQqOOrfr0qYnjOT1UGRlVboOF/E7zms5J8wGyL2
         chsA==
Received: by 10.66.88.197 with SMTP id bi5mr60893260pab.58.1349865712720;
        Wed, 10 Oct 2012 03:41:52 -0700 (PDT)
Received: from pclouds@gmail.com ([115.74.54.82])
        by mx.google.com with ESMTPS id yi9sm500405pbc.39.2012.10.10.03.41.49
        (version=TLSv1/SSLv3 cipher=OTHER);
        Wed, 10 Oct 2012 03:41:52 -0700 (PDT)
Received: by pclouds@gmail.com (sSMTP sendmail emulation); Wed, 10 Oct 2012 17:41:44 +0700
X-Mailer: git-send-email 1.7.12.1.406.g6ab07c4
In-Reply-To: <1349865651-31889-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/207393>

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
index d18d721..b700631 100644
--- a/wildmatch.c
+++ b/wildmatch.c
@@ -72,6 +72,8 @@ static int dowild(const uchar *p, const uchar *text, =
int force_lower_case)
 		return ABORT_ALL;
 	if (force_lower_case && ISUPPER(t_ch))
 	    t_ch =3D tolower(t_ch);
+	if (force_lower_case && ISUPPER(p_ch))
+	    p_ch =3D tolower(p_ch);
 	switch (p_ch) {
 	  case '\\':
 	    /* Literal match with following character.  Note that the test
--=20
1.7.12.1.406.g6ab07c4
