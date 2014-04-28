From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 10/32] resolve-undo: be specific what part of the index has changed
Date: Mon, 28 Apr 2014 17:55:31 +0700
Message-ID: <1398682553-11634-11-git-send-email-pclouds@gmail.com>
References: <1398682553-11634-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Apr 28 12:55:42 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WejDo-0001nG-Eu
	for gcvg-git-2@plane.gmane.org; Mon, 28 Apr 2014 12:55:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755350AbaD1Kzd convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 28 Apr 2014 06:55:33 -0400
Received: from mail-pd0-f171.google.com ([209.85.192.171]:41016 "EHLO
	mail-pd0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755319AbaD1Kz1 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 28 Apr 2014 06:55:27 -0400
Received: by mail-pd0-f171.google.com with SMTP id g10so621953pdj.30
        for <git@vger.kernel.org>; Mon, 28 Apr 2014 03:55:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=B4+oVNvDDq9aVOXSgy0+FRqJmB8T+Kdgv36CNn1bfko=;
        b=cZonHhIHF4fIcRPxun/JFDK9MJPpU30joB8nP3pL+UhQaCnGkHn+2Z1s1ksoXxGuua
         WGkH5fJ0U2/EAE7nwbLVAB+cBUfB871YU6vZN3FrwUR/3UPGux1ko5HARHCMmMkgjDNl
         lmyZu/7sdv+vM+atG5NRyj5Qes9mZSaRvByUSAYkpB2unWQEZan1uhABDHPogt6L3fGe
         DhvYN6d/cm5U93RPdU77qTgZQduRb+nRqIHP6FwbZfyUV4+gwFKTCe+dd4ZfXlBqtnXq
         NEvrW6DMeaXwn6N2xZkOS7urtc08dRbIylnRTy40r6nG/Nth2jvAeAJ91EnwKoxwGTOi
         UlwQ==
X-Received: by 10.66.150.69 with SMTP id ug5mr24815443pab.55.1398682526425;
        Mon, 28 Apr 2014 03:55:26 -0700 (PDT)
Received: from lanh ([115.73.231.31])
        by mx.google.com with ESMTPSA id sv10sm34159632pbc.74.2014.04.28.03.55.22
        for <multiple recipients>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Mon, 28 Apr 2014 03:55:24 -0700 (PDT)
Received: by lanh (sSMTP sendmail emulation); Mon, 28 Apr 2014 17:56:53 +0700
X-Mailer: git-send-email 1.9.1.346.ga2b5940
In-Reply-To: <1398682553-11634-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/247277>

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 cache.h        | 1 +
 resolve-undo.c | 2 +-
 2 files changed, 2 insertions(+), 1 deletion(-)

diff --git a/cache.h b/cache.h
index 4133797..7155052 100644
--- a/cache.h
+++ b/cache.h
@@ -272,6 +272,7 @@ static inline unsigned int canon_mode(unsigned int =
mode)
 #define CE_ENTRY_REMOVED	(1 << 1)
 #define CE_ENTRY_ADDED		(1 << 2)
 #define SOMETHING_CHANGED	(1 << 3) /* unclassified changes go here */
+#define RESOLVE_UNDO_CHANGED	(1 << 4)
=20
 struct index_state {
 	struct cache_entry **cache;
diff --git a/resolve-undo.c b/resolve-undo.c
index 44c697c..468a2eb 100644
--- a/resolve-undo.c
+++ b/resolve-undo.c
@@ -110,7 +110,7 @@ void resolve_undo_clear_index(struct index_state *i=
state)
 	string_list_clear(resolve_undo, 1);
 	free(resolve_undo);
 	istate->resolve_undo =3D NULL;
-	istate->cache_changed =3D 1;
+	istate->cache_changed |=3D RESOLVE_UNDO_CHANGED;
 }
=20
 int unmerge_index_entry_at(struct index_state *istate, int pos)
--=20
1.9.1.346.ga2b5940
