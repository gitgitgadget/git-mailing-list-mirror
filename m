From: Catalin Marinas <catalin.marinas@gmail.com>
Subject: Re: [StGit PATCH] Add the --merged option to goto
Date: Mon, 23 Mar 2009 16:33:04 +0000
Message-ID: <b0943d9e0903230933n5b71a53elcfaa13f00883861d@mail.gmail.com>
References: <20090320161233.28989.82497.stgit@pc1117.cambridge.arm.com>
	 <20090323084507.GA6447@diana.vm.bytemark.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: =?ISO-8859-1?Q?Karl_Hasselstr=F6m?= <kha@treskal.com>
X-From: git-owner@vger.kernel.org Mon Mar 23 17:35:47 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Lln7l-0002Xa-Dh
	for gcvg-git-2@gmane.org; Mon, 23 Mar 2009 17:35:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758595AbZCWQdN convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 23 Mar 2009 12:33:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758537AbZCWQdL
	(ORCPT <rfc822;git-outgoing>); Mon, 23 Mar 2009 12:33:11 -0400
Received: from mail-fx0-f158.google.com ([209.85.220.158]:41720 "EHLO
	mail-fx0-f158.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758479AbZCWQdI convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 23 Mar 2009 12:33:08 -0400
Received: by fxm2 with SMTP id 2so1880374fxm.37
        for <git@vger.kernel.org>; Mon, 23 Mar 2009 09:33:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=BsjKiyeP78sxLgmcEHO5Qo9osVl8GxTFwCcwyFQJpts=;
        b=ZC4wsqKBcHix2Q3RnvOaady40z2bEz8sXkHYPvaj6CGn5Di9U1LqxRIoYTgufbHEGm
         YEIsrq9ZXdU1ciH4jFcb3AxOVdQ4RUrEeQ6Ggn1yRQLUlgfccUC8+D34jASVRgztPjFG
         BC45nT6kiJfB8C9fe2CW3EQ4l+/QUDvlJXFs0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=kCDHUJVa4JdlBB0TEd9nd/+PQbjwwgFMY6AkE+Cr7MfOiyjcIyIq2IywzxZXoPbfgb
         3GaeGt+M6tb8zhGv32tcdM52jiiAYGHRGBQHNSWFxP5+VN4uL2KKd1Xsdj7md81KAB2d
         Lv7UglmhXECl07hdYgCG109he6++aAWX2Jkfg=
Received: by 10.204.100.71 with SMTP id x7mr2564142bkn.130.1237825984976; Mon, 
	23 Mar 2009 09:33:04 -0700 (PDT)
In-Reply-To: <20090323084507.GA6447@diana.vm.bytemark.co.uk>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/114332>

2009/3/23 Karl Hasselstr=F6m <kha@treskal.com>:
> On 2009-03-20 16:15:45 +0000, Catalin Marinas wrote:
>> @@ -752,12 +752,13 @@ class Index(RunWithEnv):
>> =A0 =A0 =A0 =A0 =A0assert current =3D=3D None or isinstance(current,=
 Tree)
>>
>> =A0 =A0 =A0 =A0 =A0# Take care of the really trivial cases.
>> - =A0 =A0 =A0 =A0if base =3D=3D ours:
>> - =A0 =A0 =A0 =A0 =A0 =A0return (theirs, current)
>> - =A0 =A0 =A0 =A0if base =3D=3D theirs:
>> - =A0 =A0 =A0 =A0 =A0 =A0return (ours, current)
>> - =A0 =A0 =A0 =A0if ours =3D=3D theirs:
>> - =A0 =A0 =A0 =A0 =A0 =A0return (ours, current)
>> + =A0 =A0 =A0 =A0if check_trivial:
>> + =A0 =A0 =A0 =A0 =A0 =A0if base =3D=3D ours:
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0return (theirs, current)
>> + =A0 =A0 =A0 =A0 =A0 =A0if base =3D=3D theirs:
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0return (ours, current)
>> + =A0 =A0 =A0 =A0 =A0 =A0if ours =3D=3D theirs:
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0return (ours, current)
>
> Uh, what? What's the point of not doing this unconditionally?

There are a few cases where my algorithm failed because the reverse
applying of patches fell on one of those special cases (otherwise they
wouldn't apply). The check_merged() function assumes that if a patch
can be reversed in a given tree, it was already included in that tree.

Let's assume that the tree corresponding to the top patch is T1. We
have the following cases for reverse-applying a patch which fall under
the trivial cases above (patch expressed as bottom_tree..top_tree):

The empty patch cases should be ignored from such test (not done curren=
tly):

T1..T1 =3D> merge(T1, T1, T1) =3D=3D T1
T2..T2 =3D> merge(T2, T1, T2) =3D=3D T1

The non-empty patch situations:

T1..T2 =3D> merge(T2, T1, T1) =3D=3D T1
T2..T1 =3D> merge(T1, T1, T2) =3D=3D T2

The T1..T2 is pretty common and happens when the base of a patch
wasn't modified. Reverse-applying such patch should not normally
succeed but the merge() here uses one of those special cases. The
merge() result is correct since we want two trees merged, T1 and T1,
with a common base, T2, used a helper.

The T2..T1 cases would succeed with both trivial checks and
apply_treediff() and that's probably OK since if a patch generates the
same tree when applied, the changes it makes were probably already
included.

Now I understand it better :-). Reading my explanation above, it seems
that only the T1..T2 case matters and it can be taken care of in the
check_merged() function. Checking whether the tree returned by merge()
is different than "ours" should be enough for all the above cases.

>> @@ -379,3 +385,25 @@ class StackTransaction(object):
>> =A0 =A0 =A0 =A0 =A0assert set(self.unapplied + self.hidden) =3D=3D s=
et(unapplied + hidden)
>> =A0 =A0 =A0 =A0 =A0self.unapplied =3D unapplied
>> =A0 =A0 =A0 =A0 =A0self.hidden =3D hidden
>> +
>> + =A0 =A0def check_merged(self, patches):
>> + =A0 =A0 =A0 =A0"""Return a subset of patches already merged."""
>> + =A0 =A0 =A0 =A0merged =3D []
>> + =A0 =A0 =A0 =A0temp_index =3D self.__stack.repository.temp_index()
>> + =A0 =A0 =A0 =A0temp_index_tree =3D None
>
> There's no need to create a new temp index here. The transaction
> object already has one.

I had the impression that an Index object would hold some state and
didn't want to break it. It seems OK to use as long as I don't touch
self.temp_index_tree. See below for an updated patch:


Add the --merged option to goto

=46rom: Catalin Marinas <catalin.marinas@gmail.com>

This patch adds support for checking which patches were already merged
upstream. This checking is done by trying to reverse-apply the patches
in the index before pushing them onto the stack.

Signed-off-by: Catalin Marinas <catalin.marinas@gmail.com>
---
 stgit/argparse.py        |    4 ++++
 stgit/commands/goto.py   |   12 +++++++++---
 stgit/lib/git.py         |    2 +-
 stgit/lib/transaction.py |   38 +++++++++++++++++++++++++++++++-------
 4 files changed, 45 insertions(+), 11 deletions(-)

diff --git a/stgit/argparse.py b/stgit/argparse.py
index 85ee6e3..765579c 100644
--- a/stgit/argparse.py
+++ b/stgit/argparse.py
@@ -225,6 +225,10 @@ def keep_option():
                 short =3D 'Keep the local changes',
                 default =3D config.get('stgit.autokeep') =3D=3D 'yes')=
]

