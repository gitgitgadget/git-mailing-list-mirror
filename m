From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 04/23] update-index: ignore update request if it's skip-worktree
Date: Mon, 14 Dec 2009 17:30:47 +0700
Message-ID: <1260786666-8405-5-git-send-email-pclouds@gmail.com>
References: <1260786666-8405-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Dec 14 11:35:20 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NK8Gu-0008VO-0q
	for gcvg-git-2@lo.gmane.org; Mon, 14 Dec 2009 11:35:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754992AbZLNKfR convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 14 Dec 2009 05:35:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753095AbZLNKcR
	(ORCPT <rfc822;git-outgoing>); Mon, 14 Dec 2009 05:32:17 -0500
Received: from mail-pz0-f171.google.com ([209.85.222.171]:47974 "EHLO
	mail-pz0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752104AbZLNKcP (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 14 Dec 2009 05:32:15 -0500
Received: by mail-pz0-f171.google.com with SMTP id 1so2177665pzk.33
        for <git@vger.kernel.org>; Mon, 14 Dec 2009 02:32:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:from:to:cc:subject
         :date:message-id:x-mailer:in-reply-to:references:mime-version
         :content-type:content-transfer-encoding;
        bh=od854Or+VwhjDX6KpNMg3Z06keG4VQsq9dQnliHozFE=;
        b=noNYlKDJmhxVBM0OYdUTqNZdCY3TdKe6CcRuNocFv7OOiwQuVNql6pnExt0btZQov0
         eSsLeDmS/jXhmh2Y4SBxfYXok7GVZ15fRV98rpi8fgDFREhxEThle8Hk34V8/tAC4c5M
         ALTxStxB9fBfFD5j2tx8YmO5r7ql8GA6xTLZc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        b=ijQJQtcIXC2fmUyg7FRsXUNsB5yGlgw4J3+S10sI/5w11pS27XGwYy1n1cESEvmhxr
         AHXZnFIUfVQDtSNkEbGiPJFPSVQ3mvnSBCcUHGkNOWfERVOE7Q2vITiBlY6zOCC3Ihwl
         Y5QE0Lmf8VH8lCah5GjwXtHWjeEb2ZN6+C2X4=
Received: by 10.141.100.18 with SMTP id c18mr3234436rvm.30.1260786735161;
        Mon, 14 Dec 2009 02:32:15 -0800 (PST)
Received: from pclouds@gmail.com ([115.73.233.253])
        by mx.google.com with ESMTPS id 21sm4902878pzk.11.2009.12.14.02.32.13
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Mon, 14 Dec 2009 02:32:14 -0800 (PST)
Received: by pclouds@gmail.com (sSMTP sendmail emulation); Mon, 14 Dec 2009 17:31:33 +0700
X-Mailer: git-send-email 1.6.5.2.216.g9c1ec
In-Reply-To: <1260786666-8405-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/135193>


Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 builtin-apply.c |    2 +-
 cache.h         |    2 ++
 entry.c         |    2 +-
 read-cache.c    |   17 ++++++++++++++---
 unpack-trees.c  |    6 +++---
 5 files changed, 21 insertions(+), 8 deletions(-)

diff --git a/builtin-apply.c b/builtin-apply.c
index 39dc96a..7717a66 100644
--- a/builtin-apply.c
+++ b/builtin-apply.c
@@ -2505,7 +2505,7 @@ static int verify_index_match(struct cache_entry =
*ce, struct stat *st)
 			return -1;
 		return 0;
 	}
-	return ce_match_stat(ce, st, CE_MATCH_IGNORE_VALID);
+	return ce_match_stat(ce, st, CE_MATCH_IGNORE_VALID|CE_MATCH_IGNORE_SK=
IP_WORKTREE);
 }
=20
 static int check_preimage(struct patch *patch, struct cache_entry **ce=
, struct stat *st)
diff --git a/cache.h b/cache.h
index f266246..f040f24 100644
--- a/cache.h
+++ b/cache.h
@@ -462,6 +462,8 @@ extern int index_name_is_other(const struct index_s=
tate *, const char *, int);
 #define CE_MATCH_IGNORE_VALID		01
 /* do not check the contents but report dirty on racily-clean entries =
*/
 #define CE_MATCH_RACY_IS_DIRTY	02
