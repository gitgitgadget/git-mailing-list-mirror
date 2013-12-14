From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH v2 06/21] fast-import: use git_path() for accessing .git dir instead of get_git_dir()
Date: Sat, 14 Dec 2013 17:54:52 +0700
Message-ID: <1387018507-21999-7-git-send-email-pclouds@gmail.com>
References: <1386771333-32574-1-git-send-email-pclouds@gmail.com>
 <1387018507-21999-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jonathan Niedier <jrnieder@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Dec 14 11:51:54 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Vrmp6-0000wQ-HY
	for gcvg-git-2@plane.gmane.org; Sat, 14 Dec 2013 11:51:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753484Ab3LNKvr convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 14 Dec 2013 05:51:47 -0500
Received: from mail-pb0-f51.google.com ([209.85.160.51]:43931 "EHLO
	mail-pb0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753300Ab3LNKvq (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 14 Dec 2013 05:51:46 -0500
Received: by mail-pb0-f51.google.com with SMTP id up15so3610910pbc.38
        for <git@vger.kernel.org>; Sat, 14 Dec 2013 02:51:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=JM25FtYwzRRXKFb9rg/GJXY15dX0dG+nqFCrhqno/EE=;
        b=PEb4uONtRXantVPDvhhpmf0iT1HnVgQvDxI8vZA95d5KVTy58BccTcQyi0CKmyO+NC
         nVokkVZnGNF3AirQzupcob4CRwO1Y6SzHhL95e4AV5AzXohNrg7+Q7nnn2UusNR11Nog
         nhbfk5vy/dKHZaaL45JZ4xIp+qJdOrbZM4BWXsMRhk7pH2rQLEdDNF4LIMJle3AW5DvB
         th2NOPIjuhcPLU5CCtkvX7uKVV9hirN6o9HqqkJCJTBa+VEFYq0TvN7QYxqsa3MEvUis
         oHePNewuoHs48L3jIxXhNr036kRviDwXoTprGNnpb6HTIGjfjZ5kV+dueoFlr1deO+oB
         a4Tg==
X-Received: by 10.68.206.171 with SMTP id lp11mr8689810pbc.109.1387018306146;
        Sat, 14 Dec 2013 02:51:46 -0800 (PST)
Received: from lanh ([115.73.245.131])
        by mx.google.com with ESMTPSA id pl3sm11429426pbc.13.2013.12.14.02.51.42
        for <multiple recipients>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Sat, 14 Dec 2013 02:51:45 -0800 (PST)
Received: by lanh (sSMTP sendmail emulation); Sat, 14 Dec 2013 17:56:38 +0700
X-Mailer: git-send-email 1.8.5.1.77.g42c48fa
In-Reply-To: <1387018507-21999-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/239288>

This allows git_path() to redirect info/fast-import to another place
if needed

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 fast-import.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/fast-import.c b/fast-import.c
index f4d9969..04bba3d 100644
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
1.8.5.1.77.g42c48fa
