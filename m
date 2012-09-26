From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 3/5] compat/wildmatch: fix case-insensitive matching
Date: Wed, 26 Sep 2012 18:25:39 +0700
Message-ID: <1348658741-8146-4-git-send-email-pclouds@gmail.com>
References: <1348658741-8146-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Sep 26 13:34:44 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TGpt2-0005jp-NN
	for gcvg-git-2@plane.gmane.org; Wed, 26 Sep 2012 13:34:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755211Ab2IZLec convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 26 Sep 2012 07:34:32 -0400
Received: from mail-pb0-f46.google.com ([209.85.160.46]:55406 "EHLO
	mail-pb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754132Ab2IZLeb (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 26 Sep 2012 07:34:31 -0400
Received: by mail-pb0-f46.google.com with SMTP id rr4so1747509pbb.19
        for <git@vger.kernel.org>; Wed, 26 Sep 2012 04:34:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=gYKMJY85P2EE0ROgNmwDeiaODlUaZ6JlSdAiXixCKnE=;
        b=UBBBkWdXCdzZnEQ4daT6YMh/plOrpe2CrDY4CbwGRIc8pYtupXLf5tUchMUwuXjzxR
         gf8Odj8ExYvgvqrgFZpSIglNabFYlhnjTnMIh/Dx9S4YPidFTcmgF8XEh4jVaZFFNQvZ
         Mt/D/vf1Cnko0jFcdlex9GecYj1AUDDzewS+SejMdvmBlkFOem3skrerxthxAojfO89B
         Cu82O5fH4eHLYqh/LBgMQfW6a/a72dsfYvuIJ/a6iBv0NalKqBsDy1U1aF1B5Hq+DtaQ
         +2yWpeAF2jm5opcwBu/J1omPX1Mcm8Iiri/Z4XbEH9FDpnn0ZnhVY9w7u+M+AZ6tnrUR
         Z6SQ==
Received: by 10.68.200.72 with SMTP id jq8mr1770892pbc.38.1348659270920;
        Wed, 26 Sep 2012 04:34:30 -0700 (PDT)
Received: from pclouds@gmail.com ([115.74.51.2])
        by mx.google.com with ESMTPS id nx5sm1937244pbb.49.2012.09.26.04.34.28
        (version=TLSv1/SSLv3 cipher=OTHER);
        Wed, 26 Sep 2012 04:34:30 -0700 (PDT)
Received: by pclouds@gmail.com (sSMTP sendmail emulation); Wed, 26 Sep 2012 18:27:44 +0700
X-Mailer: git-send-email 1.7.12.1.406.g6ab07c4
In-Reply-To: <1348658741-8146-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/206409>

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
1.7.12.1.406.g6ab07c4
