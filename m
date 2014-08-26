From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: Transaction patch series overview
Date: Mon, 25 Aug 2014 17:03:54 -0700
Message-ID: <20140826000354.GW20185@google.com>
References: <CAL=YDWmtitT7kHsZqXmojbv8eKYwKwVn7c+gC180FPQN1uxBvQ@mail.gmail.com>
 <CAL=YDWnd=GNycrPO-5yq+a_g569fZDOmzpat+AWrXd+5+bXDQA@mail.gmail.com>
 <CAL=YDWka47hV2TMcwcY1hm+RhbiD6HD=_ED4zB84zX5e5ABf4Q@mail.gmail.com>
 <CAL=YDWm9VaKUBRAmmybHzOBhAg_VvNc0KMG0W_uTA02YYzQrzA@mail.gmail.com>
 <20140820231723.GF20185@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "git@vger.kernel.org" <git@vger.kernel.org>,
	Michael Haggerty <mhagger@alum.mit.edu>
To: Ronnie Sahlberg <sahlberg@google.com>
X-From: git-owner@vger.kernel.org Tue Aug 26 02:04:09 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XM4F4-0001wq-5I
	for gcvg-git-2@plane.gmane.org; Tue, 26 Aug 2014 02:04:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756758AbaHZAD7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 25 Aug 2014 20:03:59 -0400
