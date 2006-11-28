X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Daniel Barkalow <barkalow@iabervon.org>
Subject: Re: [RFC] Submodules in GIT
Date: Tue, 28 Nov 2006 15:41:01 -0500 (EST)
Message-ID: <Pine.LNX.4.64.0611281407370.20138@iabervon.org>
References: <Pine.LNX.4.64.0611251037000.6991@woody.osdl.org>
 <45689747.3020403@midwinter.com> <Pine.LNX.4.64.0611251128170.3483@woody.osdl.org>
 <20061125234908.GC24909@nan92-1-81-57-214-146.fbx.proxad.net>
 <Pine.LNX.4.64.0611251936590.3483@woody.osdl.org> <Pine.LNX.4.64.0611260241320.20138@iabervon.org>
 <456C0313.3020308@op5.se> <Pine.LNX.4.64.0611281218290.20138@iabervon.org>
 <20061128180817.GA12463MdfPADPa@greensroom.kotnet.org>
 <Pine.LNX.4.64.0611281315020.20138@iabervon.org>
 <20061128190618.GB12463MdfPADPa@greensroom.kotnet.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
NNTP-Posting-Date: Tue, 28 Nov 2006 20:41:27 +0000 (UTC)
Cc: Andreas Ericsson <ae@op5.se>, Linus Torvalds <torvalds@osdl.org>,
	Yann Dirson <ydirson@altern.org>,
	Steven Grimm <koreth@midwinter.com>, git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
In-Reply-To: <20061128190618.GB12463MdfPADPa@greensroom.kotnet.org>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/32575>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1Gp9lN-0008CS-Bv for gcvg-git@gmane.org; Tue, 28 Nov
 2006 21:41:09 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1755198AbWK1UlF (ORCPT <rfc822;gcvg-git@m.gmane.org>); Tue, 28 Nov 2006
 15:41:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755277AbWK1UlF
 (ORCPT <rfc822;git-outgoing>); Tue, 28 Nov 2006 15:41:05 -0500
Received: from iabervon.org ([66.92.72.58]:39697 "EHLO iabervon.org") by
 vger.kernel.org with ESMTP id S1755198AbWK1UlD (ORCPT
 <rfc822;git@vger.kernel.org>); Tue, 28 Nov 2006 15:41:03 -0500
Received: (qmail 18295 invoked by uid 1000); 28 Nov 2006 15:41:01 -0500
Received: from localhost (sendmail-bs@127.0.0.1) by localhost with SMTP; 28
 Nov 2006 15:41:01 -0500
To: skimo@liacs.nl
Sender: git-owner@vger.kernel.org

On Tue, 28 Nov 2006, Sven Verdoolaege wrote:

> On Tue, Nov 28, 2006 at 01:37:54PM -0500, Daniel Barkalow wrote:
> > If submodule was the only thing that got changed, it's not dirty; if it 
> > were dirty, some of its contents would also have gotten changed.
> 
> For me, the commit is the only "content" of the subproject that the
> superproject should care about, so the submodule being dirty or not
> is completely irrelevant (for committing), but it seems you see the
> subproject more as a (working) tree than as a commit.

I think we agree on the tree/commit/object database model part.

I think we disagree on how the working *directories* relate. I see the 
checked-out state of a submodule as being relevant to the checked-out 
state of the supermodule, such that dirty state in the submodule directory 
is dirty state in the supermodule directory.

> > Surely:
> > 
> > "git commit submodule/foo bar"
> 
> I wouldn't dream of doing such an operation, because it doesn't make
> sense to me.  (So as far as I'm concerned, you can make it do whatever
> you'd like it to do.)  You can only commit the subproject as a whole.

I'm thinking that users of subprojects will often want to work on the
subprojects rather than exclusively using commits prepared by other 
people, and it's too much trouble to have to do the work in a repository 
for just the subproject and pull it into the superproject's submodule to 
test it. So the submodule working directory needs to function as a working 
directory for the subproject. Then

  "cd submodule; git commit foo"

does the obvious thing, but that should be the same as

  "git commit submodule/foo" (since it normally is)

and then it makes sense to let you do multiple commits with a single 
command when the paths end in different modules, since that's obviously 
what you're requesting, and then -a must do all of them.

	-Daniel
