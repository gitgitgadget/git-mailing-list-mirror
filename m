From: Josh Triplett <josh@freedesktop.org>
Subject: [PATCH] Create a new manpage for the gitignore format, and reference
 it elsewhere
Date: Fri, 01 Jun 2007 15:20:52 -0700
Message-ID: <46609BC4.9000508@freedesktop.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enigA862222891DD69D403B6C9E7"
Cc: 427078@bugs.debian.org, 427078-forwarded@bugs.debian.org
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Jun 02 00:21:28 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HuFUr-00010S-Sk
	for gcvg-git@gmane.org; Sat, 02 Jun 2007 00:21:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752773AbXFAWVQ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 1 Jun 2007 18:21:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752963AbXFAWVQ
	(ORCPT <rfc822;git-outgoing>); Fri, 1 Jun 2007 18:21:16 -0400
Received: from mail3.sea5.speakeasy.net ([69.17.117.5]:56875 "EHLO
	mail3.sea5.speakeasy.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752773AbXFAWVP (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 1 Jun 2007 18:21:15 -0400
Received: (qmail 9678 invoked from network); 1 Jun 2007 22:21:13 -0000
Received: from dsl093-040-092.pdx1.dsl.speakeasy.net (HELO [192.168.0.122]) (josh@[66.93.40.92])
          (envelope-sender <josh@freedesktop.org>)
          by mail3.sea5.speakeasy.net (qmail-ldap-1.03) with AES256-SHA encrypted SMTP
          for <git@vger.kernel.org>; 1 Jun 2007 22:21:13 -0000
User-Agent: Icedove 1.5.0.10 (X11/20070329)
X-Enigmail-Version: 0.94.2.0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/48891>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enigA862222891DD69D403B6C9E7
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
gitignore(5) from other relevant manpages and documentation.  Remove
now-redundant information on exclude patterns from git-ls-files(1), leavi=
ng
only information on how git-ls-files options specify exclude patterns and=
 what
precedence they have.

Signed-off-by: Josh Triplett <josh@freedesktop.org>
Signed-off-by: Josh Triplett <josh@freedesktop.org>
---
 Documentation/Makefile              |    2 +-
 Documentation/config.txt            |    3 +-
 Documentation/git-ls-files.txt      |   99 +++++------------------------=
-----
 Documentation/git-read-tree.txt     |    3 +-
 Documentation/git-status.txt        |    8 +--
 Documentation/gitignore.txt         |  100 +++++++++++++++++++++++++++++=
++++++
 Documentation/repository-layout.txt |    3 +-
 Documentation/user-manual.txt       |   12 ++--
 8 files changed, 129 insertions(+), 101 deletions(-)
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
diff --git a/Documentation/config.txt b/Documentation/config.txt
index 3d8f03d..bb4d6e0 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -259,7 +259,8 @@ Common unit suffixes of 'k', 'm', or 'g' are supporte=
d.
 core.excludeFile::
 	In addition to '.gitignore' (per-directory) and
 	'.git/info/exclude', git looks into this file for patterns
-	of files which are not meant to be tracked.
+	of files which are not meant to be tracked.  See
+	gitlink:gitignore[5].
=20
 alias.*::
 	Command aliases for the gitlink:git[1] command wrapper - e.g.
diff --git a/Documentation/git-ls-files.txt b/Documentation/git-ls-files.=
txt
index 43e0d22..a78a9ff 100644
--- a/Documentation/git-ls-files.txt
+++ b/Documentation/git-ls-files.txt
@@ -139,46 +139,24 @@ Exclude Patterns
=20
 'git-ls-files' can use a list of "exclude patterns" when
 traversing the directory tree and finding files to show when the
-flags --others or --ignored are specified.
+flags --others or --ignored are specified.  gitlink:gitignore[5]
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
diff --git a/Documentation/repository-layout.txt b/Documentation/reposito=
ry-layout.txt
index 0459bd9..15221b5 100644
--- a/Documentation/repository-layout.txt
+++ b/Documentation/repository-layout.txt
@@ -155,8 +155,7 @@ info/exclude::
 	exclude pattern list. `.gitignore` is the per-directory
 	ignore file.  `git status`, `git add`, `git rm` and `git
 	clean` look at it but the core git commands do not look
-	at it.  See also: gitlink:git-ls-files[1] `--exclude-from`
-	and `--exclude-per-directory`.
+	at it.  See also: gitlink:gitignore[5].
=20
 remotes::
 	Stores shorthands to be used to give URL and default
diff --git a/Documentation/user-manual.txt b/Documentation/user-manual.tx=
t
index 4fabb8e..7eaafa8 100644
--- a/Documentation/user-manual.txt
+++ b/Documentation/user-manual.txt
@@ -1103,12 +1103,12 @@ showing up in the output of "`git status`", etc.
=20
 Git therefore provides "exclude patterns" for telling git which files to=

 actively ignore. Exclude patterns are thoroughly explained in the
-"Exclude Patterns" section of the gitlink:git-ls-files[1] manual page,
-but the heart of the concept is simply a list of files which git should
-ignore. Entries in the list may contain globs to specify multiple files,=

-or may be prefixed by "`!`" to explicitly include (un-ignore) a previous=
ly
-excluded (ignored) file (i.e. later exclude patterns override earlier on=
es).
-The following example should illustrate such patterns:
+gitlink:gitignore[5] manual page, but the heart of the concept is simply=

+a list of files which git should ignore. Entries in the list may contain=

+globs to specify multiple files, or may be prefixed by "`!`" to
+explicitly include (un-ignore) a previously excluded (ignored) file
+(i.e. later exclude patterns override earlier ones).  The following
+example should illustrate such patterns:
=20
 -------------------------------------------------
 # Lines starting with '#' are considered comments.
--=20
1.5.2



--------------enigA862222891DD69D403B6C9E7
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFGYJvEGJuZRtD+evsRAmePAJ0YjtVe9UqORwNjLl9zteX+l71F5QCeKr4M
xPJJrGtOcsvdgLrdU2hyglI=
=/cOQ
-----END PGP SIGNATURE-----

--------------enigA862222891DD69D403B6C9E7--
