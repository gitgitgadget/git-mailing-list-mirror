From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH v6 11/32] fast-import: use git_path() for accessing .git dir instead of get_git_dir()
Date: Wed,  9 Jul 2014 14:32:56 +0700
Message-ID: <1404891197-18067-12-git-send-email-pclouds@gmail.com>
References: <1404891197-18067-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jul 09 09:34:32 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1X4mOc-0003T5-TV
	for gcvg-git-2@plane.gmane.org; Wed, 09 Jul 2014 09:34:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753660AbaGIHe1 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 9 Jul 2014 03:34:27 -0400
Received: from mail-pa0-f51.google.com ([209.85.220.51]:63105 "EHLO
	mail-pa0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752020AbaGIHe0 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 9 Jul 2014 03:34:26 -0400
Received: by mail-pa0-f51.google.com with SMTP id hz1so8681580pad.24
        for <git@vger.kernel.org>; Wed, 09 Jul 2014 00:34:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=GK3/geaPB8k3SUXm8xBLyMTLLnwwZoMxhoG0n9jdeOI=;
        b=oE11J6IN0mXL79o5MIs9BlgMfoe/qs18cOg61+YcG7MtZu9tfIOvX3ZIk/BUvJs6y/
         HCqsuRYWQCr5EWQex7ijL+uNS4M6r0C4fva6u2TiTunBvpxc/edI33lTIP3Z1AmBZXEE
         JJCznY4Ns3yPgK3fHq/LqfTCIPRjUTsQjkV3uelpGZj1qysdu1I5Ou/DLhztPgMxO1nq
         AkGa3EdR2NR/64utuHASxodAkdvvwMX447VSZk2DT1nMh6IjK5OHz2SLpm+3tDBTc3ec
         c3erIl/IIA0ihARVeoShrUK7knWSwS6jqnjrsH8TwBGbva5OrTozeJcKyhAiA5J3ruOL
         /RGA==
X-Received: by 10.70.21.201 with SMTP id x9mr9646249pde.7.1404891266100;
        Wed, 09 Jul 2014 00:34:26 -0700 (PDT)
Received: from lanh ([115.73.209.165])
        by mx.google.com with ESMTPSA id fs3sm80298814pac.44.2014.07.09.00.34.23
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 09 Jul 2014 00:34:25 -0700 (PDT)
Received: by lanh (sSMTP sendmail emulation); Wed, 09 Jul 2014 14:34:23 +0700
X-Mailer: git-send-email 1.9.1.346.ga2b5940
In-Reply-To: <1404891197-18067-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/253086>

This allows git_path() to redirect info/fast-import to another place
if needed

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 fast-import.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/fast-import.c b/fast-import.c
index c74ea15..e8ec34d 100644
--- a/fast-import.c
+++ b/fast-import.c
@@ -3123,12 +3123,9 @@ static void parse_progress(void)
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
1.9.1.346.ga2b5940
