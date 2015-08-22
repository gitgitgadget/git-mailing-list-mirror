From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 2/8] Add and use convenient macro ce_intent_to_add()
Date: Sat, 22 Aug 2015 08:08:05 +0700
Message-ID: <1440205700-19749-3-git-send-email-pclouds@gmail.com>
References: <xmqqy4j80wdb.fsf@gitster.dls.corp.google.com>
 <1440205700-19749-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>, phiggins@google.com,
	snoksrud@gmail.com,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Aug 22 03:08:50 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZSxIf-0004nG-FV
	for gcvg-git-2@plane.gmane.org; Sat, 22 Aug 2015 03:08:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752858AbbHVBIo convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 21 Aug 2015 21:08:44 -0400
Received: from mail-pd0-f176.google.com ([209.85.192.176]:33595 "EHLO
	mail-pd0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752816AbbHVBIn (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 21 Aug 2015 21:08:43 -0400
Received: by pdrh1 with SMTP id h1so32476184pdr.0
        for <git@vger.kernel.org>; Fri, 21 Aug 2015 18:08:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=EudQ6cra7hlLaQk3c8xsDTY1YkjhZLqOul/xZycLPrk=;
        b=X1hI7FYHdDu0jD2rFyc/uJrIB8kwXjPP2/9GVvNjzPWrja+4S2aZgbi493WjArcNcH
         DThie3L00qZvCTa0yZ4ztoMLdnAkP3dw3ent6X3IS7ZX2LBgvAtRxCViUqw/ChcGss/D
         EscUq62G1jbGlLA5+LZ1rPbJSnvqj8hRajswaA2qmas9DXx8YtNyljqAc5QmpmOQIqug
         tHFGIXzRri/7wgGt7v/Z5/PXwuUR4S9iHnvCI9itVIXRrL5MuHYwcftHICe9P2XS/yeo
         ZU2sF1D1TkYM11ye9jdGSCIP+C+K0n4PBstKKeS0o9awPI03a5tFMnwgLWUAJEXFOdBa
         kobw==
X-Received: by 10.70.33.225 with SMTP id u1mr22405754pdi.155.1440205723320;
        Fri, 21 Aug 2015 18:08:43 -0700 (PDT)
Received: from lanh ([171.232.84.126])
        by smtp.gmail.com with ESMTPSA id gh5sm9101697pbc.87.2015.08.21.18.08.40
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 21 Aug 2015 18:08:42 -0700 (PDT)
Received: by lanh (sSMTP sendmail emulation); Sat, 22 Aug 2015 08:08:39 +0700
X-Mailer: git-send-email 2.3.0.rc1.137.g477eb31
In-Reply-To: <1440205700-19749-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/276354>

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 builtin/rm.c | 2 +-
 cache-tree.c | 2 +-
 cache.h      | 1 +
 read-cache.c | 4 ++--
 4 files changed, 5 insertions(+), 4 deletions(-)

diff --git a/builtin/rm.c b/builtin/rm.c
index 80b972f..8829b09 100644
--- a/builtin/rm.c
+++ b/builtin/rm.c
@@ -211,7 +211,7 @@ static int check_local_mod(unsigned char *head, int=
 index_only)
 		 * "intent to add" entry.
 		 */
 		if (local_changes && staged_changes) {
-			if (!index_only || !(ce->ce_flags & CE_INTENT_TO_ADD))
+			if (!index_only || !ce_intent_to_add(ce))
 				string_list_append(&files_staged, name);
 		}
 		else if (!index_only) {
diff --git a/cache-tree.c b/cache-tree.c
index feace8b..c865bd2 100644
--- a/cache-tree.c
+++ b/cache-tree.c
@@ -377,7 +377,7 @@ static int update_one(struct cache_tree *it,
 		 * they are not part of generated trees. Invalidate up
 		 * to root to force cache-tree users to read elsewhere.
 		 */
-		if (ce->ce_flags & CE_INTENT_TO_ADD) {
+		if (ce_intent_to_add(ce)) {
 			to_invalidate =3D 1;
 			continue;
 		}
diff --git a/cache.h b/cache.h
index 4e25271..41d811c 100644
--- a/cache.h
+++ b/cache.h
@@ -241,6 +241,7 @@ static inline unsigned create_ce_flags(unsigned sta=
ge)
 #define ce_uptodate(ce) ((ce)->ce_flags & CE_UPTODATE)
 #define ce_skip_worktree(ce) ((ce)->ce_flags & CE_SKIP_WORKTREE)
 #define ce_mark_uptodate(ce) ((ce)->ce_flags |=3D CE_UPTODATE)
+#define ce_intent_to_add(ce) ((ce)->ce_flags & CE_INTENT_TO_ADD)
=20
 #define ce_permissions(mode) (((mode) & 0100) ? 0755 : 0644)
 static inline unsigned int create_ce_mode(unsigned int mode)
diff --git a/read-cache.c b/read-cache.c
index 89dbc08..f849cbd 100644
--- a/read-cache.c
+++ b/read-cache.c
@@ -327,7 +327,7 @@ int ie_match_stat(const struct index_state *istate,
 	 * by definition never matches what is in the work tree until it
 	 * actually gets added.
 	 */
-	if (ce->ce_flags & CE_INTENT_TO_ADD)
+	if (ce_intent_to_add(ce))
 		return DATA_CHANGED | TYPE_CHANGED | MODE_CHANGED;
=20
 	changed =3D ce_match_stat_basic(ce, st);
@@ -1251,7 +1251,7 @@ int refresh_index(struct index_state *istate, uns=
igned int flags,
=20
 			if (cache_errno =3D=3D ENOENT)
 				fmt =3D deleted_fmt;
-			else if (ce->ce_flags & CE_INTENT_TO_ADD)
+			else if (ce_intent_to_add(ce))
 				fmt =3D added_fmt; /* must be before other checks */
 			else if (changed & TYPE_CHANGED)
 				fmt =3D typechange_fmt;
--=20
2.3.0.rc1.137.g477eb31
