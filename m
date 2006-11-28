X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-2.6 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Daniel Barkalow <barkalow@iabervon.org>
Subject: Re: [RFC] Submodules in GIT
Date: Tue, 28 Nov 2006 13:37:54 -0500 (EST)
Message-ID: <Pine.LNX.4.64.0611281315020.20138@iabervon.org>
References: <20061125065338.GC4528@spearce.org>
 <20061125111235.GO5443@nan92-1-81-57-214-146.fbx.proxad.net>
 <Pine.LNX.4.64.0611251037000.6991@woody.osdl.org> <45689747.3020403@midwinter.com>
 <Pine.LNX.4.64.0611251128170.3483@woody.osdl.org>
 <20061125234908.GC24909@nan92-1-81-57-214-146.fbx.proxad.net>
 <Pine.LNX.4.64.0611251936590.3483@woody.osdl.org> <Pine.LNX.4.64.0611260241320.20138@iabervon.org>
 <456C0313.3020308@op5.se> <Pine.LNX.4.64.0611281218290.20138@iabervon.org>
 <20061128180817.GA12463MdfPADPa@greensroom.kotnet.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
NNTP-Posting-Date: Tue, 28 Nov 2006 18:38:06 +0000 (UTC)
Cc: Andreas Ericsson <ae@op5.se>, Linus Torvalds <torvalds@osdl.org>,
	Yann Dirson <ydirson@altern.org>,
	Steven Grimm <koreth@midwinter.com>, git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
In-Reply-To: <20061128180817.GA12463MdfPADPa@greensroom.kotnet.org>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/32562>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1Gp7qE-0000oM-KF for gcvg-git@gmane.org; Tue, 28 Nov
 2006 19:38:02 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1758742AbWK1Sh4 (ORCPT <rfc822;gcvg-git@m.gmane.org>); Tue, 28 Nov 2006
 13:37:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758741AbWK1Sh4
 (ORCPT <rfc822;git-outgoing>); Tue, 28 Nov 2006 13:37:56 -0500
Received: from iabervon.org ([66.92.72.58]:51978 "EHLO iabervon.org") by
 vger.kernel.org with ESMTP id S1758734AbWK1Shz (ORCPT
 <rfc822;git@vger.kernel.org>); Tue, 28 Nov 2006 13:37:55 -0500
Received: (qmail 12989 invoked by uid 1000); 28 Nov 2006 13:37:54 -0500
Received: from localhost (sendmail-bs@127.0.0.1) by localhost with SMTP; 28
 Nov 2006 13:37:54 -0500
To: skimo@liacs.nl
Sender: git-owner@vger.kernel.org

On Tue, 28 Nov 2006, Sven Verdoolaege wrote:

> On Tue, Nov 28, 2006 at 12:28:47PM -0500, Daniel Barkalow wrote:
> > It would be wrong to do "commit -a" in submodules if the supermodule 
> > weren't being committed with -a, of course.
> 
> What if you say "git commit submodule" ?

Obviously no -a, as I said.

> If you agree with the above, then why should "git commit -a"
> do any different from "git commit submodule" if submodule was
> the only thing that got changed ?

If submodule was the only thing that got changed, it's not dirty; if it 
were dirty, some of its contents would also have gotten changed. Surely:

"git commit submodule/foo bar"

should do "git commit foo" in submodule, and then commit the supermodule 
with the new commit for the submodule and the change to bar. And so
"submodule/foo" is something you could commit changes to, so it should get 
picked up by -a.

Of course, if submodule *is* the *only* thing that changed (e.g., you did 
a fast-forward merge in it, or you've previously committed it completely), 
there won't be a "commit -a" in it, because that would just generate a 
gratuitous commit.

	-Daniel
