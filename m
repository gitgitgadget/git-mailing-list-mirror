From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 4/6] abbrev_sha1_in_line: don't leak memory
Date: Tue, 29 Mar 2016 21:11:11 -0400
Message-ID: <20160330011111.GB2237@sigill.intra.peff.net>
References: <1459298333-21899-1-git-send-email-sbeller@google.com>
 <1459298333-21899-5-git-send-email-sbeller@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: gitster@pobox.com, git@vger.kernel.org
To: Stefan Beller <sbeller@google.com>
X-From: git-owner@vger.kernel.org Wed Mar 30 03:11:21 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1al4fH-0007Tb-5A
	for gcvg-git-2@plane.gmane.org; Wed, 30 Mar 2016 03:11:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753345AbcC3BLP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 29 Mar 2016 21:11:15 -0400
Received: from cloud.peff.net ([50.56.180.127]:40466 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752995AbcC3BLO (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 29 Mar 2016 21:11:14 -0400
Received: (qmail 22808 invoked by uid 102); 30 Mar 2016 01:11:14 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Tue, 29 Mar 2016 21:11:14 -0400
Received: (qmail 30187 invoked by uid 107); 30 Mar 2016 01:11:13 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Tue, 29 Mar 2016 21:11:13 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 29 Mar 2016 21:11:11 -0400
Content-Disposition: inline
In-Reply-To: <1459298333-21899-5-git-send-email-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/290246>

On Tue, Mar 29, 2016 at 05:38:51PM -0700, Stefan Beller wrote:

> `split` is of type `struct strbuf **` and just before the new free,
> we release the inner strbufs. Make sure to also release the memory
> containing the pointers to the individual strbufs.
> 
> Signed-off-by: Stefan Beller <sbeller@google.com>
> ---
>  wt-status.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/wt-status.c b/wt-status.c
> index ef74864..a78cfc0 100644
> --- a/wt-status.c
> +++ b/wt-status.c
> @@ -1065,7 +1065,7 @@ static void abbrev_sha1_in_line(struct strbuf *line)
>  	}
>  	for (i = 0; split[i]; i++)
>  		strbuf_release(split[i]);
> -
> +	free(split);
>  }

I think this can just combine with the for-loop above to become
strbuf_list_free().

-Peff
