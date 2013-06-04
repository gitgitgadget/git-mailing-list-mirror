From: elliottcable <me@ell.io>
Subject: [PATCH/RFC] rev-list: add --authorship-order alternative ordering
Date: Tue,  4 Jun 2013 14:08:18 -0400
Message-ID: <1370369299-20744-2-git-send-email-me@ell.io>
References: <1370369299-20744-1-git-send-email-me@ell.io>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: elliottcable <me@ell.io>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jun 04 20:10:57 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UjvhA-0008RF-Lr
	for gcvg-git-2@plane.gmane.org; Tue, 04 Jun 2013 20:10:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750957Ab3FDSKx convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 4 Jun 2013 14:10:53 -0400
Received: from mail-vc0-f170.google.com ([209.85.220.170]:54302 "EHLO
	mail-vc0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750821Ab3FDSKv (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 4 Jun 2013 14:10:51 -0400
Received: by mail-vc0-f170.google.com with SMTP id hf12so444561vcb.1
        for <git@vger.kernel.org>; Tue, 04 Jun 2013 11:10:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ell.io; s=google;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=C103jsWY03BhmkvfN2T4f0861h5iwQ0sOkf0gVRwOKM=;
        b=AOrxRqbe8lrYYxkqcnUgfJQHcnDRiyjPiaH9W8wfueTQ5eCdiJHZKCxTKE5DGss+L5
         0axjpNgV3imKdnkugAC3MC/sQWmqXlyhSvXfdM1bGaqurPNNgIpRg65UmCfe+mbknSBz
         9BltY6PhwKs8pxmX3KA5+Cl5q4Zcsr5fscYBE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding
         :x-gm-message-state;
        bh=C103jsWY03BhmkvfN2T4f0861h5iwQ0sOkf0gVRwOKM=;
        b=kpmE/dxxiN/e3N0+13RB3lHq3zElqmw/eeuAJ/z/fTaWu0EiD+WTiHmXC58Lsjkpcf
         9lv1wHULBw29jXRekuc9XDVdx9gElKy2vKHXFYumMxwjI1vDx92K96QqWv1Mta9TcvaV
         wGPK4JUs4kPskcpJFtSTglzCW9Al90K441Exab34BUzsf9+LqNZuBKyXxCNeZCLjcwvc
         8jfirmfFvrtD8d+OeOa5Gcsa+SZXWVuRWZG1aR76CO0iHPAHfFtBpfksY/OCILbb9+iw
         D6X6ZbrBL/eFdGZQHgqHlvYELo2LiFJUfimDrT7ac3zLWx4rGBdeftXkjCO4e9NY95cX
         eK7A==
X-Received: by 10.52.121.72 with SMTP id li8mr16206085vdb.22.1370369450349;
        Tue, 04 Jun 2013 11:10:50 -0700 (PDT)
Received: from Sanford.local.com (cpe-174-106-131-094.ec.res.rr.com. [174.106.131.94])
        by mx.google.com with ESMTPSA id u6sm45730121ven.3.2013.06.04.11.10.48
        for <multiple recipients>
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Tue, 04 Jun 2013 11:10:49 -0700 (PDT)
X-Mailer: git-send-email 1.8.1.3
In-Reply-To: <1370369299-20744-1-git-send-email-me@ell.io>
X-Gm-Message-State: ALoCoQmbmZOopkStygqUn01/tazDLp69+/WbeCA6Vjj6LNt6UIVdWF5padmCDrueQTEEF/nSW0wU
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/226388>

--date-order is an excellent alternative to --topo-order if you want a =
feel for
the *actual history*, chronologically, of your project. I use it often,=
 with
--graph as well; it's a great way to get an overview of a project's rec=
ent
development history.

However, in a project that rebases various in-development topic-branche=
s often,
it gets hard to demonstrate a *chronological history* of changes to the
codebase, as this always =E2=80=9Cresets=E2=80=9D the COMMITTER_DATE (w=
hich --date-order uses)
to the time the rebase happened; which often means =E2=80=98last time a=
ll of the
topic-branches were rebased on the latest fixes in master.=E2=80=99

Thus, I've added an --authorship-order version of --date-order, which r=
elies
upon the AUTHOR_DATE instead of the COMMITTER_DATE; this means that old=
 commits
will continue to show up chronologically in-order despite rebasing.
---
 builtin/log.c                          |  2 +-
 builtin/rev-list.c                     |  1 +
 builtin/rev-parse.c                    |  1 +
 builtin/show-branch.c                  | 12 ++++-
 commit.c                               | 83 ++++++++++++++++++++++++++=
++++----
 commit.h                               |  3 +-
 contrib/completion/git-completion.bash |  4 +-
 po/de.po                               |  4 +-
 po/git.pot                             |  2 +-
 po/sv.po                               |  4 +-
 po/vi.po                               |  4 +-
 po/zh_CN.po                            |  4 +-
 revision.c                             | 11 ++++-
 revision.h                             |  1 +
 14 files changed, 110 insertions(+), 26 deletions(-)

diff --git a/builtin/log.c b/builtin/log.c
index 9e21232..54d4d7f 100644
--- a/builtin/log.c
+++ b/builtin/log.c
@@ -237,7 +237,7 @@ static void log_show_early(struct rev_info *revs, s=
truct commit_list *list)
 	int i =3D revs->early_output;
 	int show_header =3D 1;
=20
-	sort_in_topological_order(&list, revs->lifo);
+	sort_in_topological_order(&list, revs->lifo, revs->use_author);
 	while (list && i) {
 		struct commit *commit =3D list->item;
 		switch (simplify_commit(revs, commit)) {
diff --git a/builtin/rev-list.c b/builtin/rev-list.c
index 67701be..cfa5d1f 100644
--- a/builtin/rev-list.c
+++ b/builtin/rev-list.c
@@ -30,6 +30,7 @@ static const char rev_list_usage[] =3D
 "  ordering output:\n"
 "    --topo-order\n"
 "    --date-order\n"
+"    --authorship-order\n"
 "    --reverse\n"
 "  formatting output:\n"
 "    --parents\n"
diff --git a/builtin/rev-parse.c b/builtin/rev-parse.c
index f267a1d..d08aebd 100644
--- a/builtin/rev-parse.c
+++ b/builtin/rev-parse.c
@@ -65,6 +65,7 @@ static int is_rev_argument(const char *arg)
 		"--tags",
 		"--topo-order",
 		"--date-order",
+		"--authorship-order",
 		"--unpacked",
 		NULL
 	};
diff --git a/builtin/show-branch.c b/builtin/show-branch.c
index 90fc6b1..ac06ac3 100644
--- a/builtin/show-branch.c
+++ b/builtin/show-branch.c
@@ -6,7 +6,7 @@
 #include "parse-options.h"
=20
 static const char* show_branch_usage[] =3D {
-    N_("git show-branch [-a|--all] [-r|--remotes] [--topo-order | --da=
te-order] [--current] [--color[=3D<when>] | --no-color] [--sparse] [--m=
ore=3D<n> | --list | --independent | --merge-base] [--no-name | --sha1-=
name] [--topics] [(<rev> | <glob>)...]"),
+    N_("git show-branch [-a|--all] [-r|--remotes] [--topo-order | --da=
te-order | --authorship-order] [--current] [--color[=3D<when>] | --no-c=
olor] [--sparse] [--more=3D<n> | --list | --independent | --merge-base]=
 [--no-name | --sha1-name] [--topics] [(<rev> | <glob>)...]"),
     N_("git show-branch (-g|--reflog)[=3D<n>[,<base>]] [--list] [<ref>=
]"),
     NULL
 };
@@ -631,6 +631,7 @@ int cmd_show_branch(int ac, const char **av, const =
char *prefix)
 	int all_heads =3D 0, all_remotes =3D 0;
 	int all_mask, all_revs;
 	int lifo =3D 1;
+	int use_author =3D 0;
 	char head[128];
 	const char *head_p;
 	int head_len;
@@ -667,6 +668,8 @@ int cmd_show_branch(int ac, const char **av, const =
char *prefix)
 			    N_("show refs unreachable from any other ref")),
 		OPT_BOOLEAN(0, "topo-order", &lifo,
 			    N_("show commits in topological order")),
+		OPT_BOOLEAN(0, "authorship-order", &use_author,
+			    N_("like --date-order, but with the *author* date")),
 		OPT_BOOLEAN(0, "topics", &topics,
 			    N_("show only commits not on the first branch")),
 		OPT_SET_INT(0, "sparse", &dense,
@@ -694,6 +697,11 @@ int cmd_show_branch(int ac, const char **av, const=
 char *prefix)
 			   show_branch_usage, PARSE_OPT_STOP_AT_NON_OPTION);
 	if (all_heads)
 		all_remotes =3D 1;
+	/* I'm having trouble figuring out exactly what `lifo` stores. Why do=
 both 'date-order' and
+	 * 'topo-order' set the same variable!? Aren't they mutually exclusiv=
e? Since *both* set it, for
+	 * the moment, I'm going to set it for '--authorship-order'; but that=
 seems counterintuitive. */
+	if (use_author)
+		lifo =3D 1;
=20
 	if (extra || reflog) {
 		/* "listing" mode is incompatible with
@@ -900,7 +908,7 @@ int cmd_show_branch(int ac, const char **av, const =
char *prefix)
 		exit(0);
=20
 	/* Sort topologically */
-	sort_in_topological_order(&seen, lifo);
+	sort_in_topological_order(&seen, lifo, use_author);
=20
 	/* Give names to commits */
 	if (!sha1_name && !no_name)
diff --git a/commit.c b/commit.c
index 888e02a..b8a0f60 100644
--- a/commit.c
+++ b/commit.c
@@ -78,7 +78,34 @@ struct commit *lookup_commit_reference_by_name(const=
 char *name)
 	return commit;
 }
=20
-static unsigned long parse_commit_date(const char *buf, const char *ta=
il)
+static unsigned long parse_commit_author_date(const char *buf, const c=
har *tail)
+{
+	const char *dateptr;
+
+	if (buf + 6 >=3D tail)
+		return 0;
+	if (memcmp(buf, "author", 6))
+		return 0;
+	while (buf < tail && *buf++ !=3D '>')
+		/* nada */;
+	if (buf >=3D tail)
+		return 0;
+	dateptr =3D buf;
+	while (buf < tail && *buf++ !=3D '\n')
+		/* nada */;
+	if (buf + 9 >=3D tail)
+		return 0;
+	if (memcmp(buf, "committer", 9))
+		return 0;
+	while (buf < tail && *buf++ !=3D '\n')
+		/* nada */;
+	if (buf >=3D tail)
+		return 0;
+	/* dateptr < buf && buf[-1] =3D=3D '\n', so strtoul will stop at buf-=
1 */
+	return strtoul(dateptr, NULL, 10);
+}
+
+static unsigned long parse_commit_committer_date(const char *buf, cons=
t char *tail)
 {
 	const char *dateptr;
=20
@@ -301,7 +328,8 @@ int parse_commit_buffer(struct commit *item, const =
void *buffer, unsigned long s
 			pptr =3D &commit_list_insert(new_parent, pptr)->next;
 		}
 	}
-	item->date =3D parse_commit_date(bufptr, tail);
+	item->date =3D parse_commit_committer_date(bufptr, tail);
+	item->author_date =3D parse_commit_author_date(bufptr, tail);
=20
 	return 0;
 }
@@ -380,6 +408,19 @@ void free_commit_list(struct commit_list *list)
 	}
 }
