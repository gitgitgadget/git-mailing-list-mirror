From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH v3 2/4] branch: reject -D/-d without branch name
Date: Mon, 28 Jan 2013 08:18:14 +0700
Message-ID: <1359335896-24406-2-git-send-email-pclouds@gmail.com>
References: <1359118225-14356-1-git-send-email-pclouds@gmail.com>
 <1359335896-24406-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Jonathan Nieder <jrnieder@gmail.com>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jan 28 02:19:43 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TzdNt-0008TD-Tr
	for gcvg-git-2@plane.gmane.org; Mon, 28 Jan 2013 02:19:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757200Ab3A1BTA convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 27 Jan 2013 20:19:00 -0500
Received: from mail-pb0-f47.google.com ([209.85.160.47]:61446 "EHLO
	mail-pb0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757163Ab3A1BS5 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 27 Jan 2013 20:18:57 -0500
Received: by mail-pb0-f47.google.com with SMTP id rp8so381439pbb.20
        for <git@vger.kernel.org>; Sun, 27 Jan 2013 17:18:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:from:to:cc:subject:date:message-id:x-mailer:in-reply-to
         :references:mime-version:content-type:content-transfer-encoding;
        bh=SQWjF2QWybqyXTzOTS7VtRIkixlPg9dwCkUVLsNq6RY=;
        b=UstVkrniVNgAIHFNjD0eBHkY7PHIu7io3fufzpDYhrwRQHR0WeW6HrIHgddOGm6LZm
         sLZjSdPFCIrz4kxqvbSJu7kkN2J9/rI2tXPUys051LUe6qXRskk8hPHQ5atCAvLlMPdQ
         cFLP/5HT3OJjcP2XlyCRKMhk2eALB8wwruCM3RkQHf6xTY84cYFEL99SuQBg9kXfJ5gK
         M86ekIsopyQ+GF6+b6Jes9LOK8TSHgQl332N6Ztld+7CkHxenAjOlb0huLP7Ddc2+6tr
         Vyg+PO+5eLvUHAunUPQKVkIIord/TOkbTAYzeF54523JS1LV7sUSRttjVpOVoh0ug96F
         dQ8g==
X-Received: by 10.66.72.225 with SMTP id g1mr31962588pav.79.1359335937032;
        Sun, 27 Jan 2013 17:18:57 -0800 (PST)
Received: from pclouds@gmail.com ([113.161.77.29])
        by mx.google.com with ESMTPS id ql9sm5209532pbc.61.2013.01.27.17.18.53
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Sun, 27 Jan 2013 17:18:56 -0800 (PST)
Received: by pclouds@gmail.com (sSMTP sendmail emulation); Mon, 28 Jan 2013 08:18:31 +0700
X-Mailer: git-send-email 1.8.1.1.459.g5970e58
In-Reply-To: <1359335896-24406-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/214779>


Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 builtin/branch.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/builtin/branch.c b/builtin/branch.c
index ea6498b..30c4545 100644
--- a/builtin/branch.c
+++ b/builtin/branch.c
@@ -837,9 +837,11 @@ int cmd_branch(int argc, const char **argv, const =
char *prefix)
 		colopts =3D 0;
 	}
=20
-	if (delete)
+	if (delete) {
+		if (!argc)
+			die(_("branch name required"));
 		return delete_branches(argc, argv, delete > 1, kinds, quiet);
-	else if (list) {
+	} else if (list) {
 		int ret =3D print_ref_list(kinds, detached, verbose, abbrev,
 					 with_commit, argv);
 		print_columns(&output, colopts, NULL);
--=20
1.8.1.1.459.g5970e58
