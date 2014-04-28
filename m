From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 09/32] update-index: be specific what part of the index has changed
Date: Mon, 28 Apr 2014 17:55:30 +0700
Message-ID: <1398682553-11634-10-git-send-email-pclouds@gmail.com>
References: <1398682553-11634-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Apr 28 12:55:35 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WejDi-0001gu-O6
	for gcvg-git-2@plane.gmane.org; Mon, 28 Apr 2014 12:55:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755335AbaD1KzY convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 28 Apr 2014 06:55:24 -0400
Received: from mail-pa0-f47.google.com ([209.85.220.47]:49056 "EHLO
	mail-pa0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755319AbaD1KzV (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 28 Apr 2014 06:55:21 -0400
Received: by mail-pa0-f47.google.com with SMTP id lj1so5610889pab.6
        for <git@vger.kernel.org>; Mon, 28 Apr 2014 03:55:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=wEKLLEiCvNEZfLO/9RjrRbvtcWqAfYZNBD2truQBpxw=;
        b=IlH4s+xKrIERU/fxiRUvOcY888yb1kssH7SLRXiFI98z7TVjW0TV/j8YCJ+gVzWCRW
         VMj9Kmr0D77+6ypTxziH4h0hUMEfJxbQ3JvT0O+hGcsaxfrmcv5DojZp27fi27+dPIe2
         iQRIwhFYJ36ETXsAtleMAD1ETrEbXfMZ/GZLoT9PpBvXQDzf7kOIwxauGvptoTjAfQit
         bx7iAkpjckvFi3G89Qtfw87qnS+1cS3aPdF5PlI6RqnLYoCvh/VVhMnVr347Uw0d0Ng8
         EQUYusxAF9oqSTCKCCLTNGDR3+xzXF4lIklnlGY13Qh1nn5bCF7tEMfEUL84L5FLtlyA
         hhGg==
X-Received: by 10.66.142.233 with SMTP id rz9mr24719247pab.71.1398682520135;
        Mon, 28 Apr 2014 03:55:20 -0700 (PDT)
Received: from lanh ([115.73.231.31])
        by mx.google.com with ESMTPSA id bt1sm34215581pbd.29.2014.04.28.03.55.17
        for <multiple recipients>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Mon, 28 Apr 2014 03:55:19 -0700 (PDT)
Received: by lanh (sSMTP sendmail emulation); Mon, 28 Apr 2014 17:56:48 +0700
X-Mailer: git-send-email 1.9.1.346.ga2b5940
In-Reply-To: <1398682553-11634-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/247276>

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 builtin/update-index.c | 6 +++---
 cache.h                | 1 +
 2 files changed, 4 insertions(+), 3 deletions(-)

diff --git a/builtin/update-index.c b/builtin/update-index.c
index 42cbe4b..e0e881b 100644
--- a/builtin/update-index.c
+++ b/builtin/update-index.c
@@ -56,7 +56,7 @@ static int mark_ce_flags(const char *path, int flag, =
int mark)
 		else
 			active_cache[pos]->ce_flags &=3D ~flag;
 		cache_tree_invalidate_path(active_cache_tree, path);
-		active_cache_changed =3D 1;
+		active_cache_changed |=3D CE_ENTRY_CHANGED;
 		return 0;
 	}
 	return -1;
@@ -268,7 +268,7 @@ static void chmod_path(int flip, const char *path)
 		goto fail;
 	}
 	cache_tree_invalidate_path(active_cache_tree, path);
-	active_cache_changed =3D 1;
+	active_cache_changed |=3D CE_ENTRY_CHANGED;
 	report("chmod %cx '%s'", flip, path);
 	return;
  fail:
@@ -889,7 +889,7 @@ int cmd_update_index(int argc, const char **argv, c=
onst char *prefix)
 			    INDEX_FORMAT_LB, INDEX_FORMAT_UB);
=20
 		if (the_index.version !=3D preferred_index_format)
-			active_cache_changed =3D 1;
+			active_cache_changed |=3D SOMETHING_CHANGED;
 		the_index.version =3D preferred_index_format;
 	}
=20
diff --git a/cache.h b/cache.h
index d692b74..4133797 100644
--- a/cache.h
+++ b/cache.h
@@ -271,6 +271,7 @@ static inline unsigned int canon_mode(unsigned int =
mode)
 #define CE_ENTRY_CHANGED	(1 << 0)
 #define CE_ENTRY_REMOVED	(1 << 1)
 #define CE_ENTRY_ADDED		(1 << 2)
+#define SOMETHING_CHANGED	(1 << 3) /* unclassified changes go here */
=20
 struct index_state {
 	struct cache_entry **cache;
--=20
1.9.1.346.ga2b5940
