From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH] add: don't complain when adding empty project root
Date: Mon, 23 Dec 2013 16:02:41 +0700
Message-ID: <1387789361-29036-1-git-send-email-pclouds@gmail.com>
References: <CAEcj5uWHpem+5os+3Mc_a42pk6f30i4UiV=LRPdXkoqiy1jQ_w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>, tfnico@gmail.com,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Dec 23 10:06:32 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Vv1T5-0007pU-79
	for gcvg-git-2@plane.gmane.org; Mon, 23 Dec 2013 10:06:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757191Ab3LWJGX convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 23 Dec 2013 04:06:23 -0500
Received: from mail-pa0-f45.google.com ([209.85.220.45]:35065 "EHLO
	mail-pa0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757113Ab3LWJGV (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 23 Dec 2013 04:06:21 -0500
Received: by mail-pa0-f45.google.com with SMTP id fb1so5110571pad.32
        for <git@vger.kernel.org>; Mon, 23 Dec 2013 01:06:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=DzGKhdI/lDTxKpqePj7cMOu/oee+XxZN6zAGWvdY2N0=;
        b=YWr4VbxmJlRcIIaOM8rraTzXJ9xIW5PCaDp6YutGuLutnH/roc6LSx/Dqow/5xHIBV
         iB1uTYfACucL7KLTw+RQgGV3y2wX6usV2PHVm2Yvvo1Dx6/a8oWdrNkW7JT/xcFVxLcn
         wWzDfpAAP9xDAZamEXXjF1d21dx4CjLJbCG/BMNwZ4KElzLoIWqH1ItODeS4DyJEKZEX
         DOidF4TVP26r7YblfKo58gDRoGl0EjkTvNedSHComZkrZBzVnkdZLEDvKUZTOwx6+Ca0
         e88Sf1rgADLyU6UYY8j4kYQiBW3U8LyIsUeDjSLgnkRn/7YTYaaPTovquFrkev5xDIJY
         Bp0Q==
X-Received: by 10.66.8.66 with SMTP id p2mr24327066paa.129.1387789580789;
        Mon, 23 Dec 2013 01:06:20 -0800 (PST)
Received: from lanh ([115.73.238.111])
        by mx.google.com with ESMTPSA id yg3sm42860058pab.16.2013.12.23.01.06.16
        for <multiple recipients>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Mon, 23 Dec 2013 01:06:19 -0800 (PST)
Received: by lanh (sSMTP sendmail emulation); Mon, 23 Dec 2013 16:06:16 +0700
X-Mailer: git-send-email 1.8.5.2.240.g8478abd
In-Reply-To: <CAEcj5uWHpem+5os+3Mc_a42pk6f30i4UiV=LRPdXkoqiy1jQ_w@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/239651>

This behavior was added in 07d7bed (add: don't complain when adding
empty project root - 2009-04-28) then broken by 84b8b5d (remove
match_pathspec() in favor of match_pathspec_depth() -
2013-07-14). Reinstate it.

Noticed-by: Thomas Ferris Nicolaisen <tfnico@gmail.com>
Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 builtin/add.c  | 2 +-
 t/t3700-add.sh | 4 ++++
 2 files changed, 5 insertions(+), 1 deletion(-)

diff --git a/builtin/add.c b/builtin/add.c
index 226f758..fbd3f3a 100644
--- a/builtin/add.c
+++ b/builtin/add.c
@@ -544,7 +544,7 @@ int cmd_add(int argc, const char **argv, const char=
 *prefix)
=20
 		for (i =3D 0; i < pathspec.nr; i++) {
 			const char *path =3D pathspec.items[i].match;
-			if (!seen[i] &&
+			if (!seen[i] && pathspec.items[i].match[0] &&
 			    ((pathspec.items[i].magic &
 			      (PATHSPEC_GLOB | PATHSPEC_ICASE)) ||
 			     !file_exists(path))) {
diff --git a/t/t3700-add.sh b/t/t3700-add.sh
index aab86e8..1535d8f 100755
--- a/t/t3700-add.sh
+++ b/t/t3700-add.sh
@@ -307,4 +307,8 @@ test_expect_success 'git add --dry-run --ignore-mis=
sing of non-existing file out
 	test_i18ncmp expect.err actual.err
 '
=20
+test_expect_success 'git add -A on empty repo does not error out' '
+	git init empty && ( cd empty && git add -A . )
+'
+
 test_done
--=20
1.8.5.2.240.g8478abd
