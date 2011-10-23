From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 2/2] pretty.c: use original commit message if reencoding fails
Date: Sun, 23 Oct 2011 22:51:35 +1100
Message-ID: <1319370695-12638-2-git-send-email-pclouds@gmail.com>
References: <1319370695-12638-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Oct 23 13:53:30 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RHwcL-0000sr-5b
	for gcvg-git-2@lo.gmane.org; Sun, 23 Oct 2011 13:53:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755436Ab1JWLxZ convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 23 Oct 2011 07:53:25 -0400
Received: from mail-gy0-f174.google.com ([209.85.160.174]:49523 "EHLO
	mail-gy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755398Ab1JWLxY (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 23 Oct 2011 07:53:24 -0400
Received: by gyb13 with SMTP id 13so4973220gyb.19
        for <git@vger.kernel.org>; Sun, 23 Oct 2011 04:53:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=08FnE12URgww9vg+XvZjIWtRTE4msBUxSTRvds6xcf0=;
        b=mg43QTfaAh+ZvWPzijjUzKcHL5dQD28j2TZMHjxqALJHR0/kj6XkPy3gfYIDiWeaTY
         wNGG5z8S7ZZxXyAF8Iynmo9UhQGP3nufGRt8XqxllrXwcI1d5QzVyHxRK6GbboB8EQor
         De7XG5BtRFw2aE8AJc/+t4+ANy+8Ta7DFiV7s=
Received: by 10.68.71.229 with SMTP id y5mr13313104pbu.37.1319370803382;
        Sun, 23 Oct 2011 04:53:23 -0700 (PDT)
Received: from pclouds@gmail.com (220-244-161-237.static.tpgi.com.au. [220.244.161.237])
        by mx.google.com with ESMTPS id ko15sm54503495pbb.9.2011.10.23.04.53.19
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sun, 23 Oct 2011 04:53:22 -0700 (PDT)
Received: by pclouds@gmail.com (sSMTP sendmail emulation); Sun, 23 Oct 2011 22:51:44 +1100
X-Mailer: git-send-email 1.7.3.1.256.g2539c.dirty
In-Reply-To: <1319370695-12638-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/184138>


Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 pretty.c |    5 ++++-
 1 files changed, 4 insertions(+), 1 deletions(-)

diff --git a/pretty.c b/pretty.c
index 375ff7b..230fe1c 100644
--- a/pretty.c
+++ b/pretty.c
@@ -1103,8 +1103,11 @@ void format_commit_message(const struct commit *=
commit,
 	context.message =3D commit->buffer;
 	if (output_enc) {
 		char *enc =3D get_header(commit, "encoding");
-		if (strcmp(enc ? enc : utf8, output_enc))
+		if (strcmp(enc ? enc : utf8, output_enc)) {
 			context.message =3D logmsg_reencode(commit, output_enc);
+			if (!context.message)
+				context.message =3D commit->buffer;
+		}
 		free(enc);
 	}
=20
--=20
1.7.3.1.256.g2539c.dirty
