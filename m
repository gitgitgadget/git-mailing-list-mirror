From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 19/25] list-files: make alias 'ls' default to 'list-files'
Date: Mon,  6 Apr 2015 20:52:28 +0700
Message-ID: <1428328354-14897-20-git-send-email-pclouds@gmail.com>
References: <1428328354-14897-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: 1425896314-10941-1-git-send-email-pclouds@gmail.com,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Apr 06 15:54:44 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Yf7UB-00061P-Br
	for gcvg-git-2@plane.gmane.org; Mon, 06 Apr 2015 15:54:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753430AbbDFNyj convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 6 Apr 2015 09:54:39 -0400
Received: from mail-pa0-f51.google.com ([209.85.220.51]:33231 "EHLO
	mail-pa0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753428AbbDFNyi (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 6 Apr 2015 09:54:38 -0400
Received: by paboj16 with SMTP id oj16so45232448pab.0
        for <git@vger.kernel.org>; Mon, 06 Apr 2015 06:54:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=jf8TZKZQ4tgK8dm2+52L8bHCsbRoLd07Y4afQQK82EU=;
        b=HqHEJYPAPqTtUfsyidMBXNQ1JtA1il0H8d4czwvLLwuZ5XyXoEB5BzgJNfqqQAaR/P
         t8+1qm0GJHcAMfOGzqjpyGHtHsUm6SyFiUibZafp1D1BfJbMepOqbbjRZ+3DXZ06cnhr
         JqkItnjvwn66P+fgAn81vOXwUuzDx+t/Y3oc5alKaLSkAlHIcqGzBkf9ksEr6dRqdpvA
         Noub98ZT8mQONf6ScQWtE6AvADNyaO45DORmYqhmDZQgJAupTvI1NFVc75zEbrl9CJot
         HBweSCPK+Y/WrTQwwcZd3o+fG8U+I2Mf5Q/sBg72HMZDggDIDe5riLw0GWzgmSREC47q
         1xOg==
X-Received: by 10.70.18.68 with SMTP id u4mr27929301pdd.38.1428328478008;
        Mon, 06 Apr 2015 06:54:38 -0700 (PDT)
Received: from lanh ([115.73.245.217])
        by mx.google.com with ESMTPSA id dc8sm2237020pdb.23.2015.04.06.06.54.35
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 06 Apr 2015 06:54:37 -0700 (PDT)
Received: by lanh (sSMTP sendmail emulation); Mon, 06 Apr 2015 20:54:49 +0700
X-Mailer: git-send-email 2.3.0.rc1.137.g477eb31
In-Reply-To: <1428328354-14897-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/266863>

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 config.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/config.c b/config.c
index 15a2983..16209c6 100644
--- a/config.c
+++ b/config.c
@@ -40,6 +40,10 @@ static struct config_source *cf;
=20
 static int zlib_compression_seen;
=20
+static const char *builtin_config =3D
+	"[alias]\n"
+	"	ls =3D list-files\n";
+
 /*
  * Default config_set that contains key-value pairs from the usual set=
 of config
  * config files (i.e repo specific .git/config, user wide ~/.gitconfig=
, XDG
@@ -1175,6 +1179,10 @@ int git_config_early(config_fn_t fn, void *data,=
 const char *repo_config)
=20
 	home_config_paths(&user_config, &xdg_config, "config");
=20
+	if (git_config_system())
+		git_config_from_buf(fn, "<builtin>", builtin_config,
+				    strlen(builtin_config), data);
+
 	if (git_config_system() && !access_or_die(git_etc_gitconfig(), R_OK, =
0)) {
 		ret +=3D git_config_from_file(fn, git_etc_gitconfig(),
 					    data);
--=20
2.3.0.rc1.137.g477eb31
