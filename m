From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH v2 1/2] fetch: convert argv_gc_auto to struct argv_array
Date: Sat, 16 Aug 2014 08:19:27 +0700
Message-ID: <1408151968-30294-1-git-send-email-pclouds@gmail.com>
References: <1408017065-17437-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: mflaschen@wikimedia.org, Jeff King <peff@peff.net>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Aug 16 03:19:51 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XISes-0002e1-SA
	for gcvg-git-2@plane.gmane.org; Sat, 16 Aug 2014 03:19:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751464AbaHPBTi convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 15 Aug 2014 21:19:38 -0400
Received: from mail-pd0-f176.google.com ([209.85.192.176]:55462 "EHLO
	mail-pd0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751333AbaHPBTh (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 15 Aug 2014 21:19:37 -0400
Received: by mail-pd0-f176.google.com with SMTP id y10so4170056pdj.7
        for <git@vger.kernel.org>; Fri, 15 Aug 2014 18:19:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=XiV/9ITfxZlvDGTicx2qZLiifods5XZ8u3b8lAFrSCs=;
        b=HByCzgfJdacO3uL1X2yihTamEB/KeAbCnGqq/1teq+YCsAdYd/e6EPESWwXZY9TnFY
         1SqLRXaUpP+sPC9imC+pubzyAWWtvSAwZ8Dntvjlg59mutfSxbnY1j5X87uZ14ftYrDw
         K0/sG0zpQn2wBnoQeO1Ora03O2keCfBzt8xPW3QrL0vr85glD6jEb0+fzeDS5cA8PgTU
         20ksx5fWoWr95tN7d4TNzYJbt2LTab4p2DnDCf2+dAv9vvvI4Muuh7MErhwuMBb/sYrs
         Iq3N0Hjp/4Tf3/37rE8lgoaigFWBdQ94KBBQQPJTPfJ4Z/wbzvrf42FsZHf9BlYv0t+J
         9nGg==
X-Received: by 10.68.215.106 with SMTP id oh10mr16634926pbc.98.1408151977273;
        Fri, 15 Aug 2014 18:19:37 -0700 (PDT)
Received: from lanh ([115.73.215.192])
        by mx.google.com with ESMTPSA id ki7sm9158620pbc.65.2014.08.15.18.19.34
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 15 Aug 2014 18:19:36 -0700 (PDT)
Received: by lanh (sSMTP sendmail emulation); Sat, 16 Aug 2014 08:19:34 +0700
X-Mailer: git-send-email 2.1.0.rc0.78.gc0d8480
In-Reply-To: <1408017065-17437-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/255311>

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 builtin/fetch.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/builtin/fetch.c b/builtin/fetch.c
index e8d0cca..5f06114 100644
--- a/builtin/fetch.c
+++ b/builtin/fetch.c
@@ -1110,9 +1110,7 @@ int cmd_fetch(int argc, const char **argv, const =
char *prefix)
 	struct string_list list =3D STRING_LIST_INIT_NODUP;
 	struct remote *remote;
 	int result =3D 0;
-	static const char *argv_gc_auto[] =3D {
-		"gc", "--auto", NULL,
-	};
+	struct argv_array argv_gc_auto =3D ARGV_ARRAY_INIT;
=20
 	packet_trace_identity("fetch");
=20
@@ -1198,7 +1196,9 @@ int cmd_fetch(int argc, const char **argv, const =
char *prefix)
 	list.strdup_strings =3D 1;
 	string_list_clear(&list, 0);
=20
-	run_command_v_opt(argv_gc_auto, RUN_GIT_CMD);
+	argv_array_pushl(&argv_gc_auto, "gc", "--auto", NULL);
+	run_command_v_opt(argv_gc_auto.argv, RUN_GIT_CMD);
+	argv_array_clear(&argv_gc_auto);
=20
 	return result;
 }
--=20
2.1.0.rc0.78.gc0d8480
