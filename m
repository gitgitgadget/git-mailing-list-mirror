From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 03/21] pathspec: make sure the prefix part is wildcard-clean
Date: Sun,  6 Jan 2013 13:20:50 +0700
Message-ID: <1357453268-12543-4-git-send-email-pclouds@gmail.com>
References: <1357453268-12543-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jan 06 07:21:42 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Trjc6-0007cC-2c
	for gcvg-git-2@plane.gmane.org; Sun, 06 Jan 2013 07:21:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751184Ab3AFGVW convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 6 Jan 2013 01:21:22 -0500
Received: from mail-pa0-f46.google.com ([209.85.220.46]:33196 "EHLO
	mail-pa0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751076Ab3AFGVV (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 6 Jan 2013 01:21:21 -0500
Received: by mail-pa0-f46.google.com with SMTP id bh2so10024849pad.19
        for <git@vger.kernel.org>; Sat, 05 Jan 2013 22:21:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:from:to:cc:subject:date:message-id:x-mailer:in-reply-to
         :references:mime-version:content-type:content-transfer-encoding;
        bh=OsuTaJW4QRxzIfuRXDBngrHckYmn3iFcJtz+X50E7RA=;
        b=bH9bmG0ACdwtJyL71dilyZiu9e0Lxsxsd4r9owTgyARgZY+G6Fld2Q9buqMjn6RwBy
         gixEIyIjB3aPMqfEPNEllFFFMeorEj9yjp/9vgWkMsVHyjd3PK1tgOOxJLiteEZD46lr
         h/m3d5pgZo2qJVd0q1GsYUXuYtdiQvB6dfLSoApGUz4+6H4X0rrJ/ukl+SfZv80KhjgZ
         Qu/aI1Ds0Hm0Tw7r+u/TaH+NoclXRQ36o6Nslyao1KdWOKrV2t2db7ZehNAtRz24ljVx
         4r8iB1bmbdp2ft2P6bW8Gt30P/eUOlMYahgrnbb/p7F/A16X86x5hzcZa+vnaVM8m+kN
         ZlrQ==
X-Received: by 10.68.132.34 with SMTP id or2mr177321047pbb.133.1357453279986;
        Sat, 05 Jan 2013 22:21:19 -0800 (PST)
Received: from lanh ([115.74.34.31])
        by mx.google.com with ESMTPS id wh8sm35280546pbc.75.2013.01.05.22.21.17
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sat, 05 Jan 2013 22:21:19 -0800 (PST)
Received: by lanh (sSMTP sendmail emulation); Sun, 06 Jan 2013 13:21:29 +0700
X-Mailer: git-send-email 1.8.0.rc2.23.g1fb49df
In-Reply-To: <1357453268-12543-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/212757>

Prefix is the result of Git moving back from current directory to
worktree's top directory and it has to prepend all user provided paths
so that they become relative to the new current directory. Any
wildcards in the prefix should not be treated as such because it's not
the user intention. Make sure all wildcards in the prefix part is
disabled.

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 setup.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/setup.c b/setup.c
index 4fcdae6..573ef79 100644
--- a/setup.c
+++ b/setup.c
@@ -250,6 +250,8 @@ static unsigned prefix_pathspec(struct pathspec_ite=
m *item,
 	*raw =3D item->match;
 	item->len =3D strlen(item->match);
 	item->nowildcard_len =3D simple_length(item->match);
+	if (item->nowildcard_len < prefixlen)
+		item->nowildcard_len =3D prefixlen;
 	return magic;
 }
=20
--=20
1.8.0.rc2.23.g1fb49df