+def merged_option():
+    return [opt('-m', '--merged', action =3D 'store_true',
+                short =3D 'Check for patches merged upstream')]
+
 class CompgenBase(object):
     def actions(self, var): return set()
     def words(self, var): return set()
diff --git a/stgit/commands/goto.py b/stgit/commands/goto.py
index 66f49df..839b75c 100644
--- a/stgit/commands/goto.py
+++ b/stgit/commands/goto.py
@@ -28,7 +28,7 @@ Push/pop patches to/from the stack until the one
given on the command
 line becomes current."""

 args =3D [argparse.other_applied_patches, argparse.unapplied_patches]
-options =3D argparse.keep_option()
+options =3D argparse.keep_option() + argparse.merged_option()

 directory =3D common.DirectoryHasRepositoryLib()

@@ -47,8 +47,14 @@ def func(parser, options, args):
         assert not trans.pop_patches(lambda pn: pn in to_pop)
     elif patch in trans.unapplied:
         try:
-            for pn in trans.unapplied[:trans.unapplied.index(patch)+1]=
:
-                trans.push_patch(pn, iw, allow_interactive =3D True)
+            to_push =3D trans.unapplied[:trans.unapplied.index(patch)+=
1]
+            if options.merged:
+                merged =3D set(trans.check_merged(to_push))
+            else:
+                merged =3D set()
+            for pn in to_push:
+                trans.push_patch(pn, iw, allow_interactive =3D True,
+                                 already_merged =3D pn in merged)
         except transaction.TransactionHalted:
             pass
     elif patch in trans.hidden:
diff --git a/stgit/lib/git.py b/stgit/lib/git.py
index e0a3c96..fcac918 100644
--- a/stgit/lib/git.py
+++ b/stgit/lib/git.py
@@ -732,7 +732,7 @@ class Index(RunWithEnv):
         # to use --binary.
         self.apply(self.__repository.diff_tree(tree1, tree2, ['--full-=
index']),
                    quiet)
-    def merge(self, base, ours, theirs, current =3D None):
+    def merge(self, base, ours, theirs, current =3D None, check_trivia=
l =3D True):
         """Use the index (and only the index) to do a 3-way merge of t=
