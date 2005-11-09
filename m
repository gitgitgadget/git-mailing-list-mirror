From: Fredrik Kuivinen <freku045@student.liu.se>
Subject: [PATCH] merge-recursive: Fix support for branch names containing slashes
Date: Wed, 9 Nov 2005 11:42:57 +0100
Message-ID: <20051109104257.GC4960@c165.ib.student.liu.se>
References: <E1EZKOB-0002j5-VY@jdl.com> <7vwtjjllw4.fsf@assigned-by-dhcp.cox.net> <20051108210332.GB23265@c165.ib.student.liu.se> <7v7jbig6m7.fsf@assigned-by-dhcp.cox.net> <20051108225320.GB4805@c165.ib.student.liu.se> <7vmzkenzcx.fsf@assigned-by-dhcp.cox.net> <20051109081906.GA4960@c165.ib.student.liu.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Nov 09 11:45:03 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EZnPx-0003CA-5V
	for gcvg-git@gmane.org; Wed, 09 Nov 2005 11:43:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030277AbVKIKm6 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 9 Nov 2005 05:42:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030489AbVKIKm6
	(ORCPT <rfc822;git-outgoing>); Wed, 9 Nov 2005 05:42:58 -0500
Received: from [85.8.31.11] ([85.8.31.11]:22928 "EHLO mail6.wasadata.com")
	by vger.kernel.org with ESMTP id S1030277AbVKIKm6 (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 9 Nov 2005 05:42:58 -0500
Received: from c165 (unknown [85.8.2.189])
	by mail6.wasadata.com (Postfix) with ESMTP
	id 220954102; Wed,  9 Nov 2005 11:51:22 +0100 (CET)
Received: from ksorim by c165 with local (Exim 3.36 #1 (Debian))
	id 1EZnPt-0000H2-00; Wed, 09 Nov 2005 11:42:57 +0100
To: Fredrik Kuivinen <freku045@student.liu.se>
Content-Disposition: inline
In-Reply-To: <20051109081906.GA4960@c165.ib.student.liu.se>
User-Agent: Mutt/1.5.9i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/11393>

On Wed, Nov 09, 2005 at 09:19:06AM +0100, Fredrik Kuivinen wrote:
> On Tue, Nov 08, 2005 at 09:50:54PM -0800, Junio C Hamano wrote:
> > Fredrik Kuivinen <freku045@student.liu.se> writes:
> > 
> > >> Oops, I missed that part.  This is unsafe in theory, if you
> > >> could overwrite existing file3_master or file3_dev.  Does that
> > >> matter in practice?
> > >
> > > It wont overwrite any existing files. If there is a file named
> > > 'file3_master' then the new file will be named 'file3_master_1' and if
> > > that file also exists the new file will be named 'file3_master_2', and
> > > so on.
> > 
> > Another thing to watch out is that a branch name could have a
> > slash in it.  It might make more sense to just name the heads file3~2
> > or file3~3 (with as many ~s repeated to avoid name clashes) like
> > Pasky does.
> > 
> 
> Oups, I haven't thought about that. I kind of like the idea that you
> can see the branch name in the file names though. How about replacing
> any slashes in the branch names with underscores? So the branch
> 'foo/bar' will give rise to files with suffixes like '_foo_bar' and
> '_foo_bar_<number>'.
> 

And here is a patch to implement this. Should apply cleanly on top of
'[PATCH] merge-recursive: Fix limited output of rename messages'.

---

Signed-off-by: Fredrik Kuivinen <freku045@student.liu.se>


---

 git-merge-recursive.py |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

applies-to: 1dd8c1800d7dd0425bc93f4c9441acfb207b1488
795e2900e8804af53263821c177a270cd2d7c2c0
diff --git a/git-merge-recursive.py b/git-merge-recursive.py
index 3657875..90e889c 100755
--- a/git-merge-recursive.py
+++ b/git-merge-recursive.py
@@ -295,6 +295,7 @@ def uniquePath(path, branch):
             else:
                 raise
 
+    branch = branch.replace('/', '_')
     newPath = path + '_' + branch
     suffix = 0
     while newPath in currentFileSet or \
---
0.99.9.GIT
