From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH v4 08/27] fast-import: use git_path() for accessing .git dir instead of get_git_dir()
Date: Sat,  1 Mar 2014 19:12:44 +0700
Message-ID: <1393675983-3232-9-git-send-email-pclouds@gmail.com>
References: <1392730814-19656-1-git-send-email-pclouds@gmail.com>
 <1393675983-3232-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Mar 01 13:21:44 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WJivI-0001vT-D0
	for gcvg-git-2@plane.gmane.org; Sat, 01 Mar 2014 13:21:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752749AbaCAMVj convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 1 Mar 2014 07:21:39 -0500
Received: from mail-pd0-f179.google.com ([209.85.192.179]:57893 "EHLO
	mail-pd0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752429AbaCAMVj (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 1 Mar 2014 07:21:39 -0500
Received: by mail-pd0-f179.google.com with SMTP id w10so1869052pde.38
        for <git@vger.kernel.org>; Sat, 01 Mar 2014 04:21:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=VaK2CwjgosiiLernzjvs8zR/7WmllhbjYHDZQIo/ws8=;
        b=GrLUprmr5gpTjSying1Iy4F2Vsvq+r589XYS6kWthzc8oBPI2BC4p+FOgBVXVdWCm6
         ORZDRTmGX8HvBY5/lFyssmUb+fuSKqVcFh+tw/XP+bVMiyQmrqcUi8O60K0yjNYmnB8a
         Z6W+IoHEzMquUTnSZPPCZwl41op81ImSirEEpTMavVPkmfPDHlzUn+G63PxEXWRmGoqW
         NKXYTkrUioeNaoMawkSjjsgO9y8DY9Tqcoxd9ZKddx6ursa2TDRAS4xTEH+TFsDoqR7F
         R6/ZL2Zz33YBsVRksP31PDxCKHStkZInn9tmrDgDLslF9OyVOMSYY5C0m3RZ1Lyqywy8
         UWPQ==
X-Received: by 10.66.220.198 with SMTP id py6mr9212773pac.21.1393676498605;
        Sat, 01 Mar 2014 04:21:38 -0800 (PST)
Received: from lanh ([115.73.238.45])
        by mx.google.com with ESMTPSA id sx8sm37171105pab.5.2014.03.01.04.21.35
        for <multiple recipients>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Sat, 01 Mar 2014 04:21:37 -0800 (PST)
Received: by lanh (sSMTP sendmail emulation); Sat, 01 Mar 2014 19:22:04 +0700
X-Mailer: git-send-email 1.9.0.40.gaa8c3ea
In-Reply-To: <1393675983-3232-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/243073>

This allows git_path() to redirect info/fast-import to another place
if needed

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 fast-import.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/fast-import.c b/fast-import.c
index 4fd18a3..08a1e78 100644
--- a/fast-import.c
+++ b/fast-import.c
@@ -3125,12 +3125,9 @@ static void parse_progress(void)
=20
 static char* make_fast_import_path(const char *path)
 {
-	struct strbuf abs_path =3D STRBUF_INIT;
-
 	if (!relative_marks_paths || is_absolute_path(path))
 		return xstrdup(path);
-	strbuf_addf(&abs_path, "%s/info/fast-import/%s", get_git_dir(), path)=
;
-	return strbuf_detach(&abs_path, NULL);
+	return xstrdup(git_path("info/fast-import/%s", path));
 }
=20
 static void option_import_marks(const char *marks,
--=20
1.9.0.40.gaa8c3ea
