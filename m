Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C44B51F424
	for <e@80x24.org>; Fri, 27 Apr 2018 21:39:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1759309AbeD0Vju (ORCPT <rfc822;e@80x24.org>);
        Fri, 27 Apr 2018 17:39:50 -0400
Received: from mout.gmx.net ([212.227.17.20]:55021 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1759082AbeD0Vjt (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 27 Apr 2018 17:39:49 -0400
Received: from localhost.localdomain ([37.201.195.116]) by mail.gmx.com
 (mrgmx102 [212.227.17.168]) with ESMTPSA (Nemesis) id
 0MTeVY-1elsnY225o-00QRnu; Fri, 27 Apr 2018 23:39:44 +0200
From:   Johannes Schindelin <johannes.schindelin@gmx.de>
To:     git@vger.kernel.org
Cc:     Johannes Schindelin <johannes.schindelin@gmx.de>,
        Junio C Hamano <gitster@pobox.com>,
        Jakub Narebski <jnareb@gmail.com>,
        Stefan Beller <sbeller@google.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Christian Couder <christian.couder@gmail.com>,
        Philip Oakley <philipoakley@iee.org>
Subject: [PATCH v6 04/11] replace: "libify" create_graft() and callees
Date:   Fri, 27 Apr 2018 23:39:37 +0200
Message-Id: <f2f490b41529327b8fb4214ef4f663b21ee43ed8.1524865158.git.johannes.schindelin@gmx.de>
X-Mailer: git-send-email 2.17.0.windows.1.33.gfcbb1fa0445
MIME-Version: 1.0
In-Reply-To: <cover.1524865158.git.johannes.schindelin@gmx.de>
References: <cover.1524650028.git.johannes.schindelin@gmx.de> <cover.1524865158.git.johannes.schindelin@gmx.de>
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
X-Provags-ID: V03:K1:mhbNOnlqmnQdqDpEH8t/iPTzZitZ1oem54D44IBLm9rGo/nICc4
 hI5Pz7a2HHMt4Q/AWNsFFANzZ/R1H8mSRfDb2sHaIUDkbkv3jT4P4Vdq6290jEM/AA9X76n
 j1kqhwOWp9kgmu/wYtfvVfGd5tdJFp2cceBiXd/6x4jEwnHzm7dXoMCpiIeoRaxNsfpQMGy
 /eUnhtHICnhZRydTqGcnQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:DEHYqqwwqs4=:zj1RYblX/Yw8j2wikmuXy6
 8QRFsg27UxeNGgJqQQeyY6tUsK0PIugqELzhTuU2rHXpjgI6GZ0ZfS3rjvBW+2o49POrcbXm1
 PLgfLSnF7Cfc7/eOCKfIsqUFYp5DNgU/u846RzW+TlBqBzWzwfj1v4VznX3brKuxCBM4syRku
 8OwReI6Qg0gUkg21X2bmIcFW1a1HURgmqX7QSxZHDXBgOnlQLlKnaFiPQ6qQnePXvFAtkCnaL
 WRGT+KlbLd6lIaZdbW4NM6XbHWGMN0O9v+DbO4c9L9Ol2e5OMuH0BeIGuRoBzu7rvcKhHnXYN
 N/ofc7FqjlFbJEdJN3PkEO6ASfNV07Se/iZ+E89QiOeWzEaBRt5+Ic0wl3VybcpVXCMPQDj5f
 IO2sAiaJxW7WqwG9nf4BTSURAZTyMKOSci6FC062ZKZTafE3+5u6+xnOCGxJAvllLhgEIyD82
 MzbhwCe2vn0Zi0dXoP5pyOqiEZQ6PMS5VrGX80tv2LjXI8Q4O5Dbg3DdRgmRQj0J+WFDpSId+
 ABss2QL+oR8epIWRcLHq9857VzSDl+55IF9d6LGZGyd4dWIJPo5DxYDtk3ij51HZyK/3JH5C7
 vufgbFZ3Nt96Yr1fk38sKmCqAg5lknpdOZ7nJ/f51ZgvYlhblWiQDT+G+wrGicyDLNqfWl7jo
 kTpwoTlcvdF2Ic3x1qATeZFD6ue04fmU60dL0K7/EY7+ZdSWz9XoUd2lBwyPEeIyXsKHbUY6k
 zy98WWUd+X7wPHbgiCy7Oeem/Om9sY5kVX6Uj6NSRW+RZa+ex7KV6AiXv2lr/UYYryBKrsZsP
 6EhjTKi
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

File this away as yet another patch in the "libification" category.

As with all useful functions, in the next commit we want to use
create_graft() from a higher-level function where it would be
inconvenient if the called function simply die()s: if there is a
problem, we want to let the user know how to proceed, and the callee
simply has no way of knowing what to say.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 builtin/replace.c | 169 ++++++++++++++++++++++++++++++----------------
 1 file changed, 112 insertions(+), 57 deletions(-)

diff --git a/builtin/replace.c b/builtin/replace.c
index e345a5a0f1c..e57d3d187ed 100644
--- a/builtin/replace.c
+++ b/builtin/replace.c
@@ -79,9 +79,9 @@ static int list_replace_refs(const char *pattern, const char *format)
 	else if (!strcmp(format, "long"))
 		data.format = REPLACE_FORMAT_LONG;
 	else
-		die("invalid replace format '%s'\n"
-		    "valid formats are 'short', 'medium' and 'long'\n",
-		    format);
+		return error("invalid replace format '%s'\n"
+			     "valid formats are 'short', 'medium' and 'long'\n",
+			     format);
 
 	for_each_replace_ref(show_reference, (void *)&data);
 
@@ -134,7 +134,7 @@ static int delete_replace_ref(const char *name, const char *ref,
 	return 0;
 }
 
-static void check_ref_valid(struct object_id *object,
+static int check_ref_valid(struct object_id *object,
 			    struct object_id *prev,
 			    struct strbuf *ref,
 			    int force)
@@ -142,12 +142,13 @@ static void check_ref_valid(struct object_id *object,
 	strbuf_reset(ref);
 	strbuf_addf(ref, "%s%s", git_replace_ref_base, oid_to_hex(object));
 	if (check_refname_format(ref->buf, 0))
-		die("'%s' is not a valid ref name.", ref->buf);
+		return error("'%s' is not a valid ref name.", ref->buf);
 
 	if (read_ref(ref->buf, prev))
 		oidclr(prev);
 	else if (!force)
-		die("replace ref '%s' already exists", ref->buf);
+		return error("replace ref '%s' already exists", ref->buf);
+	return 0;
 }
 
 static int replace_object_oid(const char *object_ref,
@@ -161,28 +162,33 @@ static int replace_object_oid(const char *object_ref,
 	struct strbuf ref = STRBUF_INIT;
 	struct ref_transaction *transaction;
 	struct strbuf err = STRBUF_INIT;
+	int res = 0;
 
 	obj_type = oid_object_info(object, NULL);
 	repl_type = oid_object_info(repl, NULL);
 	if (!force && obj_type != repl_type)
-		die("Objects must be of the same type.\n"
-		    "'%s' points to a replaced object of type '%s'\n"
-		    "while '%s' points to a replacement object of type '%s'.",
-		    object_ref, type_name(obj_type),
-		    replace_ref, type_name(repl_type));
-
-	check_ref_valid(object, &prev, &ref, force);
+		return error("Objects must be of the same type.\n"
+			     "'%s' points to a replaced object of type '%s'\n"
+			     "while '%s' points to a replacement object of "
+			     "type '%s'.",
+			     object_ref, type_name(obj_type),
+			     replace_ref, type_name(repl_type));
+
+	if (check_ref_valid(object, &prev, &ref, force)) {
+		strbuf_release(&ref);
+		return -1;
+	}
 
 	transaction = ref_transaction_begin(&err);
 	if (!transaction ||
 	    ref_transaction_update(transaction, ref.buf, repl, &prev,
 				   0, NULL, &err) ||
 	    ref_transaction_commit(transaction, &err))
-		die("%s", err.buf);
+		res = error("%s", err.buf);
 
 	ref_transaction_free(transaction);
 	strbuf_release(&ref);
-	return 0;
+	return res;
 }
 
 static int replace_object(const char *object_ref, const char *replace_ref, int force)
@@ -190,9 +196,11 @@ static int replace_object(const char *object_ref, const char *replace_ref, int f
 	struct object_id object, repl;
 
 	if (get_oid(object_ref, &object))
-		die("Failed to resolve '%s' as a valid ref.", object_ref);
+		return error("Failed to resolve '%s' as a valid ref.",
+			     object_ref);
 	if (get_oid(replace_ref, &repl))
-		die("Failed to resolve '%s' as a valid ref.", replace_ref);
+		return error("Failed to resolve '%s' as a valid ref.",
+			     replace_ref);
 
 	return replace_object_oid(object_ref, &object, replace_ref, &repl, force);
 }
@@ -202,7 +210,7 @@ static int replace_object(const char *object_ref, const char *replace_ref, int f
  * If "raw" is true, then the object's raw contents are printed according to
  * "type". Otherwise, we pretty-print the contents for human editing.
  */
-static void export_object(const struct object_id *oid, enum object_type type,
+static int export_object(const struct object_id *oid, enum object_type type,
 			  int raw, const char *filename)
 {
 	struct child_process cmd = CHILD_PROCESS_INIT;
@@ -210,7 +218,7 @@ static void export_object(const struct object_id *oid, enum object_type type,
 
 	fd = open(filename, O_WRONLY | O_CREAT | O_TRUNC, 0666);
 	if (fd < 0)
-		die_errno("unable to open %s for writing", filename);
+		return error_errno("unable to open %s for writing", filename);
 
 	argv_array_push(&cmd.args, "--no-replace-objects");
 	argv_array_push(&cmd.args, "cat-file");
@@ -223,7 +231,8 @@ static void export_object(const struct object_id *oid, enum object_type type,
 	cmd.out = fd;
 
 	if (run_command(&cmd))
-		die("cat-file reported failure");
+		return error("cat-file reported failure");
+	return 0;
 }
 
 /*
@@ -231,14 +240,14 @@ static void export_object(const struct object_id *oid, enum object_type type,
  * interpreting it as "type", and writing the result to the object database.
  * The sha1 of the written object is returned via sha1.
  */
-static void import_object(struct object_id *oid, enum object_type type,
+static int import_object(struct object_id *oid, enum object_type type,
 			  int raw, const char *filename)
 {
 	int fd;
 
 	fd = open(filename, O_RDONLY);
 	if (fd < 0)
-		die_errno("unable to open %s for reading", filename);
+		return error_errno("unable to open %s for reading", filename);
 
 	if (!raw && type == OBJ_TREE) {
 		const char *argv[] = { "mktree", NULL };
@@ -250,27 +259,40 @@ static void import_object(struct object_id *oid, enum object_type type,
 		cmd.in = fd;
 		cmd.out = -1;
 
-		if (start_command(&cmd))
-			die("unable to spawn mktree");
+		if (start_command(&cmd)) {
+			close(fd);
+			return error("unable to spawn mktree");
+		}
 
-		if (strbuf_read(&result, cmd.out, 41) < 0)
-			die_errno("unable to read from mktree");
+		if (strbuf_read(&result, cmd.out, 41) < 0) {
+			error_errno("unable to read from mktree");
+			close(fd);
+			close(cmd.out);
+			return -1;
+		}
 		close(cmd.out);
 
-		if (finish_command(&cmd))
-			die("mktree reported failure");
-		if (get_oid_hex(result.buf, oid) < 0)
-			die("mktree did not return an object name");
+		if (finish_command(&cmd)) {
+			strbuf_release(&result);
+			return error("mktree reported failure");
+		}
+		if (get_oid_hex(result.buf, oid) < 0) {
+			strbuf_release(&result);
+			return error("mktree did not return an object name");
+		}
 
 		strbuf_release(&result);
 	} else {
 		struct stat st;
 		int flags = HASH_FORMAT_CHECK | HASH_WRITE_OBJECT;
 
-		if (fstat(fd, &st) < 0)
-			die_errno("unable to fstat %s", filename);
+		if (fstat(fd, &st) < 0) {
+			error_errno("unable to fstat %s", filename);
+			close(fd);
+			return -1;
+		}
 		if (index_fd(oid, fd, &st, type, NULL, flags) < 0)
-			die("unable to write object to database");
+			return error("unable to write object to database");
 		/* index_fd close()s fd for us */
 	}
 
@@ -278,30 +300,43 @@ static void import_object(struct object_id *oid, enum object_type type,
 	 * No need to close(fd) here; both run-command and index-fd
 	 * will have done it for us.
 	 */
+	return 0;
 }
 
 static int edit_and_replace(const char *object_ref, int force, int raw)
 {
-	char *tmpfile = git_pathdup("REPLACE_EDITOBJ");
+	char *tmpfile;
 	enum object_type type;
 	struct object_id old_oid, new_oid, prev;
 	struct strbuf ref = STRBUF_INIT;
 
 	if (get_oid(object_ref, &old_oid) < 0)
-		die("Not a valid object name: '%s'", object_ref);
+		return error("Not a valid object name: '%s'", object_ref);
 
 	type = oid_object_info(&old_oid, NULL);
 	if (type < 0)
-		die("unable to get object type for %s", oid_to_hex(&old_oid));
+		return error("unable to get object type for %s",
+			     oid_to_hex(&old_oid));
 
-	check_ref_valid(&old_oid, &prev, &ref, force);
+	if (check_ref_valid(&old_oid, &prev, &ref, force)) {
+		strbuf_release(&ref);
+		return -1;
+	}
 	strbuf_release(&ref);
 
-	export_object(&old_oid, type, raw, tmpfile);
-	if (launch_editor(tmpfile, NULL, NULL) < 0)
-		die("editing object file failed");
-	import_object(&new_oid, type, raw, tmpfile);
-
+	tmpfile = git_pathdup("REPLACE_EDITOBJ");
+	if (export_object(&old_oid, type, raw, tmpfile)) {
+		free(tmpfile);
+		return -1;
+	}
+	if (launch_editor(tmpfile, NULL, NULL) < 0) {
+		free(tmpfile);
+		return error("editing object file failed");
+	}
+	if (import_object(&new_oid, type, raw, tmpfile)) {
+		free(tmpfile);
+		return -1;
+	}
 	free(tmpfile);
 
 	if (!oidcmp(&old_oid, &new_oid))
@@ -310,7 +345,7 @@ static int edit_and_replace(const char *object_ref, int force, int raw)
 	return replace_object_oid(object_ref, &old_oid, "replacement", &new_oid, force);
 }
 
-static void replace_parents(struct strbuf *buf, int argc, const char **argv)
+static int replace_parents(struct strbuf *buf, int argc, const char **argv)
 {
 	struct strbuf new_parents = STRBUF_INIT;
 	const char *parent_start, *parent_end;
@@ -327,9 +362,15 @@ static void replace_parents(struct strbuf *buf, int argc, const char **argv)
 	/* prepare new parents */
 	for (i = 0; i < argc; i++) {
 		struct object_id oid;
-		if (get_oid(argv[i], &oid) < 0)
-			die(_("Not a valid object name: '%s'"), argv[i]);
-		lookup_commit_or_die(&oid, argv[i]);
+		if (get_oid(argv[i], &oid) < 0) {
+			strbuf_release(&new_parents);
+			return error(_("Not a valid object name: '%s'"),
+				     argv[i]);
+		}
+		if (!lookup_commit_reference(&oid)) {
+			strbuf_release(&new_parents);
+			return error(_("could not parse %s"), argv[i]);
+		}
 		strbuf_addf(&new_parents, "parent %s\n", oid_to_hex(&oid));
 	}
 
@@ -338,6 +379,7 @@ static void replace_parents(struct strbuf *buf, int argc, const char **argv)
 		      new_parents.buf, new_parents.len);
 
 	strbuf_release(&new_parents);
+	return 0;
 }
 
 struct check_mergetag_data {
@@ -358,21 +400,23 @@ static int check_one_mergetag(struct commit *commit,
 	hash_object_file(extra->value, extra->len, type_name(OBJ_TAG), &tag_oid);
 	tag = lookup_tag(&tag_oid);
 	if (!tag)
-		die(_("bad mergetag in commit '%s'"), ref);
+		return error(_("bad mergetag in commit '%s'"), ref);
 	if (parse_tag_buffer(tag, extra->value, extra->len))
-		die(_("malformed mergetag in commit '%s'"), ref);
+		return error(_("malformed mergetag in commit '%s'"), ref);
 
 	/* iterate over new parents */
 	for (i = 1; i < mergetag_data->argc; i++) {
 		struct object_id oid;
 		if (get_oid(mergetag_data->argv[i], &oid) < 0)
-			die(_("Not a valid object name: '%s'"), mergetag_data->argv[i]);
+			return error(_("Not a valid object name: '%s'"),
+				     mergetag_data->argv[i]);
 		if (!oidcmp(&tag->tagged->oid, &oid))
 			return 0; /* found */
 	}
 
-	die(_("original commit '%s' contains mergetag '%s' that is discarded; "
-	      "use --edit instead of --graft"), ref, oid_to_hex(&tag_oid));
+	return error(_("original commit '%s' contains mergetag '%s' that is "
+		       "discarded; use --edit instead of --graft"), ref,
+		     oid_to_hex(&tag_oid));
 }
 
 static int check_mergetags(struct commit *commit, int argc, const char **argv)
@@ -394,24 +438,35 @@ static int create_graft(int argc, const char **argv, int force)
 	unsigned long size;
 
 	if (get_oid(old_ref, &old_oid) < 0)
-		die(_("Not a valid object name: '%s'"), old_ref);
-	commit = lookup_commit_or_die(&old_oid, old_ref);
+		return error(_("Not a valid object name: '%s'"), old_ref);
+	commit = lookup_commit_reference(&old_oid);
+	if (!commit)
+		return error(_("could not parse %s"), old_ref);
 
 	buffer = get_commit_buffer(commit, &size);
 	strbuf_add(&buf, buffer, size);
 	unuse_commit_buffer(commit, buffer);
 
-	replace_parents(&buf, argc - 1, &argv[1]);
+	if (replace_parents(&buf, argc - 1, &argv[1]) < 0) {
+		strbuf_release(&buf);
+		return -1;
+	}
 
 	if (remove_signature(&buf)) {
 		warning(_("the original commit '%s' has a gpg signature."), old_ref);
 		warning(_("the signature will be removed in the replacement commit!"));
 	}
 
-	check_mergetags(commit, argc, argv);
+	if (check_mergetags(commit, argc, argv)) {
+		strbuf_release(&buf);
+		return -1;
+	}
 
-	if (write_object_file(buf.buf, buf.len, commit_type, &new_oid))
-		die(_("could not write replacement commit for: '%s'"), old_ref);
+	if (write_object_file(buf.buf, buf.len, commit_type, &new_oid)) {
+		strbuf_release(&buf);
+		return error(_("could not write replacement commit for: '%s'"),
+			     old_ref);
+	}
 
 	strbuf_release(&buf);
 
-- 
2.17.0.windows.1.33.gfcbb1fa0445


