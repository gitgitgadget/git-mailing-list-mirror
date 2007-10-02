From: Andy Whitcroft <apw@shadowen.org>
Subject: Re: [PATCH] git-push: plumb in --mirror mode
Date: Tue, 2 Oct 2007 15:21:15 +0100
Message-ID: <20071002142115.GC14110@shadowen.org>
References: <7vhclalzlq.fsf@gitster.siamese.dyndns.org> <20071002120051.GC30636@shadowen.org> <Pine.LNX.4.64.0710021347530.28395@racer.site>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Tue Oct 02 16:21:42 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Icid2-0007S7-Tn
	for gcvg-git-2@gmane.org; Tue, 02 Oct 2007 16:21:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752455AbXJBOVW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 2 Oct 2007 10:21:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752421AbXJBOVW
	(ORCPT <rfc822;git-outgoing>); Tue, 2 Oct 2007 10:21:22 -0400
Received: from hellhawk.shadowen.org ([80.68.90.175]:2730 "EHLO
	hellhawk.shadowen.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752374AbXJBOVV (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 2 Oct 2007 10:21:21 -0400
Received: from 81-179-148-120.dsl.pipex.com ([81.179.148.120] helo=localhost.localdomain)
	by hellhawk.shadowen.org with esmtpa (Exim 4.50)
	id 1Icich-0007zx-IN; Tue, 02 Oct 2007 15:21:19 +0100
Received: from localhost ([127.0.0.1] helo=pinky)
	by localhost.localdomain with esmtp (Exim 4.63)
	(envelope-from <apw@shadowen.org>)
	id 1Icicd-0002cS-Ni; Tue, 02 Oct 2007 15:21:15 +0100
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0710021347530.28395@racer.site>
User-Agent: Mutt/1.5.13 (2006-08-11)
Received-SPF: none
X-SPF-Guess: neutral
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/59693>

On Tue, Oct 02, 2007 at 01:50:28PM +0100, Johannes Schindelin wrote:
> Hi,
> 
> On Tue, 2 Oct 2007, Andy Whitcroft wrote:
> 
> > @@ -137,5 +144,10 @@ int cmd_push(int argc, const char **argv, const char *prefix)
> >  	if (all && refspec)
> >  		usage(push_usage);
> >  
> > +	if (modes_specified > 1) {
> > +		error("--all and --mirror are incompatible");
> > +		usage(push_usage);
> > +	}
> > +
> 
> Why not
> 
> 	if ((flags & TRANSPORT_PUSH_ALL) && (flags & TRANSPORT_PUSH_MIRROR))?
> 
> It's more explicit.

Yep, that does seem cleaner.

> > @@ -667,6 +673,8 @@ static int git_transport_push(struct transport *transport, int refspec_nr, const
> >  		argv[argc++] = "--all";
> >  	if (flags & TRANSPORT_PUSH_FORCE)
> >  		argv[argc++] = "--force";
> > +	if (flags & TRANSPORT_PUSH_MIRROR)
> > +		argv[argc++] = "--mirror";
> >  	if (data->receivepack) {
> >  		char *rp = xmalloc(strlen(data->receivepack) + 16);
> >  		sprintf(rp, "--receive-pack=%s", data->receivepack);
> 
> Shouldn't you then increment the "11" a few lines before that, to ensure 
> enough space for the new argument?

I should have mentioned I'd not even reviewed it as the basic underlying
functionality seemed to be broken.  I'll look over it if I get a chance
to try and debug the underlying failure.

-apw
