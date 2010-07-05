From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: [RFC/PATCH 1/3] Documentation: split off rev doc into include file
Date: Mon,  5 Jul 2010 18:11:39 +0200
Message-ID: <de012c816a5ead592e51e2aa26257ba3ef41a79a.1278346173.git.git@drmicha.warpmail.net>
References: <cover.1278346173.git.git@drmicha.warpmail.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jul 05 18:12:58 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OVoHx-0006e5-AR
	for gcvg-git-2@lo.gmane.org; Mon, 05 Jul 2010 18:12:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753914Ab0GEQMg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 5 Jul 2010 12:12:36 -0400
Received: from out3.smtp.messagingengine.com ([66.111.4.27]:44443 "EHLO
	out3.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753857Ab0GEQMf (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 5 Jul 2010 12:12:35 -0400
Received: from compute2.internal (compute2.internal [10.202.2.42])
	by gateway1.messagingengine.com (Postfix) with ESMTP id A641711AAC2
	for <git@vger.kernel.org>; Mon,  5 Jul 2010 12:12:34 -0400 (EDT)
Received: from heartbeat1.messagingengine.com ([10.202.2.160])
  by compute2.internal (MEProxy); Mon, 05 Jul 2010 12:12:34 -0400
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=messagingengine.com; h=from:to:subject:date:message-id:in-reply-to:references; s=smtpout; bh=nPcBJTSDYc1cFCf7WHj2Ljo/7l0=; b=IwPJKDJHeDplKTWOFzidWzwoJgxUox2svVTLpru+0z5hRhzCcGR2o8/hCUARn2jmbutmU4dFu1t0AMKqpondDuPn5Jj6Q+fTp9fFOLJvbNEBIvhjTDyL7Tqw+AzQTLs9Q4XgthMcNVskvdKKcDvCojd6ZZc4vUqAPZv/X+GCI8A=
X-Sasl-enc: qFhtnlU4uB+Lu76OCMf0ewil89jLB6NKGxUreAHuHhz2 1278346353
Received: from localhost (whitehead.math.tu-clausthal.de [139.174.44.12])
	by mail.messagingengine.com (Postfix) with ESMTPSA id A9E3B4E1711;
	Mon,  5 Jul 2010 12:12:33 -0400 (EDT)
X-Mailer: git-send-email 1.7.1.621.g01d76
In-Reply-To: <cover.1278346173.git.git@drmicha.warpmail.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/150275>

Currently, the documentation for revisions and ranges sits in the
git-rev-parse man page, i.e. a plumbing man page, along with the
documentation of all rev-parse modes.

Split off the revisions and ranges section into an included file to
prepare for restructuring.

Signed-off-by: Michael J Gruber <git@drmicha.warpmail.net>
---
 Documentation/git-rev-parse.txt |  200 +--------------------------------------
 Documentation/revisions.txt     |  199 ++++++++++++++++++++++++++++++++++++++
 2 files changed, 200 insertions(+), 199 deletions(-)
 create mode 100644 Documentation/revisions.txt

diff --git a/Documentation/git-rev-parse.txt b/Documentation/git-rev-parse.txt
index 833a2a2..0727f43 100644
--- a/Documentation/git-rev-parse.txt
+++ b/Documentation/git-rev-parse.txt
@@ -174,205 +174,7 @@ shown.  If the pattern does not contain a globbing character (`?`,
 	Flags and parameters to be parsed.
 
 
-SPECIFYING REVISIONS
---------------------
-
-A revision parameter typically, but not necessarily, names a
-commit object.  They use what is called an 'extended SHA1'
-syntax.  Here are various ways to spell object names.  The
-ones listed near the end of this list are to name trees and
-blobs contained in a commit.
-
-* The full SHA1 object name (40-byte hexadecimal string), or
-  a substring of such that is unique within the repository.
-  E.g. dae86e1950b1277e545cee180551750029cfe735 and dae86e both
-  name the same commit object if there are no other object in
-  your repository whose object name starts with dae86e.
-
-* An output from 'git describe'; i.e. a closest tag, optionally
-  followed by a dash and a number of commits, followed by a dash, a
-  `g`, and an abbreviated object name.
-
-* A symbolic ref name.  E.g. 'master' typically means the commit
-  object referenced by refs/heads/master.  If you
-  happen to have both heads/master and tags/master, you can
-  explicitly say 'heads/master' to tell git which one you mean.
-  When ambiguous, a `<name>` is disambiguated by taking the
-  first match in the following rules:
-
-  . if `$GIT_DIR/<name>` exists, that is what you mean (this is usually
-    useful only for `HEAD`, `FETCH_HEAD`, `ORIG_HEAD` and `MERGE_HEAD`);
-
-  . otherwise, `refs/<name>` if exists;
-
-  . otherwise, `refs/tags/<name>` if exists;
-
-  . otherwise, `refs/heads/<name>` if exists;
-
-  . otherwise, `refs/remotes/<name>` if exists;
-
-  . otherwise, `refs/remotes/<name>/HEAD` if exists.
-+
-HEAD names the commit your changes in the working tree is based on.
-FETCH_HEAD records the branch you fetched from a remote repository
-with your last 'git fetch' invocation.
-ORIG_HEAD is created by commands that moves your HEAD in a drastic
-way, to record the position of the HEAD before their operation, so that
-you can change the tip of the branch back to the state before you ran
-them easily.
-MERGE_HEAD records the commit(s) you are merging into your branch
-when you run 'git merge'.
-+
-Note that any of the `refs/*` cases above may come either from
-the `$GIT_DIR/refs` directory or from the `$GIT_DIR/packed-refs` file.
-
-* A ref followed by the suffix '@' with a date specification
-  enclosed in a brace
-  pair (e.g. '\{yesterday\}', '\{1 month 2 weeks 3 days 1 hour 1
-  second ago\}' or '\{1979-02-26 18:30:00\}') to specify the value
-  of the ref at a prior point in time.  This suffix may only be
-  used immediately following a ref name and the ref must have an
-  existing log ($GIT_DIR/logs/<ref>). Note that this looks up the state
-  of your *local* ref at a given time; e.g., what was in your local
-  `master` branch last week. If you want to look at commits made during
-  certain times, see `--since` and `--until`.
-
-* A ref followed by the suffix '@' with an ordinal specification
-  enclosed in a brace pair (e.g. '\{1\}', '\{15\}') to specify
-  the n-th prior value of that ref.  For example 'master@\{1\}'
-  is the immediate prior value of 'master' while 'master@\{5\}'
-  is the 5th prior value of 'master'. This suffix may only be used
-  immediately following a ref name and the ref must have an existing
-  log ($GIT_DIR/logs/<ref>).
-
-* You can use the '@' construct with an empty ref part to get at a
-  reflog of the current branch. For example, if you are on the
-  branch 'blabla', then '@\{1\}' means the same as 'blabla@\{1\}'.
-
-* The special construct '@\{-<n>\}' means the <n>th branch checked out
-  before the current one.
-
-* The suffix '@\{upstream\}' to a ref (short form 'ref@\{u\}') refers to
-  the branch the ref is set to build on top of.  Missing ref defaults
-  to the current branch.
-
-* A suffix '{caret}' to a revision parameter (e.g. 'HEAD{caret}') means the first parent of
-  that commit object.  '{caret}<n>' means the <n>th parent (i.e.
-  'rev{caret}'
-  is equivalent to 'rev{caret}1').  As a special rule,
-  'rev{caret}0' means the commit itself and is used when 'rev' is the
-  object name of a tag object that refers to a commit object.
-
-* A suffix '{tilde}<n>' to a revision parameter means the commit
-  object that is the <n>th generation grand-parent of the named
-  commit object, following only the first parent.  I.e. rev~3 is
-  equivalent to rev{caret}{caret}{caret} which is equivalent to
-  rev{caret}1{caret}1{caret}1.  See below for a illustration of
-  the usage of this form.
-
-* A suffix '{caret}' followed by an object type name enclosed in
-  brace pair (e.g. `v0.99.8{caret}\{commit\}`) means the object
-  could be a tag, and dereference the tag recursively until an
-  object of that type is found or the object cannot be
-  dereferenced anymore (in which case, barf).  `rev{caret}0`
-  introduced earlier is a short-hand for `rev{caret}\{commit\}`.
-
-* A suffix '{caret}' followed by an empty brace pair
-  (e.g. `v0.99.8{caret}\{\}`) means the object could be a tag,
-  and dereference the tag recursively until a non-tag object is
-  found.
-
-* A colon, followed by a slash, followed by a text (e.g. `:/fix nasty bug`): this names
-  a commit whose commit message starts with the specified text.
-  This name returns the youngest matching commit which is
-  reachable from any ref.  If the commit message starts with a
-  '!', you have to repeat that;  the special sequence ':/!',
-  followed by something else than '!' is reserved for now.
-
-* A suffix ':' followed by a path (e.g. `HEAD:README`); this names the blob or tree
-  at the given path in the tree-ish object named by the part
-  before the colon.
-  ':path' (with an empty part before the colon, e.g. `:README`)
-  is a special case of the syntax described next: content
-  recorded in the index at the given path.
-
-* A colon, optionally followed by a stage number (0 to 3) and a
-  colon, followed by a path (e.g. `:0:README`); this names a blob object in the
-  index at the given path. Missing stage number (and the colon
-  that follows it, e.g. `:README`) names a stage 0 entry. During a merge, stage
-  1 is the common ancestor, stage 2 is the target branch's version
-  (typically the current branch), and stage 3 is the version from
-  the branch being merged.
-
-Here is an illustration, by Jon Loeliger.  Both commit nodes B
-and C are parents of commit node A.  Parent commits are ordered
-left-to-right.
-
-........................................
-G   H   I   J
- \ /     \ /
-  D   E   F
-   \  |  / \
-    \ | /   |
-     \|/    |
-      B     C
-       \   /
-        \ /
-         A
-........................................
-
-    A =      = A^0
-    B = A^   = A^1     = A~1
-    C = A^2  = A^2
-    D = A^^  = A^1^1   = A~2
-    E = B^2  = A^^2
-    F = B^3  = A^^3
-    G = A^^^ = A^1^1^1 = A~3
-    H = D^2  = B^^2    = A^^^2  = A~2^2
-    I = F^   = B^3^    = A^^3^
-    J = F^2  = B^3^2   = A^^3^2
-
-
-SPECIFYING RANGES
------------------
-
-History traversing commands such as 'git log' operate on a set
-of commits, not just a single commit.  To these commands,
-specifying a single revision with the notation described in the
-previous section means the set of commits reachable from that
-commit, following the commit ancestry chain.
-
-To exclude commits reachable from a commit, a prefix `{caret}`
-notation is used.  E.g. `{caret}r1 r2` means commits reachable
-from `r2` but exclude the ones reachable from `r1`.
-
-This set operation appears so often that there is a shorthand
-for it.  When you have two commits `r1` and `r2` (named according
-to the syntax explained in SPECIFYING REVISIONS above), you can ask
-for commits that are reachable from r2 excluding those that are reachable
-from r1 by `{caret}r1 r2` and it can be written as `r1..r2`.
-
-A similar notation `r1\...r2` is called symmetric difference
-of `r1` and `r2` and is defined as
-`r1 r2 --not $(git merge-base --all r1 r2)`.
-It is the set of commits that are reachable from either one of
-`r1` or `r2` but not from both.
-
-Two other shorthands for naming a set that is formed by a commit
-and its parent commits exist.  The `r1{caret}@` notation means all
-parents of `r1`.  `r1{caret}!` includes commit `r1` but excludes
-all of its parents.
-
-Here are a handful of examples:
-
-   D                G H D
-   D F              G H I J D F
-   ^G D             H D
-   ^D B             E I J F B
-   B...C            G H D E B C
-   ^D B C           E I J F B C
-   C^@              I J F
-   F^! D            G H D F
+include::revisions.txt[]
 
 PARSEOPT
 --------
diff --git a/Documentation/revisions.txt b/Documentation/revisions.txt
new file mode 100644
index 0000000..fe846f0
--- /dev/null
+++ b/Documentation/revisions.txt
@@ -0,0 +1,199 @@
+SPECIFYING REVISIONS
+--------------------
+
+A revision parameter typically, but not necessarily, names a
+commit object.  They use what is called an 'extended SHA1'
+syntax.  Here are various ways to spell object names.  The
+ones listed near the end of this list are to name trees and
+blobs contained in a commit.
+
+* The full SHA1 object name (40-byte hexadecimal string), or
+  a substring of such that is unique within the repository.
+  E.g. dae86e1950b1277e545cee180551750029cfe735 and dae86e both
+  name the same commit object if there are no other object in
+  your repository whose object name starts with dae86e.
+
+* An output from 'git describe'; i.e. a closest tag, optionally
+  followed by a dash and a number of commits, followed by a dash, a
+  `g`, and an abbreviated object name.
+
+* A symbolic ref name.  E.g. 'master' typically means the commit
+  object referenced by refs/heads/master.  If you
+  happen to have both heads/master and tags/master, you can
+  explicitly say 'heads/master' to tell git which one you mean.
+  When ambiguous, a `<name>` is disambiguated by taking the
+  first match in the following rules:
+
+  . if `$GIT_DIR/<name>` exists, that is what you mean (this is usually
+    useful only for `HEAD`, `FETCH_HEAD`, `ORIG_HEAD` and `MERGE_HEAD`);
+
+  . otherwise, `refs/<name>` if exists;
+
+  . otherwise, `refs/tags/<name>` if exists;
+
+  . otherwise, `refs/heads/<name>` if exists;
+
+  . otherwise, `refs/remotes/<name>` if exists;
+
+  . otherwise, `refs/remotes/<name>/HEAD` if exists.
++
+HEAD names the commit your changes in the working tree is based on.
+FETCH_HEAD records the branch you fetched from a remote repository
+with your last 'git fetch' invocation.
+ORIG_HEAD is created by commands that moves your HEAD in a drastic
+way, to record the position of the HEAD before their operation, so that
+you can change the tip of the branch back to the state before you ran
+them easily.
+MERGE_HEAD records the commit(s) you are merging into your branch
+when you run 'git merge'.
++
+Note that any of the `refs/*` cases above may come either from
+the `$GIT_DIR/refs` directory or from the `$GIT_DIR/packed-refs` file.
+
+* A ref followed by the suffix '@' with a date specification
+  enclosed in a brace
+  pair (e.g. '\{yesterday\}', '\{1 month 2 weeks 3 days 1 hour 1
+  second ago\}' or '\{1979-02-26 18:30:00\}') to specify the value
+  of the ref at a prior point in time.  This suffix may only be
+  used immediately following a ref name and the ref must have an
+  existing log ($GIT_DIR/logs/<ref>). Note that this looks up the state
+  of your *local* ref at a given time; e.g., what was in your local
+  `master` branch last week. If you want to look at commits made during
+  certain times, see `--since` and `--until`.
+
+* A ref followed by the suffix '@' with an ordinal specification
+  enclosed in a brace pair (e.g. '\{1\}', '\{15\}') to specify
+  the n-th prior value of that ref.  For example 'master@\{1\}'
+  is the immediate prior value of 'master' while 'master@\{5\}'
+  is the 5th prior value of 'master'. This suffix may only be used
+  immediately following a ref name and the ref must have an existing
+  log ($GIT_DIR/logs/<ref>).
+
+* You can use the '@' construct with an empty ref part to get at a
+  reflog of the current branch. For example, if you are on the
+  branch 'blabla', then '@\{1\}' means the same as 'blabla@\{1\}'.
+
+* The special construct '@\{-<n>\}' means the <n>th branch checked out
+  before the current one.
+
+* The suffix '@\{upstream\}' to a ref (short form 'ref@\{u\}') refers to
+  the branch the ref is set to build on top of.  Missing ref defaults
+  to the current branch.
+
+* A suffix '{caret}' to a revision parameter (e.g. 'HEAD{caret}') means the first parent of
+  that commit object.  '{caret}<n>' means the <n>th parent (i.e.
+  'rev{caret}'
+  is equivalent to 'rev{caret}1').  As a special rule,
+  'rev{caret}0' means the commit itself and is used when 'rev' is the
+  object name of a tag object that refers to a commit object.
+
+* A suffix '{tilde}<n>' to a revision parameter means the commit
+  object that is the <n>th generation grand-parent of the named
+  commit object, following only the first parent.  I.e. rev~3 is
+  equivalent to rev{caret}{caret}{caret} which is equivalent to
+  rev{caret}1{caret}1{caret}1.  See below for a illustration of
+  the usage of this form.
+
+* A suffix '{caret}' followed by an object type name enclosed in
+  brace pair (e.g. `v0.99.8{caret}\{commit\}`) means the object
+  could be a tag, and dereference the tag recursively until an
+  object of that type is found or the object cannot be
+  dereferenced anymore (in which case, barf).  `rev{caret}0`
+  introduced earlier is a short-hand for `rev{caret}\{commit\}`.
+
+* A suffix '{caret}' followed by an empty brace pair
+  (e.g. `v0.99.8{caret}\{\}`) means the object could be a tag,
+  and dereference the tag recursively until a non-tag object is
+  found.
+
+* A colon, followed by a slash, followed by a text (e.g. `:/fix nasty bug`): this names
+  a commit whose commit message starts with the specified text.
+  This name returns the youngest matching commit which is
+  reachable from any ref.  If the commit message starts with a
+  '!', you have to repeat that;  the special sequence ':/!',
+  followed by something else than '!' is reserved for now.
+
+* A suffix ':' followed by a path (e.g. `HEAD:README`); this names the blob or tree
+  at the given path in the tree-ish object named by the part
+  before the colon.
+  ':path' (with an empty part before the colon, e.g. `:README`)
+  is a special case of the syntax described next: content
+  recorded in the index at the given path.
+
+* A colon, optionally followed by a stage number (0 to 3) and a
+  colon, followed by a path (e.g. `:0:README`); this names a blob object in the
+  index at the given path. Missing stage number (and the colon
+  that follows it, e.g. `:README`) names a stage 0 entry. During a merge, stage
+  1 is the common ancestor, stage 2 is the target branch's version
+  (typically the current branch), and stage 3 is the version from
+  the branch being merged.
+
+Here is an illustration, by Jon Loeliger.  Both commit nodes B
+and C are parents of commit node A.  Parent commits are ordered
+left-to-right.
+
+........................................
+G   H   I   J
+ \ /     \ /
+  D   E   F
+   \  |  / \
+    \ | /   |
+     \|/    |
+      B     C
+       \   /
+        \ /
+         A
+........................................
+
+    A =      = A^0
+    B = A^   = A^1     = A~1
+    C = A^2  = A^2
+    D = A^^  = A^1^1   = A~2
+    E = B^2  = A^^2
+    F = B^3  = A^^3
+    G = A^^^ = A^1^1^1 = A~3
+    H = D^2  = B^^2    = A^^^2  = A~2^2
+    I = F^   = B^3^    = A^^3^
+    J = F^2  = B^3^2   = A^^3^2
+
+
+SPECIFYING RANGES
+-----------------
+
+History traversing commands such as 'git log' operate on a set
+of commits, not just a single commit.  To these commands,
+specifying a single revision with the notation described in the
+previous section means the set of commits reachable from that
+commit, following the commit ancestry chain.
+
+To exclude commits reachable from a commit, a prefix `{caret}`
+notation is used.  E.g. `{caret}r1 r2` means commits reachable
+from `r2` but exclude the ones reachable from `r1`.
+
+This set operation appears so often that there is a shorthand
+for it.  When you have two commits `r1` and `r2` (named according
+to the syntax explained in SPECIFYING REVISIONS above), you can ask
+for commits that are reachable from r2 excluding those that are reachable
+from r1 by `{caret}r1 r2` and it can be written as `r1..r2`.
+
+A similar notation `r1\...r2` is called symmetric difference
+of `r1` and `r2` and is defined as
+`r1 r2 --not $(git merge-base --all r1 r2)`.
+It is the set of commits that are reachable from either one of
+`r1` or `r2` but not from both.
+
+Two other shorthands for naming a set that is formed by a commit
+and its parent commits exist.  The `r1{caret}@` notation means all
+parents of `r1`.  `r1{caret}!` includes commit `r1` but excludes
+all of its parents.
+
+Here are a handful of examples:
+
+   D                G H D
+   D F              G H I J D F
+   ^G D             H D
+   ^D B             E I J F B
+   B...C            G H D E B C
+   ^D B C           E I J F B C
+   C^@              I J F
+   F^! D            G H D F
-- 
1.7.1.621.g01d76