Received: from mail-pa0-f52.google.com ([209.85.220.52]:59448 "EHLO
	mail-pa0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752606AbaHZAD6 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 25 Aug 2014 20:03:58 -0400
Received: by mail-pa0-f52.google.com with SMTP id bj1so22287875pad.11
        for <git@vger.kernel.org>; Mon, 25 Aug 2014 17:03:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=PaNCP1YW/Xpmoufiy6/l3uGuHH3jCKsWTqh9A5XtNXA=;
        b=Xb7CGM4z114tkkOpj/CaqOQrDLtrkDIy+YI3TIU4a9r1c8nEm2NY0JpyL5UjoHfwXq
         a9+Gfv9ABcWaC5Ii4uo7E3+M7EOtIXPBSCseQHrQc5pKjTkuCuHrwusPt1YwzUNg31RO
         VygTbtfHbHEEyj173IZLUr0R+RYSldcqvDsG1KMIo4NbiHV7V52/zZu9WHI3DlMUA72F
         3ZOo9HckeKetD852SsxDVr/ZAUnk8TO/HJ0MvENoEPxDGTzxcoxhUfa9wNAHV/syRIdi
         n/IlF+kH+gRuNEFlbGny7dQ2GoivHeDcKt9lyOsAGME/gMLWVF5yh2kM3GABEX2NidSp
         KXeg==
X-Received: by 10.69.31.234 with SMTP id kp10mr15293229pbd.138.1409011437500;
        Mon, 25 Aug 2014 17:03:57 -0700 (PDT)
Received: from google.com ([2620:0:1000:5b00:5425:d689:6054:193])
        by mx.google.com with ESMTPSA id bq17sm3549784pac.47.2014.08.25.17.03.56
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Mon, 25 Aug 2014 17:03:56 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20140820231723.GF20185@google.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/255877>

Jonathan Nieder wrote:
> Ronnie Sahlberg wrote:

>> ref-transaction-1 (2014-07-16) 20 commits
>> -------------------------------------------------------------
>> Second batch of ref transactions
>>
>>  - refs.c: make delete_ref use a transaction
>>  - refs.c: make prune_ref use a transaction to delete the ref
>>  - refs.c: remove lock_ref_sha1
>>  - refs.c: remove the update_ref_write function
>>  - refs.c: remove the update_ref_lock function
>>  - refs.c: make lock_ref_sha1 static
>>  - walker.c: use ref transaction for ref updates
>>  - fast-import.c: use a ref transaction when dumping tags
>>  - receive-pack.c: use a reference transaction for updating the refs
>>  - refs.c: change update_ref to use a transaction
>>  - branch.c: use ref transaction for all ref updates
>>  - fast-import.c: change update_branch to use ref transactions
>>  - sequencer.c: use ref transactions for all ref updates
>>  - commit.c: use ref transactions for updates
>>  - replace.c: use the ref transaction functions for updates
>>  - tag.c: use ref transactions when doing updates
>>  - refs.c: add transaction.status and track OPEN/CLOSED/ERROR
>>  - refs.c: make ref_transaction_begin take an err argument
>>  - refs.c: update ref_transaction_delete to check for error and return status
>>  - refs.c: change ref_transaction_create to do error checking and return status
>>  (this branch is used by rs/ref-transaction, rs/ref-transaction-multi,
>> rs/ref-transaction-reflog and rs/ref-transaction-rename.)
[...]
> I've having trouble keeping track of how patches change, which patches
> have been reviewed and which haven't, unaddressed comments, and so on,
> so as an experiment I've pushed this part of the series to the Gerrit
> server at
>
>  https://code-review.googlesource.com/#/q/topic:ref-transaction-1

Outcome of the experiment: patches gained some minor changes and then

 1-12
	Reviewed-by: Jonathan Nieder <jrnieder@gmail.com>

 13
	Reviewed-by: Michael Haggerty <mhagger@alum.mit.edu>
	Reviewed-by: Jonathan Nieder <jrnieder@gmail.com>

 14
	Reviewed-by: Jonathan Nieder <jrnieder@gmail.com>

 15-16
	Reviewed-by: Michael Haggerty <mhagger@alum.mit.edu>
	Reviewed-by: Jonathan Nieder <jrnieder@gmail.com>

 17
	Reviewed-by: Michael Haggerty <mhagger@alum.mit.edu>

 18
	Reviewed-by: Michael Haggerty <mhagger@alum.mit.edu>
	Reviewed-by: Jonathan Nieder <jrnieder@gmail.com>

 19
	Reviewed-by: Jonathan Nieder <jrnieder@gmail.com>

 20
	Reviewed-by: Michael Haggerty <mhagger@alum.mit.edu>
	Reviewed-by: Jonathan Nieder <jrnieder@gmail.com>

I found the web UI helpful in seeing how each patch evolved since I
last looked at it.  Interdiff relative to the version in pu is below.
I'm still hoping for a tweak in response to a minor comment and then I
can put up a copy of the updated series to pull.

The next series from Ronnie's collection is available at
https://code-review.googlesource.com/#/q/topic:ref-transaction in case
someone wants a fresh series to look at.

diff --git a/branch.c b/branch.c
index c1eae00..37ac555 100644
--- a/branch.c
+++ b/branch.c
@@ -305,6 +305,7 @@ void create_branch(const char *head,
 		    ref_transaction_commit(transaction, msg, &err))
 			die("%s", err.buf);
 		ref_transaction_free(transaction);
+		strbuf_release(&err);
 	}
 
 	if (real_ref && track)
diff --git a/builtin/commit.c b/builtin/commit.c
index 668fa6a..9bf1003 100644
--- a/builtin/commit.c
+++ b/builtin/commit.c
@@ -1765,8 +1765,8 @@ int cmd_commit(int argc, const char **argv, const char *prefix)
 	transaction = ref_transaction_begin(&err);
 	if (!transaction ||
 	    ref_transaction_update(transaction, "HEAD", sha1,
-				   current_head ?
-				   current_head->object.sha1 : NULL,
+				   current_head
+				   ? current_head->object.sha1 : NULL,
 				   0, !!current_head, &err) ||
 	    ref_transaction_commit(transaction, sb.buf, &err)) {
 		rollback_index_files();
@@ -1801,5 +1801,6 @@ int cmd_commit(int argc, const char **argv, const char *prefix)
 	if (!quiet)
 		print_summary(prefix, sha1, !current_head);
 
+	strbuf_release(&err);
 	return 0;
 }
