From: Jonas Fonseca <fonseca@diku.dk>
Subject: Re: [PATCH] Cleanup cogito command usage reporting
Date: Tue, 31 May 2005 03:36:44 +0200
Message-ID: <20050531013644.GD13961@diku.dk>
References: <20050530023603.GC10715@diku.dk> <20050530030521.GA13232@diku.dk> <20050530084558.GE1036@pasky.ji.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue May 31 03:35:43 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Dcvew-0004th-Cp
	for gcvg-git@gmane.org; Tue, 31 May 2005 03:35:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261853AbVEaBhe (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 30 May 2005 21:37:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261861AbVEaBhe
	(ORCPT <rfc822;git-outgoing>); Mon, 30 May 2005 21:37:34 -0400
Received: from nhugin.diku.dk ([130.225.96.140]:13022 "EHLO nhugin.diku.dk")
	by vger.kernel.org with ESMTP id S261853AbVEaBgq (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 30 May 2005 21:36:46 -0400
Received: by nhugin.diku.dk (Postfix, from userid 754)
	id D6C276E27A0; Tue, 31 May 2005 03:36:11 +0200 (CEST)
Received: from ask.diku.dk (ask.diku.dk [130.225.96.225])
	by nhugin.diku.dk (Postfix) with ESMTP
	id 481B46E2794; Tue, 31 May 2005 03:36:11 +0200 (CEST)
Received: by ask.diku.dk (Postfix, from userid 3873)
	id 843E761FE0; Tue, 31 May 2005 03:36:44 +0200 (CEST)
To: Petr Baudis <pasky@ucw.cz>
Content-Disposition: inline
In-Reply-To: <20050530084558.GE1036@pasky.ji.cz>
User-Agent: Mutt/1.5.6i
X-Spam-Status: No, hits=-4.9 required=5.0 tests=BAYES_00 autolearn=ham 
	version=2.60
X-Spam-Checker-Version: SpamAssassin 2.60 (1.212-2003-09-23-exp) on 
	nhugin.diku.dk
X-Spam-Level: 
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Petr Baudis <pasky@ucw.cz> wrote Mon, May 30, 2005:
> Dear diary, on Mon, May 30, 2005 at 05:05:21AM CEST, I got a letter
> where Jonas Fonseca <fonseca@diku.dk> told me that...
> > [ Sorry for the resend. This should bring all usage strings in sync. I
> >   forgot to add the new options. ]
> > 
> >  - Synchronize usage strings with those in cg-help. The command
> >    identifiers are still not as descriptive, though.
> 
> Ok, I'll focus on this point (the rest seems fine). I think it's
> inferior this way, since you are losing information, and for no benefit.

Yes, I was thinking more about getting nice simple generic command
identifiers that was easy to describe than thinking about self
documenting usage strings.

> > diff --git a/cg-clone b/cg-clone
> > --- a/cg-clone
> > +++ b/cg-clone
> > @@ -15,11 +15,12 @@
> > -USAGE="cg-clone [-s] LOCATION [<directory>]"
> > +USAGE="cg-clone [-s] LOCATION [DESTINATION]"
> > @@ -30,7 +31,7 @@ if [ "$1" = "-s" ]; then
> >  fi
> >  
> >  location=$1
> > -[ "$location" ] || die "usage: cg-clone [-s] SOURCE_LOC [DESTDIR]"
> > +[ "$location" ] || usage
> 
> LOCATION -> SOURCE_LOC is fine in this context (if we would ever want
> DEST_LOC, it would be better to stick with SOURCE_LOC, though). But
> DESTDIR->DESTINATION is losing information. In cogito.txt you describe
> DESTINATION as a general target location, but it's really a directory
> here. And it's shorter.

Done. Apart from the SOURCE_LOC.

> > diff --git a/cg-export b/cg-export
> > --- a/cg-export
> > +++ b/cg-export
> > @@ -22,7 +22,7 @@ USAGE="cg-export DESTINATION [TREE]"
> >  dest=$1
> >  id=$(tree-id $2)
> >  
> > -([ "$dest" ] && [ "$id" ]) || die "usage: cg-export DEST [TREE_ID]"
> > +([ "$dest" ] && [ "$id" ]) || usage
> 
> I'm for DESTDIR here too, and what harm does the _ID part make here? I
> think it's non-obvious otherwise - "TREE" can be understood as some
> directory name too.

TREE_ID it is and then DESTFILE (since it expects *.tar.* argument).

> > diff --git a/cg-help b/cg-help
> > --- a/cg-help
> > +++ b/cg-help
> > @@ -43,7 +43,7 @@ Available commands:
> >  	cg-export	DEST [TREE_ID]
> >  	cg-help		[COMMAND]
> >  	cg-init
> > -	cg-log		[-c] [-f] [-m] [-r FROM_ID[:TO_ID]] [FILE]...
> > +	cg-log		[-c] [-f] [-m] [-uUSERNAME] [-r FROM_ID[:TO_ID]] [FILE]...
> >  	cg-ls		[TREE_ID]
> >  	cg-merge	[-c] [-b BASE_ID] FROM_ID
> >  	cg-mkpatch	[-m] [-s] [-r FROM_ID[:TO_ID]]
> 
> So what about bringing those in sync too? (Or alternatively letting it
> be now and build the output dynamically in another patch.)

Dropped.

> > diff --git a/cg-merge b/cg-merge
> > --- a/cg-merge
> > +++ b/cg-merge
> > @@ -38,11 +38,11 @@ fi
> >  base=
> >  if [ "$1" = "-b" ]; then
> >  	shift
> > -	[ "$1" ] || die "usage: cg-merge [-c] [-b BASE_ID] FROM_ID"
> > +	[ "$1" ] || usage
> 
> I think BASE_ID->REVISION is loosing information too. What about
> BASE_COMMIT or something?

Changed to BASE_COMMIT.

===
Cleanup USAGE strings to be more self-documenting like those listed in
cg-help but with the following changes:

	BNAME	-> BRANCHNAME
	TNAME	-> TAGNAME
	OBJTYPE	-> OBJECT_TYPE

Updated the cogito manpage to reflect the change of command identifiers.

Signed-off-by: Jonas Fonseca <fonseca@diku.dk>
---

 Documentation/make-cogito-asciidoc |   16 +++++++---------
 cg-Xlib                            |    3 +++
 cg-add                             |    2 +-
 cg-admin-lsobj                     |    2 +-
 cg-admin-uncommit                  |    2 +-
 cg-branch-add                      |    4 ++--
 cg-clone                           |    5 +++--
 cg-commit                          |    4 ++--
 cg-diff                            |    4 ++--
 cg-export                          |    4 ++--
 cg-help                            |    2 +-
 cg-log                             |    4 ++--
 cg-ls                              |    2 +-
 cg-merge                           |    8 ++++----
 cg-mkpatch                         |    4 ++--
 cg-pull                            |    2 +-
 cg-rm                              |    2 +-
 cg-seek                            |    2 +-
 cg-tag                             |    4 ++--
 cg-update                          |    2 +-
 20 files changed, 40 insertions(+), 38 deletions(-)

diff --git a/Documentation/make-cogito-asciidoc b/Documentation/make-cogito-asciidoc
--- a/Documentation/make-cogito-asciidoc
+++ b/Documentation/make-cogito-asciidoc
@@ -106,20 +106,17 @@ $(print_command_listing $HELPER_COMMANDS
 
 Command Identifiers
 -------------------
-BRANCH::
-	Indicates a branch name added with the $(link cg-branch-add) name.
+BRANCH_NAME::
+	Indicates a branch name added with the $(link cg-branch-add) command.
 
 COMMAND::
 	Indicates a 'Cogito' command. The \`cg-\` prefix is optional.
 
-DESTINATION::
-	Indicates a path to a location file.
-
 LOCATION::
 	Indicates a local file path or a URI. See $(link cg-branch-add) for a
 	list of supported URI schemes.
 
-REVISION::
+COMMIT_ID, FROM_ID, TO_ID, BASE_COMMIT::
 	Indicates an ID resolving to a commit. The following expressions can
 	be used interchangably as IDs:
 	- empty string, 'this' or 'HEAD' (current HEAD)
@@ -129,17 +126,18 @@ REVISION::
 	- commit object hash (as returned by 'commit-id')
 	- tree object hash (as returned by 'tree-id')
 
-TAG::
+TAG_NAME::
 	Indicates a free form tag name.
 
-TYPE::
+OBJECT_TYPE::
 	Indicates a git object type i.e.: 'blob', 'commit', 'tree' or 'tag'.
 
 USERNAME::
 	Indicates a free form user name.
 
 FILE::
-	Indicates a filename - always relative to the root of the repository.
+	Indicates an already existing filename - always relative to the root
+	of the repository.
 
 COPYRIGHT
 ---------
diff --git a/cg-Xlib b/cg-Xlib
--- a/cg-Xlib
+++ b/cg-Xlib
@@ -17,6 +17,9 @@ die () {
 	exit 1
 }
 
+usage() {
+	die "usage: $USAGE"
+}
 
 mktemp () {
 	if [ ! "$BROKEN_MKTEMP" ]; then
diff --git a/cg-add b/cg-add
--- a/cg-add
+++ b/cg-add
@@ -17,7 +17,7 @@ USAGE="cg-add FILE..."
 
 . ${COGITO_LIB}cg-Xlib
 
-[ "$1" ] || die "usage: cg-add FILE..."
+[ "$1" ] || usage
 
 TMPFILE=$(mktemp -t gitadd.XXXXXX)
 find "$@" -type f > $TMPFILE || die "not all files exist, nothing added"
diff --git a/cg-admin-lsobj b/cg-admin-lsobj
--- a/cg-admin-lsobj
+++ b/cg-admin-lsobj
@@ -35,7 +35,7 @@
 #		echo -e "\n==================\nme $i"; cat-file commit $i;
 #	done
 
-USAGE="cg-admin-lsobj [TYPE]"
+USAGE="cg-admin-lsobj [OBJECT_TYPE]"
 
 . ${COGITO_LIB}cg-Xlib
 
diff --git a/cg-admin-uncommit b/cg-admin-uncommit
--- a/cg-admin-uncommit
+++ b/cg-admin-uncommit
@@ -17,7 +17,7 @@
 #	therefore generating tree with local changes against the target
 #	commit, consisting of the changes in the rolled back commits.
 
-USAGE="cg-admin-uncommit [-t] [REVISION]"
+USAGE="cg-admin-uncommit [-t] [COMMIT_ID]"
 
 . ${COGITO_LIB}cg-Xlib
 
diff --git a/cg-branch-add b/cg-branch-add
--- a/cg-branch-add
+++ b/cg-branch-add
@@ -30,14 +30,14 @@
 #
 # and refer to it as 'repo-testing' anytime later.
 
-USAGE="cg-branch-add BRANCH LOCATION"
+USAGE="cg-branch-add BRANCH_NAME LOCATION"
 
 . ${COGITO_LIB}cg-Xlib
 
 name=$1
 location=$2
 
-([ "$name" ] && [ "$location" ]) || die "usage: cg-branch-add NAME SOURCE_LOC"
+([ "$name" ] && [ "$location" ]) || usage
 (echo $name | egrep -qv '[^a-zA-Z0-9_.@!:-]') || \
 	die "name contains invalid characters"
 if [ "$name" = "this" ] || [ "$name" = "HEAD" ]; then
diff --git a/cg-clone b/cg-clone
--- a/cg-clone
+++ b/cg-clone
@@ -15,8 +15,9 @@
 # -------
 # -s::
 #	Clone in the current directory instead of creating a new one.
+#	Specifying both -s and a desination directory makes no sense .
 
-USAGE="cg-clone [-s] LOCATION [<directory>]"
+USAGE="cg-clone [-s] LOCATION [DESTDIR]"
 
 . ${COGITO_LIB}cg-Xlib
 
@@ -27,7 +28,7 @@ if [ "$1" = "-s" ]; then
 fi
 
 location=$1
-[ "$location" ] || die "usage: cg-clone [-s] SOURCE_LOC [DESTDIR]"
+[ "$location" ] || usage
 location=${location%/}
 
 destdir=$2
diff --git a/cg-commit b/cg-commit
--- a/cg-commit
+++ b/cg-commit
@@ -20,7 +20,7 @@
 #	Note, this is used internally by Cogito when merging. This option
 #	does not make sense when files are given on the command line.
 #
-# -m<message>::
+# -mMESSAGE::
 #	Specify the commit message, which is used instead of starting
 #	up an editor (if the input is not `stdin`, the input is appended
 #	after all the '-m' messages). Multiple '-m' parameters are appended
@@ -72,7 +72,7 @@
 # EDITOR::
 #	The editor used for entering revision log information.
 
-USAGE="cg-commit [-m<message>]... [-C] [-e | -E] [FILE]..."
+USAGE="cg-commit [-mMESSAGE]... [-C] [-e | -E] [FILE]..."
 
 . ${COGITO_LIB}cg-Xlib
 
diff --git a/cg-diff b/cg-diff
--- a/cg-diff
+++ b/cg-diff
@@ -16,7 +16,7 @@
 #	Instead of one ID denotes a parent commit to the specified ID
 #	(which must not be a tree, obviously).
 #
-# -r REVISION[:REVISION]::
+# -r FROM_ID[:TO_ID]::
 #	Specify the revisions to diff using either '-r rev1:rev2' or
 #	'-r rev1 -r rev2'. If no revision is specified, the current
 #	working tree is implied. Note that no revision is different from
@@ -27,7 +27,7 @@
 #	Base the diff at the merge base of the -r arguments (defaulting
 #	to master and origin).
 
-USAGE="cg-diff [-p] [-r REVISION[:REVISION]] [FILE]..."
+USAGE="cg-diff [-c] [-m] [-p] [-r FROM_ID[:TO_ID] [FILE]..."
 
 . ${COGITO_LIB}cg-Xlib
 
diff --git a/cg-export b/cg-export
--- a/cg-export
+++ b/cg-export
@@ -10,14 +10,14 @@
 # for generating a tarball. Other destination specifiers are assumed
 # to be directory names, and the tree is exported to the given directory.
 
-USAGE="cg-export DESTINATION [TREE]"
+USAGE="cg-export DESTFILE [TREE_ID]"
 
 . ${COGITO_LIB}cg-Xlib
 
 dest=$1
 id=$(tree-id $2)
 
-([ "$dest" ] && [ "$id" ]) || die "usage: cg-export DEST [TREE_ID]"
+([ "$dest" ] && [ "$id" ]) || usage
 
 [ -e "$dest" ] && die "$dest already exists."
 
diff --git a/cg-log b/cg-log
--- a/cg-log
+++ b/cg-log
@@ -24,7 +24,7 @@
 # -f::
 #	List affected files.
 #
-# -r REVISION[:REVISION]::
+# -r FROM_ID[:TO_ID]::
 #	Limit the log information to a set of revisions using either
 #	'-r FROM_ID[:TO_ID]' or '-r FROM_ID -r TO_ID'. In both cases the
 #	option expects IDs which resolve to commits and will include the
@@ -55,7 +55,7 @@
 #
 #	$ cg-log -r releasetag-0.9:releasetag-0.10
 
-USAGE="cg-log [-c] [-f] [-uUSERNAME] [-r REVISION[:REVISION]] FILE..."
+USAGE="cg-log [-c] [-f] [m] [-uUSERNAME] [-r FROM_ID[:TO_ID] FILE..."
 
 . ${COGITO_LIB}cg-Xlib
 # Try to fix the annoying "Broken pipe" output. May not help, but apparently
diff --git a/cg-ls b/cg-ls
--- a/cg-ls
+++ b/cg-ls
@@ -29,7 +29,7 @@
 #
 #	100644  blob    c7dacd0ea28994e3c754ca4eadb2e08c011ee3d3        README
 
-USAGE="cg-ls [TREE]"
+USAGE="cg-ls [TREE_ID]"
 
 . ${COGITO_LIB}cg-Xlib
 
diff --git a/cg-merge b/cg-merge
--- a/cg-merge
+++ b/cg-merge
@@ -12,14 +12,14 @@
 #
 # OPTIONS
 # -------
-# -b REVISION::
+# -b BASE_COMMIT::
 #	Parameter specifies the base commit for the merge.
 #
 # -c::
 #	Parameter specifies that you want to have tree merge never
 #	autocomitted, but want to review and commit it manually.
 
-USAGE="cg-merge [-c] [-b REVISION] BRANCH"
+USAGE="cg-merge [-c] [-b BASE_COMMIT] BRANCH_NAME"
 
 . ${COGITO_LIB}cg-Xlib
 
@@ -35,11 +35,11 @@ fi
 base=
 if [ "$1" = "-b" ]; then
 	shift
-	[ "$1" ] || die "usage: cg-merge [-c] [-b BASE_ID] FROM_ID"
+	[ "$1" ] || usage
 	base=$(commit-id "$1") || exit 1; shift
 fi
 
-[ "$1" ] || die "usage: cg-merge [-c] [-b BASE_ID] FROM_ID"
+[ "$1" ] || usage
 branchname="$1"
 branch=$(commit-id "$branchname") || exit 1
 
diff --git a/cg-mkpatch b/cg-mkpatch
--- a/cg-mkpatch
+++ b/cg-mkpatch
@@ -11,7 +11,7 @@
 #	Specify whether to print a short version of the patch without
 #	a patch header with meta info such as author and committer.
 #
-# -r REVISION[:REVISION]::
+# -r FROM_ID[:TO_ID]::
 #	Specify a set of commits to make patches from using either
 #	'-r FROM_ID[:TO_ID]' or '-r FROM_ID -r TO_ID'. In both cases the
 #	option expects IDs which resolve to commits and will include the
@@ -34,7 +34,7 @@
 # the line
 # `!-------------------------------------------------------------flip-`
 
-USAGE="cg-mkpatch [-s] [-r REVISION[:REVISION]]"
+USAGE="cg-mkpatch [-m] [-s] [-r FROM_ID[:TO_ID]]"
 
 . ${COGITO_LIB}cg-Xlib
 
diff --git a/cg-pull b/cg-pull
--- a/cg-pull
+++ b/cg-pull
@@ -7,7 +7,7 @@
 #
 # See `cg-branch-add` for some description.
 
-USAGE="cg-pull [BRANCH]"
+USAGE="cg-pull [BRANCH_NAME]"
 
 . ${COGITO_LIB}cg-Xlib
 
diff --git a/cg-rm b/cg-rm
--- a/cg-rm
+++ b/cg-rm
@@ -10,7 +10,7 @@ USAGE="cg-rm FILE..."
 
 . ${COGITO_LIB}cg-Xlib
 
-[ "$1" ] || die "usage: cg-rm FILE..."
+[ "$1" ] || usage
 
 rm -f "$@"
 git-update-cache --remove -- "$@"
diff --git a/cg-seek b/cg-seek
--- a/cg-seek
+++ b/cg-seek
@@ -19,7 +19,7 @@
 # the right thing too. If you want to migrate your working tree to another
 # branch, use `cg-clone`.
 
-USAGE="cg-seek REVISION"
+USAGE="cg-seek [COMMIT_ID]"
 
 . ${COGITO_LIB}cg-Xlib
 
diff --git a/cg-tag b/cg-tag
--- a/cg-tag
+++ b/cg-tag
@@ -8,14 +8,14 @@
 #
 # Takes the tag name and optionally the associated ID as arguments.
 
-USAGE="cg-tag TAG [REVISION]"
+USAGE="cg-tag TAG_NAME [COMMIT_ID]"
 
 . ${COGITO_LIB}cg-Xlib
 
 name=$1
 id=$2
 
-[ "$name" ] || die "usage: cg-tag TNAME [COMMIT_ID]"
+[ "$name" ] || usage
 [ "$id" ] || id=$(commit-id)
 
 (echo $name | egrep -qv '[^a-zA-Z0-9_.@!:-]') || \
diff --git a/cg-update b/cg-update
--- a/cg-update
+++ b/cg-update
@@ -8,7 +8,7 @@
 # If local changes conflict with those of the branch updated from the
 # merge will be blocked.
 
-USAGE="cg-update [BRANCH]"
+USAGE="cg-update [BRANCH_NAME]"
 
 . ${COGITO_LIB}cg-Xlib
 
-- 
Jonas Fonseca
