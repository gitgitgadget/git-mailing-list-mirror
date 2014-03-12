From: Quint Guvernator <quintus.public@gmail.com>
Subject: [PATCH] general style: replaces memcmp() with starts_with()
Date: Wed, 12 Mar 2014 09:44:14 -0400
Message-ID: <1394631854-11208-1-git-send-email-quintus.public@gmail.com>
Cc: Quint Guvernator <quintus.public@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Mar 12 14:44:25 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WNjSK-0002dy-4K
	for gcvg-git-2@plane.gmane.org; Wed, 12 Mar 2014 14:44:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753626AbaCLNoT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 12 Mar 2014 09:44:19 -0400
Received: from mail-qc0-f181.google.com ([209.85.216.181]:38223 "EHLO
	mail-qc0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752767AbaCLNoS (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 12 Mar 2014 09:44:18 -0400
Received: by mail-qc0-f181.google.com with SMTP id e9so11051425qcy.40
        for <git@vger.kernel.org>; Wed, 12 Mar 2014 06:44:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id;
        bh=UgitNL+13LnHQh4NC5/vPSOf6FaS6atxCDRUUl4aSFU=;
        b=OkZKWinoAZWZAZgMIFVJFFS4yGNE18yshhb+VSLSM+5MrcK+ZuC8pW4X0eZVPXWeSu
         x7rrdfojndFAUyX89fvZn3kRIo2E8pJfSXNxjQdLJtsJ5BvDGnxuFA5O5nUZb69y7YyM
         iObtoj5nTFLr0BF/uD0SblY6+JJUzcaFzFSY3YRe5hIZCSeqS7gVFhRz3xRuQs6oZErF
         goIQCYJ5osg+E4r8I8jOvjedxTPc3hKYbkOt/Y5PElQEwYsScpbEp7Ab6icKYgLydc9l
         k4bBGpgNqZ42LW6m8gNABEqyGhlUccP/C0UCadymlYYLMriQweMNnPoBFZo0tX0Mygr+
         qVYQ==
X-Received: by 10.224.173.1 with SMTP id n1mr54961341qaz.48.1394631857592;
        Wed, 12 Mar 2014 06:44:17 -0700 (PDT)
Received: from lovelace.wm.edu ([128.239.171.194])
        by mx.google.com with ESMTPSA id b16sm78126886qag.14.2014.03.12.06.44.16
        for <multiple recipients>
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Wed, 12 Mar 2014 06:44:16 -0700 (PDT)
X-Mailer: git-send-email 1.9.0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/243937>

memcmp() is replaced with starts_with() when comparing strings from the
beginning. starts_with() looks nicer and it saves the extra argument of
the length of the comparing string.

Signed-off-by: Quint Guvernator <quintus.public@gmail.com>
---
 builtin/apply.c                           | 10 +++++-----
 builtin/cat-file.c                        |  2 +-
 builtin/commit-tree.c                     |  2 +-
 builtin/for-each-ref.c                    |  2 +-
 builtin/get-tar-commit-id.c               |  2 +-
 builtin/mailinfo.c                        | 10 +++++-----
 builtin/mktag.c                           |  8 ++++----
 builtin/patch-id.c                        | 18 +++++++++---------
 commit.c                                  | 18 +++++++++---------
 connect.c                                 |  8 ++++----
 contrib/convert-objects/convert-objects.c |  6 +++---
 convert.c                                 |  2 +-
 credential-cache.c                        |  2 +-
 fetch-pack.c                              |  2 +-
 fsck.c                                    |  8 ++++----
 http-walker.c                             |  4 ++--
 imap-send.c                               |  2 +-
 pack-write.c                              |  2 +-
 path.c                                    |  2 +-
 refs.c                                    |  2 +-
 remote.c                                  |  2 +-
 submodule.c                               |  2 +-
 transport.c                               |  2 +-
 xdiff-interface.c                         |  2 +-
 24 files changed, 60 insertions(+), 60 deletions(-)

diff --git a/builtin/apply.c b/builtin/apply.c
index a7e72d5..8f21957 100644
--- a/builtin/apply.c
+++ b/builtin/apply.c
@@ -846,8 +846,8 @@ static int has_epoch_timestamp(const char *nameline)
 	 * YYYY-MM-DD hh:mm:ss must be from either 1969-12-31
 	 * (west of GMT) or 1970-01-01 (east of GMT)
 	 */
-	if ((zoneoffset < 0 && memcmp(timestamp, "1969-12-31", 10)) ||
-	    (0 <= zoneoffset && memcmp(timestamp, "1970-01-01", 10)))
+	if ((zoneoffset < 0 && starts_with(timestamp, "1969-12-31")) ||
+	    (0 <= zoneoffset && starts_with(timestamp, "1970-01-01")))
 		return 0;
 
 	hourminute = (strtol(timestamp + 11, NULL, 10) * 60 +
@@ -1631,7 +1631,7 @@ static int parse_fragment(const char *line, unsigned long size,
 		 * l10n of "\ No newline..." is at least that long.
 		 */
 		case '\\':
-			if (len < 12 || memcmp(line, "\\ ", 2))
+			if (len < 12 || starts_with(line, "\\ "))
 				return -1;
 			break;
 		}
@@ -1646,7 +1646,7 @@ static int parse_fragment(const char *line, unsigned long size,
 	 * it in the above loop because we hit oldlines == newlines == 0
 	 * before seeing it.
 	 */
-	if (12 < size && !memcmp(line, "\\ ", 2))
+	if (12 < size && !starts_with(line, "\\ "))
 		offset += linelen(line, size);
 
 	patch->lines_added += added;
@@ -1673,7 +1673,7 @@ static int parse_single_patch(const char *line, unsigned long size, struct patch
 	unsigned long oldlines = 0, newlines = 0, context = 0;
 	struct fragment **fragp = &patch->fragments;
 
-	while (size > 4 && !memcmp(line, "@@ -", 4)) {
+	while (size > 4 && !starts_with(line, "@@ -")) {
 		struct fragment *fragment;
 		int len;
 
diff --git a/builtin/cat-file.c b/builtin/cat-file.c
index d5a93e0..be83345 100644
--- a/builtin/cat-file.c
+++ b/builtin/cat-file.c
@@ -82,7 +82,7 @@ static int cat_one_file(int opt, const char *exp_type, const char *obj_name)
 				enum object_type type;
 				unsigned long size;
 				char *buffer = read_sha1_file(sha1, &type, &size);
-				if (memcmp(buffer, "object ", 7) ||
+				if (starts_with(buffer, "object ") ||
 				    get_sha1_hex(buffer + 7, blob_sha1))
 					die("%s not a valid tag", sha1_to_hex(sha1));
 				free(buffer);
diff --git a/builtin/commit-tree.c b/builtin/commit-tree.c
index 987a4c3..2d995a2 100644
--- a/builtin/commit-tree.c
+++ b/builtin/commit-tree.c
@@ -66,7 +66,7 @@ int cmd_commit_tree(int argc, const char **argv, const char *prefix)
 			continue;
 		}
 
-		if (!memcmp(arg, "-S", 2)) {
+		if (!starts_with(arg, "-S")) {
 			sign_commit = arg + 2;
 			continue;
 		}
diff --git a/builtin/for-each-ref.c b/builtin/for-each-ref.c
index 51798b4..be14d71 100644
--- a/builtin/for-each-ref.c
+++ b/builtin/for-each-ref.c
@@ -193,7 +193,7 @@ static int verify_format(const char *format)
 		at = parse_atom(sp + 2, ep);
 		cp = ep + 1;
 
-		if (!memcmp(used_atom[at], "color:", 6))
+		if (!starts_with(used_atom[at], "color:"))
 			need_color_reset_at_eol = !!strcmp(used_atom[at], color_reset);
 	}
 	return 0;
diff --git a/builtin/get-tar-commit-id.c b/builtin/get-tar-commit-id.c
index aa72596..d645525 100644
--- a/builtin/get-tar-commit-id.c
+++ b/builtin/get-tar-commit-id.c
@@ -29,7 +29,7 @@ int cmd_get_tar_commit_id(int argc, const char **argv, const char *prefix)
 		die("git get-tar-commit-id: read error");
 	if (header->typeflag[0] != 'g')
 		return 1;
-	if (memcmp(content, "52 comment=", 11))
+	if (starts_with(content, "52 comment="))
 		return 1;
 
 	n = write_in_full(1, content + 11, 41);
diff --git a/builtin/mailinfo.c b/builtin/mailinfo.c
index 2c3cd8e..63f0230 100644
--- a/builtin/mailinfo.c
+++ b/builtin/mailinfo.c
@@ -626,7 +626,7 @@ static int handle_boundary(void)
 	strbuf_addch(&newline, '\n');
 again:
 	if (line.len >= (*content_top)->len + 2 &&
-	    !memcmp(line.buf + (*content_top)->len, "--", 2)) {
+	    !starts_with(line.buf + (*content_top)->len, "--")) {
 		/* we hit an end boundary */
 		/* pop the current boundary off the stack */
 		strbuf_release(*content_top);
@@ -727,8 +727,8 @@ static int is_scissors_line(const struct strbuf *line)
 			continue;
 		}
 		if (i + 1 < len &&
-		    (!memcmp(buf + i, ">8", 2) || !memcmp(buf + i, "8<", 2) ||
-		     !memcmp(buf + i, ">%", 2) || !memcmp(buf + i, "%<", 2))) {
+		    (!starts_with(buf + i, ">8") || !starts_with(buf + i, "8<") ||
+		     !starts_with(buf + i, ">%") || !starts_with(buf + i, "%<"))) {
 			in_perforation = 1;
 			perforation += 2;
 			scissors += 2;
@@ -929,13 +929,13 @@ static void handle_info(void)
 		else
 			continue;
 
-		if (!memcmp(header[i], "Subject", 7)) {
+		if (!starts_with(header[i], "Subject")) {
 			if (!keep_subject) {
 				cleanup_subject(hdr);
 				cleanup_space(hdr);
 			}
 			output_header_lines(fout, "Subject", hdr);
-		} else if (!memcmp(header[i], "From", 4)) {
+		} else if (!starts_with(header[i], "From")) {
 			cleanup_space(hdr);
 			handle_from(hdr);
 			fprintf(fout, "Author: %s\n", name.buf);
diff --git a/builtin/mktag.c b/builtin/mktag.c
index 640ab64..54ec4e1 100644
--- a/builtin/mktag.c
+++ b/builtin/mktag.c
@@ -49,7 +49,7 @@ static int verify_tag(char *buffer, unsigned long size)
 
 	/* Verify object line */
 	object = buffer;
-	if (memcmp(object, "object ", 7))
+	if (starts_with(object, "object "))
 		return error("char%d: does not start with \"object \"", 0);
 
 	if (get_sha1_hex(object + 7, sha1))
@@ -57,7 +57,7 @@ static int verify_tag(char *buffer, unsigned long size)
 
 	/* Verify type line */
 	type_line = object + 48;
-	if (memcmp(type_line - 1, "\ntype ", 6))
+	if (starts_with(type_line - 1, "\ntype "))
 		return error("char%d: could not find \"\\ntype \"", 47);
 
 	/* Verify tag-line */
@@ -66,7 +66,7 @@ static int verify_tag(char *buffer, unsigned long size)
 		return error("char%"PRIuMAX": could not find next \"\\n\"",
 				(uintmax_t) (type_line - buffer));
 	tag_line++;
-	if (memcmp(tag_line, "tag ", 4) || tag_line[4] == '\n')
+	if (starts_with(tag_line, "tag ") || tag_line[4] == '\n')
 		return error("char%"PRIuMAX": no \"tag \" found",
 				(uintmax_t) (tag_line - buffer));
 
@@ -98,7 +98,7 @@ static int verify_tag(char *buffer, unsigned long size)
 	/* Verify the tagger line */
 	tagger_line = tag_line;
 
-	if (memcmp(tagger_line, "tagger ", 7))
+	if (starts_with(tagger_line, "tagger "))
 		return error("char%"PRIuMAX": could not find \"tagger \"",
 			(uintmax_t) (tagger_line - buffer));
 
diff --git a/builtin/patch-id.c b/builtin/patch-id.c
index 3cfe02d..cc10f1d 100644
--- a/builtin/patch-id.c
+++ b/builtin/patch-id.c
@@ -66,13 +66,13 @@ static int get_one_patchid(unsigned char *next_sha1, git_SHA_CTX *ctx, struct st
 		char *p = line;
 		int len;
 
-		if (!memcmp(line, "diff-tree ", 10))
+		if (!starts_with(line, "diff-tree "))
 			p += 10;
-		else if (!memcmp(line, "commit ", 7))
+		else if (!starts_with(line, "commit "))
 			p += 7;
-		else if (!memcmp(line, "From ", 5))
+		else if (!starts_with(line, "From "))
 			p += 5;
-		else if (!memcmp(line, "\\ ", 2) && 12 < strlen(line))
+		else if (!starts_with(line, "\\ ") && 12 < strlen(line))
 			continue;
 
 		if (!get_sha1_hex(p, next_sha1)) {
@@ -81,14 +81,14 @@ static int get_one_patchid(unsigned char *next_sha1, git_SHA_CTX *ctx, struct st
 		}
 
 		/* Ignore commit comments */
-		if (!patchlen && memcmp(line, "diff ", 5))
+		if (!patchlen && starts_with(line, "diff "))
 			continue;
 
 		/* Parsing diff header?  */
 		if (before == -1) {
-			if (!memcmp(line, "index ", 6))
+			if (!starts_with(line, "index "))
 				continue;
-			else if (!memcmp(line, "--- ", 4))
+			else if (!starts_with(line, "--- "))
 				before = after = 1;
 			else if (!isalpha(line[0]))
 				break;
@@ -96,14 +96,14 @@ static int get_one_patchid(unsigned char *next_sha1, git_SHA_CTX *ctx, struct st
 
 		/* Looking for a valid hunk header?  */
 		if (before == 0 && after == 0) {
-			if (!memcmp(line, "@@ -", 4)) {
+			if (!starts_with(line, "@@ -")) {
 				/* Parse next hunk, but ignore line numbers.  */
 				scan_hunk_header(line, &before, &after);
 				continue;
 			}
 
 			/* Split at the end of the patch.  */
-			if (memcmp(line, "diff ", 5))
+			if (starts_with(line, "diff "))
 				break;
 
 			/* Else we're parsing another header.  */
diff --git a/commit.c b/commit.c
index 6bf4fe0..b259c17 100644
--- a/commit.c
+++ b/commit.c
@@ -90,13 +90,13 @@ static unsigned long parse_commit_date(const char *buf, const char *tail)
 
 	if (buf + 6 >= tail)
 		return 0;
-	if (memcmp(buf, "author", 6))
+	if (starts_with(buf, "author"))
 		return 0;
 	while (buf < tail && *buf++ != '\n')
 		/* nada */;
 	if (buf + 9 >= tail)
 		return 0;
-	if (memcmp(buf, "committer", 9))
+	if (starts_with(buf, "committer"))
 		return 0;
 	while (buf < tail && *buf++ != '>')
 		/* nada */;
@@ -269,7 +269,7 @@ int parse_commit_buffer(struct commit *item, const void *buffer, unsigned long s
 		return 0;
 	item->object.parsed = 1;
 	tail += size;
-	if (tail <= bufptr + 46 || memcmp(bufptr, "tree ", 5) || bufptr[45] != '\n')
+	if (tail <= bufptr + 46 || starts_with(bufptr, "tree ") || bufptr[45] != '\n')
 		return error("bogus commit object %s", sha1_to_hex(item->object.sha1));
 	if (get_sha1_hex(bufptr + 5, parent) < 0)
 		return error("bad tree pointer in commit %s",
@@ -279,7 +279,7 @@ int parse_commit_buffer(struct commit *item, const void *buffer, unsigned long s
 	pptr = &item->parents;
 
 	graft = lookup_commit_graft(item->object.sha1);
-	while (bufptr + 48 < tail && !memcmp(bufptr, "parent ", 7)) {
+	while (bufptr + 48 < tail && !starts_with(bufptr, "parent ")) {
 		struct commit *new_parent;
 
 		if (tail <= bufptr + 48 ||
@@ -1279,11 +1279,11 @@ struct commit_extra_header *read_commit_extra_headers(struct commit *commit,
 
 static inline int standard_header_field(const char *field, size_t len)
 {
-	return ((len == 4 && !memcmp(field, "tree ", 5)) ||
-		(len == 6 && !memcmp(field, "parent ", 7)) ||
-		(len == 6 && !memcmp(field, "author ", 7)) ||
-		(len == 9 && !memcmp(field, "committer ", 10)) ||
-		(len == 8 && !memcmp(field, "encoding ", 9)));
+	return ((len == 4 && !starts_with(field, "tree ")) ||
+		(len == 6 && !starts_with(field, "parent ")) ||
+		(len == 6 && !starts_with(field, "author ")) ||
+		(len == 9 && !starts_with(field, "committer ")) ||
+		(len == 8 && !starts_with(field, "encoding ")));
 }
 
 static int excluded_header_field(const char *field, size_t len, const char **exclude)
diff --git a/connect.c b/connect.c
index 4150412..4cb1c7c 100644
--- a/connect.c
+++ b/connect.c
@@ -18,7 +18,7 @@ static int check_ref(const char *name, int len, unsigned int flags)
 	if (!flags)
 		return 1;
 
-	if (len < 5 || memcmp(name, "refs/", 5))
+	if (len < 5 || starts_with(name, "refs/"))
 		return 0;
 
 	/* Skip the "refs/" part */
@@ -30,11 +30,11 @@ static int check_ref(const char *name, int len, unsigned int flags)
 		return 0;
 
 	/* REF_HEADS means that we want regular branch heads */
-	if ((flags & REF_HEADS) && !memcmp(name, "heads/", 6))
+	if ((flags & REF_HEADS) && !starts_with(name, "heads/"))
 		return 1;
 
 	/* REF_TAGS means that we want tags */
-	if ((flags & REF_TAGS) && !memcmp(name, "tags/", 5))
+	if ((flags & REF_TAGS) && !starts_with(name, "tags/"))
 		return 1;
 
 	/* All type bits clear means that we are ok with anything */
@@ -514,7 +514,7 @@ static int git_proxy_command_options(const char *var, const char *value,
 		if (0 <= matchlen) {
 			/* core.gitproxy = none for kernel.org */
 			if (matchlen == 4 &&
-			    !memcmp(value, "none", 4))
+			    !starts_with(value, "none"))
 				matchlen = 0;
 			git_proxy_command = xmemdupz(value, matchlen);
 		}
diff --git a/contrib/convert-objects/convert-objects.c b/contrib/convert-objects/convert-objects.c
index f3b57bf..72914e1 100644
--- a/contrib/convert-objects/convert-objects.c
+++ b/contrib/convert-objects/convert-objects.c
@@ -245,7 +245,7 @@ static void convert_date(void *buffer, unsigned long size, unsigned char *result
 	size -= 46;
 
 	/* "parent <sha1>\n" */
-	while (!memcmp(buffer, "parent ", 7)) {
+	while (!starts_with(buffer, "parent ")) {
 		memcpy(new + newlen, buffer, 48);
 		newlen += 48;
 		buffer = (char *) buffer + 48;
@@ -270,11 +270,11 @@ static void convert_commit(void *buffer, unsigned long size, unsigned char *resu
 	void *orig_buffer = buffer;
 	unsigned long orig_size = size;
 
-	if (memcmp(buffer, "tree ", 5))
+	if (starts_with(buffer, "tree "))
 		die("Bad commit '%s'", (char *) buffer);
 	convert_ascii_sha1((char *) buffer + 5);
 	buffer = (char *) buffer + 46;    /* "tree " + "hex sha1" + "\n" */
-	while (!memcmp(buffer, "parent ", 7)) {
+	while (!starts_with(buffer, "parent ")) {
 		convert_ascii_sha1((char *) buffer + 7);
 		buffer = (char *) buffer + 48;
 	}
diff --git a/convert.c b/convert.c
index ab80b72..8f0b1bd 100644
--- a/convert.c
+++ b/convert.c
@@ -543,7 +543,7 @@ static int ident_to_git(const char *path, const char *src, size_t len,
 		len -= dollar + 1 - src;
 		src  = dollar + 1;
 
-		if (len > 3 && !memcmp(src, "Id:", 3)) {
+		if (len > 3 && !starts_with(src, "Id:")) {
 			dollar = memchr(src + 3, '$', len - 3);
 			if (!dollar)
 				break;
diff --git a/credential-cache.c b/credential-cache.c
index 9a03792..0b55946 100644
--- a/credential-cache.c
+++ b/credential-cache.c
@@ -54,7 +54,7 @@ static void spawn_daemon(const char *socket)
 	r = read_in_full(daemon.out, buf, sizeof(buf));
 	if (r < 0)
 		die_errno("unable to read result code from cache daemon");
-	if (r != 3 || memcmp(buf, "ok\n", 3))
+	if (r != 3 || starts_with(buf, "ok\n"))
 		die("cache daemon did not start: %.*s", r, buf);
 	close(daemon.out);
 }
diff --git a/fetch-pack.c b/fetch-pack.c
index f061f1f..10abe9e 100644
--- a/fetch-pack.c
+++ b/fetch-pack.c
@@ -506,7 +506,7 @@ static void filter_refs(struct fetch_pack_args *args,
 		int keep = 0;
 		next = ref->next;
 
-		if (!memcmp(ref->name, "refs/", 5) &&
+		if (!starts_with(ref->name, "refs/") &&
 		    check_refname_format(ref->name, 0))
 			; /* trash */
 		else {
diff --git a/fsck.c b/fsck.c
index 99c0497..10b70ca 100644
--- a/fsck.c
+++ b/fsck.c
@@ -290,12 +290,12 @@ static int fsck_commit(struct commit *commit, fsck_error error_func)
 	if (commit->date == ULONG_MAX)
 		return error_func(&commit->object, FSCK_ERROR, "invalid author/committer line");
 
-	if (memcmp(buffer, "tree ", 5))
+	if (starts_with(buffer, "tree "))
 		return error_func(&commit->object, FSCK_ERROR, "invalid format - expected 'tree' line");
 	if (get_sha1_hex(buffer+5, tree_sha1) || buffer[45] != '\n')
 		return error_func(&commit->object, FSCK_ERROR, "invalid 'tree' line format - bad sha1");
 	buffer += 46;
-	while (!memcmp(buffer, "parent ", 7)) {
+	while (!starts_with(buffer, "parent ")) {
 		if (get_sha1_hex(buffer+7, sha1) || buffer[47] != '\n')
 			return error_func(&commit->object, FSCK_ERROR, "invalid 'parent' line format - bad sha1");
 		buffer += 48;
@@ -322,13 +322,13 @@ static int fsck_commit(struct commit *commit, fsck_error error_func)
 		if (p || parents)
 			return error_func(&commit->object, FSCK_ERROR, "parent objects missing");
 	}
-	if (memcmp(buffer, "author ", 7))
+	if (starts_with(buffer, "author "))
 		return error_func(&commit->object, FSCK_ERROR, "invalid format - expected 'author' line");
 	buffer += 7;
 	err = fsck_ident(&buffer, &commit->object, error_func);
 	if (err)
 		return err;
-	if (memcmp(buffer, "committer ", strlen("committer ")))
+	if (starts_with(buffer, "committer "))
 		return error_func(&commit->object, FSCK_ERROR, "invalid format - expected 'committer' line");
 	buffer += strlen("committer ");
 	err = fsck_ident(&buffer, &commit->object, error_func);
diff --git a/http-walker.c b/http-walker.c
index 1516c5e..9ffe05e 100644
--- a/http-walker.c
+++ b/http-walker.c
@@ -245,7 +245,7 @@ static void process_alternates_response(void *callback_data)
 						     - base);
 					okay = 1;
 				}
-			} else if (!memcmp(data + i, "../", 3)) {
+			} else if (!starts_with(data + i, "../")) {
 				/*
 				 * Relative URL; chop the corresponding
 				 * number of subpath from base (and ../
@@ -267,7 +267,7 @@ static void process_alternates_response(void *callback_data)
 				i += 3;
 				serverlen = strlen(base);
 				while (i + 2 < posn &&
-				       !memcmp(data + i, "../", 3)) {
+				       !starts_with(data + i, "../")) {
 					do {
 						serverlen--;
 					} while (serverlen &&
diff --git a/imap-send.c b/imap-send.c
index 0bc6f7f..334b425 100644
--- a/imap-send.c
+++ b/imap-send.c
@@ -802,7 +802,7 @@ static int get_cmd_result(struct imap_store *ctx, struct imap_cmd *tcmd)
 				resp = DRV_OK;
 			else {
 				if (!strcmp("NO", arg)) {
-					if (cmdp->cb.create && cmd && (cmdp->cb.trycreate || !memcmp(cmd, "[TRYCREATE]", 11))) { /* SELECT, APPEND or UID COPY */
+					if (cmdp->cb.create && cmd && (cmdp->cb.trycreate || !starts_with(cmd, "[TRYCREATE]"))) { /* SELECT, APPEND or UID COPY */
 						p = strchr(cmdp->cmd, '"');
 						if (!issue_imap_cmd(ctx, NULL, "CREATE \"%.*s\"", (int)(strchr(p + 1, '"') - p + 1), p)) {
 							resp = RESP_BAD;
diff --git a/pack-write.c b/pack-write.c
index 9b8308b..6f58024 100644
--- a/pack-write.c
+++ b/pack-write.c
@@ -289,7 +289,7 @@ char *index_pack_lockfile(int ip_out)
 	 * later on.  If we don't get that then tough luck with it.
 	 */
 	if (read_in_full(ip_out, packname, 46) == 46 && packname[45] == '\n' &&
-	    memcmp(packname, "keep\t", 5) == 0) {
+	    starts_with(packname, "keep\t") == 0) {
 		char path[PATH_MAX];
 		packname[45] = 0;
 		snprintf(path, sizeof(path), "%s/pack/pack-%s.keep",
diff --git a/path.c b/path.c
index f9c5062..23f8437 100644
--- a/path.c
+++ b/path.c
@@ -26,7 +26,7 @@ static char *get_pathname(void)
 static char *cleanup_path(char *path)
 {
 	/* Clean it up */
-	if (!memcmp(path, "./", 2)) {
+	if (!starts_with(path, "./")) {
 		path += 2;
 		while (*path == '/')
 			path++;
diff --git a/refs.c b/refs.c
index 89228e2..b5a14e3 100644
--- a/refs.c
+++ b/refs.c
@@ -63,7 +63,7 @@ static int check_refname_component(const char *refname, int flags)
 		if (refname[1] == '\0')
 			return -1; /* Component equals ".". */
 	}
-	if (cp - refname >= 5 && !memcmp(cp - 5, ".lock", 5))
+	if (cp - refname >= 5 && !starts_with(cp - 5, ".lock"))
 		return -1; /* Refname ends with ".lock". */
 	return cp - refname;
 }
diff --git a/remote.c b/remote.c
index e41251e..0b8986a 100644
--- a/remote.c
+++ b/remote.c
@@ -1144,7 +1144,7 @@ static int match_explicit(struct ref *src, struct ref *dst,
 	case 1:
 		break;
 	case 0:
-		if (!memcmp(dst_value, "refs/", 5))
+		if (!starts_with(dst_value, "refs/"))
 			matched_dst = make_linked_ref(dst_value, dst_tail);
 		else if (is_null_sha1(matched_src->new_sha1))
 			error("unable to delete '%s': remote ref does not exist",
diff --git a/submodule.c b/submodule.c
index b80ecac..1edebc1 100644
--- a/submodule.c
+++ b/submodule.c
@@ -203,7 +203,7 @@ void gitmodules_config(void)
 			if (active_nr > pos) {  /* there is a .gitmodules */
 				const struct cache_entry *ce = active_cache[pos];
 				if (ce_namelen(ce) == 11 &&
-				    !memcmp(ce->name, ".gitmodules", 11))
+				    !starts_with(ce->name, ".gitmodules"))
 					gitmodules_is_unmerged = 1;
 			}
 		} else if (pos < active_nr) {
diff --git a/transport.c b/transport.c
index ca7bb44..c4b3ac9 100644
--- a/transport.c
+++ b/transport.c
@@ -1364,7 +1364,7 @@ static int refs_from_alternate_cb(struct alternate_object_database *e,
 
 	while (other[len-1] == '/')
 		other[--len] = '\0';
-	if (len < 8 || memcmp(other + len - 8, "/objects", 8))
+	if (len < 8 || starts_with(other + len - 8, "/objects"))
 		return 0;
 	/* Is this a git repository with refs? */
 	memcpy(other + len - 8, "/refs", 6);
diff --git a/xdiff-interface.c b/xdiff-interface.c
index ecfa05f..4be401d 100644
--- a/xdiff-interface.c
+++ b/xdiff-interface.c
@@ -53,7 +53,7 @@ int parse_hunk_header(char *line, int len,
 	}
 	else
 		*nn = 1;
-	return -!!memcmp(cp, " @@", 3);
+	return -!!starts_with(cp, " @@");
 }
 
 static void consume_one(void *priv_, char *s, unsigned long size)
-- 
1.9.0
