From: Quint Guvernator <quintus.public@gmail.com>
Subject: [PATCH v3 1/1] general style: replaces memcmp() with starts_with()
Date: Sat, 15 Mar 2014 12:39:13 -0400
Message-ID: <1394901553-69548-2-git-send-email-quintus.public@gmail.com>
References: <1394901553-69548-1-git-send-email-quintus.public@gmail.com>
Cc: Quint Guvernator <quintus.public@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Mar 15 17:39:47 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WOrcd-0004fw-Et
	for gcvg-git-2@plane.gmane.org; Sat, 15 Mar 2014 17:39:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755978AbaCOQjg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 15 Mar 2014 12:39:36 -0400
Received: from mail-qa0-f51.google.com ([209.85.216.51]:61799 "EHLO
	mail-qa0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755711AbaCOQjX (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 15 Mar 2014 12:39:23 -0400
Received: by mail-qa0-f51.google.com with SMTP id j7so3740935qaq.38
        for <git@vger.kernel.org>; Sat, 15 Mar 2014 09:39:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=gHLExMpVqNhyIJJBJd6P7tk2g25u+kJHe79SM9xEbrs=;
        b=YXBtaYHQilbzKJR4kRcx+VgMZHa2WJF6oSGwkPFhLrynNe2fA+auBIr+ljfBe/G8Nq
         YfUBq/fRfH8A5f6H/LFjQBHcdfMl/TQ0FO1Yr2L66OZ810L5GWmeNgv0ldO9pQLCJQO0
         xHvoOq7GrMFg7cdedfXBuj1DiAeSk8C/kDjt4AkK3tA2lCFRirE4JC3gg7by70Q2TdBw
         hXovNba00dMyD/RpFEOYBrYKgdZCA3iNMjNwD1XG+NnFgGv94njjL+7Rn05QhgviRxfT
         psp4gv8ZqJkixrvtmqExH3WpU9Q5HecPBgqbH58+Zy+BiW3r+jLQEhREA13QG6Jy3yZH
         T0ng==
X-Received: by 10.224.130.135 with SMTP id t7mr1643495qas.102.1394901562361;
        Sat, 15 Mar 2014 09:39:22 -0700 (PDT)
Received: from lovelace.wm.edu ([128.239.171.194])
        by mx.google.com with ESMTPSA id t5sm13163491qge.0.2014.03.15.09.39.21
        for <multiple recipients>
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Sat, 15 Mar 2014 09:39:21 -0700 (PDT)
X-Mailer: git-send-email 1.9.0
In-Reply-To: <1394901553-69548-1-git-send-email-quintus.public@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/244160>

memcmp() is replaced with negated starts_with() when comparing strings
from the beginning and when it is logical to do so. starts_with() looks
nicer and it saves the extra argument of the length of the comparing
string.

Signed-off-by: Quint Guvernator <quintus.public@gmail.com>
---
 builtin/apply.c                           |  6 +++---
 builtin/for-each-ref.c                    |  2 +-
 builtin/get-tar-commit-id.c               |  2 +-
 builtin/mktag.c                           |  8 ++++----
 builtin/patch-id.c                        | 18 +++++++++---------
 commit.c                                  |  4 ++--
 connect.c                                 |  6 +++---
 contrib/convert-objects/convert-objects.c |  6 +++---
 convert.c                                 |  2 +-
 http-walker.c                             |  2 +-
 imap-send.c                               |  6 +++---
 pack-write.c                              |  2 +-
 remote.c                                  |  2 +-
 13 files changed, 33 insertions(+), 33 deletions(-)

diff --git a/builtin/apply.c b/builtin/apply.c
index 0189523..de84dce 100644
--- a/builtin/apply.c
+++ b/builtin/apply.c
@@ -1631,7 +1631,7 @@ static int parse_fragment(const char *line, unsigned long size,
 		 * l10n of "\ No newline..." is at least that long.
 		 */
 		case '\\':
-			if (len < 12 || memcmp(line, "\\ ", 2))
+			if (len < 12 || !starts_with(line, "\\ "))
 				return -1;
 			break;
 		}
@@ -1646,7 +1646,7 @@ static int parse_fragment(const char *line, unsigned long size,
 	 * it in the above loop because we hit oldlines == newlines == 0
 	 * before seeing it.
 	 */
-	if (12 < size && !memcmp(line, "\\ ", 2))
+	if (12 < size && starts_with(line, "\\ "))
 		offset += linelen(line, size);
 
 	patch->lines_added += added;
@@ -1673,7 +1673,7 @@ static int parse_single_patch(const char *line, unsigned long size, struct patch
 	unsigned long oldlines = 0, newlines = 0, context = 0;
 	struct fragment **fragp = &patch->fragments;
 
-	while (size > 4 && !memcmp(line, "@@ -", 4)) {
+	while (size > 4 && starts_with(line, "@@ -")) {
 		struct fragment *fragment;
 		int len;
 
diff --git a/builtin/for-each-ref.c b/builtin/for-each-ref.c
index 3e1d5c3..4135980 100644
--- a/builtin/for-each-ref.c
+++ b/builtin/for-each-ref.c
@@ -193,7 +193,7 @@ static int verify_format(const char *format)
 		at = parse_atom(sp + 2, ep);
 		cp = ep + 1;
 
-		if (!memcmp(used_atom[at], "color:", 6))
+		if (starts_with(used_atom[at], "color:"))
 			need_color_reset_at_eol = !!strcmp(used_atom[at], color_reset);
 	}
 	return 0;
diff --git a/builtin/get-tar-commit-id.c b/builtin/get-tar-commit-id.c
index aa72596..6409c26 100644
--- a/builtin/get-tar-commit-id.c
+++ b/builtin/get-tar-commit-id.c
@@ -29,7 +29,7 @@ int cmd_get_tar_commit_id(int argc, const char **argv, const char *prefix)
 		die("git get-tar-commit-id: read error");
 	if (header->typeflag[0] != 'g')
 		return 1;
-	if (memcmp(content, "52 comment=", 11))
+	if (!starts_with(content, "52 comment="))
 		return 1;
 
 	n = write_in_full(1, content + 11, 41);
diff --git a/builtin/mktag.c b/builtin/mktag.c
index 640ab64..70385ac 100644
--- a/builtin/mktag.c
+++ b/builtin/mktag.c
@@ -49,7 +49,7 @@ static int verify_tag(char *buffer, unsigned long size)
 
 	/* Verify object line */
 	object = buffer;
-	if (memcmp(object, "object ", 7))
+	if (!starts_with(object, "object "))
 		return error("char%d: does not start with \"object \"", 0);
 
 	if (get_sha1_hex(object + 7, sha1))
@@ -57,7 +57,7 @@ static int verify_tag(char *buffer, unsigned long size)
 
 	/* Verify type line */
 	type_line = object + 48;
-	if (memcmp(type_line - 1, "\ntype ", 6))
+	if (!starts_with(type_line - 1, "\ntype "))
 		return error("char%d: could not find \"\\ntype \"", 47);
 
 	/* Verify tag-line */
@@ -66,7 +66,7 @@ static int verify_tag(char *buffer, unsigned long size)
 		return error("char%"PRIuMAX": could not find next \"\\n\"",
 				(uintmax_t) (type_line - buffer));
 	tag_line++;
-	if (memcmp(tag_line, "tag ", 4) || tag_line[4] == '\n')
+	if (!starts_with(tag_line, "tag ") || tag_line[4] == '\n')
 		return error("char%"PRIuMAX": no \"tag \" found",
 				(uintmax_t) (tag_line - buffer));
 
@@ -98,7 +98,7 @@ static int verify_tag(char *buffer, unsigned long size)
 	/* Verify the tagger line */
 	tagger_line = tag_line;
 
-	if (memcmp(tagger_line, "tagger ", 7))
+	if (!starts_with(tagger_line, "tagger "))
 		return error("char%"PRIuMAX": could not find \"tagger \"",
 			(uintmax_t) (tagger_line - buffer));
 
diff --git a/builtin/patch-id.c b/builtin/patch-id.c
index 3cfe02d..7e02f2c 100644
--- a/builtin/patch-id.c
+++ b/builtin/patch-id.c
@@ -66,13 +66,13 @@ static int get_one_patchid(unsigned char *next_sha1, git_SHA_CTX *ctx, struct st
 		char *p = line;
 		int len;
 
-		if (!memcmp(line, "diff-tree ", 10))
+		if (starts_with(line, "diff-tree "))
 			p += 10;
-		else if (!memcmp(line, "commit ", 7))
+		else if (starts_with(line, "commit "))
 			p += 7;
-		else if (!memcmp(line, "From ", 5))
+		else if (starts_with(line, "From "))
 			p += 5;
-		else if (!memcmp(line, "\\ ", 2) && 12 < strlen(line))
+		else if (starts_with(line, "\\ ") && 12 < strlen(line))
 			continue;
 
 		if (!get_sha1_hex(p, next_sha1)) {
@@ -81,14 +81,14 @@ static int get_one_patchid(unsigned char *next_sha1, git_SHA_CTX *ctx, struct st
 		}
 
 		/* Ignore commit comments */
-		if (!patchlen && memcmp(line, "diff ", 5))
+		if (!patchlen && !starts_with(line, "diff "))
 			continue;
 
 		/* Parsing diff header?  */
 		if (before == -1) {
-			if (!memcmp(line, "index ", 6))
+			if (starts_with(line, "index "))
 				continue;
-			else if (!memcmp(line, "--- ", 4))
+			else if (starts_with(line, "--- "))
 				before = after = 1;
 			else if (!isalpha(line[0]))
 				break;
@@ -96,14 +96,14 @@ static int get_one_patchid(unsigned char *next_sha1, git_SHA_CTX *ctx, struct st
 
 		/* Looking for a valid hunk header?  */
 		if (before == 0 && after == 0) {
-			if (!memcmp(line, "@@ -", 4)) {
+			if (starts_with(line, "@@ -")) {
 				/* Parse next hunk, but ignore line numbers.  */
 				scan_hunk_header(line, &before, &after);
 				continue;
 			}
 
 			/* Split at the end of the patch.  */
-			if (memcmp(line, "diff ", 5))
+			if (!starts_with(line, "diff "))
 				break;
 
 			/* Else we're parsing another header.  */
diff --git a/commit.c b/commit.c
index fa401ae..f3ca1db 100644
--- a/commit.c
+++ b/commit.c
@@ -90,13 +90,13 @@ static unsigned long parse_commit_date(const char *buf, const char *tail)
 
 	if (buf + 6 >= tail)
 		return 0;
-	if (memcmp(buf, "author", 6))
+	if (!starts_with(buf, "author"))
 		return 0;
 	while (buf < tail && *buf++ != '\n')
 		/* nada */;
 	if (buf + 9 >= tail)
 		return 0;
-	if (memcmp(buf, "committer", 9))
+	if (!starts_with(buf, "committer"))
 		return 0;
 	while (buf < tail && *buf++ != '>')
 		/* nada */;
diff --git a/connect.c b/connect.c
index 4150412..1ff0540 100644
--- a/connect.c
+++ b/connect.c
@@ -18,7 +18,7 @@ static int check_ref(const char *name, int len, unsigned int flags)
 	if (!flags)
 		return 1;
 
-	if (len < 5 || memcmp(name, "refs/", 5))
+	if (len < 5 || !starts_with(name, "refs/"))
 		return 0;
 
 	/* Skip the "refs/" part */
@@ -30,11 +30,11 @@ static int check_ref(const char *name, int len, unsigned int flags)
 		return 0;
 
 	/* REF_HEADS means that we want regular branch heads */
-	if ((flags & REF_HEADS) && !memcmp(name, "heads/", 6))
+	if ((flags & REF_HEADS) && starts_with(name, "heads/"))
 		return 1;
 
 	/* REF_TAGS means that we want tags */
-	if ((flags & REF_TAGS) && !memcmp(name, "tags/", 5))
+	if ((flags & REF_TAGS) && starts_with(name, "tags/"))
 		return 1;
 
 	/* All type bits clear means that we are ok with anything */
diff --git a/contrib/convert-objects/convert-objects.c b/contrib/convert-objects/convert-objects.c
index f3b57bf..9fdc730 100644
--- a/contrib/convert-objects/convert-objects.c
+++ b/contrib/convert-objects/convert-objects.c
@@ -245,7 +245,7 @@ static void convert_date(void *buffer, unsigned long size, unsigned char *result
 	size -= 46;
 
 	/* "parent <sha1>\n" */
-	while (!memcmp(buffer, "parent ", 7)) {
+	while (starts_with(buffer, "parent ")) {
 		memcpy(new + newlen, buffer, 48);
 		newlen += 48;
 		buffer = (char *) buffer + 48;
@@ -270,11 +270,11 @@ static void convert_commit(void *buffer, unsigned long size, unsigned char *resu
 	void *orig_buffer = buffer;
 	unsigned long orig_size = size;
 
-	if (memcmp(buffer, "tree ", 5))
+	if (!starts_with(buffer, "tree "))
 		die("Bad commit '%s'", (char *) buffer);
 	convert_ascii_sha1((char *) buffer + 5);
 	buffer = (char *) buffer + 46;    /* "tree " + "hex sha1" + "\n" */
-	while (!memcmp(buffer, "parent ", 7)) {
+	while (starts_with(buffer, "parent ")) {
 		convert_ascii_sha1((char *) buffer + 7);
 		buffer = (char *) buffer + 48;
 	}
diff --git a/convert.c b/convert.c
index ab80b72..30882e2 100644
--- a/convert.c
+++ b/convert.c
@@ -543,7 +543,7 @@ static int ident_to_git(const char *path, const char *src, size_t len,
 		len -= dollar + 1 - src;
 		src  = dollar + 1;
 
-		if (len > 3 && !memcmp(src, "Id:", 3)) {
+		if (len > 3 && starts_with(src, "Id:")) {
 			dollar = memchr(src + 3, '$', len - 3);
 			if (!dollar)
 				break;
diff --git a/http-walker.c b/http-walker.c
index 1516c5e..8ae7d69 100644
--- a/http-walker.c
+++ b/http-walker.c
@@ -267,7 +267,7 @@ static void process_alternates_response(void *callback_data)
 				i += 3;
 				serverlen = strlen(base);
 				while (i + 2 < posn &&
-				       !memcmp(data + i, "../", 3)) {
+				       starts_with(data + i, "../")) {
 					do {
 						serverlen--;
 					} while (serverlen &&
diff --git a/imap-send.c b/imap-send.c
index 0bc6f7f..019de18 100644
--- a/imap-send.c
+++ b/imap-send.c
@@ -524,7 +524,7 @@ static struct imap_cmd *v_issue_imap_cmd(struct imap_store *ctx,
 	if (Verbose) {
 		if (imap->num_in_progress)
 			printf("(%d in progress) ", imap->num_in_progress);
-		if (memcmp(cmd->cmd, "LOGIN", 5))
+		if (!starts_with(cmd->cmd, "LOGIN"))
 			printf(">>> %s", buf);
 		else
 			printf(">>> %d LOGIN <user> <pass>\n", cmd->tag);
@@ -802,7 +802,7 @@ static int get_cmd_result(struct imap_store *ctx, struct imap_cmd *tcmd)
 				resp = DRV_OK;
 			else {
 				if (!strcmp("NO", arg)) {
-					if (cmdp->cb.create && cmd && (cmdp->cb.trycreate || !memcmp(cmd, "[TRYCREATE]", 11))) { /* SELECT, APPEND or UID COPY */
+					if (cmdp->cb.create && cmd && (cmdp->cb.trycreate || starts_with(cmd, "[TRYCREATE]"))) { /* SELECT, APPEND or UID COPY */
 						p = strchr(cmdp->cmd, '"');
 						if (!issue_imap_cmd(ctx, NULL, "CREATE \"%.*s\"", (int)(strchr(p + 1, '"') - p + 1), p)) {
 							resp = RESP_BAD;
@@ -827,7 +827,7 @@ static int get_cmd_result(struct imap_store *ctx, struct imap_cmd *tcmd)
 				} else /*if (!strcmp("BAD", arg))*/
 					resp = RESP_BAD;
 				fprintf(stderr, "IMAP command '%s' returned response (%s) - %s\n",
-					 memcmp(cmdp->cmd, "LOGIN", 5) ?
+					 !starts_with(cmdp->cmd, "LOGIN") ?
 							cmdp->cmd : "LOGIN <user> <pass>",
 							arg, cmd ? cmd : "");
 			}
diff --git a/pack-write.c b/pack-write.c
index 9b8308b..c3bfa16 100644
--- a/pack-write.c
+++ b/pack-write.c
@@ -289,7 +289,7 @@ char *index_pack_lockfile(int ip_out)
 	 * later on.  If we don't get that then tough luck with it.
 	 */
 	if (read_in_full(ip_out, packname, 46) == 46 && packname[45] == '\n' &&
-	    memcmp(packname, "keep\t", 5) == 0) {
+	    !starts_with(packname, "keep\t") == 0) {
 		char path[PATH_MAX];
 		packname[45] = 0;
 		snprintf(path, sizeof(path), "%s/pack/pack-%s.keep",
diff --git a/remote.c b/remote.c
index 5f63d55..bd02b0e 100644
--- a/remote.c
+++ b/remote.c
@@ -1149,7 +1149,7 @@ static int match_explicit(struct ref *src, struct ref *dst,
 	case 1:
 		break;
 	case 0:
-		if (!memcmp(dst_value, "refs/", 5))
+		if (starts_with(dst_value, "refs/"))
 			matched_dst = make_linked_ref(dst_value, dst_tail);
 		else if (is_null_sha1(matched_src->new_sha1))
 			error("unable to delete '%s': remote ref does not exist",
-- 
1.9.0
