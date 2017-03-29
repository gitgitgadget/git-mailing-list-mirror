Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CA24820958
	for <e@80x24.org>; Wed, 29 Mar 2017 14:39:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752381AbdC2Ojo (ORCPT <rfc822;e@80x24.org>);
        Wed, 29 Mar 2017 10:39:44 -0400
Received: from mout.kundenserver.de ([217.72.192.73]:58604 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752369AbdC2Ojn (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 29 Mar 2017 10:39:43 -0400
Received: from localhost ([130.75.46.4]) by mrelayeu.kundenserver.de (mreue102
 [212.227.15.183]) with ESMTPSA (Nemesis) id 0M7bqp-1by7UP3xCR-00xMVY; Wed, 29
 Mar 2017 16:39:27 +0200
From:   Michael J Gruber <git@grubix.eu>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Lars Schneider <larsxschneider@gmail.com>,
        Luke Diamand <luke@diamand.org>
Subject: [PATCH v2 3/3] name-rev: provide debug output
Date:   Wed, 29 Mar 2017 16:39:17 +0200
Message-Id: <a9630cb3485bd2933f0addc65b90da57a09b783d.1490798142.git.git@grubix.eu>
X-Mailer: git-send-email 2.12.2.712.gba4c48c431
In-Reply-To: <xmqqa88j5xsx.fsf@gitster.mtv.corp.google.com>
References: <xmqqa88j5xsx.fsf@gitster.mtv.corp.google.com>
In-Reply-To: <cover.1490798142.git.git@grubix.eu>
References: <cover.1490798142.git.git@grubix.eu>
X-Provags-ID: V03:K0:Zk+vyxKbAp+TnD7Ls0ZwWpCc3m2/0tCG016oH734ZXXAnY5XKhc
 wIzDDEyKoEdd/+TfLS/OjCd4hVR+bAWsYQ3njMfUijWmIk4lBGEc6LtOwN53/FSvQ+V39pN
 7v4fM2gNjODCvToqdzj4E21CSmBfflln+MoQPif+uIR/kxPZsW7kwtFTbt6ttFpur5TkGdG
 FWG4VOiPj1ZVfpKe1Xfiw==
X-UI-Out-Filterresults: notjunk:1;V01:K0:ceTBQ+S4Cgo=:UDKzyhuHzdhlhh5ROTm57q
 PlpNg1D9o7ttWYg5DfQwOdzM7DXBfCZPIY6ylrTyQsdCl3xqIqTre2ksdluZRz/SuyYocAJ5h
 uX7GxvPz6NHhgbh9x+qSFmXfteeVI16xldRjS+rsKYAJSo5DwOAfTg9PoxupXM3B6CgzX6uCW
 f8wrOetz0ch4eyPWEUs0kWYgO5Dh9SpsARAYCzmsWps4iAvXA1cp11NTZi2wWz9oCyWDVqZ3M
 G9f40A9gxvFLmL0pYSKGjOEzzwBeXl6J+/c0IEwvNlk6J5AJ3FZvWt/UmOzUN/kI6Fszk27/B
 pWNPyJ95S9vDo3omkcSP97g5i1NkGK6dmypX8PoRNSAB1eFS8M/pbDO6+WTvtWr3FosCaB/IY
 LueTlXwXfmsNVV3DWjLgoOXwhIZW7GRTqKNz6CjbAEkpIHIXFCzCGiDG4iHi6TZDzTJAyhxD5
 b2cc+I+XLoVXVdXr2YePdP3Y18GbO8mc3XvZ4g+J4twwn4SgX2hL3p68CqZUWYFxJgnUkj1sg
 OrczTz75Lo4L2d2SOQdETdGdssPLevLsNTSxGKHQZeQVHtwlGf+GzrmnZnRef5f/cLxOg6hei
 8DKxg4/YMF5hxWCA2pAQ20kZ0TmSGjTQp3nst5JSQTBKsd2PSW6KEqoSK9GGf9TFVLH6WhgJr
 rKOYL4/Syl9b0PC7ZN78MI+c4t9CshqhD3RPmuezHUYCCP8p7/wl1IW4Wxhd7Xvb4Euc=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Currently, `git describe --contains --debug` does not create any debug
output because it does not pass the flag down to `git name-rev`, which
does not know that flag.

Teach the latter that flag and the former to pass it down.

The output is patterned after that of `git describe --debug`, with the
following differences:

describe loops over all args to describe, then over all possible
descriptions; name-rev does it the other way round. Therefore, we need
to amend each possible description by the arg that it is for (and we
leave out the "searching to describe" header).

The date cut-off for name-rev kicks in way more often than the candidate
number cut-off of describe, so we do not clutter the output with the
cut-off.

Signed-off-by: Michael J Gruber <git@grubix.eu>
---
 builtin/describe.c |  2 ++
 builtin/name-rev.c | 64 +++++++++++++++++++++++++++++++++++++++++++-----------
 2 files changed, 53 insertions(+), 13 deletions(-)

diff --git a/builtin/describe.c b/builtin/describe.c
index a5cd8c513f..30196793f0 100644
--- a/builtin/describe.c
+++ b/builtin/describe.c
@@ -486,6 +486,8 @@ int cmd_describe(int argc, const char **argv, const char *prefix)
 				 NULL);
 		if (always)
 			argv_array_push(&args, "--always");
+		if (debug)
+			argv_array_push(&args, "--debug");
 		if (!all) {
 			argv_array_push(&args, "--tags");
 			for_each_string_list_item(item, &patterns)
diff --git a/builtin/name-rev.c b/builtin/name-rev.c
index bf7ed015ae..51302a79ba 100644
--- a/builtin/name-rev.c
+++ b/builtin/name-rev.c
@@ -18,6 +18,10 @@ typedef struct rev_name {
 
 static long cutoff = LONG_MAX;
 
+static const char *prio_names[] = {
+	N_("head"), N_("lightweight"), N_("annotated"),
+};
+
 /* How many generations are maximally preferred over _one_ merge traversal? */
 #define MERGE_TRAVERSAL_WEIGHT 65535
 
@@ -59,10 +63,19 @@ static int is_better_name(struct rev_name *name,
 	return 0;
 }
 
+struct name_ref_data {
+	int tags_only;
+	int name_only;
+	int debug;
+	struct string_list ref_filters;
+	struct string_list exclude_filters;
+	struct object_array *revs;
+};
+
 static void name_rev(struct commit *commit,
 		const char *tip_name, unsigned long taggerdate,
 		int generation, int distance, int from_tag,
-		int deref)
+		int deref, struct name_ref_data *data)
 {
 	struct rev_name *name = (struct rev_name *)commit->util;
 	struct commit_list *parents;
@@ -75,6 +88,7 @@ static void name_rev(struct commit *commit,
 
 	if (deref) {
 		tip_name = xstrfmt("%s^0", tip_name);
+		from_tag += 1;
 
 		if (generation)
 			die("generation: %d, but deref?", generation);
@@ -87,6 +101,36 @@ static void name_rev(struct commit *commit,
 	} else if (is_better_name(name, tip_name, taggerdate,
 				  generation, distance, from_tag)) {
 copy_data:
+		if (data->debug) {
+			int i;
+			static int label_width = -1;
+			static int name_width = -1;
+			if (label_width < 0) {
+				int w;
+				for (i = 0; i < ARRAY_SIZE(prio_names); i++) {
+					w = strlen(_(prio_names[i]));
+					if (label_width < w)
+						label_width = w;
+				}
+			}
+			if (name_width < 0) {
+				int w;
+				for (i = 0; i < data->revs->nr; i++) {
+					w = strlen(data->revs->objects[i].name);
+					if (name_width < w)
+						name_width = w;
+				}
+			}
+			for (i = 0; i < data->revs->nr; i++)
+				if (!oidcmp(&commit->object.oid,
+					    &data->revs->objects[i].item->oid))
+					fprintf(stderr, " %-*s %8d %-*s %s~%d\n",
+						label_width,
+						_(prio_names[from_tag]),
+						distance, name_width,
+						data->revs->objects[i].name,
+						tip_name, generation);
+		}
 		name->tip_name = tip_name;
 		name->taggerdate = taggerdate;
 		name->generation = generation;
@@ -112,11 +156,11 @@ static void name_rev(struct commit *commit,
 
 			name_rev(parents->item, new_name, taggerdate, 0,
 				 distance + MERGE_TRAVERSAL_WEIGHT,
-				 from_tag, 0);
+				 from_tag, 0, data);
 		} else {
 			name_rev(parents->item, tip_name, taggerdate,
 				 generation + 1, distance + 1,
-				 from_tag, 0);
+				 from_tag, 0, data);
 		}
 	}
 }
@@ -146,13 +190,6 @@ static const char *name_ref_abbrev(const char *refname, int shorten_unambiguous)
 	return refname;
 }
 
-struct name_ref_data {
-	int tags_only;
-	int name_only;
-	struct string_list ref_filters;
-	struct string_list exclude_filters;
-};
-
 static struct tip_table {
 	struct tip_table_entry {
 		unsigned char sha1[20];
@@ -236,7 +273,6 @@ static int name_ref(const char *path, const struct object_id *oid, int flags, vo
 	}
 
 	add_to_tip_table(oid->hash, path, can_abbreviate_output);
-
 	while (o && o->type == OBJ_TAG) {
 		struct tag *t = (struct tag *) o;
 		if (!t->tagged)
@@ -253,7 +289,7 @@ static int name_ref(const char *path, const struct object_id *oid, int flags, vo
 			taggerdate = ((struct commit *)o)->date;
 		path = name_ref_abbrev(path, can_abbreviate_output);
 		name_rev(commit, xstrdup(path), taggerdate, 0, 0,
-			 from_tag, deref);
+			 from_tag, deref, data);
 	}
 	return 0;
 }
@@ -383,7 +419,7 @@ int cmd_name_rev(int argc, const char **argv, const char *prefix)
 {
 	struct object_array revs = OBJECT_ARRAY_INIT;
 	int all = 0, transform_stdin = 0, allow_undefined = 1, always = 0, peel_tag = 0;
-	struct name_ref_data data = { 0, 0, STRING_LIST_INIT_NODUP, STRING_LIST_INIT_NODUP };
+	struct name_ref_data data = { 0, 0, 0, STRING_LIST_INIT_NODUP, STRING_LIST_INIT_NODUP };
 	struct option opts[] = {
 		OPT_BOOL(0, "name-only", &data.name_only, N_("print only names (no SHA-1)")),
 		OPT_BOOL(0, "tags", &data.tags_only, N_("only use tags to name the commits")),
@@ -393,6 +429,7 @@ int cmd_name_rev(int argc, const char **argv, const char *prefix)
 				   N_("ignore refs matching <pattern>")),
 		OPT_GROUP(""),
 		OPT_BOOL(0, "all", &all, N_("list all commits reachable from all refs")),
+		OPT_BOOL(0, "debug", &data.debug, N_("debug search strategy on stderr")),
 		OPT_BOOL(0, "stdin", &transform_stdin, N_("read from stdin")),
 		OPT_BOOL(0, "undefined", &allow_undefined, N_("allow to print `undefined` names (default)")),
 		OPT_BOOL(0, "always",     &always,
@@ -458,6 +495,7 @@ int cmd_name_rev(int argc, const char **argv, const char *prefix)
 
 	if (cutoff)
 		cutoff = cutoff - CUTOFF_DATE_SLOP;
+	data.revs = &revs;
 	for_each_ref(name_ref, &data);
 
 	if (transform_stdin) {
-- 
2.12.2.712.gba4c48c431

