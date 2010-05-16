From: Gustav =?utf-8?b?SMOlbGxiZXJn?= <gustav@gmail.com>
Subject: [StGit PATCH] edit: Allow setting git tree SHA1 of a patch
Date: Sun, 16 May 2010 19:33:53 +0200
Message-ID: <20100516172738.5043.94039.stgit@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: davidk@lysator.liu.se, kha@treskal.com
To: git@vger.kernel.org, catalin.marinas@gmail.com
X-From: git-owner@vger.kernel.org Sun May 16 19:34:26 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ODhjN-0004XW-Ng
	for gcvg-git-2@lo.gmane.org; Sun, 16 May 2010 19:34:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754115Ab0EPRd7 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 16 May 2010 13:33:59 -0400
Received: from mail-ew0-f216.google.com ([209.85.219.216]:44429 "EHLO
	mail-ew0-f216.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752518Ab0EPRd6 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 16 May 2010 13:33:58 -0400
Received: by ewy8 with SMTP id 8so1506975ewy.28
        for <git@vger.kernel.org>; Sun, 16 May 2010 10:33:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:subject:to:from:cc:date
         :message-id:user-agent:mime-version:content-type
         :content-transfer-encoding;
        bh=V3XDB7ke8rWzM3qGhTOIr65SWlc0LO8iD1KmieXbtnY=;
        b=BEZa+sJD++q/WhfRCnFWmNQiw+kv7kgEL6uxY76a9szjhV2SFR1vOYuSJpTFuGcxSJ
         JpwSCwZjYakksF+mcpF6tbo38pH0CfVHTdU23ja38ewUFDRyoY8Iqw8YGiUAnE2DqKEB
         QCyUhATXcGOpMQQf6dpP8JLUoYIEKLvSm90Ts=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=subject:to:bcc:from:cc:date:message-id:user-agent:mime-version
         :content-type:content-transfer-encoding;
        b=bEGpEhZBOl4qh/+yWICU2+IlakFTs1B9RwkFU7cyKKwKkaZblS06WsJsM5rqAv7w2+
         iu196i7H4Pvv7ITBZFEvb0ndMY01XS7nhVugDMs7QHxZiKB974RsgcnWOzgAxe6UO2Au
         +fC7JFATFYRNnK2nOyfXJAGPt6c/x0Irlv+v4=
Received: by 10.213.42.194 with SMTP id t2mr2121100ebe.50.1274031236103;
        Sun, 16 May 2010 10:33:56 -0700 (PDT)
Received: from localhost.localdomain (c-97d7e255.66-15-64736c12.cust.bredbandsbolaget.se [85.226.215.151])
        by mx.google.com with ESMTPS id 16sm2381478ewy.7.2010.05.16.10.33.54
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sun, 16 May 2010 10:33:55 -0700 (PDT)
User-Agent: StGit/0.15-116-g4e08-dirty
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/147196>

I would like to have something similar to this patch, which allows for
setting the (git) tree of a particular patch. I would like to use it
(from the Emacs mode) to make it easier to split an old patch into two
(or more).

It might be that this is too "powerful" (read: unsafe), and maybe a
better (safer) command would use whatever is currently in the index
rather than a SHA1.

Anyway, I'd appreciate any comments, e.g. at
http://github.com/gustavh/stgit/commits/set-tree (pull from
git://github.com/gustavh/stgit.git "set-tree" branch).

---
Also fix capitalization in edit's short description.

Signed-off-by: Gustav H=C3=A5llberg <gustav@gmail.com>
---
 stgit/commands/edit.py |   19 ++++++++++++++++---
 t/t3300-edit.sh        |   15 +++++++++++++++
 2 files changed, 31 insertions(+), 3 deletions(-)

diff --git a/stgit/commands/edit.py b/stgit/commands/edit.py
index f3f731f..55282f4 100644
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
@@ -52,7 +52,11 @@ invoked even if such command-line options are given.=
)
=20
 If the patch diff is edited but does not apply, no changes are made to
 the patch at all. The edited patch is saved to a file which you can
-feed to "stg edit --file", once you have made sure it does apply."""
+feed to "stg edit --file", once you have made sure it does apply.
+
+With --set-tree you set the git tree of the patch to the specified
+SHA1, without changing the tree of any other patches. See also the
+--set-tree flag of stg push."""
=20
 args =3D [argparse.applied_patches, argparse.unapplied_patches,
         argparse.hidden_patches]
@@ -61,6 +65,9 @@ options =3D [
         short =3D 'Edit the patch diff'),
     opt('-e', '--edit', action =3D 'store_true',
         short =3D 'Invoke interactive editor'),
+    opt('-t', '--set-tree', action =3D 'store',
+        metavar =3D 'SHA1',
+        short =3D 'Set the git tree of the patch to SHA1'),
     ] + (argparse.sign_options() +
          argparse.message_options(save_template =3D True) +
          argparse.author_options() + argparse.diff_opts_option())
@@ -86,6 +93,9 @@ def func(parser, options, args):
=20
     cd =3D orig_cd =3D stack.patches.get(patchname).commit.data
=20
+    if options.set_tree:
+        cd =3D cd.set_tree(stack.repository.get_tree(options.set_tree)=
)
+
     cd, failed_diff =3D edit.auto_edit_patch(
         stack.repository, cd, msg =3D options.message, contains_diff =3D=
 True,
         author =3D options.author, committer =3D lambda p: p,
@@ -128,7 +138,10 @@ def func(parser, options, args):
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
index 7003a27..078d4c3 100755
--- a/t/t3300-edit.sh
+++ b/t/t3300-edit.sh
@@ -212,4 +212,19 @@ test_expect_failure 'Fail to set invalid author da=
te' '
     test "$(date HEAD)" =3D "2013-01-28 22:30:00 -0300"
 '
=20
+test_expect_success 'Set patch tree SHA1' '
+    p2tree=3D$(git log -1 --pretty=3Dformat:%T $(stg id p2)) &&
+    p4tree=3D$(git log -1 --pretty=3Dformat:%T $(stg id p4)) &&
+    stg edit --set-tree $p4tree &&
+    test $(git write-tree) =3D $p4tree &&
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
