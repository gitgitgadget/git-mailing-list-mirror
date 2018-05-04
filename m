Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 97D7B200B9
	for <e@80x24.org>; Fri,  4 May 2018 15:35:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751401AbeEDPeu (ORCPT <rfc822;e@80x24.org>);
        Fri, 4 May 2018 11:34:50 -0400
Received: from mout.gmx.net ([212.227.17.22]:54807 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751294AbeEDPer (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 4 May 2018 11:34:47 -0400
Received: from virtualbox.mshome.net ([37.201.195.116]) by mail.gmx.com
 (mrgmx101 [212.227.17.168]) with ESMTPSA (Nemesis) id
 0MEKZg-1f7xpu2ce0-00FPJ3; Fri, 04 May 2018 17:34:38 +0200
From:   Johannes Schindelin <johannes.schindelin@gmx.de>
To:     git@vger.kernel.org
Cc:     Johannes Schindelin <johannes.schindelin@gmx.de>,
        Junio C Hamano <gitster@pobox.com>,
        Thomas Rast <tr@thomasrast.ch>,
        Thomas Gummerer <t.gummerer@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>, Ramsay Jones <ramsay@ramsayjones.plus.com>,
        Stefan Beller <sbeller@google.com>,
        Jacob Keller <jacob.keller@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>
Subject: [PATCH v2 03/18] branch-diff: first rudimentary implementation
Date:   Fri,  4 May 2018 17:34:36 +0200
Message-Id: <e530e450ebd307b72a64c81e4192bbb0df57cf65.1525448066.git.johannes.schindelin@gmx.de>
X-Mailer: git-send-email 2.17.0.409.g71698f11835
In-Reply-To: <cover.1525448066.git.johannes.schindelin@gmx.de>
References: <cover.1525361419.git.johannes.schindelin@gmx.de> <cover.1525448066.git.johannes.schindelin@gmx.de>
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:LNg4fkJC2i2uxsFGK5TLFu4vE2xW+dPp9cGo7UlXyLXlJEIAXB9
 eT83RNHnFDD+YXdK1YWjOhgnveJ47lQPQNQtnJanTM/tg9iuvGfsD4opOQUBbCJycxMeG1A
 qfLv9rIM5wfXnsAmniqpwzdhe13wJOdHHfMfvpI5dMMt5NFbrMESVF9s1D9MYEVim3EBjMK
 EOzORigiUnIFArIcghGYQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:jMFAusAQG+8=:Ao9+b/ttIMI9Go5hMlzz28
 nbq8aRtavumRKPmoPECO7LRvjz2vQjWOXFKfErTgZ4WnxPxmTU5YVh9zDUQVvv0q3IuYqcyOc
 9Ikwc+fg1FFv2alzezSPE6kmoLWsRkPgMhMP9lXjIviG64nHRVXwsiF1tUzhrOc1CiZfHo9hV
 oV4SkAINgUqeSQzUnWziCt5XRcF4IGxHztr6mrt9f11+pjsiHSSGOvUcZBbKdTpoOlvVJL6Wf
 htbn0gjO9OQeB67j37NHjjO451ltd5v2kuFiS9OULZbmzWhom43Juhe/n9ZGTZGVeih12zDXS
 xKyOpNdwq19L2a+j0+desXrVVKfQhYW5KDgI93uazTvCejjzf6Gm5OaTUPyvW/5m2Fv3vBkIY
 ec9qFT0zXxpjdh5NCz2EyxMWWTzzpRx9a79I35Xzbl16OEsELOigGpw8dPkJOH/jAivQQR7GY
 9AhYpNx0DJvQ5RwqFZipyuSP7lu/SmzfUG1hj8Lmqy060w0JAL35HQFp38Jh64iwvHt9HPJwF
 6bn6QBZOkYBxQW32/OGSwHc0k6Lw74k3ITTzc0HH8TWAOmrDhmq7UgfGB8VQ6o4uoZRDlLji2
 8Ev+EAiRwcYUT6x6fiacmwlCV16y6Hqq7eG5gzMVzkF4CxFD9khzyCRV1uGMrjTf8gwdnD8Uu
 vzqzFoy2ApOmjO4UTeN9xt0y+AUMWEKHUc0Q+iheAf7Gt1mCL1TVi61PEOj/dKAKZrgmJY17J
 hvTQAAFvm4fSJwIrqPhjn7ZlixEWeiKlT6jDUAjaJKOEZdezgxMBP4VAG5ZNLqYMURQmVMaRP
 zyG8KWe
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

At this stage, `git branch-diff` can determine corresponding commits of
two related commit ranges. This makes use of the recently introduced
implementation of the Hungarian algorithm.

The core of this patch is a straight port of the ideas of tbdiff, the
seemingly dormant project at https://github.com/trast/tbdiff.

The output does not at all match `tbdiff`'s output yet, as this patch
really concentrates on getting the patch matching part right.

Note: due to differences in the diff algorithm (`tbdiff` uses the
Python module `difflib`, Git uses its xdiff fork), the cost matrix
calculated by `branch-diff` is different (but very similar) to the one
calculated by `tbdiff`. Therefore, it is possible that they find
different matching commits in corner cases (e.g. when a patch was split
into two patches of roughly equal length).

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 builtin/branch-diff.c | 335 +++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 334 insertions(+), 1 deletion(-)

diff --git a/builtin/branch-diff.c b/builtin/branch-diff.c
index 60a4b4fbe30..c462681067c 100644
--- a/builtin/branch-diff.c
+++ b/builtin/branch-diff.c
@@ -1,6 +1,12 @@
 #include "cache.h"
 #include "builtin.h"
 #include "parse-options.h"
+#include "string-list.h"
+#include "run-command.h"
+#include "argv-array.h"
+#include "hashmap.h"
+#include "xdiff-interface.h"
+#include "hungarian.h"
 
 static const char * const builtin_branch_diff_usage[] = {
 N_("git branch-diff [<options>] <old-base>..<old-tip> <new-base>..<new-tip>"),
@@ -20,6 +26,279 @@ static int parse_creation_weight(const struct option *opt, const char *arg,
 	return 0;
 }
 
+struct patch_util {
+	/* For the search for an exact match */
+	struct hashmap_entry e;
+	const char *diff, *patch;
+
+	int i;
+	int diffsize;
+	size_t diff_offset;
+	/* the index of the matching item in the other branch, or -1 */
+	int matching;
+	struct object_id oid;
+};
+
+/*
+ * Reads the patches into a string list, with the `util` field being populated
+ * as struct object_id (will need to be free()d).
+ */
+static int read_patches(const char *range, struct string_list *list)
+{
+	struct child_process cp = CHILD_PROCESS_INIT;
+	FILE *in;
+	struct strbuf buf = STRBUF_INIT, line = STRBUF_INIT;
+	struct patch_util *util = NULL;
+	int in_header = 1;
+
+	argv_array_pushl(&cp.args, "log", "--no-color", "-p", "--no-merges",
+			"--reverse", "--date-order", "--decorate=no",
+			"--no-abbrev-commit", range,
+			NULL);
+	cp.out = -1;
+	cp.no_stdin = 1;
+	cp.git_cmd = 1;
+
+	if (start_command(&cp))
+		return error_errno(_("could not start `log`"));
+	in = fdopen(cp.out, "r");
+	if (!in) {
+		error_errno(_("could not read `log` output"));
+		finish_command(&cp);
+		return -1;
+	}
+
+	while (strbuf_getline(&line, in) != EOF) {
+		const char *p;
+
+		if (skip_prefix(line.buf, "commit ", &p)) {
+			if (util) {
+				string_list_append(list, buf.buf)->util = util;
+				strbuf_reset(&buf);
+			}
+			util = xcalloc(sizeof(*util), 1);
+			if (get_oid(p, &util->oid)) {
+				error(_("could not parse commit '%s'"), p);
+				free(util);
+				string_list_clear(list, 1);
+				strbuf_release(&buf);
+				strbuf_release(&line);
+				fclose(in);
+				finish_command(&cp);
+				return -1;
+			}
+			util->matching = -1;
+			in_header = 1;
+			continue;
+		}
+
+		if (starts_with(line.buf, "diff --git")) {
+			in_header = 0;
+			strbuf_addch(&buf, '\n');
+			if (!util->diff_offset)
+				util->diff_offset = buf.len;
+			strbuf_addbuf(&buf, &line);
+		} else if (in_header) {
+			if (starts_with(line.buf, "Author: ")) {
+				strbuf_addbuf(&buf, &line);
+				strbuf_addstr(&buf, "\n\n");
+			} else if (starts_with(line.buf, "    ")) {
+				strbuf_addbuf(&buf, &line);
+				strbuf_addch(&buf, '\n');
+			}
+			continue;
+		} else if (starts_with(line.buf, "@@ "))
+			strbuf_addstr(&buf, "@@");
+		else if (line.buf[0] && !starts_with(line.buf, "index "))
+			/*
+			 * A completely blank (not ' \n', which is context)
+			 * line is not valid in a diff.  We skip it
+			 * silently, because this neatly handles the blank
+			 * separator line between commits in git-log
+			 * output.
+			 */
+			strbuf_addbuf(&buf, &line);
+		else
+			continue;
+
+		strbuf_addch(&buf, '\n');
+		util->diffsize++;
+	}
+	fclose(in);
+	strbuf_release(&line);
+
+	if (util)
+		string_list_append(list, buf.buf)->util = util;
+	strbuf_release(&buf);
+
+	if (finish_command(&cp))
+		return -1;
+
+	return 0;
+}
+
+static int patch_util_cmp(const void *dummy, const struct patch_util *a,
+		     const struct patch_util *b, const char *keydata)
+{
+	return strcmp(a->diff, keydata ? keydata : b->diff);
+}
+
+static void find_exact_matches(struct string_list *a, struct string_list *b)
+{
+	struct hashmap map;
+	int i;
+
+	hashmap_init(&map, (hashmap_cmp_fn)patch_util_cmp, NULL, 0);
+
+	/* First, add the patches of a to a hash map */
+	for (i = 0; i < a->nr; i++) {
+		struct patch_util *util = a->items[i].util;
+
+		util->i = i;
+		util->patch = a->items[i].string;
+		util->diff = util->patch + util->diff_offset;
+		hashmap_entry_init(util, strhash(util->diff));
+		hashmap_add(&map, util);
+	}
+
+	/* Now try to find exact matches in b */
+	for (i = 0; i < b->nr; i++) {
+		struct patch_util *util = b->items[i].util, *other;
+
+		util->i = i;
+		util->patch = b->items[i].string;
+		util->diff = util->patch + util->diff_offset;
+		hashmap_entry_init(util, strhash(util->diff));
+		other = hashmap_remove(&map, util, NULL);
+		if (other) {
+			if (other->matching >= 0)
+				BUG("already assigned!");
+
+			other->matching = i;
+			util->matching = other->i;
+		}
+	}
+
+	hashmap_free(&map, 0);
+}
+
+static void diffsize_consume(void *data, char *line, unsigned long len)
+{
+	(*(int *)data)++;
+}
+
+static int diffsize(const char *a, const char *b)
+{
+	xpparam_t pp = { 0 };
+	xdemitconf_t cfg = { 0 };
+	mmfile_t mf1, mf2;
+	int count = 0;
+
+	mf1.ptr = (char *)a;
+	mf1.size = strlen(a);
+	mf2.ptr = (char *)b;
+	mf2.size = strlen(b);
+
+	cfg.ctxlen = 3;
+	if (!xdi_diff_outf(&mf1, &mf2, diffsize_consume, &count, &pp, &cfg))
+		return count;
+
+	error(_("failed to generate diff"));
+	return INT_MAX;
+}
+
+static int get_correspondences(struct string_list *a, struct string_list *b,
+			       double creation_weight)
+{
+	int n = a->nr + b->nr;
+	double *cost = xmalloc(sizeof(double) * n * n), c;
+	int *a2b = xmalloc(sizeof(int) * n), *b2a = xmalloc(sizeof(int) * n);
+	int i, j, res;
+
+	for (i = 0; i < a->nr; i++) {
+		struct patch_util *a_util = a->items[i].util;
+
+		for (j = 0; j < b->nr; j++) {
+			struct patch_util *b_util = b->items[j].util;
+
+			if (a_util->matching == j)
+				c = 0;
+			else if (a_util->matching < 0 && b_util->matching < 0)
+				c = diffsize(a_util->diff, b_util->diff);
+			else
+				c = INT_MAX;
+			cost[i + n * j] = c;
+		}
+
+		c = a_util->matching < 0 ?
+			a_util->diffsize * creation_weight : INT_MAX;
+		for (j = b->nr; j < n; j++)
+			cost[i + n * j] = c;
+	}
+
+	for (j = 0; j < b->nr; j++) {
+		struct patch_util *util = b->items[j].util;
+
+		c = util->matching < 0 ?
+			util->diffsize * creation_weight : INT_MAX;
+		for (i = a->nr; i < n; i++)
+			cost[i + n * j] = c;
+	}
+
+	for (i = a->nr; i < n; i++)
+		for (j = b->nr; j < n; j++)
+			cost[i + n * j] = 0;
+
+	res = compute_assignment(n, n, cost, a2b, b2a);
+
+	for (i = 0; i < a->nr; i++)
+		if (a2b[i] >= 0 && a2b[i] < b->nr) {
+			struct patch_util *a_util = a->items[i].util;
+			struct patch_util *b_util = b->items[a2b[i]].util;
+
+			a_util->matching = a2b[i];
+			b_util->matching = i;
+		}
+
+	free(cost);
+	free(a2b);
+	free(b2a);
+
+	return res;
+}
+
+static const char *short_oid(struct patch_util *util)
+{
+	return find_unique_abbrev(&util->oid, DEFAULT_ABBREV);
+}
+
+static void output(struct string_list *a, struct string_list *b)
+{
+	int i;
+
+	for (i = 0; i < b->nr; i++) {
+		struct patch_util *util = b->items[i].util, *prev;
+
+		if (util->matching < 0)
+			printf("-: -------- > %d: %s\n",
+					i + 1, short_oid(util));
+		else {
+			prev = a->items[util->matching].util;
+			printf("%d: %s ! %d: %s\n",
+			       util->matching + 1, short_oid(prev),
+			       i + 1, short_oid(util));
+		}
+	}
+
+	for (i = 0; i < a->nr; i++) {
+		struct patch_util *util = a->items[i].util;
+
+		if (util->matching < 0)
+			printf("%d: %s < -: --------\n",
+			       i + 1, short_oid(util));
+	}
+}
+
 int cmd_branch_diff(int argc, const char **argv, const char *prefix)
 {
 	double creation_weight = 0.6;
@@ -30,9 +309,63 @@ int cmd_branch_diff(int argc, const char **argv, const char *prefix)
 			0, parse_creation_weight },
 		OPT_END()
 	};
+	int res = 0;
+	struct strbuf range1 = STRBUF_INIT, range2 = STRBUF_INIT;
+	struct string_list branch1 = STRING_LIST_INIT_DUP;
+	struct string_list branch2 = STRING_LIST_INIT_DUP;
 
 	argc = parse_options(argc, argv, NULL, options,
 			builtin_branch_diff_usage, 0);
 
-	return 0;
+	if (argc == 2) {
+		if (!strstr(argv[0], ".."))
+			warning(_("no .. in range: '%s'"), argv[0]);
+		strbuf_addstr(&range1, argv[0]);
+
+		if (!strstr(argv[1], ".."))
+			warning(_("no .. in range: '%s'"), argv[1]);
+		strbuf_addstr(&range2, argv[1]);
+	} else if (argc == 3) {
+		strbuf_addf(&range1, "%s..%s", argv[0], argv[1]);
+		strbuf_addf(&range2, "%s..%s", argv[0], argv[2]);
+	} else if (argc == 1) {
+		const char *b = strstr(argv[0], "..."), *a = argv[0];
+		int a_len;
+
+		if (!b)
+			die(_("single arg format requires a symmetric range"));
+
+		a_len = (int)(b - a);
+		if (!a_len) {
+			a = "HEAD";
+			a_len = strlen(a);
+		}
+		b += 3;
+		if (!*b)
+			b = "HEAD";
+		strbuf_addf(&range1, "%s..%.*s", b, a_len, a);
+		strbuf_addf(&range2, "%.*s..%s", a_len, a, b);
+	} else {
+		error(_("need two commit ranges"));
+		usage_with_options(builtin_branch_diff_usage, options);
+	}
+
+	if (read_patches(range1.buf, &branch1))
+		res = error(_("could not parse log for '%s'"), range1.buf);
+	if (!res && read_patches(range2.buf, &branch2))
+		res = error(_("could not parse log for '%s'"), range2.buf);
+
+	if (!res) {
+		find_exact_matches(&branch1, &branch2);
+		res = get_correspondences(&branch1, &branch2, creation_weight);
+		if (!res)
+			output(&branch1, &branch2);
+	}
+
+	strbuf_release(&range1);
+	strbuf_release(&range2);
+	string_list_clear(&branch1, 1);
+	string_list_clear(&branch2, 1);
+
+	return !!res;
 }
-- 
2.17.0.409.g71698f11835