diff --git a/builtin/receive-pack.c b/builtin/receive-pack.c
index 91099ad..224fadc 100644
--- a/builtin/receive-pack.c
+++ b/builtin/receive-pack.c
@@ -194,7 +194,7 @@ static void write_head_info(void)
 
 struct command {
 	struct command *next;
-	char *error_string;
+	const char *error_string;
 	unsigned int skip_update:1,
 		     did_not_exist:1;
 	int index;
@@ -468,7 +468,7 @@ static int update_shallow_ref(struct command *cmd, struct shallow_info *si)
 	return 0;
 }
 
-static char *update(struct command *cmd, struct shallow_info *si)
+static const char *update(struct command *cmd, struct shallow_info *si)
 {
 	const char *name = cmd->ref_name;
 	struct strbuf namespaced_name_buf = STRBUF_INIT;
@@ -479,7 +479,7 @@ static char *update(struct command *cmd, struct shallow_info *si)
 	/* only refs/... are allowed */
 	if (!starts_with(name, "refs/") || check_refname_format(name + 5, 0)) {
 		rp_error("refusing to create funny ref '%s' remotely", name);
-		return xstrdup("funny refname");
+		return "funny refname";
 	}
 
 	strbuf_addf(&namespaced_name_buf, "%s%s", get_git_namespace(), name);
@@ -497,20 +497,20 @@ static char *update(struct command *cmd, struct shallow_info *si)
 			rp_error("refusing to update checked out branch: %s", name);
 			if (deny_current_branch == DENY_UNCONFIGURED)
 				refuse_unconfigured_deny();
-			return xstrdup("branch is currently checked out");
+			return "branch is currently checked out";
 		}
 	}
 
 	if (!is_null_sha1(new_sha1) && !has_sha1_file(new_sha1)) {
 		error("unpack should have generated %s, "
 		      "but I can't find it!", sha1_to_hex(new_sha1));
-		return xstrdup("bad pack");
+		return "bad pack";
 	}
 
 	if (!is_null_sha1(old_sha1) && is_null_sha1(new_sha1)) {
 		if (deny_deletes && starts_with(name, "refs/heads/")) {
 			rp_error("denying ref deletion for %s", name);
-			return xstrdup("deletion prohibited");
+			return "deletion prohibited";
 		}
 
 		if (!strcmp(namespaced_name, head_name)) {
@@ -525,7 +525,7 @@ static char *update(struct command *cmd, struct shallow_info *si)
 				if (deny_delete_current == DENY_UNCONFIGURED)
 					refuse_unconfigured_deny_delete_current();
 				rp_error("refusing to delete the current branch: %s", name);
-				return xstrdup("deletion of the current branch prohibited");
+				return "deletion of the current branch prohibited";
 			}
 		}
 	}
@@ -543,19 +543,19 @@ static char *update(struct command *cmd, struct shallow_info *si)
 		    old_object->type != OBJ_COMMIT ||
 		    new_object->type != OBJ_COMMIT) {
 			error("bad sha1 objects for %s", name);
-			return xstrdup("bad ref");
+			return "bad ref";
 		}
 		old_commit = (struct commit *)old_object;
 		new_commit = (struct commit *)new_object;
 		if (!in_merge_bases(old_commit, new_commit)) {
 			rp_error("denying non-fast-forward %s"
 				 " (you should pull first)", name);
-			return xstrdup("non-fast-forward");
+			return "non-fast-forward";
 		}
 	}
 	if (run_update_hook(cmd)) {
 		rp_error("hook declined to update %s", name);
-		return xstrdup("hook declined");
+		return "hook declined";
 	}
 
 	if (is_null_sha1(new_sha1)) {
@@ -570,7 +570,7 @@ static char *update(struct command *cmd, struct shallow_info *si)
 		}
 		if (delete_ref(namespaced_name, old_sha1, 0)) {
 			rp_error("failed to delete %s", name);
-			return xstrdup("failed to delete");
+			return "failed to delete";
 		}
 		return NULL; /* good */
 	}
