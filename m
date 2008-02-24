From: Daniel Barkalow <barkalow@iabervon.org>
Subject: Re: [PATCH] checkout: error out when index is unmerged even with
 -m
Date: Sun, 24 Feb 2008 01:29:26 -0500 (EST)
Message-ID: <alpine.LNX.1.00.0802240121170.19024@iabervon.org>
References: <alpine.LFD.1.00.0802231323590.21332@woody.linux-foundation.org> <7v8x1b1fiu.fsf@gitster.siamese.dyndns.org> <alpine.LFD.1.00.0802231430100.21332@woody.linux-foundation.org> <7vzltrz4cl.fsf@gitster.siamese.dyndns.org>
 <7voda7xmnk.fsf_-_@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Feb 24 07:30:33 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JTANZ-0003XN-O5
	for gcvg-git-2@gmane.org; Sun, 24 Feb 2008 07:30:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751170AbYBXG33 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 24 Feb 2008 01:29:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751033AbYBXG33
	(ORCPT <rfc822;git-outgoing>); Sun, 24 Feb 2008 01:29:29 -0500
Received: from iabervon.org ([66.92.72.58]:41093 "EHLO iabervon.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750948AbYBXG32 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 24 Feb 2008 01:29:28 -0500
Received: (qmail 26544 invoked by uid 1000); 24 Feb 2008 06:29:26 -0000
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 24 Feb 2008 06:29:26 -0000
In-Reply-To: <7voda7xmnk.fsf_-_@gitster.siamese.dyndns.org>
User-Agent: Alpine 1.00 (LNX 882 2007-12-20)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/74904>

On Sat, 23 Feb 2008, Junio C Hamano wrote:

> Even when -m is given to allow fallilng back to 3-way merge
> while switching branches, we should refuse if the original index
> is unmerged.

Acked-by: Daniel Barkalow <barkalow@iabervon.org>

> Signed-off-by: Junio C Hamano <gitster@pobox.com>
> ---
> 
>  * I think this bug was inherited from the scripted version.
>    Fixing it is much easier here.

I'm pretty sure it was. I wasn't clear on all the motivations for checkout 
-m behavior, so I tried to make it exactly the same.

>  builtin-checkout.c |    4 ++--
>  1 files changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/builtin-checkout.c b/builtin-checkout.c
> index 283831e..e028270 100644
> --- a/builtin-checkout.c
> +++ b/builtin-checkout.c
> @@ -226,8 +226,8 @@ static int merge_working_tree(struct checkout_opts *opts,
>  		refresh_cache(REFRESH_QUIET);
>  
>  		if (unmerged_cache()) {
> -			ret = opts->merge ? -1 :
> -				error("you need to resolve your current index first");
> +			error("you need to resolve your current index first");
> +			return 1;
>  		} else {
>  			topts.update = 1;
>  			topts.merge = 1;

Ditch the "else" now that it's not needed? And, actually, I think you can 
ditch most of the use of "ret" when there's only one case for getting to 
needing a real merge.

	-Daniel
*This .sig left intentionally blank*
