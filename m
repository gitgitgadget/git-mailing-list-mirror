From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: [EGIT PATCH 1/4] Change history page table to SWT.VIRTUAL.
Date: Tue, 1 Apr 2008 00:12:03 -0400
Message-ID: <20080401041203.GR10274@spearce.org>
References: <1206890314-3712-1-git-send-email-rogersoares@intelinet.com.br> <20080331053430.GJ10274@spearce.org> <47F1AB1B.90309@intelinet.com.br> <20080401033614.GP10274@spearce.org> <47F1B1D9.3090209@intelinet.com.br>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org, robin.rosenberg@dewire.com
To: "Roger C. Soares" <rogersoares@intelinet.com.br>
X-From: git-owner@vger.kernel.org Tue Apr 01 07:05:51 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JgYgO-0008BV-Iw
	for gcvg-git-2@gmane.org; Tue, 01 Apr 2008 07:05:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751309AbYDAFEe (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 1 Apr 2008 01:04:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751430AbYDAFEe
	(ORCPT <rfc822;git-outgoing>); Tue, 1 Apr 2008 01:04:34 -0400
Received: from corvette.plexpod.net ([64.38.20.226]:49578 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750914AbYDAFEe (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 1 Apr 2008 01:04:34 -0400
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173] helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.68)
	(envelope-from <spearce@spearce.org>)
	id 1JgYfc-0001GH-RA; Tue, 01 Apr 2008 01:04:28 -0400
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id D71BF20FBAE; Tue,  1 Apr 2008 00:12:03 -0400 (EDT)
Content-Disposition: inline
In-Reply-To: <47F1B1D9.3090209@intelinet.com.br>
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/78631>

"Roger C. Soares" <rogersoares@intelinet.com.br> wrote:
>
> >Hmm.  I didn't notice that, but at this point its so damn fast for
> >me that I don't have the reflexes to really try and use the table
> >before GenerateHistoryJob is complete.  I'll have to add some sleeps
> >in there to make it slow down its work and see if I can reproduce
> >what you are describing.
>
> Yep, I noticed it while debuging and don't think it's very important. 
> I'm very happy with the current speed and it's also almost instant to 
> me. I think the lazy provider could be of some help in case someone is 
> reading from a slow nfs partition or something like that. It's very 
> border case thought.

Actually I think the trick to use there is the "early output
and restart" that C Git's rev-list and gitk learned about two
months back.  We don't do this in jgit yet and that means we have
to produce _all_ commits before we can topologically sort them and
return even the first commit.

We should be able to produce results immediately and then force
a reset and redraw of the table when we find the rare cases where
topological sorting gets violated by honoring the standard commit
date ordering.

There aren't many such cases in git.git or linux-2.6.git.  They only
happen if clock skew is enough that folks are able to create multiple
commits at the same time that are out of order according to topology.
And remember that in the GUI we do wind up redrawing the table anyway
as we add new items to the end of it.  So its really no big deal
to just reset everything and restart when we find the violations.

Its on my list of things to add to the jgit machinary, but I'm also
looking to get push[*1*] and merge implemented.  I am reasonably
happy with the performance of the History view, as its actually
now usuable on real projects.  So its time to add new features,
rather than optimizing old ones.


[*1*]  Hopefully this is a successful GSoC 2008 project.  ;-)

-- 
Shawn.
