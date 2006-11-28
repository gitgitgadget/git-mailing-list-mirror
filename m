X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-2.4 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Daniel Barkalow <barkalow@iabervon.org>
Subject: Re: [RFC] Submodules in GIT
Date: Tue, 28 Nov 2006 12:28:47 -0500 (EST)
Message-ID: <Pine.LNX.4.64.0611281218290.20138@iabervon.org>
References: <20061121223130.GA24909@nan92-1-81-57-214-146.fbx.proxad.net>
 <Pine.LNX.4.64.0611211437430.3338@woody.osdl.org>
 <20061121235429.GH5443@nan92-1-81-57-214-146.fbx.proxad.net>
 <20061122034056.GB23856@spearce.org> <20061123232313.GB24909@nan92-1-81-57-214-146.fbx.proxad.net>
 <20061125065338.GC4528@spearce.org> <20061125111235.GO5443@nan92-1-81-57-214-146.fbx.proxad.net>
 <Pine.LNX.4.64.0611251037000.6991@woody.osdl.org> <45689747.3020403@midwinter.com>
 <Pine.LNX.4.64.0611251128170.3483@woody.osdl.org>
 <20061125234908.GC24909@nan92-1-81-57-214-146.fbx.proxad.net>
 <Pine.LNX.4.64.0611251936590.3483@woody.osdl.org> <Pine.LNX.4.64.0611260241320.20138@iabervon.org>
 <456C0313.3020308@op5.se>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
NNTP-Posting-Date: Tue, 28 Nov 2006 17:29:15 +0000 (UTC)
Cc: Linus Torvalds <torvalds@osdl.org>,
	Yann Dirson <ydirson@altern.org>,
	Steven Grimm <koreth@midwinter.com>, git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
In-Reply-To: <456C0313.3020308@op5.se>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/32553>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1Gp6lH-0007Do-P8 for gcvg-git@gmane.org; Tue, 28 Nov
 2006 18:28:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S935909AbWK1R2t (ORCPT <rfc822;gcvg-git@m.gmane.org>); Tue, 28 Nov 2006
 12:28:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S935911AbWK1R2t
 (ORCPT <rfc822;git-outgoing>); Tue, 28 Nov 2006 12:28:49 -0500
Received: from iabervon.org ([66.92.72.58]:21260 "EHLO iabervon.org") by
 vger.kernel.org with ESMTP id S935909AbWK1R2s (ORCPT
 <rfc822;git@vger.kernel.org>); Tue, 28 Nov 2006 12:28:48 -0500
Received: (qmail 10119 invoked by uid 1000); 28 Nov 2006 12:28:47 -0500
Received: from localhost (sendmail-bs@127.0.0.1) by localhost with SMTP; 28
 Nov 2006 12:28:47 -0500
To: Andreas Ericsson <ae@op5.se>
Sender: git-owner@vger.kernel.org

On Tue, 28 Nov 2006, Andreas Ericsson wrote:

> Daniel Barkalow wrote:
> > On Sat, 25 Nov 2006, Linus Torvalds wrote:
> > > I'd actually suggest that "git commit -a" with non-clean submodules error
> > > out for that reason
> > 
> > Just have it run "git commit -a" in each dirty submodule recursively as part
> > of preparing the index, since that's what the user wants to do anyway, and
> > nothing already done would be affected.
> > 
> 
> Running "commit -a" is definitely the wrong thing to do, as it prevents one
> from using the index at all. Erroring out if the submodules are dirty, or just
> accepting the fact that they are and taking whatever commit HEAD points to is
> *always* preferrable.

I don't think anyone would actually use the index in submodules but not in 
the supermodule. If submodules are seen mostly as ordinary directories as 
far as the supermodule's working directory is concerned, it wouldn't make 
sense to not commit dirty state in a subdirectory with -a just because 
it's a submodule.

It would be wrong to do "commit -a" in submodules if the supermodule 
weren't being committed with -a, of course.

> > "git commit -a -m <message>" should probably fail, of course.
> > 
> 
> Why? There's no reason to rob this command of its power just because we're
> using submodules.

It should fail if there are dirty submodules, because the user needs to 
provide a commit message for each of them, and only one commit message can 
be provided this way, and -m inhibits invoking an editor.

	-Daniel
