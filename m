From: Andy Parkins <andyparkins@gmail.com>
Subject: [PATCH 3/3] Change all instances of memcmp(buffer, CONSTANT, strlen(CONSTANT) for prefixcmp()
Date: Thu, 4 Oct 2007 22:10:55 +0100
Message-ID: <200710042210.55895.andyparkins@gmail.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Oct 04 23:12:15 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IdXzP-0001dd-22
	for gcvg-git-2@gmane.org; Thu, 04 Oct 2007 23:12:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760880AbXJDVLO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 4 Oct 2007 17:11:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1760648AbXJDVLN
	(ORCPT <rfc822;git-outgoing>); Thu, 4 Oct 2007 17:11:13 -0400
Received: from fk-out-0910.google.com ([209.85.128.185]:53182 "EHLO
	fk-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760880AbXJDVLK (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 4 Oct 2007 17:11:10 -0400
Received: by fk-out-0910.google.com with SMTP id z23so284413fkz
        for <git@vger.kernel.org>; Thu, 04 Oct 2007 14:11:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:from:date:subject:to:x-tuid:x-uid:x-length:mime-version:content-transfer-encoding:content-disposition:message-id;
        bh=zaU1EJx3QQNhLCRwSun7mnimRgrwAOLbn46gBoiRIJY=;
        b=b7IF21Z1h2MgEMvlH1E4ti9d2QtgFvqU7MWZizt/T1BYJIcHkhELf0YinAzVd47omS9JPyE+qSLiTZNDNZhrn0h7LEZvJDgJNf1FuuPxYP+bl/6nr+8BFZL1WdXDrpr/0uOtxjA+8mJGFbMz/5RbSLWuW+6FtQ0W0g9jQcL+NIs=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:from:date:subject:to:x-tuid:x-uid:x-length:mime-version:content-transfer-encoding:content-disposition:message-id;
        b=CS6ioJCkFodhOZZD1IPhkitD7ZDX+lYKSOwr0R4xm5m2+MCsOh4Q+8zYVCDqp/BS8jaBB3PQBFeVaVJlfrJ8FylZ7kJOlKNYYmZVFTkmDsqQdS8TJJF0wR7dt2pncIrzgCh3vKv3VIeThpdZWh2BWanMkq0+08ZUOf31NwLA1KE=
Received: by 10.82.154.12 with SMTP id b12mr18289684bue.1191532267463;
        Thu, 04 Oct 2007 14:11:07 -0700 (PDT)
Received: from grissom.local ( [84.201.153.164])
        by mx.google.com with ESMTPS id 34sm3084611nfu.2007.10.04.14.11.05
        (version=SSLv3 cipher=OTHER);
        Thu, 04 Oct 2007 14:11:06 -0700 (PDT)
X-TUID: ee3545810302cfa0
X-UID: 351
X-Length: 27985
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/60005>

Revision cc44c7655 changed most strncmp() instances for prefixcmp().
That patch missed the functionally equivalent memcmp() calls, that were
candidates for the same change.

This patch changes every memcmp() call where one of the compared strings
is a constant for an appropriate call to prefixcmp().

Signed-off-by: Andy Parkins <andyparkins@gmail.com>
---
 builtin-apply.c                           |   20 ++++++++++----------
 builtin-cat-file.c                        |    2 +-
 builtin-fetch--tool.c                     |    2 +-
 builtin-fsck.c                            |    6 +++---
 builtin-mailinfo.c                        |   22 +++++++++++-----------
 builtin-mailsplit.c                       |    2 +-
 builtin-tar-tree.c                        |    2 +-
 combine-diff.c                            |    2 +-
 commit.c                                  |   14 +++++++-------
 connect.c                                 |    8 ++++----
 contrib/convert-objects/convert-objects.c |    6 +++---
 convert.c                                 |    4 ++--
 fast-import.c                             |    2 +-
 fetch-pack.c                              |    2 +-
 http-fetch.c                              |    4 ++--
 imap-send.c                               |   10 +++++-----
 mktag.c                                   |    8 ++++----
 patch-id.c                                |   10 +++++-----
 path.c                                    |    8 ++++----
 receive-pack.c                            |    2 +-
 refs.c                                    |    4 ++--
 send-pack.c                               |    8 ++++----
 tag.c                                     |    6 +++---
 xdiff-interface.c                         |    2 +-
 24 files changed, 78 insertions(+), 78 deletions(-)

diff --git a/builtin-apply.c b/builtin-apply.c
index 05c6bc3..cac5d65 100644
--- a/builtin-apply.c
+++ b/builtin-apply.c
@@ -205,7 +205,7 @@ static unsigned long linelen(const char *buffer, unsigned long size)
 
 static int is_dev_null(const char *str)
 {
-	return !memcmp("/dev/null", str, 9) && isspace(str[9]);
+	return !prefixcmp(str, "/dev/null") && isspace(str[9]);
 }
 
 #define TERM_SPACE	1
@@ -411,7 +411,7 @@ static char *gitdiff_verify_name(const char *line, int isnull, char *orig_name,
 	}
 	else {
 		/* expect "/dev/null" */
-		if (memcmp("/dev/null", line, 9) || line[9] != '\n')
+		if (prefixcmp(line, "/dev/null") || line[9] != '\n')
 			die("git-apply: bad git-diff - expected /dev/null on line %d", linenr);
 		return NULL;
 	}
@@ -839,7 +839,7 @@ static int find_header(char *line, unsigned long size, int *hdrsize, struct patc
 		 * That's a sign that we didn't find a header, and that a
 		 * patch has become corrupted/broken up.
 		 */
-		if (!memcmp("@@ -", line, 4)) {
+		if (!prefixcmp(line, "@@ -")) {
 			struct fragment dummy;
 			if (parse_fragment_header(line, len, &dummy) < 0)
 				continue;
@@ -854,7 +854,7 @@ static int find_header(char *line, unsigned long size, int *hdrsize, struct patc
 		 * Git patch? It might not have a real patch, just a rename
 		 * or mode change, so we handle that specially
 		 */
-		if (!memcmp("diff --git ", line, 11)) {
+		if (!prefixcmp(line, "diff --git ")) {
 			int git_hdr_len = parse_git_header(line, len, size, patch);
 			if (git_hdr_len <= len)
 				continue;
@@ -869,7 +869,7 @@ static int find_header(char *line, unsigned long size, int *hdrsize, struct patc
 		}
 
 		/** --- followed by +++ ? */
-		if (memcmp("--- ", line,  4) || memcmp("+++ ", line + len, 4))
+		if (prefixcmp(line, "--- ") || prefixcmp(line + len, "+++ "))
 			continue;
 
 		/*
@@ -878,7 +878,7 @@ static int find_header(char *line, unsigned long size, int *hdrsize, struct patc
 		 * minimum
 		 */
 		nextlen = linelen(line + len, size - len);
-		if (size < nextlen + 14 || memcmp("@@ -", line + len + nextlen, 4))
+		if (size < nextlen + 14 || prefixcmp(line + len + nextlen, "@@ -"))
 			continue;
 
 		/* Ok, we'll consider it a patch */
@@ -1003,7 +1003,7 @@ static int parse_fragment(char *line, unsigned long size, struct patch *patch, s
 		 * l10n of "\ No newline..." is at least that long.
 		 */
 		case '\\':
-			if (len < 12 || memcmp(line, "\\ ", 2))
+			if (len < 12 || prefixcmp(line, "\\ "))
 				return -1;
 			break;
 		}
@@ -1017,7 +1017,7 @@ static int parse_fragment(char *line, unsigned long size, struct patch *patch, s
 	 * it in the above loop because we hit oldlines == newlines == 0
 	 * before seeing it.
 	 */
-	if (12 < size && !memcmp(line, "\\ ", 2))
+	if (12 < size && !prefixcmp(line, "\\ "))
 		offset += linelen(line, size);
 
 	patch->lines_added += added;
@@ -1036,7 +1036,7 @@ static int parse_single_patch(char *line, unsigned long size, struct patch *patc
 	unsigned long oldlines = 0, newlines = 0, context = 0;
 	struct fragment **fragp = &patch->fragments;
 
-	while (size > 4 && !memcmp(line, "@@ -", 4)) {
+	while (size > 4 && !prefixcmp(line, "@@ -")) {
 		struct fragment *fragment;
 		int len;
 
@@ -1316,7 +1316,7 @@ static int parse_chunk(char *buffer, unsigned long size, struct patch *patch)
 			else
 				patchsize = 0;
 		}
-		else if (!memcmp(" differ\n", buffer + hd + llen - 8, 8)) {
+		else if (!prefixcmp(buffer + hd + llen - 8, " differ\n")) {
 			for (i = 0; binhdr[i]; i++) {
 				int len = strlen(binhdr[i]);
 				if (len < size - hd &&
diff --git a/builtin-cat-file.c b/builtin-cat-file.c
index f132d58..4f91c31 100644
--- a/builtin-cat-file.c
+++ b/builtin-cat-file.c
@@ -19,7 +19,7 @@ static void pprint_tag(const unsigned char *sha1, const char *buf, unsigned long
 		char c = *cp++;
 		if (c != '\n')
 			continue;
-		if (7 <= endp - cp && !memcmp("tagger ", cp, 7)) {
+		if (7 <= endp - cp && !prefixcmp(cp, "tagger ")) {
 			const char *tagger = cp;
 
 			/* Found the tagger line.  Copy out the contents
diff --git a/builtin-fetch--tool.c b/builtin-fetch--tool.c
index cdb64cc..3362618 100644
--- a/builtin-fetch--tool.c
+++ b/builtin-fetch--tool.c
@@ -384,7 +384,7 @@ static int expand_refs_wildcard(const char *ls_remote_result, int numrefs,
 				ls++;
 			next = strchr(ls, '\n');
 			eol = !next ? (ls + strlen(ls)) : next;
-			if (!memcmp("^{}", eol-3, 3))
+			if (!prefixcmp(eol-3, "^{}"))
 				continue;
 			if (eol - ls < 40)
 				continue;
diff --git a/builtin-fsck.c b/builtin-fsck.c
index 83a2d0c..2229ea9 100644
--- a/builtin-fsck.c
+++ b/builtin-fsck.c
@@ -359,17 +359,17 @@ static int fsck_commit(struct commit *commit)
 		fprintf(stderr, "Checking commit %s\n",
 			sha1_to_hex(commit->object.sha1));
 
-	if (memcmp(buffer, "tree ", 5))
+	if (prefixcmp(buffer, "tree "))
 		return objerror(&commit->object, "invalid format - expected 'tree' line");
 	if (get_sha1_hex(buffer+5, tree_sha1) || buffer[45] != '\n')
 		return objerror(&commit->object, "invalid 'tree' line format - bad sha1");
 	buffer += 46;
-	while (!memcmp(buffer, "parent ", 7)) {
+	while (!prefixcmp(buffer, "parent ")) {
 		if (get_sha1_hex(buffer+7, sha1) || buffer[47] != '\n')
 			return objerror(&commit->object, "invalid 'parent' line format - bad sha1");
 		buffer += 48;
 	}
-	if (memcmp(buffer, "author ", 7))
+	if (prefixcmp(buffer, "author "))
 		return objerror(&commit->object, "invalid format - expected 'author' line");
 	free(commit->buffer);
 	commit->buffer = NULL;
diff --git a/builtin-mailinfo.c b/builtin-mailinfo.c
index d7cb11d..d2d25f8 100644
--- a/builtin-mailinfo.c
+++ b/builtin-mailinfo.c
@@ -242,7 +242,7 @@ static char *cleanup_subject(char *subject)
 		int len, remove;
 		switch (*subject) {
 		case 'r': case 'R':
-			if (!memcmp("e:", subject+1, 2)) {
+			if (!prefixcmp(subject+1, "e:")) {
 				subject += 3;
 				continue;
 			}
@@ -330,11 +330,11 @@ static int check_header(char *line, unsigned linesize, char **hdr_data, int over
 	}
 
 	/* for inbody stuff */
-	if (!memcmp(">From", line, 5) && isspace(line[5]))
+	if (!prefixcmp(line, ">From") && isspace(line[5]))
 		return 1;
-	if (!memcmp("[PATCH]", line, 7) && isspace(line[7])) {
+	if (!prefixcmp(line, "[PATCH]") && isspace(line[7])) {
 		for (i = 0; header[i]; i++) {
-			if (!memcmp("Subject: ", header[i], 9)) {
+			if (!prefixcmp(header[i], "Subject: ")) {
 				if (! handle_header(line, hdr_data[i], 0)) {
 					return 1;
 				}
@@ -360,7 +360,7 @@ static int is_rfc2822_header(char *line)
 	char *cp = line;
 
 	/* Count mbox From headers as headers */
-	if (!memcmp(line, "From ", 5) || !memcmp(line, ">From ", 6))
+	if (!prefixcmp(line, "From ") || !prefixcmp(line, ">From "))
 		return 1;
 
 	while ((ch = *cp++)) {
@@ -656,7 +656,7 @@ static int handle_boundary(void)
 {
 	char newline[]="\n";
 again:
-	if (!memcmp(line+content_top->boundary_len, "--", 2)) {
+	if (!prefixcmp(line+content_top->boundary_len, "--")) {
 		/* we hit an end boundary */
 		/* pop the current boundary off the stack */
 		free(content_top->boundary);
@@ -693,18 +693,18 @@ again:
 static inline int patchbreak(const char *line)
 {
 	/* Beginning of a "diff -" header? */
-	if (!memcmp("diff -", line, 6))
+	if (!prefixcmp(line, "diff -"))
 		return 1;
 
 	/* CVS "Index: " line? */
-	if (!memcmp("Index: ", line, 7))
+	if (!prefixcmp(line, "Index: "))
 		return 1;
 
 	/*
 	 * "--- <filename>" starts patches without headers
 	 * "---<sp>*" is a manual separator
 	 */
-	if (!memcmp("---", line, 3)) {
+	if (!prefixcmp(line, "---")) {
 		line += 3;
 		/* space followed by a filename? */
 		if (line[0] == ' ' && !isspace(line[1]))
@@ -892,7 +892,7 @@ static void handle_info(void)
 		else
 			continue;
 
-		if (!memcmp(header[i], "Subject", 7)) {
+		if (!prefixcmp(header[i], "Subject")) {
 			if (keep_subject)
 				sub = hdr;
 			else {
@@ -900,7 +900,7 @@ static void handle_info(void)
 				cleanup_space(sub);
 			}
 			output_header_lines(fout, "Subject", sub);
-		} else if (!memcmp(header[i], "From", 4)) {
+		} else if (!prefixcmp(header[i], "From")) {
 			handle_from(hdr);
 			fprintf(fout, "Author: %s\n", name);
 			fprintf(fout, "Email: %s\n", email);
diff --git a/builtin-mailsplit.c b/builtin-mailsplit.c
index 43fc373..0d10798 100644
--- a/builtin-mailsplit.c
+++ b/builtin-mailsplit.c
@@ -15,7 +15,7 @@ static int is_from_line(const char *line, int len)
 {
 	const char *colon;
 
-	if (len < 20 || memcmp("From ", line, 5))
+	if (len < 20 || prefixcmp(line, "From "))
 		return 0;
 
 	colon = line + len - 2;
diff --git a/builtin-tar-tree.c b/builtin-tar-tree.c
index b04719e..0f9f03c 100644
--- a/builtin-tar-tree.c
+++ b/builtin-tar-tree.c
@@ -79,7 +79,7 @@ int cmd_get_tar_commit_id(int argc, const char **argv, const char *prefix)
 		die("git-get-tar-commit-id: read error");
 	if (header->typeflag[0] != 'g')
 		return 1;
-	if (memcmp(content, "52 comment=", 11))
+	if (prefixcmp(content, "52 comment="))
 		return 1;
 
 	n = write_in_full(1, content + 11, 41);
diff --git a/combine-diff.c b/combine-diff.c
index fe5a2a1..bdfb033 100644
--- a/combine-diff.c
+++ b/combine-diff.c
@@ -156,7 +156,7 @@ struct combine_diff_state {
 static void consume_line(void *state_, char *line, unsigned long len)
 {
 	struct combine_diff_state *state = state_;
-	if (5 < len && !memcmp("@@ -", line, 4)) {
+	if (5 < len && !prefixcmp(line, "@@ -")) {
 		if (parse_hunk_header(line, len,
 				      &state->ob, &state->on,
 				      &state->nb, &state->nn))
diff --git a/commit.c b/commit.c
index 20fb220..6de2e3b 100644
--- a/commit.c
+++ b/commit.c
@@ -109,11 +109,11 @@ static unsigned long parse_commit_date(const char *buf)
 {
 	unsigned long date;
 
-	if (memcmp(buf, "author", 6))
+	if (prefixcmp(buf, "author"))
 		return 0;
 	while (*buf++ != '\n')
 		/* nada */;
-	if (memcmp(buf, "committer", 9))
+	if (prefixcmp(buf, "committer"))
 		return 0;
 	while (*buf++ != '>')
 		/* nada */;
@@ -293,7 +293,7 @@ int parse_commit_buffer(struct commit *item, void *buffer, unsigned long size)
 		return 0;
 	item->object.parsed = 1;
 	tail += size;
-	if (tail <= bufptr + 5 || memcmp(bufptr, "tree ", 5))
+	if (tail <= bufptr + 5 || prefixcmp(bufptr, "tree "))
 		return error("bogus commit object %s", sha1_to_hex(item->object.sha1));
 	if (tail <= bufptr + 45 || get_sha1_hex(bufptr + 5, parent) < 0)
 		return error("bad tree pointer in commit %s",
@@ -305,7 +305,7 @@ int parse_commit_buffer(struct commit *item, void *buffer, unsigned long size)
 	pptr = &item->parents;
 
 	graft = lookup_commit_graft(item->object.sha1);
-	while (bufptr + 48 < tail && !memcmp(bufptr, "parent ", 7)) {
+	while (bufptr + 48 < tail && !prefixcmp(bufptr, "parent ")) {
 		struct commit *new_parent;
 
 		if (tail <= bufptr + 48 ||
@@ -915,7 +915,7 @@ static void pp_header(enum cmit_fmt fmt,
 			continue;
 		}
 
-		if (!memcmp(line, "parent ", 7)) {
+		if (!prefixcmp(line, "parent ")) {
 			if (linelen != 48)
 				die("bad parent line in commit");
 			continue;
@@ -939,11 +939,11 @@ static void pp_header(enum cmit_fmt fmt,
 		 * FULL shows both authors but not dates.
 		 * FULLER shows both authors and dates.
 		 */
-		if (!memcmp(line, "author ", 7)) {
+		if (!prefixcmp(line, "author ")) {
 			strbuf_grow(sb, linelen + 80);
 			add_user_info("Author", fmt, sb, line + 7, dmode, encoding);
 		}
-		if (!memcmp(line, "committer ", 10) &&
+		if (!prefixcmp(line, "committer ") &&
 		    (fmt == CMIT_FMT_FULL || fmt == CMIT_FMT_FULLER)) {
 			strbuf_grow(sb, linelen + 80);
 			add_user_info("Commit", fmt, sb, line + 10, dmode, encoding);
diff --git a/connect.c b/connect.c
index 94c2d60..7c24711 100644
--- a/connect.c
+++ b/connect.c
@@ -13,7 +13,7 @@ static int check_ref(const char *name, int len, unsigned int flags)
 	if (!flags)
 		return 1;
 
-	if (len < STRLEN_PATH_REFS || memcmp(name, PATH_REFS, STRLEN_PATH_REFS))
+	if (len < STRLEN_PATH_REFS || prefixcmp(name, PATH_REFS))
 		return 0;
 
 	/* Skip the "refs/" part */
@@ -25,11 +25,11 @@ static int check_ref(const char *name, int len, unsigned int flags)
 		return 0;
 
 	/* REF_HEADS means that we want regular branch heads */
-	if ((flags & REF_HEADS) && !memcmp(name, PATH_HEADS, STRLEN_PATH_HEADS))
+	if ((flags & REF_HEADS) && !prefixcmp(name, PATH_HEADS))
 		return 1;
 
 	/* REF_TAGS means that we want tags */
-	if ((flags & REF_TAGS) && !memcmp(name, PATH_TAGS, STRLEN_PATH_TAGS))
+	if ((flags & REF_TAGS) && !prefixcmp(name, PATH_TAGS))
 		return 1;
 
 	/* All type bits clear means that we are ok with anything */
@@ -391,7 +391,7 @@ static int git_proxy_command_options(const char *var, const char *value)
 		if (0 <= matchlen) {
 			/* core.gitproxy = none for kernel.org */
 			if (matchlen == 4 &&
-			    !memcmp(value, "none", 4))
+			    !prefixcmp(value, "none"))
 				matchlen = 0;
 			git_proxy_command = xmemdupz(value, matchlen);
 		}
diff --git a/contrib/convert-objects/convert-objects.c b/contrib/convert-objects/convert-objects.c
index 90e7900..08c1961 100644
--- a/contrib/convert-objects/convert-objects.c
+++ b/contrib/convert-objects/convert-objects.c
@@ -245,7 +245,7 @@ static void convert_date(void *buffer, unsigned long size, unsigned char *result
 	size -= 46;
 
 	/* "parent <sha1>\n" */
-	while (!memcmp(buffer, "parent ", 7)) {
+	while (!prefixcmp(buffer, "parent ")) {
 		memcpy(new + newlen, buffer, 48);
 		newlen += 48;
 		buffer = (char *) buffer + 48;
@@ -270,11 +270,11 @@ static void convert_commit(void *buffer, unsigned long size, unsigned char *resu
 	void *orig_buffer = buffer;
 	unsigned long orig_size = size;
 
-	if (memcmp(buffer, "tree ", 5))
+	if (prefixcmp(buffer, "tree "))
 		die("Bad commit '%s'", (char*) buffer);
 	convert_ascii_sha1((char *) buffer + 5);
 	buffer = (char *) buffer + 46;    /* "tree " + "hex sha1" + "\n" */
-	while (!memcmp(buffer, "parent ", 7)) {
+	while (!prefixcmp(buffer, "parent ")) {
 		convert_ascii_sha1((char *) buffer + 7);
 		buffer = (char *) buffer + 48;
 	}
diff --git a/convert.c b/convert.c
index 0d5e909..cf11235 100644
--- a/convert.c
+++ b/convert.c
@@ -389,7 +389,7 @@ static int count_ident(const char *cp, unsigned long size)
 			continue;
 		if (size < 3)
 			break;
-		if (memcmp("Id", cp, 2))
+		if (prefixcmp(cp, "Id"))
 			continue;
 		ch = cp[2];
 		cp += 3;
@@ -433,7 +433,7 @@ static int ident_to_git(const char *path, const char *src, size_t len,
 		len -= dollar + 1 - src;
 		src  = dollar + 1;
 
-		if (len > 3 && !memcmp(src, "Id:", 3)) {
+		if (len > 3 && !prefixcmp(src, "Id:")) {
 			dollar = memchr(src + 3, '$', len - 3);
 			if (!dollar)
 				break;
diff --git a/fast-import.c b/fast-import.c
index e9c80be..ead3392 100644
--- a/fast-import.c
+++ b/fast-import.c
@@ -1903,7 +1903,7 @@ static void cmd_from_commit(struct branch *b, char *buf, unsigned long size)
 {
 	if (!buf || size < 46)
 		die("Not a valid commit: %s", sha1_to_hex(b->sha1));
-	if (memcmp("tree ", buf, 5)
+	if (prefixcmp(buf, "tree ")
 		|| get_sha1_hex(buf + 5, b->branch_tree.versions[1].sha1))
 		die("The commit %s is corrupt", sha1_to_hex(b->sha1));
 	hashcpy(b->branch_tree.versions[0].sha1,
diff --git a/fetch-pack.c b/fetch-pack.c
index c3b7ef6..bf5e84d 100644
--- a/fetch-pack.c
+++ b/fetch-pack.c
@@ -344,7 +344,7 @@ static void filter_refs(struct ref **refs, int nr_match, char **match)
 
 	for (ref = *refs; ref; ref = next) {
 		next = ref->next;
-		if (!memcmp(ref->name, PATH_REFS, STRLEN_PATH_REFS) &&
+		if (!prefixcmp(ref->name, PATH_REFS) &&
 		    check_ref_format(ref->name + STRLEN_PATH_REFS))
 			; /* trash */
 		else if (fetch_all &&
diff --git a/http-fetch.c b/http-fetch.c
index 2680fbd..9583579 100644
--- a/http-fetch.c
+++ b/http-fetch.c
@@ -528,7 +528,7 @@ static void process_alternates_response(void *callback_data)
 						     - base);
 					okay = 1;
 				}
-			} else if (!memcmp(data + i, "../", 3)) {
+			} else if (!prefixcmp(data + i, "../")) {
 				/* Relative URL; chop the corresponding
 				 * number of subpath from base (and ../
 				 * from data), and concatenate the result.
@@ -549,7 +549,7 @@ static void process_alternates_response(void *callback_data)
 				i += 3;
 				serverlen = strlen(base);
 				while (i + 2 < posn &&
-				       !memcmp(data + i, "../", 3)) {
+				       !prefixcmp(data + i, "../")) {
 					do {
 						serverlen--;
 					} while (serverlen &&
diff --git a/imap-send.c b/imap-send.c
index a429a76..6d924fc 100644
--- a/imap-send.c
+++ b/imap-send.c
@@ -464,7 +464,7 @@ v_issue_imap_cmd( imap_store_t *ctx, struct imap_cmd_cb *cb,
 	if (Verbose) {
 		if (imap->num_in_progress)
 			printf( "(%d in progress) ", imap->num_in_progress );
-		if (memcmp( cmd->cmd, "LOGIN", 5 ))
+		if (prefixcmp( cmd->cmd, "LOGIN" ))
 			printf( ">>> %s", buf );
 		else
 			printf( ">>> %d LOGIN <user> <pass>\n", cmd->tag );
@@ -644,7 +644,7 @@ parse_imap_list_l( imap_t *imap, char **sp, list_t **curp, int level )
 				if (level && *s == ')')
 					break;
 			cur->len = s - p;
-			if (cur->len == 3 && !memcmp ("NIL", p, 3)) {
+			if (cur->len == 3 && !prefixcmp(p, "NIL")) {
 				cur->val = NIL;
 			} else {
 				cur->val = xmemdupz(p, cur->len);
@@ -824,7 +824,7 @@ get_cmd_result( imap_store_t *ctx, struct imap_cmd *tcmd )
 				resp = DRV_OK;
 			else {
 				if (!strcmp( "NO", arg )) {
-					if (cmdp->cb.create && cmd && (cmdp->cb.trycreate || !memcmp( cmd, "[TRYCREATE]", 11 ))) { /* SELECT, APPEND or UID COPY */
+					if (cmdp->cb.create && cmd && (cmdp->cb.trycreate || !prefixcmp( cmd, "[TRYCREATE]" ))) { /* SELECT, APPEND or UID COPY */
 						p = strchr( cmdp->cmd, '"' );
 						if (!issue_imap_cmd( ctx, NULL, "CREATE \"%.*s\"", strchr( p + 1, '"' ) - p + 1, p )) {
 							resp = RESP_BAD;
@@ -849,7 +849,7 @@ get_cmd_result( imap_store_t *ctx, struct imap_cmd *tcmd )
 				} else /*if (!strcmp( "BAD", arg ))*/
 					resp = RESP_BAD;
 				fprintf( stderr, "IMAP command '%s' returned response (%s) - %s\n",
-					 memcmp (cmdp->cmd, "LOGIN", 5) ?
+					 prefixcmp(cmdp->cmd, "LOGIN") ?
 							cmdp->cmd : "LOGIN <user> <pass>",
 							arg, cmd ? cmd : "");
 			}
@@ -1079,7 +1079,7 @@ imap_store_msg( store_t *gctx, msg_data_t *data, int *uid )
 					sbreak = ebreak = i - 2 + nocr;
 					goto mktid;
 				}
-				if (!memcmp( fmap + start, "X-TUID: ", 8 )) {
+				if (!prefixcmp( fmap + start, "X-TUID: " )) {
 					extra -= (ebreak = i) - (sbreak = start) + nocr;
 					goto mktid;
 				}
diff --git a/mktag.c b/mktag.c
index b05260c..7a19110 100644
--- a/mktag.c
+++ b/mktag.c
@@ -52,7 +52,7 @@ static int verify_tag(char *buffer, unsigned long size)
 
 	/* Verify object line */
 	object = buffer;
-	if (memcmp(object, "object ", 7))
+	if (prefixcmp(object, "object "))
 		return error("char%d: does not start with \"object \"", 0);
 
 	if (get_sha1_hex(object + 7, sha1))
@@ -60,7 +60,7 @@ static int verify_tag(char *buffer, unsigned long size)
 
 	/* Verify type line */
 	type_line = object + 48;
-	if (memcmp(type_line - 1, "\ntype ", 6))
+	if (prefixcmp(type_line - 1, "\ntype "))
 		return error("char%d: could not find \"\\ntype \"", 47);
 
 	/* Verify tag-line */
@@ -68,7 +68,7 @@ static int verify_tag(char *buffer, unsigned long size)
 	if (!tag_line)
 		return error("char" PD_FMT ": could not find next \"\\n\"", type_line - buffer);
 	tag_line++;
-	if (memcmp(tag_line, "tag ", 4) || tag_line[4] == '\n')
+	if (prefixcmp(tag_line, "tag ") || tag_line[4] == '\n')
 		return error("char" PD_FMT ": no \"tag \" found", tag_line - buffer);
 
 	/* Get the actual type */
@@ -97,7 +97,7 @@ static int verify_tag(char *buffer, unsigned long size)
 	/* Verify the tagger line */
 	tagger_line = tag_line;
 
-	if (memcmp(tagger_line, "tagger", 6) || (tagger_line[6] == '\n'))
+	if (prefixcmp(tagger_line, "tagger") || (tagger_line[6] == '\n'))
 		return error("char" PD_FMT ": could not find \"tagger\"", tagger_line - buffer);
 
 	/* TODO: check for committer info + blank line? */
diff --git a/patch-id.c b/patch-id.c
index 9349bc5..390f7a7 100644
--- a/patch-id.c
+++ b/patch-id.c
@@ -40,9 +40,9 @@ static void generate_id_list(void)
 		char *p = line;
 		int len;
 
-		if (!memcmp(line, "diff-tree ", 10))
+		if (!prefixcmp(line, "diff-tree "))
 			p += 10;
-		else if (!memcmp(line, "commit ", 7))
+		else if (!prefixcmp(line, "commit "))
 			p += 7;
 
 		if (!get_sha1_hex(p, n)) {
@@ -53,15 +53,15 @@ static void generate_id_list(void)
 		}
 
 		/* Ignore commit comments */
-		if (!patchlen && memcmp(line, "diff ", 5))
+		if (!patchlen && prefixcmp(line, "diff "))
 			continue;
 
 		/* Ignore git-diff index header */
-		if (!memcmp(line, "index ", 6))
+		if (!prefixcmp(line, "index "))
 			continue;
 
 		/* Ignore line numbers when computing the SHA1 of the patch */
-		if (!memcmp(line, "@@ -", 4))
+		if (!prefixcmp(line, "@@ -"))
 			continue;
 
 		/* Compute the sha without whitespace */
diff --git a/path.c b/path.c
index d330bbc..037f2ef 100644
--- a/path.c
+++ b/path.c
@@ -25,7 +25,7 @@ static char *get_pathname(void)
 static char *cleanup_path(char *path)
 {
 	/* Clean it up */
-	if (!memcmp(path, "./", 2)) {
+	if (!prefixcmp(path, "./")) {
 		path += 2;
 		while (*path == '/')
 			path++;
@@ -100,7 +100,7 @@ int validate_headref(const char *path)
 	/* Make sure it is a "refs/.." symlink */
 	if (S_ISLNK(st.st_mode)) {
 		len = readlink(path, buffer, sizeof(buffer)-1);
-		if (len >= STRLEN_PATH_REFS && !memcmp(PATH_REFS, buffer, STRLEN_PATH_REFS))
+		if (len >= STRLEN_PATH_REFS && !prefixcmp(PATH_REFS, buffer))
 			return 0;
 		return -1;
 	}
@@ -119,12 +119,12 @@ int validate_headref(const char *path)
 	 */
 	if (len < 4)
 		return -1;
-	if (!memcmp("ref:", buffer, 4)) {
+	if (!prefixcmp(buffer, "ref:")) {
 		buf = buffer + 4;
 		len -= 4;
 		while (len && isspace(*buf))
 			buf++, len--;
-		if (len >= STRLEN_PATH_REFS && !memcmp(PATH_REFS, buf, STRLEN_PATH_REFS))
+		if (len >= STRLEN_PATH_REFS && !prefixcmp(PATH_REFS, buf))
 			return 0;
 	}
 
diff --git a/receive-pack.c b/receive-pack.c
index 114ea38..c8e94b6 100644
--- a/receive-pack.c
+++ b/receive-pack.c
@@ -415,7 +415,7 @@ static const char *unpack(void)
 		     len < 46 && (s = xread(ip.out, packname+len, 46-len)) > 0;
 		     len += s);
 		if (len == 46 && packname[45] == '\n' &&
-		    memcmp(packname, "keep\t", 5) == 0) {
+		    prefixcmp(packname, "keep\t") == 0) {
 			char path[PATH_MAX];
 			packname[45] = 0;
 			snprintf(path, sizeof(path), "%s/pack/pack-%s.keep",
diff --git a/refs.c b/refs.c
index 5891609..ba3b5c8 100644
--- a/refs.c
+++ b/refs.c
@@ -409,7 +409,7 @@ const char *resolve_ref(const char *ref, unsigned char *sha1, int reading, int *
 		/* Follow "normalized" - ie "refs/.." symlinks by hand */
 		if (S_ISLNK(st.st_mode)) {
 			len = readlink(path, buffer, sizeof(buffer)-1);
-			if (len >= STRLEN_PATH_REFS && !memcmp(PATH_REFS, buffer, STRLEN_PATH_REFS)) {
+			if (len >= STRLEN_PATH_REFS && !prefixcmp(buffer, PATH_REFS)) {
 				buffer[len] = 0;
 				strcpy(ref_buffer, buffer);
 				ref = ref_buffer;
@@ -438,7 +438,7 @@ const char *resolve_ref(const char *ref, unsigned char *sha1, int reading, int *
 		/*
 		 * Is it a symbolic ref?
 		 */
-		if (len < 4 || memcmp("ref:", buffer, 4))
+		if (len < 4 || prefixcmp(buffer, "ref:"))
 			break;
 		buf = buffer + 4;
 		len -= 4;
diff --git a/send-pack.c b/send-pack.c
index f74e66a..efafab1 100644
--- a/send-pack.c
+++ b/send-pack.c
@@ -151,11 +151,11 @@ static int receive_status(int in)
 	char line[1000];
 	int ret = 0;
 	int len = packet_read_line(in, line, sizeof(line));
-	if (len < 10 || memcmp(line, "unpack ", 7)) {
+	if (len < 10 || prefixcmp(line, "unpack ")) {
 		fprintf(stderr, "did not receive status back\n");
 		return -1;
 	}
-	if (memcmp(line, "unpack ok\n", 10)) {
+	if (prefixcmp(line, "unpack ok\n")) {
 		fputs(line, stderr);
 		ret = -1;
 	}
@@ -164,12 +164,12 @@ static int receive_status(int in)
 		if (!len)
 			break;
 		if (len < 3 ||
-		    (memcmp(line, "ok", 2) && memcmp(line, "ng", 2))) {
+		    (prefixcmp(line, "ok") && prefixcmp(line, "ng"))) {
 			fprintf(stderr, "protocol error: %s\n", line);
 			ret = -1;
 			break;
 		}
-		if (!memcmp(line, "ok", 2))
+		if (!prefixcmp(line, "ok"))
 			continue;
 		fputs(line, stderr);
 		ret = -1;
diff --git a/tag.c b/tag.c
index f62bcdd..305529b 100644
--- a/tag.c
+++ b/tag.c
@@ -46,15 +46,15 @@ int parse_tag_buffer(struct tag *item, void *data, unsigned long size)
 
 	if (size < 64)
 		return -1;
-	if (memcmp("object ", data, 7) || get_sha1_hex((char *) data + 7, sha1))
+	if (prefixcmp(data, "object ") || get_sha1_hex((char *) data + 7, sha1))
 		return -1;
 
 	type_line = (char *) data + 48;
-	if (memcmp("\ntype ", type_line-1, 6))
+	if (prefixcmp(type_line-1, "\ntype "))
 		return -1;
 
 	tag_line = strchr(type_line, '\n');
-	if (!tag_line || memcmp("tag ", ++tag_line, 4))
+	if (!tag_line || prefixcmp(++tag_line, "tag "))
 		return -1;
 
 	sig_line = strchr(tag_line, '\n');
diff --git a/xdiff-interface.c b/xdiff-interface.c
index be866d1..06d4f8b 100644
--- a/xdiff-interface.c
+++ b/xdiff-interface.c
@@ -44,7 +44,7 @@ int parse_hunk_header(char *line, int len,
 	}
 	else
 		*nn = 1;
-	return -!!memcmp(cp, " @@", 3);
+	return -!!prefixcmp(cp, " @@");
 }
 
 static void consume_one(void *priv_, char *s, unsigned long size)
-- 
1.5.3.rc5.11.g312e
