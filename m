From: Daniel Barkalow <barkalow@iabervon.org>
Subject: Re: [PATCH v2] Fix remote.<remote>.vcs
Date: Wed, 27 Jan 2010 18:54:11 -0500 (EST)
Message-ID: <alpine.LNX.2.00.1001271853130.14365@iabervon.org>
References: <1264614797-22394-1-git-send-email-ilari.liusvaara@elisanet.fi> <alpine.LNX.2.00.1001271335140.14365@iabervon.org> <20100127185927.GA22630@Knoppix> <7vk4v3pabr.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Ilari Liusvaara <ilari.liusvaara@elisanet.fi>, git@vger.kernel.org,
	Tor Arvid Lund <torarvid@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Jan 28 00:54:21 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NaHiG-0007jn-BH
	for gcvg-git-2@lo.gmane.org; Thu, 28 Jan 2010 00:54:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754519Ab0A0XyN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 27 Jan 2010 18:54:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754429Ab0A0XyN
	(ORCPT <rfc822;git-outgoing>); Wed, 27 Jan 2010 18:54:13 -0500
Received: from iabervon.org ([66.92.72.58]:36318 "EHLO iabervon.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754340Ab0A0XyM (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 27 Jan 2010 18:54:12 -0500
Received: (qmail 31299 invoked by uid 1000); 27 Jan 2010 23:54:11 -0000
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 27 Jan 2010 23:54:11 -0000
In-Reply-To: <7vk4v3pabr.fsf@alter.siamese.dyndns.org>
User-Agent: Alpine 2.00 (LNX 1167 2008-08-23)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/138208>

On Wed, 27 Jan 2010, Junio C Hamano wrote:

> Ilari Liusvaara <ilari.liusvaara@elisanet.fi> writes:
> 
> > On Wed, Jan 27, 2010 at 01:39:00PM -0500, Daniel Barkalow wrote:
> >> On Wed, 27 Jan 2010, Ilari Liusvaara wrote:
> >> >  
> >> >  	if (!remote)
> >> >  		die("No remote provided to transport_get()");
> >> >  
> >> >  	ret->remote = remote;
> >> > +	helper = remote->foreign_vcs;
> >> 
> >> Needs to be "helper = remote ? remote->foreign_vcs : NULL", for the same 
> >> reason that the test below had been "remote && remote->foreign_vcs".
> >
> > Few lines above that:
> >
> >      if (!remote)
> >              die("No remote provided to transport_get()");
> 
> Perhaps we would want this micro-clean-up on top then.
> 
> -- >8 --
> Subject: transport_get(): drop unnecessary check for !remote
> 
> At the beginning of the function we make sure remote is not NULL, and
> the remainder of the funciton already depends on it.

I agree with both of these; there used to be code that used a NULL remote 
and just a URL, but that's gone now.

> Signed-off-by: Junio C Hamano <gitster@pobox.com>
> ---
> diff --git a/transport.c b/transport.c
> index 87581b8..3846aac 100644
> --- a/transport.c
> +++ b/transport.c
> @@ -921,7 +921,7 @@ struct transport *transport_get(struct remote *remote, const char *url)
>  	ret->remote = remote;
>  	helper = remote->foreign_vcs;
>  
> -	if (!url && remote && remote->url)
> +	if (!url && remote->url)
>  		url = remote->url[0];
>  	ret->url = url;
>  
> 
