From: Junio C Hamano <junkio@cox.net>
Subject: Re: More gitweb queries..
Date: Fri, 27 May 2005 13:13:58 -0700
Message-ID: <7vu0kowho9.fsf@assigned-by-dhcp.cox.net>
References: <Pine.LNX.4.58.0505271145570.17402@ppc970.osdl.org>
	<20050527192941.GE7068@cip.informatik.uni-erlangen.de>
	<7vhdgoxx8c.fsf@assigned-by-dhcp.cox.net>
	<20050527195552.GA6541@cip.informatik.uni-erlangen.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri May 27 22:13:11 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DblBY-0001tA-S3
	for gcvg-git@gmane.org; Fri, 27 May 2005 22:12:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262571AbVE0UOF (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 27 May 2005 16:14:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262572AbVE0UOF
	(ORCPT <rfc822;git-outgoing>); Fri, 27 May 2005 16:14:05 -0400
Received: from fed1rmmtao08.cox.net ([68.230.241.31]:47334 "EHLO
	fed1rmmtao08.cox.net") by vger.kernel.org with ESMTP
	id S262571AbVE0UOA (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 27 May 2005 16:14:00 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.60.172])
          by fed1rmmtao08.cox.net
          (InterMail vM.6.01.04.00 201-2131-118-20041027) with ESMTP
          id <20050527201359.LBRZ16890.fed1rmmtao08.cox.net@assigned-by-dhcp.cox.net>;
          Fri, 27 May 2005 16:13:59 -0400
To: Thomas Glanzmann <sithglan@stud.uni-erlangen.de>
In-Reply-To: <20050527195552.GA6541@cip.informatik.uni-erlangen.de> (Thomas
 Glanzmann's message of "Fri, 27 May 2005 21:55:52 +0200")
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

>>>>> "TG" == Thomas Glanzmann <sithglan@stud.uni-erlangen.de> writes:

>> You merge by hand and resolve if they have conflicts, just like
>> what you already do in two head merge case.

TG> I see. Does that mean that 'git-ls-files --unmerged' will report upto 9
TG> stages per file?

No, I think my description was unclear.  You still merge two at
a time because that is what git-read-tree -m gives you (3-way
merge is between $(merge-base $A $B) and $A and $B so you are
merging two heads).

To confess, my workflow to merge with Linus is currently
primarily patch based, so I do not even use git-read-tree -m
3-way merge when I make an Octopus (for that matter, I do not
myself do Octopus at all these days).  When I have bunch of
independent changes, I would first prepare and test these:

           -- JC#1
          / - JC#2
         /  - JC#3
  Linus#1-  - JC#4  
         \    ...
          \-- JC#7

By the time I am done and happy with them, tip of Linus tree may
have already advanced and he is at Linus#2.  I would then apply
diffs between Linus#1 and JC#n (1 <= n <= 7) on top of Linus #2,
and commit the result with parents set to Linus #2 and JC#1,
JC#2, ..., JC#7.

           ------- Linus#2
          /               \
         / -- JC#1 --------\
        / /-- JC#2 ---------\ 
       / /--- JC#3 ----------\
  Linus#1---- JC#4 ---------- Octopus 
         \    ...            /
          \-- JC#7 ----------

