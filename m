From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 1/2] fetch: convert argv_gc_auto to struct argv_array
Date: Thu, 14 Aug 2014 18:51:04 +0700
Message-ID: <1408017065-17437-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: mflaschen@wikimedia.org,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Aug 14 13:51:23 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XHtYu-0001aZ-Jj
	for gcvg-git-2@plane.gmane.org; Thu, 14 Aug 2014 13:51:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754789AbaHNLvQ convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 14 Aug 2014 07:51:16 -0400
Received: from mail-pa0-f50.google.com ([209.85.220.50]:58485 "EHLO
	mail-pa0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754563AbaHNLvQ (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 14 Aug 2014 07:51:16 -0400
Received: by mail-pa0-f50.google.com with SMTP id et14so1478996pad.23
        for <git@vger.kernel.org>; Thu, 14 Aug 2014 04:51:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:mime-version:content-type
         :content-transfer-encoding;
        bh=Tn9ipwQGz+1LADURbwWbPNLJzsr1QYBsEC/3wB0wXMA=;
        b=aBKARzrSbC7uF3zqJFtflxkfjkeaiQr++1SaM/r7T7fq6NvSL/fe/gstTvoY4kLftc
         UFpM7SuuRqFnY1YN2ysHwQicujtaw0kdWLNPasabIyXNjwvOlD0WV5nosjaxGxsTw2qd
         VqDDKk6X0clpnGGi6y+STO5OUFOZNADIxAZw8rQWGPtGe/Jcxeq8IKFZEfJ/ek6UyTO9
         5knMEg2M6jSidiCjEMaG3rblggpUQQfUnVAMwd+lSHegj6RVVfLYv+UEXY80t4Sb0TiS
         t0g40DD1VrCazhT0KJczL5u4gB2w20uGV6phHUZBVedwPN68yMLohlUxN1USp2igAzTZ
         tcfw==
X-Received: by 10.68.68.143 with SMTP id w15mr3913823pbt.134.1408017075645;
        Thu, 14 Aug 2014 04:51:15 -0700 (PDT)
Received: from lanh ([115.73.215.84])
        by mx.google.com with ESMTPSA id j1sm7443492pdh.31.2014.08.14.04.51.13
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 14 Aug 2014 04:51:15 -0700 (PDT)
Received: by lanh (sSMTP sendmail emulation); Thu, 14 Aug 2014 18:51:12 +0700
X-Mailer: git-send-email 2.1.0.rc0.78.gc0d8480
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/255262>

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 builtin/fetch.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/builtin/fetch.c b/builtin/fetch.c
index e8d0cca..9394194 100644
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
@@ -1198,7 +1196,8 @@ int cmd_fetch(int argc, const char **argv, const =
char *prefix)
 	list.strdup_strings =3D 1;
 	string_list_clear(&list, 0);
=20
-	run_command_v_opt(argv_gc_auto, RUN_GIT_CMD);
+	argv_array_pushl(&argv_gc_auto, "gc", "--auto", NULL);
+	run_command_v_opt(argv_gc_auto.argv, RUN_GIT_CMD);
=20
 	return result;
 }
--=20
2.1.0.rc0.78.gc0d8480
