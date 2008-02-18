From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] branch: optionally setup branch.*.merge from upstream
 local branches
Date: Mon, 18 Feb 2008 14:05:36 +0000 (GMT)
Message-ID: <alpine.LSU.1.00.0802181403040.30505@racer.site>
References: alpine.LSU.1.00.0802181328380.30505@racer.site <1203342817-19653-1-git-send-email-jaysoffian@gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: Jay Soffian <jaysoffian@gmail.com>
X-From: git-owner@vger.kernel.org Mon Feb 18 15:06:25 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JR6dU-0001Ht-Tn
	for gcvg-git-2@gmane.org; Mon, 18 Feb 2008 15:06:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751583AbYBROFu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 18 Feb 2008 09:05:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751517AbYBROFu
	(ORCPT <rfc822;git-outgoing>); Mon, 18 Feb 2008 09:05:50 -0500
Received: from mail.gmx.net ([213.165.64.20]:58649 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751462AbYBROFt (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 18 Feb 2008 09:05:49 -0500
Received: (qmail invoked by alias); 18 Feb 2008 14:05:46 -0000
Received: from unknown (EHLO [138.251.11.74]) [138.251.11.74]
  by mail.gmx.net (mp055) with SMTP; 18 Feb 2008 15:05:46 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX19S8nZfYRNSTvXVv201v3XWgQxAUn6TxOHnCGn9fk
	h5GUl4V3bYrok0
X-X-Sender: gene099@racer.site
In-Reply-To: <1203342817-19653-1-git-send-email-jaysoffian@gmail.com>
User-Agent: Alpine 1.00 (LSU 882 2007-12-20)
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/74293>

Hi,

On Mon, 18 Feb 2008, Jay Soffian wrote:

>  Incorporated Johannes' second round of feedback.

Not exactly.

> diff --git a/branch.c b/branch.c
> index 1fc8788..64f0a4a 100644
> --- a/branch.c
> +++ b/branch.c
> @@ -37,7 +37,7 @@ static int find_tracked_branch(struct remote *remote, void *priv)
>   * to infer the settings for branch.<new_ref>.{remote,merge} from the
>   * config.
>   */
> -static int setup_tracking(const char *new_ref, const char *orig_ref)
> +static int setup_tracking(const char *new_ref, const char *orig_ref, int always)
>  {
>  	char key[1024];
>  	struct tracking tracking;
> @@ -49,8 +49,12 @@ static int setup_tracking(const char *new_ref, const char *orig_ref)
>  	memset(&tracking, 0, sizeof(tracking));
>  	tracking.spec.dst = (char *)orig_ref;
>  	if (for_each_remote(find_tracked_branch, &tracking) ||
> -			!tracking.matches)
> -		return 1;
> +			!tracking.matches) {
> +		if (!always)
> +			return 1;
> +		tracking.matches = 1;
> +		tracking.src = xstrdup(orig_ref);
> +	}
>  

This looks completely different than what I commented on.  And my comments 
suggested a different solution.

Unfortunately, I will not have time for the rest of the day to review that 
new thing (it is not at all obvious for me why this works as intended, and 
does not break anything else).

But you can use the time to write some tests ;-)

Ciao,
Dscho
