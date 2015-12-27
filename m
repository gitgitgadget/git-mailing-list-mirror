From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 2/6] Add and use convenient macro ce_intent_to_add()
Date: Sun, 27 Dec 2015 08:51:28 +0700
Message-ID: <1451181092-26054-3-git-send-email-pclouds@gmail.com>
References: <1451181092-26054-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Dec 27 02:52:33 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aD0Va-0006gr-EC
	for gcvg-git-2@plane.gmane.org; Sun, 27 Dec 2015 02:52:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754367AbbL0BwI convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 26 Dec 2015 20:52:08 -0500
Received: from mail-pf0-f178.google.com ([209.85.192.178]:35816 "EHLO
	mail-pf0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754157AbbL0Bvk (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 26 Dec 2015 20:51:40 -0500
Received: by mail-pf0-f178.google.com with SMTP id 78so94559159pfw.2
        for <git@vger.kernel.org>; Sat, 26 Dec 2015 17:51:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=xDIAi4lpVvZyuUxNyhad3VjVexRZpFL+nxfMkOm0jW0=;
        b=qc8rbAMAjSYn6uma5NrIGiwSyCtajne9P5CVE55H9Mdzo9P6tfae2OFSnFUKpajH36
         5/dY8+JXo0vFe5aBhf2QQzgyLkBYqEMdySJrIuvho/9mmhnulPr1oXNL2Ehgs2KYmlwB
         +U1UJ1T8ZrELm6ViqYmn/F4YFvr2v5RIsW82qr476/owHSzSkpy7w+0pLBSCx8183QeV
         CZHTS+QUyzoX9OhN+Mg0oU6gq9BTdPCP8/VdtoFVxR7Ce/GosT7ECGMSenBqCVWjOv6p
         ctQrctwjQySRtm7ICODYRcU+NKCt0G+DSbXkYcpGjshgfcG0kv8zmPN70q4UIEhMl3Xm
         bSvA==
X-Received: by 10.98.2.2 with SMTP id 2mr68340541pfc.13.1451181099728;
        Sat, 26 Dec 2015 17:51:39 -0800 (PST)
Received: from lanh ([171.233.234.31])
        by smtp.gmail.com with ESMTPSA id xr8sm72523775pab.26.2015.12.26.17.51.36
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 26 Dec 2015 17:51:38 -0800 (PST)
Received: by lanh (sSMTP sendmail emulation); Sun, 27 Dec 2015 08:51:46 +0700
X-Mailer: git-send-email 2.3.0.rc1.137.g477eb31
In-Reply-To: <1451181092-26054-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/283007>

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 builtin/rm.c | 2 +-
 cache-tree.c | 2 +-
 cache.h      | 1 +
 read-cache.c | 4 ++--
 4 files changed, 5 insertions(+), 4 deletions(-)

diff --git a/builtin/rm.c b/builtin/rm.c
index 3304bff..74a7a43 100644
--- a/builtin/rm.c
+++ b/builtin/rm.c
@@ -212,7 +212,7 @@ static int check_local_mod(unsigned char *head, int=
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
index 32772b9..e590346 100644
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
index 3d3244b..b1f0531 100644
--- a/cache.h
+++ b/cache.h
@@ -233,6 +233,7 @@ static inline unsigned create_ce_flags(unsigned sta=
ge)
 #define ce_uptodate(ce) ((ce)->ce_flags & CE_UPTODATE)
 #define ce_skip_worktree(ce) ((ce)->ce_flags & CE_SKIP_WORKTREE)
 #define ce_mark_uptodate(ce) ((ce)->ce_flags |=3D CE_UPTODATE)
+#define ce_intent_to_add(ce) ((ce)->ce_flags & CE_INTENT_TO_ADD)
=20
 #define ce_permissions(mode) (((mode) & 0100) ? 0755 : 0644)
 static inline unsigned int create_ce_mode(unsigned int mode)
diff --git a/read-cache.c b/read-cache.c
index 36ff89f..fb80c47 100644
--- a/read-cache.c
+++ b/read-cache.c
@@ -311,7 +311,7 @@ int ie_match_stat(const struct index_state *istate,
 	 * by definition never matches what is in the work tree until it
 	 * actually gets added.
 	 */
-	if (ce->ce_flags & CE_INTENT_TO_ADD)
+	if (ce_intent_to_add(ce))
 		return DATA_CHANGED | TYPE_CHANGED | MODE_CHANGED;
=20
 	changed =3D ce_match_stat_basic(ce, st);
@@ -1231,7 +1231,7 @@ int refresh_index(struct index_state *istate, uns=
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