@@ -580,18 +580,18 @@ static char *update(struct command *cmd, struct shallow_info *si)
 
 		if (shallow_update && si->shallow_ref[cmd->index] &&
 		    update_shallow_ref(cmd, si))
-			return xstrdup("shallow error");
+			return "shallow error";
 
 		transaction = ref_transaction_begin(&err);
 		if (!transaction ||
 		    ref_transaction_update(transaction, namespaced_name,
 					   new_sha1, old_sha1, 0, 1, &err) ||
 		    ref_transaction_commit(transaction, "push", &err)) {
-			char *str = strbuf_detach(&err, NULL);
 			ref_transaction_free(transaction);
 
-			rp_error("%s", str);
-			return str;
+			rp_error("%s", err.buf);
+			strbuf_release(&err);
+			return "failed to update ref";
 		}
 
 		ref_transaction_free(transaction);
@@ -654,9 +654,6 @@ static void check_aliased_update(struct command *cmd, struct string_list *list)
 	char cmd_oldh[41], cmd_newh[41], dst_oldh[41], dst_newh[41];
 	int flag;
 
-	if (cmd->error_string)
-		die("BUG: check_aliased_update called with failed cmd");
-
 	strbuf_addf(&buf, "%s%s", get_git_namespace(), cmd->ref_name);
 	dst_name = resolve_ref_unsafe(buf.buf, sha1, 0, &flag);
 	strbuf_release(&buf);
@@ -668,7 +665,7 @@ static void check_aliased_update(struct command *cmd, struct string_list *list)
 	if (!dst_name) {
 		rp_error("refusing update to broken symref '%s'", cmd->ref_name);
 		cmd->skip_update = 1;
-		cmd->error_string = xstrdup("broken symref");
+		cmd->error_string = "broken symref";
 		return;
 	}
 
@@ -694,9 +691,8 @@ static void check_aliased_update(struct command *cmd, struct string_list *list)
 		 cmd->ref_name, cmd_oldh, cmd_newh,
 		 dst_cmd->ref_name, dst_oldh, dst_newh);
 
-	cmd->error_string = xstrdup("inconsistent aliased update");
-	free(dst_cmd->error_string);
-	dst_cmd->error_string = xstrdup("inconsistent aliased update");
+	cmd->error_string = dst_cmd->error_string =
+		"inconsistent aliased update";
 }
 
 static void check_aliased_updates(struct command *commands)
@@ -744,9 +740,7 @@ static void set_connectivity_errors(struct command *commands,
 		if (!check_everything_connected(command_singleton_iterator,
 						0, &singleton))
 			continue;
-		if (cmd->error_string)  /* can't happen */
-			continue;
-		cmd->error_string = xstrdup("missing necessary objects");
+		cmd->error_string = "missing necessary objects";
 	}
 }
 
@@ -783,9 +777,9 @@ static void reject_updates_to_hidden(struct command *commands)
 		if (cmd->error_string || !ref_is_hidden(cmd->ref_name))
 			continue;
 		if (is_null_sha1(cmd->new_sha1))
-			cmd->error_string = xstrdup("deny deleting a hidden ref");
+			cmd->error_string = "deny deleting a hidden ref";
 		else
-			cmd->error_string = xstrdup("deny updating a hidden ref");
+			cmd->error_string = "deny updating a hidden ref";
 	}
 }
 
