From: Chris Mason <mason@suse.com>
Subject: Re: [PATCH] improved delta support for git
Date: Fri, 13 May 2005 07:44:26 -0400
Message-ID: <200505130744.28544.mason@suse.com>
References: <Pine.LNX.4.62.0505112309480.5426@localhost.localdomain> <Pine.LNX.4.62.0505121110490.5426@localhost.localdomain> <7vbr7gicv8.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: Nicolas Pitre <nico@cam.org>, jon@blackcubes.dyndns.org,
	Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri May 13 13:37:01 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DWYTI-0004tF-5s
	for gcvg-git@gmane.org; Fri, 13 May 2005 13:36:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262331AbVEMLoi (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 13 May 2005 07:44:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262340AbVEMLoi
	(ORCPT <rfc822;git-outgoing>); Fri, 13 May 2005 07:44:38 -0400
Received: from cantor.suse.de ([195.135.220.2]:8862 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S262331AbVEMLoc (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 13 May 2005 07:44:32 -0400
Received: from extimap.suse.de (extimap.suse.de [195.135.220.6])
	(using TLSv1 with cipher EDH-RSA-DES-CBC3-SHA (168/168 bits))
	(No client certificate requested)
	by mx1.suse.de (Postfix) with ESMTP id 106441196;
	Fri, 13 May 2005 13:44:32 +0200 (CEST)
To: Junio C Hamano <junkio@cox.net>
User-Agent: KMail/1.8
In-Reply-To: <7vbr7gicv8.fsf@assigned-by-dhcp.cox.net>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

On Thursday 12 May 2005 13:16, Junio C Hamano wrote:
> >>>>> "NP" == Nicolas Pitre <nico@cam.org> writes:
> >>
> >> On 5/13/05, Chris Mason <mason@suse.com> wrote:
> >> > On Thursday 12 May 2005 00:36, Junio C Hamano wrote:
> >> > > It appears to me that changes to the make_sure_we_have_it() ...
> >> >
> >> > If we fetch the named object and it is a delta, the delta will either
> >> > depend on an object we already have or an object that we don't have. 
> >> > If we don't have it, the pull should find it while pulling other
> >> > commits we don't have.
>
> NP> 1) If you happen to already have the referenced object in your local
> NP>    repository then you're done.
>
> Yes.
>
> NP> 2) If not you pull the referenced object from the remote repository,
> NP>    repeat with #1 if it happens to be another delta object.
>
> Yes, that is the outline of what my (untested) patch does.
>
> Unless I am grossly mistaken, what Chris says is true only when
> we are pulling with -a flag to the git-*-pull family.  If we are
> pulling "partially near the tip", we do not necessarily pull
> "other commits we don't have", hence detecting delta's
> requirement at per-object level and pulling the dependent
> becomes necessary, which is essentially what you wrote in (2)
> above.
>
Yes, my post does assume that you're pulling everything and the repo you're 
pulling from has a sane state.  This should be the common case though, so I 
would suggest optimizing things to build a list of the delta objects and 
check them at the end to see if we didn't pull any.

We want the list of delta objects regardless, this way we can warn the user 
that they have pulled in deltas and give them the chance to convert them into 
full files.

-chris
