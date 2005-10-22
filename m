From: Petr Baudis <pasky@suse.cz>
Subject: Re: Handling renames.
Date: Sat, 22 Oct 2005 04:49:46 +0200
Message-ID: <20051022024946.GP30889@pasky.or.cz>
References: <Pine.LNX.4.64.0510211631400.10477@g5.osdl.org> <20051022003733.GA8351@pasky.or.cz> <20051022004743.GN30889@pasky.or.cz> <Pine.LNX.4.64.0510211826350.10477@g5.osdl.org> <20051022015109.GO30889@pasky.or.cz> <7vbr1is3m4.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Oct 22 04:51:02 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1ET9SK-0001J7-QD
	for gcvg-git@gmane.org; Sat, 22 Oct 2005 04:50:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932571AbVJVCtt (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 21 Oct 2005 22:49:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932572AbVJVCtt
	(ORCPT <rfc822;git-outgoing>); Fri, 21 Oct 2005 22:49:49 -0400
Received: from w241.dkm.cz ([62.24.88.241]:10719 "EHLO machine.or.cz")
	by vger.kernel.org with ESMTP id S932571AbVJVCtt (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 21 Oct 2005 22:49:49 -0400
Received: (qmail 18761 invoked by uid 2001); 22 Oct 2005 04:49:46 +0200
To: Junio C Hamano <junkio@cox.net>
Content-Disposition: inline
In-Reply-To: <7vbr1is3m4.fsf@assigned-by-dhcp.cox.net>
X-message-flag: Outlook : A program to spread viri, but it can do mail too.
User-Agent: Mutt/1.5.10i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/10463>

Dear diary, on Sat, Oct 22, 2005 at 04:10:59AM CEST, I got a letter
where Junio C Hamano <junkio@cox.net> told me that...
> I think it is OK for the higher level layer (like your
> single-file-history follower) to use what you outlined with
> "edges", as either a hint/request from the user and/or a cache
> of what the expensive and unreliable thing figured out.
> 
> I however do not necessarily think adding the "edges"
> information as an optional second item on "parent " line in a
> commit is a good idea.

Well, it's obviously unflying idea when it doesn't become core part of
GIT. ;-) That won't stop me with Cogito, though...

> Rather, treating the set of "edges" just
> like we treat the grafts feel more appropriate to me.  IOW,
> create .git/info/edges and keep your edge information there.

The thing is, you aren't supposed to have a lot of grafts, they are
expected to be rare. OTOH, renames aren't really all that rare, and as
the history goes, you'll accumulate a lot of them. Besides, it's not
just a cache - in case the user manually recorded the rename, it's an
important historical information, as important as e.g. the commit
message. It should be also distributed with the rest of the history
data, not be a per-repository thing. (Actually, this does not mix with
the cache at all - that should be a separate thing, quite possibly in
info/.)


But if GIT won't do this, I will have to do this in some Cogito-specific
way. My preliminary plan is appending something like this to the commit
message:

	---
	!%$rename foo\x20bar baz\nquux

!%$ being some arbitrary magic literal, and filter this out from cg-log
and such. Also, all Cogito commits adding/removing files but not
renaming any would have a '!%$norenames' line in the commit message, so
that I know that I don't have to do the expensive heuristics because no
rename/copy happened.

-- 
				Petr "Pasky" Baudis
Stuff: http://pasky.or.cz/
VI has two modes: the one in which it beeps and the one in which
it doesn't.