@@ -799,11 +793,8 @@ static void execute_commands(struct command *commands,
 	struct iterate_data data;
 
 	if (unpacker_error) {
-		for (cmd = commands; cmd; cmd = cmd->next) {
-			if (cmd->error_string)  /* can't happen */
-				continue;
-			cmd->error_string = xstrdup("unpacker error");
-		}
+		for (cmd = commands; cmd; cmd = cmd->next)
+			cmd->error_string = "unpacker error";
 		return;
 	}
 
@@ -816,9 +807,8 @@ static void execute_commands(struct command *commands,
 
 	if (run_receive_hook(commands, "pre-receive", 0)) {
 		for (cmd = commands; cmd; cmd = cmd->next) {
-			if (cmd->error_string)
-				continue;
-			cmd->error_string = xstrdup("pre-receive hook declined");
+			if (!cmd->error_string)
+				cmd->error_string = "pre-receive hook declined";
 		}
 		return;
 	}
@@ -1096,8 +1086,7 @@ static void update_shallow_info(struct command *commands,
 		if (is_null_sha1(cmd->new_sha1))
 			continue;
 		if (ref_status[cmd->index]) {
-			free(cmd->error_string);
-			cmd->error_string = xstrdup("shallow update not allowed");
+			cmd->error_string = "shallow update not allowed";
 			cmd->skip_update = 1;
 		}
 	}
@@ -1138,17 +1127,6 @@ static int delete_only(struct command *commands)
 	return 1;
 }
 
-static void free_commands(struct command *commands)
-{
-	while (commands) {
-		struct command *next = commands->next;
-
-		free(commands->error_string);
-		free(commands);
-		commands = next;
-	}
-}
-
 int cmd_receive_pack(int argc, const char **argv, const char *prefix)
 {
 	int advertise_refs = 0;
@@ -1244,6 +1222,5 @@ int cmd_receive_pack(int argc, const char **argv, const char *prefix)
 		packet_flush(1);
 	sha1_array_clear(&shallow);
 	sha1_array_clear(&ref);
-	free_commands(commands);
 	return 0;
 }
diff --git a/builtin/replace.c b/builtin/replace.c
index 7528f3d..1fcd06d 100644
--- a/builtin/replace.c
+++ b/builtin/replace.c
@@ -169,8 +169,7 @@ static int replace_object_sha1(const char *object_ref,
 
 	transaction = ref_transaction_begin(&err);
 	if (!transaction ||
-	    ref_transaction_update(transaction, ref, repl, prev,
-				   0, !is_null_sha1(prev), &err) ||
+	    ref_transaction_update(transaction, ref, repl, prev, 0, 1, &err) ||
 	    ref_transaction_commit(transaction, NULL, &err))
 		die("%s", err.buf);
 
diff --git a/builtin/tag.c b/builtin/tag.c
index 1aa88a2..f3f172f 100644
--- a/builtin/tag.c
+++ b/builtin/tag.c
@@ -712,6 +712,7 @@ int cmd_tag(int argc, const char **argv, const char *prefix)
 	if (force && !is_null_sha1(prev) && hashcmp(prev, object))
 		printf(_("Updated tag '%s' (was %s)\n"), tag, find_unique_abbrev(prev, DEFAULT_ABBREV));
 
+	strbuf_release(&err);
 	strbuf_release(&buf);
 	strbuf_release(&ref);
 	return 0;
diff --git a/builtin/update-ref.c b/builtin/update-ref.c
index c6ad0be..96a53b9 100644
--- a/builtin/update-ref.c
+++ b/builtin/update-ref.c
@@ -366,6 +366,8 @@ int cmd_update_ref(int argc, const char **argv, const char *prefix)
 
 	if (read_stdin) {
 		transaction = ref_transaction_begin(&err);
+		if (!transaction)
+			die("%s", err.buf);
 		if (delete || no_deref || argc > 0)
 			usage_with_options(git_update_ref_usage, options);
 		if (end_null)
@@ -374,6 +376,7 @@ int cmd_update_ref(int argc, const char **argv, const char *prefix)
 		if (ref_transaction_commit(transaction, msg, &err))
 			die("%s", err.buf);
 		ref_transaction_free(transaction);
+		strbuf_release(&err);
 		return 0;
 	}
 
diff --git a/fast-import.c b/fast-import.c
index a95e1be..e7f6e37 100644
--- a/fast-import.c
+++ b/fast-import.c
@@ -1716,6 +1716,7 @@ static int update_branch(struct branch *b)
 		return -1;
 	}
 	ref_transaction_free(transaction);
+	strbuf_release(&err);
 	return 0;
 }
 
