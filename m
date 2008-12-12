From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] git-branch: display sha1 on branch deletion
Date: Fri, 12 Dec 2008 14:43:51 -0500
Message-ID: <20081212194349.GA5486@sigill.intra.peff.net>
References: <uTIFnEi0iyLKcAungf7u1Gu2xl50j9i-AMiZaQp-QTs1q-ppgyHZoelGLgvK7BFKpYE03BLRHJ4@cipher.nrlssc.navy.mil>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: gitster@pobox.com, git@vger.kernel.org
To: Brandon Casey <casey@nrlssc.navy.mil>
X-From: git-owner@vger.kernel.org Fri Dec 12 20:45:25 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LBDwm-000095-FO
	for gcvg-git-2@gmane.org; Fri, 12 Dec 2008 20:45:12 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751830AbYLLTny (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 12 Dec 2008 14:43:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751702AbYLLTny
	(ORCPT <rfc822;git-outgoing>); Fri, 12 Dec 2008 14:43:54 -0500
Received: from peff.net ([208.65.91.99]:1423 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751331AbYLLTny (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 12 Dec 2008 14:43:54 -0500
Received: (qmail 15509 invoked by uid 111); 12 Dec 2008 19:43:53 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.32) with ESMTP; Fri, 12 Dec 2008 14:43:53 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 12 Dec 2008 14:43:51 -0500
Content-Disposition: inline
In-Reply-To: <uTIFnEi0iyLKcAungf7u1Gu2xl50j9i-AMiZaQp-QTs1q-ppgyHZoelGLgvK7BFKpYE03BLRHJ4@cipher.nrlssc.navy.mil>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/102934>

On Fri, Dec 12, 2008 at 01:29:01PM -0600, Brandon Casey wrote:

> Make it easier to recover from a mistaken branch deletion by displaying the
> sha1 of the branch's tip commit.

I think this is reasonable behavior, but I have two comments:

> -			printf("Deleted %sbranch %s.\n", remote, argv[i]);
> +			printf("Deleted %sbranch %s (%s).\n", remote, argv[i],
> +                                sha1_to_hex(sha1));

1. Any reason not to use find_unique_abbrev(sha1, DEFAULT_ABBREV) here?
   The full 40-character sha1 kind of dominates the line, especially if
   you have short branch name. And this is not really for long-term
   usage, but rather "oops, I didn't mean to have just deleted that".

2. I wonder if it is confusing to new users to simply say "Delete branch
   $branch ($sha1)". We haven't deleted $sha1, just the branch pointer.
   $sha1 is probably still in the HEAD reflog, if not in another branch.
   Maybe something like "(was $sha1)" would be appropriate.

I don't know if '2' is a big deal. I haven't been a new user for a long
time, so I didn't personally find it confusing (especially with '1' so
that you actually notice the branch name rather than the gigantic sha1).

-Peff
