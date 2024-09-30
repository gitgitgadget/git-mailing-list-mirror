Received: from aib29agh124.zrh1.oracleemaildelivery.com (aib29agh124.zrh1.oracleemaildelivery.com [192.29.178.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F447185B74
	for <git@vger.kernel.org>; Mon, 30 Sep 2024 22:24:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.29.178.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727735047; cv=none; b=dgGM6KtCG42drYEF0GlyA8l+phTHAToBIvda/vpNsOhM/kkZc8TsAbQuMmGCqZrvg3GqxAxudqpaH4mNmrlasr1etuBliSQtuJc3/mkhWAn2XqDn1+AXdWB+a9zwBu+/w0fdd85UVDpVJo9k6PA7HupWJkA6coAvIcqFiVBtA0w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727735047; c=relaxed/simple;
	bh=wHzc577Rhf0HaNdAF+tZkN2qqaTzVqgo+VadjMDfxnU=;
	h=From:To:Cc:Subject:Date:Message-id:In-reply-to:References:
	 MIME-version; b=nu5FYyRHPsOUM029JBZc+M+65Ovp/CGpESLjZ3pq/acdf9H+WRT/IlQ0jSGconxMCvWlA1VFrg4Up9hFvVgriWOyjOLxK3ug9oFJBtprzovNmX/b8SdomalmnyQT2Ge3Sqle6JTvkFzt8rM8h4pAz4Nly3ohrz90zmj8vbW8Uic=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=ferdinandy.com; spf=pass smtp.mailfrom=zrh1.rp.oracleemaildelivery.com; dkim=pass (2048-bit key) header.d=zrh1.rp.oracleemaildelivery.com header.i=@zrh1.rp.oracleemaildelivery.com header.b=V+wrGhGT; arc=none smtp.client-ip=192.29.178.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=ferdinandy.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zrh1.rp.oracleemaildelivery.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=zrh1.rp.oracleemaildelivery.com header.i=@zrh1.rp.oracleemaildelivery.com header.b="V+wrGhGT"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; s=prod-zrh-20200406;
 d=zrh1.rp.oracleemaildelivery.com;
 h=Date:To:From:Subject:Message-Id:MIME-Version:Sender:List-Unsubscribe:List-Unsubscribe-Post;
 bh=DMl/MXN+52ljcRsXWcpgZZ1JRwXdwgm/eWpEyvA7YP0=;
 b=V+wrGhGTTqLQKZESSEhuBO/77eMJRLDgO4BDqwum0JoCTpgeRsHVbzR1gthMZ4yW2qlm3QXIVVFW
   yDrNrfzMrYbgUjQDnhzhtd27M2gqlaVeGv0S12qGETXL8roMUYcydh0FHQRPXBWEmhLBOpw+G2FK
   vB5mulbcsjxtFLxc3PoQKs6Rg84zKX+DK6EAMsY0zVbplJKJOkEF6+3NvCLbyDAu/npubAjXifRr
   zwvUcI92jXjF1EW6SVBG1DOicVx7fwJ0pKb9jl9eDTppMG6WZVIaZ/bDQ4CkBy/g5FFHkBbDXbuP
   Pf9fsrC16V1GazYFuHz7eYkNBndGG6sP0oCFfw==
Received: by omta-ad1-fd2-401-eu-zurich-1.omtaad1.vcndpzrh.oraclevcn.com
 (Oracle Communications Messaging Server 8.1.0.1.20240911 64bit (built Sep 11
 2024))
 with ESMTPS id <0SKN003EOCW3CN50@omta-ad1-fd2-401-eu-zurich-1.omtaad1.vcndpzrh.oraclevcn.com> for
 git@vger.kernel.org; Mon, 30 Sep 2024 22:24:03 +0000 (GMT)
List-Unsubscribe-Post: List-Unsubscribe=One-Click
From: Bence Ferdinandy <bence@ferdinandy.com>
To: git@vger.kernel.org
Cc: phillip.wood@dunelm.org.uk,	Junio C Hamano <gitster@pobox.com>,
	Taylor Blau <me@ttaylorr.com>,	=?UTF-8?q?Ren=C3=A9=20Scharfe?= <l.s.r@web.de>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Bence Ferdinandy <bence@ferdinandy.com>
Subject: [PATCH v4 5/5] fetch: set remote/HEAD if it does not exist
Date: Tue,  1 Oct 2024 00:19:55 +0200
Message-id: <20240930222025.2349008-6-bence@ferdinandy.com>
In-reply-to: <20240930222025.2349008-1-bence@ferdinandy.com>
References: <D4JIG4VS5WVN.2F0PNU5514UEL@ferdinandy.com>
 <20240930222025.2349008-1-bence@ferdinandy.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-version: 1.0
Content-transfer-encoding: 8bit
Reporting-Meta:
 AAHyeI1GC1WEq4rT6PdihqO8P/mfN0dkRFH643wIUILRJE9M1SidZS4CDd3XE2nQ
 kt2nhmTIBMHS8zWb9GOqjObAD0bgyHTbzQ64cJ4He+VWVge9fsMzeX+Y+64vm3y2
 WptheT54L/rb7Py5Bv2TqSuD0TMVbhWqf4WQHEHLPsOKgTpsFkbSLql5JmfEwwxQ
 xf+u9Qfv7rQjSCTDAMhUNfqs3vUhIM5Wm/FwdbLX14EkxOoqt+e2fyXftVgxx2E9
 W1lUNkC8So8xo+5MhtleOlCKtkDcMx+y+t1FEpgV1Fj9gm5XhydY236/i3TGVF9E
 YAjcnq7f7XUgQs6ZRU9kbtJHs0KukEVShbvHOuZFKcwGpDDEENCeSppwJA99GGy4
 e2KXnY7iG9DWE11TUzJNjZjNxKR6s5HPXxA7bhvn9hisRykbi1X7EOtWrvAtef35
 ReqYXn7BGYUvo1ZHgcum+CUymoXmnw19p1UFWDWhEd2J3+Kz9U44VHE3

If the user has remote/HEAD set already and it looks like it has changed
on the server, then print a message, otherwise set it if we can.
Silently pass if the user already has the same remote/HEAD set as
reported by the server.

Signed-off-by: Bence Ferdinandy <bence@ferdinandy.com>
---

Notes:
    v3: - does not rely on remote set-head anymore so it only authenticates
        once
        - uses the new REF_CREATE_ONLY to atomically check if the ref exists
          and only write it if it doesn't
        - in all other cases the maximum it does is print a warning
    
    v4: - instead of the discarded REF_CREATE_ONLY, it uses the existing,
          but updated transaction api to request a silent create only
        - it now uses the atomic before_target to determine reporting
        - refactored for legibility

 builtin/fetch.c           | 83 +++++++++++++++++++++++++++++++++++++++
 t/t5514-fetch-multiple.sh |  9 +++++
 2 files changed, 92 insertions(+)

diff --git a/builtin/fetch.c b/builtin/fetch.c
index c900f57721..f10a9d5371 100644
--- a/builtin/fetch.c
+++ b/builtin/fetch.c
@@ -1577,6 +1577,82 @@ static int backfill_tags(struct display_state *display_state,
 	return retcode;
 }
 
+static void report_set_head(const char *remote, const char *head_name,
+			struct strbuf *buf_prev) {
+	struct strbuf buf_prefix = STRBUF_INIT;
+	const char *prev_head;
+
+	strbuf_addf(&buf_prefix, "refs/remotes/%s/", remote);
+	skip_prefix(buf_prev->buf, buf_prefix.buf, &prev_head);
+
+	if (prev_head && !strcmp(prev_head, head_name))
+		;
+	else if (prev_head) {
+		printf("'HEAD' at '%s' has changed from '%s' to '%s'\n",
+			remote, prev_head, head_name);
+		printf("Run 'git remote set-head %s %s' to follow the change.\n",
+			remote, head_name);
+	}
+}
+
+static const char *strip_refshead(const char *name){
+	skip_prefix(name, "refs/heads/", &name);
+	return name;
+}
+
+static int set_head(const struct ref *remote_refs)
+{
+	int result = 0;
+	struct strbuf b_head = STRBUF_INIT, b_remote_head = STRBUF_INIT,
+		b_local_head = STRBUF_INIT;
+	const char *remote = gtransport->remote->name;
+	char *head_name = NULL;
+	struct ref *ref, *matches;
+	struct ref *fetch_map = NULL, **fetch_map_tail = &fetch_map;
+	struct refspec_item refspec = {
+		.force = 0,
+		.pattern = 1,
+		.src = (char *) "refs/heads/*",
+		.dst = (char *) "refs/heads/*",
+	};
+	struct string_list heads = STRING_LIST_INIT_DUP;
+	struct ref_store *refs = get_main_ref_store(the_repository);
+
+	get_fetch_map(remote_refs, &refspec, &fetch_map_tail, 0);
+	matches = guess_remote_head(find_ref_by_name(remote_refs, "HEAD"),
+				    fetch_map, 1);
+	for (ref = matches; ref; ref = ref->next) {
+		string_list_append(&heads, strip_refshead(ref->name));
+	}
+
+
+	if (!heads.nr)
+		result = 1;
+	else if (heads.nr > 1) {
+		result = 1;
+	} else
+		head_name = xstrdup(heads.items[0].string);
+	if (head_name) {
+		strbuf_addf(&b_head, "refs/remotes/%s/HEAD", remote);
+		strbuf_addf(&b_remote_head, "refs/remotes/%s/%s", remote, head_name);
+		/* make sure it's valid */
+		if (!refs_ref_exists(refs, b_remote_head.buf))
+			result |= error(_("Not a valid ref: %s"), b_remote_head.buf);
+		else if (refs_update_symref(refs, b_head.buf, b_remote_head.buf,
+					"remote set-head", &b_local_head, true))
+			result |= error(_("Could not setup %s"), b_head.buf);
+		else {
+			report_set_head(remote, head_name, &b_local_head);
+		}
+		free(head_name);
+	}
+
+	strbuf_release(&b_head);
+	strbuf_release(&b_local_head);
+	strbuf_release(&b_remote_head);
+	return result;
+}
+
 static int do_fetch(struct transport *transport,
 		    struct refspec *rs,
 		    const struct fetch_config *config)
@@ -1646,6 +1722,8 @@ static int do_fetch(struct transport *transport,
 				    "refs/tags/");
 	}
 
+	strvec_push(&transport_ls_refs_options.ref_prefixes,"HEAD");
+
 	if (must_list_refs) {
 		trace2_region_enter("fetch", "remote_refs", the_repository);
 		remote_refs = transport_get_remote_refs(transport,
@@ -1790,6 +1868,10 @@ static int do_fetch(struct transport *transport,
 				  "you need to specify exactly one branch with the --set-upstream option"));
 		}
 	}