diff --git a/refs.c b/refs.c
index 0017d9c..819e25f 100644
--- a/refs.c
+++ b/refs.c
@@ -2074,7 +2074,10 @@ int dwim_log(const char *str, int len, unsigned char *sha1, char **log)
 	return logs_found;
 }
 
-/* This function should make sure errno is meaningful on error */
+/*
+ * Locks a "refs/" ref returning the lock on success and NULL on failure.
+ * On failure errno is set to something meaningful.
+ */
 static struct ref_lock *lock_ref_sha1_basic(const char *refname,
 					    const unsigned char *old_sha1,
 					    int flags, int *type_p)
@@ -2401,6 +2404,7 @@ static void prune_ref(struct ref_to_prune *r)
 		return;
 	}
 	ref_transaction_free(transaction);
+	strbuf_release(&err);
 	try_remove_empty_parents(r->name);
 }
 
@@ -2575,6 +2579,7 @@ int delete_ref(const char *refname, const unsigned char *sha1, int delopt)
 		return 1;
 	}
 	ref_transaction_free(transaction);
+	strbuf_release(&err);
 	return 0;
 }
 
@@ -3352,19 +3357,15 @@ struct ref_update {
  * Transaction states.
  * OPEN:   The transaction is in a valid state and can accept new updates.
  *         An OPEN transaction can be committed.
- * CLOSED: If an open transaction is successfully committed the state will
- *         change to CLOSED. No further changes can be made to a CLOSED
- *         transaction.
- *         CLOSED means that all updates have been successfully committed and
- *         the only thing that remains is to free the completed transaction.
- * ERROR:  The transaction has failed and is no longer committable.
- *         No further changes can be made to a CLOSED transaction and it must
- *         be rolled back using transaction_free.
+ * CLOSED: A closed transaction is no longer active and no other operations
+ *         than free can be used on it in this state.
+ *         A transaction can either become closed by successfully committing
+ *         an active transaction or if there is a failure while building
+ *         the transaction thus rendering it failed/inactive.
  */
 enum ref_transaction_state {
 	REF_TRANSACTION_OPEN   = 0,
-	REF_TRANSACTION_CLOSED = 1,
-	REF_TRANSACTION_ERROR  = 2,
+	REF_TRANSACTION_CLOSED = 1
 };
 
 /*
@@ -3509,6 +3510,7 @@ int update_ref(const char *action, const char *refname,
 		strbuf_release(&err);
 		return 1;
 	}
+	strbuf_release(&err);
 	return 0;
 }
 
@@ -3588,10 +3590,10 @@ int ref_transaction_commit(struct ref_transaction *transaction,
 					     msg);
 			update->lock = NULL; /* freed by write_ref_sha1 */
 			if (ret) {
-				const char *str = "Cannot update the ref '%s'.";
-
 				if (err)
-					strbuf_addf(err, str, update->refname);
+					strbuf_addf(err, "Cannot update the "
+						    "ref '%s'.",
+						    update->refname);
 				goto cleanup;
 			}
 		}
