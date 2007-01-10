From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] sha1_name(): accept ':directory/' to get at the cache_tree
Date: Wed, 10 Jan 2007 01:54:43 +0100 (CET)
Message-ID: <Pine.LNX.4.63.0701100151230.22628@wbgn013.biozentrum.uni-wuerzburg.de>
References: <Pine.LNX.4.63.0701091502030.22628@wbgn013.biozentrum.uni-wuerzburg.de>
 <7vodp7iwzu.fsf@assigned-by-dhcp.cox.net>
 <Pine.LNX.4.63.0701100108460.22628@wbgn013.biozentrum.uni-wuerzburg.de>
 <7vtzyzhg47.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jan 10 01:54:59 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H4Rk2-0007WK-Vn
	for gcvg-git@gmane.org; Wed, 10 Jan 2007 01:54:59 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932602AbXAJAyq (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 9 Jan 2007 19:54:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932603AbXAJAyq
	(ORCPT <rfc822;git-outgoing>); Tue, 9 Jan 2007 19:54:46 -0500
Received: from mail.gmx.net ([213.165.64.20]:45728 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S932602AbXAJAyp (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 9 Jan 2007 19:54:45 -0500
Received: (qmail invoked by alias); 10 Jan 2007 00:54:43 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO dumbo2) [132.187.25.13]
  by mail.gmx.net (mp045) with SMTP; 10 Jan 2007 01:54:43 +0100
X-Authenticated: #1490710
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7vtzyzhg47.fsf@assigned-by-dhcp.cox.net>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/36449>

Hi,

On Tue, 9 Jan 2007, Junio C Hamano wrote:

> Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
> 
> > It is still at what cache_name_pos(cp, namelen) pointed to, or NULL if 
> > the entry does not exist (e.g. there is no cache entry, or all cache 
> > entries are lexicographically smaller).
> >
> >> For example, would this work?
> >> 
> >> 	$ echo >t- && git add t-
> >>         $ git show :t
> >> 	$ git show :t/
> >
> > I think so: The code explicitely checks for a trailing '/'. (See second 
> > last line of the hunk you quoted.)
> 
> The comment was not about the trailing / version, but the one without.
> Have you tried them?

Of course not! I had the impression that cache_name_pos() just _had_ to 
find the correct spot, but of course you are right: it does not.

> >> > +			struct cache_tree *tree =
> >> > +				cache_tree_find(active_cache_tree, cp);
> >> > +			if (!cache_tree_fully_valid(tree)) {
> >> > +				ret = cache_tree_update(active_cache_tree,
> >> > +						active_cache, active_nr, 0, 0);
> >> > +				if (ret < 0)
> >> > +					return ret;
> >> 
> >> This gracefully errs out when the index is unmerged but fails to
> >> pretend the index knows about trees, if the unmerged part of
> >> index is outside the directory the user specified.
> >
> > That is correct. But in that case, we cannot sanely ask the question "what 
> > would the tree object look like if we committed right now?"
> 
> But that is not the question you are asking.  "git-ls-files t/"
> does work even though you still have cache.h unmerged in the
> index.

Ah! I retract that. I did _not_ want the recursive file list. I wanted the 
equivalent of HEAD:t/ _after_ a commit.

> > But then it turned out that I even use it before committing, like when I 
> > ask "what files would be in my next revision?" It is not a question 
> > arising daily, but sometimes it is interesting to see _before_ committing 
> > them. (Note that I am not only interested in the _modified_ files.)
> 
> So it really is about being able to say show while you mean ls-files.
> 
> I am not opposed to that goal at all.  I think it makes it
> easier to type.  But I think using cache-tree is a wrong
> approach.

Well, you are the master.

Ciao,
Dscho
