From: Eyvind Bernhardsen <eyvind-git@orakel.ntnu.no>
Subject: [PATCH v2] fast-import: Document the effect of "merge" with no "from" in a commit
Date: Fri, 21 Mar 2008 16:25:18 +0100
Message-ID: <BDCF3EE6-0813-40B1-96D8-CCBADCCDAEA6@orakel.ntnu.no>
References: <F6F70627-FAE7-43F1-BECC-E70A4A561982@orakel.ntnu.no> <20080318034321.GK8410@spearce.org> <F4486D8E-3256-4FA7-89A7-3EC7E7D64162@orakel.ntnu.no> <20080319020625.GA3535@spearce.org> <9A41E5AD-2305-457B-A214-7A11A1B559F6@orakel.ntnu.no> <20080320034031.GX8410@spearce.org> <6FC571BB-D304-4D25-B1F2-1E03BD5438F8@orakel.ntnu.no> <FB8C4A1F-3DC1-4D7B-910B-5F721F39B244@orakel.ntnu.no>
Mime-Version: 1.0 (Apple Message framework v919.2)
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Content-Transfer-Encoding: 7bit
Cc: James Westby <jw+debian@jameswestby.net>,
	Ian Clatworthy <ian.clatworthy@internode.on.net>,
	Michael Haggerty <mhagger@alum.mit.edu>,
	Git Mailing List <git@vger.kernel.org>
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Fri Mar 21 16:26:16 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Jcj8E-0003Lz-Jt
	for gcvg-git-2@gmane.org; Fri, 21 Mar 2008 16:26:11 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753476AbYCUPZ0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 21 Mar 2008 11:25:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753325AbYCUPZ0
	(ORCPT <rfc822;git-outgoing>); Fri, 21 Mar 2008 11:25:26 -0400
Received: from 97.84-49-228.nextgentel.com ([84.49.228.97]:58737 "EHLO
	eyvind.bernhardsens.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753305AbYCUPZZ (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 21 Mar 2008 11:25:25 -0400
Received: from [192.168.0.3] (ip-254-5-149-91.dialup.ice.no [91.149.5.254])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by eyvind.bernhardsens.net (Postfix) with ESMTP id 28E3D14619F;
	Fri, 21 Mar 2008 16:25:20 +0100 (CET)
In-Reply-To: <FB8C4A1F-3DC1-4D7B-910B-5F721F39B244@orakel.ntnu.no>
X-Mailer: Apple Mail (2.919.2)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/77744>

The fast-import documentation currently does not document the behaviour
of "merge" when there is no "from" in a commit.  This patch adds a
description of what happens: the commit is created with a parent, but
no files.  This behaviour is equivalent to "from" followed by
"filedeleteall".

Signed-off-by: Eyvind Bernhardsen <eyvind-git@orakel.ntnu.no>
---
On 21. mars. 2008, at 14.57, Eyvind Bernhardsen wrote:
> It turns out that I'm an idiot and you're right.  I'll rewrite the  
> patch to reflect that the "merge" behaviour only applies when  
> creating a branch.

Second attempt, now with 58% more understanding.

  Documentation/git-fast-import.txt |   11 ++++++++---
  1 files changed, 8 insertions(+), 3 deletions(-)

diff --git a/Documentation/git-fast-import.txt b/Documentation/git- 
fast-import.txt
index 96f6767..c29a4f8 100644
--- a/Documentation/git-fast-import.txt
+++ b/Documentation/git-fast-import.txt
@@ -385,6 +385,9 @@ new commit.
  Omitting the `from` command in the first commit of a new branch
  will cause fast-import to create that commit with no ancestor. This
  tends to be desired only for the initial commit of a project.
+If the frontend creates all files from scratch when making a new
+branch, a `merge` command may be used instead of `from` to start
+the commit with an empty tree.
  Omitting the `from` command on existing branches is usually desired,
  as the current commit on that branch is automatically assumed to
  be the first ancestor of the new commit.
@@ -427,13 +430,15 @@ existing value of the branch.

  `merge`
  ^^^^^^^
-Includes one additional ancestor commit, and makes the current
-commit a merge commit.  An unlimited number of `merge` commands per
+Includes one additional ancestor commit.  If the `from` command is
+omitted when creating a new branch, the first `merge` commit will be
+the first ancestor of the current commit, and the branch will start
+out with no files.  An unlimited number of `merge` commands per
  commit are permitted by fast-import, thereby establishing an n-way  
merge.
  However Git's other tools never create commits with more than 15
  additional ancestors (forming a 16-way merge).  For this reason
  it is suggested that frontends do not use more than 15 `merge`
-commands per commit.
+commands per commit; 16, if starting a new, empty branch.

  Here `<committish>` is any of the commit specification expressions
  also accepted by `from` (see above).
-- 
1.5.5.rc0.9.g6e103
