Received: from mout.web.de (mout.web.de [217.72.192.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D9B335E1A3
	for <git@vger.kernel.org>; Sat, 25 Jul 2026 10:41:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.72.192.78
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784976079; cv=none; b=pyqSuGT7O4xbeLnExYiR1DNTBHj5H8rvCbwgdYc02sXDi5HpMW/eXtPUm5zHd0ese4//Xg+27bX+o4BHOWJAbddx0PRXYWueEAreeEmhMxh9OP88uq4q5b+ffB3S8HrV/pCAQNXDqrj7+inRFuScvzdCfcHZHgLTWyKNFfQX9t0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784976079; c=relaxed/simple;
	bh=Th0WelLugQG96C2DKwVGmhgzUEuZLCZT8FJ3jqm7gsM=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=AeZV38M40Wa3FrOOemZ17tNhp/ahdbAm/4PJWpocVnfipJAdfd82MZPco/gikzFiD5lwjJxoNuEo1RYP448gpb6EWq6s4RbWZVAooQ02HVpear2YV+EWLKN3n4/lxLNccGVa1vXxN3xKRf7OvkLy/xzY5lO40cuSxkhwzn+bLfg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=l.s.r@web.de header.b=F3oCsiIz; arc=none smtp.client-ip=217.72.192.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=l.s.r@web.de header.b="F3oCsiIz"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1784976068; x=1785580868; i=l.s.r@web.de;
	bh=jT2iFZji+Q0EPHJ7q4qkIxpq/f7yBiCw0RA1Kj11tIY=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:From:To:
	 Cc:References:In-Reply-To:Content-Type:Content-Transfer-Encoding:
	 cc:content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=F3oCsiIzqFdgv8GKQ8i2ddKCZdmdPqRgqZSmm6QPw5TVfU8CCJCz8p4ml39QIE07
	 4azmZJyfB/I3EOXhlJiJnug+8F9uBy11m8n9RUYIg00Rex9dac7J/ZJXbX5SLdY7w
	 y0XNGlWuymV0P9OTVtrSGgY/w3GRCWTwuPEnPdlXJJa0gwY+ru+Ul+qoneIG3BORh
	 ptPlK7IP10/YaGFd1LdLSL6AIOjQ61McUzxl+6JYNRpWqv9dMWgbqlUt5+jXGHqqW
	 xDnsQOPDmfV4H4C5+GG0v2MW2GD+v0P7ex3Kvs5z9XFbEJUB4nA7Mx6HOpb/rLG1r
	 O1+NCd9chbpcGevO6Q==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from client.hidden.invalid by smtp.web.de (mrweb105
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1N4627-1wwcK50zKL-00tdGA; Sat, 25
 Jul 2026 12:41:08 +0200
Message-ID: <590382fb-731b-4e14-911e-ff68356d1082@web.de>
Date: Sat, 25 Jul 2026 12:41:07 +0200
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: [PATCH v2] branch: report active bisect run when rejecting delete
From: =?UTF-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>
To: Git List <git@vger.kernel.org>
Cc: stsp <stsp2@yandex.ru>, Phillip Wood <phillip.wood@dunelm.org.uk>,
 Junio C Hamano <gitster@pobox.com>
References: <9865fc6b-e3fe-4614-9ffe-71af776e1796@web.de>
Content-Language: en-US
In-Reply-To: <9865fc6b-e3fe-4614-9ffe-71af776e1796@web.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:1Waqn8PUD4ElNFpwGKh/et26VR85bL/MNR3zGCU1jibSaffNDmG
 q/XL2g3MWLg6sF7zQuee/uch9NImbuVVopJKQE8ic1V3SLnZpG/XluxBSpvjdTDVAZYOeTA
 zOEX9HjIYlLWoWC4aRlP3Rk61Wf2QzNVNDVSexs1hZ6XRDUEfte/W/7vwFOCvHt+lubQJ5Y
 B3lpbL+uUy7im8kAQUpew==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:9GieHgx85DY=;JtoZ/u+in8zXLLjQEWPI4fMqwF2
 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
 XzNaaXFyaxn/

git branch refuses to delete branches that are currently checked out
with a message like this: "error: cannot delete branch 'foo' used by
worktree at '/path/of/worktree'".  This can be confusing if it's an
internal checkout for git bisect.  Report a more specific error in
that case to help users that might have forgotten their bisect run.

Suggested-by: stsp <stsp2@yandex.ru>
Signed-off-by: Ren=C3=A9 Scharfe <l.s.r@web.de>
=2D--
Changes since v2:
- Only report bisect runs as specific rejection reason for now.
- Leave rebasing unaddressed because I don't see how to formulate
  clear and readable messages for those scenarios, yet.
- Collect all checkout reasons of all branches in a simple array for
  easy use, e.g. to eventually address rebases or for git status.
- Rebased onto the landed test_grep conversion.

 branch.c          | 80 +++++++++++++++++++++++++++++++++--------------
 branch.h          |  6 ++++
 builtin/branch.c  |  7 +++++
 t/t3200-branch.sh |  4 +--
 4 files changed, 72 insertions(+), 25 deletions(-)

diff --git a/branch.c b/branch.c
index 243db7d0fc..a9fc790818 100644
=2D-- a/branch.c
+++ b/branch.c
@@ -385,6 +385,39 @@ int validate_branchname(const char *name, struct strb=
uf *ref)
 static int initialized_checked_out_branches;
 static struct strmap current_checked_out_branches =3D STRMAP_INIT;
=20
+enum branch_checkout_kind {
+	BRANCH_CHECKOUT_KIND_CHECKOUT,
+	BRANCH_CHECKOUT_KIND_REBASE,
+	BRANCH_CHECKOUT_KIND_BISECT,
+	BRANCH_CHECKOUT_KIND_UPDATE_REF,
+};
+
+struct checked_out_branch {
+	char *refname;
+	char *path;
+	enum branch_checkout_kind kind;
+};
+
+static struct checked_out_branch *checked_out_branches;
+static size_t checked_out_branches_alloc, checked_out_branches_nr;
+
+static void register_checked_out_branch(const char *prefix, const char *n=
ame,
+					const char *path,
+					enum branch_checkout_kind kind)
+{
+	char *refname =3D xstrfmt("%s%s", prefix, name);
+	char *path_copy =3D xstrdup(path);
+
+	ALLOC_GROW(checked_out_branches, checked_out_branches_nr + 1,
+		   checked_out_branches_alloc);
+	checked_out_branches[checked_out_branches_nr].refname =3D refname;
+	checked_out_branches[checked_out_branches_nr].path =3D path_copy;
+	checked_out_branches[checked_out_branches_nr].kind =3D kind;
+	checked_out_branches_nr++;
+
+	strmap_put(&current_checked_out_branches, refname, path_copy);
+}
+
 static void prepare_checked_out_branches(void)
 {
 	int i =3D 0;
@@ -397,7 +430,7 @@ static void prepare_checked_out_branches(void)
 	worktrees =3D get_worktrees();
=20
 	while (worktrees[i]) {
-		char *old, *wt_gitdir;
+		char *wt_gitdir;
 		struct wt_status_state state =3D { 0 };
 		struct worktree *wt =3D worktrees[i++];
 		struct string_list update_refs =3D STRING_LIST_INIT_DUP;
@@ -406,34 +439,25 @@ static void prepare_checked_out_branches(void)
 			continue;
=20
 		if (wt->head_ref) {
-			old =3D strmap_put(&current_checked_out_branches,
-					 wt->head_ref,
-					 xstrdup(wt->path));
-			free(old);
+			register_checked_out_branch("", wt->head_ref, wt->path,
+						    BRANCH_CHECKOUT_KIND_CHECKOUT);
 		}
=20
 		if (wt_status_check_rebase(wt, &state) &&
 		    (state.rebase_in_progress || state.rebase_interactive_in_progress) =
&&
 		    state.branch) {
-			struct strbuf ref =3D STRBUF_INIT;
-			strbuf_addf(&ref, "refs/heads/%s", state.branch);
-			old =3D strmap_put(&current_checked_out_branches,
-					 ref.buf,
-					 xstrdup(wt->path));
-			free(old);
-			strbuf_release(&ref);
+			register_checked_out_branch("refs/heads/", state.branch,
+						    wt->path,
+						    BRANCH_CHECKOUT_KIND_REBASE);
 		}
 		wt_status_state_free_buffers(&state);
=20
 		if (wt_status_check_bisect(wt, &state) &&
 		    state.bisecting_from) {
-			struct strbuf ref =3D STRBUF_INIT;
-			strbuf_addf(&ref, "refs/heads/%s", state.bisecting_from);
-			old =3D strmap_put(&current_checked_out_branches,
-					 ref.buf,
-					 xstrdup(wt->path));
-			free(old);
-			strbuf_release(&ref);
+			register_checked_out_branch("refs/heads/",
+						    state.bisecting_from,
+						    wt->path,
+						    BRANCH_CHECKOUT_KIND_BISECT);
 		}
 		wt_status_state_free_buffers(&state);
=20
@@ -442,10 +466,9 @@ static void prepare_checked_out_branches(void)
 						     &update_refs)) {
 			struct string_list_item *item;
 			for_each_string_list_item(item, &update_refs) {
-				old =3D strmap_put(&current_checked_out_branches,
-						 item->string,
-						 xstrdup(wt->path));
-				free(old);
+				register_checked_out_branch("", item->string,
+							    wt->path,
+							    BRANCH_CHECKOUT_KIND_UPDATE_REF);
 			}
 			string_list_clear(&update_refs, 1);
 		}
@@ -462,6 +485,17 @@ const char *branch_checked_out(const char *refname)
 	return strmap_get(&current_checked_out_branches, refname);
 }
=20
+const char *branch_bisecting(const char *refname)
+{
+	prepare_checked_out_branches();
+	for (size_t i =3D 0; i < checked_out_branches_nr; i++) {
+		if (!strcmp(refname, checked_out_branches[i].refname) &&
+		    checked_out_branches[i].kind =3D=3D BRANCH_CHECKOUT_KIND_BISECT)
+			return checked_out_branches[i].path;
+	}
+	return NULL;
+}
+
 /*
  * Check if a branch 'name' can be created as a new branch; die otherwise=
.
  * 'force' can be used when it is OK for the named branch already exists.
diff --git a/branch.h b/branch.h
index 3dc6e2a0ff..e9b1f7b37d 100644
=2D-- a/branch.h
+++ b/branch.h
@@ -106,6 +106,12 @@ void create_branches_recursively(struct repository *r=
, const char *name,
  */
 const char *branch_checked_out(const char *refname);
=20
+/*
+ * If the branch at 'refname' is currently used for bisecting in a
+ * worktree, then return the path to that worktree.
+ */
+const char *branch_bisecting(const char *refname);
+
 /*
  * Check if 'name' can be a valid name for a branch; die otherwise.
  * Return 1 if the named branch already exists; return 0 otherwise.
diff --git a/builtin/branch.c b/builtin/branch.c
index dede60d27b..29e4ec6c67 100644
=2D-- a/builtin/branch.c
+++ b/builtin/branch.c
@@ -265,6 +265,13 @@ static int delete_branches(int argc, const char **arg=
v, int force, int kinds,
=20
 		if (kinds =3D=3D FILTER_REFS_BRANCHES) {
 			const char *path;
+			if ((path =3D branch_bisecting(name))) {
+				error(_("cannot delete branch '%s' "
+					"used by worktree at '%s' for bisect"),
+					      bname.buf, path);
+				ret =3D 1;
+				continue;
+			}
 			if ((path =3D branch_checked_out(name))) {
 				error(_("cannot delete branch '%s' "
 					"used by worktree at '%s'"),
diff --git a/t/t3200-branch.sh b/t/t3200-branch.sh
index 1ecbafbee1..051434d9c6 100755
=2D-- a/t/t3200-branch.sh
+++ b/t/t3200-branch.sh
@@ -930,7 +930,7 @@ test_expect_success 'deleting currently checked out br=
anch fails' '
 	git worktree add -b my7 my7 &&
 	test_must_fail git -C my7 branch -d my7 &&
 	test_must_fail git branch -d my7 2>actual &&
-	test_grep "^error: cannot delete branch .my7. used by worktree at " actu=
al &&
+	test_grep "^error: cannot delete branch '"'"'my7'"'"' used by worktree a=
t '"'.*'\$"'" actual &&
 	rm -r my7 &&
 	git worktree prune
 '
@@ -941,7 +941,7 @@ test_expect_success 'deleting in-use branch fails' '
 	git -C my7 bisect start HEAD HEAD~2 &&
 	test_must_fail git -C my7 branch -d my7 &&
 	test_must_fail git branch -d my7 2>actual &&
-	test_grep "^error: cannot delete branch .my7. used by worktree at " actu=
al &&
+	test_grep "^error: cannot delete branch '"'"'my7'"'"' used by worktree a=
t '"'.*' for bisect\$"'" actual &&
 	rm -r my7 &&
 	git worktree prune
 '
=2D-=20
2.55.0
