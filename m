From: Daniel Barkalow <barkalow@iabervon.org>
Subject: Re: [PATCH 0/5] Extend pattern refspecs
Date: Fri, 6 Mar 2009 02:03:04 -0500 (EST)
Message-ID: <alpine.LNX.1.00.0903060153490.19665@iabervon.org>
References: <alpine.LNX.1.00.0903052346270.19665@iabervon.org>  <76718490903052119y4d6a7e0ck24bfeb1c0964e413@mail.gmail.com>  <alpine.LNX.1.00.0903060038510.19665@iabervon.org> <76718490903052252y1778aa41g8f3e52329f7bf288@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Jay Soffian <jaysoffian@gmail.com>
X-From: git-owner@vger.kernel.org Fri Mar 06 08:04:38 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LfU6o-0007Zj-8P
	for gcvg-git-2@gmane.org; Fri, 06 Mar 2009 08:04:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752987AbZCFHDL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 6 Mar 2009 02:03:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752007AbZCFHDI
	(ORCPT <rfc822;git-outgoing>); Fri, 6 Mar 2009 02:03:08 -0500
Received: from iabervon.org ([66.92.72.58]:47929 "EHLO iabervon.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751912AbZCFHDG (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 6 Mar 2009 02:03:06 -0500
Received: (qmail 26143 invoked by uid 1000); 6 Mar 2009 07:03:04 -0000
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 6 Mar 2009 07:03:04 -0000
In-Reply-To: <76718490903052252y1778aa41g8f3e52329f7bf288@mail.gmail.com>
User-Agent: Alpine 1.00 (LNX 882 2007-12-20)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/112395>

On Fri, 6 Mar 2009, Jay Soffian wrote:

> On Fri, Mar 6, 2009 at 1:07 AM, Daniel Barkalow <barkalow@iabervon.org> wrote:
> > On Fri, 6 Mar 2009, Jay Soffian wrote:
> >
> > Actually, you should be able to just drop your "buf" and use spec->src and
> > spec->dst, since it just stores the original strings. So that should be
> > easy enough, although it might be good to go through a remote.c function
> > just in case it becomes more complicated later. On the other hand,
> > get_head_names() should probably get a patch like my 1/5 to have it use
> > the remote.c parser, or should use a constant "head mirror" refspec like
> > that tag_refspec already in remote.c
> 
> Okay.
> 
> > Do you have tests for "git remote show -n"?
> 
> Yes. Apparently not enough of them though if nothing is failing.

It only seems to be off by saying:

  Local ref configured for 'git push' (status not queried):
    refs/heads/** forces to refs/heads/**

so you didn't necessarily miss much, just the one thing I seem to have 
broken.

> > Merging my series (on top of
> > origin/master) and e5dcbfd and adding a final '*' to the string in
> > get_head_names() made everything pass for me, without doing anything about
> > the extra *s, but the output is clearly not quite right.
> 
> Hmm, alright.
> 
> > I'm not seeing anything that makes assumptions about the matching
> > semantics of pattern refspecs, just stuff about how the stored form
> > relates to the config-file form.
> 
> Okay, that sounds right.
> 
> I assume your series will end up in pu soon enough, and I think my
> series is about to hop to next. What's the right way to to have them
> be happy together?

The only "correctness of outcome" issue is the open-coded refspec 
initialization, I think, which is probably actually cleaner to have as a 
constant in remote.c anyway (unlike in builtin-clone, there's no 
variability at all, so it might as well be a constant.

I can amend my series to avoid adding the extra * in the message when your 
series graduates, and it should be clean enough to deal with if your 
series wound up getting dropped later; it'll be the only change in that 
file for my series, so I'd be able to drop it easily.

It'd be useful to have that message tested by your series, though, so I 
can verify my series reliably without worrying about whether I 
accidentally dropped both the fix and the test.

	-Daniel
*This .sig left intentionally blank*
