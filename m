From: Junio C Hamano <junkio@cox.net>
Subject: [PATCH 1/6] blame.c: whitespace and formatting clean-up.
Date: Thu, 05 Oct 2006 14:00:55 -0700
Message-ID: <7vsli2eauw.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-From: git-owner@vger.kernel.org Thu Oct 05 23:01:42 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GVaL6-0006NS-CZ
	for gcvg-git@gmane.org; Thu, 05 Oct 2006 23:01:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751291AbWJEVBE (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 5 Oct 2006 17:01:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751323AbWJEVBE
	(ORCPT <rfc822;git-outgoing>); Thu, 5 Oct 2006 17:01:04 -0400
Received: from fed1rmmtao12.cox.net ([68.230.241.27]:64704 "EHLO
	fed1rmmtao12.cox.net") by vger.kernel.org with ESMTP
	id S1751291AbWJEVBB (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 5 Oct 2006 17:01:01 -0400
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao12.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20061005210101.LTFU26416.fed1rmmtao12.cox.net@fed1rmimpo02.cox.net>;
          Thu, 5 Oct 2006 17:01:01 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id Wl131V00e1kojtg0000000
	Thu, 05 Oct 2006 17:01:04 -0400
To: git@vger.kernel.org
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/28364>


Signed-off-by: Junio C Hamano <junkio@cox.net>
---
 blame.c |  200 +++++++++++++++++++++++++++++++-------------------------------
 1 files changed, 100 insertions(+), 100 deletions(-)

diff --git a/blame.c b/blame.c
index 8cfd5d9..394b5c3 100644
--- a/blame.c
+++ b/blame.c
@@ -20,16 +20,17 @@ #include "xdiff-interface.h"
 
 #define DEBUG 0
 
-static const char blame_usage[] = "git-blame [-c] [-l] [-t] [-S <revs-file>] [--] file [commit]\n"
-	"  -c, --compatibility Use the same output mode as git-annotate (Default: off)\n"
-	"  -l, --long          Show long commit SHA1 (Default: off)\n"
-	"  -t, --time          Show raw timestamp (Default: off)\n"
-	"  -S, --revs-file     Use revisions from revs-file instead of calling git-rev-list\n"
-	"  -h, --help          This message";
+static const char blame_usage[] =
+"git-blame [-c] [-l] [-t] [-S <revs-file>] [--] file [commit]\n"
+"  -c, --compatibility Use the same output mode as git-annotate (Default: off)\n"
+"  -l, --long          Show long commit SHA1 (Default: off)\n"
+"  -t, --time          Show raw timestamp (Default: off)\n"
+"  -S, --revs-file     Use revisions from revs-file instead of calling git-rev-list\n"
+"  -h, --help          This message";
 
 static struct commit **blame_lines;
 static int num_blame_lines;
-static char* blame_contents;
+static char *blame_contents;
 static int blame_len;
 
 struct util_info {
@@ -38,9 +39,9 @@ struct util_info {
 	char *buf;
 	unsigned long size;
 	int num_lines;
-	const char* pathname;
+	const char *pathname;
 
-	void* topo_data;
+	void *topo_data;
 };
 
 struct chunk {
@@ -156,11 +157,10 @@ static int get_blob_sha1_internal(const 
 				  unsigned mode, int stage);
 
 static unsigned char blob_sha1[20];
-static const char* blame_file;
+static const char *blame_file;
 static int get_blob_sha1(struct tree *t, const char *pathname,
 			 unsigned char *sha1)
 {
-	int i;
 	const char *pathspec[2];
 	blame_file = pathname;
 	pathspec[0] = pathname;
@@ -168,12 +168,7 @@ static int get_blob_sha1(struct tree *t,
 	hashclr(blob_sha1);
 	read_tree_recursive(t, "", 0, 0, pathspec, get_blob_sha1_internal);
 
-	for (i = 0; i < 20; i++) {
-		if (blob_sha1[i] != 0)
-			break;
-	}
-
-	if (i == 20)
+	if (is_null_sha1(blob_sha1))
 		return -1;
 
 	hashcpy(sha1, blob_sha1);
@@ -239,7 +234,8 @@ static void print_map(struct commit *cmi
 		if (i < util->num_lines) {
 			num = util->line_map[i];
 			printf("%d\t", num);
-		} else
+		}
+		else
 			printf("\t");
 
 		if (i < util2->num_lines) {
@@ -247,7 +243,8 @@ static void print_map(struct commit *cmi
 			printf("%d\t", num2);
 			if (num != -1 && num2 != num)
 				printf("---");
-		} else
+		}
+		else
 			printf("\t");
 
 		printf("\n");
@@ -266,12 +263,12 @@ static void fill_line_map(struct commit 
 	int cur_chunk = 0;
 	int i1, i2;
 
-	if (p->num && DEBUG)
-		print_patch(p);
-
-	if (DEBUG)
+	if (DEBUG) {
+		if (p->num)
+			print_patch(p);
 		printf("num lines 1: %d num lines 2: %d\n", util->num_lines,
 		       util2->num_lines);
+	}
 
 	for (i1 = 0, i2 = 0; i1 < util->num_lines; i1++, i2++) {
 		struct chunk *chunk = NULL;
@@ -293,7 +290,8 @@ static void fill_line_map(struct commit 
 				i2 += chunk->len2;
 
 			cur_chunk++;
-		} else {
+		}
+		else {
 			if (i2 >= util2->num_lines)
 				break;
 
@@ -327,7 +325,7 @@ static int map_line(struct commit *commi
 	return info->line_map[line];
 }
 
-static struct util_info* get_util(struct commit *commit)
+static struct util_info *get_util(struct commit *commit)
 {
 	struct util_info *util = commit->util;
 
@@ -369,7 +367,7 @@ static void alloc_line_map(struct commit
 		if (util->buf[i] == '\n')
 			util->num_lines++;
 	}
-	if(util->buf[util->size - 1] != '\n')
+	if (util->buf[util->size - 1] != '\n')
 		util->num_lines++;
 
 	util->line_map = xmalloc(sizeof(int) * util->num_lines);
@@ -378,9 +376,9 @@ static void alloc_line_map(struct commit
 		util->line_map[i] = -1;
 }
 
-static void init_first_commit(struct commit* commit, const char* filename)
+static void init_first_commit(struct commit *commit, const char *filename)
 {
-	struct util_info* util = commit->util;
+	struct util_info *util = commit->util;
 	int i;
 
 	util->pathname = filename;
@@ -395,18 +393,17 @@ static void init_first_commit(struct com
 		util->line_map[i] = i;
 }
 
-
 static void process_commits(struct rev_info *rev, const char *path,
-			    struct commit** initial)
+			    struct commit **initial)
 {
 	int i;
-	struct util_info* util;
+	struct util_info *util;
 	int lines_left;
 	int *blame_p;
 	int *new_lines;
 	int new_lines_len;
 
-	struct commit* commit = get_revision(rev);
+	struct commit *commit = get_revision(rev);
 	assert(commit);
 	init_first_commit(commit, path);
 
@@ -442,7 +439,7 @@ static void process_commits(struct rev_i
 		     parents != NULL; parents = parents->next)
 			num_parents++;
 
-		if(num_parents == 0)
+		if (num_parents == 0)
 			*initial = commit;
 
 		if (fill_util_info(commit))
@@ -503,13 +500,12 @@ static void process_commits(struct rev_i
 	} while ((commit = get_revision(rev)) != NULL);
 }
 
-
-static int compare_tree_path(struct rev_info* revs,
-			     struct commit* c1, struct commit* c2)
+static int compare_tree_path(struct rev_info *revs,
+			     struct commit *c1, struct commit *c2)
 {
 	int ret;
-	const char* paths[2];
-	struct util_info* util = c2->util;
+	const char *paths[2];
+	struct util_info *util = c2->util;
 	paths[0] = util->pathname;
 	paths[1] = NULL;
 
@@ -520,12 +516,11 @@ static int compare_tree_path(struct rev_
 	return ret;
 }
 
-
-static int same_tree_as_empty_path(struct rev_info *revs, struct tree* t1,
-				   const char* path)
+static int same_tree_as_empty_path(struct rev_info *revs, struct tree *t1,
+				   const char *path)
 {
 	int ret;
-	const char* paths[2];
+	const char *paths[2];
 	paths[0] = path;
 	paths[1] = NULL;
 
@@ -536,9 +531,9 @@ static int same_tree_as_empty_path(struc
 	return ret;
 }
 
-static const char* find_rename(struct commit* commit, struct commit* parent)
+static const char *find_rename(struct commit *commit, struct commit *parent)
 {
-	struct util_info* cutil = commit->util;
+	struct util_info *cutil = commit->util;
 	struct diff_options diff_opts;
 	const char *paths[1];
 	int i;
@@ -564,9 +559,11 @@ static const char* find_rename(struct co
 	for (i = 0; i < diff_queued_diff.nr; i++) {
 		struct diff_filepair *p = diff_queued_diff.queue[i];
 
-		if (p->status == 'R' && !strcmp(p->one->path, cutil->pathname)) {
+		if (p->status == 'R' &&
+		    !strcmp(p->one->path, cutil->pathname)) {
 			if (DEBUG)
-				printf("rename %s -> %s\n", p->one->path, p->two->path);
+				printf("rename %s -> %s\n",
+				       p->one->path, p->two->path);
 			return p->two->path;
 		}
 	}
@@ -582,7 +579,7 @@ static void simplify_commit(struct rev_i
 		return;
 
 	if (!commit->parents) {
-		struct util_info* util = commit->util;
+		struct util_info *util = commit->util;
 		if (!same_tree_as_empty_path(revs, commit->tree,
 					     util->pathname))
 			commit->object.flags |= TREECHANGE;
@@ -608,17 +605,17 @@ static void simplify_commit(struct rev_i
 
 		case REV_TREE_NEW:
 		{
-
-			struct util_info* util = commit->util;
+			struct util_info *util = commit->util;
 			if (revs->remove_empty_trees &&
 			    same_tree_as_empty_path(revs, p->tree,
 						    util->pathname)) {
-				const char* new_name = find_rename(commit, p);
+				const char *new_name = find_rename(commit, p);
 				if (new_name) {
-					struct util_info* putil = get_util(p);
+					struct util_info *putil = get_util(p);
 					if (!putil->pathname)
 						putil->pathname = xstrdup(new_name);
-				} else {
+				}
+				else {
 					*pp = parent->next;
 					continue;
 				}
@@ -639,19 +636,18 @@ static void simplify_commit(struct rev_i
 	commit->object.flags |= TREECHANGE;
 }
 
-
 struct commit_info
 {
-	char* author;
-	char* author_mail;
+	char *author;
+	char *author_mail;
 	unsigned long author_time;
-	char* author_tz;
+	char *author_tz;
 };
 
-static void get_commit_info(struct commit* commit, struct commit_info* ret)
+static void get_commit_info(struct commit *commit, struct commit_info *ret)
 {
 	int len;
-	char* tmp;
+	char *tmp;
 	static char author_buf[1024];
 
 	tmp = strstr(commit->buffer, "\nauthor ") + 8;
@@ -662,24 +658,24 @@ static void get_commit_info(struct commi
 	tmp = ret->author;
 	tmp += len;
 	*tmp = 0;
-	while(*tmp != ' ')
+	while (*tmp != ' ')
 		tmp--;
 	ret->author_tz = tmp+1;
 
 	*tmp = 0;
-	while(*tmp != ' ')
+	while (*tmp != ' ')
 		tmp--;
 	ret->author_time = strtoul(tmp, NULL, 10);
 
 	*tmp = 0;
-	while(*tmp != ' ')
+	while (*tmp != ' ')
 		tmp--;
 	ret->author_mail = tmp + 1;
 
 	*tmp = 0;
 }
 
-static const char* format_time(unsigned long time, const char* tz_str,
+static const char *format_time(unsigned long time, const char *tz_str,
 			       int show_raw_time)
 {
 	static char time_buf[128];
@@ -704,15 +700,15 @@ static const char* format_time(unsigned 
 	return time_buf;
 }
 
-static void topo_setter(struct commit* c, void* data)
+static void topo_setter(struct commit *c, void *data)
 {
-	struct util_info* util = c->util;
+	struct util_info *util = c->util;
 	util->topo_data = data;
 }
 
-static void* topo_getter(struct commit* c)
+static void *topo_getter(struct commit *c)
 {
-	struct util_info* util = c->util;
+	struct util_info *util = c->util;
 	return util->topo_data;
 }
 
@@ -747,9 +743,9 @@ int main(int argc, const char **argv)
 	int compatibility = 0;
 	int show_raw_time = 0;
 	int options = 1;
-	struct commit* start_commit;
+	struct commit *start_commit;
 
-	const char* args[10];
+	const char *args[10];
 	struct rev_info rev;
 
 	struct commit_info ci;
@@ -758,27 +754,30 @@ int main(int argc, const char **argv)
 	int longest_file, longest_author;
 	int found_rename;
 
-	const char* prefix = setup_git_directory();
+	const char *prefix = setup_git_directory();
 	git_config(git_default_config);
 
-	for(i = 1; i < argc; i++) {
-		if(options) {
-			if(!strcmp(argv[i], "-h") ||
+	for (i = 1; i < argc; i++) {
+		if (options) {
+			if (!strcmp(argv[i], "-h") ||
 			   !strcmp(argv[i], "--help"))
 				usage(blame_usage);
-			else if(!strcmp(argv[i], "-l") ||
-				!strcmp(argv[i], "--long")) {
+			if (!strcmp(argv[i], "-l") ||
+			    !strcmp(argv[i], "--long")) {
 				sha1_len = 40;
 				continue;
-			} else if(!strcmp(argv[i], "-c") ||
-				  !strcmp(argv[i], "--compatibility")) {
+			}
+			if (!strcmp(argv[i], "-c") ||
+			    !strcmp(argv[i], "--compatibility")) {
 				compatibility = 1;
 				continue;
-			} else if(!strcmp(argv[i], "-t") ||
-				  !strcmp(argv[i], "--time")) {
+			}
+			if (!strcmp(argv[i], "-t") ||
+			    !strcmp(argv[i], "--time")) {
 				show_raw_time = 1;
 				continue;
-			} else if(!strcmp(argv[i], "-S")) {
+			}
+			if (!strcmp(argv[i], "-S")) {
 				if (i + 1 < argc &&
 				    !read_ancestry(argv[i + 1], &sha1_p)) {
 					compatibility = 1;
@@ -786,33 +785,34 @@ int main(int argc, const char **argv)
 					continue;
 				}
 				usage(blame_usage);
-			} else if(!strcmp(argv[i], "--")) {
+			}
+			if (!strcmp(argv[i], "--")) {
 				options = 0;
 				continue;
-			} else if(argv[i][0] == '-')
+			}
+			if (argv[i][0] == '-')
 				usage(blame_usage);
-			else
-				options = 0;
+			options = 0;
 		}
 
-		if(!options) {
-			if(!filename)
+		if (!options) {
+			if (!filename)
 				filename = argv[i];
-			else if(!commit)
+			else if (!commit)
 				commit = argv[i];
 			else
 				usage(blame_usage);
 		}
 	}
 
-	if(!filename)
+	if (!filename)
 		usage(blame_usage);
 	if (commit && sha1_p)
 		usage(blame_usage);
-	else if(!commit)
+	else if (!commit)
 		commit = "HEAD";
 
-	if(prefix)
+	if (prefix)
 		sprintf(filename_buf, "%s%s", prefix, filename);
 	else
 		strcpy(filename_buf, filename);
@@ -830,7 +830,6 @@ int main(int argc, const char **argv)
 		return 1;
 	}
 
-
 	init_revisions(&rev, setup_git_directory());
 	rev.remove_empty_trees = 1;
 	rev.topo_order = 1;
@@ -857,7 +856,7 @@ int main(int argc, const char **argv)
 	found_rename = 0;
 	for (i = 0; i < num_blame_lines; i++) {
 		struct commit *c = blame_lines[i];
-		struct util_info* u;
+		struct util_info *u;
 		if (!c)
 			c = initial;
 		u = c->util;
@@ -873,20 +872,20 @@ int main(int argc, const char **argv)
 
 	for (i = 0; i < num_blame_lines; i++) {
 		struct commit *c = blame_lines[i];
-		struct util_info* u;
-
+		struct util_info *u;
 		if (!c)
 			c = initial;
-
 		u = c->util;
+
 		get_commit_info(c, &ci);
 		fwrite(sha1_to_hex(c->object.sha1), sha1_len, 1, stdout);
-		if(compatibility) {
+		if (compatibility) {
 			printf("\t(%10s\t%10s\t%d)", ci.author,
 			       format_time(ci.author_time, ci.author_tz,
 					   show_raw_time),
 			       i+1);
-		} else {
+		}
+		else {
 			if (found_rename)
 				printf(" %-*.*s", longest_file, longest_file,
 				       u->pathname);
@@ -897,13 +896,14 @@ int main(int argc, const char **argv)
 			       max_digits, i+1);
 		}
 
-		if(i == num_blame_lines - 1) {
+		if (i == num_blame_lines - 1) {
 			fwrite(buf, blame_len - (buf - blame_contents),
 			       1, stdout);
-			if(blame_contents[blame_len-1] != '\n')
+			if (blame_contents[blame_len-1] != '\n')
 				putc('\n', stdout);
-		} else {
-			char* next_buf = strchr(buf, '\n') + 1;
+		}
+		else {
+			char *next_buf = strchr(buf, '\n') + 1;
 			fwrite(buf, next_buf - buf, 1, stdout);
 			buf = next_buf;
 		}
-- 
1.4.2.3.g866f3
