From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH 3/3 v2] git-http-fetch: not a builtin
Date: Tue, 28 Jul 2009 15:23:11 +0200 (CEST)
Message-ID: <alpine.DEB.1.00.0907281520150.8306@pacific.mpi-cbg.de>
References: <alpine.LNX.2.00.0907280207480.2147@iabervon.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Linus Torvalds <torvalds@linux-foundation.org>
To: Daniel Barkalow <barkalow@iabervon.org>
X-From: git-owner@vger.kernel.org Tue Jul 28 15:23:13 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MVme8-0008OH-Ag
	for gcvg-git-2@gmane.org; Tue, 28 Jul 2009 15:23:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754122AbZG1NXE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 28 Jul 2009 09:23:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754119AbZG1NXE
	(ORCPT <rfc822;git-outgoing>); Tue, 28 Jul 2009 09:23:04 -0400
Received: from mail.gmx.net ([213.165.64.20]:56159 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1754095AbZG1NXC (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 28 Jul 2009 09:23:02 -0400
Received: (qmail invoked by alias); 28 Jul 2009 13:23:01 -0000
Received: from pacific.mpi-cbg.de (EHLO pacific.mpi-cbg.de) [141.5.10.38]
  by mail.gmx.net (mp038) with SMTP; 28 Jul 2009 15:23:01 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1+2WwVP2Aq2L4n6PISXcgfh3KJCaD2wGRsFwtgHbV
	VNg+9vP2mtXuqa
X-X-Sender: schindelin@pacific.mpi-cbg.de
In-Reply-To: <alpine.LNX.2.00.0907280207480.2147@iabervon.org>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.45
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/124248>

Hi,

On Tue, 28 Jul 2009, Daniel Barkalow wrote:

> From: Linus Torvalds <torvalds@linux-foundation.org>
> 
> This splits up git-http-fetch so that it isn't built-in.
> 
> It also removes the general dependency on curl, because it is no
> longer used by any built-in code.
> 
> Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
> Signed-off-by: Daniel Barkalow <barkalow@iabervon.org>
> ---

I think there is something missing that was not needed in Linus' original 
patch:

> diff --git a/Makefile b/Makefile
> index d3dd2ed..3425336 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -979,10 +979,7 @@ else
>  	else
>  		CURL_LIBCURL = -lcurl
>  	endif
> -	BUILTIN_OBJS += builtin-http-fetch.o
> -	PROGRAMS += git-shim-curl$X
> -	EXTLIBS += $(CURL_LIBCURL)
> -	LIB_OBJS += http.o http-walker.o
> +	PROGRAMS += git-shim-curl$X git-http-fetch$X

So now, http is all excluded from libgit.a.  Okay.

> @@ -1487,6 +1484,9 @@ git-imap-send$X: imap-send.o $(GITLIBS)
>  
>  http.o http-walker.o http-push.o transport.o: http.h
>  
> +git-http-fetch$X: revision.o http.o http-push.o $(GITLIBS)
> +	$(QUIET_LINK)$(CC) $(ALL_CFLAGS) -o $@ $(ALL_LDFLAGS) $(filter %.o,$^) \
> +		$(LIBS) $(CURL_LIBCURL) $(EXPAT_LIBEXPAT)

And git-http-fetch is linked to libcurl.  But why is git-shim-curl not 
linked to libcurl?  I can only guess (as I am running out of time) that 
git-shim-curl (in addition to having a doubly horrible name) has _no idea_ 
about curl?  So why does it exist in the first place?  Should not rather 
"git http-fetch" be turned _into_ that helper (albeit with a much better 
name)?

Ciao,
Dscho
