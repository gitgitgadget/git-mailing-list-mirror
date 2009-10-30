From: Daniel Barkalow <barkalow@iabervon.org>
Subject: Re: [PATCH 02/19] Allow fetch to modify refs
Date: Fri, 30 Oct 2009 01:56:05 -0400 (EDT)
Message-ID: <alpine.LNX.2.00.0910300151450.14365@iabervon.org>
References: <1256839287-19016-1-git-send-email-srabbelier@gmail.com> <1256839287-19016-3-git-send-email-srabbelier@gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Git List <git@vger.kernel.org>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Johan Herland <johan@herland.net>
To: Sverre Rabbelier <srabbelier@gmail.com>
X-From: git-owner@vger.kernel.org Fri Oct 30 06:56:15 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N3kT8-0002Dg-F5
	for gcvg-git-2@lo.gmane.org; Fri, 30 Oct 2009 06:56:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755881AbZJ3F4D (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 30 Oct 2009 01:56:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755605AbZJ3F4C
	(ORCPT <rfc822;git-outgoing>); Fri, 30 Oct 2009 01:56:02 -0400
Received: from iabervon.org ([66.92.72.58]:38968 "EHLO iabervon.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754764AbZJ3F4B (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 30 Oct 2009 01:56:01 -0400
Received: (qmail 15800 invoked by uid 1000); 30 Oct 2009 05:56:05 -0000
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 30 Oct 2009 05:56:05 -0000
In-Reply-To: <1256839287-19016-3-git-send-email-srabbelier@gmail.com>
User-Agent: Alpine 2.00 (LNX 1167 2008-08-23)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/131673>

On Thu, 29 Oct 2009, Sverre Rabbelier wrote:

> From: Daniel Barkalow <barkalow@iabervon.org>
> 
> This allows the transport to use the null sha1 for a ref reported to
> be present in the remote repository to indicate that a ref exists but
> its actual value is presently unknown and will be set if the objects
> are fetched.
> 
> Also adds documentation to the API to specify exactly what the methods
> should do and how they should interpret arguments.
> 
> Signed-off-by: Daniel Barkalow <barkalow@iabervon.org>
> Signed-off-by: Sverre Rabbelier <srabbelier@gmail.com>
> ---
> 
> 	Signed off by me because I rebased it on master and fixed the
> 	conflicts with nico's patch.
> 
>  builtin-clone.c    |    5 +++--
>  transport-helper.c |    4 ++--
>  transport.c        |   13 +++++++------
>  transport.h        |   41 +++++++++++++++++++++++++++++++++++++++--
>  4 files changed, 51 insertions(+), 12 deletions(-)
> 
> diff --git a/builtin-clone.c b/builtin-clone.c
> index 5762a6f..0042bee 100644
> --- a/builtin-clone.c
> +++ b/builtin-clone.c
> @@ -526,8 +526,9 @@ int cmd_clone(int argc, const char **argv, const char *prefix)
>  
>  		refs = transport_get_remote_refs(transport);
>  		if (refs) {
> -			mapped_refs = wanted_peer_refs(refs, refspec);
> -			transport_fetch_refs(transport, mapped_refs);
> +			struct ref *ref_cpy = wanted_peer_refs(refs, refspec);
> +			mapped_refs = ref_cpy;
> +			transport_fetch_refs(transport, ref_cpy);

Just drop this hunk; the change doesn't actually do anything. Otherwise, 
the patch matches what I have.

	-Daniel
*This .sig left intentionally blank*
