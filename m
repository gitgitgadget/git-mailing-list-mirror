From: Daniel Barkalow <barkalow@iabervon.org>
Subject: Re: [RFC] Importing from a patch-oriented SCM
Date: Fri, 19 Aug 2005 12:22:29 -0400 (EDT)
Message-ID: <Pine.LNX.4.63.0508191141570.23242@iabervon.org>
References: <46a038f9050819000417ed436e@mail.gmail.com> 
 <7vslx61i3s.fsf@assigned-by-dhcp.cox.net> <46a038f905081901521296c24@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Aug 19 18:21:57 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1E69af-0006ez-Fy
	for gcvg-git@gmane.org; Fri, 19 Aug 2005 18:19:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964986AbVHSQTF (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 19 Aug 2005 12:19:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964985AbVHSQTF
	(ORCPT <rfc822;git-outgoing>); Fri, 19 Aug 2005 12:19:05 -0400
Received: from iabervon.org ([66.92.72.58]:48132 "EHLO iabervon.org")
	by vger.kernel.org with ESMTP id S964986AbVHSQTE (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 19 Aug 2005 12:19:04 -0400
Received: (qmail 13506 invoked by uid 1000); 19 Aug 2005 12:22:29 -0400
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 19 Aug 2005 12:22:29 -0400
To: Martin Langhoff <martin.langhoff@gmail.com>
In-Reply-To: <46a038f905081901521296c24@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

On Fri, 19 Aug 2005, Martin Langhoff wrote:

> On 8/19/05, Junio C Hamano <junkio@cox.net> wrote:
> > Martin Langhoff <martin.langhoff@gmail.com> writes:
> >
> > > If I remember correctly, Junio added some stuff in the merge & rebase
> > > code that will identify if a particular patch has been seen and
> > > applied, and skip it even if it's a bit out of order. But I don't know
> >
> > I think you are talking about git-patch-id.
>
> Is this used at commit time, and stored somewhere (doesn't seem to be)
> or do you select older patches from the destination branch at merge
> time?

If a patch is applied verbatim, or a merge results in no conflicts (i.e.,
only offsets), then you can run git-patch-id on the diff caused by it and
compare the result with the git-patch-id of the diff caused by your local
change to see if you've found it. Of course, if there was any modification
to the patch or a conflict was resolved, you won't see a match, but that's
plausibly correct anyway: you don't know whether the content change that
resulted from your patch really matched the change you wanted to make.

> If you only compare patches since the last merge, patches that were
> merged but somehow unreported will fall into a black hole and cause a
> conflict going forward anyway. Hmm.  That seems to be a problem I
> won't be able to avoid if merges happen out-of-order.

They might cause conflicts, but they're relatively unlikely to require
manual intervention, because the merging mechanism in git is stronger than
the one in arch (by virtue of identifying a common ancestor), and will
recognize when a section of changes made by both sides is the same and
produce a warning rather than a conflict. That's how the rebase stuff can
identify that your rebased patch is empty (when upstream applies your
patch): the content change that it would make has been made.

	-Daniel
*This .sig left intentionally blank*
