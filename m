From: Junio C Hamano <junkio@cox.net>
Subject: Re: git-name-rev off-by-one bug
Date: Wed, 30 Nov 2005 23:46:36 -0800
Message-ID: <7vu0dtl0o3.fsf@assigned-by-dhcp.cox.net>
References: <20051128234256.1508.qmail@science.horizon.com>
	<7vhd9wngn6.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.64.0511301235390.25300@iabervon.org>
	<7vsltdsxzb.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.64.0511301514500.25300@iabervon.org>
	<7vy835okxs.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.64.0511301707020.25300@iabervon.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Dec 01 08:47:02 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Ehj9W-0002n1-07
	for gcvg-git@gmane.org; Thu, 01 Dec 2005 08:46:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750749AbVLAHqj (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 1 Dec 2005 02:46:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750750AbVLAHqj
	(ORCPT <rfc822;git-outgoing>); Thu, 1 Dec 2005 02:46:39 -0500
Received: from fed1rmmtao03.cox.net ([68.230.241.36]:39927 "EHLO
	fed1rmmtao03.cox.net") by vger.kernel.org with ESMTP
	id S1750749AbVLAHqi (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 1 Dec 2005 02:46:38 -0500
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao03.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20051201074559.KIDN20875.fed1rmmtao03.cox.net@assigned-by-dhcp.cox.net>;
          Thu, 1 Dec 2005 02:45:59 -0500
To: Daniel Barkalow <barkalow@iabervon.org>
In-Reply-To: <Pine.LNX.4.64.0511301707020.25300@iabervon.org> (Daniel
	Barkalow's message of "Wed, 30 Nov 2005 18:12:57 -0500 (EST)")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/13039>

Delight in working on free software project is you have so many
good people with you that you can have many "Aha, lightbulb!"
moments.  This is one of them for me.  I realized where the
trouble I felt when reading your table came from; it was that I
was focused on the old way the table was organized too much.

When one constructs a case table to make sure one covered
everything, one first lists the variables and the possible
values they can take, and make NxMxOxPx... grid.  In the
original table I did, I chose what is in O and A and B as my
variables (and that's where my comment about O being bit2 etc
comes from).  I did not realize the semantics and algorithm you
used can be better described by different set of variables
(namely, how ancestors match the HEAD, and how the remote
matches the HEAD, if I understand correctly).  I had trouble
understanding your version only because I kept thinking in terms
of (O,A,B).

So after thinking about that...

    Daniel Barkalow <barkalow@iabervon.org> writes:

    > On Wed, 30 Nov 2005, Junio C Hamano wrote:
    >
    > Perhaps the table would be clearer if the lines were grouped
    > in exists/missing? (With 5ALT repeated in the 011 and 111
    > groups, since it applies to both) Then you would only need
    > to look at 5 lines with cascading (in the most complex
    > case), rather than having to read the whole top of the
    > table.

I think the current ordering of cases makes more sense.  If we
forget about the case labels from the original table (and the
way the original table classified cases), I suspect we could
reorganize the cases to describe the semantics even better and
clearer.  That is, not grouping by exists/missing, but grouping
by matching/unmatching.

> (It is actually written like that, with the exception of 5ALT, 2ALT, and 
> 3ALT, but it's not visually obvious.)

Yeah, I now realize that.

> The tricky bit is really cases 2ALT and 3ALT, which can be used in cases 
> where some but not all of the ancestors are empty, and can't be used if 
> there's a directory/file conflict; neither of these conditions matters for 
> anything else in the table, so it's hard to fit this in. My strategy is to 
> have those as special cases, and have the rest of the table cover 
> everything (rather than having case 2 require a directory/file conflict 
> and case 7 require that no ancestor be empty, which would be accurate, but 
> would make it harder to check for missing cases).

Makes sense.  Thanks for the clarification and lightbulb moment.
