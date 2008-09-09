From: Petr Baudis <pasky@suse.cz>
Subject: Re: [RFC] origin link for cherry-pick and revert
Date: Tue, 9 Sep 2008 23:13:55 +0200
Message-ID: <20080909211355.GB10544@machine.or.cz>
References: <20080909132212.GA25476@cuci.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: "Stephen R. van den Berg" <srb@cuci.nl>
X-From: git-owner@vger.kernel.org Tue Sep 09 23:15:14 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KdAYD-0003LX-TP
	for gcvg-git-2@gmane.org; Tue, 09 Sep 2008 23:15:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753524AbYIIVN6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 9 Sep 2008 17:13:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751973AbYIIVN6
	(ORCPT <rfc822;git-outgoing>); Tue, 9 Sep 2008 17:13:58 -0400
Received: from w241.dkm.cz ([62.24.88.241]:53448 "EHLO machine.or.cz"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750754AbYIIVN6 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 9 Sep 2008 17:13:58 -0400
Received: by machine.or.cz (Postfix, from userid 2001)
	id 71937393A370; Tue,  9 Sep 2008 23:13:55 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <20080909132212.GA25476@cuci.nl>
User-Agent: Mutt/1.5.16 (2007-06-09)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/95433>

On Tue, Sep 09, 2008 at 03:22:12PM +0200, Stephen R. van den Berg wrote:
> - During fetch/push/pull the full commit including the origin fields is
>   transmitted, however, the objects the origin links are referring to
>   are not (unless they are being transmitted because of other reasons).
> 
> - When fetching/pulling it is optionally possible to tell git to
>   actually transmit objects referred to by origin links even if it would
>   otherwise not have done so.

I think this is misguided. In general case, cherrypicks can be from
completely unrelated histories, and if you are doing the cherry pick,
you are saying that actually, the history *does not matter*. In that
case, this kind of link tries to impose a meaning where there is none,
and in an ill-defined way when whether the commit is actually around
anywhere is essentially random.

Why do you actually *follow* the origin link at all anyway? Without its
parents, the associated tree etc., the object is essentially useless for
you; the authorship information and commit message should've been
preserved by a proper cherry-pick anyway. You're cluttering the object
store with invalid objects, which also breaks quite some fundamental
logic within Git (which assumes that if an object exists, all its
references are valid - give or take few special cases like shallow
repositories, but this would have very different characteristics).

Having history browsers draw fancy lines is fine but I see nothing wrong
with them extracting this from the free-form part of the commit message.
For informative purposes, we don't shy away from heuristics anyway, c.f.
our renames detection (heck, we are even brave enough to use that for
merges).

-- 
				Petr "Pasky" Baudis
The next generation of interesting software will be done
on the Macintosh, not the IBM PC.  -- Bill Gates
