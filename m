From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 1/2] diff: change semantics of "ignore whitespace"
	options
Date: Mon, 25 May 2009 07:04:29 -0400
Message-ID: <20090525110429.GB27070@coredump.intra.peff.net>
References: <1243106690-6385-1-git-send-email-gitster@pobox.com> <1243106690-6385-2-git-send-email-gitster@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon May 25 13:05:00 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M8Xz7-0005oy-J9
	for gcvg-git-2@gmane.org; Mon, 25 May 2009 13:04:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752731AbZEYLEb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 25 May 2009 07:04:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752339AbZEYLEb
	(ORCPT <rfc822;git-outgoing>); Mon, 25 May 2009 07:04:31 -0400
Received: from peff.net ([208.65.91.99]:42999 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752074AbZEYLEa (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 25 May 2009 07:04:30 -0400
Received: (qmail 3963 invoked by uid 107); 25 May 2009 11:04:33 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Mon, 25 May 2009 07:04:33 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Mon, 25 May 2009 07:04:29 -0400
Content-Disposition: inline
In-Reply-To: <1243106690-6385-2-git-send-email-gitster@pobox.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/119921>

On Sat, May 23, 2009 at 12:24:49PM -0700, Junio C Hamano wrote:

> When --quiet is in effect, various diff frontends optimize by breaking out
> early from the loop that enumerates the filepairs, when we find the first
> path level difference; when --ignore-whitespace* is used the above change
> automatically disables this optimization.

Both patches in this series look good to me, with one slight exception:

> +	if ((XDF_IGNORE_WHITESPACE|
> +	     XDF_IGNORE_WHITESPACE_CHANGE|
> +	     XDF_IGNORE_WHITESPACE_AT_EOL) & options->xdl_opts) {
> +		DIFF_OPT_SET(options, DIFF_FROM_CONTENTS);
> +	} else {
> +		DIFF_OPT_CLR(options, DIFF_FROM_CONTENTS);
> +	}

We have DIFF_XDL_TST these days; while it is currently equivalent to
what you do here, I thought part of the purpose was to abstract it to
make it simpler to later add master/slave magic.

-Peff
