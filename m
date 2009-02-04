From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 2/2] builtin-remote: make rm operation safer in
	mirrored repository
Date: Wed, 4 Feb 2009 10:42:27 -0500
Message-ID: <20090204154227.GE6896@sigill.intra.peff.net>
References: <76718490902030638y36299191i1fcc2ab8646b9593@mail.gmail.com> <1233683473-87893-2-git-send-email-jaysoffian@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: Jay Soffian <jaysoffian@gmail.com>
X-From: git-owner@vger.kernel.org Wed Feb 04 16:44:14 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LUjvA-0005UJ-2J
	for gcvg-git-2@gmane.org; Wed, 04 Feb 2009 16:44:12 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754584AbZBDPmc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 4 Feb 2009 10:42:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754649AbZBDPmc
	(ORCPT <rfc822;git-outgoing>); Wed, 4 Feb 2009 10:42:32 -0500
Received: from peff.net ([208.65.91.99]:56321 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752629AbZBDPmb (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 4 Feb 2009 10:42:31 -0500
Received: (qmail 29845 invoked by uid 107); 4 Feb 2009 15:42:44 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.40) with ESMTPA; Wed, 04 Feb 2009 10:42:44 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 04 Feb 2009 10:42:27 -0500
Content-Disposition: inline
In-Reply-To: <1233683473-87893-2-git-send-email-jaysoffian@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/108383>

On Tue, Feb 03, 2009 at 12:51:13PM -0500, Jay Soffian wrote:

> So much work for what seemed such a minor change. :) I hope this version is
> well-polished enough.

The more minor the change, the more major the comments. :) Thanks for
sticking with it. This version looks good to me except for one thing:

> +	/* don't delete non-remote branches */
> +	if (prefixcmp(refname, "refs/remotes")) {
> +		if (!prefixcmp(refname, "refs/heads/"))
> +			string_list_append(abbrev_branch(refname),
> +					   branches->skipped);
> +		return 0;
> +	}

Why does this version introduce the "only skip refs/heads/" check?
Shouldn't we also protect other random refs (or if not, shouldn't the
commit message explain why not)?

> +	if (skipped.nr) {
> +		fprintf(stderr, skipped.nr == 1 ?
> +			"Note: A non-remote branch was not removed; "
> +			"to delete it, use:\n" :
> +			"Note: Non-remote branches were not removed; "
> +			"to delete them, use:\n");

Ooh, proper pluralization. Classy.

-Peff