he
         L{Tree}s C{base}, C{ours} and C{theirs}. The merge will either
         succeed (in which case the first half of the return value is
diff --git a/stgit/lib/transaction.py b/stgit/lib/transaction.py
index b146648..9fa75c1 100644
--- a/stgit/lib/transaction.py
+++ b/stgit/lib/transaction.py
@@ -297,7 +297,8 @@ class StackTransaction(object):
                     out.info('Deleted %s%s' % (pn, s))
         return popped

-    def push_patch(self, pn, iw =3D None, allow_interactive =3D False)=
:
+    def push_patch(self, pn, iw =3D None, allow_interactive =3D False,
+                   already_merged =3D False):
         """Attempt to push the named patch. If this results in conflic=
ts,
         halts the transaction. If index+worktree are given, spill any
         conflicts to them."""
@@ -305,11 +306,14 @@ class StackTransaction(object):
         cd =3D orig_cd.set_committer(None)
         oldparent =3D cd.parent
         cd =3D cd.set_parent(self.top)
-        base =3D oldparent.data.tree
-        ours =3D cd.parent.data.tree
-        theirs =3D cd.tree
-        tree, self.temp_index_tree =3D self.temp_index.merge(
-            base, ours, theirs, self.temp_index_tree)
+        if already_merged:
+            tree =3D cd.tree
+        else:
+            base =3D oldparent.data.tree
+            ours =3D cd.parent.data.tree
+            theirs =3D cd.tree
+            tree, self.temp_index_tree =3D self.temp_index.merge(
+                base, ours, theirs, self.temp_index_tree)
         s =3D ''
         merge_conflict =3D False
         if not tree:
@@ -341,7 +345,9 @@ class StackTransaction(object):
         else:
             comm =3D None
             s =3D ' (unmodified)'
-        if not merge_conflict and cd.is_nochange():
+        if already_merged:
+            s =3D ' (merged)'
+        elif not merge_conflict and cd.is_nochange():
             s =3D ' (empty)'
         out.info('Pushed %s%s' % (pn, s))
         def update():
@@ -379,3 +385,21 @@ class StackTransaction(object):
         assert set(self.unapplied + self.hidden) =3D=3D set(unapplied =
+ hidden)
         self.unapplied =3D unapplied
         self.hidden =3D hidden
+
+    def check_merged(self, patches):
+        """Return a subset of patches already merged."""
+        merged =3D []
+        temp_index_tree =3D None
+        ours =3D self.stack.head.data.tree
+        for pn in reversed(patches):
+            # check whether patch changes can be reversed in the curre=
nt tree
+            cd =3D self.patches[pn].data
+            base =3D cd.tree
+            theirs =3D cd.parent.data.tree
+            tree, temp_index_tree =3D \
+                    self.temp_index.merge(base, ours, theirs, temp_ind=
ex_tree,
+                                          check_trivial =3D False)
+            if tree and tree !=3D ours:
+                merged.append(pn)
+                ours =3D tree
+        return merged


--=20
Catalin
