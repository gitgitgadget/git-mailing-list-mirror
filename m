From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH v3 2/2] cache-tree: remove dead i-t-a code in verify_cache()
Date: Thu, 13 Dec 2012 08:39:07 +0700
Message-ID: <1355362747-13474-2-git-send-email-pclouds@gmail.com>
References: <7vip89bz4v.fsf@alter.siamese.dyndns.org>
 <1355362747-13474-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
	Jonathon Mah <me@JonathonMah.com>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Dec 13 02:39:04 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TixlQ-0007CC-4k
	for gcvg-git-2@plane.gmane.org; Thu, 13 Dec 2012 02:39:04 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755335Ab2LMBim convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 12 Dec 2012 20:38:42 -0500
Received: from mail-pa0-f46.google.com ([209.85.220.46]:62440 "EHLO
	mail-pa0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755076Ab2LMBil (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 12 Dec 2012 20:38:41 -0500
Received: by mail-pa0-f46.google.com with SMTP id bh2so1117297pad.19
        for <git@vger.kernel.org>; Wed, 12 Dec 2012 17:38:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=QAS0lR5HiC5hlH+83DpCg6fgQePi/cxuag3FkjGQaQk=;
        b=ccSCs7kxgGWt52RW2cHb0vgVLGffSdqms0VrCsA4t+o5j17eEMr2Mcs9mwELiloBwL
         tP+tTXDR5hTosZH7ehjdS7h+w0XVH9Lxg8ObEFqS7UnZSUeGRJjekkUyshg2FCFXSIc4
         SB8gX7mLHrcQsudd7nz/cjshQxZBFDj/yRitigY0t7hJ46pIy4PWe2ShUm0jiZmCIVOt
         P/EizFcuc5RKLwxk4KNd+vRLt0rUjuOwM0UewM25cqAkPuI+RogH3NDQKJN7pwde8gzb
         3XG88wtDiUcgpKqp4EcGh9vSt+3cBOz4vPfUqpRv9yiR4CaS4dhbXZm6QZ/4YBwf6j1z
         AzWg==
Received: by 10.68.228.2 with SMTP id se2mr365241pbc.93.1355362721247;
        Wed, 12 Dec 2012 17:38:41 -0800 (PST)
Received: from lanh ([115.74.41.198])
        by mx.google.com with ESMTPS id vs3sm16997pbc.61.2012.12.12.17.38.37
        (version=TLSv1/SSLv3 cipher=OTHER);
        Wed, 12 Dec 2012 17:38:40 -0800 (PST)
Received: by lanh (sSMTP sendmail emulation); Thu, 13 Dec 2012 08:39:15 +0700
X-Mailer: git-send-email 1.8.0.rc2.23.g1fb49df
In-Reply-To: <1355362747-13474-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/211430>

This code is added in 331fcb5 (git add --intent-to-add: do not let an
empty blob be committed by accident - 2008-11-28) to forbid committing
when i-t-a entries are present. When we allow that, we forgot to
remove this unreachable code.

Noticed-by: Junio C Hamano <gitster@pobox.com>
Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 cache-tree.c | 8 ++------
 1 file changed, 2 insertions(+), 6 deletions(-)

diff --git a/cache-tree.c b/cache-tree.c
index 1fbc81a..3e79e27 100644
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
