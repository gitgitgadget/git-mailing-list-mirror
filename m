From: Daniel Barkalow <barkalow@iabervon.org>
Subject: Re: [PATCH] Merge non-first refs that match first refspec
Date: Fri, 28 Sep 2007 00:40:36 -0400 (EDT)
Message-ID: <Pine.LNX.4.64.0709280026240.5926@iabervon.org>
References: <Pine.LNX.4.64.0709272351010.5926@iabervon.org>
 <20070928041509.GU3099@spearce.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Fri Sep 28 06:40:47 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ib7eg-0006l6-Dg
	for gcvg-git-2@gmane.org; Fri, 28 Sep 2007 06:40:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754969AbXI1Ekj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 28 Sep 2007 00:40:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754927AbXI1Ekj
	(ORCPT <rfc822;git-outgoing>); Fri, 28 Sep 2007 00:40:39 -0400
Received: from iabervon.org ([66.92.72.58]:57938 "EHLO iabervon.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754698AbXI1Eki (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 28 Sep 2007 00:40:38 -0400
Received: (qmail 24982 invoked by uid 1000); 28 Sep 2007 04:40:36 -0000
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 28 Sep 2007 04:40:36 -0000
In-Reply-To: <20070928041509.GU3099@spearce.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/59359>

On Fri, 28 Sep 2007, Shawn O. Pearce wrote:

> My understanding of the old code was that it should do what Junio
> was reporting as broken:

Agreed; that's why I thought there must be something wrong with it.

>   - when i == 0 this is the first remote.$foo.fetch;
>   - when has_merge == 0 we have no branch.$name.merge;
>   - when ref_map != NULL we have at least one ref from this fetch spec;
>   - when fetch[0].src == ref_map->name it wasn't a wildcard spec;
> 
> The if conditional above was ordered the way it is so we can skip
> the more expensive operation (the strcmp) most of them time through
> the loop iteration.
> 
> The only way I can see the old code was failing was if ref_map
> as returned by get_fetch_map() pointed to more than one refspec.
> But for that to be true then fetch[1].src must have been a wildcard,
> in which case the strcmp() would fail.  So we should only ever
> get one entry, it should be the first entry, and dammit it should
> have matched.

That is the analysis that the original code is based on, yes. But it's not 
the easiest thing to follow, and I misunderstood it earlier this evening 
(prompted by the claim that it wasn't working, mostly). It's probably 
worth checking remote->fetch[0].pattern instead of the strcmp, anyway, 
since that's clearer and cheaper anyway.

> How/why are we getting cases where fetch[0].src isn't in the first
> entry in ref_map?  What are those other entries?  Are they possibly
> going to also match fetch[0].src and cause more than one branch
> to merge?

Beats me; Junio, what's your test case?

> BTW, thanks for looking at this.  I didn't have time to get to it
> this week and now I'm really unlikely to be able to do so until
> after I get back from San Jose.  I have too many things crammed
> into this next week. :-\

No problem. You fixed plenty of my other bugs in this code, and it's 
getting so close to done.

	-Daniel
*This .sig left intentionally blank*
