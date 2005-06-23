From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: Patch (apply) vs. Pull
Date: Thu, 23 Jun 2005 11:43:13 -0700 (PDT)
Message-ID: <Pine.LNX.4.58.0506231137440.11175@ppc970.osdl.org>
References: <Pine.LNX.4.21.0506231149460.30848-100000@iabervon.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jun 23 20:48:46 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DlWje-00009I-U3
	for gcvg-git@gmane.org; Thu, 23 Jun 2005 20:47:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262678AbVFWSs1 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 23 Jun 2005 14:48:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263033AbVFWSo3
	(ORCPT <rfc822;git-outgoing>); Thu, 23 Jun 2005 14:44:29 -0400
Received: from smtp.osdl.org ([65.172.181.4]:8874 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S263032AbVFWSlS (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 23 Jun 2005 14:41:18 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id j5NIf8jA019467
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Thu, 23 Jun 2005 11:41:08 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id j5NIf70e003212;
	Thu, 23 Jun 2005 11:41:07 -0700
To: Daniel Barkalow <barkalow@iabervon.org>
In-Reply-To: <Pine.LNX.4.21.0506231149460.30848-100000@iabervon.org>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.40__
X-MIMEDefang-Filter: osdl$Revision: 1.111 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org



On Thu, 23 Jun 2005, Daniel Barkalow wrote:
> 
> I think that, if we care much about the hashes of diffs, we should hash
> the diff that's being applied, not hash a regenerated diff (unless, of
> course, the diff that's being applied has been modified in hash-relevant
> ways, in which case it's not going to match anything anyway).

But this whole algorithm depends on comparing two git commits, so we don't
actually _have_ a diff: we must generate it ourselves from the commits we
have in the history (ie we'd compare the commit we're "moving forward"
with each commit that we're moving it forward past - in order to see
whether it's already been applied).

Now, we control both of these patch generations, so in that sense it's 
easy to just make sure we generate both diffs the same way, but I just 
wanted to point this fact out.

> Wouldn't the only case where this would be a problem be if we had the
> committer apply the patch, generate a diff, hash it, and stick the hash in
> the commit?

Right, that would mean that we don't control the hash generation at both 
points, and would make it fundamentally harder. But since the whole point 
is that we should be able to generate the ID _without_ it actually being 
stored away anywhere, this hash approach should work fine.

> I think that the whole-chain case is sufficiently common to make special
> and extra smooth; developers will be making their history forwards every
> day, and only cherry-picking on occasion.

I'm not convinced. I think a _lot_ of people would want to do re-ordering 
of patches, combining them, and cherry-picking them if they just had a 
good way to do that.

That would then be a good way of cleaning up messy history too. Just prune 
the old tree once you've moved it forward.

		Linus
