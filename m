From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 3/6] receive-pack: receive.denyDeleteCurrent
Date: Mon, 9 Feb 2009 13:53:10 -0500
Message-ID: <20090209185310.GB27037@coredump.intra.peff.net>
References: <1234170565-6740-1-git-send-email-gitster@pobox.com> <1234170565-6740-2-git-send-email-gitster@pobox.com> <1234170565-6740-3-git-send-email-gitster@pobox.com> <1234170565-6740-4-git-send-email-gitster@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Feb 09 19:54:53 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LWbHE-0007Wn-I4
	for gcvg-git-2@gmane.org; Mon, 09 Feb 2009 19:54:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753903AbZBISxN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 9 Feb 2009 13:53:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753868AbZBISxN
	(ORCPT <rfc822;git-outgoing>); Mon, 9 Feb 2009 13:53:13 -0500
Received: from peff.net ([208.65.91.99]:35425 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753678AbZBISxM (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 9 Feb 2009 13:53:12 -0500
Received: (qmail 4277 invoked by uid 107); 9 Feb 2009 18:53:28 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Mon, 09 Feb 2009 13:53:28 -0500
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Mon, 09 Feb 2009 13:53:10 -0500
Content-Disposition: inline
In-Reply-To: <1234170565-6740-4-git-send-email-gitster@pobox.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/109101>

On Mon, Feb 09, 2009 at 01:09:22AM -0800, Junio C Hamano wrote:

> This is a companion patch to the recent 3d95d92 (receive-pack: explain
> what to do when push updates the current branch, 2009-01-31).
> 
> Deleting the current branch from a remote will result in the next clone
> from it not check out anything, among other things.  It also is one of the
> cause that makes remotes/origin/HEAD a dangling symbolic ref.  This patch
> still allows the traditional behaviour but with a big warning, and promises
> that the default will change to 'refuse' in a future release.

This patch looks good to me. One comment:

> --- a/t/t5400-send-pack.sh
> +++ b/t/t5400-send-pack.sh
> @@ -193,4 +193,11 @@ test_expect_success 'pushing wildcard refspecs respects forcing' '
>      )
>  '
>  
> +test_expect_success 'deny pushing to delete current branch' '
> +    (
> +	rewound_push_setup &&
> +	git send-pack ../parent/.git :refs/heads/master 2>errs
> +    )
> +'

It was not immediately obvious why the subshell is needed here (for
those in the audience, it is because rewound_push_setup changes
directory). Perhaps 2/6 should be amended for rewound_push_setup to use
a subshell instead, which makes it less likely to be forgotten by new
tests.

-Peff
