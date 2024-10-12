Received: from aib29agh124.zrh1.oracleemaildelivery.com (aib29agh124.zrh1.oracleemaildelivery.com [192.29.178.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DC8E149C52
	for <git@vger.kernel.org>; Sat, 12 Oct 2024 23:15:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.29.178.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728774960; cv=none; b=lSUklKgXuwYJ3311SvQDSN2uy7XhdDsUgw4llwW+mBacckb7CtxBaKQhC9dZepna/FFHznRt8g7gVqPLfsvF4GiL46WmpxhWiN9HFhcrDmP5V/OmHkcpCo2cnWwJ2M/UJMnFJtL6fYTdfs/p5IRxNAml9Y1vY2iGBlqVjoLvAZg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728774960; c=relaxed/simple;
	bh=LJsVczIvaPgJzsgRDF60qghwIZFSrI9B/uASVQbLqao=;
	h=From:To:Cc:Subject:Date:Message-id:In-reply-to:References:
	 MIME-version; b=uL/2nxqW5r7+YRDc8pi3r4JSP/t9RbtThYf5zUjkj2E84a0V5U4Pq2yuoXjS8wkFjr9qdQ4ERJMlZKqpPTO+71it2sQMZjwRbwFLtBsvSr7ZzUe9X2RwGs/6zKLOXzpci0xFzW13GuTQYtWaEsAnAOWMqdS6Ue3Gnh7eKRB0Wsc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=ferdinandy.com; spf=pass smtp.mailfrom=zrh1.rp.oracleemaildelivery.com; dkim=pass (2048-bit key) header.d=zrh1.rp.oracleemaildelivery.com header.i=@zrh1.rp.oracleemaildelivery.com header.b=JRGVvVAF; arc=none smtp.client-ip=192.29.178.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=ferdinandy.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zrh1.rp.oracleemaildelivery.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=zrh1.rp.oracleemaildelivery.com header.i=@zrh1.rp.oracleemaildelivery.com header.b="JRGVvVAF"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; s=prod-zrh-20200406;
 d=zrh1.rp.oracleemaildelivery.com;
 h=Date:To:From:Subject:Message-Id:MIME-Version:Sender:List-Unsubscribe:List-Unsubscribe-Post;
 bh=NM1Yfw2gMe0ZCy3FY+8plMNY+If24i2o2YEPrO91yOQ=;
 b=JRGVvVAFC8NgXUTxskfjdjJtqA+8SnX9RkatXGfQlt/eiOCfSFbGruFJo6cuU2ikViGtGr2R9Jh7
   u9VTE6Gyw2Bep58mmLcG5MWHxpRP0CgyaH/ypz4iBauRnbT90gkHoZKrXT8dT1/3Z3NRdtI1V9Zf
   JR71hY/dRt4R8Ouypy5qoXCqUDmiNmGbgmh4efGifx8GZP89bbQTBQzw6IhJJLFIokZC89qthqHw
   SujY5sVE+FIyI6wp38yozZ6AQ0hxZPmlIM/o/TL16u79IjVmEE7bxRcpdEpILzEKfizvaSy+OBJI
   Bmu6ui9jkdDCRxVQIE5sl0bRcoHdOwsItzwpqw==
Received: by omta-ad1-fd2-401-eu-zurich-1.omtaad1.vcndpzrh.oraclevcn.com
 (Oracle Communications Messaging Server 8.1.0.1.20240911 64bit (built Sep 11
 2024))
 with ESMTPS id <0SL900FTPNAF1T30@omta-ad1-fd2-401-eu-zurich-1.omtaad1.vcndpzrh.oraclevcn.com> for
 git@vger.kernel.org; Sat, 12 Oct 2024 23:15:51 +0000 (GMT)
List-Unsubscribe-Post: List-Unsubscribe=One-Click
From: Bence Ferdinandy <bence@ferdinandy.com>
To: git@vger.kernel.org
Cc: phillip.wood@dunelm.org.uk,	Taylor Blau <me@ttaylorr.com>,
	=?UTF-8?q?Ren=C3=A9=20Scharfe?= <l.s.r@web.de>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Junio C Hamano <gitster@pobox.com>,	Bence Ferdinandy <bence@ferdinandy.com>
Subject: [PATCH v7 5/6] refs: add create_only option to refs_update_symref
Date: Sun, 13 Oct 2024 01:03:25 +0200
Message-id: <20241012230428.3259229-5-bence@ferdinandy.com>
In-reply-to: <20241012230428.3259229-1-bence@ferdinandy.com>
References: <20241010133022.1733542-1-bence@ferdinandy.com>
 <20241012230428.3259229-1-bence@ferdinandy.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-version: 1.0
Content-transfer-encoding: 8bit
Reporting-Meta:
 AAH5WjwJA9YJE1eMNxG4kucu7BjGwMzMiiZCwtQcLQfhQVT3cNAlp8pJlIUdzg4y
 sh3cOykRyQotKGSzVWDUhpHd3upg32zoUimycXuZEJyLnNFWNjh5WPcMAUYdQ34x
 4rwPh150K5GuHqBzGDeWn3z8vQDUga3EQ0cdCQoCVRJRTiq57+ecR2e0FACflr/e
 RXYulKvBpYkqN+y5FsbG/A1WdClaBQ+MErpVRux5AJ1WYvlWNSiza+km0oISyB1e
 uR7YfBMNfWt+jtX+BTo6Gw0RWD06J+GeqeeUT6KDOzXe+pAz0KAODVakfOHjykhU
 gXRyR2G7LIHwn51spuyoCrViStWpaWRXLBtFpIdyuKqAhQSMAx2NaYVyyaRHMwvM
 kyqXOMmX6u4HesVslnKzE3OC77MYYCBpSU6HCiQlflXa/ZpDrKlVuLUHGBE+jZDe
 gH5/mgf3rbSqDccmT39O0y5EBaCki5ON3vJb3z9gqToCCIB64Q8AFBNX

Allow the caller to specify that it only wants to update the symref if
it does not already exist. Silently ignore the error from the
transaction API if the symref already exists.

Signed-off-by: Bence Ferdinandy <bence@ferdinandy.com>
---

Notes:
    v4: new patch
    v5: no change
    
    v6: - switched from bool to int for create_only
        - refactored logic in refs_update_symref with goto as layed out by
          Junio
    
    v7: - change commit prefix to be more in line with project standards
        - refactored code to accommodate changes in the first patch, but
          otherwise no change

 builtin/branch.c          |  2 +-
 builtin/checkout.c        |  5 +++--
 builtin/clone.c           |  8 +++++---
 builtin/notes.c           |  3 ++-
 builtin/remote.c          |  9 ++++++---
 builtin/symbolic-ref.c    |  2 +-
 builtin/worktree.c        |  2 +-
 refs.c                    | 30 ++++++++++++++++++++++--------
 refs.h                    |  2 +-
 reset.c                   |  2 +-
 sequencer.c               |  3 ++-
 setup.c                   |  3 ++-
 t/helper/test-ref-store.c |  2 +-
 13 files changed, 48 insertions(+), 25 deletions(-)

diff --git a/builtin/branch.c b/builtin/branch.c
index 6c87690b58..2fcbcbfd59 100644
--- a/builtin/branch.c
+++ b/builtin/branch.c
@@ -559,7 +559,7 @@ static int replace_each_worktree_head_symref(struct worktree **worktrees,
 			continue;
 
 		refs = get_worktree_ref_store(worktrees[i]);
-		if (refs_update_symref(refs, "HEAD", newref, logmsg, NULL))
+		if (refs_update_symref(refs, "HEAD", newref, logmsg, NULL, 0))
 			ret = error(_("HEAD of working tree %s is not updated"),
 				    worktrees[i]->path);
 	}
diff --git a/builtin/checkout.c b/builtin/checkout.c
index 356ee9bcde..9abb71dc07 100644
--- a/builtin/checkout.c
+++ b/builtin/checkout.c
@@ -1015,7 +1015,8 @@ static void update_refs_for_switch(const struct checkout_opts *opts,
 			describe_detached_head(_("HEAD is now at"), new_branch_info->commit);
 		}
 	} else if (new_branch_info->path) {	/* Switch branches. */
-		if (refs_update_symref(get_main_ref_store(the_repository), "HEAD", new_branch_info->path, msg.buf, NULL) < 0)
+		if (refs_update_symref(get_main_ref_store(the_repository), "HEAD", new_branch_info->path,
+					msg.buf, NULL, 0) < 0)
 			die(_("unable to update HEAD"));
 		if (!opts->quiet) {
 			if (old_branch_info->path && !strcmp(new_branch_info->path, old_branch_info->path)) {
@@ -1479,7 +1480,7 @@ static int switch_unborn_to_new_branch(const struct checkout_opts *opts)
 		die(_("You are on a branch yet to be born"));
 	strbuf_addf(&branch_ref, "refs/heads/%s", opts->new_branch);
 	status = refs_update_symref(get_main_ref_store(the_repository),
-				    "HEAD", branch_ref.buf, "checkout -b", NULL);
+				    "HEAD", branch_ref.buf, "checkout -b", NULL, 0);
 	strbuf_release(&branch_ref);
 	if (!opts->quiet)
 		fprintf(stderr, _("Switched to a new branch '%s'\n"),
diff --git a/builtin/clone.c b/builtin/clone.c
index ead2af20ea..87e8f1421a 100644
--- a/builtin/clone.c
+++ b/builtin/clone.c
@@ -661,7 +661,7 @@ static void update_remote_refs(const struct ref *refs,
 		strbuf_addstr(&head_ref, "HEAD");
 		if (refs_update_symref(get_main_ref_store(the_repository), head_ref.buf,
 				       remote_head_points_at->peer_ref->name,
-				       msg, NULL) < 0)
+				       msg, NULL, 0) < 0)
 			die(_("unable to update %s"), head_ref.buf);
 		strbuf_release(&head_ref);
 	}
@@ -673,7 +673,8 @@ static void update_head(const struct ref *our, const struct ref *remote,
 	const char *head;
 	if (our && skip_prefix(our->name, "refs/heads/", &head)) {
 		/* Local default branch link */
-		if (refs_update_symref(get_main_ref_store(the_repository), "HEAD", our->name, NULL, NULL) < 0)
+		if (refs_update_symref(get_main_ref_store(the_repository), "HEAD", our->name,
+					NULL, NULL, 0) < 0)
 			die(_("unable to update HEAD"));
 		if (!option_bare) {
 			refs_update_ref(get_main_ref_store(the_repository),
@@ -702,7 +703,8 @@ static void update_head(const struct ref *our, const struct ref *remote,
 		 * Unborn head from remote; same as "our" case above except
 		 * that we have no ref to update.
 		 */
-		if (refs_update_symref(get_main_ref_store(the_repository), "HEAD", unborn, NULL, NULL) < 0)
+		if (refs_update_symref(get_main_ref_store(the_repository), "HEAD", unborn,
+					NULL, NULL, 0) < 0)
 			die(_("unable to update HEAD"));
 		if (!option_bare)
 			install_branch_config(0, head, remote_name, unborn);
diff --git a/builtin/notes.c b/builtin/notes.c
index ba646f06ff..7b3138e3c3 100644
--- a/builtin/notes.c
+++ b/builtin/notes.c
@@ -980,7 +980,8 @@ static int merge(int argc, const char **argv, const char *prefix)
 			die(_("a notes merge into %s is already in-progress at %s"),
 			    notes_ref, wt->path);
 		free_worktrees(worktrees);
-		if (refs_update_symref(get_main_ref_store(the_repository), "NOTES_MERGE_REF", notes_ref, NULL, NULL))
+		if (refs_update_symref(get_main_ref_store(the_repository), "NOTES_MERGE_REF", notes_ref,
+					NULL, NULL, 0))
 			die(_("failed to store link to current notes ref (%s)"),
 			    notes_ref);
 		fprintf(stderr, _("Automatic notes merge failed. Fix conflicts in %s "
diff --git a/builtin/remote.c b/builtin/remote.c
index 2b6948439f..d60ec6e907 100644
--- a/builtin/remote.c
+++ b/builtin/remote.c
@@ -244,7 +244,8 @@ static int add(int argc, const char **argv, const char *prefix)
 		strbuf_reset(&buf2);
 		strbuf_addf(&buf2, "refs/remotes/%s/%s", name, master);
 
-		if (refs_update_symref(get_main_ref_store(the_repository), buf.buf, buf2.buf, "remote add", NULL))
+		if (refs_update_symref(get_main_ref_store(the_repository), buf.buf, buf2.buf,
+					"remote add", NULL, 0))
 			result = error(_("Could not setup master '%s'"), master);
 	}
 
@@ -864,7 +865,8 @@ static int mv(int argc, const char **argv, const char *prefix)
 		strbuf_reset(&buf3);
 		strbuf_addf(&buf3, "remote: renamed %s to %s",
 				item->string, buf.buf);
-		if (refs_update_symref(get_main_ref_store(the_repository), buf.buf, buf2.buf, buf3.buf, NULL))
+		if (refs_update_symref(get_main_ref_store(the_repository), buf.buf, buf2.buf,
+					buf3.buf, NULL, 0))
 			die(_("creating '%s' failed"), buf.buf);
 		display_progress(progress, ++refs_renamed_nr);
 	}
@@ -1470,7 +1472,8 @@ static int set_head(int argc, const char **argv, const char *prefix)
 		/* make sure it's valid */
 		if (!refs_ref_exists(refs, buf2.buf))
 			result |= error(_("Not a valid ref: %s"), buf2.buf);
-		else if (refs_update_symref(refs, buf.buf, buf2.buf, "remote set-head", &buf_prev))
+		else if (refs_update_symref(refs, buf.buf, buf2.buf,
+					"remote set-head", &buf_prev, 0))
 			result |= error(_("Could not setup %s"), buf.buf);
 		else if (opt_a) {
 			report_set_head_auto(argv[0], head_name, &buf_prev);
diff --git a/builtin/symbolic-ref.c b/builtin/symbolic-ref.c
index 7728fbc3c1..cfbb53b30c 100644
--- a/builtin/symbolic-ref.c
+++ b/builtin/symbolic-ref.c
@@ -88,7 +88,7 @@ int cmd_symbolic_ref(int argc,
 		if (check_refname_format(argv[1], REFNAME_ALLOW_ONELEVEL) < 0)
 			die("Refusing to set '%s' to invalid ref '%s'", argv[0], argv[1]);
 		ret = !!refs_update_symref(get_main_ref_store(the_repository),
-					   argv[0], argv[1], msg, NULL);
+					   argv[0], argv[1], msg, NULL, 0);
 		break;
 	default:
 		usage_with_options(git_symbolic_ref_usage, options);
diff --git a/builtin/worktree.c b/builtin/worktree.c
index a7ab4193c1..2e95367235 100644
--- a/builtin/worktree.c
+++ b/builtin/worktree.c
@@ -517,7 +517,7 @@ static int add_worktree(const char *path, const char *refname,
 		ret = refs_update_ref(wt_refs, NULL, "HEAD", &commit->object.oid,
 				      NULL, 0, UPDATE_REFS_MSG_ON_ERR);
 	else
-		ret = refs_update_symref(wt_refs, "HEAD", symref.buf, NULL, NULL);
+		ret = refs_update_symref(wt_refs, "HEAD", symref.buf, NULL, NULL, 0);
 	if (ret)
 		goto done;
 
diff --git a/refs.c b/refs.c
index b964ac44d0..29c020e78e 100644
--- a/refs.c
+++ b/refs.c
@@ -2115,26 +2115,40 @@ int peel_iterated_oid(struct repository *r, const struct object_id *base, struct
 
 int refs_update_symref(struct ref_store *refs, const char *ref,
 		       const char *target, const char *logmsg,
-		       struct strbuf *referent)
+		       struct strbuf *referent, int create_only)
 {
 	struct ref_transaction *transaction;
 	struct strbuf err = STRBUF_INIT;
-	int ret = 0;
+	int ret = 0, prepret = 0;
 
 	transaction = ref_store_transaction_begin(refs, &err);
-	if (!transaction ||
-		ref_transaction_update(transaction, ref, NULL, NULL,
-				   target, NULL, REF_NO_DEREF,
-				   logmsg, &err) ||
-		ref_transaction_prepare(transaction, &err)) {
+	if (!transaction) {
+	error_return:
 		ret = error("%s", err.buf);
 		goto cleanup;
 	}
+	if (create_only) {
+		if (ref_transaction_create(transaction, ref, NULL, target,
+					   REF_NO_DEREF, logmsg, &err))
+			goto error_return;
+		prepret = ref_transaction_prepare(transaction, &err);
+		if (prepret && prepret != TRANSACTION_CREATE_EXISTS)
+			goto error_return;
+	} else {
+		if (ref_transaction_update(transaction, ref, NULL, NULL,
+					   target, NULL, REF_NO_DEREF,
+					   logmsg, &err) ||
+			ref_transaction_prepare(transaction, &err))
+			goto error_return;
+	}
+
 	if (referent)
 		refs_read_symbolic_ref(refs, ref, referent);
 
+	if (prepret == TRANSACTION_CREATE_EXISTS)
+		goto cleanup;
 	if (ref_transaction_commit(transaction, &err))
-		ret = error("%s", err.buf);
+		goto error_return;
 
 cleanup:
 	strbuf_release(&err);
diff --git a/refs.h b/refs.h
index c83b1ec76e..41ae384f11 100644
--- a/refs.h
+++ b/refs.h
@@ -572,7 +572,7 @@ int refs_copy_existing_ref(struct ref_store *refs, const char *oldref,
 
 int refs_update_symref(struct ref_store *refs, const char *refname,
 		       const char *target, const char *logmsg,
-		       struct strbuf *referent);
+		       struct strbuf *referent, int create_only);
 
 enum action_on_err {
 	UPDATE_REFS_MSG_ON_ERR,
diff --git a/reset.c b/reset.c
index cc36a9ed56..919fb84f5f 100644
--- a/reset.c
+++ b/reset.c
@@ -76,7 +76,7 @@ static int update_refs(const struct reset_head_opts *opts,
 		if (!ret)
 			ret = refs_update_symref(get_main_ref_store(the_repository),
 						 "HEAD", switch_to_branch,
-						 reflog_head, NULL);
+						 reflog_head, NULL, 0);
 	}
 	if (!ret && run_hook)
 		run_hooks_l(the_repository, "post-checkout",
diff --git a/sequencer.c b/sequencer.c
index 23b162924c..103d0ddfb2 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -5107,7 +5107,8 @@ static int pick_commits(struct repository *r,
 			}
 			msg = reflog_message(opts, "finish", "returning to %s",
 				head_ref.buf);
-			if (refs_update_symref(get_main_ref_store(the_repository), "HEAD", head_ref.buf, msg, NULL)) {
+			if (refs_update_symref(get_main_ref_store(the_repository), "HEAD", head_ref.buf,
+						msg, NULL, 0)) {
 				res = error(_("could not update HEAD to %s"),
 					head_ref.buf);
 				goto cleanup_head_ref;
diff --git a/setup.c b/setup.c
index d95f051465..9bbc655ee4 100644
--- a/setup.c
+++ b/setup.c
@@ -2275,7 +2275,8 @@ void create_reference_database(enum ref_storage_format ref_storage_format,
 			die(_("invalid initial branch name: '%s'"),
 			    initial_branch);
 
-		if (refs_update_symref(get_main_ref_store(the_repository), "HEAD", ref, NULL, NULL) < 0)
+		if (refs_update_symref(get_main_ref_store(the_repository), "HEAD", ref,
+					NULL, NULL, 0) < 0)
 			exit(1);
 		free(ref);
 	}
diff --git a/t/helper/test-ref-store.c b/t/helper/test-ref-store.c
index a911302bea..f72b029e51 100644
--- a/t/helper/test-ref-store.c
+++ b/t/helper/test-ref-store.c
@@ -120,7 +120,7 @@ static int cmd_create_symref(struct ref_store *refs, const char **argv)
 	const char *target = notnull(*argv++, "target");
 	const char *logmsg = *argv++;
 
-	return refs_update_symref(refs, refname, target, logmsg, NULL);
+	return refs_update_symref(refs, refname, target, logmsg, NULL, 0);
 }
 
 static struct flag_definition transaction_flags[] = {
-- 
2.47.0.7.g072c39eddb.dirty

