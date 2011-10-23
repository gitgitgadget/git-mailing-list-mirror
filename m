From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 1/2] pretty.c: free get_header() return value
Date: Sun, 23 Oct 2011 22:51:34 +1100
Message-ID: <1319370695-12638-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Oct 23 13:53:22 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RHwcD-0000qq-LQ
	for gcvg-git-2@lo.gmane.org; Sun, 23 Oct 2011 13:53:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755433Ab1JWLxR convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 23 Oct 2011 07:53:17 -0400
Received: from mail-pz0-f42.google.com ([209.85.210.42]:38509 "EHLO
	mail-pz0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755398Ab1JWLxQ (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 23 Oct 2011 07:53:16 -0400
Received: by pzk36 with SMTP id 36so14185194pzk.1
        for <git@vger.kernel.org>; Sun, 23 Oct 2011 04:53:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:mime-version
         :content-type:content-transfer-encoding;
        bh=lxlgf3XUNPzRTxvPIPuIOvUuUEwm2kAtuWem1Ccu4dI=;
        b=e2joCvvjxXRX1d2p764ZkZ19h/rJ3TEcvJBfjHWCozLkgx/2Apgbo1XjVN23lC65ff
         lBGJPhDV8t4Ve1TVu97NvP037Rjhcq43QT0epj2AfEfQ+9VKJK5qIwcK0eLTP+4wq5ZJ
         oYSYHcJsqbyn3TDNOr4zqg7hVf5IyLZiGL6QY=
Received: by 10.68.31.132 with SMTP id a4mr41352988pbi.26.1319370796267;
        Sun, 23 Oct 2011 04:53:16 -0700 (PDT)
Received: from pclouds@gmail.com (220-244-161-237.static.tpgi.com.au. [220.244.161.237])
        by mx.google.com with ESMTPS id h5sm54521459pbq.11.2011.10.23.04.53.12
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sun, 23 Oct 2011 04:53:15 -0700 (PDT)
Received: by pclouds@gmail.com (sSMTP sendmail emulation); Sun, 23 Oct 2011 22:51:36 +1100
X-Mailer: git-send-email 1.7.3.1.256.g2539c.dirty
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/184137>


Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 pretty.c |    7 +++----
 1 files changed, 3 insertions(+), 4 deletions(-)

diff --git a/pretty.c b/pretty.c
index f45eb54..375ff7b 100644
--- a/pretty.c
+++ b/pretty.c
@@ -1094,7 +1094,6 @@ void format_commit_message(const struct commit *c=
ommit,
 {
 	struct format_commit_context context;
 	static const char utf8[] =3D "UTF-8";
-	const char *enc;
 	const char *output_enc =3D pretty_ctx->output_encoding;
=20
 	memset(&context, 0, sizeof(context));
@@ -1103,10 +1102,10 @@ void format_commit_message(const struct commit =
*commit,
 	context.wrap_start =3D sb->len;
 	context.message =3D commit->buffer;
 	if (output_enc) {
-		enc =3D get_header(commit, "encoding");
-		enc =3D enc ? enc : utf8;
-		if (strcmp(enc, output_enc))
+		char *enc =3D get_header(commit, "encoding");
+		if (strcmp(enc ? enc : utf8, output_enc))
 			context.message =3D logmsg_reencode(commit, output_enc);
+		free(enc);
 	}
=20
 	strbuf_expand(sb, format, format_commit_item, &context);
--=20
1.7.3.1.256.g2539c.dirty
