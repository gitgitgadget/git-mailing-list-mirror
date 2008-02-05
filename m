From: Daniel Barkalow <barkalow@iabervon.org>
Subject: Re: [PATCH 1/2] Reduce the number of connects when fetching
Date: Tue, 5 Feb 2008 14:20:21 -0500 (EST)
Message-ID: <alpine.LNX.1.00.0802051417140.13593@iabervon.org>
References: <alpine.LNX.1.00.0802041323450.13593@iabervon.org> <7v8x20gkue.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Feb 05 20:20:59 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JMTLl-0006Qb-Ml
	for gcvg-git-2@gmane.org; Tue, 05 Feb 2008 20:20:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754786AbYBETUY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 5 Feb 2008 14:20:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752934AbYBETUY
	(ORCPT <rfc822;git-outgoing>); Tue, 5 Feb 2008 14:20:24 -0500
Received: from iabervon.org ([66.92.72.58]:56188 "EHLO iabervon.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751451AbYBETUX (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 5 Feb 2008 14:20:23 -0500
Received: (qmail 4294 invoked by uid 1000); 5 Feb 2008 19:20:21 -0000
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 5 Feb 2008 19:20:21 -0000
In-Reply-To: <7v8x20gkue.fsf@gitster.siamese.dyndns.org>
User-Agent: Alpine 1.00 (LNX 882 2007-12-20)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/72681>

On Mon, 4 Feb 2008, Junio C Hamano wrote:

> Daniel Barkalow <barkalow@iabervon.org> writes:
> 
> > This shares the connection between getting the remote ref list and
> > getting objects in the first batch. (A second connection is still used
> > to follow tags)
> > ---
> 
> No signoff.

I think I must have switched from signing off my emails to signing off my 
commits some time since last october.

Signed-off-by: Daniel Barkalow <barkalow@iabervon.org>

> > There's a bug here, fixed in the next patch, but it's just cosmetic (we 
> > hang up on the remote end unexpectedly if we turn out not to need 
> > anything), and I think reorganizing changes to not do that makes the 
> > changes harder to follow.
> 
> > @@ -706,9 +703,34 @@ int cmd_fetch_pack(int argc, const char **argv, const char *prefix)
> >  	if (!dest)
> >  		usage(fetch_pack_usage);
> >  
> > -	ref = fetch_pack(&args, dest, nr_heads, heads, NULL);
> > +	int fd[2];
> > +	struct child_process *conn = git_connect(fd, (char *)dest, args.uploadpack,
> > +                          args.verbose ? CONNECT_VERBOSE : 0);
> 
> Decl after statement.
> 
> But other than that, good job.  I did not realize it would be
> doable this cleanly.

I designed the transport structure to permit it, and the protocol was 
originally designed to work that way, so it should be easy... the hard 
part is getting rid of a second connection for fetching new tags, but 
that's a relatively unusual situation anyway.

> Will squash all three and queue for 'next'.

Great. I assume you'll fix my C99-ism, as well?

	-Daniel
*This .sig left intentionally blank*
