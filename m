From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 3/5] wt-status.c: rework the way changes to the index
 and work tree are summarized
Date: Thu, 6 Aug 2009 10:46:39 -0400
Message-ID: <20090806144638.GA1970@coredump.intra.peff.net>
References: <1249463746-21538-1-git-send-email-gitster@pobox.com>
 <1249463746-21538-2-git-send-email-gitster@pobox.com>
 <1249463746-21538-3-git-send-email-gitster@pobox.com>
 <1249463746-21538-4-git-send-email-gitster@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Aug 06 16:46:55 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MZ4F3-0002eS-72
	for gcvg-git-2@gmane.org; Thu, 06 Aug 2009 16:46:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752410AbZHFOqp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 6 Aug 2009 10:46:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751867AbZHFOqo
	(ORCPT <rfc822;git-outgoing>); Thu, 6 Aug 2009 10:46:44 -0400
Received: from peff.net ([208.65.91.99]:47028 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751528AbZHFOqo (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 6 Aug 2009 10:46:44 -0400
Received: (qmail 31898 invoked by uid 107); 6 Aug 2009 14:48:54 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Thu, 06 Aug 2009 10:48:54 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Thu, 06 Aug 2009 10:46:39 -0400
Content-Disposition: inline
In-Reply-To: <1249463746-21538-4-git-send-email-gitster@pobox.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/125073>

On Wed, Aug 05, 2009 at 02:15:44AM -0700, Junio C Hamano wrote:

> diff --git a/wt-status.c b/wt-status.c
> index 47735d8..1614352 100644
> --- a/wt-status.c
> +++ b/wt-status.c
> @@ -20,6 +20,7 @@ static char wt_status_colors[][COLOR_MAXLEN] = {
>  	GIT_COLOR_RED,    /* WT_STATUS_CHANGED */
>  	GIT_COLOR_RED,    /* WT_STATUS_UNTRACKED */
>  	GIT_COLOR_RED,    /* WT_STATUS_NOBRANCH */
> +	GIT_COLOR_YELLOW, /* WT_STATUS_UNMERGED */
>  };

Does this belong in 3/5? It looks like the WT_STATUS_UNMERGED symbol is
not used at all until 4/5, which seems like the more logical place
(since it deals explicitly with unmerged entries). Also, why does it
start yellow here and then turn to red in the next patch?

And related:

> diff --git a/wt-status.h b/wt-status.h
> index 78add09..f80142f 100644
> --- a/wt-status.h
> +++ b/wt-status.h
> [...]
>  	WT_STATUS_NOBRANCH,
> +	WT_STATUS_UNMERGED,

-Peff
