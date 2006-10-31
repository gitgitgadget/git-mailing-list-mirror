X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Shawn Pearce <spearce@spearce.org>
Subject: Re: [PATCH 2/2] Teach receive-pack how to keep pack files based on object count.
Date: Tue, 31 Oct 2006 16:29:42 -0500
Message-ID: <20061031212942.GA24184@spearce.org>
References: <20061031075704.GB7691@spearce.org> <Pine.LNX.4.64.0610311447250.11384@xanadu.home> <20061031201148.GD23671@spearce.org> <Pine.LNX.4.64.0610311559150.11384@xanadu.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
NNTP-Posting-Date: Tue, 31 Oct 2006 21:30:09 +0000 (UTC)
Cc: Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0610311559150.11384@xanadu.home>
User-Agent: Mutt/1.5.11
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - corvette.plexpod.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [0 0] / [47 12]
X-AntiAbuse: Sender Address Domain - spearce.org
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/30598>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1Gf1BB-00079k-9T for gcvg-git@gmane.org; Tue, 31 Oct
 2006 22:29:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1946030AbWJaV3t (ORCPT <rfc822;gcvg-git@m.gmane.org>); Tue, 31 Oct 2006
 16:29:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1946043AbWJaV3t
 (ORCPT <rfc822;git-outgoing>); Tue, 31 Oct 2006 16:29:49 -0500
Received: from corvette.plexpod.net ([64.38.20.226]:13549 "EHLO
 corvette.plexpod.net") by vger.kernel.org with ESMTP id S1946030AbWJaV3r
 (ORCPT <rfc822;git@vger.kernel.org>); Tue, 31 Oct 2006 16:29:47 -0500
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173]
 helo=asimov.home.spearce.org) by corvette.plexpod.net with esmtpa (Exim 4.52)
 id 1Gf1At-0002Np-HZ; Tue, 31 Oct 2006 16:29:35 -0500
Received: by asimov.home.spearce.org (Postfix, from userid 1000) id
 466F220FB0C; Tue, 31 Oct 2006 16:29:42 -0500 (EST)
To: Nicolas Pitre <nico@cam.org>
Sender: git-owner@vger.kernel.org

Nicolas Pitre <nico@cam.org> wrote:
> On Tue, 31 Oct 2006, Shawn Pearce wrote:
> > Nicolas Pitre <nico@cam.org> wrote:
> > > I think this should be solved before rx packs are actually stored as 
> > > packs though.  Otherwise people will end up with unwanted .keep files 
> > > left around.  Maybe having a much bigger default for object number 
> > > treshold for the time being?  (unless this patch is applied to "next" at 
> > > the same time as another one that actually deals with those .keep 
> > > files).
> > 
> > Its next on my list of things to do.  Hopefully I'll be able to
> > implement it today.
> > 
> > I'm thinking of just brute forcing it: put enough identifying data
> > into the .keep file to make it unique, then go through every local
> > pack and look at their .keep file; if the content matches what
> > receive-pack asked index-pack to put there then remove it.
> 
> Ouch.  What about the patch below?  It covers only the pull/fetch case, 
> but covering the push case shouldn't be that hard either (simply use a 
> pipe to read index-pack's stdout and capture the pack name).
> 
> I used "pack" <tab> <sha1> so it is easy to pick out of the list of refs 
> that usually comes over the stream in the fetch case (if I understood 
> that part right).

I thought about using a pipe too, but in the case of receive-pack
it looked like index-pack was sending something back to the push
end of the connection.  I didn't dig into the code enough to see
what that was and how to do the same in receive-pack itself.  The
brute force approach is horrible but simple.  ;-)

I'll look at your patch and what I need to do make a pipe work here,
because its clearly the better solution.

-- 
