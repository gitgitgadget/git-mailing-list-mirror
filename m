From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH v3 1/4] branch: no detached HEAD check when editing another branch's description
Date: Mon, 28 Jan 2013 08:18:13 +0700
Message-ID: <1359335896-24406-1-git-send-email-pclouds@gmail.com>
References: <1359118225-14356-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Jonathan Nieder <jrnieder@gmail.com>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jan 28 02:19:43 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TzdNt-0008TD-F0
	for gcvg-git-2@plane.gmane.org; Mon, 28 Jan 2013 02:19:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757198Ab3A1BS7 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 27 Jan 2013 20:18:59 -0500
Received: from mail-pa0-f42.google.com ([209.85.220.42]:45847 "EHLO
	mail-pa0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757191Ab3A1BSu (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 27 Jan 2013 20:18:50 -0500
Received: by mail-pa0-f42.google.com with SMTP id rl6so1202590pac.1
        for <git@vger.kernel.org>; Sun, 27 Jan 2013 17:18:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:from:to:cc:subject:date:message-id:x-mailer:in-reply-to
         :references:mime-version:content-type:content-transfer-encoding;
        bh=UKZWSrXzDiAtxjxiu00pmPdD9PTUgK1R/Po7YMsLgxw=;
        b=B0UT7SLOuYtB0a6TKJDtJwIkQbdVRatpLZzRivC9qtg2wyc0rHzumqOoKf1EvfOsWv
         y8ZxNh2zoPL8rUieTbC3N4LcWKOOm2stkm4/ImyyGiucwxZGFkTElF1l2QZwqpt4w8mY
         +69fAIUuCcPQEBuifO/DYiqiYTqXTE+5YnpMSnfu0s/juTG7Yvjx8Lw3qKU8qRdc8hVa
         dFXJltD+5us5N26yaDMgZcpwmwnQ5dI2PlvjPh05DYsxXI5r5eJP94CCZCKZsLh9eikj
         mT1DbdRgN2T788oaZ8ztAABEiP7W4ypA+9oUme4DnuCt9Wy5jJnxpnuf0690ocbV14E+
         9rzA==
X-Received: by 10.66.76.8 with SMTP id g8mr32060613paw.40.1359335929962;
        Sun, 27 Jan 2013 17:18:49 -0800 (PST)
Received: from pclouds@gmail.com ([113.161.77.29])
        by mx.google.com with ESMTPS id bi8sm5624906pab.15.2013.01.27.17.18.45
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Sun, 27 Jan 2013 17:18:48 -0800 (PST)
Received: by pclouds@gmail.com (sSMTP sendmail emulation); Mon, 28 Jan 2013 08:18:24 +0700
X-Mailer: git-send-email 1.8.1.1.459.g5970e58
In-Reply-To: <1359118225-14356-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/214778>


Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 Split out from v3's 2/3 as Jonathan suggested.

 builtin/branch.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/builtin/branch.c b/builtin/branch.c
index 873f624..ea6498b 100644
--- a/builtin/branch.c
+++ b/builtin/branch.c
@@ -850,11 +850,11 @@ int cmd_branch(int argc, const char **argv, const=
 char *prefix)
 		const char *branch_name;
 		struct strbuf branch_ref =3D STRBUF_INIT;
=20
-		if (detached)
-			die("Cannot give description to detached HEAD");
-		if (!argc)
+		if (!argc) {
+			if (detached)
+				die("Cannot give description to detached HEAD");
 			branch_name =3D head;
-		else if (argc =3D=3D 1)
+		} else if (argc =3D=3D 1)
 			branch_name =3D argv[0];
 		else
 			usage_with_options(builtin_branch_usage, options);
--=20
1.8.1.1.459.g5970e58
