From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 03/41] bisect.c: use die_errno() and warning_errno()
Date: Sun,  1 May 2016 18:14:19 +0700
Message-ID: <1462101297-8610-4-git-send-email-pclouds@gmail.com>
References: <1462101297-8610-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun May 01 13:15:36 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1awpLc-0006hd-3j
	for gcvg-git-2@plane.gmane.org; Sun, 01 May 2016 13:15:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752110AbcEALPb convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 1 May 2016 07:15:31 -0400
Received: from mail-pa0-f68.google.com ([209.85.220.68]:36712 "EHLO
	mail-pa0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751834AbcEALPa (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 1 May 2016 07:15:30 -0400
Received: by mail-pa0-f68.google.com with SMTP id i5so16176677pag.3
        for <git@vger.kernel.org>; Sun, 01 May 2016 04:15:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=B3bzeIA/gdyoYduk8KkAsCm711A0fc2Dx1J+MYMKpr0=;
        b=p6YmgFerMFQ5Gy5h3YxEOHvPfmzIe47K6/Ge3SKSlJ3/7/RSggPFhpAEKAr51D6b0m
         xV87ZFCWAeCxTO1qzlkuv9MaertTZnJ25QqRHyh6p5YZgxcbTMZoShx7zyclFoe+CplQ
         1RR+Og4XvJd4wpAtkQTN2WQ7kYCFWAbLSQ/bfEgmYyUYr6e0RmO2Wj+euLhpU2U4CFBX
         r9qrtYKu0Z1Irp0ibeH2gB79XHmE0unZ+Xk0nyiiw0j0l+/zVL+DZ4ufLEiwBbNHV/H5
         jlph7qvi0eUEa3MWwIaz9ZPDVu7KsrFsInjIu+wRs9rJ8HZhicB+cs6PQkE243pT1+I2
         H6qA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=B3bzeIA/gdyoYduk8KkAsCm711A0fc2Dx1J+MYMKpr0=;
        b=NGubph7PT/vlNARH+UCUUirKXdgnbzLCZDGf9j1toD+woS5Guo+Tm6Kbg7XPCd47o3
         ttSqmOUcV4fBcybPsUWZtdwWgeXnGgbZO8hGRwFCjjShK1eVD7an26PMzsxUPcAjOJ08
         eTX3CnXxsMtx0SGrfYx080ox1hD5CEFjTbJnMY1qoG2YthbRk9elFRDg49xXdojTY5Dv
         dvupyzMCW5svi9cm0/c6J7LGERV5pIqpTLi4TPcOLt2DM+CcdFyv/G7OtAWhgpJAd7W9
         T4w1L54RAxOm/lcBXJOAYiU98ZDeYldL9i4rFoBsn0roKO9gvxRzJaf7GIVWh0FUagLP
         4UHA==
X-Gm-Message-State: AOPr4FUO2hf1UGm/UMSPMgt1eSIXUAKjrha91XM0mvJcSfrADw4dyNoP9hOmcJx/Mf3ERQ==
X-Received: by 10.67.1.3 with SMTP id bc3mr40763489pad.138.1462101329694;
        Sun, 01 May 2016 04:15:29 -0700 (PDT)
Received: from lanh ([115.72.42.9])
        by smtp.gmail.com with ESMTPSA id b64sm37094684pfa.48.2016.05.01.04.15.26
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 01 May 2016 04:15:28 -0700 (PDT)
Received: by lanh (sSMTP sendmail emulation); Sun, 01 May 2016 18:15:25 +0700
X-Mailer: git-send-email 2.8.0.rc0.210.gd302cd2
In-Reply-To: <1462101297-8610-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/293153>

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
