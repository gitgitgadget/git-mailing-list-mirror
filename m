From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 1/8] diff-no-index: use diff_tree_setup_paths()
Date: Thu,  9 Sep 2010 01:50:16 +1000
Message-ID: <1283961023-4491-2-git-send-email-pclouds@gmail.com>
References: <1283961023-4491-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org, Elijah Newren <newren@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Sep 09 05:22:57 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OtXiy-0000En-C8
	for gcvg-git-2@lo.gmane.org; Thu, 09 Sep 2010 05:22:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752863Ab0IIDWj convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 8 Sep 2010 23:22:39 -0400
Received: from mail-pw0-f46.google.com ([209.85.160.46]:47382 "EHLO
	mail-pw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752575Ab0IIDWi (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 8 Sep 2010 23:22:38 -0400
Received: by pwi3 with SMTP id 3so339297pwi.19
        for <git@vger.kernel.org>; Wed, 08 Sep 2010 20:22:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:from:to:cc:subject
         :date:message-id:x-mailer:in-reply-to:references:mime-version
         :content-type:content-transfer-encoding;
        bh=pzwUdJirsjUbBjA4ImdVIjD3FbS7ZzGtOUiwBdQaZas=;
        b=RCK2DU71ctArUtZencDanoWJdJa1ce7tMqMLp1u4cXCK0qNiB4Gls6frcVb5zGAtfl
         +k+O22nWM/701GUk2gnjhiuMyRLohiwDzuQWyrKoUrxJVSUrWIj0bjbNyKYbYon89lCx
         ipNi4WhQgVUTye8guSzc4+c1YQbmNClTZYdRs=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        b=kmCjLbCygU/GC4RGxETgLwvawIq9zM48xQ3beMo6Zo5buHlGabdBE2emoW43dyayad
         GpKX8XT/rVKB6OMDfKdpYVKMBkJbqlcVT3uW2f09QVWgIeUEXEam40do39qXdRqgyotC
         bd9eSjoSDB+AiTcEMfGrFwCjcsjC8Vkq6qQv0=
Received: by 10.142.133.11 with SMTP id g11mr424225wfd.156.1284002556941;
        Wed, 08 Sep 2010 20:22:36 -0700 (PDT)
Received: from dektop (dektec3.lnk.telstra.net [165.228.202.174])
        by mx.google.com with ESMTPS id 9sm828757wfd.0.2010.09.08.20.22.33
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 08 Sep 2010 20:22:36 -0700 (PDT)
Received: by dektop (sSMTP sendmail emulation); Thu,  9 Sep 2010 01:50:41 +1000
X-Mailer: git-send-email 1.7.1.rc1.70.g13aff
In-Reply-To: <1283961023-4491-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/155830>

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
1.7.1.rc1.70.g13aff
