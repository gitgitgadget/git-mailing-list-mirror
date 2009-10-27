From: Daniel Barkalow <barkalow@iabervon.org>
Subject: Re: [PATCH] Fix memory leak in transport-helper
Date: Tue, 27 Oct 2009 15:05:57 -0400 (EDT)
Message-ID: <alpine.LNX.2.00.0910271456410.14365@iabervon.org>
References: <1255577814-14745-1-git-send-email-spearce@spearce.org> <20091015185253.6117@nanako3.lavabit.com> <20091015143340.GI10505@spearce.org> <200910151721.08352.johan@herland.net> <20091015154142.GL10505@spearce.org> <7vfx9k4d33.fsf@alter.siamese.dyndns.org>
 <20091015204543.GP10505@spearce.org> <alpine.LNX.2.00.0910270032170.14365@iabervon.org> <alpine.DEB.1.00.0910271510430.4985@pacific.mpi-cbg.de> <alpine.LNX.2.00.0910271329510.14365@iabervon.org> <alpine.DEB.1.00.0910271954020.11562@felix-maschine>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: "Shawn O. Pearce" <spearce@spearce.org>,
	Junio C Hamano <gitster@pobox.com>,
	Johan Herland <johan@herland.net>,
	Nanako Shiraishi <nanako3@lavabit.com>,
	Sverre Rabbelier <srabbelier@gmail.com>, git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Tue Oct 27 20:06:06 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N2rMr-0003o7-A0
	for gcvg-git-2@lo.gmane.org; Tue, 27 Oct 2009 20:06:05 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754730AbZJ0TFz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 27 Oct 2009 15:05:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754673AbZJ0TFz
	(ORCPT <rfc822;git-outgoing>); Tue, 27 Oct 2009 15:05:55 -0400
Received: from iabervon.org ([66.92.72.58]:50824 "EHLO iabervon.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753687AbZJ0TFy (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 27 Oct 2009 15:05:54 -0400
Received: (qmail 29764 invoked by uid 1000); 27 Oct 2009 19:05:57 -0000
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 27 Oct 2009 19:05:57 -0000
In-Reply-To: <alpine.DEB.1.00.0910271954020.11562@felix-maschine>
User-Agent: Alpine 2.00 (LNX 1167 2008-08-23)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/131372>

On Tue, 27 Oct 2009, Johannes Schindelin wrote:

> Hi,
> 
> On Tue, 27 Oct 2009, Daniel Barkalow wrote:
> 
> > On Tue, 27 Oct 2009, Johannes Schindelin wrote:
> > 
> > > Hi,
> > > 
> > > On Tue, 27 Oct 2009, Daniel Barkalow wrote:
> > > 
> > > > diff --git a/transport-helper.c b/transport-helper.c
> > > > index f57e84c..479539d 100644
> > > > --- a/transport-helper.c
> > > > +++ b/transport-helper.c
> > > > @@ -67,6 +67,13 @@ static int disconnect_helper(struct transport *transport)
> > > >  	return 0;
> > > >  }
> > > >  
> > > > +static int close_helper(struct transport *transport)
> > > > +{
> > > > +	disconnect_helper(transport);
> > > > +	free(transport->data);
> > > > +	return 0;
> > > > +}
> > > 
> > > Why did you not leech the transport->data = NULL; part from Peff/Sverre's 
> > > patch?
> > 
> > Because this code is only called just before transport itself is freed by 
> > the caller, and, in general, a transport with these methods is invalid 
> > without a valid transport->data. I expect that's also why Peff called it a 
> > hack not appropriate for actual application.
> 
> So you mean to imply that this method is not about closing, but about 
> releasing the structure.  Right?

Yes, that's the word I was failing to come up with last night, thanks.
Junio, "s/close/release/g" on that patch should improve comprehensibility 
greatly. (And changing the transport method name would probably also 
improve matters)

	-Daniel
*This .sig left intentionally blank*
