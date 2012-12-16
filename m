From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH v4 1/4] cache-tree: remove dead i-t-a code in verify_cache()
Date: Sun, 16 Dec 2012 11:15:25 +0700
Message-ID: <1355631328-26678-2-git-send-email-pclouds@gmail.com>
References: <1355631328-26678-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Dec 16 05:15:38 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Tk5dZ-0004J7-6M
	for gcvg-git-2@plane.gmane.org; Sun, 16 Dec 2012 05:15:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752510Ab2LPEPJ convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 15 Dec 2012 23:15:09 -0500
Received: from mail-pa0-f46.google.com ([209.85.220.46]:41645 "EHLO
	mail-pa0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752453Ab2LPEPH (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 15 Dec 2012 23:15:07 -0500
Received: by mail-pa0-f46.google.com with SMTP id bh2so3304170pad.19
        for <git@vger.kernel.org>; Sat, 15 Dec 2012 20:15:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=whFtN6lH/vPTrSagVfQBvLkaSmAfLIgdGBg37ewDQW0=;
        b=qDo+ADoEigyfCiXuCc/lgByxgODQV08JWiWjpOZVO1BmN85JKzFeSlteV8VSDGezS5
         TXzhg1Eailchoj99L/SfjBCn2gIlsvZJA1FBxHYznTWolLAheldqV9/cJI0nW6l1Z+Uf
         gnhVyrFXpkog3SJ3xb/god+sdNQpYBQ/+dCkgfhrqCjsvjkOVEbSexM5uajbCEcSTJvk
         slQ5SaoR+dWwz9n8af0XsfejeESLK7yeVZVwd8aqnF8qO5fHidvU9IdtLUROMJPIizAl
         x1+jx3SfBTWX7GkShd39pP4eWOK8yxe4fwuqHa/iTqZ3B04qQBuGCGDR0tGevL7pxVYk
         IUIA==
Received: by 10.68.143.129 with SMTP id se1mr30946867pbb.67.1355631306642;
        Sat, 15 Dec 2012 20:15:06 -0800 (PST)
Received: from lanh ([115.74.41.198])
        by mx.google.com with ESMTPS id nt5sm5722047pbb.59.2012.12.15.20.15.03
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sat, 15 Dec 2012 20:15:05 -0800 (PST)
Received: by lanh (sSMTP sendmail emulation); Sun, 16 Dec 2012 11:15:44 +0700
X-Mailer: git-send-email 1.8.0.rc2.23.g1fb49df
In-Reply-To: <1355631328-26678-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/211574>

This code is added in 331fcb5 (git add --intent-to-add: do not let an
empty blob be committed by accident - 2008-11-28) to forbid committing
when i-t-a entries are present. When we allow that, we forgot to
remove this.

Noticed-by: Junio C Hamano <gitster@pobox.com>
Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 cache-tree.c | 8 ++------
 1 file changed, 2 insertions(+), 6 deletions(-)

diff --git a/cache-tree.c b/cache-tree.c
index 28ed657..e2beab5 100644
--- a/cache-tree.c
+++ b/cache-tree.c
@@ -166,12 +166,8 @@ static int verify_cache(struct cache_entry **cache=
,
 				fprintf(stderr, "...\n");
 				break;
 			}
-			if (ce_stage(ce))
-				fprintf(stderr, "%s: unmerged (%s)\n",
-					ce->name, sha1_to_hex(ce->sha1));
-			else
-				fprintf(stderr, "%s: not added yet\n",
-					ce->name);
+			fprintf(stderr, "%s: unmerged (%s)\n",
+				ce->name, sha1_to_hex(ce->sha1));
 		}
 	}
 	if (funny)
--=20
1.8.0.rc2.23.g1fb49df
