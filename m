From: Stephen Boyd <bebarino@gmail.com>
Subject: [PATCH 8/7] Make string_list_append() consistent with everything else
Date: Wed, 31 Mar 2010 23:29:39 -0700
Message-ID: <1270103379-3686-1-git-send-email-bebarino@gmail.com>
References: <7vzl1qwfno.fsf@alter.siamese.dyndns.org>
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Apr 01 08:30:02 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NxDui-0002nO-Ml
	for gcvg-git-2@lo.gmane.org; Thu, 01 Apr 2010 08:30:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753559Ab0DAG3y (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 1 Apr 2010 02:29:54 -0400
Received: from mail-yx0-f199.google.com ([209.85.210.199]:37632 "EHLO
	mail-yx0-f199.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753456Ab0DAG3q (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 1 Apr 2010 02:29:46 -0400
Received: by yxe37 with SMTP id 37so338026yxe.21
        for <git@vger.kernel.org>; Wed, 31 Mar 2010 23:29:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=8hN6WtzQkSvT1fRXeEq40OtdGi+WdAoio7nm8f9e8RQ=;
        b=Rx+0GBgf5JXzpImhxDc+9k+HodpcjW9mUrb+aQM2U3VN5Pgr+xR8w/NMQMqjCptZ0P
         gM1u4Z5PgroPOw0rxdK5qvU9lRwiB9NudJRWJpqoOokNjiIO9GBrQywR9spHrbhdr7+X
         ysHoSEsq2nWzSB4hNpE3VBmuDg9UvH0BpksKY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=A0BhioIBDb6337UMMsVGu5KUB5D3Rf58cJvcPw7neIrgaH47ZW/uj5a6x4pf3ftPPO
         IXggcohCCAlhNlWmmlAA5FlWP/M8lUVqeruMdSSAnuwKWTCjjOcuz73W1P4kAoA7pFTA
         YQApD5hcuxP+Ibj8Am9ckpM0m7vbgKTWXmRdE=
Received: by 10.101.8.32 with SMTP id l32mr1685293ani.115.1270103384377;
        Wed, 31 Mar 2010 23:29:44 -0700 (PDT)
Received: from localhost (user-0c9haca.cable.mindspring.com [24.152.169.138])
        by mx.google.com with ESMTPS id j42sm7825542ibr.1.2010.03.31.23.29.41
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 31 Mar 2010 23:29:43 -0700 (PDT)
X-Mailer: git-send-email 1.7.0.3.313.g87b3c
In-Reply-To: <7vzl1qwfno.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/143718>

string_list_append() is the only function in the string_list API which takes
the struct string_list as the second argument instead of the first. Swap the
ordering to make the string_list API consistent.

This was mostly done with

 $ git grep -lz 'string_list_append' |
   xargs -0 perl -pi -e
   's/string_list_append\((.*), ([^)]+)\)/string_list_append\($2, $1)/'

and then some minor fixups and manual verification.

Signed-off-by: Stephen Boyd <bebarino@gmail.com>
---

 On 03/29/2010 10:18 PM, Junio C Hamano wrote:
 > Stephen Boyd <bebarino@gmail.com> writes:
 >
 >> Anyone else annoyed that string_list_append() is the only function
 >> that takes doesn't take the string list as the first argument?
 >
 > Yes.

 This swaps it.

 Documentation/technical/api-string-list.txt |    4 +-
 builtin/apply.c                             |    2 +-
 builtin/fast-export.c                       |    4 +-
 builtin/fetch.c                             |    8 ++--
 builtin/fmt-merge-msg.c                     |   18 +++++-----
 builtin/log.c                               |   20 ++++++------
 builtin/remote.c                            |   46 +++++++++++++-------------
 builtin/rerere.c                            |    2 +-
 builtin/shortlog.c                          |    2 +-
 notes.c                                     |    6 ++--
 remote.c                                    |    2 +-
 revision.c                                  |    4 +-
 string-list.c                               |    2 +-
 string-list.h                               |    2 +-
 14 files changed, 61 insertions(+), 61 deletions(-)

diff --git a/Documentation/technical/api-string-list.txt b/Documentation/technical/api-string-list.txt
index 6d8c24b..3f575bd 100644
--- a/Documentation/technical/api-string-list.txt
+++ b/Documentation/technical/api-string-list.txt
@@ -38,8 +38,8 @@ struct string_list list;
 int i;
 
 memset(&list, 0, sizeof(struct string_list));
-string_list_append("foo", &list);
-string_list_append("bar", &list);
+string_list_append(&list, "foo");
+string_list_append(&list, "bar");
 for (i = 0; i < list.nr; i++)
 	printf("%s\n", list.items[i].string)
 ----
diff --git a/builtin/apply.c b/builtin/apply.c
index 7ca9047..2d02d17 100644
--- a/builtin/apply.c
+++ b/builtin/apply.c
@@ -3404,7 +3404,7 @@ static void add_name_limit(const char *name, int exclude)
 {
 	struct string_list_item *it;
 
-	it = string_list_append(name, &limit_by_name);
+	it = string_list_append(&limit_by_name, name);
 	it->util = exclude ? NULL : (void *) 1;
 }
 
diff --git a/builtin/fast-export.c b/builtin/fast-export.c
index b0a4029..b353861 100644
--- a/builtin/fast-export.c
+++ b/builtin/fast-export.c
@@ -438,7 +438,7 @@ static void get_tags_and_duplicates(struct object_array *pending,
 			/* handle nested tags */
 			while (tag && tag->object.type == OBJ_TAG) {
 				parse_object(tag->object.sha1);
-				string_list_append(full_name, extra_refs)->util = tag;
+				string_list_append(extra_refs, full_name)->util = tag;
 				tag = (struct tag *)tag->tagged;
 			}
 			if (!tag)
@@ -464,7 +464,7 @@ static void get_tags_and_duplicates(struct object_array *pending,
 		}
 		if (commit->util)
 			/* more than one name for the same object */
-			string_list_append(full_name, extra_refs)->util = commit;
+			string_list_append(extra_refs, full_name)->util = commit;
 		else
 			commit->util = full_name;
 	}
diff --git a/builtin/fetch.c b/builtin/fetch.c
index 957be9f..e29fff0 100644
--- a/builtin/fetch.c
+++ b/builtin/fetch.c
@@ -745,7 +745,7 @@ static int get_one_remote_for_fetch(struct remote *remote, void *priv)
 {
 	struct string_list *list = priv;
 	if (!remote->skip_default_update)
-		string_list_append(remote->name, list);
+		string_list_append(list, remote->name);
 	return 0;
 }
 
@@ -764,8 +764,8 @@ static int get_remote_group(const char *key, const char *value, void *priv)
 		int space = strcspn(value, " \t\n");
 		while (*value) {
 			if (space > 1) {
-				string_list_append(xstrndup(value, space),
-						   g->list);
+				string_list_append(g->list,
+						   xstrndup(value, space));
 			}
 			value += space + (value[space] != '\0');
 			space = strcspn(value, " \t\n");
@@ -786,7 +786,7 @@ static int add_remote_or_group(const char *name, struct string_list *list)
 		if (!remote_is_configured(name))
 			return 0;
 		remote = remote_get(name);
-		string_list_append(remote->name, list);
+		string_list_append(list, remote->name);
 	}
 	return 1;
 }
diff --git a/builtin/fmt-merge-msg.c b/builtin/fmt-merge-msg.c
index 379a031..6012012 100644
--- a/builtin/fmt-merge-msg.c
+++ b/builtin/fmt-merge-msg.c
@@ -82,7 +82,7 @@ static int handle_line(char *line)
 
 	item = unsorted_string_list_lookup(&srcs, src);
 	if (!item) {
-		item = string_list_append(src, &srcs);
+		item = string_list_append(&srcs, src);
 		item->util = xcalloc(1, sizeof(struct src_data));
 		init_src_data(item->util);
 	}
@@ -93,19 +93,19 @@ static int handle_line(char *line)
 		src_data->head_status |= 1;
 	} else if (!prefixcmp(line, "branch ")) {
 		origin = line + 7;
-		string_list_append(origin, &src_data->branch);
+		string_list_append(&src_data->branch, origin);
 		src_data->head_status |= 2;
 	} else if (!prefixcmp(line, "tag ")) {
 		origin = line;
-		string_list_append(origin + 4, &src_data->tag);
+		string_list_append(&src_data->tag, origin + 4);
 		src_data->head_status |= 2;
 	} else if (!prefixcmp(line, "remote branch ")) {
 		origin = line + 14;
-		string_list_append(origin, &src_data->r_branch);
+		string_list_append(&src_data->r_branch, origin);
 		src_data->head_status |= 2;
 	} else {
 		origin = src;
-		string_list_append(line, &src_data->generic);
+		string_list_append(&src_data->generic, line);
 		src_data->head_status |= 2;
 	}
 
@@ -118,7 +118,7 @@ static int handle_line(char *line)
 		sprintf(new_origin, "%s of %s", origin, src);
 		origin = new_origin;
 	}
