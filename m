From: Daniel Barkalow <barkalow@iabervon.org>
Subject: Re: [PATCH 3/3 v2] git-http-fetch: not a builtin
Date: Tue, 28 Jul 2009 14:05:49 -0400 (EDT)
Message-ID: <alpine.LNX.2.00.0907281400100.2147@iabervon.org>
References: <alpine.LNX.2.00.0907280207480.2147@iabervon.org> <alpine.DEB.1.00.0907281520150.8306@pacific.mpi-cbg.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Linus Torvalds <torvalds@linux-foundation.org>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Tue Jul 28 20:06:02 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MVr3m-00025P-Bj
	for gcvg-git-2@gmane.org; Tue, 28 Jul 2009 20:05:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755327AbZG1SFu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 28 Jul 2009 14:05:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755317AbZG1SFu
	(ORCPT <rfc822;git-outgoing>); Tue, 28 Jul 2009 14:05:50 -0400
Received: from iabervon.org ([66.92.72.58]:54104 "EHLO iabervon.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755307AbZG1SFt (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 28 Jul 2009 14:05:49 -0400
Received: (qmail 4363 invoked by uid 1000); 28 Jul 2009 18:05:49 -0000
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 28 Jul 2009 18:05:49 -0000
In-Reply-To: <alpine.DEB.1.00.0907281520150.8306@pacific.mpi-cbg.de>
User-Agent: Alpine 2.00 (LNX 1167 2008-08-23)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/124267>

On Tue, 28 Jul 2009, Johannes Schindelin wrote:

> Hi,
> 
> On Tue, 28 Jul 2009, Daniel Barkalow wrote:
> 
> > From: Linus Torvalds <torvalds@linux-foundation.org>
> > 
> > This splits up git-http-fetch so that it isn't built-in.
> > 
> > It also removes the general dependency on curl, because it is no
> > longer used by any built-in code.
> > 
> > Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
> > Signed-off-by: Daniel Barkalow <barkalow@iabervon.org>
> > ---
> 
> I think there is something missing that was not needed in Linus' original 
> patch:
> 
> > diff --git a/Makefile b/Makefile
> > index d3dd2ed..3425336 100644
> > --- a/Makefile
> > +++ b/Makefile
> > @@ -979,10 +979,7 @@ else
> >  	else
> >  		CURL_LIBCURL = -lcurl
> >  	endif
> > -	BUILTIN_OBJS += builtin-http-fetch.o
> > -	PROGRAMS += git-shim-curl$X
> > -	EXTLIBS += $(CURL_LIBCURL)
> > -	LIB_OBJS += http.o http-walker.o
> > +	PROGRAMS += git-shim-curl$X git-http-fetch$X
> 
> So now, http is all excluded from libgit.a.  Okay.
> 
> > @@ -1487,6 +1484,9 @@ git-imap-send$X: imap-send.o $(GITLIBS)
> >  
> >  http.o http-walker.o http-push.o transport.o: http.h
> >  
> > +git-http-fetch$X: revision.o http.o http-push.o $(GITLIBS)
> > +	$(QUIET_LINK)$(CC) $(ALL_CFLAGS) -o $@ $(ALL_LDFLAGS) $(filter %.o,$^) \
> > +		$(LIBS) $(CURL_LIBCURL) $(EXPAT_LIBEXPAT)
> 
> And git-http-fetch is linked to libcurl.  But why is git-shim-curl not 
> linked to libcurl?

It is linked to libcurl. Like git-http-push, it was already not relying on 
EXTLIBS including -lcurl.

	-Daniel
*This .sig left intentionally blank*
