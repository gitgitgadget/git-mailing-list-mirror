Received: from mout.web.de (mout.web.de [212.227.15.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A86D3F4129
	for <git@vger.kernel.org>; Wed, 13 May 2026 15:49:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778687355; cv=none; b=J7AsNjZ5745h2zftnN8bz37XHDZUIvF6DMvBzcjm9WT1t4i96TdjuPDmug63HZnh9mEc7vrf9BWjoOXevaSld5LPGGW51UYb2ksD2/Jm85jf2GNYcKP/ErmacvZ+/xvs35pIkB+Sy1TLP0eIDN94KdcvAcSnPN1JSqE267vkDGQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778687355; c=relaxed/simple;
	bh=RigD6VpxaiMigbH5qBln5ClGHkyPbMLQevPWIYpu6rM=;
	h=Message-ID:Date:MIME-Version:To:From:Subject:Content-Type; b=qIHJgkgGf/g6vp0dgXAq1+3JeauBbqTEIet7ENXsWTjGERsU4m1QnnSNfeYPNl0TpYaM9k3yHzynGnGvZZb+PDOvPpzsJwUS4cB4IHIz9Cxbjr5TSmkcXCQ9mRRNK+OJoNdB1qgIL/9IWINCMaNww5JmnoHl9T0gIVC7m+evavw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=l.s.r@web.de header.b=a48N98nX; arc=none smtp.client-ip=212.227.15.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=l.s.r@web.de header.b="a48N98nX"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1778687351; x=1779292151; i=l.s.r@web.de;
	bh=SeMWKCPYtBVYy+kLMCHUv4t3O/A9mzrbcRc+ltPvvgA=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:To:From:Subject:
	 Content-Type:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=a48N98nX7V+ZcyNlSnc+e5XVNhqulHKwmEIOY0DRcETMDX5LIzwHaNy96OGgbMnk
	 uh+EfGfzfo3Q8k0rBEY0/xO8RzynuO/ppcVty1+jJU+vUFADHSGngveCQS9qFlqlq
	 uwDuQov4fE/H3bPaWlWC2Hm15JZjeRl0EKpUzDGd2KNZJHwOZJuGiWUprcPo5v5cM
	 pr7PRy8W1RuFprhIPcWt/OUYGM3VGINpbytQE4aSn9q2mIrPsA0+sZA76ZMsKb2fG
	 UfAZRGqvS2TY6U+h6FYFy7Qfwrr6wSDV7U0L4Ej0SxURsKfDJJQnAcEh3NApbcKSO
	 iJAKt9KapvHIymFauA==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from client.hidden.invalid by smtp.web.de (mrweb006
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1MbkWQ-1wxtEH2bCY-00nVAe for
 <git@vger.kernel.org>; Wed, 13 May 2026 17:49:11 +0200
Message-ID: <183aa0fd-d455-4ec9-9c42-d511fac8b3e4@web.de>
Date: Wed, 13 May 2026 17:49:11 +0200
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: Git List <git@vger.kernel.org>
From: =?UTF-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>
Subject: [PATCH] hex: add and use strbuf_add_oid_hex()
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:q1j56+orCt48A99wqnD7sdKCVrgR+vcm5644wiA9jCR10dgkWZg
 2SnqYVvHwxb8kp8G26/WbnWyh2tt516AnitKp4BSpge/CdOm0qOuX7XxadtyrZ6vwN+4epM
 vKdXW6AxAtqrqABYQ9TmbK19cJc1TIgRJT+3AcLWxa6OHMYVgrIe/tAeaa1MeuPAn74v8hL
 R4enI2aY9wUg8xYtDj2/g==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:yLFNT1/OYQE=;14IeG0KLF9gLQ1oP/RQD40cI/q7
 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
 1yxkWX7+v/ZaRlvjGPG5xMtWrH+4t9SJw==

Add a function for adding the full hexadecimal hash value of an object
ID to a strbuf.  It's thread-safe and slightly more efficient than using
strbuf_addstr() with oid_to_hex() because it doesn't have to determine
the length of the string or copy it from the intermediate static buffer.

Add and apply a semantic patch to use it throughout the code base.

I get a tiny speedup for git log showing a single hash per commit:

Benchmark 1: ./git_main log --format=3D%H
  Time (mean =C2=B1 =CF=83):      91.2 ms =C2=B1   0.7 ms    [User: 51.9 m=
s, System: 38.6 ms]
  Range (min =E2=80=A6 max):    89.8 ms =E2=80=A6  92.6 ms    31 runs

Benchmark 2: ./git log --format=3D%H
  Time (mean =C2=B1 =CF=83):      90.5 ms =C2=B1   0.7 ms    [User: 51.0 m=
s, System: 38.8 ms]
  Range (min =E2=80=A6 max):    89.2 ms =E2=80=A6  92.3 ms    32 runs

Summary
  ./git log --format=3D%H ran
    1.01 =C2=B1 0.01 times faster than ./git_main log --format=3D%H

Signed-off-by: Ren=C3=A9 Scharfe <l.s.r@web.de>
=2D--
 bisect.c                      |  2 +-
 builtin/bisect.c              |  2 +-
 builtin/cat-file.c            |  5 ++---
 builtin/replace.c             |  2 +-
 convert.c                     |  2 +-
 fsck.c                        |  2 +-
 hex.c                         | 10 ++++++++++
 hex.h                         |  5 +++++
 pretty.c                      |  8 ++++----
 refs.c                        |  2 +-
 sequencer.c                   |  4 ++--
 shallow.c                     |  2 +-
 tools/coccinelle/strbuf.cocci |  6 ++++++
 transport-helper.c            |  2 +-
 14 files changed, 37 insertions(+), 17 deletions(-)

diff --git a/bisect.c b/bisect.c
index ef17a442e5..e67226a6dc 100644
=2D-- a/bisect.c
+++ b/bisect.c
@@ -512,7 +512,7 @@ static char *join_oid_array_hex(struct oid_array *arra=
y, char delim)
 	int i;
=20
 	for (i =3D 0; i < array->nr; i++) {
-		strbuf_addstr(&joined_hexs, oid_to_hex(array->oid + i));
+		strbuf_add_oid_hex(&joined_hexs, array->oid + i);
 		if (i + 1 < array->nr)
 			strbuf_addch(&joined_hexs, delim);
 	}
diff --git a/builtin/bisect.c b/builtin/bisect.c
index 4520e585d0..0f679e7af9 100644
=2D-- a/builtin/bisect.c
+++ b/builtin/bisect.c
@@ -833,7 +833,7 @@ static enum bisect_error bisect_start(struct bisect_te=
rms *terms, int argc,
 		if (!repo_get_oid(the_repository, head, &head_oid) &&
 		    !starts_with(head, "refs/heads/")) {
 			strbuf_reset(&start_head);
-			strbuf_addstr(&start_head, oid_to_hex(&head_oid));
+			strbuf_add_oid_hex(&start_head, &head_oid);
 		} else if (!repo_get_oid(the_repository, head, &head_oid) &&
 			   skip_prefix(head, "refs/heads/", &head)) {
 			strbuf_addstr(&start_head, head);
diff --git a/builtin/cat-file.c b/builtin/cat-file.c
index d9fbad5358..f015e5f415 100644
=2D-- a/builtin/cat-file.c
+++ b/builtin/cat-file.c
@@ -320,7 +320,7 @@ static int expand_atom(struct strbuf *sb, const char *=
atom, int len,
 {
 	if (is_atom("objectname", atom, len)) {
 		if (!data->mark_query)
-			strbuf_addstr(sb, oid_to_hex(&data->oid));
+			strbuf_add_oid_hex(sb, &data->oid);
 	} else if (is_atom("objecttype", atom, len)) {
 		if (data->mark_query)
 			data->info.typep =3D &data->type;
@@ -345,8 +345,7 @@ static int expand_atom(struct strbuf *sb, const char *=
atom, int len,
 		if (data->mark_query)
 			data->info.delta_base_oid =3D &data->delta_base_oid;
 		else
-			strbuf_addstr(sb,
-				      oid_to_hex(&data->delta_base_oid));
+			strbuf_add_oid_hex(sb, &data->delta_base_oid);
 	} else if (is_atom("objectmode", atom, len)) {
 		if (!data->mark_query && !(S_IFINVALID =3D=3D data->mode))
 			strbuf_addf(sb, "%06o", data->mode);
diff --git a/builtin/replace.c b/builtin/replace.c
index 4c62c5ab58..aed6b2c8de 100644
=2D-- a/builtin/replace.c
+++ b/builtin/replace.c
@@ -127,7 +127,7 @@ static int for_each_replace_name(const char **argv, ea=
ch_replace_name_fn fn)
 		}
=20
 		strbuf_setlen(&ref, base_len);
-		strbuf_addstr(&ref, oid_to_hex(&oid));
+		strbuf_add_oid_hex(&ref, &oid);
 		full_hex =3D ref.buf + base_len;
=20
 		if (refs_read_ref(get_main_ref_store(the_repository), ref.buf, &oid)) {
diff --git a/convert.c b/convert.c
index eae36c8a59..036506842c 100644
=2D-- a/convert.c
+++ b/convert.c
@@ -1239,7 +1239,7 @@ static int ident_to_worktree(const char *src, size_t=
 len,
=20
 		/* step 4: substitute */
 		strbuf_addstr(buf, "Id: ");
-		strbuf_addstr(buf, oid_to_hex(&oid));
+		strbuf_add_oid_hex(buf, &oid);
 		strbuf_addstr(buf, " $");
 	}
 	strbuf_add(buf, src, len);
diff --git a/fsck.c b/fsck.c
index b72200c352..b4ffee6a04 100644
=2D-- a/fsck.c
+++ b/fsck.c
@@ -344,7 +344,7 @@ const char *fsck_describe_object(struct fsck_options *=
options,
 	buf =3D bufs + b;
 	b =3D (b + 1) % ARRAY_SIZE(bufs);
 	strbuf_reset(buf);
-	strbuf_addstr(buf, oid_to_hex(oid));
+	strbuf_add_oid_hex(buf, oid);
 	if (name)
 		strbuf_addf(buf, " (%s)", name);
=20
diff --git a/hex.c b/hex.c
index bc756722ca..f02832140d 100644
=2D-- a/hex.c
+++ b/hex.c
@@ -3,6 +3,7 @@
 #include "git-compat-util.h"
 #include "hash.h"
 #include "hex.h"
+#include "strbuf.h"
=20
 static int get_hash_hex_algop(const char *hex, unsigned char *hash,
 			      const struct git_hash_algo *algop)
@@ -122,3 +123,12 @@ char *oid_to_hex(const struct object_id *oid)
 {
 	return hash_to_hex_algop(oid->hash, &hash_algos[oid->algo]);
 }
+
+void strbuf_add_oid_hex(struct strbuf *sb, const struct object_id *oid)
+{
+	const struct git_hash_algo *algop =3D oid->algo ?
+		&hash_algos[oid->algo] : the_hash_algo;
+	strbuf_grow(sb, algop->hexsz);
+	hash_to_hex_algop_r(sb->buf + sb->len, oid->hash, algop);
+	strbuf_setlen(sb, sb->len + algop->hexsz);
+}
diff --git a/hex.h b/hex.h
index 1e9a65d83a..f15c7e2220 100644
=2D-- a/hex.h
+++ b/hex.h
@@ -33,6 +33,11 @@ char *oid_to_hex_r(char *out, const struct object_id *o=
id);
 char *hash_to_hex_algop(const unsigned char *hash, const struct git_hash_=
algo *);	/* static buffer result! */
 char *oid_to_hex(const struct object_id *oid);						/* same static buffer=
 */
=20
+struct strbuf;
+
+/* Apply oid_to_hex_r() to a strbuf to append the hexadecimal hash. */
+void strbuf_add_oid_hex(struct strbuf *sb, const struct object_id *oid);
+
 /*
  * Parse a 40-character hexadecimal object ID starting from hex, updating=
 the
  * pointer specified by end when parsing stops.  The resulting object ID =
is
diff --git a/pretty.c b/pretty.c
index 814803980b..2684223946 100644
=2D-- a/pretty.c
+++ b/pretty.c
@@ -662,7 +662,7 @@ static void add_merge_info(const struct pretty_print_c=
ontext *pp,
 		if (pp->abbrev)
 			strbuf_add_unique_abbrev(sb, oidp, pp->abbrev);
 		else
-			strbuf_addstr(sb, oid_to_hex(oidp));
+			strbuf_add_oid_hex(sb, oidp);
 		parent =3D parent->next;
 	}
 	strbuf_addch(sb, '\n');
@@ -1567,7 +1567,7 @@ static size_t format_commit_one(struct strbuf *sb, /=
* in UTF-8 */
 	switch (placeholder[0]) {
 	case 'H':		/* commit hash */
 		strbuf_addstr(sb, diff_get_color(c->auto_color, DIFF_COMMIT));
-		strbuf_addstr(sb, oid_to_hex(&commit->object.oid));
+		strbuf_add_oid_hex(sb, &commit->object.oid);
 		strbuf_addstr(sb, diff_get_color(c->auto_color, DIFF_RESET));
 		return 1;
 	case 'h':		/* abbreviated commit hash */
@@ -1577,7 +1577,7 @@ static size_t format_commit_one(struct strbuf *sb, /=
* in UTF-8 */
 		strbuf_addstr(sb, diff_get_color(c->auto_color, DIFF_RESET));
 		return 1;
 	case 'T':		/* tree hash */
-		strbuf_addstr(sb, oid_to_hex(get_commit_tree_oid(commit)));
+		strbuf_add_oid_hex(sb, get_commit_tree_oid(commit));
 		return 1;
 	case 't':		/* abbreviated tree hash */
 		strbuf_add_unique_abbrev(sb,
@@ -1588,7 +1588,7 @@ static size_t format_commit_one(struct strbuf *sb, /=
* in UTF-8 */
 		for (p =3D commit->parents; p; p =3D p->next) {
 			if (p !=3D commit->parents)
 				strbuf_addch(sb, ' ');
-			strbuf_addstr(sb, oid_to_hex(&p->item->object.oid));
+			strbuf_add_oid_hex(sb, &p->item->object.oid);
 		}
 		return 1;
 	case 'p':		/* abbreviated parent hashes */
diff --git a/refs.c b/refs.c
index 844785219d..ee92f18d41 100644
=2D-- a/refs.c
+++ b/refs.c
@@ -2498,7 +2498,7 @@ int refs_update_symref_extended(struct ref_store *re=
fs, const char *ref,
 	if (referent && refs_read_symbolic_ref(refs, ref, referent) =3D=3D NOT_A=
_SYMREF) {
 		struct object_id oid;
 		if (!refs_read_ref(refs, ref, &oid)) {
-			strbuf_addstr(referent, oid_to_hex(&oid));
+			strbuf_add_oid_hex(referent, &oid);
 			ret =3D NOT_A_SYMREF;
 		}
 	}
diff --git a/sequencer.c b/sequencer.c
index b7d8dca47f..b4df04b672 100644
=2D-- a/sequencer.c
+++ b/sequencer.c
@@ -2223,7 +2223,7 @@ static void refer_to_commit(struct repository *r, st=
ruct strbuf *msgbuf,
 		repo_format_commit_message(r, commit,
 					   "%h (%s, %ad)", msgbuf, &ctx);
 	} else {
-		strbuf_addstr(msgbuf, oid_to_hex(&commit->object.oid));
+		strbuf_add_oid_hex(msgbuf, &commit->object.oid);
 	}
 }
=20
@@ -2395,7 +2395,7 @@ static int do_pick_commit(struct repository *r,
 			if (!has_conforming_footer(&ctx->message, NULL, 0))
 				strbuf_addch(&ctx->message, '\n');
 			strbuf_addstr(&ctx->message, cherry_picked_prefix);
-			strbuf_addstr(&ctx->message, oid_to_hex(&commit->object.oid));
+			strbuf_add_oid_hex(&ctx->message, &commit->object.oid);
 			strbuf_addstr(&ctx->message, ")\n");
 		}
 		if (!is_fixup(command))
diff --git a/shallow.c b/shallow.c
index a8ad92e303..b4b4e2e32a 100644
=2D-- a/shallow.c
+++ b/shallow.c
@@ -395,7 +395,7 @@ static int write_shallow_commits_1(struct strbuf *out,=
 int use_pack_protocol,
 	if (!extra)
 		return data.count;
 	for (size_t i =3D 0; i < extra->nr; i++) {
-		strbuf_addstr(out, oid_to_hex(extra->oid + i));
+		strbuf_add_oid_hex(out, extra->oid + i);
 		strbuf_addch(out, '\n');
 		data.count++;
 	}
diff --git a/tools/coccinelle/strbuf.cocci b/tools/coccinelle/strbuf.cocci
index f586128329..667903d1d4 100644
=2D-- a/tools/coccinelle/strbuf.cocci
+++ b/tools/coccinelle/strbuf.cocci
@@ -78,3 +78,9 @@ struct strbuf SB;
 @@
 - SB.buf ? SB.buf : ""
 + SB.buf
+
+@@
+expression SB, OID;
+@@
+- strbuf_addstr(SB, oid_to_hex(OID))
++ strbuf_add_oid_hex(SB, OID)
diff --git a/transport-helper.c b/transport-helper.c
index 4614036c99..4a54769789 100644
=2D-- a/transport-helper.c
+++ b/transport-helper.c
@@ -1051,7 +1051,7 @@ static int push_refs_with_push(struct transport *tra=
nsport,
 			if (ref->peer_ref)
 				strbuf_addstr(&buf, ref->peer_ref->name);
 			else
-				strbuf_addstr(&buf, oid_to_hex(&ref->new_oid));
+				strbuf_add_oid_hex(&buf, &ref->new_oid);
 		}
 		strbuf_addch(&buf, ':');
 		strbuf_addstr(&buf, ref->name);
=2D-=20
2.54.0