-	string_list_append(origin, &origins)->util = sha1;
+	string_list_append(&origins, origin)->util = sha1;
 	return 0;
 }
 
@@ -176,10 +176,10 @@ static void shortlog(const char *name, unsigned char *sha1,
 		strbuf_ltrim(&sb);
 
 		if (!sb.len)
-			string_list_append(sha1_to_hex(commit->object.sha1),
-					   &subjects);
+			string_list_append(&subjects,
+					   sha1_to_hex(commit->object.sha1));
 		else
-			string_list_append(strbuf_detach(&sb, NULL), &subjects);
+			string_list_append(&subjects, strbuf_detach(&sb, NULL));
 	}
 
 	if (count > limit)
diff --git a/builtin/log.c b/builtin/log.c
index a8dd8c9..8e9be47 100644
--- a/builtin/log.c
+++ b/builtin/log.c
@@ -497,13 +497,13 @@ static void add_header(const char *value)
 		len--;
 
 	if (!strncasecmp(value, "to: ", 4)) {
-		item = string_list_append(value + 4, &extra_to);
+		item = string_list_append(&extra_to, value + 4);
 		len -= 4;
 	} else if (!strncasecmp(value, "cc: ", 4)) {
-		item = string_list_append(value + 4, &extra_cc);
+		item = string_list_append(&extra_cc, value + 4);
 		len -= 4;
 	} else {
-		item = string_list_append(value, &extra_hdr);
+		item = string_list_append(&extra_hdr, value);
 	}
 
 	item->string[len] = '\0';
