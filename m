From: Junio C Hamano <junkio@cox.net>
Subject: Re: Issues with higher-order stages in dircache
Date: Sat, 16 Apr 2005 22:11:01 -0700
Message-ID: <7v64ym2dju.fsf@assigned-by-dhcp.cox.net>
References: <Pine.LNX.4.58.0504140201130.7211@ppc970.osdl.org>
	<7vll7lqlbg.fsf@assigned-by-dhcp.cox.net>
	<20050414193507.GA22699@pasky.ji.cz>
	<7vmzs1osv1.fsf@assigned-by-dhcp.cox.net>
	<20050414233159.GX22699@pasky.ji.cz>
	<7v7jj4q2j2.fsf@assigned-by-dhcp.cox.net>
	<20050414223039.GB28082@64m.dyndns.org>
	<7vfyxsmqmk.fsf@assigned-by-dhcp.cox.net>
	<20050415062807.GA29841@64m.dyndns.org>
	<7vfyxsi9bq.fsf@assigned-by-dhcp.cox.net>
	<7vaco0i3t9.fsf_-_@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.58.0504151138490.7211@ppc970.osdl.org>
	<7vmzrzhkd3.fsf@assigned-by-dhcp.cox.net>
	<7vfyxrhfsw.fsf_-_@assigned-by-dhcp.cox.net>
	<7vmzrzfwe4.fsf_-_@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.58.0504151755590.7211@ppc970.osdl.org>
	<7v7jj3fjky.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.58.0504152152580.7211@ppc970.osdl.org>
	<Pine.LNX.4.58.0504152256520.7211@ppc970.osdl.org>
	<7vis2ncf8j.fsf@assigned-by-dhc
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Apr 17 07:08:08 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DN20j-0006VD-6q
	for gcvg-git@gmane.org; Sun, 17 Apr 2005 07:07:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261259AbVDQFLj (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 17 Apr 2005 01:11:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261261AbVDQFLj
	(ORCPT <rfc822;git-outgoing>); Sun, 17 Apr 2005 01:11:39 -0400
Received: from fed1rmmtao02.cox.net ([68.230.241.37]:46271 "EHLO
	fed1rmmtao02.cox.net") by vger.kernel.org with ESMTP
	id S261259AbVDQFL3 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 17 Apr 2005 01:11:29 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.60.172])
          by fed1rmmtao02.cox.net
          (InterMail vM.6.01.04.00 201-2131-118-20041027) with ESMTP
          id <20050417051102.FIZL4787.fed1rmmtao02.cox.net@assigned-by-dhcp.cox.net>;
          Sun, 17 Apr 2005 01:11:02 -0400
To: Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <7vll7i95u1.fsf_-_@assigned-by-dhcp.cox.net> (Junio C. Hamano's
 message of "Sat, 16 Apr 2005 07:03:34 -0700")
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Linus,

    earlier I wrote [*R1*]:

   - An explicit "update-cache [--add] [--remove] path" should
     be taken as a signal from the user (or Cogito) to tell the
     dircache layer "the merge is done and here is the result".
     So just delete higher-order stages for the path and record
     the specified path at stage 0 (or remove it altogether).

and I think this commit of yours implements the adding half.

    commit be7b1f05cea8e5213ffef8f74ebdefed2aacb6fc:1
    author Linus Torvalds <torvalds@ppc970.osdl.org> 1113678345 -0700
    committer Linus Torvalds <torvalds@ppc970.osdl.org> 1113678345 -0700

    When inserting a index entry of stage 0, remove all old unmerged entries.

I am wondering if you have a particular reason not to do the
same for the removing half.  Without it, currently I do not see
a way for the user or Cogito to tell dircache layer that the
merge should result in removal.  That is, other than first
adding a phony entry there (which brings the entry down to stage
0) and then immediately doing a regular update-cache --remove.
That is two instead of one reading of 1.6MB index file for the
kernel case.

Also do you have any comments on this one from the same message?

 * read-tree

   - When merging two trees, i.e. "read-tree -m A B", shouldn't
     we collapse identical stage-1/2 into stage-0?


[References]

*R1* http://marc.theaimsgroup.com/?l=git&m=111366023126466&w=2

