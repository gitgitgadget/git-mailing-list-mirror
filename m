From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] git-push: plumb in --mirror mode
Date: Tue, 2 Oct 2007 13:50:28 +0100 (BST)
Message-ID: <Pine.LNX.4.64.0710021347530.28395@racer.site>
References: <7vhclalzlq.fsf@gitster.siamese.dyndns.org> <20071002120051.GC30636@shadowen.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Andy Whitcroft <apw@shadowen.org>
X-From: git-owner@vger.kernel.org Tue Oct 02 14:51:59 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IchE9-0006L1-DH
	for gcvg-git-2@gmane.org; Tue, 02 Oct 2007 14:51:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753028AbXJBMvq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 2 Oct 2007 08:51:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752731AbXJBMvp
	(ORCPT <rfc822;git-outgoing>); Tue, 2 Oct 2007 08:51:45 -0400
Received: from mail.gmx.net ([213.165.64.20]:54956 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752709AbXJBMvp (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 2 Oct 2007 08:51:45 -0400
Received: (qmail invoked by alias); 02 Oct 2007 12:51:43 -0000
Received: from unknown (EHLO [138.251.11.74]) [138.251.11.74]
  by mail.gmx.net (mp051) with SMTP; 02 Oct 2007 14:51:43 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1+p4GIpil+ptE1MgTYZ0VhGbXapeu1s+DmPXgTrsK
	WkE9TzCVaNzZP/
X-X-Sender: gene099@racer.site
In-Reply-To: <20071002120051.GC30636@shadowen.org>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/59689>

Hi,

On Tue, 2 Oct 2007, Andy Whitcroft wrote:

> @@ -137,5 +144,10 @@ int cmd_push(int argc, const char **argv, const char *prefix)
>  	if (all && refspec)
>  		usage(push_usage);
>  
> +	if (modes_specified > 1) {
> +		error("--all and --mirror are incompatible");
> +		usage(push_usage);
> +	}
> +

Why not

	if ((flags & TRANSPORT_PUSH_ALL) && (flags & TRANSPORT_PUSH_MIRROR))?

It's more explicit.


> @@ -667,6 +673,8 @@ static int git_transport_push(struct transport *transport, int refspec_nr, const
>  		argv[argc++] = "--all";
>  	if (flags & TRANSPORT_PUSH_FORCE)
>  		argv[argc++] = "--force";
> +	if (flags & TRANSPORT_PUSH_MIRROR)
> +		argv[argc++] = "--mirror";
>  	if (data->receivepack) {
>  		char *rp = xmalloc(strlen(data->receivepack) + 16);
>  		sprintf(rp, "--receive-pack=%s", data->receivepack);

Shouldn't you then increment the "11" a few lines before that, to ensure 
enough space for the new argument?

Ciao,
Dscho
