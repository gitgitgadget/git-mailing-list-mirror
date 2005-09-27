From: Petr Baudis <pasky@suse.cz>
Subject: Re: Cogito: cg-clone doesn't like packed tag objects
Date: Tue, 27 Sep 2005 14:34:55 +0200
Message-ID: <20050927123455.GE30889@pasky.or.cz>
References: <7virwna2oi.fsf@assigned-by-dhcp.cox.net> <7v4q875bbj.fsf@assigned-by-dhcp.cox.net> <20050927094029.GA30889@pasky.or.cz> <200509271214.31933.Josef.Weidendorfer@gmx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Sep 27 14:38:20 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EKEfl-0002Kb-3n
	for gcvg-git@gmane.org; Tue, 27 Sep 2005 14:35:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964857AbVI0Me6 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 27 Sep 2005 08:34:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964866AbVI0Me6
	(ORCPT <rfc822;git-outgoing>); Tue, 27 Sep 2005 08:34:58 -0400
Received: from w241.dkm.cz ([62.24.88.241]:1243 "EHLO machine.or.cz")
	by vger.kernel.org with ESMTP id S964857AbVI0Me5 (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 27 Sep 2005 08:34:57 -0400
Received: (qmail 14745 invoked by uid 2001); 27 Sep 2005 14:34:55 +0200
To: Josef Weidendorfer <Josef.Weidendorfer@gmx.de>
Content-Disposition: inline
In-Reply-To: <200509271214.31933.Josef.Weidendorfer@gmx.de>
X-message-flag: Outlook : A program to spread viri, but it can do mail too.
User-Agent: Mutt/1.5.10i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/9392>

Dear diary, on Tue, Sep 27, 2005 at 12:14:31PM CEST, I got a letter
where Josef Weidendorfer <Josef.Weidendorfer@gmx.de> told me that...
> On Tuesday 27 September 2005 11:40, Petr Baudis wrote:
> > Another thing I proposed back then (I think it was in June) was having
> > the refs/tags directory further divised based on heads, so all tags for
> > head A would be in refs/tags/A/, etc. I didn't pursue this idea now
> > because it seemed that there would be way too many duplicate stuff in
> > refs/tags/ since most tags are likely to be shared across heads, but
> > perhaps it is the beast and cleanest solution after all.
> 
> The problem here is that currently there are no global, public branches.
> And you should not mix private heads in refs/heads with global tags.

But we don't need any global tags or heads. You just have some heads in
your refs/heads (it doesn't matter if they are public or remote, that's
a "social" issue what you tell people to fetch). And based on your heads
you have in your refs/heads, there would be directories in your
refs/tags/ corresponding to those.

If you fetch remote head, its local subdirectory in refs/tags/ is
populated with the new tags, and if you merge two heads, the public tags
are copied around. Then if you are resolving a tag, we should first look
at refs/tags/$(readlink HEAD)/tagname, and if it doesn't exist, we would
look at refs/tags/tagname (so if you wanted to reference a tag not in
your head, you'd have to use a "head/tag" form). Optionally, you could
also look for refs/tags/*/tagname and if it gives you a unique match,
use that - but I'm not sure how good idea this is since it already makes
the lookup way too heuristical.

> Perhaps interpret tag objects as global branch names, similar to
> the "mixture" in .git/refs ?

I don't understand.

-- 
				Petr "Pasky" Baudis
Stuff: http://pasky.or.cz/
VI has two modes: the one in which it beeps and the one in which
it doesn't.
