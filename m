From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 02/19] diff-no-index: use diff_tree_setup_paths()
Date: Mon, 13 Dec 2010 16:46:39 +0700
Message-ID: <1292233616-27692-3-git-send-email-pclouds@gmail.com>
References: <1292233616-27692-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Dec 13 10:48:24 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PS516-0004Xi-FL
	for gcvg-git-2@lo.gmane.org; Mon, 13 Dec 2010 10:48:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751719Ab0LMJsJ convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 13 Dec 2010 04:48:09 -0500
Received: from mail-pv0-f174.google.com ([74.125.83.174]:40068 "EHLO
	mail-pv0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751671Ab0LMJsH (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 13 Dec 2010 04:48:07 -0500
Received: by pva4 with SMTP id 4so1079505pva.19
        for <git@vger.kernel.org>; Mon, 13 Dec 2010 01:48:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:from:to:cc:subject
         :date:message-id:x-mailer:in-reply-to:references:mime-version
         :content-type:content-transfer-encoding;
        bh=pWI5dX4Bnq4BVtCwvAivThOkqtbSABWJxKOtKavbE4Y=;
        b=IfUz/t6oKdSKugOAg/3syBMQJuB5ZBfSoujyiVML59XF4h61NESNo5sCvA1XKX3iy/
         1pjBKU/8jR7JcfwB45FKRqYBaM+a37HvDPP4z3ogy/z/SFUie8XDrN9SLZTQ2KPlpWzK
         csiCV7473qkiEYRQUx4ARu82i99n2Mrq9S5b8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        b=F2UZZo+bVTsyf5NpT6Kyx5j82rYXGUbFOg1KFNaOaNZAOUM4UIeMa19LZAyEnCGjff
         vGuMxzCNQsCJNCJAYCYxN0SmjPpUnilaWJ1HCMB77Hhvuwh6OMIZ/2Qtp0OPoJQA9hn/
         d9dx/GJ9KOCV+hzO8ky+nnXPvsDYEuQW8ggSs=
Received: by 10.142.211.19 with SMTP id j19mr3052944wfg.61.1292233685021;
        Mon, 13 Dec 2010 01:48:05 -0800 (PST)
Received: from pclouds@gmail.com ([115.73.222.178])
        by mx.google.com with ESMTPS id e14sm8675570wfg.20.2010.12.13.01.48.00
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Mon, 13 Dec 2010 01:48:03 -0800 (PST)
Received: by pclouds@gmail.com (sSMTP sendmail emulation); Mon, 13 Dec 2010 16:47:11 +0700
X-Mailer: git-send-email 1.7.3.3.476.g10a82
In-Reply-To: <1292233616-27692-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/163532>

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
