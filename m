From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH v3 15/23] untracked cache: print stats with $GIT_TRACE_UNTRACKED_STATS
Date: Mon,  8 Dec 2014 21:04:59 +0700
Message-ID: <1418047507-22892-17-git-send-email-pclouds@gmail.com>
References: <1418047507-22892-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Dec 08 14:56:13 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XxynJ-0004wt-TL
	for gcvg-git-2@plane.gmane.org; Mon, 08 Dec 2014 14:56:10 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755516AbaLHN4F convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 8 Dec 2014 08:56:05 -0500
Received: from mail-pd0-f170.google.com ([209.85.192.170]:38511 "EHLO
	mail-pd0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754376AbaLHN4E (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 8 Dec 2014 08:56:04 -0500
Received: by mail-pd0-f170.google.com with SMTP id v10so5190431pde.15
        for <git@vger.kernel.org>; Mon, 08 Dec 2014 05:56:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=T3/z93URxQ9rpuvkSL8MZMpTfNmFJ+QjKVBEP6X0qPA=;
        b=Wftp1TdAWNSjyPuzc8Xs7Y87YeRg0XKEbdI2njn2DXtQXseB4u96HM+/d22usmfgBT
         2JygTFhytJY6FrDCoRNl46Wy060TXRiAH90c3WhreVQYIaYvGS/nfuUeVSd+4ITjpghJ
         ZH85Q9oEi8IGxp60QopbhY7XJ1O32FPUaCdQzzMxx14hebzL3y4EdSKobkeQRAe7+Brj
         qBt6tKUr0Vg1AY2/ZiH1B9Plwn+GMKmj9MbyYTu3fSy5Y/DBoVpTKeYUbu+iXLrwnmZ1
         4sNwWFDc5vaM9SfD6lJ4RKJtq3xIEcWVzcy2mvNUBfMUKcojTi1hUAeSPse8CEg+N9Wa
         f6KA==
X-Received: by 10.69.14.33 with SMTP id fd1mr61545080pbd.90.1418046962894;
        Mon, 08 Dec 2014 05:56:02 -0800 (PST)
Received: from lanh ([115.73.205.130])
        by mx.google.com with ESMTPSA id ny10sm12355693pdb.21.2014.12.08.05.56.00
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 08 Dec 2014 05:56:02 -0800 (PST)
Received: by lanh (sSMTP sendmail emulation); Mon, 08 Dec 2014 21:06:38 +0700
X-Mailer: git-send-email 2.2.0.60.gb7b3c64
In-Reply-To: <1418047507-22892-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/261033>

This could be used to verify correct behavior in tests

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 dir.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/dir.c b/dir.c
index 7fa372e..14dbd7a 100644
--- a/dir.c
+++ b/dir.c
@@ -1922,6 +1922,18 @@ int read_directory(struct dir_struct *dir, const=
 char *path, int len, const stru
 	free_simplify(simplify);
 	qsort(dir->entries, dir->nr, sizeof(struct dir_entry *), cmp_name);
 	qsort(dir->ignored, dir->ignored_nr, sizeof(struct dir_entry *), cmp_=
name);
+	if (dir->untracked) {
+		static struct trace_key trace_untracked_stats =3D TRACE_KEY_INIT(UNT=
RACKED_STATS);
+		trace_printf_key(&trace_untracked_stats,
+				 "node creation: %u\n"
+				 "gitignore invalidation: %u\n"
+				 "directory invalidation: %u\n"
+				 "opendir: %u\n",
+				 dir->untracked->dir_created,
+				 dir->untracked->gitignore_invalidated,
+				 dir->untracked->dir_invalidated,
+				 dir->untracked->dir_opened);
+	}
 	return dir->nr;
 }
=20
--=20
2.2.0.60.gb7b3c64
