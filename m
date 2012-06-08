From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: [RFC] notes: attach help text to subcommands
Date: Fri,  8 Jun 2012 14:26:16 +0530
Message-ID: <1339145776-20495-1-git-send-email-artagnon@gmail.com>
References: <7vobowmjwr.fsf@alter.siamese.dyndns.org>
Cc: Junio C Hamano <gitster@pobox.com>,
	Jonathan Nieder <jrnieder@gmail.com>
To: Git List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri Jun 08 10:59:00 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Scv23-00014p-E1
	for gcvg-git-2@plane.gmane.org; Fri, 08 Jun 2012 10:58:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933995Ab2FHI6z (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 8 Jun 2012 04:58:55 -0400
Received: from mail-pz0-f46.google.com ([209.85.210.46]:33207 "EHLO
	mail-pz0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932177Ab2FHI6x (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 8 Jun 2012 04:58:53 -0400
Received: by dady13 with SMTP id y13so2070313dad.19
        for <git@vger.kernel.org>; Fri, 08 Jun 2012 01:58:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=jpSn1PYpb4+Nafq4YiWZNVYW62HfXNJmXMwdBh/mH+I=;
        b=R36TNp2PZbZKd84drFYqD/gI65M4TkF0dSye8xU89HRvVgU4yuy8rZmSXPNEx0U68i
         P40loeQ4XU7XU6Jypn5hKB92oj3iLMDNdBxrYu4SVWKfOtSnAFzZRd3tcOLbixrBmdoF
         XQamsTyiIHaSDTn8sUgDnHmna6dM8N55fpSrW0+tIFOV5rVY53HZbphNmUQjoDAY5N/v
         Wz9ggS8Ud92qwM9a3rYME87TV4IuBN7HSZyj17h0T9qtY2dKuewD3eOwtRU9K4ewXJCU
         2Vs9ZWjstHmobZmU33QIC0cpBqQRzRj1J+9IvxyvykBJbC+qkOd84b+enL/oXnm+C4dR
         Puvg==
Received: by 10.68.237.74 with SMTP id va10mr18631828pbc.46.1339145932960;
        Fri, 08 Jun 2012 01:58:52 -0700 (PDT)
Received: from localhost.localdomain ([122.174.108.158])
        by mx.google.com with ESMTPS id np8sm7154969pbc.71.2012.06.08.01.58.49
        (version=TLSv1/SSLv3 cipher=OTHER);
        Fri, 08 Jun 2012 01:58:51 -0700 (PDT)
X-Mailer: git-send-email 1.7.10
In-Reply-To: <7vobowmjwr.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/199472>

Subcommands now have descriptive help text attached to them so that
the following error message:

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

Signed-off-by: Ramkumar Ramachandra <artagnon@gmail.com>
---
 I coerced my patch to use the string_list API, and this is the
 result.  It looks terribly ugly, and I have no idea how to proceed.

 Thoughts/ suggestions?

 builtin/notes.c |  119 ++++++++++++++++++++++++++++++++++++++-----------------
 1 file changed, 82 insertions(+), 37 deletions(-)

diff --git a/builtin/notes.c b/builtin/notes.c
index 3644d14..d5fcf45 100644
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
 
@@ -1059,15 +1048,75 @@ static int get_ref(int argc, const char **argv, const char *prefix)
 	return 0;
 }
 
+
+#define USAGE_OPTS_WIDTH 24
+#define USAGE_GAP         2
+
+typedef int subcmd_cb(int argc, const char **argv, const char *prefix);
+
+struct subcommand {
+	const char *help;
+	subcmd_cb *callback;
+};
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
 	const char *override_notes_ref = NULL;
+	struct string_list subcmds = STRING_LIST_INIT_NODUP;
+	struct string_list_item *item;
 	struct option options[] = {
 		OPT_STRING(0, "ref", &override_notes_ref, "notes_ref",
 			   "use notes from <notes_ref>"),
 		OPT_END()
 	};
+	struct subcommand util[] = {
+		{ "list notes for given object", list },
+		{ "add notes for given object", add },
+		{ "copy notes for first object onto second object", copy },
+		{ "append notes to existing object", append_edit },
+		{ "edit notes for given object", append_edit },
+		{ "show notes for given object", show },
+		{ "merge given notes ref into current notes ref", merge },
+		{ "remove notes for given objects", remove_cmd },
+		{ "remove all notes for non-existing/unreachable objects", prune },
+		{ "print the current notes ref", get_ref }
+	};
 
 	git_config(git_default_config, NULL);
 	argc = parse_options(argc, argv, prefix, options, git_notes_usage,
@@ -1081,28 +1130,24 @@ int cmd_notes(int argc, const char **argv, const char *prefix)
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
-
-	return result ? 1 : 0;
+	string_list_insert(&subcmds, "list")->util = &util[0];
+	string_list_insert(&subcmds, "add")->util = &util[1];
+	string_list_insert(&subcmds, "copy")->util = &util[2];
+	string_list_insert(&subcmds, "append")->util = &util[3];
+	string_list_insert(&subcmds, "edit")->util = &util[4];
+	string_list_insert(&subcmds, "show")->util = &util[5];
+	string_list_insert(&subcmds, "merge")->util = &util[6];
+	string_list_insert(&subcmds, "remove")->util = &util[7];
+	string_list_insert(&subcmds, "prune")->util = &util[8];
+	string_list_insert(&subcmds, "get-ref")->util = &util[9];
+
+	if (argc < 1)
+		return list(argc, argv, prefix) ? 1 : 0;
+
+	item = unsorted_string_list_lookup(&subcmds, argv[0]);
+	if (item)
+		return ((struct subcommand *)(item->util))->callback(argc, argv, prefix) ? 1 : 0;
+	error("unknown subcommand: %s", argv[0]);
+	subcommand_usage(git_notes_usage, &subcmds);
+	exit(129);
 }
-- 
1.7.10
