From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 10/41] builtin/pack-objects.c: use die_errno() and warning_errno()
Date: Sun,  1 May 2016 18:14:26 +0700
Message-ID: <1462101297-8610-11-git-send-email-pclouds@gmail.com>
References: <1462101297-8610-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun May 01 13:16:15 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1awpMF-00070B-1K
	for gcvg-git-2@plane.gmane.org; Sun, 01 May 2016 13:16:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752382AbcEALQK convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 1 May 2016 07:16:10 -0400
Received: from mail-pf0-f195.google.com ([209.85.192.195]:34870 "EHLO
	mail-pf0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752367AbcEALQJ (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 1 May 2016 07:16:09 -0400
Received: by mail-pf0-f195.google.com with SMTP id r187so19009728pfr.2
        for <git@vger.kernel.org>; Sun, 01 May 2016 04:16:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ywgfT3CDiqsMECgYSjUiwwmWupoyQ0eqCrc3g1tJJ3o=;
        b=z380QX/eOHxlfENeGm0TX1Jm9jTmECyxxAQK1Akn4kbVA5LqGcybTWao/XGjwDc1fx
         hhMtkvwFKLKe8XE7HmCNmZflKIJP/Bzxy9MeJNJgeeqUcfIIHajj1QAYIFDvepChWq1R
         2FAmrYS0w9Fc7Va73fLZRuI4Y0UD2ycu83EX0KaaJ9uoXhUpxI0oWTY+2Vgh9OeQAY3Z
         OEWz+4Hd47jgSTlgpXGplqgntjH1booSYA8htB9TImio762vxdlIR07O58gT4QbcTX6a
         3uwvYRDwMZ8dnu8mbUtdHC4BKejy8634SIKTyzPN5DejL8HET18WhXkbdzJxQub7eH1G
         0Y9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ywgfT3CDiqsMECgYSjUiwwmWupoyQ0eqCrc3g1tJJ3o=;
        b=P1Snb3ankRsXK1G0LWNDcf90bg9GRgQKo48MvLF4Hes4vyiLpBiIa2EqSzMtSU7xdK
         h2RErnF0Ehyj+S6h8iNe9IFNoaj+skW9QI2Xi1ebzmAwSXNZKO3Hq60vWOXrTHtCJUxQ
         eoy5gsMvxzmr12LpzsFXPGHxHrlUwyg3aNyjUWBt5GsNexf+Tc4bbXCvc/WHL7sa6Abb
         X6lYWOstf5N3o4uEAObmteH0PCUrPrktizskysywNYBCcPQb6+L6PP1sX7H+IpREQ3O9
         Z7RoeJb+9PsSSG4VQeNY6doEjkMWPgAq+Rs0F88VZmawAHWbmqpU+g1pCXObR9rn3erc
         +zzw==
X-Gm-Message-State: AOPr4FU4h+cwaF3Q1kg0d9zJXyliG6MWquUDbJff5bU4zXvLI+kDG7pVeWBScgpLN0Gd7A==
X-Received: by 10.98.103.28 with SMTP id b28mr43898360pfc.155.1462101368839;
        Sun, 01 May 2016 04:16:08 -0700 (PDT)
Received: from lanh ([115.72.42.9])
        by smtp.gmail.com with ESMTPSA id ey12sm37373337pac.26.2016.05.01.04.16.05
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 01 May 2016 04:16:07 -0700 (PDT)
Received: by lanh (sSMTP sendmail emulation); Sun, 01 May 2016 18:16:04 +0700
X-Mailer: git-send-email 2.8.0.rc0.210.gd302cd2
In-Reply-To: <1462101297-8610-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/293160>

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 builtin/pack-objects.c | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/builtin/pack-objects.c b/builtin/pack-objects.c
index a27de5b..e18e190 100644
--- a/builtin/pack-objects.c
+++ b/builtin/pack-objects.c
@@ -828,8 +828,7 @@ static void write_pack_file(void)
 			 * to preserve this property.
 			 */
 			if (stat(pack_tmp_name, &st) < 0) {
-				warning("failed to stat %s: %s",
-					pack_tmp_name, strerror(errno));
+				warning_errno("failed to stat %s", pack_tmp_name);
 			} else if (!last_mtime) {
 				last_mtime =3D st.st_mtime;
 			} else {
@@ -837,8 +836,7 @@ static void write_pack_file(void)
 				utb.actime =3D st.st_atime;
 				utb.modtime =3D --last_mtime;
 				if (utime(pack_tmp_name, &utb) < 0)
-					warning("failed utime() on %s: %s",
-						pack_tmp_name, strerror(errno));
+					warning_errno("failed utime() on %s", pack_tmp_name);
 			}
=20
 			strbuf_addf(&tmpname, "%s-", base_name);
@@ -2020,7 +2018,7 @@ static void ll_find_deltas(struct object_entry **=
list, unsigned list_size,
 		ret =3D pthread_create(&p[i].thread, NULL,
 				     threaded_find_deltas, &p[i]);
 		if (ret)
-			die("unable to create thread: %s", strerror(ret));
+			die_errno("unable to create thread");
 		active_threads++;
 	}
=20
--=20
2.8.0.rc0.210.gd302cd2
