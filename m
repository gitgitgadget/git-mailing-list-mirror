X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Shawn Pearce <spearce@spearce.org>
Subject: Re: git bug? + question
Date: Sat, 4 Nov 2006 14:05:12 -0500
Message-ID: <20061104190512.GA2517@spearce.org>
References: <buoejsme6ho.fsf@dhapc248.dev.necel.com> <20061103162422.b0bf105e.seanlkml@sympatico.ca> <20061104050305.GA9003@spearce.org> <200611041852.23867.Josef.Weidendorfer@gmx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
NNTP-Posting-Date: Sat, 4 Nov 2006 19:05:36 +0000 (UTC)
Cc: Sean <seanlkml@sympatico.ca>, Junio C Hamano <junkio@cox.net>,
	Miles Bader <miles@gnu.org>, git@vger.kernel.org,
	Karl =?iso-8859-1?Q?Hasselstr=F6m?= <kha@treskal.com>
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Content-Disposition: inline
In-Reply-To: <200611041852.23867.Josef.Weidendorfer@gmx.de>
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/30936>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GgQpf-00012b-0z for gcvg-git@gmane.org; Sat, 04 Nov
 2006 20:05:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1753611AbWKDTF1 (ORCPT <rfc822;gcvg-git@m.gmane.org>); Sat, 4 Nov 2006
 14:05:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753614AbWKDTF1
 (ORCPT <rfc822;git-outgoing>); Sat, 4 Nov 2006 14:05:27 -0500
Received: from corvette.plexpod.net ([64.38.20.226]:2788 "EHLO
 corvette.plexpod.net") by vger.kernel.org with ESMTP id S1753610AbWKDTF0
 (ORCPT <rfc822;git@vger.kernel.org>); Sat, 4 Nov 2006 14:05:26 -0500
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173]
 helo=asimov.home.spearce.org) by corvette.plexpod.net with esmtpa (Exim 4.52)
 id 1GgQpH-0008Ft-3d; Sat, 04 Nov 2006 14:05:07 -0500
Received: by asimov.home.spearce.org (Postfix, from userid 1000) id
 BD68B20E491; Sat,  4 Nov 2006 14:05:12 -0500 (EST)
To: Josef Weidendorfer <Josef.Weidendorfer@gmx.de>
Sender: git-owner@vger.kernel.org

Josef Weidendorfer <Josef.Weidendorfer@gmx.de> wrote:
> On Saturday 04 November 2006 06:03, Shawn Pearce wrote:
> > After reading your reply you are probably correct.  I can see there
> > may be workflows that want every remote branch also created as a
> > local branch.
> > 
> > I could certainly live with a command line option to clone, e.g.:
> > 
> > 	git clone --only vmdvt,vmtip user@host:/path...
> 
> Still missing here: What branch should be checked out after
> cloning?

Ah.

I probably should have also stated that my users should be doing
-n as well with git clone, then using git checkout -b to create
a new branch from one of the refs they did clone.  (Reason is we
strictly follow a topic branch model of development, with even the
developer's local branches beginning with their initials.)

But you have a good point.  Cloning with say --only as I show above
might be confusing as its not defined what branch to checkout after
the clone.
 
> Perhaps it is better to extend git-checkout to allow to do the
> correct thing when the user specifies a read-only branch from
> refs/remotes. E.g. with refs/remotes/origin/vmdvt,
> 
>  	git checkout origin/vmdvt
> 
> should create a new local branch refs/heads/vmdvt which forks
> from remotes/origin/vmdvt (and abort with
> error if refs/heads/vmdvt already exists without being the local
> development branch for remotes/origin/vmdvt)

Yes, that would work for our workflow.  I won't try to speak about
anyone else's.

I'd also say that if the local branch (refs/heads/vmdvt) exists and
if `git pull . origin/vmdvt` is going to be a fast-forward that the
fast-forward should happen during the checkout.  That way after the
checkout is complete you really do have what is in origin/vmdvt,
but are sitting on a local branch.

-- 
