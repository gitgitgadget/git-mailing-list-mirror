From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH 02/13] Use an external program to implement fetching with
 curl
Date: Wed, 5 Aug 2009 21:54:44 +0200 (CEST)
Message-ID: <alpine.DEB.1.00.0908052154000.8306@pacific.mpi-cbg.de>
References: <alpine.LNX.2.00.0908050053580.2147@iabervon.org> <alpine.DEB.1.00.0908051206460.8306@pacific.mpi-cbg.de> <alpine.LNX.2.00.0908051145250.2147@iabervon.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Johan Herland <johan@herland.net>
To: Daniel Barkalow <barkalow@iabervon.org>
X-From: git-owner@vger.kernel.org Wed Aug 05 21:54:30 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MYmZ9-0005I7-NS
	for gcvg-git-2@gmane.org; Wed, 05 Aug 2009 21:54:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751893AbZHETyU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 5 Aug 2009 15:54:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751758AbZHETyU
	(ORCPT <rfc822;git-outgoing>); Wed, 5 Aug 2009 15:54:20 -0400
Received: from mail.gmx.net ([213.165.64.20]:33109 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751506AbZHETyT (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 5 Aug 2009 15:54:19 -0400
Received: (qmail invoked by alias); 05 Aug 2009 19:54:19 -0000
Received: from pacific.mpi-cbg.de (EHLO pacific.mpi-cbg.de) [141.5.10.38]
  by mail.gmx.net (mp044) with SMTP; 05 Aug 2009 21:54:19 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX19zeSkPhoZzXXcLHMICSNjC+X9sXsfUKaIhTe0gSE
	6NERhjhbzfVXrx
X-X-Sender: schindelin@pacific.mpi-cbg.de
In-Reply-To: <alpine.LNX.2.00.0908051145250.2147@iabervon.org>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.44
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/124958>

Hi,

On Wed, 5 Aug 2009, Daniel Barkalow wrote:

> On Wed, 5 Aug 2009, Johannes Schindelin wrote:
> 
> > On Wed, 5 Aug 2009, Daniel Barkalow wrote:
> > 
> > > diff --git a/Makefile b/Makefile
> > > index 504646a..35117fc 100644
> > > --- a/Makefile
> > > +++ b/Makefile
> > > @@ -981,6 +981,7 @@ else
> > >  		CURL_LIBCURL = -lcurl
> > >  	endif
> > >  	BUILTIN_OBJS += builtin-http-fetch.o
> > > +	PROGRAMS += git-remote-http$X git-remote-https$X git-remote-ftp$X git-http-fetch$X
> > >  	EXTLIBS += $(CURL_LIBCURL)
> > >  	LIB_OBJS += http.o http-walker.o
> > >  	curl_check := $(shell (echo 070908; curl-config --vernum) | sort -r | sed -ne 2p)
> > > @@ -1491,6 +1492,10 @@ git-http-push$X: revision.o http.o http-push.o $(GITLIBS)
> > >  	$(QUIET_LINK)$(CC) $(ALL_CFLAGS) -o $@ $(ALL_LDFLAGS) $(filter %.o,$^) \
> > >  		$(LIBS) $(CURL_LIBCURL) $(EXPAT_LIBEXPAT)
> > >  
> > > +git-remote-http$X git-remote-https$X git-remote-ftp$X: remote-curl.o http.o http-walker.o $(GITLIBS)
> > > +	$(QUIET_LINK)$(CC) $(ALL_CFLAGS) -o $@ $(ALL_LDFLAGS) $(filter %.o,$^) \
> > > +		$(LIBS) $(CURL_LIBCURL) $(EXPAT_LIBEXPAT)
> > > +
> > 
> > Ooops, I missed this part.  How about making git-remote-https and 
> > git-remote-ftp hardlinks to git-remote-http?
> 
> Sure. Is "ln ... || ln -s ... || cp ..." the right way to do this 
> cross-platform?

You mean as in

	$(BUILT_INS): git$X
	        $(QUIET_BUILT_IN)$(RM) $@ && \
	        ln git$X $@ 2>/dev/null || \
	        ln -s git$X $@ 2>/dev/null || \
	        cp git$X $@

?  I guess so ;-)

Ciao,
Dscho
