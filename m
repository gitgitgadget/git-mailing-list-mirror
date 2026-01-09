Received: from mout.web.de (mout.web.de [212.227.17.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C25C221DB5
	for <git@vger.kernel.org>; Fri,  9 Jan 2026 21:30:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767994227; cv=none; b=t5jbWWf7E3UVKO2ASElCd0SndQ+O1UPy9rT/uEuN5ogh3dWtxvAl3EbSZIqEWcdABwVkCqa7zWS2f4sEY0ltK3vEigzpIAaG4KBFaQDGloont/gFxLwYDmNYdEfb+86mOLHolEut0B4/lBMjy1fzMvJprQ2acGCgPZCuww9gYKI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767994227; c=relaxed/simple;
	bh=Ewd4Yl630VIRh/ELIZUqWXmKo2IJgl9WxEosD/ohqFk=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=BssLDl5NVVPNuuYljdEu6eszwVwfFz7CjKqv976w6Ge/S07/PXxev3aO/pImYBkqCxEUFuAuvwzhe8kxmNozmGemygUngd5N1Fu2tdOonROa43mACJqW+gW0XvyscagmnLXWAgd0tPE7YkBZdAcFpQO10VXEFgzYnYGoL1sv7H4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=l.s.r@web.de header.b=OQxyHAbI; arc=none smtp.client-ip=212.227.17.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=l.s.r@web.de header.b="OQxyHAbI"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1767994223; x=1768599023; i=l.s.r@web.de;
	bh=FiGwdl9K1n+LzylmsH8IhKPm9e6mHk5T5Uf+bkOM6ng=;
	h=X-UI-Sender-Class:From:To:Subject:Date:Message-ID:In-Reply-To:
	 References:MIME-Version:Content-Type:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=OQxyHAbIgk1fIG0vbquRlFF/AwWAJSb3RewpMjam+Xz+algCRmbsbfp9332Uosr/
	 +c/lSIjVctgfHwHCWTK0jb4b7WnvEn6KvAFwax1KY5cJHoJDv0ObvXMediNEENMQF
	 0w7euRDr5sAUTj7ED1kprNiJj5mu6hyWOKbRajrxRdgW53m3nWIX30HgPY98DFbOK
	 xCaB0WP4MspEBqGNrTPFokt5dBRpMrPOOSK1jQQm/YTc9voh0EcEwMcKDe2KuyqYu
	 ItpHZUTK3sKIVVtIoN9Y5IkkYIMwVl5AW35+3Oz6u/rsAbBlj5cPVyCIquGyK1Kx+
	 PPRXIEXNcYc33+d4qA==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from Mini-von-Rene.speedport.ip ([79.203.19.215]) by smtp.web.de
 (mrweb106 [213.165.67.124]) with ESMTPSA (Nemesis) id
 1N9LIc-1vsdwp1PRE-00vl3U for <git@vger.kernel.org>; Fri, 09 Jan 2026 22:30:23
 +0100
From: =?UTF-8?q?Ren=C3=A9=20Scharfe?= <l.s.r@web.de>
To: git@vger.kernel.org
Subject: [PATCH 09/10] tree: stop using the_repository
Date: Fri,  9 Jan 2026 22:30:20 +0100
Message-ID: <20260109213021.2546-10-l.s.r@web.de>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260109213021.2546-1-l.s.r@web.de>
References: <20260109213021.2546-1-l.s.r@web.de>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:wqs1t4DzESL03ItfyzrAZzi5YX3YaUy6Lz+b2qQj26mj20BkbGp
 fpJ7z+yXhsvxtNijPf9Ppjy5yIn7iIbkVIX9KWunGctzIQB4yMD/tTObyK3A8XIN7zbCMVW
 yGxXFjk0mJShom9IquMVz50B1DB5sUkVEmYF2Az5V4Q8i2z9Zv1spfmeM4LPYUl8pG3X78D
 6/oN+BV3IH/3QjiYfWAxA==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:iu4QvxCeSPc=;h128vc0XWHGKAd8MYaUTDu2ZGL/
 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

Push the use of the_repository to the remaining callers by turning the
compatibility wrappers into macros, whose use still requires
USE_THE_REPOSITORY_VARIABLE to be defined.

Signed-off-by: Ren=C3=A9 Scharfe <l.s.r@web.de>
=2D--
 tree.c | 12 ------------
 tree.h |  9 +++------
 2 files changed, 3 insertions(+), 18 deletions(-)

diff --git a/tree.c b/tree.c
index edcf6a284cb..d703ab97c83 100644
=2D-- a/tree.c
+++ b/tree.c
@@ -1,5 +1,3 @@
-#define USE_THE_REPOSITORY_VARIABLE
-
 #include "git-compat-util.h"
 #include "hex.h"
 #include "tree.h"
@@ -185,11 +183,6 @@ int parse_tree_buffer(struct tree *item, void *buffer=
, unsigned long size)
 	return 0;
 }
=20
-int parse_tree_gently(struct tree *item, int quiet_on_missing)
-{
-	return repo_parse_tree_gently(the_repository, item, quiet_on_missing);
-}
-
 int repo_parse_tree_gently(struct repository *r, struct tree *item,
 			   int quiet_on_missing)
 {
@@ -219,11 +212,6 @@ void free_tree_buffer(struct tree *tree)
 	tree->object.parsed =3D 0;
 }
=20
-struct tree *parse_tree_indirect(const struct object_id *oid)
-{
-	return repo_parse_tree_indirect(the_repository, oid);
-}
-
 struct tree *repo_parse_tree_indirect(struct repository *r,
 				      const struct object_id *oid)
 {
diff --git a/tree.h b/tree.h
index 9037891d30f..677382eed86 100644
=2D-- a/tree.h
+++ b/tree.h
@@ -19,13 +19,10 @@ struct tree *lookup_tree(struct repository *r, const s=
truct object_id *oid);
=20
 int parse_tree_buffer(struct tree *item, void *buffer, unsigned long size=
);
=20
-int parse_tree_gently(struct tree *tree, int quiet_on_missing);
+#define parse_tree_gently(t, q) repo_parse_tree_gently(the_repository, t,=
 q)
 int repo_parse_tree_gently(struct repository *r, struct tree *item,
 			   int quiet_on_missing);
-static inline int parse_tree(struct tree *tree)
-{
-	return parse_tree_gently(tree, 0);
-}
+#define parse_tree(t) repo_parse_tree(the_repository, t)
 static inline int repo_parse_tree(struct repository *r, struct tree *item=
)
 {
 	return repo_parse_tree_gently(r, item, 0);
@@ -33,7 +30,7 @@ static inline int repo_parse_tree(struct repository *r, =
struct tree *item)
 void free_tree_buffer(struct tree *tree);
=20
 /* Parses and returns the tree in the given ent, chasing tags and commits=
. */
-struct tree *parse_tree_indirect(const struct object_id *oid);
+#define parse_tree_indirect(o) repo_parse_tree_indirect(the_repository, o=
)
 struct tree *repo_parse_tree_indirect(struct repository *r,
 				      const struct object_id *oid);
=20
=2D-=20
2.52.0

