From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH v2 07/16] pack-objects: add --version to specify written pack version
Date: Mon,  9 Sep 2013 20:57:58 +0700
Message-ID: <1378735087-4813-8-git-send-email-pclouds@gmail.com>
References: <1378652660-6731-1-git-send-email-pclouds@gmail.com>
 <1378735087-4813-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: Nicolas Pitre <nico@fluxnic.net>
X-From: git-owner@vger.kernel.org Mon Sep 09 15:56:02 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VJ1we-0002xd-Mv
	for gcvg-git-2@plane.gmane.org; Mon, 09 Sep 2013 15:56:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753421Ab3IINzz convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 9 Sep 2013 09:55:55 -0400
Received: from mail-pb0-f49.google.com ([209.85.160.49]:53175 "EHLO
	mail-pb0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751891Ab3IINzy (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 9 Sep 2013 09:55:54 -0400
Received: by mail-pb0-f49.google.com with SMTP id xb4so6122543pbc.36
        for <git@vger.kernel.org>; Mon, 09 Sep 2013 06:55:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=Gz8RpHEQOHVtct5mYu6UkJLsLU1LXJwkyh98UNhSXbs=;
        b=bcoBmbmRfCm584kIklkWl5j1pc7GN/l9KTnryFLyfxF7LCc0QSoyz+0EIzExw3tpQZ
         mXBvZEWzklCcMPWPlp1SY5O5CtwOacwkfHVyEVWtpJ5vaJwqA7fKBCurIS9oIsBkaYcl
         yLKxdKz10p3hedWx7i3I4NlZtArQ2Nk2VJRsrVzcJrIaWxCtph4XS5I8SYL0g40+tjE5
         r08Xb7+eCrpAf6ov5QsrR/QKUFo1ukp8wU8wbHQkYYnM7dYonRVuYrzJFuy0cPwBNFlk
         Q/S5YGOs5Vt3i7EqeCsQwONVBqsr+0RjOI8ZPkM5X8DWF7GPrbcI40lQTDLfw4gzhLzT
         jOAQ==
X-Received: by 10.68.234.73 with SMTP id uc9mr3346561pbc.142.1378734953265;
        Mon, 09 Sep 2013 06:55:53 -0700 (PDT)
Received: from lanh ([115.73.228.17])
        by mx.google.com with ESMTPSA id sy10sm3882415pac.15.1969.12.31.16.00.00
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Mon, 09 Sep 2013 06:55:52 -0700 (PDT)
Received: by lanh (sSMTP sendmail emulation); Mon, 09 Sep 2013 20:59:02 +0700
X-Mailer: git-send-email 1.8.2.83.gc99314b
In-Reply-To: <1378735087-4813-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/234335>


Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 builtin/pack-objects.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/builtin/pack-objects.c b/builtin/pack-objects.c
index 33faea8..ef68fc5 100644
--- a/builtin/pack-objects.c
+++ b/builtin/pack-objects.c
@@ -81,6 +81,7 @@ static int num_preferred_base;
 static struct progress *progress_state;
 static int pack_compression_level =3D Z_DEFAULT_COMPRESSION;
 static int pack_compression_seen;
+static int pack_version =3D 2;
=20
 static unsigned long delta_cache_size =3D 0;
 static unsigned long max_delta_cache_size =3D 256 * 1024 * 1024;
@@ -735,7 +736,7 @@ static void write_pack_file(void)
 		else
 			f =3D create_tmp_packfile(&pack_tmp_name);
=20
-		offset =3D write_pack_header(f, 2, nr_remaining);
+		offset =3D write_pack_header(f, pack_version, nr_remaining);
 		if (!offset)
 			die_errno("unable to write pack header");
 		nr_written =3D 0;
@@ -2455,6 +2456,7 @@ int cmd_pack_objects(int argc, const char **argv,=
 const char *prefix)
 		{ OPTION_CALLBACK, 0, "index-version", NULL, N_("version[,offset]"),
 		  N_("write the pack index file in the specified idx format version"=
),
 		  0, option_parse_index_version },
+		OPT_INTEGER(0, "version", &pack_version, N_("pack version")),
 		OPT_ULONG(0, "max-pack-size", &pack_size_limit,
 			  N_("maximum size of each output pack file")),
 		OPT_BOOL(0, "local", &local,
@@ -2525,6 +2527,8 @@ int cmd_pack_objects(int argc, const char **argv,=
 const char *prefix)
 	}
 	if (pack_to_stdout !=3D !base_name || argc)
 		usage_with_options(pack_usage, pack_objects_options);
+	if (pack_version !=3D 2)
+		die(_("pack version %d is not supported"), pack_version);
=20
 	rp_av[rp_ac++] =3D "pack-objects";
 	if (thin) {
--=20
1.8.2.83.gc99314b
