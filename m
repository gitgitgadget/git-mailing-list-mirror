From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH v2 03/41] bisect.c: use die_errno() and warning_errno()
Date: Tue,  3 May 2016 19:03:36 +0700
Message-ID: <1462277054-5943-4-git-send-email-pclouds@gmail.com>
References: <1462101297-8610-1-git-send-email-pclouds@gmail.com>
 <1462277054-5943-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Jeff King <peff@peff.net>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue May 03 14:06:39 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1axZ65-000884-Dt
	for gcvg-git-2@plane.gmane.org; Tue, 03 May 2016 14:06:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932881AbcECMGd convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 3 May 2016 08:06:33 -0400
Received: from mail-pa0-f49.google.com ([209.85.220.49]:35227 "EHLO
	mail-pa0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932462AbcECMGc (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 3 May 2016 08:06:32 -0400
Received: by mail-pa0-f49.google.com with SMTP id iv1so8843718pac.2
        for <git@vger.kernel.org>; Tue, 03 May 2016 05:06:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=B3bzeIA/gdyoYduk8KkAsCm711A0fc2Dx1J+MYMKpr0=;
        b=1GkbwPfkbxzDwksN5k4AvIDwxht4Dzt89g8TKHIK/EkFe0nW4LN0rs26LffINrgCbN
         bCRcLcGvHo6DJnMfTcHOEyWp8p75YBpXix7R1bfQQvI5zHc/NP7ogxCa5EjagNOUKgtz
         YUpM/twFSVsuMD2ZZ35WtwFLU6UcsLPlPXgCwtyMYDE3zD/RNxn9TC0mF1TC0OFeCHjL
         ejU2gZj/i2kvawrBD1lOnfU8CQifoj/KB2ZYAD6A+a7RFEAPBMdXd/noZol8emtdqmyK
         F7eqIwKh4FHunywucSl74GSqZOWSgfxBV1L7yOkknHqWafUgY7fG5gqJ08Da51nCl+Y6
         GPMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=B3bzeIA/gdyoYduk8KkAsCm711A0fc2Dx1J+MYMKpr0=;
        b=FZajyosXG4mr113wLPYd8wkV7uw7cAgHEmThiLoEgr8n3eTY3dIzv2783c2mVzqlXd
         CKxNU8Jhi8FjjzOooiqoenZSTYWjRIZrKazGgBf/TepHux57txYL1WJ1qKVQEeT2Ss7M
         FuR56ZHTHS1DWZWBnA5k5ZJBiK1PU/6otfpZDVv3xqKwuXv3fMm/b7DOf3zQf7cuiJEV
         vZbsp3HETF4mVOypmTk1r4i3reFIvibXBb1gZsCX/D0cWe5RsKKdsq8A4ZWAQCEIAhCl
         n6629xl+AKAw1mpmIuolmQYyU69eM9IVyp3NjMKTBuD6dYnRjXvwuYbvAtCiytclydwX
         Qmlg==
X-Gm-Message-State: AOPr4FVTvxUDVrVahPUZckC5i4PHaS5wfQCGY3odIEZkhPjdXynHdrsp1fnDyEs2ByZ62Q==
X-Received: by 10.66.173.141 with SMTP id bk13mr2887102pac.64.1462277191532;
        Tue, 03 May 2016 05:06:31 -0700 (PDT)
Received: from lanh ([115.72.42.9])
        by smtp.gmail.com with ESMTPSA id v185sm5476404pfb.72.2016.05.03.05.06.27
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 03 May 2016 05:06:30 -0700 (PDT)
Received: by lanh (sSMTP sendmail emulation); Tue, 03 May 2016 19:06:27 +0700
X-Mailer: git-send-email 2.8.0.rc0.210.gd302cd2
In-Reply-To: <1462277054-5943-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/293356>

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 bisect.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/bisect.c b/bisect.c
index 7996c29..6d93edb 100644
--- a/bisect.c
+++ b/bisect.c
@@ -860,8 +860,8 @@ static void check_good_are_ancestors_of_bad(const c=
har *prefix, int no_checkout)
 	/* Create file BISECT_ANCESTORS_OK. */
 	fd =3D open(filename, O_CREAT | O_TRUNC | O_WRONLY, 0600);
 	if (fd < 0)
-		warning("could not create file '%s': %s",
-			filename, strerror(errno));
+		warning_errno("could not create file '%s'",
+			      filename);
 	else
 		close(fd);
  done:
@@ -910,8 +910,7 @@ void read_bisect_terms(const char **read_bad, const=
 char **read_good)
 			*read_good =3D "good";
 			return;
 		} else {
-			die("could not read file '%s': %s", filename,
-				strerror(errno));
+			die_errno("could not read file '%s'", filename);
 		}
 	} else {
 		strbuf_getline_lf(&str, fp);
--=20
2.8.0.rc0.210.gd302cd2
