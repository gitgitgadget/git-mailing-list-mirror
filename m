From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH v4 03/13] parseopt: make OPT_INTEGER support hexadecimal as well
Date: Fri,  3 Feb 2012 20:34:28 +0700
Message-ID: <1328276078-27955-4-git-send-email-pclouds@gmail.com>
References: <1328276078-27955-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Feb 03 14:31:24 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RtJEV-0007xT-P4
	for gcvg-git-2@plane.gmane.org; Fri, 03 Feb 2012 14:31:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756353Ab2BCNbL convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 3 Feb 2012 08:31:11 -0500
Received: from mail-pz0-f46.google.com ([209.85.210.46]:37976 "EHLO
	mail-pz0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756242Ab2BCNbD (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 3 Feb 2012 08:31:03 -0500
Received: by mail-pz0-f46.google.com with SMTP id p15so2736866dad.19
        for <git@vger.kernel.org>; Fri, 03 Feb 2012 05:31:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=1jtvRTWjvsrdQ2hDPOriREJYo1vS6vlKwFsX+ixhTIA=;
        b=TZi20bDB+RDsFg+4RV3by1yknrHioh2HTL6wIn/2RxpFbbsDxnizjHhQo/Xci9oiws
         iYBnW698t39n3TNy+iZoJ62XWhCHICNfvuI8LkOiB/9BMQWHLDbQRaogc2N4XjR696Y1
         HC0Q3H382bLdnslNxQ1XhkaZlGeoDkovPKJ1c=
Received: by 10.68.222.103 with SMTP id ql7mr17964215pbc.53.1328275863583;
        Fri, 03 Feb 2012 05:31:03 -0800 (PST)
Received: from tre ([115.74.57.120])
        by mx.google.com with ESMTPS id p9sm13117403pbb.9.2012.02.03.05.30.59
        (version=TLSv1/SSLv3 cipher=OTHER);
        Fri, 03 Feb 2012 05:31:02 -0800 (PST)
Received: by tre (sSMTP sendmail emulation); Fri, 03 Feb 2012 20:35:12 +0700
X-Mailer: git-send-email 1.7.8.36.g69ee2
In-Reply-To: <1328276078-27955-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/189761>


Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 parse-options.c |    5 ++++-
 1 files changed, 4 insertions(+), 1 deletions(-)

diff --git a/parse-options.c b/parse-options.c
index f0098eb..7c9109d 100644
--- a/parse-options.c
+++ b/parse-options.c
@@ -139,7 +139,10 @@ static int get_value(struct parse_opt_ctx_t *p,
 		}
 		if (get_arg(p, opt, flags, &arg))
 			return -1;
-		*(int *)opt->value =3D strtol(arg, (char **)&s, 10);
+		if (!prefixcmp(arg, "0x") || !prefixcmp(arg, "0X"))
+			*(int *)opt->value =3D strtol(arg + 2, (char **)&s, 16);
+		else
+			*(int *)opt->value =3D strtol(arg, (char **)&s, 10);
 		if (*s)
 			return opterror(opt, "expects a numerical value", flags);
 		return 0;
--=20
1.7.8.36.g69ee2