@@ -527,13 +527,13 @@ static int git_format_config(const char *var, const char *value, void *cb)
 	if (!strcmp(var, "format.to")) {
 		if (!value)
 			return config_error_nonbool(var);
-		string_list_append(value, &extra_to);
+		string_list_append(&extra_to, value);
 		return 0;
 	}
 	if (!strcmp(var, "format.cc")) {
 		if (!value)
 			return config_error_nonbool(var);
-		string_list_append(value, &extra_cc);
+		string_list_append(&extra_cc, value);
 		return 0;
 	}
 	if (!strcmp(var, "diff.color") || !strcmp(var, "color.diff")) {
@@ -911,7 +911,7 @@ static int to_callback(const struct option *opt, const char *arg, int unset)
 	if (unset)
 		string_list_clear(&extra_to, 0);
 	else
-		string_list_append(arg, &extra_to);
+		string_list_append(&extra_to, arg);
 	return 0;
 }
 
@@ -920,7 +920,7 @@ static int cc_callback(const struct option *opt, const char *arg, int unset)
 	if (unset)
 		string_list_clear(&extra_cc, 0);
 	else
-		string_list_append(arg, &extra_cc);
+		string_list_append(&extra_cc, arg);
 	return 0;
 }
 
@@ -1194,7 +1194,7 @@ int cmd_format_patch(int argc, const char **argv, const char *prefix)
 		rev.ref_message_ids = xcalloc(1, sizeof(struct string_list));
 	if (in_reply_to) {
 		const char *msgid = clean_message_id(in_reply_to);
-		string_list_append(msgid, rev.ref_message_ids);
+		string_list_append(rev.ref_message_ids, msgid);
 	}
 	rev.numbered_files = numbered_files;
 	rev.patch_suffix = fmt_patch_suffix;
@@ -1241,8 +1241,8 @@ int cmd_format_patch(int argc, const char **argv, const char *prefix)
 				    && (!cover_letter || rev.nr > 1))
 					free(rev.message_id);
 				else
-					string_list_append(rev.message_id,
-							   rev.ref_message_ids);
+					string_list_append(rev.ref_message_ids,
+							   rev.message_id);
 			}
 			gen_message_id(&rev, sha1_to_hex(commit->object.sha1));
 		}
