X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Shawn Pearce <spearce@spearce.org>
Subject: Re: git-PS1 bash prompt setting
Date: Mon, 27 Nov 2006 12:02:49 -0500
Message-ID: <20061127170249.GC6616@spearce.org>
References: <BAYC1-PASMTP037FDA6C6465F0541AC613AEE90@CEZ.ICE> <Pine.LNX.4.63.0611261524130.30004@wbgn013.biozentrum.uni-wuerzburg.de> <20061126094212.fde8cce7.seanlkml@sympatico.ca> <20061127065400.GA19174@spearce.org> <20061127075650.81a5a850.seanlkml@sympatico.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
NNTP-Posting-Date: Mon, 27 Nov 2006 17:03:21 +0000 (UTC)
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org, Theodore Tso <tytso@mit.edu>
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Content-Disposition: inline
In-Reply-To: <20061127075650.81a5a850.seanlkml@sympatico.ca>
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/32429>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1Gojsk-0007TL-HM for gcvg-git@gmane.org; Mon, 27 Nov
 2006 18:03:02 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1758412AbWK0RC6 (ORCPT <rfc822;gcvg-git@m.gmane.org>); Mon, 27 Nov 2006
 12:02:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758415AbWK0RC6
 (ORCPT <rfc822;git-outgoing>); Mon, 27 Nov 2006 12:02:58 -0500
Received: from corvette.plexpod.net ([64.38.20.226]:27879 "EHLO
 corvette.plexpod.net") by vger.kernel.org with ESMTP id S1758382AbWK0RC6
 (ORCPT <rfc822;git@vger.kernel.org>); Mon, 27 Nov 2006 12:02:58 -0500
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173]
 helo=asimov.home.spearce.org) by corvette.plexpod.net with esmtpa (Exim 4.52)
 id 1GojsS-0005QI-MM; Mon, 27 Nov 2006 12:02:44 -0500
Received: by asimov.home.spearce.org (Postfix, from userid 1000) id
 7364A20FB7F; Mon, 27 Nov 2006 12:02:49 -0500 (EST)
To: Sean <seanlkml@sympatico.ca>
Sender: git-owner@vger.kernel.org

Sean <seanlkml@sympatico.ca> wrote:
> On Mon, 27 Nov 2006 01:54:00 -0500
> Shawn Pearce <spearce@spearce.org> wrote:
> 
> > I'm using something like this, and will be adding it to
> > git-completion.bash tonight:
> > 
> > 	__git_ps1 ()
> > 	{
> > 		local b="$(git symbolic-ref HEAD 2>/dev/null)"
> > 		if [ -n "$b" ]; then echo "(${b##refs/heads/})"; fi
> > 	}
> > 	PS1='[\u@\h \W$(__git_ps1)]\$ '
> > 
> > it works very well...
> 
> Yeah, when I first coded it I even looked at making it a bash loadable
> to make it perform better but found the prototype to run acceptably,
> so never bothered.

When I originally coded the first version of __git_ps1 I was using
it on a Cygwin system, where the fork+exec of the external script
can take a little while.  The time to fork+exec two programs (script
and then git) is huge compared to just fork+exec of git by itself,
so I coded it as a function.  On the other hand my Mac OS X system
doesn't even blink at either implementation.

> If Git does get a --show-ps1 option, people will
> still be able to roll their own version to tweak the output format
> as you did above.  Hopefully the standard format will work for most
> though.

I'm not sure that's worth implementing in the core code.
Most shells that will let you invoke a command as part of their
prompt generation will also let you use builtin functions and do
some basic string manipulation (e.g. like I do above with bash).
At which point it is say 5 lines of shell (nicely formatted) to
craft a prompt string vs. 15-20 lines of C to parse the option,
read HEAD, and craft a prompt string.

If someone else contributes a --show-ps1 option that is useable as
a replacement for my __git_ps1 I'll gladly jump on board and change
to using it, but I just don't see a reason to write it myself.

-- 
