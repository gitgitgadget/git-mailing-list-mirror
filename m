From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 3/4] Prepare testsuite for a "git clone" that packs refs
Date: Sun, 15 Jun 2008 13:54:18 -0400
Message-ID: <20080615175418.GB6127@sigill.intra.peff.net>
References: <200806151602.03445.johan@herland.net> <200806151605.47214.johan@herland.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Daniel Barkalow <barkalow@iabervon.org>
To: Johan Herland <johan@herland.net>
X-From: git-owner@vger.kernel.org Sun Jun 15 19:55:16 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K7wRf-0004ep-AK
	for gcvg-git-2@gmane.org; Sun, 15 Jun 2008 19:55:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758697AbYFORyV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 15 Jun 2008 13:54:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758696AbYFORyV
	(ORCPT <rfc822;git-outgoing>); Sun, 15 Jun 2008 13:54:21 -0400
Received: from peff.net ([208.65.91.99]:4916 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758689AbYFORyU (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 15 Jun 2008 13:54:20 -0400
Received: (qmail 3729 invoked by uid 111); 15 Jun 2008 17:54:20 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.32) with ESMTP; Sun, 15 Jun 2008 13:54:20 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sun, 15 Jun 2008 13:54:18 -0400
Content-Disposition: inline
In-Reply-To: <200806151605.47214.johan@herland.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/85102>

On Sun, Jun 15, 2008 at 04:05:47PM +0200, Johan Herland wrote:

> .git/packed-refs. This patch therefore teaches t5515-fetch-merge-logic
> to also remove the refs in question from the packed-refs file.
> [...]
> +			cat .git/packed-refs | \
> +			while read sha1 refname
> +			do
> +				case "$sha1" in
> +				^*) # remove peeled tags
> +					;;
> +				*)
> +					case "$refname" in
> +					refs/heads/*|\
> +					refs/remotes/rem/*|\
> +					refs/tags/*) # remove same as above
> +						;;
> +					*) # keep everything else
> +						echo "$sha1 $refname"
> +						;;
> +					esac
> +				esac
> +			done > .git/packed-refs.new
> +			mv .git/packed-refs.new .git/packed-refs

Might it not be simpler to just convert it to use plumbing to delete the
refs? Something like piping for-each-ref into update-ref -d?

-Peff
