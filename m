From: Nanako Shiraishi <nanako3@lavabit.com>
Subject: [PATCH] git-bundle doc: update examples
Date: Wed, 4 Feb 2009 18:15:29 +0900
Message-ID: <20090204181529.6117@nanako3.lavabit.com>
References: <7vab95r7j4.fsf@gitster.siamese.dyndns.org> <87y6wnnjvl.fsf@jidanni.org> <7vbptj9cp8.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Cc: git@vger.kernel.org,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	jidanni@jidanni.org, mdl123@verizon.net, spearce@spearce.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Feb 04 10:18:02 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LUdtR-0003uM-5v
	for gcvg-git-2@gmane.org; Wed, 04 Feb 2009 10:18:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754752AbZBDJQQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 4 Feb 2009 04:16:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755008AbZBDJQP
	(ORCPT <rfc822;git-outgoing>); Wed, 4 Feb 2009 04:16:15 -0500
Received: from karen.lavabit.com ([72.249.41.33]:33288 "EHLO karen.lavabit.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754912AbZBDJQJ (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 4 Feb 2009 04:16:09 -0500
Received: from d.earth.lavabit.com (d.earth.lavabit.com [192.168.111.13])
	by karen.lavabit.com (Postfix) with ESMTP id 07CA1C7B03;
	Wed,  4 Feb 2009 03:16:09 -0600 (CST)
Received: from 6914.lavabit.com (212.62.97.21)
	by lavabit.com with ESMTP id FKZ1YTN1SZYW; Wed, 04 Feb 2009 03:16:09 -0600
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws; s=lavabit; d=lavabit.com;
  b=UM5aDMR9qrBwg81ab05Bl3Txp6Od3ZFNJ9ft9r4Q0dHDERKF8Q/qQXPorcYcZGQLOJThk3+kRj8EboSTJEXDwsRbjkii2yLm/0/XfyE3Ah1JPnO+wnvIb36jEUqjx2POJgbRajl492OWpLmpIOBjlK/IWYiG0z4sD78ubRfGe6Q=;
  h=From:To:Cc:Date:Subject:In-Reply-To:References:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id;
In-Reply-To: <7vbptj9cp8.fsf@gitster.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/108319>

This rewrites the example part of the bundle doucmentation to follow
the suggestion made by Junio during a recent discussion (gmane 108030).

Instead of just showing different ways to create and use bundles in a
disconnected fashion, the rewritten example first shows the simplest
"full cycle" of sneakernet workflow, and then introduces various
variations.

The words are mostly taken from Junio's outline. I only reformatted
them and proofread to make sure the end result flows naturally.

Signed-off-by: Nanako Shiraishi <nanako3@lavabit.com>
---

I didn't want your improvement suggestion to go to waste either, so
here is a proposed conclusion of this topic in a patch form, hopefully
in a good enough quality.

After the maintainer spent a lot of time to suggest how to improve a
proposed patch for inclusion, it is rude for a contributor to walk
away without following through the review process. Such a proposed
patch is not contributing to the development process but only stealing
maintainer's and reviewers' time from the community. But others like I
can at least try to help (^_^;).

 Documentation/git-bundle.txt |  132 ++++++++++++++++++++++++++---------------
 1 files changed, 84 insertions(+), 48 deletions(-)

diff --git a/Documentation/git-bundle.txt b/Documentation/git-bundle.txt
index 1b66ab7..ea0f6a0 100644
--- a/Documentation/git-bundle.txt
+++ b/Documentation/git-bundle.txt
@@ -84,7 +84,7 @@ defining the basis.  More than one reference may be packaged, and more
 than one basis can be specified.  The objects packaged are those not
 contained in the union of the given bases.  Each basis can be
 specified explicitly (e.g., ^master~10), or implicitly (e.g.,
-master~10..master, master --since=10.days.ago).
+master~10..master, --since=10.days.ago master).
 
 It is very important that the basis used be held by the destination.
 It is okay to err on the side of conservatism, causing the bundle file
@@ -94,75 +94,111 @@ when unpacking at the destination.
 EXAMPLE
 -------
 
-Assume two repositories exist as R1 on machine A, and R2 on machine B.
+Assume you want to transfer the history from a repository R1 on machine A
+to another repository R2 on machine B.
 For whatever reason, direct connection between A and B is not allowed,
 but we can move data from A to B via some mechanism (CD, email, etc).
 We want to update R2 with developments made on branch master in R1.
 
