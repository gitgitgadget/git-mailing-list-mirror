X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-2.2 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Daniel Barkalow <barkalow@iabervon.org>
Subject: Re: [RFC] Submodules in GIT
Date: Sun, 26 Nov 2006 03:05:15 -0500 (EST)
Message-ID: <Pine.LNX.4.64.0611260241320.20138@iabervon.org>
References: <20061121223130.GA24909@nan92-1-81-57-214-146.fbx.proxad.net>
 <Pine.LNX.4.64.0611211437430.3338@woody.osdl.org>
 <20061121235429.GH5443@nan92-1-81-57-214-146.fbx.proxad.net>
 <20061122034056.GB23856@spearce.org> <20061123232313.GB24909@nan92-1-81-57-214-146.fbx.proxad.net>
 <20061125065338.GC4528@spearce.org> <20061125111235.GO5443@nan92-1-81-57-214-146.fbx.proxad.net>
 <Pine.LNX.4.64.0611251037000.6991@woody.osdl.org> <45689747.3020403@midwinter.com>
 <Pine.LNX.4.64.0611251128170.3483@woody.osdl.org>
 <20061125234908.GC24909@nan92-1-81-57-214-146.fbx.proxad.net>
 <Pine.LNX.4.64.0611251936590.3483@woody.osdl.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
NNTP-Posting-Date: Sun, 26 Nov 2006 08:05:33 +0000 (UTC)
Cc: Yann Dirson <ydirson@altern.org>,
	Steven Grimm <koreth@midwinter.com>, git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
In-Reply-To: <Pine.LNX.4.64.0611251936590.3483@woody.osdl.org>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/32333>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GoF0y-0007SB-VI for gcvg-git@gmane.org; Sun, 26 Nov
 2006 09:05:29 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S966919AbWKZIFT (ORCPT <rfc822;gcvg-git@m.gmane.org>); Sun, 26 Nov 2006
 03:05:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S967329AbWKZIFS
 (ORCPT <rfc822;git-outgoing>); Sun, 26 Nov 2006 03:05:18 -0500
Received: from iabervon.org ([66.92.72.58]:50954 "EHLO iabervon.org") by
 vger.kernel.org with ESMTP id S966919AbWKZIFR (ORCPT
 <rfc822;git@vger.kernel.org>); Sun, 26 Nov 2006 03:05:17 -0500
Received: (qmail 20571 invoked by uid 1000); 26 Nov 2006 03:05:15 -0500
Received: from localhost (sendmail-bs@127.0.0.1) by localhost with SMTP; 26
 Nov 2006 03:05:15 -0500
To: Linus Torvalds <torvalds@osdl.org>
Sender: git-owner@vger.kernel.org

On Sat, 25 Nov 2006, Linus Torvalds wrote:

> On Sun, 26 Nov 2006, Yann Dirson wrote:
> > 
> > Also, I'd rather expect "git-commit -a" outside of any submodule to
> > commit everything in the supermodule, triggering submodule commits as an
> > intermediate step when needed - just like "git-commit -a" does not
> > require to manually specify subdirectories to inclue in the commit.  I'd
> > rather expect a special flag to exclude submodules from a commit.
> 
> So, how do you do commit messages? It generally doesn't make sense to 
> share the same commit message for submodules - the sub-commits generally 
> do different things.

The same way you do the first commit message. Ask independantly for each 
commit message in sequence with enough context in the comment section that 
you know what you're talking about.

> I'd actually suggest that "git commit -a" with non-clean submodules error 
> out for that reason, with something like
> 
> 	submodule 'src/xyzzy' is not up-to-date, please commit changes to 
> 	that first.
> 
> exactly because you really generally should consider the submodule commits 
> to be a separate phase.

I think this is getting close to the classic usability blunder of having 
the program tell you what you should have done instead of what you did, 
and then making you do it yourself, rather than just doing it.

Just have it run "git commit -a" in each dirty submodule recursively as 
part of preparing the index, since that's what the user wants to do 
anyway, and nothing already done would be affected.

"git commit -a -m <message>" should probably fail, of course.

	-Daniel
