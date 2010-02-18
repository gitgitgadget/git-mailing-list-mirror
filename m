From: Jeff King <peff@peff.net>
Subject: Re: Host refs to push are chosen (documentation error)?
Date: Wed, 17 Feb 2010 20:16:20 -0500
Message-ID: <20100218011620.GA15870@coredump.intra.peff.net>
References: <201002171627.57599.arvidjaar@mail.ru>
 <be6fef0d1002170539v4384b355lb6be3e2f19b7b87b@mail.gmail.com>
 <32541b131002170939l261f396cpbee45f652fd96c77@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Tay Ray Chuan <rctay89@gmail.com>,
	Andrey Borzenkov <arvidjaar@mail.ru>, git@vger.kernel.org
To: Avery Pennarun <apenwarr@gmail.com>
X-From: git-owner@vger.kernel.org Thu Feb 18 02:16:32 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Nhv0J-0002iY-3j
	for gcvg-git-2@lo.gmane.org; Thu, 18 Feb 2010 02:16:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753351Ab0BRBQY convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 17 Feb 2010 20:16:24 -0500
Received: from peff.net ([208.65.91.99]:49332 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751961Ab0BRBQX (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 17 Feb 2010 20:16:23 -0500
Received: (qmail 23671 invoked by uid 107); 18 Feb 2010 01:16:34 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Wed, 17 Feb 2010 20:16:34 -0500
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Wed, 17 Feb 2010 20:16:20 -0500
Content-Disposition: inline
In-Reply-To: <32541b131002170939l261f396cpbee45f652fd96c77@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/140275>

On Wed, Feb 17, 2010 at 12:39:23PM -0500, Avery Pennarun wrote:

> On Wed, Feb 17, 2010 at 8:39 AM, Tay Ray Chuan <rctay89@gmail.com> wr=
ote:
> > On Wed, Feb 17, 2010 at 9:27 PM, Andrey Borzenkov <arvidjaar@mail.r=
u> wrote:
> >> {pts/1}% l .git/refs/heads
> >> local-mdv =C2=A0local-mdv.stgit
> >
> > have you tried
> >
> > =C2=A0$ cat .git/packed-refs
> >
> > ?
>=20
> The documentation is still lying though :)

Agreed. It's a minor point, but one that can mislead users who don't
know about packed refs. Maybe something like this?

-- >8 --
Subject: [PATCH] docs: don't talk about $GIT_DIR/refs/ everywhere

It is somewhat misleading to say that we pull refs just from
$GIT_DIR/refs/*, because we may also consult the packed refs
mechanism. These days we tend to treat the "refs hierarchy"
as more of an abstract namespace that happens to be
represented as $GIT_DIR/refs. At best, this is a minor
inaccuracy, but at worst it can confuse users who then look
in $GIT_DIR/refs and find that it is missing some of the
refs they expected to see.

This patch drops most uses of "$GIT_DIR/refs/*", changing
them into just "refs/*", under the assumption that users can
handle the concept of an abstract refs namespace. There are
a few things to note:

  - most cases just dropped the $GIT_DIR/ portion. But for
    cases where that left _just_ the word "refs", I changed
    it to "refs/" to help indicate that it was a hierarchy.
    I didn't do the same for longer paths (e.g.,
    "refs/heads" remained, instead of becoming
    "refs/heads/").

  - in some cases, no change was made, as the text was
    explicitly about unpacked refs (e.g., the discussion in
    git-pack-refs).

  - In some cases it made sense instead to note the
    existence of packed refs (e.g., in check-ref-format and
    rev-parse).

Signed-off-by: Jeff King <peff@peff.net>
---
 Documentation/git-check-ref-format.txt |    5 +++--
 Documentation/git-clone.txt            |    2 +-
 Documentation/git-fetch-pack.txt       |    2 +-
 Documentation/git-pack-objects.txt     |    2 +-
 Documentation/git-prune.txt            |    2 +-
 Documentation/git-push.txt             |    6 +++---
 Documentation/git-rev-parse.txt        |   14 +++++++++-----
 Documentation/git-show-branch.txt      |   10 +++++-----
 Documentation/git-stash.txt            |    2 +-
 Documentation/rev-list-options.txt     |   22 +++++++++++-----------
 10 files changed, 36 insertions(+), 31 deletions(-)

diff --git a/Documentation/git-check-ref-format.txt b/Documentation/git=
-check-ref-format.txt
index e1c4320..379eee6 100644
--- a/Documentation/git-check-ref-format.txt
+++ b/Documentation/git-check-ref-format.txt
@@ -19,8 +19,9 @@ status if it is not.
=20
 A reference is used in git to specify branches and tags.  A
 branch head is stored under the `$GIT_DIR/refs/heads` directory, and
-a tag is stored under the `$GIT_DIR/refs/tags` directory.  git
-imposes the following rules on how references are named:
+a tag is stored under the `$GIT_DIR/refs/tags` directory (or, if refs
+are packed by `git gc`, as entries in the `$GIT_DIR/packed-refs` file)=
=2E
+git imposes the following rules on how references are named:
=20
 . They can include slash `/` for hierarchical (directory)
   grouping, but no slash-separated component can begin with a
diff --git a/Documentation/git-clone.txt b/Documentation/git-clone.txt
index f43c8b2..88ea624 100644
--- a/Documentation/git-clone.txt
+++ b/Documentation/git-clone.txt
@@ -29,7 +29,7 @@ arguments will in addition merge the remote master br=
anch into the
 current master branch, if any.
=20
 This default configuration is achieved by creating references to
-the remote branch heads under `$GIT_DIR/refs/remotes/origin` and
+the remote branch heads under `refs/remotes/origin` and
 by initializing `remote.origin.url` and `remote.origin.fetch`
 configuration variables.
=20
diff --git a/Documentation/git-fetch-pack.txt b/Documentation/git-fetch=
-pack.txt
index e9952e8..97ea797 100644
--- a/Documentation/git-fetch-pack.txt
+++ b/Documentation/git-fetch-pack.txt
@@ -18,7 +18,7 @@ higher level wrapper of this command, instead.
 Invokes 'git-upload-pack' on a possibly remote repository
 and asks it to send objects missing from this repository, to
 update the named heads.  The list of commits available locally
-is found out by scanning local $GIT_DIR/refs/ and sent to
+is found out by scanning the local refs/ hierarchy and sent to
 'git-upload-pack' running on the other end.
=20
 This command degenerates to download everything to complete the
diff --git a/Documentation/git-pack-objects.txt b/Documentation/git-pac=
k-objects.txt
index ffd5025..61fd7d0 100644
--- a/Documentation/git-pack-objects.txt
+++ b/Documentation/git-pack-objects.txt
@@ -73,7 +73,7 @@ base-name::
 --all::
 	This implies `--revs`.  In addition to the list of
 	revision arguments read from the standard input, pretend
-	as if all refs under `$GIT_DIR/refs` are specified to be
+	as if all refs under `refs/` are specified to be
 	included.
=20
 --include-tag::
diff --git a/Documentation/git-prune.txt b/Documentation/git-prune.txt
index 3bb7304..15cfb7a 100644
--- a/Documentation/git-prune.txt
+++ b/Documentation/git-prune.txt
@@ -17,7 +17,7 @@ NOTE: In most cases, users should run 'git gc', which=
 calls
 'git prune'. See the section "NOTES", below.
=20
 This runs 'git fsck --unreachable' using all the refs
-available in `$GIT_DIR/refs`, optionally with additional set of
+available in `refs/`, optionally with additional set of
 objects specified on the command line, and prunes all unpacked
 objects unreachable from any of these head objects from the object dat=
abase.
 In addition, it
diff --git a/Documentation/git-push.txt b/Documentation/git-push.txt
index bd79119..3f103cc 100644
--- a/Documentation/git-push.txt
+++ b/Documentation/git-push.txt
@@ -69,11 +69,11 @@ nor in any Push line of the corresponding remotes f=
ile---see below).
=20
 --all::
 	Instead of naming each ref to push, specifies that all
-	refs under `$GIT_DIR/refs/heads/` be pushed.
+	refs under `refs/heads/` be pushed.
=20
 --mirror::
 	Instead of naming each ref to push, specifies that all
-	refs under `$GIT_DIR/refs/` (which includes but is not
+	refs under `refs/` (which includes but is not
 	limited to `refs/heads/`, `refs/remotes/`, and `refs/tags/`)
 	be mirrored to the remote repository.  Newly created local
 	refs will be pushed to the remote end, locally updated refs
@@ -96,7 +96,7 @@ nor in any Push line of the corresponding remotes fil=
e---see below).
 	the same as prefixing all refs with a colon.
=20
 --tags::
-	All refs under `$GIT_DIR/refs/tags` are pushed, in
+	All refs under `refs/tags` are pushed, in
 	addition to refspecs explicitly listed on the command
 	line.
=20
diff --git a/Documentation/git-rev-parse.txt b/Documentation/git-rev-pa=
rse.txt
index d677c72..9ee006b 100644
--- a/Documentation/git-rev-parse.txt
+++ b/Documentation/git-rev-parse.txt
@@ -101,15 +101,14 @@ OPTIONS
 	abbreviation mode.
=20
 --all::
-	Show all refs found in `$GIT_DIR/refs`.
+	Show all refs found in `refs/`.
=20
 --branches[=3Dpattern]::
 --tags[=3Dpattern]::
 --remotes[=3Dpattern]::
 	Show all branches, tags, or remote-tracking branches,
-	respectively (i.e., refs found in `$GIT_DIR/refs/heads`,
-	`$GIT_DIR/refs/tags`, or `$GIT_DIR/refs/remotes`,
-	respectively).
+	respectively (i.e., refs found in `refs/heads`,
+	`refs/tags`, or `refs/remotes`, respectively).
 +
 If a `pattern` is given, only refs matching the given shell glob are
 shown.  If the pattern does not contain a globbing character (`?`,
@@ -189,7 +188,7 @@ blobs contained in a commit.
   `g`, and an abbreviated object name.
=20
 * A symbolic ref name.  E.g. 'master' typically means the commit
-  object referenced by $GIT_DIR/refs/heads/master.  If you
+  object referenced by refs/heads/master.  If you
   happen to have both heads/master and tags/master, you can
   explicitly say 'heads/master' to tell git which one you mean.
   When ambiguous, a `<name>` is disambiguated by taking the
@@ -217,6 +216,11 @@ you can change the tip of the branch back to the s=
tate before you ran
 them easily.
 MERGE_HEAD records the commit(s) you are merging into your branch
 when you run 'git merge'.
++
+For any of the `$GIT_DIR/refs` cases above, packed refs from
+`$GIT_DIR/packed-refs` may be substituted (e.g., a line with
+`refs/heads/master` in the packed-refs file would have the same
+precedence as the file `$GIT_DIR/refs/heads/master`).
=20
 * A ref followed by the suffix '@' with a date specification
   enclosed in a brace
diff --git a/Documentation/git-show-branch.txt b/Documentation/git-show=
-branch.txt
index 7343361..b9c4154 100644
--- a/Documentation/git-show-branch.txt
+++ b/Documentation/git-show-branch.txt
@@ -20,8 +20,8 @@ DESCRIPTION
 -----------
=20
 Shows the commit ancestry graph starting from the commits named
-with <rev>s or <globs>s (or all refs under $GIT_DIR/refs/heads
-and/or $GIT_DIR/refs/tags) semi-visually.
+with <rev>s or <globs>s (or all refs under refs/heads
+and/or refs/tags) semi-visually.
=20
 It cannot show more than 29 branches and commits at a time.
=20
@@ -37,8 +37,8 @@ OPTIONS
=20
 <glob>::
 	A glob pattern that matches branch or tag names under
-	$GIT_DIR/refs.  For example, if you have many topic
-	branches under $GIT_DIR/refs/heads/topic, giving
+	refs/.  For example, if you have many topic
+	branches under refs/heads/topic, giving
 	`topic/*` would show all of them.
=20
 -r::
@@ -176,7 +176,7 @@ EXAMPLE
 -------
=20
 If you keep your primary branches immediately under
-`$GIT_DIR/refs/heads`, and topic branches in subdirectories of
+`refs/heads`, and topic branches in subdirectories of
 it, having the following in the configuration file may help:
=20
 ------------
diff --git a/Documentation/git-stash.txt b/Documentation/git-stash.txt
index 84e555d..473889a 100644
--- a/Documentation/git-stash.txt
+++ b/Documentation/git-stash.txt
@@ -33,7 +33,7 @@ A stash is by default listed as "WIP on 'branchname' =
=2E..", but
 you can give a more descriptive message on the command line when
 you create one.
=20
-The latest stash you created is stored in `$GIT_DIR/refs/stash`; older
+The latest stash you created is stored in `refs/stash`; older
 stashes are found in the reflog of this reference and can be named usi=
ng
 the usual reflog syntax (e.g. `stash@\{0}` is the most recently
 created stash, `stash@\{1}` is the one before it, `stash@\{2.hours.ago=
}`
diff --git a/Documentation/rev-list-options.txt b/Documentation/rev-lis=
t-options.txt
index 6e9baf8..81c0e6f 100644
--- a/Documentation/rev-list-options.txt
+++ b/Documentation/rev-list-options.txt
@@ -225,26 +225,26 @@ endif::git-rev-list[]
=20
 --all::
=20
-	Pretend as if all the refs in `$GIT_DIR/refs/` are listed on the
+	Pretend as if all the refs in `refs/` are listed on the
 	command line as '<commit>'.
=20
 --branches[=3Dpattern]::
=20
-	Pretend as if all the refs in `$GIT_DIR/refs/heads` are listed
+	Pretend as if all the refs in `refs/heads` are listed
 	on the command line as '<commit>'. If `pattern` is given, limit
 	branches to ones matching given shell glob. If pattern lacks '?',
 	'*', or '[', '/*' at the end is implied.
=20
 --tags[=3Dpattern]::
=20
-	Pretend as if all the refs in `$GIT_DIR/refs/tags` are listed
+	Pretend as if all the refs in `refs/tags` are listed
 	on the command line as '<commit>'. If `pattern` is given, limit
 	tags to ones matching given shell glob. If pattern lacks '?', '*',
 	or '[', '/*' at the end is implied.
=20
 --remotes[=3Dpattern]::
=20
-	Pretend as if all the refs in `$GIT_DIR/refs/remotes` are listed
+	Pretend as if all the refs in `refs/remotes` are listed
 	on the command line as '<commit>'. If `pattern`is given, limit
 	remote tracking branches to ones matching given shell glob.
 	If pattern lacks '?', '*', or '[', '/*' at the end is implied.
@@ -259,9 +259,9 @@ endif::git-rev-list[]
 ifndef::git-rev-list[]
 --bisect::
=20
-	Pretend as if the bad bisection ref `$GIT_DIR/refs/bisect/bad`
+	Pretend as if the bad bisection ref `refs/bisect/bad`
 	was listed and as if it was followed by `--not` and the good
-	bisection refs `$GIT_DIR/refs/bisect/good-*` on the command
+	bisection refs `refs/bisect/good-*` on the command
 	line.
 endif::git-rev-list[]
=20
@@ -561,10 +561,10 @@ Bisection Helpers
=20
 Limit output to the one commit object which is roughly halfway between
 included and excluded commits. Note that the bad bisection ref
-`$GIT_DIR/refs/bisect/bad` is added to the included commits (if it
-exists) and the good bisection refs `$GIT_DIR/refs/bisect/good-*` are
+`refs/bisect/bad` is added to the included commits (if it
+exists) and the good bisection refs `refs/bisect/good-*` are
 added to the excluded commits (if they exist). Thus, supposing there
-are no refs in `$GIT_DIR/refs/bisect/`, if
+are no refs in `refs/bisect/`, if
=20
 ----------------------------------------------------------------------=
-
 	$ git rev-list --bisect foo ^bar ^baz
@@ -585,7 +585,7 @@ one.
 --bisect-vars::
=20
 This calculates the same as `--bisect`, except that refs in
-`$GIT_DIR/refs/bisect/` are not used, and except that this outputs
+`refs/bisect/` are not used, and except that this outputs
 text ready to be eval'ed by the shell. These lines will assign the
 name of the midpoint revision to the variable `bisect_rev`, and the
 expected number of commits to be tested after `bisect_rev` is tested
@@ -599,7 +599,7 @@ number of commits to be tested if `bisect_rev` turn=
s out to be bad to
=20
 This outputs all the commit objects between the included and excluded
 commits, ordered by their distance to the included and excluded
-commits. Refs in `$GIT_DIR/refs/bisect/` are not used. The farthest
+commits. Refs in `refs/bisect/` are not used. The farthest
 from them is displayed first. (This is the only one displayed by
 `--bisect`.)
 +
--=20
1.7.0.25.g1cf14