+	if (set_head(remote_refs))
+		printf("Ran into issues with creating \'%s/HEAD\',\n"
+			"use \'git remote set-head -a %s\' to investigate.\n",
+			gtransport->remote->name,gtransport->remote->name);
 
 cleanup:
 	if (retcode) {
@@ -2020,6 +2102,7 @@ static int fetch_multiple(struct string_list *list, int max_children,
 	return !!result;
 }
 
+
 /*
  * Fetching from the promisor remote should use the given filter-spec
  * or inherit the default filter-spec from the config.
diff --git a/t/t5514-fetch-multiple.sh b/t/t5514-fetch-multiple.sh
index 579872c258..ef5874b7b3 100755
--- a/t/t5514-fetch-multiple.sh
+++ b/t/t5514-fetch-multiple.sh
@@ -45,14 +45,17 @@ test_expect_success setup '
 '
 
 cat > test/expect << EOF
+  one/HEAD -> one/main
   one/main
   one/side
   origin/HEAD -> origin/main
   origin/main
   origin/side
+  three/HEAD -> three/main
   three/another
   three/main
   three/side
+  two/HEAD -> two/main
   two/another
   two/main
   two/side
@@ -97,6 +100,7 @@ cat > expect << EOF
   origin/HEAD -> origin/main
   origin/main
   origin/side
+  three/HEAD -> three/main
   three/another
   three/main
   three/side
@@ -112,8 +116,10 @@ test_expect_success 'git fetch --multiple (but only one remote)' '
 '
 
 cat > expect << EOF
+  one/HEAD -> one/main
   one/main
   one/side
+  two/HEAD -> two/main
   two/another
   two/main
   two/side
@@ -221,14 +227,17 @@ test_expect_success 'git fetch --multiple --jobs=0 picks a default' '
 
 create_fetch_all_expect () {
 	cat >expect <<-\EOF
+	  one/HEAD -> one/main
 	  one/main
 	  one/side
 	  origin/HEAD -> origin/main
 	  origin/main
 	  origin/side
+	  three/HEAD -> three/main
 	  three/another
 	  three/main
 	  three/side
+	  two/HEAD -> two/main
 	  two/another
 	  two/main
 	  two/side
-- 
2.47.0.rc0.5.gf1cffeb8df.dirty

