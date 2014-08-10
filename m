From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH v2 4/8] mv: remove an "if" that's always true
Date: Sun, 10 Aug 2014 09:29:32 +0700
Message-ID: <1407637776-19794-5-git-send-email-pclouds@gmail.com>
References: <1407637776-19794-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Aug 10 04:30:11 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XGIte-0003gR-Op
	for gcvg-git-2@plane.gmane.org; Sun, 10 Aug 2014 04:30:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752091AbaHJCaE convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 9 Aug 2014 22:30:04 -0400
Received: from mail-pa0-f44.google.com ([209.85.220.44]:62996 "EHLO
	mail-pa0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751631AbaHJCaD (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 9 Aug 2014 22:30:03 -0400
Received: by mail-pa0-f44.google.com with SMTP id eu11so9267555pac.31
        for <git@vger.kernel.org>; Sat, 09 Aug 2014 19:30:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=ckOgGhyrHYN6OWhV8BRIADqachpQ+Q6RWeVHhQgBr3o=;
        b=qJtENloImw4jyxK83g0VszL5r7cB3qiIPwiPZknSqKvWSdmdIxDJQBHvfZA82u6v66
         CmN/T7d6KbscFgzERjfaB/4Hj6gRyNAfHYhm9Yfe8TiqPAxQVgTnYr75vzF57IhvWi2i
         ely0+E9K8kbMFoLOHnXb3oASb6Bb5f5Eizhb4V4FrYu6fwo5dmRx9NqxpHVOVUFrQxax
         Pfg834Wt2izeu54YLazW2pHamWfTpRBir6FplmRA2wbUOzcPXvlojirQklL94mVxERQW
         6jd5ikNIifpNBPwc9dP3Xbj/KqPPJy7kY5rPT6sCz5nhjfMToB9iIY8RxmpP514OAThm
         AICA==
X-Received: by 10.70.38.72 with SMTP id e8mr19832834pdk.33.1407637803109;
        Sat, 09 Aug 2014 19:30:03 -0700 (PDT)
Received: from lanh ([115.73.228.225])
        by mx.google.com with ESMTPSA id l3sm7243359pbq.8.2014.08.09.19.30.00
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 09 Aug 2014 19:30:02 -0700 (PDT)
Received: by lanh (sSMTP sendmail emulation); Sun, 10 Aug 2014 09:30:06 +0700
X-Mailer: git-send-email 2.1.0.rc0.78.gc0d8480
In-Reply-To: <1407637776-19794-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/255080>

This is inside an "else" block of "if (last - first < 1)", so we know
that "last - first >=3D 1" when we come here. No need to check
"last - first > 0".

While at there, save "argc + last - first" to a variable to shorten
the statements a bit.

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 builtin/mv.c | 22 +++++++---------------
 1 file changed, 7 insertions(+), 15 deletions(-)

diff --git a/builtin/mv.c b/builtin/mv.c
index 524f4e5..0732355 100644
--- a/builtin/mv.c
+++ b/builtin/mv.c
@@ -175,22 +175,14 @@ int cmd_mv(int argc, const char **argv, const cha=
r *prefix)
 				if (last - first < 1)
 					bad =3D _("source directory is empty");
 				else {
-					int j, dst_len;
+					int j, dst_len, n;
=20
-					if (last - first > 0) {
-						source =3D xrealloc(source,
-								(argc + last - first)
-								* sizeof(char *));
-						destination =3D xrealloc(destination,
-								(argc + last - first)
-								* sizeof(char *));
-						modes =3D xrealloc(modes,
-								(argc + last - first)
-								* sizeof(enum update_mode));
-						submodule_gitfile =3D xrealloc(submodule_gitfile,
-								(argc + last - first)
-								* sizeof(char *));
-					}
+					n =3D argc + last - first;
+					source =3D xrealloc(source, n * sizeof(char *));
+					destination =3D xrealloc(destination, n * sizeof(char *));
+					modes =3D xrealloc(modes, n * sizeof(enum update_mode));
+					submodule_gitfile =3D
+						xrealloc(submodule_gitfile, n * sizeof(char *));
=20
 					dst =3D add_slash(dst);
 					dst_len =3D strlen(dst);
--=20
2.1.0.rc0.78.gc0d8480
