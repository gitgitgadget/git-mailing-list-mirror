From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 1/3] checkout: pass whole struct to parse_branchname_arg instead of individual flags
Date: Sat,  3 Jan 2015 16:41:25 +0700
Message-ID: <1420278087-14613-2-git-send-email-pclouds@gmail.com>
References: <1420278087-14613-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	Mark Levedahl <mlevedahl@gmail.com>,
	Max Kirillov <max@max630.net>,
	Jens Lehmann <Jens.Lehmann@web.de>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Jan 03 10:42:04 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Y7LDf-0001wX-UU
	for gcvg-git-2@plane.gmane.org; Sat, 03 Jan 2015 10:42:04 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750961AbbACJlw convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 3 Jan 2015 04:41:52 -0500
Received: from mail-pa0-f43.google.com ([209.85.220.43]:44437 "EHLO
	mail-pa0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750950AbbACJlv (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 3 Jan 2015 04:41:51 -0500
Received: by mail-pa0-f43.google.com with SMTP id kx10so25491263pab.30
        for <git@vger.kernel.org>; Sat, 03 Jan 2015 01:41:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=ShdlHqwKABgKSHdKcj32AnZHjVlq81Y88lmuhJYUbbM=;
        b=wUvA4jG81v0tztGDGnm86YqgILO1EuXWibnzKwHiy8hbia6tcfqIux/HlroeafbCp7
         UV9YUgdUjbMYwsJLgiZzxTWrBC5r21uJ7nzRQ+xd6i75xcd0GJ7S+GG7CFl97jmpzom2
         hKRXH5+0NmiTHfz2kPU5iC0mBnX/jm25x716XEshzImIpyr+kw+ZZD5bxBB0lQVNm+Lp
         G3tKgnIJu0DS+d3KnPoqklpLQhUcTJN1NED1itmk/QUDElGjDCxwOIg8HOy4uyMN7nHg
         UXKEnTrsGViQ4PwTZRX3GzpkPXsiN6ilC2ACTY+CWAleabYkU/RUkaglTuzJEBYBoqTa
         juNw==
X-Received: by 10.68.65.16 with SMTP id t16mr128695126pbs.70.1420278110586;
        Sat, 03 Jan 2015 01:41:50 -0800 (PST)
Received: from lanh ([115.73.231.124])
        by mx.google.com with ESMTPSA id qm7sm30042093pbc.46.2015.01.03.01.41.47
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 03 Jan 2015 01:41:50 -0800 (PST)
Received: by lanh (sSMTP sendmail emulation); Sat, 03 Jan 2015 16:41:51 +0700
X-Mailer: git-send-email 2.2.0.84.ge9c7a8a
In-Reply-To: <1420278087-14613-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/261992>

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 builtin/checkout.c | 13 ++++++-------
 1 file changed, 6 insertions(+), 7 deletions(-)

diff --git a/builtin/checkout.c b/builtin/checkout.c
index 953b763..d8717ef 100644
--- a/builtin/checkout.c
+++ b/builtin/checkout.c
@@ -1079,11 +1079,12 @@ static void check_linked_checkouts(struct branc=
h_info *new)
 static int parse_branchname_arg(int argc, const char **argv,
 				int dwim_new_local_branch_ok,
 				struct branch_info *new,
-				struct tree **source_tree,
-				unsigned char rev[20],
-				const char **new_branch,
-				int force_detach)
+				struct checkout_opts *opts,
+				unsigned char rev[20])
 {
+	struct tree **source_tree =3D &opts->source_tree;
+	const char **new_branch =3D &opts->new_branch;
+	int force_detach =3D opts->force_detach;
 	int argcount =3D 0;
 	unsigned char branch_rev[20];
 	const char *arg;
@@ -1420,9 +1421,7 @@ int cmd_checkout(int argc, const char **argv, con=
st char *prefix)
 			opts.track =3D=3D BRANCH_TRACK_UNSPECIFIED &&
 			!opts.new_branch;
 		int n =3D parse_branchname_arg(argc, argv, dwim_ok,
-					     &new, &opts.source_tree,
-					     rev, &opts.new_branch,
-					     opts.force_detach);
+					     &new, &opts, rev);
 		argv +=3D n;
 		argc -=3D n;
 	}
--=20
2.2.0.84.ge9c7a8a
