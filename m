From: Daniel Barkalow <barkalow@iabervon.org>
Subject: Re: [PATCH] builtin-push: don't access freed transport->url
Date: Thu, 3 Dec 2009 18:38:13 -0500 (EST)
Message-ID: <alpine.LNX.2.00.0912031837570.14365@iabervon.org>
References: <20091204073144.f98115f9.rctay89@gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Git Mailing List <git@vger.kernel.org>,
	Sverre Rabbelier <srabbelier@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
To: Tay Ray Chuan <rctay89@gmail.com>
X-From: git-owner@vger.kernel.org Fri Dec 04 00:40:01 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NGLHF-0007cH-7Q
	for gcvg-git-2@lo.gmane.org; Fri, 04 Dec 2009 00:40:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755267AbZLCXiN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 3 Dec 2009 18:38:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755105AbZLCXiK
	(ORCPT <rfc822;git-outgoing>); Thu, 3 Dec 2009 18:38:10 -0500
Received: from iabervon.org ([66.92.72.58]:50916 "EHLO iabervon.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754575AbZLCXiH (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 3 Dec 2009 18:38:07 -0500
Received: (qmail 29824 invoked by uid 1000); 3 Dec 2009 23:38:13 -0000
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 3 Dec 2009 23:38:13 -0000
In-Reply-To: <20091204073144.f98115f9.rctay89@gmail.com>
User-Agent: Alpine 2.00 (LNX 1167 2008-08-23)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/134483>

On Fri, 4 Dec 2009, Tay Ray Chuan wrote:

> Move the failed push message to before transport_disconnect() so that
> it doesn't access transport->url after transport has been free()'d (in
> transport_disconnect()).
> 
> Additionally, make the failed push message more accurate by moving it
> before transport_disconnect(), so that it doesn't report errors due
> to a failed disconnect.
> 
> Cc: "Daniel Barkalow" <barkalow@iabervon.org>
> Signed-off-by: Tay Ray Chuan <rctay89@gmail.com>

Acked-by: Daniel Barkalow <barkalow@iabervon.org>

> ---
>  builtin-push.c |    5 +++--
>  1 files changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/builtin-push.c b/builtin-push.c
> index a21e46c..dcfb53f 100644
> --- a/builtin-push.c
> +++ b/builtin-push.c
> @@ -101,13 +101,14 @@ static int push_with_options(struct transport *transport, int flags)
>  		fprintf(stderr, "Pushing to %s\n", transport->url);
>  	err = transport_push(transport, refspec_nr, refspec, flags,
>  			     &nonfastforward);
> +	if (err != 0)
> +		error("failed to push some refs to '%s'", transport->url);
> +
>  	err |= transport_disconnect(transport);
> 
>  	if (!err)
>  		return 0;
> 
> -	error("failed to push some refs to '%s'", transport->url);
> -
>  	if (nonfastforward && advice_push_nonfastforward) {
>  		printf("To prevent you from losing history, non-fast-forward updates were rejected\n"
>  		       "Merge the remote changes before pushing again.  See the 'non-fast-forward'\n"
> --
> 1.6.6.rc1.249.g048b3
> 
