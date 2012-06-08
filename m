From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: [PATCH] notes: attach help text to subcommands
Date: Fri,  8 Jun 2012 20:58:37 +0530
Message-ID: <1339169317-12134-1-git-send-email-artagnon@gmail.com>
References: <7vd359eu4s.fsf@alter.siamese.dyndns.org>
Cc: Git List <git@vger.kernel.org>,
	Jonathan Nieder <jrnieder@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Jun 08 17:31:23 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Sd19k-0006lm-Li
	for gcvg-git-2@plane.gmane.org; Fri, 08 Jun 2012 17:31:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757036Ab2FHPbQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 8 Jun 2012 11:31:16 -0400
Received: from mail-pz0-f46.google.com ([209.85.210.46]:55625 "EHLO
	mail-pz0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754204Ab2FHPbP (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 8 Jun 2012 11:31:15 -0400
Received: by dady13 with SMTP id y13so2494460dad.19
        for <git@vger.kernel.org>; Fri, 08 Jun 2012 08:31:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=ev3XHs2aGQGS2cqFaNtUWZBQt3BIuguV2IJMoQAFJzk=;
        b=LNevzDA1qDOZtBeIBKdLEO8WINr72hTFJit9x332yVKDID58Lg5QOuRZ21D/dktRlI
         jBuSWVHbRC/q3xOQudavPIYdm9R4Gu/SmgtEpotvR17SiDdfi0fXzHX68EO6BMjpFKol
         E1VV2+i0oVtCEAJ2ABuWs/g1Jo7B5aTGH90FD2zAVCHT5BDhkx2mpnUZDucMhrRHPiKF
         UMa6nLkU1XDX0Ky1tmjUC5Wn3wlCGWSFzjTaQHf1gMQCWSkeaUJse0zt+GPA8hiKbN++
         OTogfCgRkF0C8e44gO9zCUh8wnLF5VfpbHUzS2Wi1/BAR8Ekgwb6rbgjT9YhAgeGif+p
         u2Ig==
Received: by 10.68.222.163 with SMTP id qn3mr20933251pbc.135.1339169474431;
        Fri, 08 Jun 2012 08:31:14 -0700 (PDT)
Received: from localhost.localdomain ([122.174.108.158])
        by mx.google.com with ESMTPS id ph1sm8161866pbb.45.2012.06.08.08.31.09
        (version=TLSv1/SSLv3 cipher=OTHER);
        Fri, 08 Jun 2012 08:31:11 -0700 (PDT)
X-Mailer: git-send-email 1.7.10
In-Reply-To: <7vd359eu4s.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/199504>

Attach descriptive help text to subcommands of 'git notes' so that the
following error message:

  $ git notes foo
  error: Unknown subcommand: foo
  usage: git notes [--ref <notes_ref>] [list [<object>]]
     or: git notes [--ref <notes_ref>] add [-f] [-m <msg> | -F <file> | (-c | -C) <object>] [<object>]
     or: git notes [--ref <notes_ref>] copy [-f] <from-object> <to-object>
     or: git notes [--ref <notes_ref>] append [-m <msg> | -F <file> | (-c | -C) <object>] [<object>]
     or: git notes [--ref <notes_ref>] edit [<object>]
     or: git notes [--ref <notes_ref>] show [<object>]
     or: git notes [--ref <notes_ref>] merge [-v | -q] [-s <strategy> ] <notes_ref>
     or: git notes merge --commit [-v | -q]
     or: git notes merge --abort [-v | -q]
     or: git notes [--ref <notes_ref>] remove [<object>...]
     or: git notes [--ref <notes_ref>] prune [-n | -v]
     or: git notes [--ref <notes_ref>] get-ref

    --ref <notes_ref>     use notes from <notes_ref>

is replaced by a more helpful:

  $ git notes foo
  error: unknown subcommand: foo
  usage: git notes [<options>] [<subcommand>] [<options>] [<object>..]

  available subcommands:
      list                  list notes for given object
      add                   add notes for given object
      copy                  copy notes for first object onto second object
      append                append notes to existing object
      edit                  edit notes for given object
      show                  show notes for given object
      merge                 merge given notes ref into current notes ref
      remove                remove notes for given objects
      prune                 remove all notes for non-existing/unreachable objects
      get-ref               print the current notes ref

Helped-by: Junio C Hamano <gitster@pobox.com>
Signed-off-by: Ramkumar Ramachandra <artagnon@gmail.com>
---
 Junio C Hamano wrote:
 > If you make "struct subcommand" to contain entry's own name, you
 > could simply do this, no?
 >
 >        for (i = 0; i < ARRAY_SIZE(util); i++)
 >                string_list_insert(&subcmds, util[i].name)->util = &util[i];
 >
 > Perhaps append all and then sort once at the end?
 
 Thanks.  I wish we could do something aout USAGE_OPTS_WIDTH and
 USAGE_GAP; I stole them from parse-options.c.  Plus, `struct
 subcommand` and `subcommand_usage` need a new home if they're going
 to be used by more builtins with subcommands.
 
 Thoughts?

 builtin/notes.c |  112 +++++++++++++++++++++++++++++++++++++------------------
 1 file changed, 76 insertions(+), 36 deletions(-)

diff --git a/builtin/notes.c b/builtin/notes.c
index 3644d14..223f990 100644
--- a/builtin/notes.c
+++ b/builtin/notes.c
@@ -20,18 +20,7 @@
 #include "notes-merge.h"
 
 static const char * const git_notes_usage[] = {
-	"git notes [--ref <notes_ref>] [list [<object>]]",
-	"git notes [--ref <notes_ref>] add [-f] [-m <msg> | -F <file> | (-c | -C) <object>] [<object>]",
-	"git notes [--ref <notes_ref>] copy [-f] <from-object> <to-object>",
-	"git notes [--ref <notes_ref>] append [-m <msg> | -F <file> | (-c | -C) <object>] [<object>]",
-	"git notes [--ref <notes_ref>] edit [<object>]",
-	"git notes [--ref <notes_ref>] show [<object>]",
-	"git notes [--ref <notes_ref>] merge [-v | -q] [-s <strategy> ] <notes_ref>",
-	"git notes merge --commit [-v | -q]",
-	"git notes merge --abort [-v | -q]",
-	"git notes [--ref <notes_ref>] remove [<object>...]",
-	"git notes [--ref <notes_ref>] prune [-n | -v]",
-	"git notes [--ref <notes_ref>] get-ref",
+	"git notes [<options>] [<subcommand>] [<options>] [<object>..]",
 	NULL
 };
 
@@ -1059,15 +1048,76 @@ static int get_ref(int argc, const char **argv, const char *prefix)
 	return 0;
 }
 
+
+struct subcommand {
+	const char *name;
+	const char *help;
+	int (*callback)(int, const char **, const char *);
+};
+
+#define USAGE_OPTS_WIDTH 24
+#define USAGE_GAP         2
+
+static void subcommand_usage(const char * const *usagestr,
+			struct string_list *subcmds)
+{
+	int i;
+
+	fprintf(stderr, "usage: %s\n", *usagestr++);
+	while (*usagestr && **usagestr)
+		fprintf(stderr, "   or: %s\n", *usagestr++);
+	while (*usagestr) {
+		fprintf(stderr, "%s%s\n",
+				**usagestr ? "    " : "",
+				*usagestr);
+		usagestr++;
+	}
+
+	fputc('\n', stderr);
+	fprintf(stderr, "available subcommands:\n");
+	for (i = 0; i < subcmds->nr; i++) {
+		size_t pos;
+		int pad;
+
+		pos = fprintf(stderr, "    ");
+		pos += fprintf(stderr, "%s", subcmds->items[i].string);
+
+		if (pos <= USAGE_OPTS_WIDTH)
+			pad = USAGE_OPTS_WIDTH - pos;
+		else {
+			fputc('\n', stderr);
+			pad = USAGE_OPTS_WIDTH;
+		}
+		fprintf(stderr, "%*s%s\n", pad + USAGE_GAP, "",
+			((struct subcommand *)(subcmds->items[i].util))->help);
+	}
+	fputc('\n', stderr);
+}
+
 int cmd_notes(int argc, const char **argv, const char *prefix)
 {
-	int result;
+	int i;
 	const char *override_notes_ref = NULL;
+	struct string_list subcmds = STRING_LIST_INIT_NODUP;
+	struct string_list_item *item;
 	struct option options[] = {
 		OPT_STRING(0, "ref", &override_notes_ref, "notes_ref",
 			   "use notes from <notes_ref>"),
 		OPT_END()
 	};
+	struct subcommand util[] = {
+		{ "list", "list notes for given object", list },
+		{ "add", "add notes for given object", add },
+		{ "copy", "copy notes for first object onto second object", copy },
+		{ "append", "append notes to existing object", append_edit },
+		{ "edit", "edit notes for given object", append_edit },
+		{ "show", "show notes for given object", show },
+		{ "merge", "merge given notes ref into current notes ref", merge },
+		{ "remove", "remove notes for given objects", remove_cmd },
+		{ "prune",
+		  "remove all notes for non-existing/unreachable objects", prune },
+		{ "get-ref", "print the current notes ref", get_ref }
+	};
 
 	git_config(git_default_config, NULL);
 	argc = parse_options(argc, argv, prefix, options, git_notes_usage,
@@ -1081,28 +1131,18 @@ int cmd_notes(int argc, const char **argv, const char *prefix)
 		strbuf_release(&sb);
 	}
 
-	if (argc < 1 || !strcmp(argv[0], "list"))
-		result = list(argc, argv, prefix);
-	else if (!strcmp(argv[0], "add"))
-		result = add(argc, argv, prefix);
-	else if (!strcmp(argv[0], "copy"))
-		result = copy(argc, argv, prefix);
-	else if (!strcmp(argv[0], "append") || !strcmp(argv[0], "edit"))
-		result = append_edit(argc, argv, prefix);
-	else if (!strcmp(argv[0], "show"))
-		result = show(argc, argv, prefix);
-	else if (!strcmp(argv[0], "merge"))
-		result = merge(argc, argv, prefix);
-	else if (!strcmp(argv[0], "remove"))
-		result = remove_cmd(argc, argv, prefix);
-	else if (!strcmp(argv[0], "prune"))
-		result = prune(argc, argv, prefix);
-	else if (!strcmp(argv[0], "get-ref"))
-		result = get_ref(argc, argv, prefix);
-	else {
-		result = error(_("Unknown subcommand: %s"), argv[0]);
-		usage_with_options(git_notes_usage, options);
-	}
+	for (i = 0; i < ARRAY_SIZE(util); i++)
+		string_list_insert(&subcmds, util[i].name)->util = &util[i];
+	sort_string_list(&subcmds);
+
+	if (argc < 1)
+		return list(argc, argv, prefix) ? 1 : 0;
+
+	item = string_list_lookup(&subcmds, argv[0]);
+	if (item)
+		return ((struct subcommand *)(item->util))->callback(argc, argv, prefix) ? 1 : 0;
 
-	return result ? 1 : 0;
+	error("unknown subcommand: %s", argv[0]);
+	subcommand_usage(git_notes_usage, &subcmds);
+	exit(129);
 }
-- 
1.7.10
