From: Jeff King <peff@peff.net>
Subject: Re: Latest master failing t7401 submodule tests
Date: Wed, 3 Mar 2010 17:57:44 -0500
Message-ID: <20100303225744.GA26575@coredump.intra.peff.net>
References: <4B8E5450.3040702@gmail.com>
 <7vhboxqje8.fsf@alter.siamese.dyndns.org>
 <20100303200239.GA28904@coredump.intra.peff.net>
 <7vhboxno38.fsf@alter.siamese.dyndns.org>
 <20100303204257.GA5501@coredump.intra.peff.net>
 <7v3a0hktga.fsf@alter.siamese.dyndns.org>
 <7vzl2phz8e.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Johan Herland <johan@herland.net>,
	A Large Angry SCM <gitzilla@gmail.com>,
	git <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Mar 03 23:57:50 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NmxVl-0005KB-K8
	for gcvg-git-2@lo.gmane.org; Wed, 03 Mar 2010 23:57:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750880Ab0CCW5r (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 3 Mar 2010 17:57:47 -0500
Received: from peff.net ([208.65.91.99]:49049 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750804Ab0CCW5p (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 3 Mar 2010 17:57:45 -0500
Received: (qmail 16027 invoked by uid 107); 3 Mar 2010 22:58:05 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Wed, 03 Mar 2010 17:58:05 -0500
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Wed, 03 Mar 2010 17:57:44 -0500
Content-Disposition: inline
In-Reply-To: <7vzl2phz8e.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/141488>

On Wed, Mar 03, 2010 at 01:28:01PM -0800, Junio C Hamano wrote:

> Continuing to mutter to myself...  I am suspecting that the right solution
> to the issue $gmane/140066 raised may be your "dwim-ref fix in 003c6ab
> (dwim_ref: fix dangling symref warning, 2010-02-16) and a patch along the
> line of the attached (with 3deea89 reverted of course).

I am totally clueless about submodules, not having ever actually used
them myself. So I will let others weigh in on whether "git submodule
summary" on an unborn branch makes any sense. But:

  1. _if_ it is not a sensible thing, then your patch below:

> diff --git a/wt-status.c b/wt-status.c
> index 5807fc3..1cca3aa 100644
> --- a/wt-status.c
> +++ b/wt-status.c
> @@ -476,6 +476,9 @@ static void wt_status_print_submodule_summary(struct wt_status *s, int uncommitt
>  		NULL
>  	};
>  
> +	if (s->is_initial && !uncommitted)
> +		return;
> +
>  	sprintf(summary_limit, "%d", s->submodule_summary);
>  	snprintf(index, sizeof(index), "GIT_INDEX_FILE=%s", s->index_file);

Seems like the right thing, to protect git-status users.

  2. If it is sensible, then the hunk we both posted (to check for args
     before shift) makes sense to me. Whether the "compare against empty
     tree" bit makes sense is beyond my submodule cluelessness to
     determine (but it intuitively sounds right to me).

In either case, I think that:

> We _might_ also want to revert 003c6ab, though it is more or less an
> independent issue.

reverting 003c6ab is not a good idea. As far as I am concerned, it was a
bugfix.

-Peff