+/* do stat comparison even if CE_SKIP_WORKTREE is true */
+#define CE_MATCH_IGNORE_SKIP_WORKTREE		04
 extern int ie_match_stat(const struct index_state *, struct cache_entr=
y *, struct stat *, unsigned int);
 extern int ie_modified(const struct index_state *, struct cache_entry =
*, struct stat *, unsigned int);
=20
diff --git a/entry.c b/entry.c
index f276cf3..efee21f 100644
--- a/entry.c
+++ b/entry.c
@@ -202,7 +202,7 @@ int checkout_entry(struct cache_entry *ce, const st=
ruct checkout *state, char *t
 	len +=3D ce_namelen(ce);
=20
 	if (!check_path(path, len, &st)) {
-		unsigned changed =3D ce_match_stat(ce, &st, CE_MATCH_IGNORE_VALID);
+		unsigned changed =3D ce_match_stat(ce, &st, CE_MATCH_IGNORE_VALID|CE=
_MATCH_IGNORE_SKIP_WORKTREE);
 		if (!changed)
 			return 0;
 		if (!state->force) {
diff --git a/read-cache.c b/read-cache.c
index 4e3e272..b31861c 100644
--- a/read-cache.c
+++ b/read-cache.c
@@ -259,12 +259,17 @@ int ie_match_stat(const struct index_state *istat=
e,
 {
 	unsigned int changed;
 	int ignore_valid =3D options & CE_MATCH_IGNORE_VALID;
+	int ignore_skip_worktree =3D options & CE_MATCH_IGNORE_SKIP_WORKTREE;
 	int assume_racy_is_modified =3D options & CE_MATCH_RACY_IS_DIRTY;
=20
 	/*
 	 * If it's marked as always valid in the index, it's
 	 * valid whatever the checked-out copy says.
+	 *
+	 * skip-worktree has the same effect with higher precedence
 	 */
+	if (!ignore_skip_worktree && ce_skip_worktree(ce))
+		return 0;
 	if (!ignore_valid && (ce->ce_flags & CE_VALID))
 		return 0;
=20
@@ -564,7 +569,7 @@ int add_to_index(struct index_state *istate, const =
char *path, struct stat *st,
 	int size, namelen, was_same;
 	mode_t st_mode =3D st->st_mode;
 	struct cache_entry *ce, *alias;
-	unsigned ce_option =3D CE_MATCH_IGNORE_VALID|CE_MATCH_RACY_IS_DIRTY;
+	unsigned ce_option =3D CE_MATCH_IGNORE_VALID|CE_MATCH_IGNORE_SKIP_WOR=
KTREE|CE_MATCH_RACY_IS_DIRTY;
 	int verbose =3D flags & (ADD_CACHE_VERBOSE | ADD_CACHE_PRETEND);
 	int pretend =3D flags & ADD_CACHE_PRETEND;
 	int intent_only =3D flags & ADD_CACHE_INTENT;
@@ -1000,14 +1005,20 @@ static struct cache_entry *refresh_cache_ent(st=
ruct index_state *istate,
 	struct cache_entry *updated;
 	int changed, size;
 	int ignore_valid =3D options & CE_MATCH_IGNORE_VALID;
+	int ignore_skip_worktree =3D options & CE_MATCH_IGNORE_SKIP_WORKTREE;
=20
 	if (ce_uptodate(ce))
 		return ce;
=20
 	/*
-	 * CE_VALID means the user promised us that the change to
-	 * the work tree does not matter and told us not to worry.
+	 * CE_VALID or CE_SKIP_WORKTREE means the user promised us
+	 * that the change to the work tree does not matter and told
+	 * us not to worry.
 	 */
+	if (!ignore_skip_worktree && ce_skip_worktree(ce)) {
+		ce_mark_uptodate(ce);
+		return ce;
+	}
 	if (!ignore_valid && (ce->ce_flags & CE_VALID)) {
 		ce_mark_uptodate(ce);
 		return ce;
diff --git a/unpack-trees.c b/unpack-trees.c
index 720f7a1..4870da9 100644
--- a/unpack-trees.c
+++ b/unpack-trees.c
@@ -454,7 +454,7 @@ static int verify_uptodate(struct cache_entry *ce,
 		return 0;
=20
 	if (!lstat(ce->name, &st)) {
-		unsigned changed =3D ie_match_stat(o->src_index, ce, &st, CE_MATCH_I=
GNORE_VALID);
+		unsigned changed =3D ie_match_stat(o->src_index, ce, &st, CE_MATCH_I=
GNORE_VALID|CE_MATCH_IGNORE_SKIP_WORKTREE);
 		if (!changed)
 			return 0;
 		/*
@@ -572,7 +572,7 @@ static int icase_exists(struct unpack_trees_options=
 *o, struct cache_entry *dst,
 	struct cache_entry *src;
=20
 	src =3D index_name_exists(o->src_index, dst->name, ce_namelen(dst), 1=
);
-	return src && !ie_match_stat(o->src_index, src, st, CE_MATCH_IGNORE_V=
ALID);
+	return src && !ie_match_stat(o->src_index, src, st, CE_MATCH_IGNORE_V=
ALID|CE_MATCH_IGNORE_SKIP_WORKTREE);
 }
=20
 /*
@@ -1007,7 +1007,7 @@ int oneway_merge(struct cache_entry **src, struct=
 unpack_trees_options *o)
 		if (o->reset && !ce_uptodate(old)) {
 			struct stat st;
 			if (lstat(old->name, &st) ||
-			    ie_match_stat(o->src_index, old, &st, CE_MATCH_IGNORE_VALID))
+			    ie_match_stat(o->src_index, old, &st, CE_MATCH_IGNORE_VALID|CE_=
MATCH_IGNORE_SKIP_WORKTREE))
 				update |=3D CE_UPDATE;
 		}
 		add_entry(o, old, update, 0);
--=20
1.6.5.2.216.g9c1ec
