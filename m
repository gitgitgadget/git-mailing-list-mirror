From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: [PATCH] Add git-name-rev
Date: Wed, 26 Oct 2005 01:05:59 +0200 (CEST)
Message-ID: <Pine.LNX.4.63.0510260103570.27364@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-From: git-owner@vger.kernel.org Wed Oct 26 01:07:26 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EUXrq-0006t6-Tk
	for gcvg-git@gmane.org; Wed, 26 Oct 2005 01:06:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932467AbVJYXGD (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 25 Oct 2005 19:06:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932468AbVJYXGD
	(ORCPT <rfc822;git-outgoing>); Tue, 25 Oct 2005 19:06:03 -0400
Received: from wrzx28.rz.uni-wuerzburg.de ([132.187.3.28]:913 "EHLO
	wrzx28.rz.uni-wuerzburg.de") by vger.kernel.org with ESMTP
	id S932467AbVJYXGB (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 25 Oct 2005 19:06:01 -0400
Received: from wrzx30.rz.uni-wuerzburg.de (wrzx30.rz.uni-wuerzburg.de [132.187.1.30])
	by wrzx28.rz.uni-wuerzburg.de (Postfix) with ESMTP
	id F06E913EFF3; Wed, 26 Oct 2005 01:05:59 +0200 (CEST)
Received: from virusscan (localhost [127.0.0.1])
	by wrzx30.rz.uni-wuerzburg.de (Postfix) with ESMTP
	id D055A9ABA5; Wed, 26 Oct 2005 01:05:59 +0200 (CEST)
Received: from wrzx28.rz.uni-wuerzburg.de (wrzx28.rz.uni-wuerzburg.de [132.187.3.28])
	by wrzx30.rz.uni-wuerzburg.de (Postfix) with ESMTP
	id 85D689AAB0; Wed, 26 Oct 2005 01:05:59 +0200 (CEST)
Received: from dumbo2 (wbgn013.biozentrum.uni-wuerzburg.de [132.187.25.13])
	by wrzx28.rz.uni-wuerzburg.de (Postfix) with ESMTP
	id 2F54113EFF3; Wed, 26 Oct 2005 01:05:59 +0200 (CEST)
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
To: git@vger.kernel.org, junkio@cox.net
X-Virus-Scanned: by amavisd-new (Rechenzentrum Universitaet Wuerzburg)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/10628>

git-name-rev tries to find nice symbolic names for commits. It does so by 
walking the commits from the refs. When the symbolic name is ambiguous, 
the following heuristic is applied: Try to avoid too many ~'s, and if two 
ambiguous names have the same count of ~'s, take the one whose last number 
is smaller.

Signed-off-by: Johannes Schindelin <Johannes.Schindelin@gmx.de>

---

	This is a toy which may help you, too. In case it is still not 
	clear what it does:

	$ git-name-rev 33db5f4d9027a10e477ccf054b2c1ab94f74c85a

	33db5f4d9027a10e477ccf054b2c1ab94f74c85a v0.99^0~940

	A thing like this is very useful for debugging git-fetch-pack: If 
	you see that a certain rev is common, you can now understand in 
	more detail where this rev is.

 .gitignore                     |    1 
 Documentation/git-name-rev.txt |   47 ++++++++++++
 Makefile                       |    2 
 name-rev.c                     |  162 ++++++++++++++++++++++++++++++++++++++++
 4 files changed, 211 insertions(+), 1 deletions(-)
 create mode 100644 Documentation/git-name-rev.txt
 create mode 100644 name-rev.c

applies-to: 2152f0960114f638d74c4919a850dd597963ac52
bc2caae16f461e3b496d27e3f038cbb6d141706c
diff --git a/.gitignore b/.gitignore
index 52cb9e2..fe16651 100644
--- a/.gitignore
+++ b/.gitignore
@@ -54,6 +54,7 @@ git-merge-recursive
 git-merge-resolve
 git-merge-stupid
 git-mktag
+git-name-rev
 git-octopus
 git-pack-objects
 git-parse-remote
diff --git a/Documentation/git-name-rev.txt b/Documentation/git-name-rev.txt
new file mode 100644
index 0000000..6a7bb07
--- /dev/null
+++ b/Documentation/git-name-rev.txt
@@ -0,0 +1,47 @@
+git-name-rev(1)
+===============
+
+NAME
+----
+git-name-rev - Find symbolic names for given revs.
+
+
+SYNOPSIS
+--------
+'git-name-rev' <commitish>...
+
+DESCRIPTION
+-----------
+Finds symbolic names suitable for human digestion for revisions given in any
+format parsable by git-rev-parse.
+
+
+EXAMPLE
+-------
+
+Given a commit, find out where it is relative to the local refs. Say somebody
+wrote you about that phantastic commit 33db5f4d9027a10e477ccf054b2c1ab94f74c85a.
+Of course, you look into the commit, but that only tells you what happened, but
+not the context.
+
+Enter git-name-rev:
+
+------------
+% git name-rev 33db5f4d9027a10e477ccf054b2c1ab94f74c85a
+------------
+
+Now you are wiser, because you know that it happened 940 revisions before v0.99.
+
+
+Author
+------
+Written by Johannes Schindelin <Johannes.Schindelin@gmx.de>
+
+Documentation
+--------------
+Documentation by Johannes Schindelin.
+
+GIT
+---
+Part of the gitlink:git[7] suite
+
diff --git a/Makefile b/Makefile
index d6fd706..4877abb 100644
--- a/Makefile
+++ b/Makefile
@@ -122,7 +122,7 @@ PROGRAMS = \
 	git-unpack-objects$X git-update-index$X git-update-server-info$X \
 	git-upload-pack$X git-verify-pack$X git-write-tree$X \
 	git-update-ref$X git-symbolic-ref$X git-check-ref-format$X \
-	$(SIMPLE_PROGRAMS)
+	git-name-rev$X $(SIMPLE_PROGRAMS)
 
 # Backward compatibility -- to be removed after 1.0
 PROGRAMS += git-ssh-pull$X git-ssh-push$X
diff --git a/name-rev.c b/name-rev.c
new file mode 100644
index 0000000..a3a095e
--- /dev/null
+++ b/name-rev.c
@@ -0,0 +1,162 @@
+#include <stdlib.h>
+#include "cache.h"
+#include "commit.h"
+#include "tag.h"
+#include "refs.h"
+
+static const char name_rev_usage[] =
+	"git-name-rev commitish [commitish...]\n";
+
+typedef struct rev_name {
+	const char *tip_name;
+	int merge_traversals;
+	int generation;
+} rev_name;
+
+static long cutoff = LONG_MAX;
+
+static void name_rev(struct commit *commit,
+		const char *tip_name, int merge_traversals, int generation,
+		int deref)
+{
+	struct rev_name *name = (struct rev_name *)commit->object.util;
+	struct commit_list *parents;
+	int parent_number = 0;
+
+	if (!commit->object.parsed)
+		parse_commit(commit);
+
+	if (commit->date < cutoff)
+		return;
+
+	if (deref) {
+		char *new_name = xmalloc(strlen(tip_name)+3);
+		strcpy(new_name, tip_name);
+		strcat(new_name, "^0");
+		tip_name = new_name;
+
+		if (generation)
+			die("generation: %d, but deref?", generation);
+	}
+
+	if (name == NULL) {
+		name = xmalloc(sizeof(rev_name));
+		commit->object.util = name;
+		goto copy_data;
+	} else if (name->merge_traversals > merge_traversals ||
+			(name->merge_traversals == merge_traversals &&
+			 name->generation > generation)) {
+copy_data:
+		name->tip_name = tip_name;
+		name->merge_traversals = merge_traversals;
+		name->generation = generation;
+	} else
+		return;
+
+	for (parents = commit->parents;
+			parents;
+			parents = parents->next, parent_number++) {
+		if (parent_number > 0) {
+			char *new_name = xmalloc(strlen(tip_name)+8);
+
+			if (generation > 0)
+				sprintf(new_name, "%s~%d^%d", tip_name,
+						generation, parent_number);
+			else
+				sprintf(new_name, "%s^%d", tip_name, parent_number);
+
+			name_rev(parents->item, new_name,
+				merge_traversals + 1 , 0, 0);
+		} else {
+			name_rev(parents->item, tip_name, merge_traversals,
+				generation + 1, 0);
+		}
+	}
+}
+
+static int name_ref(const char *path, const unsigned char *sha1)
+{
+	struct object *o = parse_object(sha1);
+	int deref = 0;
+
+	while (o && o->type == tag_type) {
+		struct tag *t = (struct tag *) o;
+		if (!t->tagged)
+			break; /* broken repository */
+		o = parse_object(t->tagged->sha1);
+		deref = 1;
+	}
+	if (o && o->type == commit_type) {
+		struct commit *commit = (struct commit *)o;
+		const char *p;
+
+		while ((p = strchr(path, '/')))
+			path = p+1;
+
+		name_rev(commit, strdup(path), 0, 0, deref);
+	}
+	return 0;
+}
+
+int main(int argc, char **argv)
+{
+	struct object_list *revs = NULL;
+	struct object_list **walker = &revs;
+	int as_is = 0;
+
+	setup_git_directory();
+
+	if (argc < 2)
+		usage(name_rev_usage);
+
+	for (--argc, ++argv; argc; --argc, ++argv) {
+		unsigned char sha1[20];
+		struct object *o;
+		struct commit *commit;
+
+		if (!as_is && (*argv)[0] == '-') {
+			if (!strcmp(*argv, "--")) {
+				as_is = 1;
+				continue;
+			}
+
+			usage(name_rev_usage);
+		}
+
+		if (get_sha1(*argv, sha1)) {
+			fprintf(stderr, "Could not get sha1 for %s. Skipping.\n",
+					*argv);
+			continue;
+		}
+
+		o = deref_tag(parse_object(sha1));
+		if (!o || o->type != commit_type) {
+			fprintf(stderr, "Could not get commit for %s. Skipping.\n",
+					*argv);
+			continue;
+		}
+
+		commit = (struct commit *)o;
+
+		if (cutoff > commit->date)
+			cutoff = commit->date;
+
+		object_list_append((struct object *)commit, walker);
+		(*walker)->name = *argv;
+		walker = &((*walker)->next);
+	}
+
+	for_each_ref(name_ref);
+
+	for ( ; revs; revs = revs->next) {
+		struct rev_name *n = (struct rev_name *)revs->item->util;
+
+		printf("%s %s", revs->name, n->tip_name);
+		if (n->generation)
+			printf("~%d", n->generation);
+		printf("\n");
+	}
+
+	return 0;
+}
+
---
0.99.8.GIT
