From: Gustav =?utf-8?b?SMOlbGxiZXJn?= <gustav@gmail.com>
Subject: [PATCH 2/2] edit: Allow setting git tree of a patch
Date: Mon, 24 May 2010 20:52:28 +0200
Message-ID: <20100524185228.30884.50567.stgit@sambuntu>
References: <20100524184908.30884.65042.stgit@sambuntu>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: David =?utf-8?q?K=C3=A5gedal?= <davidk@lysator.liu.se>,
	kha@treskal.com, git@vger.kernel.org
To: Catalin Marinas <catalin.marinas@gmail.com>
X-From: git-owner@vger.kernel.org Mon May 24 20:52:42 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OGclT-0006Nj-Jb
	for gcvg-git-2@lo.gmane.org; Mon, 24 May 2010 20:52:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755807Ab0EXSwf convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 24 May 2010 14:52:35 -0400
Received: from mail-wy0-f174.google.com ([74.125.82.174]:45381 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755623Ab0EXSwd (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 24 May 2010 14:52:33 -0400
Received: by mail-wy0-f174.google.com with SMTP id 29so1784268wyb.19
        for <git@vger.kernel.org>; Mon, 24 May 2010 11:52:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:subject:to:from:cc:date
         :message-id:in-reply-to:references:user-agent:mime-version
         :content-type:content-transfer-encoding;
        bh=YAdW/Z7JaN/HDzQQEAkNxNGVDh3BKO49p1TIzMRAyt8=;
        b=HWdKINi3qbLu4pKeL5BysZ3xwHCCaV0IFnekT3/LsOoo+7Dk7iUIT/3waGUrMYsqZZ
         2q7OO+QRf0zPF0ntod1fzOcD+tu6l1168WyAn4gV9zFpkBt5n61m0FSlLl0PP7gX+qY/
         5RJlkJm7M3E9Ny10QGAPWgCLn9D2QALcwNqik=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=subject:to:from:cc:date:message-id:in-reply-to:references
         :user-agent:mime-version:content-type:content-transfer-encoding;
        b=CoJZzFQISRpzISig2qEWg9cstazeKjBOfdtybVGKYV+IdiUlVTPtirK37BCJv/EqJW
         qCxhNq5WpfnOElCeMjBU8dxsMVKNYbYhMjTeE/cxV5tn73FRZC9uindBtqWW81yLSrnT
         0ShmAlSNcmmLjJLrOGWOhKFqDdl27u1Cx75KI=
Received: by 10.216.88.133 with SMTP id a5mr3678454wef.192.1274727152825;
        Mon, 24 May 2010 11:52:32 -0700 (PDT)
Received: from [127.0.1.1] (c-97d7e255.66-15-64736c12.cust.bredbandsbolaget.se [85.226.215.151])
        by mx.google.com with ESMTPS id 14sm2082772ewy.2.2010.05.24.11.52.31
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Mon, 24 May 2010 11:52:32 -0700 (PDT)
In-Reply-To: <20100524184908.30884.65042.stgit@sambuntu>
User-Agent: StGit/0.15-96-g5d79
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/147641>

Also fix capitalization in edit's short description.

Signed-off-by: Gustav H=C3=A5llberg <gustav@gmail.com>
---
 stgit/commands/edit.py |   39 ++++++++++++++++++++++++++++-----------
 t/t3300-edit.sh        |   15 +++++++++++++++
 2 files changed, 43 insertions(+), 11 deletions(-)

diff --git a/stgit/commands/edit.py b/stgit/commands/edit.py
index f3f731f..79335d0 100644
--- a/stgit/commands/edit.py
+++ b/stgit/commands/edit.py
@@ -24,7 +24,7 @@ from stgit.commands import common
 from stgit.lib import git as gitlib, transaction, edit
 from stgit.out import *
=20
-help =3D 'edit a patch description or diff'
+help =3D 'Edit a patch description or diff'
 kind =3D 'patch'
 usage =3D ['[options] [--] [<patch>]']
 description =3D """
@@ -52,18 +52,28 @@ invoked even if such command-line options are given=
=2E)
=20
 If the patch diff is edited but does not apply, no changes are made to
 the patch at all. The edited patch is saved to a file which you can
-feed to "stg edit --file", once you have made sure it does apply."""
+feed to "stg edit --file", once you have made sure it does apply.
+
+With --set-tree you set the git tree of the patch to the specified
+TREE-ISH without changing the tree of any other patches. When used on
+the top patch, the index and work tree will be updated to match the
+tree.  This low-level option is primarily meant to be used by tools
+built on top of StGit, such as the Emacs mode. See also the --set-tree
+flag of stg push."""
=20
 args =3D [argparse.applied_patches, argparse.unapplied_patches,
         argparse.hidden_patches]
-options =3D [
-    opt('-d', '--diff', action =3D 'store_true',
-        short =3D 'Edit the patch diff'),
-    opt('-e', '--edit', action =3D 'store_true',
-        short =3D 'Invoke interactive editor'),
-    ] + (argparse.sign_options() +
-         argparse.message_options(save_template =3D True) +
-         argparse.author_options() + argparse.diff_opts_option())
+options =3D (
+    [ opt('-d', '--diff', action =3D 'store_true',
+          short =3D 'Edit the patch diff'),
+      opt('-e', '--edit', action =3D 'store_true',
+          short =3D 'Invoke interactive editor') ] +
+    argparse.sign_options() +
+    argparse.message_options(save_template =3D True) +
+    argparse.author_options() + argparse.diff_opts_option() +
+    [ opt('-t', '--set-tree', action =3D 'store',
+          metavar =3D 'TREE-ISH',
+          short =3D 'Set the git tree of the patch to TREE-ISH') ])
=20
 directory =3D common.DirectoryHasRepositoryLib()
=20
@@ -86,6 +96,10 @@ def func(parser, options, args):
=20
     cd =3D orig_cd =3D stack.patches.get(patchname).commit.data
=20
+    if options.set_tree:
+        cd =3D cd.set_tree(stack.repository.rev_parse(
+                options.set_tree, discard_stderr =3D True, object_type=
 =3D 'tree'))
+
     cd, failed_diff =3D edit.auto_edit_patch(
         stack.repository, cd, msg =3D options.message, contains_diff =3D=
 True,
         author =3D options.author, committer =3D lambda p: p,
@@ -128,7 +142,10 @@ def func(parser, options, args):
     trans.patches[patchname] =3D stack.repository.commit(cd)
     try:
         for pn in popped:
-            trans.push_patch(pn, iw, allow_interactive =3D True)
+            if options.set_tree:
+                trans.push_tree(pn)
+            else:
+                trans.push_patch(pn, iw, allow_interactive =3D True)
     except transaction.TransactionHalted:
         pass
     try:
diff --git a/t/t3300-edit.sh b/t/t3300-edit.sh
index 7003a27..09a2f25 100755
--- a/t/t3300-edit.sh
+++ b/t/t3300-edit.sh
@@ -212,4 +212,19 @@ test_expect_failure 'Fail to set invalid author da=
te' '
     test "$(date HEAD)" =3D "2013-01-28 22:30:00 -0300"
 '
=20
+test_expect_success 'Set patch tree' '
+    p2tree=3D$(git log -1 --pretty=3Dformat:%T $(stg id p2)) &&
+    p4commit=3D$(stg id p4) &&
+    stg edit --set-tree $p4commit &&
+    test $(git write-tree) =3D $(git rev-parse ${p4commit}^{tree}) &&
+    grep "^333zz$" foo &&
+    stg pop &&
+    stg edit --set-tree $p2tree p2 &&
+    stg push --set-tree &&
+    test $(git write-tree) =3D $p2tree &&
+    grep "^333$" foo &&
+    stg edit --set-tree $p2tree p1 &&
+    test "$(echo $(stg series --empty --all))" =3D "+ p1 0> p2 - p3 ! =
p4"
+'
+
 test_done