@@ -3614,8 +3616,7 @@ int ref_transaction_commit(struct ref_transaction *transaction,
 	clear_loose_ref_cache(&ref_cache);
 
 cleanup:
-	transaction->state = ret ? REF_TRANSACTION_ERROR
-		: REF_TRANSACTION_CLOSED;
+	transaction->state = REF_TRANSACTION_CLOSED;
 
 	for (i = 0; i < n; i++)
 		if (updates[i]->lock)
diff --git a/refs.h b/refs.h
index aad846c..69ef28c 100644
--- a/refs.h
+++ b/refs.h
@@ -180,8 +180,7 @@ extern int peel_ref(const char *refname, unsigned char *sha1);
  */
 #define REF_NODEREF	0x01
 /*
- * Locks any ref (for 'HEAD' type refs) and sets errno to something
- * meaningful on failure.
+ * This function sets errno to something meaningful on failure.
  */
 extern struct ref_lock *lock_any_ref_for_update(const char *refname,
 						const unsigned char *old_sha1,
diff --git a/sequencer.c b/sequencer.c
index cf17c69..5e93b6a 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -296,6 +296,7 @@ static int fast_forward_to(const unsigned char *to, const unsigned char *from,
 	}
 
 	strbuf_release(&sb);
+	strbuf_release(&err);
 	ref_transaction_free(transaction);
 	return 0;
 }
diff --git a/walker.c b/walker.c
index 60d9f9e..b8a5441 100644
--- a/walker.c
+++ b/walker.c
@@ -251,12 +251,12 @@ void walker_targets_free(int targets, char **target, const char **write_ref)
 int walker_fetch(struct walker *walker, int targets, char **target,
 		 const char **write_ref, const char *write_ref_log_details)
 {
-	struct strbuf ref_name = STRBUF_INIT;
+	struct strbuf refname = STRBUF_INIT;
 	struct strbuf err = STRBUF_INIT;
 	struct ref_transaction *transaction = NULL;
 	unsigned char *sha1 = xmalloc(targets * 20);
 	char *msg = NULL;
-	int i;
+	int i, ret = -1;
 
 	save_commit_buffer = 0;
 
@@ -264,7 +264,7 @@ int walker_fetch(struct walker *walker, int targets, char **target,
 		transaction = ref_transaction_begin(&err);
 		if (!transaction) {
 			error("%s", err.buf);
-			goto rollback_and_fail;
+			goto done;
 		}
 	}
 	if (!walker->get_recover)
@@ -273,15 +273,18 @@ int walker_fetch(struct walker *walker, int targets, char **target,
 	for (i = 0; i < targets; i++) {
 		if (interpret_target(walker, target[i], &sha1[20 * i])) {
 			error("Could not interpret response from server '%s' as something to pull", target[i]);
-			goto rollback_and_fail;
+			goto done;
 		}
 		if (process(walker, lookup_unknown_object(&sha1[20 * i])))
-			goto rollback_and_fail;
+			goto done;
 	}
 
 	if (loop(walker))
-		goto rollback_and_fail;
-
+		goto done;
+	if (!write_ref) {
+		ret = 0;
+		goto done;
+	}
 	if (write_ref_log_details) {
 		msg = xmalloc(strlen(write_ref_log_details) + 12);
 		sprintf(msg, "fetch from %s", write_ref_log_details);
@@ -289,37 +292,33 @@ int walker_fetch(struct walker *walker, int targets, char **target,
 		msg = NULL;
 	}
 	for (i = 0; i < targets; i++) {
-		if (!write_ref || !write_ref[i])
+		if (!write_ref[i])
 			continue;
-		strbuf_reset(&ref_name);
-		strbuf_addf(&ref_name, "refs/%s", write_ref[i]);
-		if (ref_transaction_update(transaction, ref_name.buf,
+		strbuf_reset(&refname);
+		strbuf_addf(&refname, "refs/%s", write_ref[i]);
+		if (ref_transaction_update(transaction, refname.buf,
 					   &sha1[20 * i], NULL, 0, 0,
 					   &err)) {
 			error("%s", err.buf);
-			goto rollback_and_fail;
+			goto done;
 		}
 	}
-	if (write_ref) {
-		if (ref_transaction_commit(transaction,
-					   msg ? msg : "fetch (unknown)",
-					   &err)) {
-			error("%s", err.buf);
-			goto rollback_and_fail;
-		}
-		ref_transaction_free(transaction);
+	if (ref_transaction_commit(transaction,
+				   msg ? msg : "fetch (unknown)",
+				   &err)) {
+		error("%s", err.buf);
+		goto done;
 	}
 
-	free(msg);
-	return 0;
+	ret = 0;
 
-rollback_and_fail:
+done:
 	ref_transaction_free(transaction);
 	free(msg);
+	free(sha1);
 	strbuf_release(&err);
-	strbuf_release(&ref_name);
-
-	return -1;
+	strbuf_release(&refname);
+	return ret;
 }
 
 void walker_free(struct walker *walker)
