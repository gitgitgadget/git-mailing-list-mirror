X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Shawn Pearce <spearce@spearce.org>
Subject: Re: multi-project repos (was Re: Cleaning up git user-interface warts)
Date: Fri, 17 Nov 2006 12:15:32 -0500
Message-ID: <20061117171532.GE32597@spearce.org>
References: <Pine.LNX.4.64.0611151908130.3349@woody.osdl.org> <455C412D.1030408@xs4all.nl> <Pine.LNX.4.64.0611160814560.3349@woody.osdl.org> <455C94FA.3050903@xs4all.nl> <Pine.LNX.4.64.0611160904010.3349@woody.osdl.org> <455CA2A8.5010700@xs4all.nl> <Pine.LNX.4.64.0611160958170.3349@woody.osdl.org> <Pine.LNX.4.64.0611161039160.3349@woody.osdl.org> <20061117162605.GA32597@spearce.org> <87bqn6qav2.wl%cworth@cworth.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
NNTP-Posting-Date: Fri, 17 Nov 2006 17:17:15 +0000 (UTC)
Cc: Linus Torvalds <torvalds@osdl.org>,
	Han-Wen Nienhuys <hanwen@xs4all.nl>,
	Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Content-Disposition: inline
In-Reply-To: <87bqn6qav2.wl%cworth@cworth.org>
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/31715>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1Gl7JV-0003tj-QK for gcvg-git@gmane.org; Fri, 17 Nov
 2006 18:15:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1755750AbWKQRPk (ORCPT <rfc822;gcvg-git@m.gmane.org>); Fri, 17 Nov 2006
 12:15:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755751AbWKQRPk
 (ORCPT <rfc822;git-outgoing>); Fri, 17 Nov 2006 12:15:40 -0500
Received: from corvette.plexpod.net ([64.38.20.226]:44437 "EHLO
 corvette.plexpod.net") by vger.kernel.org with ESMTP id S1755749AbWKQRPj
 (ORCPT <rfc822;git@vger.kernel.org>); Fri, 17 Nov 2006 12:15:39 -0500
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173]
 helo=asimov.home.spearce.org) by corvette.plexpod.net with esmtpa (Exim 4.52)
 id 1Gl7JI-0004cO-Np; Fri, 17 Nov 2006 12:15:28 -0500
Received: by asimov.home.spearce.org (Postfix, from userid 1000) id
 08E4720E469; Fri, 17 Nov 2006 12:15:32 -0500 (EST)
To: Carl Worth <cworth@cworth.org>
Sender: git-owner@vger.kernel.org

Carl Worth <cworth@cworth.org> wrote:
> Yes, this was my exact thought when reading what Linus
> wrote. ORIG_HEAD might be fine and all, but it pales in functionality
> compared to what reflog provides.
> 
> I would very much like to see reflog getting first-class citizen
> support in git:
> 
> 1. Be on by default

I have:

	git repo-config --global core.logAllRefUpdates true

especially since Junio fixed it to only create logs for heads and
not tags.  That way its on by default for me.  But I think it should
be on by default in the next version of Git.
 
> 2. Get documented in all the right places, (much better than adding
>    documentation for ORIG_HEAD in my opinion)

Agreed.  I'm not likely to do it anytime soon however, so I'm hoping
someone else will do it...  :-)
 
> 3. Tighter integration with branch manipulations. Do we already delete
>    reflog when deleting a branch? We don't have a branch rename
>    operation, but if we get one, renaming the reflog should go
>    hand-in-hand, etc.

Yes, we delete the log when we delete the branch, and we prune
back the empty directories too just like we do on the branch side,
so that new branches can be correctly created.

There was a recent discussion about that from Junio if I recall.
Several people that I work with have asked that branch rename
support be added to Git, and that if you rename the branch the
reflog follows.  Because in their mind they are simply changing
the name of the branch, any old history of that branch should
stick around.

I tried to think of an option to "git branch" to do the rename but
kept thinking that:

	git rename-branch old new

is the better syntax...  even though that's command number 133
or something like that...

We should stick a "null" event into the reflog during a branch
rename.  Make both the old and new SHA1 the current SHA1 but drop
a message in saying "renamed branch old -> new" (for example).

-- 
