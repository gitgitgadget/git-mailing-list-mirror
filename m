From: Daniel Barkalow <barkalow@iabervon.org>
Subject: Re: [PATCH] builtin-clone: fix for new unpack_trees() semantics
Date: Sun, 9 Mar 2008 19:14:55 -0400 (EDT)
Message-ID: <alpine.LNX.1.00.0803091911010.19665@iabervon.org>
References: <alpine.LNX.1.00.0803081803360.19665@iabervon.org> <alpine.LSU.1.00.0803092227230.3975@racer.site> <alpine.LNX.1.00.0803091829100.19665@iabervon.org> <alpine.LSU.1.00.0803092354310.3975@racer.site> <alpine.LNX.1.00.0803091857540.19665@iabervon.org>
 <alpine.LSU.1.00.0803100005060.3975@racer.site>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Mon Mar 10 00:15:42 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JYUjz-0001No-9e
	for gcvg-git-2@gmane.org; Mon, 10 Mar 2008 00:15:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752596AbYCIXPA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 9 Mar 2008 19:15:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753108AbYCIXPA
	(ORCPT <rfc822;git-outgoing>); Sun, 9 Mar 2008 19:15:00 -0400
Received: from iabervon.org ([66.92.72.58]:52669 "EHLO iabervon.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752408AbYCIXO7 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 9 Mar 2008 19:14:59 -0400
Received: (qmail 21109 invoked by uid 1000); 9 Mar 2008 23:14:55 -0000
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 9 Mar 2008 23:14:55 -0000
In-Reply-To: <alpine.LSU.1.00.0803100005060.3975@racer.site>
User-Agent: Alpine 1.00 (LNX 882 2007-12-20)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/76683>

On Mon, 10 Mar 2008, Johannes Schindelin wrote:

> Hi,
> 
> On Sun, 9 Mar 2008, Daniel Barkalow wrote:
> 
> > On Sun, 9 Mar 2008, Johannes Schindelin wrote:
> > 
> > > On Sun, 9 Mar 2008, Daniel Barkalow wrote:
> > > 
> > > > On Sun, 9 Mar 2008, Johannes Schindelin wrote:
> > > > 
> > > > > In git.git's "next" branch, unpack_trees() must specify source and target 
> > > > > index.
> > > > > 
> > > > > Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
> > > > > ---
> > > > > 
> > > > > 	To be squashed into 10/11
> > > > > 
> > > > >  builtin-clone.c |    2 ++
> > > > >  1 files changed, 2 insertions(+), 0 deletions(-)
> > > > > 
> > > > > diff --git a/builtin-clone.c b/builtin-clone.c
> > > > > index e4047ed..3890e12 100644
> > > > > --- a/builtin-clone.c
> > > > > +++ b/builtin-clone.c
> > > > > @@ -534,6 +534,8 @@ int cmd_clone(int argc, const char **argv, const char *prefix)
> > > > >  		opts.verbose_update = !option_quiet;
> > > > >  		opts.merge = 1;
> > > > >  		opts.fn = twoway_merge;
> > > > > +		opts.src_index = &the_index;
> > > > > +		opts.dst_index = &the_index;
> > > > 
> > > > Actually, I think the sensible thing is to just not do a merge here, since 
> > > > we know there's no index beforehand and the two trees are the same.
> > > > 
> > > > I think the odd twoway merge of two copies of HEAD is just an artifact of 
> > > > clone originally just doing "git checkout HEAD", and that got translated 
> > > > various times failing to notice the special cases.
> > > 
> > > Okay, but would oneway_merge not want to write the index, too (rightfully 
> > > so)?
> > 
> > I'm thinking:
> > 
> >   memset(&opts, 0, sizeof opts);
> >   opts.update = 1;
> >   opts.verbose_update = !option_quiet;
> >   opts.dst_index = &the_index;
> > 
> >   init_tree_desc(&t[0], tree->buffer, tree->size);
> >   unpack_trees(1, t, &opts);
> > 
> > That is, write it, but not read it, and only have one tree.
> 
> Yes.  And this sets dst_index (what I tried to hint at with my patch).

Oh, yes. Your patch is what prompted me to fix that part (and to find that 
Linus's unpack_trees was in next now). But seeing src_index in your patch 
made me wonder what it wanted a source index for anyway, since this is the 
first index we've had in this repo.

	-Daniel
*This .sig left intentionally blank*