diff --git a/builtin/remote.c b/builtin/remote.c
index 277765b..cc7247a 100644
--- a/builtin/remote.c
+++ b/builtin/remote.c
@@ -87,7 +87,7 @@ static int opt_parse_track(const struct option *opt, const char *arg, int not)
 	if (not)
 		string_list_clear(list, 0);
 	else
-		string_list_append(arg, list);
+		string_list_append(list, arg);
 	return 0;
 }
 
@@ -149,7 +149,7 @@ static int add(int argc, const char **argv)
 	strbuf_addf(&buf, "remote.%s.fetch", name);
 
 	if (track.nr == 0)
-		string_list_append("*", &track);
+		string_list_append(&track, "*");
 	for (i = 0; i < track.nr; i++) {
 		struct string_list_item *item = track.items + i;
 
@@ -247,11 +247,11 @@ static int config_read_branches(const char *key, const char *value, void *cb)
 			while (space) {
 				char *merge;
 				merge = xstrndup(value, space - value);
-				string_list_append(merge, &info->merge);
+				string_list_append(&info->merge, merge);
 				value = abbrev_branch(space + 1);
 				space = strchr(value, ' ');
 			}
-			string_list_append(xstrdup(value), &info->merge);
+			string_list_append(&info->merge, xstrdup(value));
 		} else
 			info->rebase = git_config_bool(orig_key, value);
 	}
