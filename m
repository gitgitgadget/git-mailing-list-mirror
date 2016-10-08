Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.5 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7CAEF1F4F8
	for <e@80x24.org>; Sat,  8 Oct 2016 15:39:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752338AbcJHPjP (ORCPT <rfc822;e@80x24.org>);
        Sat, 8 Oct 2016 11:39:15 -0400
Received: from mout.web.de ([217.72.192.78]:49281 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751412AbcJHPjN (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 8 Oct 2016 11:39:13 -0400
Received: from [192.168.178.36] ([79.213.121.94]) by smtp.web.de (mrweb102)
 with ESMTPSA (Nemesis) id 0MMVpy-1bnwQo0jl8-008LbF; Sat, 08 Oct 2016 17:38:56
 +0200
X-Mozilla-News-Host: news://news.gmane.org:119
To:     Git List <git@vger.kernel.org>
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
Subject: [PATCH] use strbuf_add_unique_abbrev() for adding short hashes, part
 3
Message-ID: <c830e99d-4fc9-b001-cce3-38f66dc2c678@web.de>
Date:   Sat, 8 Oct 2016 17:38:47 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.4.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K0:O49zcKkTg6JEThFMBAnh3zVuElIreAIza3nXcs8rCcBoCQFTTCH
 ZaIrr481WDeW6qI7/P8NrpyCXve4Ie6V4WJtDQvYFDb3XIGDyr35KUeWrqnHOjqUurx9wK/
 /tM3JFjzJN8eLrwrLc/9Xf/JZXVdbX53M3bDNXQwahXvldX0fnUgdP4Pd8dO2MHGkZ6s1w8
 l6J4bm3PMWt26QkbNDc8A==
X-UI-Out-Filterresults: notjunk:1;V01:K0:P52pFuML9Wc=:yaJ80SzOoTY6LR/KER8qWI
 B98kkPTUSxgSTT1mlrtIrgyBc+o75Bgh6CsgbKheAFA9rwArHzefCoBp6H+I9FVflDtiNoKpl
 vavPkrGsIZtpeUe60B+O2E+ESJPU4K+dmjBZghDTLnp0C4GJRLYaIZh3/nH5ESYkyf/1Gb763
 ZlYh7Qze6aVnHfdlgckkq5nqFFfSyDBZNac4l9L2+WzKVghier6wQE0TKArnttojrEyab1xLA
 IiS/GOccI582CAPoCYa4zUf/9CiRmrtZj9jlwUaLSj+Jz0aEPh5mYc08AQgxkYfFJNXGYbUs5
 AlEXqs0Zs++nudo2Q7Abb+d1PCqbtBP4RLbcOjGOtxL+TX/X7klpce4vYmhx148QmyZbw9d7a
 NC5YJv4eY4Wr+vPr2/tQbF23NIDf8PlXX3rtbNQlbN/VXibmayB8rIqWM6bhufPOyP9rvLNSx
 CtC9zDegjZJkfpCBKckulncNP1IbfKaXpHO9n1Xnl/D6U1/UfVr8vK3E8FyBL5Cnt1QU4wsQ4
 8MmUYBe9MPEmqCikn5cr8bIPD9JYXiEdiNW0dSoEqJJ7T47mNVnE4DB0I5UWAFwMYXjXw6fu/
 k/tseIeI8NXM9fhjdxaUEGX8PBUd6uGQVNM6CdtUNQ5QDJCvwtJkTfzE1ogmobYqMsUNV7zaj
 dge2n+Gmsv42YHlk7m7HS6m6JWDNKIN9TGKcv1XW3BdEDBCHHugn4Pys9tdFedFxLDJn+krGN
 Ha2Jm5KQP4hWlyAQvhmy/xdzQRxRccCTZyBnBtE7fXiv9qfjdBmFbowH+vicSfEd3RtMq0Lub
 zx22GVG
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Call strbuf_add_unique_abbrev() to add abbreviated hashes to strbufs
instead of taking detours through find_unique_abbrev() and its static
buffer.  This is shorter in most cases and a bit more efficient.

The changes here are not easily handled by a semantic patch because
they involve removing temporary variables and deconstructing format
strings for strbuf_addf().

Signed-off-by: Rene Scharfe <l.s.r@web.de>
---
 merge-recursive.c |  6 +++---
 pretty.c          | 12 +++++-------
 submodule.c       |  7 +++----
 wt-status.c       | 10 ++++------
 4 files changed, 15 insertions(+), 20 deletions(-)

diff --git a/merge-recursive.c b/merge-recursive.c
index 5200d5c..9041c2f 100644
--- a/merge-recursive.c
+++ b/merge-recursive.c
@@ -202,9 +202,9 @@ static void output_commit_title(struct merge_options *o, struct commit *commit)
 		strbuf_addf(&o->obuf, "virtual %s\n",
 			merge_remote_util(commit)->name);
 	else {
-		strbuf_addf(&o->obuf, "%s ",
-			find_unique_abbrev(commit->object.oid.hash,
-				DEFAULT_ABBREV));
+		strbuf_add_unique_abbrev(&o->obuf, commit->object.oid.hash,
+					 DEFAULT_ABBREV);
+		strbuf_addch(&o->obuf, ' ');
 		if (parse_commit(commit) != 0)
 			strbuf_addstr(&o->obuf, _("(bad commit)\n"));
 		else {
diff --git a/pretty.c b/pretty.c
index 25efbca..0c31495 100644
--- a/pretty.c
+++ b/pretty.c
@@ -544,15 +544,13 @@ static void add_merge_info(const struct pretty_print_context *pp,
 	strbuf_addstr(sb, "Merge:");
 
 	while (parent) {
-		struct commit *p = parent->item;
-		const char *hex = NULL;
+		struct object_id *oidp = &parent->item->object.oid;
+		strbuf_addch(sb, ' ');
 		if (pp->abbrev)
-			hex = find_unique_abbrev(p->object.oid.hash, pp->abbrev);
-		if (!hex)
-			hex = oid_to_hex(&p->object.oid);
+			strbuf_add_unique_abbrev(sb, oidp->hash, pp->abbrev);
+		else
+			strbuf_addstr(sb, oid_to_hex(oidp));
 		parent = parent->next;
-
-		strbuf_addf(sb, " %s", hex);
 	}
 	strbuf_addch(sb, '\n');
 }
diff --git a/submodule.c b/submodule.c
index 2de06a3..476f60b 100644
--- a/submodule.c
+++ b/submodule.c
@@ -392,10 +392,9 @@ static void show_submodule_header(FILE *f, const char *path,
 	}
 
 output_header:
-	strbuf_addf(&sb, "%s%sSubmodule %s %s..", line_prefix, meta, path,
-			find_unique_abbrev(one->hash, DEFAULT_ABBREV));
-	if (!fast_backward && !fast_forward)
-		strbuf_addch(&sb, '.');
+	strbuf_addf(&sb, "%s%sSubmodule %s ", line_prefix, meta, path);
+	strbuf_add_unique_abbrev(&sb, one->hash, DEFAULT_ABBREV);
+	strbuf_addstr(&sb, (fast_backward || fast_forward) ? ".." : "...");
 	strbuf_add_unique_abbrev(&sb, two->hash, DEFAULT_ABBREV);
 	if (message)
 		strbuf_addf(&sb, " %s%s\n", message, reset);
diff --git a/wt-status.c b/wt-status.c
index 99d1b0a..ca5c45f 100644
--- a/wt-status.c
+++ b/wt-status.c
@@ -1110,7 +1110,6 @@ static void abbrev_sha1_in_line(struct strbuf *line)
 	split = strbuf_split_max(line, ' ', 3);
 	if (split[0] && split[1]) {
 		unsigned char sha1[20];
-		const char *abbrev;
 
 		/*
 		 * strbuf_split_max left a space. Trim it and re-add
@@ -1118,9 +1117,10 @@ static void abbrev_sha1_in_line(struct strbuf *line)
 		 */
 		strbuf_trim(split[1]);
 		if (!get_sha1(split[1]->buf, sha1)) {
-			abbrev = find_unique_abbrev(sha1, DEFAULT_ABBREV);
 			strbuf_reset(split[1]);
-			strbuf_addf(split[1], "%s ", abbrev);
+			strbuf_add_unique_abbrev(split[1], sha1,
+						 DEFAULT_ABBREV);
+			strbuf_addch(split[1], ' ');
 			strbuf_reset(line);
 			for (i = 0; split[i]; i++)
 				strbuf_addbuf(line, split[i]);
@@ -1343,10 +1343,8 @@ static char *get_branch(const struct worktree *wt, const char *path)
 	else if (starts_with(sb.buf, "refs/"))
 		;
 	else if (!get_sha1_hex(sb.buf, sha1)) {
-		const char *abbrev;
-		abbrev = find_unique_abbrev(sha1, DEFAULT_ABBREV);
 		strbuf_reset(&sb);
-		strbuf_addstr(&sb, abbrev);
+		strbuf_add_unique_abbrev(&sb, sha1, DEFAULT_ABBREV);
 	} else if (!strcmp(sb.buf, "detached HEAD")) /* rebase */
 		goto got_nothing;
 	else			/* bisect */
-- 
2.10.1

