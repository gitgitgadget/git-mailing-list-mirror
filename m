From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH/WIP 04/10] parse_pathspec: save prefix information
Date: Sun, 13 Jan 2013 19:49:33 +0700
Message-ID: <1358081379-17752-5-git-send-email-pclouds@gmail.com>
References: <1358081379-17752-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jan 13 13:50:16 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TuN0w-0000vj-KN
	for gcvg-git-2@plane.gmane.org; Sun, 13 Jan 2013 13:50:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754839Ab3AMMty convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 13 Jan 2013 07:49:54 -0500
Received: from mail-da0-f51.google.com ([209.85.210.51]:39928 "EHLO
	mail-da0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754793Ab3AMMtx (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 13 Jan 2013 07:49:53 -0500
Received: by mail-da0-f51.google.com with SMTP id i30so1417385dad.24
        for <git@vger.kernel.org>; Sun, 13 Jan 2013 04:49:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:from:to:cc:subject:date:message-id:x-mailer:in-reply-to
         :references:mime-version:content-type:content-transfer-encoding;
        bh=z1PlLpsbkvzVVMHG+zsXStJr/C2b1mtu2oZ/tag7hA4=;
        b=vWOCop3emBiehJiziudL+/eO8QuFLfCyhTEKACH9zvuk3TpnZgS1bVZ4S+aV01Lr+7
         Cv36dGbEIwoRfzIPQeQj0QibxZc9EvU5jFovVTz55zwLcFx99bPFxqLL1QguEplIzmOj
         AaagkliuT2/Nro2ReAEIzJ2kZlLGHzddjy5e808UzopuHT1Te0Yg82absHXAKEtWjRay
         5orf0Ny3CUmGY99MOFEickQGHJ6h4T0eHXxbFyMGh9jhv02o2QszqFLxFKZUBp7R9kmV
         u7w2TkB4+sc2kZEt1vpPZpnXFnS/ac6qpV2DNehTJqwnpykxRz0SUvgUnwDw8TwTfYg4
         s1sQ==
X-Received: by 10.68.231.40 with SMTP id td8mr50807420pbc.48.1358081393363;
        Sun, 13 Jan 2013 04:49:53 -0800 (PST)
Received: from lanh ([115.74.52.72])
        by mx.google.com with ESMTPS id d1sm6779037pav.6.2013.01.13.04.49.50
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Sun, 13 Jan 2013 04:49:52 -0800 (PST)
Received: by lanh (sSMTP sendmail emulation); Sun, 13 Jan 2013 19:50:08 +0700
X-Mailer: git-send-email 1.8.0.rc2.23.g1fb49df
In-Reply-To: <1358081379-17752-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/213376>


Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 cache.h | 2 +-
 setup.c | 1 +
 2 files changed, 2 insertions(+), 1 deletion(-)

diff --git a/cache.h b/cache.h
index 900b81a..fb54876 100644
--- a/cache.h
+++ b/cache.h
@@ -493,7 +493,7 @@ struct pathspec {
 		const char *match;
 		const char *original;
 		unsigned magic;
-		int len;
+		int len, prefix;
 		int nowildcard_len;
 		int flags;
 	} *items;
diff --git a/setup.c b/setup.c
index 6b48f1b..c4af05e 100644
--- a/setup.c
+++ b/setup.c
@@ -310,6 +310,7 @@ static unsigned prefix_pathspec(struct pathspec_ite=
m *item,
 		if (item->nowildcard_len < prefixlen)
 			item->nowildcard_len =3D prefixlen;
 	}
+	item->prefix =3D prefixlen;
 	if (item->nowildcard_len < item->len &&
 	    item->match[item->nowildcard_len] =3D=3D '*' &&
 	    no_wildcard(item->match + item->nowildcard_len + 1))
--=20
1.8.0.rc2.23.g1fb49df
