From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH 2/2] fetch/push: readd rsync support
Date: Fri, 28 Sep 2007 13:22:09 +0100 (BST)
Message-ID: <Pine.LNX.4.64.0709281317170.28395@racer.site>
References: <Pine.LNX.4.64.0709280602580.28395@racer.site>
 <Pine.LNX.4.64.0709280606530.28395@racer.site> <20070928052018.GW3099@spearce.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: gitster@pobox.com, Daniel Barkalow <barkalow@iabervon.org>,
	git@vger.kernel.org
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Fri Sep 28 14:23:34 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IbEsU-0002EC-Fx
	for gcvg-git-2@gmane.org; Fri, 28 Sep 2007 14:23:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752904AbXI1MXU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 28 Sep 2007 08:23:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752401AbXI1MXT
	(ORCPT <rfc822;git-outgoing>); Fri, 28 Sep 2007 08:23:19 -0400
Received: from mail.gmx.net ([213.165.64.20]:53392 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752227AbXI1MXT (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 28 Sep 2007 08:23:19 -0400
Received: (qmail invoked by alias); 28 Sep 2007 12:23:17 -0000
Received: from unknown (EHLO [138.251.11.74]) [138.251.11.74]
  by mail.gmx.net (mp056) with SMTP; 28 Sep 2007 14:23:17 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1+bZdtXWFObXYWzX/m4deYUD/N8lE8ymRxz1mU7FV
	NaVaBiZDxk0ezw
X-X-Sender: gene099@racer.site
In-Reply-To: <20070928052018.GW3099@spearce.org>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/59387>

Hi,

On Fri, 28 Sep 2007, Shawn O. Pearce wrote:

> Johannes Schindelin <Johannes.Schindelin@gmx.de> wrote:
> > +static int disconnect_rsync(struct transport *transport)
> > +{
> > +	return 0;
> > +}
> >  
> >  /* Generic functions for using commit walkers */
> >  
> > @@ -402,7 +730,10 @@ struct transport *transport_get(struct remote *remote, const char *url)
> >  	ret->url = url;
> >  
> >  	if (!prefixcmp(url, "rsync://")) {
> > -		/* not supported; don't populate any ops */
> > +		ret->get_refs_list = get_refs_via_rsync;
> > +		ret->fetch = fetch_objs_via_rsync;
> > +		ret->push = rsync_transport_push;
> > +		ret->disconnect = disconnect_rsync;
> >  
> >  	} else if (!prefixcmp(url, "http://")
> >  	        || !prefixcmp(url, "https://")
> 
> For what it's worth disconnect is an optional operation.

Strange.  When not assigning disconnect, I had an error last night.  But 
it could well be something independent.

Reading the code again, I should not even have to assign NULL to 
ret->disconnect.

Will fix.

> I see push is now supported again.  Didn't we remove rsync push support 
> a long time ago?  Like say in:
> 
>   commit c485104741ccdf32dd0c96fcb886c38a0b5badbd
>   Author: c.shoemaker@cox.net <c.shoemaker@cox.net>
>   Date:   Sat Oct 29 00:16:33 2005 -0400
> 
>     Add usage help to git-push.sh
>     
>     Also clarify failure to push to read-only remote.  Especially,
>     state why rsync:// is not used for pushing.
>     
>     [jc: ideally rsync should not be used for anything]
>     
>     Signed-off-by: Chris Shoemaker <c.shoemaker at cox.net>
>     Signed-off-by: Junio C Hamano <junkio@cox.net>

I know.  I hesitated, but then: it was all too easy to have it in, so why 
should we relinquish it?

> I guess it is nice to see that you can't kill rsync.  Like Windows it 
> always finds it way back into your life.

Hehe.

Ciao,
Dscho
