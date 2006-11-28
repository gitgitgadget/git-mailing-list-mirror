X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Shawn Pearce <spearce@spearce.org>
Subject: Re: [RFC] Submodules in GIT
Date: Tue, 28 Nov 2006 16:10:12 -0500
Message-ID: <20061128211012.GJ28337@spearce.org>
References: <Pine.LNX.4.64.0611251128170.3483@woody.osdl.org> <20061125234908.GC24909@nan92-1-81-57-214-146.fbx.proxad.net> <Pine.LNX.4.64.0611251936590.3483@woody.osdl.org> <Pine.LNX.4.64.0611260241320.20138@iabervon.org> <456C0313.3020308@op5.se> <Pine.LNX.4.64.0611281218290.20138@iabervon.org> <20061128180817.GA12463MdfPADPa@greensroom.kotnet.org> <Pine.LNX.4.64.0611281315020.20138@iabervon.org> <20061128190618.GB12463MdfPADPa@greensroom.kotnet.org> <Pine.LNX.4.64.0611281407370.20138@iabervon.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
NNTP-Posting-Date: Tue, 28 Nov 2006 21:10:42 +0000 (UTC)
Cc: skimo@liacs.nl, Andreas Ericsson <ae@op5.se>,
	Linus Torvalds <torvalds@osdl.org>,
	Yann Dirson <ydirson@altern.org>,
	Steven Grimm <koreth@midwinter.com>, git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0611281407370.20138@iabervon.org>
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/32578>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GpADr-00061K-1V for gcvg-git@gmane.org; Tue, 28 Nov
 2006 22:10:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1755650AbWK1VKc (ORCPT <rfc822;gcvg-git@m.gmane.org>); Tue, 28 Nov 2006
 16:10:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755695AbWK1VKc
 (ORCPT <rfc822;git-outgoing>); Tue, 28 Nov 2006 16:10:32 -0500
Received: from corvette.plexpod.net ([64.38.20.226]:49346 "EHLO
 corvette.plexpod.net") by vger.kernel.org with ESMTP id S1755627AbWK1VKb
 (ORCPT <rfc822;git@vger.kernel.org>); Tue, 28 Nov 2006 16:10:31 -0500
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173]
 helo=asimov.home.spearce.org) by corvette.plexpod.net with esmtpa (Exim 4.52)
 id 1GpADM-0002j7-Vl; Tue, 28 Nov 2006 16:10:05 -0500
Received: by asimov.home.spearce.org (Postfix, from userid 1000) id
 1914020FB7F; Tue, 28 Nov 2006 16:10:12 -0500 (EST)
To: Daniel Barkalow <barkalow@iabervon.org>
Sender: git-owner@vger.kernel.org

Daniel Barkalow <barkalow@iabervon.org> wrote:
>   "cd submodule; git commit foo"
> 
> does the obvious thing, but that should be the same as
> 
>   "git commit submodule/foo" (since it normally is)
> 
> and then it makes sense to let you do multiple commits with a single 
> command when the paths end in different modules, since that's obviously 
> what you're requesting, and then -a must do all of them.

Except what if the submodules have different commit message
standards?  E.g. one requires signoff and another doesn't?  Or one
allows privately held information (e.g. its your coporate project)
and one doesn't (e.g. its an open source project you use/contribute
to)?

But slightly more practical: the change message for the superproject
might simply be "resolved bug X, caused by ...".  Which may make a
lot of sense to the top level project, but makes no sense at all
in a submodule involved in the fix as the submodule's developer
community doesn't even know what "X" is, let alone how "..." could
have caused it.

So you really need to think twice before you apply the same commit
message to every project, as each commit message needs to make sense
with that one submodule's limited scope, or within the supermodule's
larger scope.

But if you really still think that the same commit message makes
sense everywhere, we have 'git commit -F'.  Write it out in a file
and hand it off to -F in each module.  This would be easier if
git-ls-files grew a new option:

	vi ~/msg
	for m in $(git ls-files --submodules); do git commit -F ~/msg; done
	git commit -F ~/msg

-- 
