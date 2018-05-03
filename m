Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B3578200B9
	for <e@80x24.org>; Thu,  3 May 2018 15:30:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751416AbeECPao (ORCPT <rfc822;e@80x24.org>);
        Thu, 3 May 2018 11:30:44 -0400
Received: from mout.gmx.net ([212.227.17.20]:43899 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751382AbeECPak (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 3 May 2018 11:30:40 -0400
Received: from virtualbox.mshome.net ([37.201.195.116]) by mail.gmx.com
 (mrgmx103 [212.227.17.168]) with ESMTPSA (Nemesis) id
 0LevUh-1eYqpf06NL-00qgiq; Thu, 03 May 2018 17:30:36 +0200
From:   Johannes Schindelin <johannes.schindelin@gmx.de>
To:     git@vger.kernel.org
Cc:     Johannes Schindelin <johannes.schindelin@gmx.de>,
        Junio C Hamano <gitster@pobox.com>,
        Thomas Rast <tr@thomasrast.ch>,
        Thomas Gummerer <t.gummerer@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH 03/18] branch-diff: first rudimentary implementation
Date:   Thu,  3 May 2018 17:30:31 +0200
Message-Id: <ec51c71779a325263c1b705a6b1bfb003fcd528a.1525361419.git.johannes.schindelin@gmx.de>
X-Mailer: git-send-email 2.17.0.409.g0f525fc0ba7
In-Reply-To: <cover.1525361419.git.johannes.schindelin@gmx.de>
References: <cover.1525361419.git.johannes.schindelin@gmx.de>
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:1jFfZ3dQ9GFUoaj2NZ51IFXLV7JZogUj1vSNpUDkKNaCXAb1Brw
 QzkUUVXqGDQ7Yz01s+nJpT3LK3A+4iwh1a2Ur9DsjbLJpCEXw7HagM/Mx0Se4XIbc/XuPPC
 e/FVr2YZLRlbhbkBTx+qlN30Hw2l0XtTEcmGcxMGmsSiw6sgu45og3jm++A4b/jj2LEfpEj
 a+b6AcXPia00CF2R2CkJQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:4WjilgVMG8M=:2okuDxlY10Fk1imPMhLIhD
 z6PbZWNRrEoRjxryi6aBspASixda4bg7hkZrRPKQJJbEIIvsUigRTpkCpcYz6u2tYelRbCwG8
 eF39S/b+UQ+4JIjMaLnvq6v82KJcTc3TcdFkR2fzffTL1ypjxly6/ezyTz/H2WWTiLxwub2rY
 OBZ0eJKy2XMjjwJWWv6WX/ybTjDSZZ7XlJvQIUmJCLIDRyWpK00B/qWvkhUKthlXC9BfC3UNC
 2donI5nEwD41/mr/fu2IDVk27C5FpMHiQcZr2dRbOYUAYmE/uwKJkiVg6RCl/Avn/hIMfl1pX
 5OhhnmqgJZQfXrGu8rFQl6tZP495HI36/Tu4IcRR9907vh9re7GM96UFiTAMdrtKB/rbVYcsY
 dN8paMrhFg1+DQpok79XaKLVBSKZXJ1HogrmrFzVAdI1pKXKZyGh0KDjMx3wU1Mf2TrQmnvSH
 NLMJA/QvEdNQsv9kBBORToYJ0s+QU1ffGV0jLjwSZ+5EUU20ZpYMjgILVkuGF7Asv53pbZhNX
 fSjPOocxXwhTILx33QbeQ3cZt0/D8Tv4Yv0CJsX3kmoZDjEfA2gXPcbpu4Tki2QXRPwXHZer6
 e5Svgm57HaU0cLubdC0caGKS8vsRJWQhkU/e0NXpSdSA15U0Mn6a1HUh+Im1eLj7v8Ce9kTy3
 M1YCEmAyXrwpwlNNHL0iUv0eB1hotZNNZvLlVhcwcRBAM7W2g1QM7PrhzlyfCxh4rHggxaFcW
 qj5wp8Fb1cmVsk4Jkg67RIWXUnpOk2dLaPxPWByf5e/rpUEW7a3GrUAAjg/ziPsZo0bGuIt9a
 BQ2qCwy
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
Pythong module `difflib`, Git uses its xdiff fork), the cost matrix
calculated by `branch-diff` is different (but very similar) to the one
calculated by `tbdiff`. Therefore, it is possible that they find
different matching commits in corner cases (e.g. when a patch was split
into two patches of roughly equal length).

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 builtin/branch-diff.c | 337 +++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 334 insertions(+), 3 deletions(-)

diff --git a/builtin/branch-diff.c b/builtin/branch-diff.c
index 97266cd326d..02dc06a57ca 100644
--- a/builtin/branch-diff.c
+++ b/builtin/branch-diff.c
@@ -1,13 +1,17 @@
 #include "cache.h"
 #include "parse-options.h"
+#include "string-list.h"
+#include "run-command.h"
+#include "argv-array.h"
+#include "hashmap.h"
+#include "xdiff-interface.h"
+#include "hungarian.h"
 
 static const char * const builtin_branch_diff_usage[] = {
 	N_("git rebase--helper [<options>] ( A..B C..D | A...B | base A B )"),
 	NULL
 };
 
-#define COLOR_DUAL_MODE 2
-
 static int parse_creation_weight(const struct option *opt, const char *arg,
 				 int unset)
 {
@@ -19,6 +23,279 @@ static int parse_creation_weight(const struct option *opt, const char *arg,
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
+
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
 	int no_patches = 0;
@@ -32,9 +309,63 @@ int cmd_branch_diff(int argc, const char **argv, const char *prefix)
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
+		error("Need two commit ranges");
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
2.17.0.395.g6a618d6010f.dirty


