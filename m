From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 08/21] remote: let guess_remote_head() optionally
	return all matches
Date: Thu, 26 Feb 2009 09:37:29 -0500
Message-ID: <20090226143729.GA9693@coredump.intra.peff.net>
References: <cover.1235546707.git.jaysoffian@gmail.com> <ad3c408c208c8a829b1e4a0c0818e808b19e1dfc.1235546708.git.jaysoffian@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: Jay Soffian <jaysoffian@gmail.com>
X-From: git-owner@vger.kernel.org Thu Feb 26 15:39:28 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LchOB-0005vW-Tk
	for gcvg-git-2@gmane.org; Thu, 26 Feb 2009 15:39:04 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752969AbZBZOhe (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 26 Feb 2009 09:37:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752610AbZBZOhe
	(ORCPT <rfc822;git-outgoing>); Thu, 26 Feb 2009 09:37:34 -0500
Received: from peff.net ([208.65.91.99]:41410 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751720AbZBZOhd (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 26 Feb 2009 09:37:33 -0500
Received: (qmail 5161 invoked by uid 107); 26 Feb 2009 14:37:57 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Thu, 26 Feb 2009 09:37:57 -0500
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Thu, 26 Feb 2009 09:37:29 -0500
Content-Disposition: inline
In-Reply-To: <ad3c408c208c8a829b1e4a0c0818e808b19e1dfc.1235546708.git.jaysoffian@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/111564>

On Wed, Feb 25, 2009 at 03:32:15AM -0500, Jay Soffian wrote:

> +struct ref *copy_ref_with_peer(const struct ref *src)
> +{
> +	struct ref *dst = copy_ref(src);
> +	dst->peer_ref = copy_ref(src->peer_ref);
> +	return dst;
> +}

Hmm. This should probably be:

  dst->peer_ref = src->peer_ref ? copy_ref(src->peer_ref) : NULL;

(or copy_ref should return NULL when given NULL). I also wonder if the
copied ref's peer_ref should be explicitly NULL'd.

I don't think it matters for the current code, since we always feed it
"matched refs" which have a peer, but I think it is good to be a little
more defensive in such a generically-named function.

And yes, this bug was in my original patch. :)

-Peff
