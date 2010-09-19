From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 2/6] diff-no-index: use diff_tree_setup_paths()
Date: Mon, 20 Sep 2010 09:21:50 +1000
Message-ID: <1284938514-16663-3-git-send-email-pclouds@gmail.com>
References: <1284938514-16663-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Elijah Newren <newren@gmail.com>
X-From: git-owner@vger.kernel.org Mon Sep 20 01:22:57 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OxTDl-0007qb-0T
	for gcvg-git-2@lo.gmane.org; Mon, 20 Sep 2010 01:22:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755009Ab0ISXWZ convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 19 Sep 2010 19:22:25 -0400
Received: from mail-pw0-f46.google.com ([209.85.160.46]:36504 "EHLO
	mail-pw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754035Ab0ISXWR (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 19 Sep 2010 19:22:17 -0400
Received: by pwi3 with SMTP id 3so1084991pwi.19
        for <git@vger.kernel.org>; Sun, 19 Sep 2010 16:22:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:from:to:cc:subject
         :date:message-id:x-mailer:in-reply-to:references:mime-version
         :content-type:content-transfer-encoding;
        bh=WvrY/+970G2bakEd3we5MjBNSe5I0GuABuJOI2VYPfE=;
        b=K9wz4xqRH2XfoqoR7RkN4frFn6+NcgbHQ9xEU93YHDj5gPUfRoBOmP6EAiO+w53Fwk
         mYlpCt8M2SlVEnn0wjSCG1ErOfEQA7SKxWAXc9deM5Mar1WkNFLeqGaV8mgpA9JAu9nL
         w8w/sCWZmid+eLR36gGIOxX0LtfpjBAFX0P2w=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        b=HkvtInmvCpUvaduIksfS2XiqfXMZFPvyPArEt3mTjlbVkWl0oUeF3O8LhioR+i1JXy
         jc+Mb4pPqIxxM4XOeBF87BavHIfrZVC1G6nlY28m/tr61LY180DWXe+Rji4qLYKT9KW4
         uDcuQShKQU07GR5SfCROZPpM+3uY3Otu5z984=
Received: by 10.142.245.9 with SMTP id s9mr6928333wfh.210.1284938535036;
        Sun, 19 Sep 2010 16:22:15 -0700 (PDT)
Received: from dektop (dektec3.lnk.telstra.net [165.228.202.174])
        by mx.google.com with ESMTPS id l42sm4865015wfa.9.2010.09.19.16.22.11
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sun, 19 Sep 2010 16:22:13 -0700 (PDT)
Received: by dektop (sSMTP sendmail emulation); Mon, 20 Sep 2010 09:22:08 +1000
X-Mailer: git-send-email 1.7.1.rc1.70.g788ca
In-Reply-To: <1284938514-16663-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/156524>

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
1.7.1.rc1.70.g788ca
