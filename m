From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH] setup: update the right file in multiple checkouts
Date: Tue, 25 Aug 2015 17:30:46 +0700
Message-ID: <1440498646-25663-1-git-send-email-pclouds@gmail.com>
References: <CACsJy8A2sUEcaY2JryTHj3hvES-VDJt_eMgogP5WjVA3FiXDsg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Aug 25 12:30:59 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZUBVF-00066z-Q4
	for gcvg-git-2@plane.gmane.org; Tue, 25 Aug 2015 12:30:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755145AbbHYKat convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 25 Aug 2015 06:30:49 -0400
Received: from mail-pa0-f54.google.com ([209.85.220.54]:33990 "EHLO
	mail-pa0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755134AbbHYKat (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 25 Aug 2015 06:30:49 -0400
Received: by pabzx8 with SMTP id zx8so29888607pab.1
        for <git@vger.kernel.org>; Tue, 25 Aug 2015 03:30:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=jeNpFd2Y0TWe29I7zg0N0dsbEMREo03ifQhT6tiyoMQ=;
        b=m071QliZrf5sZA6bv6/KMn4266mM6R6wFUITCtiBrAx/lOgW29jmK53stib7X06nYG
         WmAXIVfg14ItRXP4HpZIwIh4Ff8bLsWhBmscREvZqb1doTOxD7aVTpCUaRCHi9+hWv9v
         WgVxbSqIwF49II1FTPvwuSaU991A394FNNlWD7lqcv3H3Ke3pP5C4A8VFtfOOPDFjJia
         Sk0duVFBrC9vMzxOcZDVRHquLRDuwVytd/aC84In6OBKzJG76WvqzfSJ5gsQoBH6YN1g
         aIPwWjffNwAxnumZ01XGJW1z0/q3tTAFNARZse6Az1fetWXtVmzRtHGANgX8fLOwSFKN
         afGw==
X-Received: by 10.66.148.6 with SMTP id to6mr54710012pab.132.1440498648715;
        Tue, 25 Aug 2015 03:30:48 -0700 (PDT)
Received: from lanh ([171.232.84.126])
        by smtp.gmail.com with ESMTPSA id v2sm20536660pda.34.2015.08.25.03.30.45
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 25 Aug 2015 03:30:47 -0700 (PDT)
Received: by lanh (sSMTP sendmail emulation); Tue, 25 Aug 2015 17:30:48 +0700
X-Mailer: git-send-email 2.3.0.rc1.137.g477eb31
In-Reply-To: <CACsJy8A2sUEcaY2JryTHj3hvES-VDJt_eMgogP5WjVA3FiXDsg@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/276515>

This code is introduced in 23af91d (prune: strategies for linked
checkouts - 2014-11-30), and it's supposed to implement this rule from
that commit's message:

 - linked checkouts are supposed to keep its location in $R/gitdir up
   to date. The use case is auto fixup after a manual checkout move.

Note the name, "$R/gitdir", not "$R/gitfile". Correct the path to be
updated accordingly.

While at there, make sure I/O errors are not silently dropped.

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 The code was right in v2 [1] and became "gitfile" since v3 [2]. I
 need to reconsider my code quality after this :(

 [1] http://article.gmane.org/gmane.comp.version-control.git/239299
 [2] http://article.gmane.org/gmane.comp.version-control.git/242325

 setup.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/setup.c b/setup.c
index 5f9f07d..64bf2b4 100644
--- a/setup.c
+++ b/setup.c
@@ -402,9 +402,9 @@ static void update_linked_gitdir(const char *gitfil=
e, const char *gitdir)
 	struct strbuf path =3D STRBUF_INIT;
 	struct stat st;
=20
-	strbuf_addf(&path, "%s/gitfile", gitdir);
+	strbuf_addf(&path, "%s/gitdir", gitdir);
 	if (stat(path.buf, &st) || st.st_mtime + 24 * 3600 < time(NULL))
-		write_file(path.buf, 0, "%s\n", gitfile);
+		write_file(path.buf, 1, "%s\n", gitfile);
 	strbuf_release(&path);
 }
=20
--=20
2.3.0.rc1.137.g477eb31
