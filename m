From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH 2/2] Allow http authentication via prompt for http
 push.
Date: Thu, 19 Mar 2009 17:59:32 +0100 (CET)
Message-ID: <alpine.DEB.1.00.0903191755270.6357@intel-tinevez-2-302>
References: <d8c371a80903190812w59febbd3qc6bc3d70ce85f76e@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: Amos King <amos.l.king@gmail.com>
X-From: git-owner@vger.kernel.org Thu Mar 19 18:03:15 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LkLcs-0008Mv-Bf
	for gcvg-git-2@gmane.org; Thu, 19 Mar 2009 18:01:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750933AbZCSQ7i (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 19 Mar 2009 12:59:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751067AbZCSQ7i
	(ORCPT <rfc822;git-outgoing>); Thu, 19 Mar 2009 12:59:38 -0400
Received: from mail.gmx.net ([213.165.64.20]:35819 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1750722AbZCSQ7h (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 19 Mar 2009 12:59:37 -0400
Received: (qmail invoked by alias); 19 Mar 2009 16:59:34 -0000
Received: from cbg-off-client.mpi-cbg.de (EHLO intel-tinevez-2-302.mpi-cbg.de) [141.5.11.5]
  by mail.gmx.net (mp048) with SMTP; 19 Mar 2009 17:59:34 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX18zqL4zzQozLAu+f1CXa+F6leVWuP649WCI8RmPus
	toNYDkbqano0th
X-X-Sender: schindel@intel-tinevez-2-302
In-Reply-To: <d8c371a80903190812w59febbd3qc6bc3d70ce85f76e@mail.gmail.com>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.52
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/113794>

Hi,

On Thu, 19 Mar 2009, Amos King wrote:

> There is now a faux remote created in order to
> be passed to http_init.
> 
> Signed-off-by: Amos King <amos.l.king@gmail.com>
> ---
>  http-push.c |   11 ++++++++++-
>  1 files changed, 10 insertions(+), 1 deletions(-)
> 
> diff --git a/http-push.c b/http-push.c
> index 9ac2664..468d5af 100644
> --- a/http-push.c
> +++ b/http-push.c
> @@ -2195,7 +2195,16 @@ int main(int argc, char **argv)
> 
>  	memset(remote_dir_exists, -1, 256);
> 
> -	http_init(NULL);
> +	/*
> +	 * This is a faked remote so that http_init can
> +	 * get the correct data for builidng out athorization.
> +	 */

You might want to pass this through aspell ;-)  Altough it will not 
suggest 'out ->our', I guess...

> +	struct remote *remote;
> +	remote = xcalloc(sizeof(*remote), 1);
> +	ALLOC_GROW(remote->url, remote->url_nr + 1, remote->url_alloc);
> +	remote->url[remote->url_nr++] = repo->url;
> +
> +	http_init(remote);

Would 'fake' not be a more appropriate name than 'remote'?

That would also make the patch 1/2 rather unnecessary (I also have to 
admit that I do not find 'repo' a better name, as we have a repository 
both locally and remotely, and this _is_ the remote repository, not the 
local one).

Ciao,
Dscho
