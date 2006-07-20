From: "Peter Eriksen" <s022018@student.dtu.dk>
Subject: Unanticipated test error
Date: Thu, 20 Jul 2006 21:40:13 +0200
Message-ID: <20060720194013.GC24793@bohr.gbar.dtu.dk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-From: git-owner@vger.kernel.org Thu Jul 20 21:40:54 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1G3eNl-0002wc-H9
	for gcvg-git@gmane.org; Thu, 20 Jul 2006 21:40:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030343AbWGTTkQ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 20 Jul 2006 15:40:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030365AbWGTTkQ
	(ORCPT <rfc822;git-outgoing>); Thu, 20 Jul 2006 15:40:16 -0400
Received: from bohr.gbar.dtu.dk ([192.38.95.24]:40905 "HELO bohr.gbar.dtu.dk")
	by vger.kernel.org with SMTP id S1030343AbWGTTkP (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 20 Jul 2006 15:40:15 -0400
Received: (qmail 5908 invoked by uid 5842); 20 Jul 2006 21:40:13 +0200
To: git@vger.kernel.org
Content-Disposition: inline
User-Agent: Mutt/1.5.7i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/24035>

Greetings,

I get a bit strange "make test" error using the patch bellow on the
current Git master branch.  Applied with git-apply.  I suspect it is
an error in my umask or something.  It compiles fine.  The error 
output is:


[peter@localhost git]$ make test
make -C templates
make[1]: Entering directory `/home/peter/Git/git/templates'
: no custom templates yet
make[1]: Leaving directory `/home/peter/Git/git/templates'
make -C t/ all
make[1]: Entering directory `/home/peter/Git/git/t'
*** t0000-basic.sh ***
mv: cannot stat `.git/hooks': No such file or directory
*   ok 1: .git/objects should be empty after git-init-db in an empty repo.
*   ok 2: .git/objects should have 3 subdirectories.
*   ok 3: git-update-index without --add should fail adding.
*   ok 4: git-update-index with --add should succeed.
*   ok 5: writing tree out with git-write-tree
*   ok 6: validate object ID of a known tree.
*   ok 7: git-update-index without --remove should fail removing.
*   ok 8: git-update-index with --remove should be able to remove.
*   ok 9: git-write-tree should be able to write an empty tree.
*   ok 10: validate object ID of a known tree.
*   ok 11: adding various types of objects with git-update-index --add.
*   ok 12: showing stage with git-ls-files --stage
*   ok 13: validate git-ls-files output for a known tree.
* FAIL 14: writing tree out with git-write-tree.
        tree=$(git-write-tree)
* FAIL 15: validate object ID for a known tree.
        test "$tree" = 087704a96baf1c2d1c869a8b084481e121c88b5b
* FAIL 16: showing tree with git-ls-tree
        git-ls-tree $tree >current
* FAIL 17: git-ls-tree output for a known tree.
        diff current expected
* FAIL 18: showing tree with git-ls-tree -r
        git-ls-tree -r $tree >current
* FAIL 19: git-ls-tree -r output for a known tree.
        diff current expected
* FAIL 20: showing tree with git-ls-tree -r -t
        git-ls-tree -r -t $tree >current
* FAIL 21: git-ls-tree -r output for a known tree.
        diff current expected
* FAIL 22: writing partial tree out with git-write-tree --prefix.
        ptree=$(git-write-tree --prefix=path3)
* FAIL 23: validate object ID for a known tree.
        test "$ptree" = 21ae8269cacbe57ae09138dcc3a2887f904d02b3
* FAIL 24: writing partial tree out with git-write-tree --prefix.
        ptree=$(git-write-tree --prefix=path3/subp3)
* FAIL 25: validate object ID for a known tree.
        test "$ptree" = 3c5e5399f3a333eddecce7a9b9465b63f65f51e2
* FAIL 26: git-read-tree followed by write-tree should be idempotent.
        git-read-tree $tree &&
             test -f .git/index &&
             newtree=$(git-write-tree) &&
             test "$newtree" = "$tree"
* FAIL 27: validate git-diff-files output for a know cache/work tree state.
        git-diff-files >current && diff >/dev/null -b current expected
*   ok 28: git-update-index --refresh should succeed.
*   ok 29: no diff after checkout and git-update-index --refresh.
* FAIL 30: git-commit-tree records the correct tree in a commit.
        commit0=$(echo NO | git-commit-tree $P) &&
             tree=$(git show --pretty=raw $commit0 |
                 sed -n -e "s/^tree //p" -e "/^author /q") &&
             test "z$tree" = "z$P"
* FAIL 31: git-commit-tree records the correct parent in a commit.
        commit1=$(echo NO | git-commit-tree $P -p $commit0) &&
             parent=$(git show --pretty=raw $commit1 |
                 sed -n -e "s/^parent //p" -e "/^author /q") &&
             test "z$commit0" = "z$parent"
* FAIL 32: git-commit-tree omits duplicated parent in a commit.
        commit2=$(echo NO | git-commit-tree $P -p $commit0 -p $commit0) &&
             parent=$(git show --pretty=raw $commit2 |
                 sed -n -e "s/^parent //p" -e "/^author /q" |
                 sort -u) &&
             test "z$commit0" = "z$parent" &&
             numparent=$(git show --pretty=raw $commit2 |
                 sed -n -e "s/^parent //p" -e "/^author /q" |
                 wc -l) &&
             test $numparent = 1
* failed 17 among 32 test(s)
make[1]: *** [t0000-basic.sh] Error 1
make[1]: Leaving directory `/home/peter/Git/git/t'
make: *** [test] Error 2
[peter@localhost git]$


The patch really should not change any semantics at all, since
it converts instances of 

   memcpy(to, from, len);
   to[len] = 0;

into

   strlcpy(to, from, len);

I need a bit of help troubleshooting this one.  I have tried
running t0000-basic.sh using "bash -x", but that did not help
me this time.

Regards,

Peter



======== strlcpy.diff ===============

diff --git a/builtin-apply.c b/builtin-apply.c
index c903146..79537c5 100644
--- a/builtin-apply.c
+++ b/builtin-apply.c
@@ -266,8 +266,7 @@ static char * find_name(const char *line
 	}
 
 	name = xmalloc(len + 1);
-	memcpy(name, start, len);
-	name[len] = 0;
+	strlcpy(name, start, len);
 	free(def);
 	return name;
 }
@@ -439,8 +438,7 @@ static int gitdiff_index(const char *lin
 	if (!ptr || ptr[1] != '.' || 40 < ptr - line)
 		return 0;
 	len = ptr - line;
-	memcpy(patch->old_sha1_prefix, line, len);
-	patch->old_sha1_prefix[len] = 0;
+	strlcpy(patch->old_sha1_prefix, line, len);
 
 	line = ptr + 2;
 	ptr = strchr(line, ' ');
@@ -452,8 +450,7 @@ static int gitdiff_index(const char *lin
 
 	if (40 < len)
 		return 0;
-	memcpy(patch->new_sha1_prefix, line, len);
-	patch->new_sha1_prefix[len] = 0;
+	strlcpy(patch->new_sha1_prefix, line, len);
 	if (*ptr == ' ')
 		patch->new_mode = patch->old_mode = strtoul(ptr+1, NULL, 8);
 	return 0;
@@ -609,8 +606,7 @@ static char *git_header_name(char *line,
 			}
 			if (second[len] == '\n' && !memcmp(name, second, len)) {
 				char *ret = xmalloc(len + 1);
-				memcpy(ret, name, len);
-				ret[len] = 0;
+				strlcpy(ret, name, len);
 				return ret;
 			}
 		}
diff --git a/builtin-init-db.c b/builtin-init-db.c
index 7fdd2fa..206cad1 100644
--- a/builtin-init-db.c
+++ b/builtin-init-db.c
@@ -156,8 +156,7 @@ static void copy_templates(const char *g
 		return;
 	}
 
-	memcpy(path, git_dir, len);
-	path[len] = 0;
+	strlcpy(path, git_dir, len);
 	copy_templates_1(path, len,
 			 template_path, template_len,
 			 dir);
diff --git a/builtin-ls-files.c b/builtin-ls-files.c
index 8dae9f7..a2bd674 100644
--- a/builtin-ls-files.c
+++ b/builtin-ls-files.c
@@ -310,8 +310,7 @@ static void verify_pathspec(void)
 	prefix_len = max;
 	if (max) {
 		real_prefix = xmalloc(max + 1);
-		memcpy(real_prefix, prev, max);
-		real_prefix[max] = 0;
+		strlcpy(real_prefix, prev, max);
 	}
 	prefix = real_prefix;
 }
diff --git a/cache-tree.c b/cache-tree.c
index d9f7e1e..5c8009d 100644
--- a/cache-tree.c
+++ b/cache-tree.c
@@ -80,8 +80,7 @@ static struct cache_tree_sub *find_subtr
 	down = xmalloc(sizeof(*down) + pathlen + 1);
 	down->cache_tree = NULL;
 	down->namelen = pathlen;
-	memcpy(down->name, path, pathlen);
-	down->name[pathlen] = 0;
+	strlcpy(down->name, path, pathlen);
 
 	if (pos < it->subtree_nr)
 		memmove(it->down + pos + 1,
diff --git a/combine-diff.c b/combine-diff.c
index 1bc1484..34c166d 100644
--- a/combine-diff.c
+++ b/combine-diff.c
@@ -31,8 +31,7 @@ static struct combine_diff_path *interse
 			len = strlen(path);
 			p = xmalloc(combine_diff_path_size(num_parent, len));
 			p->path = (char*) &(p->parent[num_parent]);
-			memcpy(p->path, path, len);
-			p->path[len] = 0;
+			strlcpy(p->path, path, len);
 			p->len = len;
 			p->next = NULL;
 			memset(p->parent, 0,
@@ -143,8 +142,7 @@ static void append_lost(struct sline *sl
 	lline->len = len;
 	lline->next = NULL;
 	lline->parent_map = this_mask;
-	memcpy(lline->line, line, len);
-	lline->line[len] = 0;
+	strlcpy(lline->line, line, len);
 	*sline->lost_tail = lline;
 	sline->lost_tail = &lline->next;
 }
diff --git a/diff-lib.c b/diff-lib.c
index 116b5a9..3e1f0b2 100644
--- a/diff-lib.c
+++ b/diff-lib.c
@@ -45,8 +45,7 @@ int run_diff_files(struct rev_info *revs
 
 			dpath->next = NULL;
 			dpath->len = path_len;
-			memcpy(dpath->path, ce->name, path_len);
-			dpath->path[path_len] = '\0';
+			strlcpy(dpath->path, ce->name, path_len);
 			dpath->mode = 0;
 			memset(dpath->sha1, 0, 20);
 			memset(&(dpath->parent[0]), 0,
diff --git a/diffcore-order.c b/diffcore-order.c
index aef6da6..cae64b9 100644
--- a/diffcore-order.c
+++ b/diffcore-order.c
@@ -50,8 +50,7 @@ static void prepare_order(const char *or
 				}
 				else {
 					order[cnt] = xmalloc(ep-cp+1);
-					memcpy(order[cnt], cp, ep-cp);
-					order[cnt][ep-cp] = 0;
+					strlcpy(order[cnt], cp, ep-cp);
 				}
 				cnt++;
 			}
diff --git a/dir.c b/dir.c
index 092d077..cf0b171 100644
--- a/dir.c
+++ b/dir.c
@@ -260,8 +260,7 @@ static void add_name(struct dir_struct *
 	}
 	ent = xmalloc(sizeof(*ent) + len + 1);
 	ent->len = len;
-	memcpy(ent->name, pathname, len);
-	ent->name[len] = 0;
+	strlcpy(ent->name, pathname, len);
 	dir->entries[dir->nr++] = ent;
 }
 
diff --git a/entry.c b/entry.c
index 793724f..0860ded 100644
--- a/entry.c
+++ b/entry.c
@@ -11,8 +11,7 @@ static void create_directories(const cha
 
 	while ((slash = strchr(slash+1, '/')) != NULL) {
 		len = slash - path;
-		memcpy(buf, path, len);
-		buf[len] = 0;
+		strlcpy(buf, path, len);
 		if (mkdir(buf, 0777)) {
 			if (errno == EEXIST) {
 				struct stat st;
diff --git a/imap-send.c b/imap-send.c
index 65c71c6..a4c40e8 100644
--- a/imap-send.c
+++ b/imap-send.c
@@ -656,8 +656,7 @@ parse_imap_list_l( imap_t *imap, char **
 			cur->len = s - p;
 			s++;
 			cur->val = xmalloc( cur->len + 1 );
-			memcpy( cur->val, p, cur->len );
-			cur->val[cur->len] = 0;
+			strlcpy( cur->val, p, cur->len );
 		} else {
 			/* atom */
 			p = s;
diff --git a/mktag.c b/mktag.c
index 27f4c4f..7047bec 100644
--- a/mktag.c
+++ b/mktag.c
@@ -76,8 +76,7 @@ static int verify_tag(char *buffer, unsi
 	if (typelen >= sizeof(type))
 		return error("char%td: type too long\n", type_line+5 - buffer);
 
-	memcpy(type, type_line+5, typelen);
-	type[typelen] = 0;
+	strlcpy(type, type_line+5, typelen);
 
 	/* Verify that the object matches */
 	if (get_sha1_hex(object + 7, sha1))
