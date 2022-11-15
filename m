Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98C41C433FE
	for <git@archiver.kernel.org>; Tue, 15 Nov 2022 18:20:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229681AbiKOSUM (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 15 Nov 2022 13:20:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35246 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229596AbiKOSUL (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 15 Nov 2022 13:20:11 -0500
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 703FA248EF
        for <git@vger.kernel.org>; Tue, 15 Nov 2022 10:20:09 -0800 (PST)
Received: by mail-wr1-x429.google.com with SMTP id a14so25729274wru.5
        for <git@vger.kernel.org>; Tue, 15 Nov 2022 10:20:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=A08lLIJZ/UOfVuzl483HexCdq7clDne2vKMPruH/0DE=;
        b=QvvrbuYq9pEaZPZxgRq9CH8J/UuoeOqiPpKOPGuLT1vDja9dR5/vM47nHQk92Nn6Ee
         IXSfDb1w0uREj/YDTqlxr71RFVPGkdAzBasFxUF7iUmm3JIpgSHu3W84ywQqFeVhmxkb
         N7f0We71HDqCCMK2ZVXrofNPpm342TyUCxeO9vT30bYfDr98FmIlNnmfovIBqXO08Oi8
         AFn8UGf5LweewVw3rAzYUnTlNME7cZISd8mPSdMV0yL+Bux6twSMB6xj/H4esVjkWFKb
         oQwYi/D9+R7GJdlEXnJjUIHMjqGP/KbQLdEHzA4Y53PjuRgxQiX2w8o4+E6r3blq8FKj
         DzhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=A08lLIJZ/UOfVuzl483HexCdq7clDne2vKMPruH/0DE=;
        b=AUNcdgJtFyPze0X8X7/W9pzxzOhiY1D/7iVSdVn1ubcJvCLvl+GJxeucoWx2kf8mDp
         jmJudkgeY1UZb9dfCK9TYlc9vxXlu0zn6W17HxQLO2g8eN12IMfD4WUpPinLEkn1eStd
         HL2QHNrfo/ncLhumqZNhypxJLcLs7OGWj29giZi9qxWjhGiaJU1BcBJOrIY7kPzaOwq4
         Z1F7bmNQBP6GFhAvPY78RENofO2E3LhoOnkwg8m1271f8/XjCw0Eqvb9NNPaJBzqVCbY
         Lr2wlCypv5CSeNcpIMB193UfI7y89VrpFa0xsmk/tjED+NHdSDc8TaSImzKoxwK/RPzy
         9Zcg==
X-Gm-Message-State: ANoB5pkwcE2WIE+RqhCcRQpAnRWEUPVLcLs72lsms4gljYHJOpMIV3wR
        i2w6w/5RuLBXW7qfAQyKcm36GAUKDuw=
X-Google-Smtp-Source: AA0mqf4gw8fVBwiGQk0ccZ7YCeQstKiEhEUs7ZUqaGq7mKs1Pnh7vTDE94qVChACbfMo6OBkZkQNgw==
X-Received: by 2002:adf:f7d1:0:b0:236:8ef4:6ee2 with SMTP id a17-20020adff7d1000000b002368ef46ee2mr11193593wrq.683.1668536407256;
        Tue, 15 Nov 2022 10:20:07 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id h15-20020a05600c350f00b003cfcf9f9d62sm16979902wmq.12.2022.11.15.10.20.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Nov 2022 10:20:06 -0800 (PST)
Message-Id: <pull.1420.git.1668536405563.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 15 Nov 2022 18:20:05 +0000
Subject: [PATCH] range-diff: support reading mbox files
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Johannes Schindelin <johannes.schindelin@gmx.de>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Johannes Schindelin <johannes.schindelin@gmx.de>

Internally, the `git range-diff` command spawns a `git log` process and
parses its output for the given commit ranges.

This works well when the patches that need to be compared are present in
the local repository in the form of commits.

In scenarios where that is not the case, the `range-diff` command is
currently less helpful.

The Git mailing list is such a scenario: Instead of using Git to
exchange commits, the patches are sent there as plain-text and no commit
range can be specified to let `range-diff` consume those patches.

Instead, the expectation is to download the mails, apply them locally
and then use `range-diff`. This can be quite cumbersome e.g. when a
suitable base revision has to be found first where the patch applies
cleanly.

Let's offer a way to read those patches from pre-prepared MBox files
instead when an argument "mbox:<filename>" is passed instead of a commit
range.

For extra convenience, interpret the filename `-` as standard input.
This makes it easy to compare contributions on the mailing list with the
actual commits that were integrated into Git's main branch. Example:

	commit=5c4003ca3f0e9ac6d3c8aa3e387ff843bd440411
	mid=bdfa3845b81531863941e6a97c28eb1afa62dd2c.1489435755.git.johannes.schindelin@gmx.de
	curl -s https://lore.kernel.org/git/$mid/raw |
	git range-diff mbox:- $commit^!

This addresses https://github.com/gitgitgadget/git/issues/207

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
    range-diff: support reading mbox files
    
    I frequently find myself wanting to look at the range-diff between some
    local commits and the patches on the Git mailing list, but unwilling to
    go through the process of finding an appropriate base revision to apply
    the patches onto (just to throw the generated patches away afterwards,
    anyway).
    
    So I came up with this patch. May it be helpful to other developers,
    too.
    
    This patch contains a home-rolled mbox parser. Initially, I wrote a
    really basic parser and it worked well enough, but, you know, as things
    go it became more complex than that in order to provide actually useful
    range-diffs for existing commits and their corresponding mails (because
    of in-body From: headers, because of -- trailers and long subjects, just
    to name a few reasons). In hindsight, it might have made sense to try to
    to reuse the parser that is available in mailinfo.c, which I had
    initially dismissed as overly complex and unnecessary for this use case.
    If anyone feels up to it, I would invite them to adjust this code to
    replace the mbox parser with one based on the mailinfo.c. Incrementally,
    of course, because the perfect is the enemy of the good.

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1420%2Fdscho%2Frange-diff-from-mbox-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1420/dscho/range-diff-from-mbox-v1
Pull-Request: https://github.com/gitgitgadget/git/pull/1420

 Documentation/git-range-diff.txt |   3 +-
 range-diff.c                     | 317 ++++++++++++++++++++++++++++++-
 t/t3206-range-diff.sh            |   9 +
 3 files changed, 327 insertions(+), 2 deletions(-)

diff --git a/Documentation/git-range-diff.txt b/Documentation/git-range-diff.txt
index 0b393715d70..e2c4661acde 100644
--- a/Documentation/git-range-diff.txt
+++ b/Documentation/git-range-diff.txt
@@ -37,7 +37,8 @@ There are three ways to specify the commit ranges:
 
 - `<range1> <range2>`: Either commit range can be of the form
   `<base>..<rev>`, `<rev>^!` or `<rev>^-<n>`. See `SPECIFYING RANGES`
-  in linkgit:gitrevisions[7] for more details.
+  in linkgit:gitrevisions[7] for more details. Alternatively, the
+  patches can be provided as an mbox-formatted file via `mbox:<path>`.
 
 - `<rev1>...<rev2>`. This is equivalent to
   `<rev2>..<rev1> <rev1>..<rev2>`.
diff --git a/range-diff.c b/range-diff.c
index 124dd678c38..7c84cdbeffa 100644
--- a/range-diff.c
+++ b/range-diff.c
@@ -12,6 +12,7 @@
 #include "userdiff.h"
 #include "apply.h"
 #include "revision.h"
+#include "dir.h"
 
 struct patch_util {
 	/* For the search for an exact match */
@@ -26,6 +27,293 @@ struct patch_util {
 	struct object_id oid;
 };
 
+static inline int strtost(char const *s, size_t *result, const char **end)
+{
+	unsigned long u;
+	char *p;
+
+	errno = 0;
+	/* negative values would be accepted by strtoul */
+	if (*s == '-')
+		return -1;
+	u = strtoul(s, &p, 10);
+	if (errno || p == s)
+		return -1;
+	if (result)
+		*result = u;
+	*end = p;
+
+	return 0;
+}
+
+static int parse_hunk_header(const char *p,
+			     size_t *old_count, size_t *new_count,
+			     const char **end)
+{
+	size_t o = 1, n = 1;
+
+	if (!skip_prefix(p, "@@ -", &p) ||
+	    strtost(p, NULL, &p) ||
+	    (*p != ' ' && (*p != ',' || strtost(p + 1, &o, &p))) ||
+	    !skip_prefix(p, " +", &p) ||
+	    strtost(p, NULL, &p) ||
+	    (*p != ' ' && (*p != ',' || strtost(p + 1, &n, &p))) ||
+	    !skip_prefix(p, " @@", &p))
+		return -1;
+
+	*old_count = o;
+	*new_count = n;
+	*end = p;
+
+	return 0;
+}
+
+static inline int find_eol(const char *line, size_t size)
+{
+	char *eol;
+
+	eol = memchr(line, '\n', size);
+	if (!eol)
+		return size;
+
+	if (eol != line && eol[-1] == '\r')
+		eol[-1] = '\0';
+	else
+		*eol = '\0';
+
+	return eol + 1 - line;
+}
+
+static int read_mbox(const char *path, struct string_list *list)
+{
+	struct strbuf buf = STRBUF_INIT, contents = STRBUF_INIT;
+	struct strbuf long_subject = STRBUF_INIT;
+	struct patch_util *util = NULL;
+	enum {
+		MBOX_BEFORE_HEADER,
+		MBOX_IN_HEADER,
+		MBOX_IN_COMMIT_MESSAGE,
+		MBOX_AFTER_TRIPLE_DASH,
+		MBOX_IN_DIFF
+	} state = MBOX_BEFORE_HEADER;
+	char *line, *current_filename = NULL;
+	int len;
+	size_t size, old_count = 0, new_count = 0;
+	const char *author = NULL, *subject = NULL;
+
+	if (!strcmp(path, "-")) {
+		if (strbuf_read(&contents, STDIN_FILENO, 0) < 0)
+			return error_errno(_("could not read stdin"));
+	} else if (strbuf_read_file(&contents, path, 0) < 0)
+		return error_errno(_("could not read '%s'"), path);
+
+	line = contents.buf;
+	size = contents.len;
+	for (; size > 0; size -= len, line += len) {
+		const char *p;
+
+		len = find_eol(line, size);
+
+		if (state == MBOX_BEFORE_HEADER) {
+			if (!skip_prefix(line, "From ", &p))
+				continue;
+
+			util = xcalloc(1, sizeof(*util));
+			if (get_oid_hex(p, &util->oid) < 0)
+				oidcpy(&util->oid, null_oid());
+			util->matching = -1;
+			author = subject = NULL;
+
+			state = MBOX_IN_HEADER;
+		}
+
+		if (starts_with(line, "diff --git ")) {
+			struct patch patch = { 0 };
+			struct strbuf root = STRBUF_INIT;
+			int linenr = 0;
+			int orig_len;
+
+			state = MBOX_IN_DIFF;
+			old_count = new_count = 0;
+			strbuf_addch(&buf, '\n');
+			if (!util->diff_offset)
+				util->diff_offset = buf.len;
+			line[len - 1] = '\n';
+			orig_len = len;
+			len = parse_git_diff_header(&root, &linenr, 1, line,
+						    len, size, &patch);
+			if (len < 0) {
+				error(_("could not parse git header '%.*s'"),
+				      orig_len, line);
+				free(util);
+				free(current_filename);
+				string_list_clear(list, 1);
+				strbuf_release(&buf);
+				strbuf_release(&contents);
+				strbuf_release(&long_subject);
+				return -1;
+			}
+
+			if (patch.old_name)
+				skip_prefix(patch.old_name, "a/",
+					    (const char **)&patch.old_name);
+			if (patch.new_name)
+				skip_prefix(patch.new_name, "b/",
+					    (const char **)&patch.new_name);
+
+			strbuf_addstr(&buf, " ## ");
+			if (patch.is_new > 0)
+				strbuf_addf(&buf, "%s (new)", patch.new_name);
+			else if (patch.is_delete > 0)
+				strbuf_addf(&buf, "%s (deleted)", patch.old_name);
+			else if (patch.is_rename)
+				strbuf_addf(&buf, "%s => %s", patch.old_name, patch.new_name);
+			else
+				strbuf_addstr(&buf, patch.new_name);
+
+			free(current_filename);
+			if (patch.is_delete > 0)
+				current_filename = xstrdup(patch.old_name);
+			else
+				current_filename = xstrdup(patch.new_name);
+
+			if (patch.new_mode && patch.old_mode &&
+			    patch.old_mode != patch.new_mode)
+				strbuf_addf(&buf, " (mode change %06o => %06o)",
+					    patch.old_mode, patch.new_mode);
+
+			strbuf_addstr(&buf, " ##\n");
+			util->diffsize++;
+		} else if (state == MBOX_IN_HEADER) {
+			if (!line[0]) {
+				state = MBOX_IN_COMMIT_MESSAGE;
+				/* Look for an in-body From: */
+				if (size > 5 && skip_prefix(line + 1, "From: ", &p)) {
+					size -= p - line;
+					line += p - line;
+					len = find_eol(line, size);
+
+					while (isspace(*p))
+						p++;
+					author = p;
+				}
+				strbuf_addstr(&buf, " ## Metadata ##\n");
+				if (author)
+					strbuf_addf(&buf, "Author: %s\n", author);
+				strbuf_addstr(&buf, "\n ## Commit message ##\n");
+				if (subject)
+					strbuf_addf(&buf, "    %s\n\n", subject);
+			} else if (skip_prefix(line, "From: ", &p)) {
+				while (isspace(*p))
+					p++;
+				author = p;
+			} else if (skip_prefix(line, "Subject: ", &p)) {
+				const char *q;
+
+				while (isspace(*p))
+					p++;
+				subject = p;
+
+				if (starts_with(p, "[PATCH") &&
+				    (q = strchr(p, ']'))) {
+					q++;
+					while (isspace(*q))
+						q++;
+					subject = q;
+				}
+
+				if (len < size && line[len] == ' ') {
+					/* handle long subject */
+					strbuf_reset(&long_subject);
+					strbuf_addstr(&long_subject, subject);
+					while (len < size && line[len] == ' ') {
+						line += len;
+						size -= len;
+						len = find_eol(line, size);
+						strbuf_addstr(&long_subject, line);
+					}
+					subject = long_subject.buf;
+				}
+			}
+		} else if (state == MBOX_IN_COMMIT_MESSAGE) {
+			if (!*line)
+				strbuf_addch(&buf, '\n');
+			else if (strcmp(line, "---")) {
+				int tabs = 0;
+
+				/* simulate tab expansion */
+				while (line[tabs] == '\t')
+					tabs++;
+				strbuf_addf(&buf, "%*s%s\n",
+					    4 + 8 * tabs, "", line + tabs);
+			} else {
+				/*
+				 * Trim the trailing newline that is added
+				 * by `format-patch`.
+				 */
+				strbuf_trim_trailing_newline(&buf);
+				state = MBOX_AFTER_TRIPLE_DASH;
+			}
+		} else if (state == MBOX_IN_DIFF) {
+			switch (line[0]) {
+			case '\0':
+				continue; /* ignore empty lines after diff */
+			case '+':
+			case '-':
+			case ' ':
+				if (!old_count && !new_count)
+					break;
+				if (old_count && line[0] != '+')
+					old_count--;
+				if (new_count && line[0] != '-')
+					new_count--;
+				/* fallthrough */
+			case '\\':
+				strbuf_addstr(&buf, line);
+				strbuf_addch(&buf, '\n');
+				util->diffsize++;
+				continue;
+			case '@':
+				if (parse_hunk_header(line, &old_count,
+						      &new_count, &p))
+					break;
+
+				strbuf_addstr(&buf, "@@");
+				if (current_filename && *p)
+					strbuf_addf(&buf, " %s:",
+						    current_filename);
+				strbuf_addstr(&buf, p);
+				strbuf_addch(&buf, '\n');
+				util->diffsize++;
+				continue;
+			}
+
+			if (util) {
+				string_list_append(list, buf.buf)->util = util;
+				strbuf_reset(&buf);
+			}
+			util = xcalloc(1, sizeof(*util));
+			oidcpy(&util->oid, null_oid());
+			util->matching = -1;
+			author = subject = NULL;
+			state = MBOX_BEFORE_HEADER;
+		}
+	}
+	strbuf_release(&contents);
+
+	if (util) {
+		if (state == MBOX_IN_DIFF)
+			string_list_append(list, buf.buf)->util = util;
+		else
+			free(util);
+	}
+	strbuf_release(&buf);
+	strbuf_release(&long_subject);
+	free(current_filename);
+
+	return 0;
+}
+
 /*
  * Reads the patches into a string list, with the `util` field being populated
  * as struct object_id (will need to be free()d).
@@ -41,6 +329,10 @@ static int read_patches(const char *range, struct string_list *list,
 	ssize_t len;
 	size_t size;
 	int ret = -1;
+	const char *path;
+
+	if (skip_prefix(range, "mbox:", &path))
+		return read_mbox(path, list);
 
 	strvec_pushl(&cp.args, "log", "--no-color", "-p", "--no-merges",
 		     "--reverse", "--date-order", "--decorate=no",
@@ -424,6 +716,19 @@ static void output_pair_header(struct diff_options *diffopt,
 
 		strbuf_addch(buf, ' ');
 		pp_commit_easy(CMIT_FMT_ONELINE, commit, buf);
+	} else {
+		struct patch_util *util = b_util ? b_util : a_util;
+		const char *needle = "\n ## Commit message ##\n";
+		const char *p = !util || !util->patch ?
+			NULL : strstr(util->patch, needle);
+		if (p) {
+			if (status == '!')
+				strbuf_addf(buf, "%s%s", color_reset, color);
+
+			strbuf_addch(buf, ' ');
+			p += strlen(needle);
+			strbuf_add(buf, p, strchrnul(p, '\n') - p);
+		}
 	}
 	strbuf_addf(buf, "%s\n", color_reset);
 
@@ -554,6 +859,9 @@ int show_range_diff(const char *range1, const char *range2,
 	if (range_diff_opts->left_only && range_diff_opts->right_only)
 		res = error(_("options '%s' and '%s' cannot be used together"), "--left-only", "--right-only");
 
+	if (!strcmp(range1, "mbox:-") && !strcmp(range2, "mbox:-"))
+		res = error(_("only one mbox can be read from stdin"));
+
 	if (!res && read_patches(range1, &branch1, range_diff_opts->other_arg))
 		res = error(_("could not parse log for '%s'"), range1);
 	if (!res && read_patches(range2, &branch2, range_diff_opts->other_arg))
@@ -575,10 +883,17 @@ int show_range_diff(const char *range1, const char *range2,
 int is_range_diff_range(const char *arg)
 {
 	char *copy = xstrdup(arg); /* setup_revisions() modifies it */
-	const char *argv[] = { "", copy, "--", NULL };
+	const char *argv[] = { "", copy, "--", NULL }, *path;
 	int i, positive = 0, negative = 0;
 	struct rev_info revs;
 
+	if (skip_prefix(arg, "mbox:", &path)) {
+		if (!strcmp(path, "-") || file_exists(path))
+			return 1;
+		error_errno(_("not an mbox: '%s'"), path);
+		return 0;
+	}
+
 	init_revisions(&revs, NULL);
 	if (setup_revisions(3, argv, &revs, NULL) == 1) {
 		for (i = 0; i < revs.pending.nr; i++)
diff --git a/t/t3206-range-diff.sh b/t/t3206-range-diff.sh
index 459beaf7d9c..2b64d30e8e6 100755
--- a/t/t3206-range-diff.sh
+++ b/t/t3206-range-diff.sh
@@ -783,6 +783,15 @@ test_expect_success 'ranges with pathspecs' '
 	! grep "$topic_oid" actual
 '
 
+test_expect_success 'compare range vs mbox' '
+	git format-patch --stdout topic..mode-only-change >mbox &&
+	git range-diff topic...mode-only-change >expect &&
+	git range-diff mode-only-change..topic mbox:./mbox >actual &&
+	test_cmp expect actual &&
+	git range-diff mode-only-change..topic mbox:- <mbox >actual &&
+	test_cmp expect actual
+'
+
 test_expect_success 'submodule changes are shown irrespective of diff.submodule' '
 	git init sub-repo &&
 	test_commit -C sub-repo sub-first &&

base-commit: b75747829f4c277323c78b1c5973ad63ea038a2d
-- 
gitgitgadget
