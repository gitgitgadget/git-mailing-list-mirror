From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] http-push: Make WebDAV work with (broken?) default apache2 WebDAV module
Date: Wed, 09 Aug 2006 12:33:42 -0700
Message-ID: <7vk65h3drd.fsf@assigned-by-dhcp.cox.net>
References: <20060809185423.GB7841@nospam.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Nick Hengeveld <nickh@reactrix.com>
X-From: git-owner@vger.kernel.org Wed Aug 09 21:34:03 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GAtoN-0000Sm-Ee
	for gcvg-git@gmane.org; Wed, 09 Aug 2006 21:33:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751328AbWHITdp (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 9 Aug 2006 15:33:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751335AbWHITdp
	(ORCPT <rfc822;git-outgoing>); Wed, 9 Aug 2006 15:33:45 -0400
Received: from fed1rmmtao06.cox.net ([68.230.241.33]:56291 "EHLO
	fed1rmmtao06.cox.net") by vger.kernel.org with ESMTP
	id S1751328AbWHITdo (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 9 Aug 2006 15:33:44 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.5.203])
          by fed1rmmtao06.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20060809193343.RTNX6235.fed1rmmtao06.cox.net@assigned-by-dhcp.cox.net>;
          Wed, 9 Aug 2006 15:33:43 -0400
To: git@wingding.demon.nl
In-Reply-To: <20060809185423.GB7841@nospam.com> (Rutger Nijlunsing's message
	of "Wed, 9 Aug 2006 20:54:23 +0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/25138>

Rutger Nijlunsing <rutger@nospam.com> writes:

> WebDAV on Debian unstable cannot handle renames on WebDAV from
> file.ext to newfile (without ext) when newfile* already
> exists. Normally, git creates a file like 'objects/xx/sha1.token',
> which is renamed to 'objects/xx/sha1' when transferred completely.
>
> Just use '_' instead of '.' so WebDAV doesn't see it as an extension
> change.
>
> Signed-off-by: Rutger Nijlunsing <git@tux.tmfweb.nl>
> Acked-by: Johannes Schindelin <Johannes.Schindelin@gmx.de>

Good problem and workaround description.  Nick, does this look
sane to you, or is there a more kosher way to handle this?

> ---
>  http-push.c |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
>
> diff --git a/http-push.c b/http-push.c
> index 4021e7d..d45733e 100644
> --- a/http-push.c
> +++ b/http-push.c
> @@ -530,7 +530,7 @@ static void start_put(struct transfer_re
>  	request->dest = xmalloc(strlen(request->url) + 14);
>  	sprintf(request->dest, "Destination: %s", request->url);
>  	posn += 38;
> -	*(posn++) = '.';
> +	*(posn++) = '_';
>  	strcpy(posn, request->lock->token);
>  
>  	slot = get_active_slot();
> -- 
> 1.4.2.rc2.g7cb1
>
>
> -- 
> Rutger Nijlunsing ---------------------------------- eludias ed dse.nl
> never attribute to a conspiracy which can be explained by incompetence
> ----------------------------------------------------------------------