@@ -288,14 +288,14 @@ static int get_ref_states(const struct ref *remote_refs, struct ref_states *stat
 	for (ref = fetch_map; ref; ref = ref->next) {
 		unsigned char sha1[20];
 		if (!ref->peer_ref || read_ref(ref->peer_ref->name, sha1))
-			string_list_append(abbrev_branch(ref->name), &states->new);
+			string_list_append(&states->new, abbrev_branch(ref->name));
 		else
-			string_list_append(abbrev_branch(ref->name), &states->tracked);
+			string_list_append(&states->tracked, abbrev_branch(ref->name));
 	}
 	stale_refs = get_stale_heads(states->remote, fetch_map);
 	for (ref = stale_refs; ref; ref = ref->next) {
 		struct string_list_item *item =
-			string_list_append(abbrev_branch(ref->name), &states->stale);
+			string_list_append(&states->stale, abbrev_branch(ref->name));
 		item->util = xstrdup(ref->name);
 	}
 	free_refs(stale_refs);
@@ -344,8 +344,8 @@ static int get_push_ref_states(const struct ref *remote_refs,
 			continue;
 		hashcpy(ref->new_sha1, ref->peer_ref->new_sha1);
 
-		item = string_list_append(abbrev_branch(ref->peer_ref->name),
-					  &states->push);
+		item = string_list_append(&states->push,
+					  abbrev_branch(ref->peer_ref->name));
 		item->util = xcalloc(sizeof(struct push_info), 1);
 		info = item->util;
 		info->forced = ref->force;
@@ -380,7 +380,7 @@ static int get_push_ref_states_noquery(struct ref_states *states)
 
 	states->push.strdup_strings = 1;
 	if (!remote->push_refspec_nr) {
-		item = string_list_append("(matching)", &states->push);
+		item = string_list_append(&states->push, "(matching)");
 		info = item->util = xcalloc(sizeof(struct push_info), 1);
 		info->status = PUSH_STATUS_NOTQUERIED;
 		info->dest = xstrdup(item->string);
@@ -388,11 +388,11 @@ static int get_push_ref_states_noquery(struct ref_states *states)
 	for (i = 0; i < remote->push_refspec_nr; i++) {
 		struct refspec *spec = remote->push + i;
 		if (spec->matching)
-			item = string_list_append("(matching)", &states->push);
+			item = string_list_append(&states->push, "(matching)");
 		else if (strlen(spec->src))
-			item = string_list_append(spec->src, &states->push);
+			item = string_list_append(&states->push, spec->src);
 		else
-			item = string_list_append("(delete)", &states->push);
+			item = string_list_append(&states->push, "(delete)");
 
 		info = item->util = xcalloc(sizeof(struct push_info), 1);
 		info->forced = spec->force;
@@ -416,7 +416,7 @@ static int get_head_names(const struct ref *remote_refs, struct ref_states *stat
 	matches = guess_remote_head(find_ref_by_name(remote_refs, "HEAD"),
 				    fetch_map, 1);
 	for (ref = matches; ref; ref = ref->next)
-		string_list_append(abbrev_branch(ref->name), &states->heads);
+		string_list_append(&states->heads, abbrev_branch(ref->name));
 
 	free_refs(fetch_map);
 	free_refs(matches);
@@ -480,8 +480,8 @@ static int add_branch_for_removal(const char *refname,
 	if (prefixcmp(refname, "refs/remotes")) {
 		/* advise user how to delete local branches */
 		if (!prefixcmp(refname, "refs/heads/"))
-			string_list_append(abbrev_branch(refname),
-					   branches->skipped);
+			string_list_append(branches->skipped,
+					   abbrev_branch(refname));
 		/* silently skip over other non-remote refs */
 		return 0;
 	}
@@ -490,7 +490,7 @@ static int add_branch_for_removal(const char *refname,
 	if (flags & REF_ISSYMREF)
 		return unlink(git_path("%s", refname));
 
-	item = string_list_append(refname, branches->branches);
+	item = string_list_append(branches->branches, refname);
 	item->util = xmalloc(20);
 	hashcpy(item->util, sha1);
 
@@ -515,7 +515,7 @@ static int read_remote_branches(const char *refname,
 
 	strbuf_addf(&buf, "refs/remotes/%s", rename->old);
 	if (!prefixcmp(refname, buf.buf)) {
-		item = string_list_append(xstrdup(refname), rename->remote_branches);
+		item = string_list_append(rename->remote_branches, xstrdup(refname));
 		symref = resolve_ref(refname, orig_sha1, 1, &flag);
 		if (flag & REF_ISSYMREF)
 			item->util = xstrdup(symref);
@@ -798,7 +798,7 @@ static int append_ref_to_tracked_list(const char *refname,
 	memset(&refspec, 0, sizeof(refspec));
 	refspec.dst = (char *)refname;
 	if (!remote_find_tracking(states->remote, &refspec))
-		string_list_append(abbrev_branch(refspec.src), &states->tracked);
+		string_list_append(&states->tracked, abbrev_branch(refspec.src));
 
 	return 0;
 }
@@ -946,7 +946,7 @@ static int add_push_to_show_info(struct string_list_item *push_item, void *cb_da
 		show_info->width = n;
 	if ((n = strlen(push_info->dest)) > show_info->width2)
 		show_info->width2 = n;
-	item = string_list_append(push_item->string, show_info->list);
+	item = string_list_append(show_info->list, push_item->string);
 	item->util = push_item->util;
 	return 0;
 }
@@ -1360,10 +1360,10 @@ static int get_one_entry(struct remote *remote, void *priv)
 
 	if (remote->url_nr > 0) {
 		strbuf_addf(&url_buf, "%s (fetch)", remote->url[0]);
-		string_list_append(remote->name, list)->util =
+		string_list_append(list, remote->name)->util =
 				strbuf_detach(&url_buf, NULL);
 	} else
-		string_list_append(remote->name, list)->util = NULL;
+		string_list_append(list, remote->name)->util = NULL;
 	if (remote->pushurl_nr) {
 		url = remote->pushurl;
 		url_nr = remote->pushurl_nr;
@@ -1374,7 +1374,7 @@ static int get_one_entry(struct remote *remote, void *priv)
 	for (i = 0; i < url_nr; i++)
 	{
 		strbuf_addf(&url_buf, "%s (push)", url[i]);
-		string_list_append(remote->name, list)->util =
+		string_list_append(list, remote->name)->util =
 				strbuf_detach(&url_buf, NULL);
 	}
 
diff --git a/builtin/rerere.c b/builtin/rerere.c
index 34f9ace..73610b6 100644
--- a/builtin/rerere.c
+++ b/builtin/rerere.c
@@ -59,7 +59,7 @@ static void garbage_collect(struct string_list *rr)
 		cutoff = (has_rerere_resolution(e->d_name)
 			  ? cutoff_resolve : cutoff_noresolve);
 		if (then < now - cutoff * 86400)
-			string_list_append(e->d_name, &to_remove);
+			string_list_append(&to_remove, e->d_name);
 	}
 	for (i = 0; i < to_remove.nr; i++)
 		unlink_rr_item(to_remove.items[i].string);
diff --git a/builtin/shortlog.c b/builtin/shortlog.c
index 06320f5..e052c17 100644
--- a/builtin/shortlog.c
+++ b/builtin/shortlog.c
@@ -115,7 +115,7 @@ static void insert_one_record(struct shortlog *log,
 		}
 	}
 
-	string_list_append(buffer, item->util);
+	string_list_append(item->util, buffer);
 }
 
 static void read_from_stdin(struct shortlog *log)
diff --git a/notes.c b/notes.c
index e425e19..6556627 100644
--- a/notes.c
+++ b/notes.c
@@ -838,7 +838,7 @@ static int string_list_add_one_ref(const char *path, const unsigned char *sha1,
 {
 	struct string_list *refs = cb;
 	if (!unsorted_string_list_has_string(refs, path))
-		string_list_append(path, refs);
+		string_list_append(refs, path);
 	return 0;
 }
 
@@ -851,7 +851,7 @@ void string_list_add_refs_by_glob(struct string_list *list, const char *glob)
 		if (get_sha1(glob, sha1))
 			warning("notes ref %s is invalid", glob);
 		if (!unsorted_string_list_has_string(list, glob))
-			string_list_append(glob, list);
+			string_list_append(list, glob);
 	}
 }
 
@@ -983,7 +983,7 @@ void init_display_notes(struct display_notes_opt *opt)
 	assert(!display_notes_trees);
 
 	if (!opt || !opt->suppress_default_notes) {
-		string_list_append(default_notes_ref(), &display_notes_refs);
+		string_list_append(&display_notes_refs, default_notes_ref());
 		display_ref_env = getenv(GIT_NOTES_DISPLAY_REF_ENVIRONMENT);
 		if (display_ref_env) {
 			string_list_add_refs_from_colon_sep(&display_notes_refs,
diff --git a/remote.c b/remote.c
index c70181c..498bf38 100644
--- a/remote.c
+++ b/remote.c
@@ -1709,7 +1709,7 @@ struct ref *get_stale_heads(struct remote *remote, struct ref *fetch_map)
 	info.ref_names = &ref_names;
 	info.stale_refs_tail = &stale_refs;
 	for (ref = fetch_map; ref; ref = ref->next)
-		string_list_append(ref->name, &ref_names);
+		string_list_append(&ref_names, ref->name);
 	sort_string_list(&ref_names);
 	for_each_ref(get_stale_heads_cb, &info);
 	string_list_clear(&ref_names, 0);
diff --git a/revision.c b/revision.c
index f4b8b38..28f1c6d 100644
--- a/revision.c
+++ b/revision.c
@@ -1205,8 +1205,8 @@ static int handle_revision_opt(struct rev_info *revs, int argc, const char **arg
 		else
 			strbuf_addstr(&buf, "refs/notes/");
 		strbuf_addstr(&buf, arg+13);
-		string_list_append(strbuf_detach(&buf, NULL),
-				   revs->notes_opt.extra_notes_refs);
+		string_list_append(revs->notes_opt.extra_notes_refs,
+				   strbuf_detach(&buf, NULL));
 	} else if (!strcmp(arg, "--no-notes")) {
 		revs->show_notes = 0;
 		revs->show_notes_given = 1;
diff --git a/string-list.c b/string-list.c
index c9ad7fc..6d29187 100644
--- a/string-list.c
+++ b/string-list.c
@@ -148,7 +148,7 @@ void print_string_list(const char *text, const struct string_list *p)
 		printf("%s:%p\n", p->items[i].string, p->items[i].util);
 }
 
-struct string_list_item *string_list_append(const char *string, struct string_list *list)
+struct string_list_item *string_list_append(struct string_list *list, const char *string)
 {
 	ALLOC_GROW(list->items, list->nr + 1, list->alloc);
 	list->items[list->nr].string =
diff --git a/string-list.h b/string-list.h
index 63b69c8..814bbd3 100644
--- a/string-list.h
+++ b/string-list.h
@@ -35,7 +35,7 @@ struct string_list_item *string_list_insert_at_index(int insert_at,
 struct string_list_item *string_list_lookup(const char *string, struct string_list *list);
 
 /* Use these functions only on unsorted lists: */
-struct string_list_item *string_list_append(const char *string, struct string_list *list);
+struct string_list_item *string_list_append(struct string_list *list, const char *string);
 void sort_string_list(struct string_list *list);
 int unsorted_string_list_has_string(struct string_list *list, const char *string);
 struct string_list_item *unsorted_string_list_lookup(struct string_list *list,
-- 
1.7.0.3.313.g87b3c
