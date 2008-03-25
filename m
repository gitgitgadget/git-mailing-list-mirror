From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: faster egit history page and a pure java "gitk"
Date: Tue, 25 Mar 2008 00:43:08 -0400
Message-ID: <20080325044308.GA4759@spearce.org>
References: <20080324092726.GQ8410@spearce.org> <47E7ADA3.2060906@intelinet.com.br>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Robin Rosenberg <robin.rosenberg@dewire.com>, git@vger.kernel.org
To: "Roger C. Soares" <rogersoares@intelinet.com.br>
X-From: git-owner@vger.kernel.org Tue Mar 25 05:44:15 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Je117-0002KQ-2n
	for gcvg-git-2@gmane.org; Tue, 25 Mar 2008 05:44:09 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751873AbYCYEnR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 25 Mar 2008 00:43:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750733AbYCYEnR
	(ORCPT <rfc822;git-outgoing>); Tue, 25 Mar 2008 00:43:17 -0400
Received: from corvette.plexpod.net ([64.38.20.226]:58964 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751171AbYCYEnQ (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 25 Mar 2008 00:43:16 -0400
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173] helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.68)
	(envelope-from <spearce@spearce.org>)
	id 1Je10A-0002Fw-Bt; Tue, 25 Mar 2008 00:43:10 -0400
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id 997B620FBAE; Tue, 25 Mar 2008 00:43:08 -0400 (EDT)
Content-Disposition: inline
In-Reply-To: <47E7ADA3.2060906@intelinet.com.br>
User-Agent: Mutt/1.5.11
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - corvette.plexpod.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - spearce.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/78144>

"Roger C. Soares" <rogersoares@intelinet.com.br> wrote:
> Shawn O. Pearce escreveu:
> >OK, so I decided a few weeks back that the history page was not fast
> >enough.  I think I've spent the past 3 weeks writing true revision
> >machinary for jgit, and now connecting it up to a UI visualizer.
> >
> >  git://repo.or.cz/egit/spearce.git plotter
> >
> >The history page has been completely replaced.  I saw Roger has
> >some patches against the current history page.  :-|
> 
> Hi Shawn. This is awesome, I can't wait to see this integrated in the 
> main repo :)
> 
> I don't spend much time working on egit so I usually take a while to 
> make small things, but I can certainly merge my patches on top of yours.
> 
> Robin, how should I proceed, resend all my patches from the weekend on 
> top of Shawn's tree?

I just pushed a newer version out that contains support for showing
commits using a bold font if the commit has the highlightFlag set
on it.  I assume you were trying to work on a feature like gitk
has where you can type in a string and have gitk bold all of the
commits that contain that string in the message, right?

If you look at the newer internal.history.GitHistoryPage class there
is a historyFlag available as an instance member.  We also have an
SWTCommitList allocated in the inputSet() method.  The SWTCommitList
has an applyFlag method that accepts a RevFilter and adds the passed
RevFlag onto any commit that matches the filter.

There are a lot of RevFilter implementations, take a look at the
revwalk.filter package, or see the command line parsing code in
RevWalkTextBuiltin.  We have ones for author, committer, message...

So a good part of the code is there to do a bold/unbold thing.
There's also indexOf and lastIndexOf methods on SWTCommitList that
can search for the highlightFlag in either direction from a given
row index, making a prev/next feature pretty easy.

I decided to leave some low hanging fruit.  There's bigger and
more complex issues still lurking in the revwalk/treewalk features.

-- 
Shawn.
