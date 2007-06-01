From: Josh Triplett <josh@freedesktop.org>
Subject: [PATCH] Create a new manpage for the gitignore format, and reference
 it elsewhere
Date: Fri, 01 Jun 2007 13:49:47 -0700
Message-ID: <4660866B.7000304@freedesktop.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enig01FBC3680BDFA32FEDE547F1"
Cc: 427078@bugs.debian.org, 427078-forwarded@bugs.debian.org
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jun 01 22:50:20 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HuE4h-0006ss-6K
	for gcvg-git@gmane.org; Fri, 01 Jun 2007 22:50:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1763238AbXFAUuN (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 1 Jun 2007 16:50:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1763338AbXFAUuN
	(ORCPT <rfc822;git-outgoing>); Fri, 1 Jun 2007 16:50:13 -0400
Received: from mail1.sea5.speakeasy.net ([69.17.117.3]:39091 "EHLO
	mail1.sea5.speakeasy.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1763238AbXFAUuK (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 1 Jun 2007 16:50:10 -0400
Received: (qmail 3724 invoked from network); 1 Jun 2007 20:50:09 -0000
Received: from dsl093-040-092.pdx1.dsl.speakeasy.net (HELO [192.168.0.122]) (josh@[66.93.40.92])
          (envelope-sender <josh@freedesktop.org>)
          by mail1.sea5.speakeasy.net (qmail-ldap-1.03) with AES256-SHA encrypted SMTP
          for <git@vger.kernel.org>; 1 Jun 2007 20:50:08 -0000
User-Agent: Icedove 1.5.0.10 (X11/20070329)
X-Enigmail-Version: 0.94.2.0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/48884>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig01FBC3680BDFA32FEDE547F1
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Only git-ls-files(1) describes the gitignore format in detail, and it doe=
s so
with reference to git-ls-files options.  Most users don't use the plumbin=
g
command git-ls-files directly, and shouldn't have to look in its manpage =
for
information on the gitignore format.

Create a new manpage gitignore(5) (Documentation/gitignore.txt), and fact=
or
out the gitignore documentation into that file, changing it to refer to
=2Egitignore and $GIT_DIR/info/exclude as used by porcelain commands.  Re=
ference
gitignore(5) from other relevant manpages.  Remove now-redundant informat=
ion
on exclude patterns from git-ls-files(1), leaving only information on how=

git-ls-files options specify exclude patterns and what precedence they ha=
ve.

Signed-off-by: Josh Triplett <josh@freedesktop.org>
---
 Documentation/Makefile          |    2 +-
 Documentation/git-ls-files.txt  |   99 +++++----------------------------=
-----
 Documentation/git-read-tree.txt |    3 +-
 Documentation/git-status.txt    |    8 +--
 Documentation/gitignore.txt     |  100 +++++++++++++++++++++++++++++++++=
++++++
 5 files changed, 120 insertions(+), 92 deletions(-)
 create mode 100644 Documentation/gitignore.txt

diff --git a/Documentation/Makefile b/Documentation/Makefile
index 3f92783..ef4425c 100644
--- a/Documentation/Makefile
+++ b/Documentation/Makefile
@@ -2,7 +2,7 @@ MAN1_TXT=3D \
 	$(filter-out $(addsuffix .txt, $(ARTICLES) $(SP_ARTICLES)), \
 		$(wildcard git-*.txt)) \
 	gitk.txt
-MAN5_TXT=3Dgitattributes.txt
+MAN5_TXT=3Dgitattributes.txt gitignore.txt
 MAN7_TXT=3Dgit.txt
=20
 DOC_HTML=3D$(patsubst %.txt,%.html,$(MAN1_TXT) $(MAN5_TXT) $(MAN7_TXT))
diff --git a/Documentation/git-ls-files.txt b/Documentation/git-ls-files.=
txt
index 43e0d22..62d8739 100644
--- a/Documentation/git-ls-files.txt
+++ b/Documentation/git-ls-files.txt
@@ -139,46 +139,24 @@ Exclude Patterns
=20
 'git-ls-files' can use a list of "exclude patterns" when
 traversing the directory tree and finding files to show when the
-flags --others or --ignored are specified.
+flags --others or --ignored are specified.  gitignore(5)
+specifies the format of exclude patterns.
=20
-These exclude patterns come from these places:
+These exclude patterns come from these places, in order:
=20
-  1. command line flag --exclude=3D<pattern> specifies a single
-     pattern.
+  1. The command line flag --exclude=3D<pattern> specifies a
+     single pattern.  Patterns are ordered in the same order
+     they appear in the command line.
=20
-  2. command line flag --exclude-from=3D<file> specifies a list of
-     patterns stored in a file.
+  2. The command line flag --exclude-from=3D<file> specifies a
+     file containing a list of patterns.  Patterns are ordered
+     in the same order they appear in the file.
=20
   3. command line flag --exclude-per-directory=3D<name> specifies
      a name of the file in each directory 'git-ls-files'
-     examines, and if exists, its contents are used as an
-     additional list of patterns.
-
-An exclude pattern file used by (2) and (3) contains one pattern
-per line.  A line that starts with a '#' can be used as comment
-for readability.
-
-There are three lists of patterns that are in effect at a given
-time.  They are built and ordered in the following way:
-
- * --exclude=3D<pattern> from the command line; patterns are
-   ordered in the same order as they appear on the command line.
-
- * lines read from --exclude-from=3D<file>; patterns are ordered
-   in the same order as they appear in the file.
-
- * When --exclude-per-directory=3D<name> is specified, upon
-   entering a directory that has such a file, its contents are
-   appended at the end of the current "list of patterns".  They
-   are popped off when leaving the directory.
-
-Each pattern in the pattern list specifies "a match pattern" and
-optionally the fate; either a file that matches the pattern is
-considered excluded or included.  A filename is matched against
-the patterns in the three lists; the --exclude-from list is
-checked first, then the --exclude-per-directory list, and then
-finally the --exclude list. The last match determines its fate.
-If there is no match in the three lists, the fate is "included".
+     examines, normally `.gitignore`.  Files in deeper
+     directories take precedence.  Patterns are ordered in the
+     same order they appear in the files.
=20
 A pattern specified on the command line with --exclude or read
 from the file specified with --exclude-from is relative to the
@@ -186,58 +164,9 @@ top of the directory tree.  A pattern read from a fi=
le specified
 by --exclude-per-directory is relative to the directory that the
 pattern file appears in.
=20
-An exclude pattern is of the following format:
-
- - an optional prefix '!' which means that the fate this pattern
-   specifies is "include", not the usual "exclude"; the
-   remainder of the pattern string is interpreted according to
-   the following rules.
-
- - if it does not contain a slash '/', it is a shell glob
-   pattern and used to match against the filename without
-   leading directories.
-
- - otherwise, it is a shell glob pattern, suitable for
-   consumption by fnmatch(3) with FNM_PATHNAME flag.  I.e. a
-   slash in the pattern must match a slash in the pathname.
-   "Documentation/\*.html" matches "Documentation/git.html" but
-   not "ppc/ppc.html".  As a natural exception, "/*.c" matches
-   "cat-file.c" but not "mozilla-sha1/sha1.c".
-
-An example:
-
---------------------------------------------------------------
-    $ cat .git/info/exclude
-    # ignore objects and archives, anywhere in the tree.
-    *.[oa]
-    $ cat Documentation/.gitignore
-    # ignore generated html files,
-    *.html
-    # except foo.html which is maintained by hand
-    !foo.html
-    $ git-ls-files --ignored \
-        --exclude=3D'Documentation/*.[0-9]' \
-        --exclude-from=3D.git/info/exclude \
-        --exclude-per-directory=3D.gitignore
---------------------------------------------------------------
-
-Another example:
-
---------------------------------------------------------------
-    $ cat .gitignore
-    vmlinux*
-    $ ls arch/foo/kernel/vm*
-    arch/foo/kernel/vmlinux.lds.S
-    $ echo '!/vmlinux*' >arch/foo/kernel/.gitignore
---------------------------------------------------------------
-
-The second .gitignore keeps `arch/foo/kernel/vmlinux.lds.S` file
-from getting ignored.
-
-
 See Also
 --------
-gitlink:git-read-tree[1]
+gitlink:git-read-tree[1], gitlink:gitignore[5]
=20
=20
 Author
@@ -246,7 +175,7 @@ Written by Linus Torvalds <torvalds@osdl.org>
=20
 Documentation
 --------------
-Documentation by David Greaves, Junio C Hamano and the git-list <git@vge=
r.kernel.org>.
+Documentation by David Greaves, Junio C Hamano, Josh Triplett, and the g=
it-list <git@vger.kernel.org>.
=20
 GIT
 ---
diff --git a/Documentation/git-read-tree.txt b/Documentation/git-read-tre=
e.txt
index 019c8be..acb5744 100644
--- a/Documentation/git-read-tree.txt
+++ b/Documentation/git-read-tree.txt
@@ -341,7 +341,8 @@ have finished your work-in-progress), attempt the mer=
ge again.
=20
 See Also
 --------
-gitlink:git-write-tree[1]; gitlink:git-ls-files[1]
+gitlink:git-write-tree[1]; gitlink:git-ls-files[1];
+gitlink:gitignore[5]
=20
=20
 Author
diff --git a/Documentation/git-status.txt b/Documentation/git-status.txt
index d701538..1fd1af1 100644
--- a/Documentation/git-status.txt
+++ b/Documentation/git-status.txt
@@ -42,11 +42,9 @@ mean the same thing and the latter is kept for backwar=
d
 compatibility) and `color.status.<slot>` configuration variables
 to colorize its output.
=20
-As for gitlink:git-add[1], the configuration variable
-'core.excludesfile' can indicate a path to a file containing patterns
-of file names to exclude, in addition to patterns given in
-'info/exclude' and '.gitignore'.
-
+See Also
+--------
+gitlink:gitignore[5]
=20
 Author
 ------
diff --git a/Documentation/gitignore.txt b/Documentation/gitignore.txt
new file mode 100644
index 0000000..190bd9f
--- /dev/null
+++ b/Documentation/gitignore.txt
@@ -0,0 +1,100 @@
+gitignore(5)
+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
+
+NAME
+----
+gitignore - Specifies intentionally untracked files to ignore
+
+SYNOPSIS
+--------
+$GIT_DIR/info/exclude, .gitignore
+
+DESCRIPTION
+-----------
+
+A `gitignore` file specifies intentionally untracked files that
+git should ignore.  Each line in a `gitignore` file specifies a
+pattern.
+
+When deciding whether to ignore a path, git normally checks
+`gitignore` patterns from multiple sources, with the following
+order of precedence:
+
+ * Patterns read from the file specified by the configuration
+   variable 'core.excludesfile'.
+
+ * Patterns read from `$GIT_DIR/info/exclude`.
+
+ * Patterns read from a `.gitignore` file in the same directory
+   as the path, or in any parent directory, ordered from the
+   deepest such file to a file in the root of the repository.
+   These patterns match relative to the location of the
+   `.gitignore` file.  A project normally includes such
+   `.gitignore` files in its repository, containing patterns for
+   files generated as part of the project build.
+
+Some git plumbing tools, such as git-ls-files(1) and
+git-read-tree(1), read `gitignore` patterns specified by
+command-line options, or from files specified by command-line
+options.
+
+Patterns have the following format:
+
+ - A blank line matches no files, so it can serve as a separator
+   for readability.
+
+ - A line starting with #=20
+
+ - An optional prefix '!' which negates the pattern; any
+   matching file excluded by a previous pattern will become
+   included again.
+
+ - If the pattern does not contain a slash '/', git treats it as
+   a shell glob pattern and checks for a match against the
+   pathname without leading directories.
+
+ - Otherwise, git treats the pattern as a shell glob suitable
+   for consumption by fnmatch(3) with the FNM_PATHNAME flag: any
+   slash in the pattern must match a slash in the pathname.  For
+   example, "Documentation/\*.html" matches
+   "Documentation/git.html" but not "ppc/ppc.html".  A leading
+   slash matches the beginning of the pathname; for example,
+   "/*.c" matches "cat-file.c" but not "mozilla-sha1/sha1.c".
+
+An example:
+
+--------------------------------------------------------------
+    $ cat .git/info/exclude
+    # ignore objects and archives, anywhere in the tree.
+    *.[oa]
+    $ cat Documentation/.gitignore
+    # ignore generated html files,
+    *.html
+    # except foo.html which is maintained by hand
+    !foo.html
+    $ git-ls-files --ignored \
+        --exclude=3D'Documentation/*.[0-9]' \
+        --exclude-from=3D.git/info/exclude \
+        --exclude-per-directory=3D.gitignore
+--------------------------------------------------------------
+
+Another example:
+
+--------------------------------------------------------------
+    $ cat .gitignore
+    vmlinux*
+    $ ls arch/foo/kernel/vm*
+    arch/foo/kernel/vmlinux.lds.S
+    $ echo '!/vmlinux*' >arch/foo/kernel/.gitignore
+--------------------------------------------------------------
+
+The second .gitignore prevents git from ignoring
+`arch/foo/kernel/vmlinux.lds.S`.
+
+Documentation
+-------------
+Documentation by Josh Triplett.
+
+GIT
+---
+Part of the gitlink:git[7] suite
--=20
1.5.2



--------------enig01FBC3680BDFA32FEDE547F1
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFGYIZrGJuZRtD+evsRAszjAJ9VNyOnK6+w3dArO1FkienVVY5ULgCdGbQW
0W4kqtM8eh79DETmySdA4oE=
=uL3Q
-----END PGP SIGNATURE-----

--------------enig01FBC3680BDFA32FEDE547F1--
