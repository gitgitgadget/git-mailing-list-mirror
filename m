From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 02/21] diff-no-index: use diff_tree_setup_paths()
Date: Wed, 15 Dec 2010 22:02:37 +0700
Message-ID: <1292425376-14550-3-git-send-email-pclouds@gmail.com>
References: <1292425376-14550-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Dec 15 16:10:28 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PSszq-0003mL-Tg
	for gcvg-git-2@lo.gmane.org; Wed, 15 Dec 2010 16:10:27 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754848Ab0LOPKU convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 15 Dec 2010 10:10:20 -0500
Received: from mail-iw0-f180.google.com ([209.85.214.180]:40783 "EHLO
	mail-iw0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754501Ab0LOPKT (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 15 Dec 2010 10:10:19 -0500
X-Greylist: delayed 372 seconds by postgrey-1.27 at vger.kernel.org; Wed, 15 Dec 2010 10:10:19 EST
Received: by iwn37 with SMTP id 37so2327113iwn.11
        for <git@vger.kernel.org>; Wed, 15 Dec 2010 07:10:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:from:to:cc:subject
         :date:message-id:x-mailer:in-reply-to:references:mime-version
         :content-type:content-transfer-encoding;
        bh=pWI5dX4Bnq4BVtCwvAivThOkqtbSABWJxKOtKavbE4Y=;
        b=P0VyCbUPtaV9Q/K4bA8sJOrDuzTS4kuTeZqZ8btquLEGxnSNFvRLnO4qwaOK1ID7l2
         4ILRN4GvO4Z7eWTGw9IBkaG5HqBAjHu2DoQImbDJj9XYlr1xMoyf/VXjrfCeYqBNEih4
         JvgsplMMb3tHvi0haYmfq6q2gJejW04wXdtrA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        b=ivUSNUWVZckpWxCsn1wug6a8rHXkAltTqruofMB/ktmyWKAn+SX9FFg/tZ3xuY3YDz
         aMoXS3MwuVSlR/YdZdQzTIzNIg74mojpuav3HamLLoMs+MMR9FdQOtI/QwT0cu+WCmhN
         f2uyNxkzYQmR6pD+te0rnQ8Ho6yanlOhOCG9U=
Received: by 10.231.34.205 with SMTP id m13mr4451369ibd.184.1292425447013;
        Wed, 15 Dec 2010 07:04:07 -0800 (PST)
Received: from pclouds@gmail.com ([115.73.209.213])
        by mx.google.com with ESMTPS id i16sm1037203ibl.18.2010.12.15.07.04.03
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 15 Dec 2010 07:04:05 -0800 (PST)
Received: by pclouds@gmail.com (sSMTP sendmail emulation); Wed, 15 Dec 2010 22:03:14 +0700
X-Mailer: git-send-email 1.7.3.3.476.g10a82
In-Reply-To: <1292425376-14550-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/163777>

diff_options.{paths,nr_paths} will be removed later. Do not
modify them directly.

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 diff-no-index.c |    9 +++++----
 1 files changed, 5 insertions(+), 4 deletions(-)

diff --git a/diff-no-index.c b/diff-no-index.c
index ce9e783..e48ab92 100644
--- a/diff-no-index.c
+++ b/diff-no-index.c
@@ -231,8 +231,9 @@ void diff_no_index(struct rev_info *revs,
=20
 	if (prefix) {
 		int len =3D strlen(prefix);
+		const char *paths[3];
+		memset(paths, 0, sizeof(paths));
=20
-		revs->diffopt.paths =3D xcalloc(2, sizeof(char *));
 		for (i =3D 0; i < 2; i++) {
 			const char *p =3D argv[argc - 2 + i];
 			/*
@@ -242,12 +243,12 @@ void diff_no_index(struct rev_info *revs,
 			p =3D (strcmp(p, "-")
 			     ? xstrdup(prefix_filename(prefix, len, p))
 			     : p);
-			revs->diffopt.paths[i] =3D p;
+			paths[i] =3D p;
 		}
+		diff_tree_setup_paths(paths, &revs->diffopt);
 	}
 	else
-		revs->diffopt.paths =3D argv + argc - 2;
-	revs->diffopt.nr_paths =3D 2;
+		diff_tree_setup_paths(argv + argc - 2, &revs->diffopt);
 	revs->diffopt.skip_stat_unmatch =3D 1;
 	if (!revs->diffopt.output_format)
 		revs->diffopt.output_format =3D DIFF_FORMAT_PATCH;
--=20
1.7.3.3.476.g10a82
