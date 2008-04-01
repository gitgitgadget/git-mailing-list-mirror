From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: [EGIT PATCH 2/4] FindToolbar port to the new history page.
Date: Tue, 1 Apr 2008 00:02:41 -0400
Message-ID: <20080401040241.GQ10274@spearce.org>
References: <1206890325-3732-1-git-send-email-rogersoares@intelinet.com.br> <20080331061914.GK10274@spearce.org> <47F1AF86.3030503@intelinet.com.br>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org, robin.rosenberg@dewire.com
To: "Roger C. Soares" <rogersoares@intelinet.com.br>
X-From: git-owner@vger.kernel.org Tue Apr 01 06:03:38 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JgXij-0003Jp-HK
	for gcvg-git-2@gmane.org; Tue, 01 Apr 2008 06:03:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750792AbYDAECr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 1 Apr 2008 00:02:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750783AbYDAECr
	(ORCPT <rfc822;git-outgoing>); Tue, 1 Apr 2008 00:02:47 -0400
Received: from corvette.plexpod.net ([64.38.20.226]:35204 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750748AbYDAECr (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 1 Apr 2008 00:02:47 -0400
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173] helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.68)
	(envelope-from <spearce@spearce.org>)
	id 1JgXhf-0004lH-32; Tue, 01 Apr 2008 00:02:31 -0400
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id D3AB920FBAE; Tue,  1 Apr 2008 00:02:41 -0400 (EDT)
Content-Disposition: inline
In-Reply-To: <47F1AF86.3030503@intelinet.com.br>
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/78623>

"Roger C. Soares" <rogersoares@intelinet.com.br> wrote:
> Shawn O. Pearce escreveu:
> >Hmm.  So what functionality did the highlight flag + RevFilter
> >not get you?  It supports both regex as well as non-regex matches,
> >is quick, and can be joined together with other filters.  A lot of
> >the code in the FindToolbarThread should drop out.
> 
> Ok, so, my motivation first. I don't have too much time to work on egit 
> but I'm interested in using your work in my build. So, I'm pushing the 
> features I need. This patch was intended as a simple port of the 
> existing FindToolbar to the new history page so I can use it.

OK, that makes sense.  Under that basis I'm willing to take your port
in, especially if the other items I mentioned that you said "Ok" to
were cleaned up.

> I tried the applyFlags you described but it doesn't have a monitor 
> approach to give feedback to the toolbar so it knows when to refresh the 
> table and to select the first match, or to go red when nothing was 
> found. I also couldn't find from the highlight flag + RevFilter solution 
> how to get the total rows encountered and the index of a match so the 
> toolbar can show that the selected match is number 2 from 10.

OK.  Major gaps in the jgit API.  I now understand better what you
were needing here.  I'll probably go another around on that API
soon and see if I can't update your port once I have these things
down at the jgit level.
 
> So, this patch was intented as a port. I'm not sure everything related 
> to search should go inside jgit, but I agree that RevFilters should be 
> reused. I was thinking about it as an improvement after the port, it's 
> not my priority right now but someone else can do it? ;)

Right.  :)

> >So this is doing basically the same thing as the highlight RevFlag
> >(give a boolean about match status for a given RevCommit) but needs
> >to consult a HashMap by creating a temporary boxed Integer, and this
> >is deep down inside of the painting code for the table.  Urrgh.
> 
> The map is used to give the x from total information. When using a 
> VIRTUAL table it doesn't have a noticable performance impact because 
> only a small set is required at a time.

Hmm.  Not really.  We're still beating on that paint listener every
time the screen needs to draw.  I don't think SWT is double buffering
the table either, so every redraw event is coming through this code.
Be nice if we didn't have to suffer through a HashMap hit every time.

> >Would it make sense to abstract out and reuse the BooleanPrefAction
> >class I added to GitHistoryPage in ea3f1e7a7684b8?  
> >  
> Probably, I'll get a look on it.

This is maybe something to clean up later, after the port is
initially in my tree.

-- 
Shawn.
