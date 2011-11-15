From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 04/10] commit: move resolve_ref() closer to where the return value is used
Date: Tue, 15 Nov 2011 13:07:50 +0700
Message-ID: <1321337276-17803-4-git-send-email-pclouds@gmail.com>
References: <20111115060603.GA17585@tre>
 <1321337276-17803-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue Nov 15 07:06:17 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RQC9v-0005p2-WD
	for gcvg-git-2@lo.gmane.org; Tue, 15 Nov 2011 07:06:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752335Ab1KOGFf convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 15 Nov 2011 01:05:35 -0500
Received: from mail-gx0-f174.google.com ([209.85.161.174]:64839 "EHLO
	mail-gx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752314Ab1KOGFe (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 15 Nov 2011 01:05:34 -0500
Received: by ggnb2 with SMTP id b2so7055058ggn.19
        for <git@vger.kernel.org>; Mon, 14 Nov 2011 22:05:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=g+at8HGptVSGLd26ZVg+EIeO4pKEHhlOV82ll+XBPFs=;
        b=um2H72ip/NHRMr2mgVyYUOHdfUs6sFhG4TF2uTA7UG8eFa56kp9FcM17gyFbPbtOcx
         ROVr0bc1Bp0Gfztzi66hrLVMPeXEfKmb0zCpzG3s+5O9LoieYtdvl8jN/Hwj7T8iIpFZ
         M6/QsKbXuZR9UxT9vDdAzr0/FzowAtwO7AXrE=
Received: by 10.68.208.225 with SMTP id mh1mr57613878pbc.17.1321337132907;
        Mon, 14 Nov 2011 22:05:32 -0800 (PST)
Received: from tre ([115.74.43.88])
        by mx.google.com with ESMTPS id p6sm62443097pbf.3.2011.11.14.22.05.29
        (version=TLSv1/SSLv3 cipher=OTHER);
        Mon, 14 Nov 2011 22:05:32 -0800 (PST)
Received: by tre (sSMTP sendmail emulation); Tue, 15 Nov 2011 13:08:17 +0700
X-Mailer: git-send-email 1.7.4.74.g639db
In-Reply-To: <1321337276-17803-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/185426>

resolve_ref() returns a static buffer and the value may change if
another resolve_ref() is called. Move resolve_ref() closer to printf()
where the value is used to reduce that chance.

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 builtin/commit.c |    3 ++-
 1 files changed, 2 insertions(+), 1 deletions(-)

diff --git a/builtin/commit.c b/builtin/commit.c
index 11ae005..365b9f6 100644
--- a/builtin/commit.c
+++ b/builtin/commit.c
@@ -1259,7 +1259,7 @@ static void print_summary(const char *prefix, con=
st unsigned char *sha1,
 	struct commit *commit;
 	struct strbuf format =3D STRBUF_INIT;
 	unsigned char junk_sha1[20];
-	const char *head =3D resolve_ref("HEAD", junk_sha1, 0, NULL, 0);
+	const char *head;
 	struct pretty_print_context pctx =3D {0};
 	struct strbuf author_ident =3D STRBUF_INIT;
 	struct strbuf committer_ident =3D STRBUF_INIT;
@@ -1304,6 +1304,7 @@ static void print_summary(const char *prefix, con=
st unsigned char *sha1,
 	rev.diffopt.break_opt =3D 0;
 	diff_setup_done(&rev.diffopt);
=20
+	head =3D resolve_ref("HEAD", junk_sha1, 0, NULL, 0);
 	printf("[%s%s ",
 		!prefixcmp(head, "refs/heads/") ?
 			head + 11 :
--=20
1.7.4.74.g639db