=20
+struct commit_list * commit_list_insert_by_author_date(struct commit *=
item, struct commit_list **list)
+{
+	struct commit_list **pp =3D list;
+	struct commit_list *p;
+	while ((p =3D *pp) !=3D NULL) {
+		if (p->item->author_date < item->author_date) {
+			break;
+		}
+		pp =3D &p->next;
+	}
+	return commit_list_insert(item, pp);
+}
+
 struct commit_list * commit_list_insert_by_date(struct commit *item, s=
truct commit_list **list)
 {
 	struct commit_list **pp =3D list;
@@ -393,6 +434,17 @@ struct commit_list * commit_list_insert_by_date(st=
ruct commit *item, struct comm
 	return commit_list_insert(item, pp);
 }
=20
+static int commit_list_compare_by_author_date(const void *a, const voi=
d *b)
+{
+	unsigned long a_date =3D ((const struct commit_list *)a)->item->autho=
r_date;
+	unsigned long b_date =3D ((const struct commit_list *)b)->item->autho=
r_date;
+	if (a_date < b_date)
+		return 1;
+	if (a_date > b_date)
+		return -1;
+	return 0;
+}
+
 static int commit_list_compare_by_date(const void *a, const void *b)
 {
 	unsigned long a_date =3D ((const struct commit_list *)a)->item->date;
@@ -414,6 +466,12 @@ static void commit_list_set_next(void *a, void *ne=
xt)
 	((struct commit_list *)a)->next =3D next;
 }
=20
+void commit_list_sort_by_author_date(struct commit_list **list)
+{
+	*list =3D llist_mergesort(*list, commit_list_get_next, commit_list_se=
t_next,
+				commit_list_compare_by_author_date);
+}
+
 void commit_list_sort_by_date(struct commit_list **list)
 {
 	*list =3D llist_mergesort(*list, commit_list_get_next, commit_list_se=
t_next,
@@ -509,7 +567,7 @@ struct commit *pop_commit(struct commit_list **stac=
k)
 /*
  * Performs an in-place topological sort on the list supplied.
  */
-void sort_in_topological_order(struct commit_list ** list, int lifo)
+void sort_in_topological_order(struct commit_list ** list, int lifo, i=
nt use_author)
 {
 	struct commit_list *next, *orig =3D *list;
 	struct commit_list *work, **insert;
@@ -554,8 +612,12 @@ void sort_in_topological_order(struct commit_list =
** list, int lifo)
 	}
=20
 	/* process the list in topological order */
-	if (!lifo)
-		commit_list_sort_by_date(&work);
+	if (!lifo) {
+		if (use_author)
+			commit_list_sort_by_author_date(&work);
+		else
+			commit_list_sort_by_date(&work);
+	}
=20
 	pptr =3D list;
 	*list =3D NULL;
@@ -580,10 +642,13 @@ void sort_in_topological_order(struct commit_list=
 ** list, int lifo)
 			 * guaranteeing topological order.
 			 */
 			if (--parent->indegree =3D=3D 1) {
-				if (!lifo)
-					commit_list_insert_by_date(parent, &work);
-				else
-					commit_list_insert(parent, &work);
+				if (!lifo) {
+					if (use_author)
+						commit_list_insert_by_author_date(parent, &work);
+					else
+						commit_list_insert_by_date(parent, &work);
+				} else {
+					commit_list_insert(parent, &work); }
 			}
 		}
 		/*
diff --git a/commit.h b/commit.h
index 67bd509..de07525 100644
--- a/commit.h
+++ b/commit.h
@@ -17,6 +17,7 @@ struct commit {
 	void *util;
 	unsigned int indegree;
 	unsigned long date;
+	unsigned long author_date;
 	struct commit_list *parents;
 	struct tree *tree;
 	char *buffer;
@@ -150,7 +151,7 @@ void clear_commit_marks_for_object_array(struct obj=
ect_array *a, unsigned mark);
  *   in addition, when lifo =3D=3D 0, commits on parallel tracks are
  *   sorted in the dates order.
  */
-void sort_in_topological_order(struct commit_list ** list, int lifo);
+void sort_in_topological_order(struct commit_list ** list, int lifo, i=
nt use_author);
=20
 struct commit_graft {
 	unsigned char sha1[20];
diff --git a/contrib/completion/git-completion.bash b/contrib/completio=
n/git-completion.bash
index 91234d4..f051e53 100644
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -1445,7 +1445,7 @@ _git_log ()
 			$__git_log_common_options
 			$__git_log_shortlog_options
 			$__git_log_gitk_options
-			--root --topo-order --date-order --reverse
+			--root --topo-order --date-order --authorship-order --reverse
 			--follow --full-diff
 			--abbrev-commit --abbrev=3D
 			--relative-date --date=3D
@@ -2291,7 +2291,7 @@ _git_show_branch ()
 	case "$cur" in
 	--*)
 		__gitcomp "
-			--all --remotes --topo-order --current --more=3D
+			--all --remotes --topo-order --authorship-order --current --more=3D
 			--list --independent --merge-base --no-name
 			--color --no-color
 			--sha1-name --sparse --topics --reflog
diff --git a/po/de.po b/po/de.po
index 4901488..0dc184f 100644
--- a/po/de.po
+++ b/po/de.po
@@ -8716,12 +8716,12 @@ msgstr "Ausgabe mit Zeilenumbr=C3=BCchen"
=20
 #: builtin/show-branch.c:9
 msgid ""
-"git show-branch [-a|--all] [-r|--remotes] [--topo-order | --date-orde=
r] [--"
+"git show-branch [-a|--all] [-r|--remotes] [--topo-order | --date-orde=
r | --authorship-order] [--"
 "current] [--color[=3D<when>] | --no-color] [--sparse] [--more=3D<n> |=
 --list | --"
 "independent | --merge-base] [--no-name | --sha1-name] [--topics] [(<r=
ev> | "
 "<glob>)...]"
 msgstr ""
-"git show-branch [-a|--all] [-r|--remotes] [--topo-order | --date-orde=
r] [--"
+"git show-branch [-a|--all] [-r|--remotes] [--topo-order | --date-orde=
r | --authorship-order] [--"
 "current] [--color[=3D<Wann>] | --no-color] [--sparse] [--more=3D<n> |=
 --list | --"
 "independent | --merge-base] [--no-name | --sha1-name] [--topics] "
 "[(<Revision> | <glob>)...]"
diff --git a/po/git.pot b/po/git.pot
index 4a9d4ef..325348d 100644
--- a/po/git.pot
+++ b/po/git.pot
@@ -8123,7 +8123,7 @@ msgstr ""
=20
 #: builtin/show-branch.c:9
 msgid ""
-"git show-branch [-a|--all] [-r|--remotes] [--topo-order | --date-orde=
r] [--"
+"git show-branch [-a|--all] [-r|--remotes] [--topo-order | --date-orde=
r | --authorship-order] [--"
 "current] [--color[=3D<when>] | --no-color] [--sparse] [--more=3D<n> |=
 --list | --"
 "independent | --merge-base] [--no-name | --sha1-name] [--topics] [(<r=
ev> | "
 "<glob>)...]"
diff --git a/po/sv.po b/po/sv.po
index a5c88c9..5091224 100644
--- a/po/sv.po
+++ b/po/sv.po
@@ -8478,12 +8478,12 @@ msgstr "Radbryt utdata"
=20
 #: builtin/show-branch.c:9
 msgid ""
-"git show-branch [-a|--all] [-r|--remotes] [--topo-order | --date-orde=
r] [--"
+"git show-branch [-a|--all] [-r|--remotes] [--topo-order | --date-orde=
r | --authorship-order] [--"
 "current] [--color[=3D<when>] | --no-color] [--sparse] [--more=3D<n> |=
 --list | --"
 "independent | --merge-base] [--no-name | --sha1-name] [--topics] [(<r=
ev> | "
 "<glob>)...]"
 msgstr ""
-"git show-branch [-a|--all] [-r|--remotes] [--topo-order | --date-orde=
r] [--"
+"git show-branch [-a|--all] [-r|--remotes] [--topo-order | --date-orde=
r | --authorship-order] [--"
 "current] [--color[=3D<n=C3=A4r>] | --no-color] [--sparse] [--more=3D<=
n> | --list | --"
 "independent | --merge-base] [--no-name | --sha1-name] [--topics] [(<r=
ev> | "
 "<m=C3=B6nster>)...]"
diff --git a/po/vi.po b/po/vi.po
index c6af8d5..ec41ff8 100644
--- a/po/vi.po
+++ b/po/vi.po
@@ -8622,12 +8622,12 @@ msgstr "Ng=E1=BA=AFt d=C3=B2ng khi qu=C3=A1 d=C3=
=A0i"
=20
 #: builtin/show-branch.c:9
 msgid ""
-"git show-branch [-a|--all] [-r|--remotes] [--topo-order | --date-orde=
r] [--"
+"git show-branch [-a|--all] [-r|--remotes] [--topo-order | --date-orde=
r | --authorship-order] [--"
 "current] [--color[=3D<when>] | --no-color] [--sparse] [--more=3D<n> |=
 --list | --"
 "independent | --merge-base] [--no-name | --sha1-name] [--topics] [(<r=
ev> | "
 "<glob>)...]"
 msgstr ""
-"git show-branch [-a|--all] [-r|--remotes] [--topo-order | --date-orde=
r] [--"
+"git show-branch [-a|--all] [-r|--remotes] [--topo-order | --date-orde=
r | --authorship-order] [--"
 "current] [--color[=3D<khi>] | --no-color] [--sparse] [--more=3D<n> | =
--list | --"
 "independent | --merge-base] [--no-name | --sha1-name] [--topics] [(<r=
ev> | "
 "<glob>)...]"
diff --git a/po/zh_CN.po b/po/zh_CN.po
index ba757d9..a666aed 100644
--- a/po/zh_CN.po
+++ b/po/zh_CN.po
@@ -8446,12 +8446,12 @@ msgstr "=E6=8A=98=E8=A1=8C=E8=BE=93=E5=87=BA"
=20
 #: builtin/show-branch.c:9
 msgid ""
-"git show-branch [-a|--all] [-r|--remotes] [--topo-order | --date-orde=
r] [--"
+"git show-branch [-a|--all] [-r|--remotes] [--topo-order | --date-orde=
r | --authorship-order] [--"
 "current] [--color[=3D<when>] | --no-color] [--sparse] [--more=3D<n> |=
 --list | --"
 "independent | --merge-base] [--no-name | --sha1-name] [--topics] [(<r=
ev> | "
 "<glob>)...]"
 msgstr ""
-"git show-branch [-a|--all] [-r|--remotes] [--topo-order | --date-orde=
r] [--"
+"git show-branch [-a|--all] [-r|--remotes] [--topo-order | --date-orde=
r | --authorship-order] [--"
 "current] [--color[=3D<when>] | --no-color] [--sparse] [--more=3D<n> |=
 --list | --"
 "independent | --merge-base] [--no-name | --sha1-name] [--topics] [(<r=
ev> | "
 "<glob>)...]"
diff --git a/revision.c b/revision.c
index 518cd08..2d077ce 100644
--- a/revision.c
+++ b/revision.c
@@ -1053,6 +1053,7 @@ void init_revisions(struct rev_info *revs, const =
char *prefix)
 	revs->pruning.add_remove =3D file_add_remove;
 	revs->pruning.change =3D file_change;
 	revs->lifo =3D 1;
+	revs->use_author =3D 0;
 	revs->dense =3D 1;
 	revs->prefix =3D prefix;
 	revs->max_age =3D -1;
@@ -1394,6 +1395,7 @@ static int handle_revision_opt(struct rev_info *r=
evs, int argc, const char **arg
 	} else if (!strcmp(arg, "--topo-order")) {
 		revs->lifo =3D 1;
 		revs->topo_order =3D 1;
+		revs->use_author =3D 0;
 	} else if (!strcmp(arg, "--simplify-merges")) {
 		revs->simplify_merges =3D 1;
 		revs->topo_order =3D 1;
@@ -1412,6 +1414,11 @@ static int handle_revision_opt(struct rev_info *=
revs, int argc, const char **arg
 	} else if (!strcmp(arg, "--date-order")) {
 		revs->lifo =3D 0;
 		revs->topo_order =3D 1;
+		revs->use_author =3D 0;
+	} else if (!strcmp(arg, "--authorship-order")) {
+		revs->lifo =3D 0;
+		revs->topo_order =3D 1;
+		revs->use_author =3D 1;
 	} else if (!prefixcmp(arg, "--early-output")) {
 		int count =3D 100;
 		switch (arg[14]) {
@@ -2191,7 +2198,7 @@ int prepare_revision_walk(struct rev_info *revs)
 		if (limit_list(revs) < 0)
 			return -1;
 	if (revs->topo_order)
-		sort_in_topological_order(&revs->commits, revs->lifo);
+		sort_in_topological_order(&revs->commits, revs->lifo, revs->use_auth=
or);
 	if (revs->line_level_traverse)
 		line_log_filter(revs);
 	if (revs->simplify_merges)
@@ -2503,7 +2510,7 @@ static void create_boundary_commit_list(struct re=
v_info *revs)
 	 * If revs->topo_order is set, sort the boundary commits
 	 * in topological order
 	 */
-	sort_in_topological_order(&revs->commits, revs->lifo);
+	sort_in_topological_order(&revs->commits, revs->lifo, revs->use_autho=
r);
 }
=20
 static struct commit *get_revision_internal(struct rev_info *revs)
diff --git a/revision.h b/revision.h
index a313a13..09effab 100644
--- a/revision.h
+++ b/revision.h
@@ -73,6 +73,7 @@ struct rev_info {
 			simplify_history:1,
 			lifo:1,
 			topo_order:1,
+			use_author:1,
 			simplify_merges:1,
 			simplify_by_decoration:1,
 			tag_objects:1,
--=20
1.8.1.3