-To create the bundle you have to specify the basis. You have some options:
+To bootstrap the process, you can first create a bundle that doesn't have
+any basis. You can use a tag to remember up to what commit you sent out
+in order to make it easy to later update the other repository with
+incremental bundle,
 
-- Without basis.
-+
-This is useful when sending the whole history.
+----------------
+machineA$ cd R1
+machineA$ git bundle create file.bdl master
+machineA$ git tag -f lastR2bundle master
+----------------
 
-------------
-$ git bundle create mybundle master
-------------
+Then you sneakernet file.bdl to the target machine B. Because you don't
+have to have any object to extract objects from such a bundle, not only
+you can fetch/pull from a bundle, you can clone from it as if it was a
+remote repository.
 
-- Using temporally tags.
-+
-We set a tag in R1 (lastR2bundle) after the previous such transport,
-and move it afterwards to help build the bundle.
+----------------
+machineB$ git clone /home/me/tmp/file.bdl R2
+----------------
 
-------------
-$ git bundle create mybundle master ^lastR2bundle
-$ git tag -f lastR2bundle master
-------------
+This will define a remote called "origin" in the resulting repository that
+lets you fetch and pull from the bundle. $GIT_DIR/config file in R2 may
+have an entry like this:
 
-- Using a tag present in both repositories
+------------------------
+[remote "origin"]
+    url = /home/me/tmp/file.bdl
+    fetch = refs/heads/*:refs/remotes/origin/*
+------------------------
+
+You can fetch/pull to update the resulting mine.git repository after
+replacing the bundle you store at /home/me/tmp/file.bdl with incremental
+updates from here on.
+
+After working more in the original repository, you can create an
+incremental bundle to update the other:
+
+----------------
+machineA$ cd R1
+machineA$ git bundle create file.bdl lastR2bundle..master
+machineA$ git tag -f lastR2bundle master
+----------------
+
+and sneakernet it to the other machine to replace /home/me/tmp/file.bdl,
+and pull from it.
+
+----------------
+machineB$ cd R2
+machineB$ git pull
+----------------
 
-------------
-$ git bundle create mybundle master ^v1.0.0
-------------
+If you know up to what commit the intended recipient repository should
+have the necessary objects for, you can use that knowledge to specify the
+basis, giving a cut-off point to limit the revisions and objects that go
+in the resulting bundle. The previous example used lastR2bundle tag
+for this purpose, but you can use other options you would give to
+the linkgit:git-log[1] command. Here are more examples:
 
-- A basis based on time.
+You can use a tag that is present in both.
 
-------------
-$ git bundle create mybundle master --since=10.days.ago
-------------
+----------------
+$ git bundle create mybundle v1.0.0..master
+----------------
 
-- With a limit on the number of commits
+You can use a basis based on time.
 
-------------
-$ git bundle create mybundle master -n 10
-------------
+----------------
+$ git bundle create mybundle --since=10.days master
+----------------
 
-Then you move mybundle from A to B, and in R2 on B:
+Or you can use the number of commits.
 
-------------
+----------------
+$ git bundle create mybundle -10 master
+----------------
+
+You can run `git-bundle verify` to see if you can extract from a bundle
+that was created with a basis.
+
+----------------
 $ git bundle verify mybundle
-$ git fetch mybundle master:localRef
-------------
+----------------
 
-With something like this in the config in R2:
+This will list what commits you must have in order to extract from the
+bundle and will error out if you don't have them.
 
-------------------------
-[remote "bundle"]
-    url = /home/me/tmp/file.bdl
-    fetch = refs/heads/*:refs/remotes/origin/*
-------------------------
+A bundle from a recipient repository's point of view is just like a
+regular repository it fetches/pulls from. You can for example map
+refs, like this example, when fetching:
 
-You can first sneakernet the bundle file to ~/tmp/file.bdl and
-then these commands on machine B:
+----------------
+$ git fetch mybundle master:localRef
+----------------
 
-------------
-$ git ls-remote bundle
-$ git fetch bundle
-$ git pull bundle
-------------
+Or see what refs it offers.
 
-would treat it as if it is talking with a remote side over the
-network.
+----------------
+$ git ls-remote mybundle
+----------------
 
 Author
 ------
-- 
1.6.1.2

-- 
Nanako Shiraishi
http://ivory.ap.teacup.com/nanako3/
