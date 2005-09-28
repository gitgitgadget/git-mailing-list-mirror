From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] Use git-update-ref in scripts.
Date: Wed, 28 Sep 2005 11:17:26 -0700
Message-ID: <7vk6h1rr9l.fsf@assigned-by-dhcp.cox.net>
References: <Pine.LNX.4.58.0509251134480.3308@g5.osdl.org>
	<Pine.LNX.4.58.0509251153090.3308@g5.osdl.org>
	<7vpsqtykor.fsf_-_@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.58.0509280819000.3308@g5.osdl.org>
	<7vek79w2ps.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.58.0509281007200.3308@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed Sep 28 20:20:01 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EKgV4-0002cm-Pe
	for gcvg-git@gmane.org; Wed, 28 Sep 2005 20:17:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750716AbVI1SRs (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 28 Sep 2005 14:17:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750718AbVI1SRs
	(ORCPT <rfc822;git-outgoing>); Wed, 28 Sep 2005 14:17:48 -0400
Received: from fed1rmmtao07.cox.net ([68.230.241.32]:47536 "EHLO
	fed1rmmtao07.cox.net") by vger.kernel.org with ESMTP
	id S1750716AbVI1SRr (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 28 Sep 2005 14:17:47 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao07.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20050928181726.TIWJ16347.fed1rmmtao07.cox.net@assigned-by-dhcp.cox.net>;
          Wed, 28 Sep 2005 14:17:26 -0400
To: Linus Torvalds <torvalds@osdl.org>
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/9445>

Linus Torvalds <torvalds@osdl.org> writes:

> On Wed, 28 Sep 2005, Junio C Hamano wrote:
>> 
> I don't like doing the diff before-hand, but it looked like the default 
> was to try just one strategy, and avoid the diff in that case.

By 'diff before-hand' I take it to mean the savestate for later
rounds to keep the pre-merge state.  You are correct that it is
not done in a single strategy case, and 'git pull' by default
would use only one of Daniel's git-merge-resolve or in the
multi-remote case git-merge-octopus, depending on the number of
heads being merged.  BTW, I decided not to use diff, just in
case somebody has binary blob we cannot reproduce with diff and
patch.

> Actually, my preference would be to have a unconditional simple case
> first. If there's only one possible base, and the trivial merge succeeds
> (ie no three-way merges needed at all, just a single git-read-tree), do
> that part unconditionally.
>
> That actually matches 90% of all merges I do, and I'd be much happier with 
> git-merge if it did that first and if it then does something more complex 
> (including diffs etc) afterwards, I'm much less likely to worry.

Hmph.  That sort of makes sense but to make the unconditional
simple case really fast it should use read-tree -m -u which
_would_ smudge if things do not go well, which implies you need
savestate before that which would make it slower -- wouldn't it?

I think using Daniel's git-merge-resolve and nothing else by
default would be equivalent of having that unconditional simple
case upfront.
