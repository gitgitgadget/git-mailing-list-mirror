From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 16/16] list-files: make alias 'ls' default to 'list-files'
Date: Mon,  9 Mar 2015 17:18:34 +0700
Message-ID: <1425896314-10941-17-git-send-email-pclouds@gmail.com>
References: <1425896314-10941-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>, git@drmicha.warpmail.net,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Mar 09 11:20:40 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YUund-0002tW-AU
	for gcvg-git-2@plane.gmane.org; Mon, 09 Mar 2015 11:20:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932207AbbCIKUd convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 9 Mar 2015 06:20:33 -0400
Received: from mail-pd0-f179.google.com ([209.85.192.179]:43603 "EHLO
	mail-pd0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932069AbbCIKUb (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 9 Mar 2015 06:20:31 -0400
Received: by pdjp10 with SMTP id p10so56796206pdj.10
        for <git@vger.kernel.org>; Mon, 09 Mar 2015 03:20:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=jf8TZKZQ4tgK8dm2+52L8bHCsbRoLd07Y4afQQK82EU=;
        b=uXcf4fC7r+l+/FMWHJYszkkcs3cxxoDYVQlUZUZN4HtD7ykTaTPOJem7RceFADdzGu
         8mW0NLyS5u8Tav9Oq/6ilIaIoHKZ8d9JKgs0QVGBxXE6xM2wIxFw6nmTUHbJsrA36JD2
         tR0nmkRQVp2se+48Ziu2vUMGIu5rK+1MYsMUZNxXqEVYoqbc4iWHtLFxNSFe6GBe4G3L
         DAVsahbLSJ4iBbAbGYqZ2joFOoLQRMcEe7SqxoDqrddL0S8//IBl0HI6qMin8jeU/vBm
         jXJ4Cr6c9ce9o0d6jSWPFtlx4ZveWzBClVET7ZrsjCFT4O7AEjxwhd356McOgC3wjjeI
         pgDQ==
X-Received: by 10.70.55.65 with SMTP id q1mr13149790pdp.35.1425896430829;
        Mon, 09 Mar 2015 03:20:30 -0700 (PDT)
Received: from lanh ([115.73.245.123])
        by mx.google.com with ESMTPSA id d4sm18437178pdm.50.2015.03.09.03.20.27
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 09 Mar 2015 03:20:29 -0700 (PDT)
Received: by lanh (sSMTP sendmail emulation); Mon, 09 Mar 2015 17:20:26 +0700
X-Mailer: git-send-email 2.3.0.rc1.137.g477eb31
In-Reply-To: <1425896314-10941-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/265158>

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
