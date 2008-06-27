From: Daniel Barkalow <barkalow@iabervon.org>
Subject: Re: [PATCH 2/2] clone: respect url.insteadOf setting in global
 configs
Date: Fri, 27 Jun 2008 12:08:53 -0400 (EDT)
Message-ID: <alpine.LNX.1.00.0806271205430.19665@iabervon.org>
References: <27C25D70-0BFC-4362-A771-C7CAD89BC198@ai.rug.nl> <alpine.DEB.1.00.0806271353350.9925@racer> <alpine.DEB.1.00.0806271355520.9925@racer>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Pieter de Bie <pdebie@ai.rug.nl>,
	Git Mailinglist <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Fri Jun 27 18:10:18 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KCGWP-0007Ds-R6
	for gcvg-git-2@gmane.org; Fri, 27 Jun 2008 18:10:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759540AbYF0QI4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 27 Jun 2008 12:08:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757498AbYF0QIz
	(ORCPT <rfc822;git-outgoing>); Fri, 27 Jun 2008 12:08:55 -0400
Received: from iabervon.org ([66.92.72.58]:36370 "EHLO iabervon.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757211AbYF0QIy (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 27 Jun 2008 12:08:54 -0400
Received: (qmail 17630 invoked by uid 1000); 27 Jun 2008 16:08:53 -0000
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 27 Jun 2008 16:08:53 -0000
In-Reply-To: <alpine.DEB.1.00.0806271355520.9925@racer>
User-Agent: Alpine 1.00 (LNX 882 2007-12-20)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/86577>

On Fri, 27 Jun 2008, Johannes Schindelin wrote:

> When we call "git clone" with a url that has a rewrite rule in either
> $HOME/.gitconfig or /etc/gitconfig, the URL can be different from
> what the command line expects it to be.
> 
> So, let's use the URL as the remote structure has it, not the literal
> string from the command line.

This is how it should be.

Maybe I ought to make transport_get() take the index of the URL in the 
list for the remote, instead of taking the actual URL; any use of a URL 
that's not from that list is going to be oddly wrong in some way, I think.

Thanks for taking care of this.

> Noticed by Pieter de Bie.
> 
> Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
> ---
>  builtin-clone.c |    3 ++-
>  1 files changed, 2 insertions(+), 1 deletions(-)
> 
> diff --git a/builtin-clone.c b/builtin-clone.c
> index 965b5fc..8dda52a 100644
> --- a/builtin-clone.c
> +++ b/builtin-clone.c
> @@ -463,7 +463,8 @@ int cmd_clone(int argc, const char **argv, const char *prefix)
>  		refs = clone_local(path, git_dir);
>  	else {
>  		struct remote *remote = remote_get(argv[0]);
> -		struct transport *transport = transport_get(remote, argv[0]);
> +		struct transport *transport =
> +			transport_get(remote, remote->url[0]);
>  
>  		if (!transport->get_refs_list || !transport->fetch)
>  			die("Don't know how to clone %s", transport->url);
> -- 
> 1.5.6.173.gde14c
> 
> 
> 
