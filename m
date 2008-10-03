From: Daniel Barkalow <barkalow@iabervon.org>
Subject: Re: [PATCH] Fix argument handling for fetch-pack call when stdout
 is connected and -q/--quiet is supplied.
Date: Fri, 3 Oct 2008 15:50:34 -0400 (EDT)
Message-ID: <alpine.LNX.1.00.0810031548260.19665@iabervon.org>
References: <4ac8254d0810031234x26ebc96cy7cf5dcae2ef516e0@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org, davej@codemonkey.org.uk
To: Tuncer Ayaz <tuncer.ayaz@gmail.com>
X-From: git-owner@vger.kernel.org Fri Oct 03 21:52:11 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Klqh8-0007CD-C8
	for gcvg-git-2@gmane.org; Fri, 03 Oct 2008 21:52:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753476AbYJCTug (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 3 Oct 2008 15:50:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751754AbYJCTug
	(ORCPT <rfc822;git-outgoing>); Fri, 3 Oct 2008 15:50:36 -0400
Received: from iabervon.org ([66.92.72.58]:51971 "EHLO iabervon.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750951AbYJCTuf (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 3 Oct 2008 15:50:35 -0400
Received: (qmail 8324 invoked by uid 1000); 3 Oct 2008 19:50:34 -0000
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 3 Oct 2008 19:50:34 -0000
In-Reply-To: <4ac8254d0810031234x26ebc96cy7cf5dcae2ef516e0@mail.gmail.com>
User-Agent: Alpine 1.00 (LNX 882 2007-12-20)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/97447>

On Fri, 3 Oct 2008, Tuncer Ayaz wrote:

> Following is a patch to complete the changes discussed
> here http://marc.info/?l=git&m=121529226023180&w=2.
> 
> I hope it makes sense and doesn't break something else.
> 
> With this simple one-liner patch applied I no longer see
> the following remote messages as no-progress is correctly
> sent to the remote site:
> remote: Counting objects: 84102, done.
> remote: Compressing objects: 100% (24720/24720), done.
> remote: Total 84102 (delta 60949), reused 80810 (delta 57900)
> 
> Regards,
> 
>         Tuncer Ayaz
> 
> Signed-off-by: Tuncer Ayaz <tuncer.ayaz@gmail.com>
> ---
>  transport.c |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
> 
> diff --git a/transport.c b/transport.c
> index 71433d9..1f24011 100644
> --- a/transport.c
> +++ b/transport.c
> @@ -644,7 +644,7 @@ static int fetch_refs_via_pack(struct transport *transport,
>     args.include_tag = data->followtags;
>     args.verbose = (transport->verbose > 0);
>     args.quiet = args.no_progress = (transport->verbose < 0);
> -   args.no_progress = !isatty(1);
> +   args.no_progress = args.quiet || !isatty(1);

If you're doing that, remove the "args.no_progress =" from the previous 
line, which was there to have that effect (but not so clearly). Aside from 
that, it looks good to me.

>     args.depth = data->depth;
> 
>     for (i = 0; i < nr_heads; i++)
> -- 
> 1.6.0.2
> 
