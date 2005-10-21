From: Junio C Hamano <junkio@cox.net>
Subject: Re: How to create a new branch based on a tag?
Date: Thu, 20 Oct 2005 22:08:28 -0700
Message-ID: <7vzmp3319v.fsf@assigned-by-dhcp.cox.net>
References: <435901F7.9020509@ust.hk>
	<7vsluv5y0p.fsf@assigned-by-dhcp.cox.net> <4359161B.5000808@ust.hk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Oct 21 07:10:41 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1ESp98-00053P-Sn
	for gcvg-git@gmane.org; Fri, 21 Oct 2005 07:08:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964869AbVJUFIa (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 21 Oct 2005 01:08:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964870AbVJUFIa
	(ORCPT <rfc822;git-outgoing>); Fri, 21 Oct 2005 01:08:30 -0400
Received: from fed1rmmtao04.cox.net ([68.230.241.35]:38820 "EHLO
	fed1rmmtao04.cox.net") by vger.kernel.org with ESMTP
	id S964869AbVJUFIa (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 21 Oct 2005 01:08:30 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao04.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20051021050758.FADD11356.fed1rmmtao04.cox.net@assigned-by-dhcp.cox.net>;
          Fri, 21 Oct 2005 01:07:58 -0400
To: Ben Lau <benlau@ust.hk>
In-Reply-To: <4359161B.5000808@ust.hk> (Ben Lau's message of "Sat, 22 Oct 2005
	00:23:55 +0800")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/10420>

Ben Lau <benlau@ust.hk> writes:

>>The way you know is as good as it gets.  v2.6.11-tree case is
>>really an unfortunate special case.
>>
> What is wrong with the v2.6.11-tree? I just thought it is a duplicate tag
> of v2.6.11.

They are not *wrong* per-se.  They are tags to tree objects
without any associated commit history -- that makes them
inappropriate to be used as branch heads.

Linus or somebody authoritative could do:

    $ commit=$(echo v2.6.11 | \
      git-commit-tree c39ae07f393806ccf406ef966e9a15afc43cc36a)
    $ git-tag -s -m 'v2.6.11 canonical "fake" commit' v2.6.11fake $commit

and tell everybody interested to have:

1da177e4c3f41524e886b7f1b8a0c1fc7321cac2 xxxxxxxxxx

(where xxxxx... is the value of $commit above) in their
info/grafts file.  Then we *could* pretend that v2.6.12-rc2's
parent is v2.6.11.  You could branch off from v2.6.11fake commit
and base your development, and later you could merge that into
later development history (say, v2.6.14-rc5) if you wanted to.

If Linus does something like the above, the graft probably be
better done between the current v2.6.12-rc2 based commit history
and the corresponding commit in the history resurrected from
BKCVS (torvalds/old-2.6-bkcvs.git).  Then you could even base
your development on top of v2.4.0 ;-).

Funnily, v2.6.12-rc2 commit in the current history and BKCVS
v2.6.12-rc2 commit in the resurrected history have different
tree IDs.

I am however not quite sure how useful the above would be,
though.  EVen between 2.6.11 and 2.6.12-rc2 much have happened,
so unless the changes you are making apply to the part that did
not change between those two, merge conflict resolution might be
quite a chore.
