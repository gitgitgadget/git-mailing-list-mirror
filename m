From: Jeff King <peff@peff.net>
Subject: Re: [PATCHv2 3/4] bundle: don't leak an fd in case of early return
Date: Wed, 30 Mar 2016 13:23:54 -0400
Message-ID: <20160330172354.GB19675@sigill.intra.peff.net>
References: <1459357518-14913-1-git-send-email-sbeller@google.com>
 <1459357518-14913-4-git-send-email-sbeller@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: sunshine@sunshineco.com, gitster@pobox.com, git@vger.kernel.org
To: Stefan Beller <sbeller@google.com>
X-From: git-owner@vger.kernel.org Wed Mar 30 19:24:14 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1alJqn-0000qN-CR
	for gcvg-git-2@plane.gmane.org; Wed, 30 Mar 2016 19:24:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754912AbcC3RX6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 30 Mar 2016 13:23:58 -0400
Received: from cloud.peff.net ([50.56.180.127]:40972 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751055AbcC3RX5 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 30 Mar 2016 13:23:57 -0400
Received: (qmail 10639 invoked by uid 102); 30 Mar 2016 17:23:56 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Wed, 30 Mar 2016 13:23:56 -0400
Received: (qmail 4686 invoked by uid 107); 30 Mar 2016 17:23:56 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Wed, 30 Mar 2016 13:23:56 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 30 Mar 2016 13:23:54 -0400
Content-Disposition: inline
In-Reply-To: <1459357518-14913-4-git-send-email-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/290324>

On Wed, Mar 30, 2016 at 10:05:17AM -0700, Stefan Beller wrote:

> diff --git a/bundle.c b/bundle.c
> index 506ac49..fbc8593 100644
> --- a/bundle.c
> +++ b/bundle.c
> @@ -407,6 +407,7 @@ int create_bundle(struct bundle_header *header, const char *path,
>  	int bundle_to_stdout;
>  	int ref_count = 0;
>  	struct rev_info revs;
> +	int ret = -1;

A minor nit, but I don't think we ever put anything but "-1" in this
variable. It could go away and we can just "return -1" in the "err"
path.

-Peff
