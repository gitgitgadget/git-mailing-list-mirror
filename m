From: Jeff King <peff@peff.net>
Subject: Re: [PATCH v2] git-branch: display sha1 on branch deletion
Date: Sat, 13 Dec 2008 01:31:05 -0500
Message-ID: <20081213063104.GA8480@coredump.intra.peff.net>
References: <AeIdfC6dcUaLaDHDaAdSq8Mxz6QoUdeypSUI24erUEyAHVz4HeTSCw@cipher.nrlssc.navy.mil> <UfCPFu_boLV0ycLKLmOno8GTqmtC4RSZZ9O6aRLGYjmSZOdKv6ywhCjApnplTHLxUIzO8KJ5Mww@cipher.nrlssc.navy.mil>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: gitster@pobox.com, git@vger.kernel.org
To: Brandon Casey <casey@nrlssc.navy.mil>
X-From: git-owner@vger.kernel.org Sat Dec 13 07:32:30 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LBO39-0007pB-Js
	for gcvg-git-2@gmane.org; Sat, 13 Dec 2008 07:32:28 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756107AbYLMGbJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 13 Dec 2008 01:31:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756086AbYLMGbJ
	(ORCPT <rfc822;git-outgoing>); Sat, 13 Dec 2008 01:31:09 -0500
Received: from peff.net ([208.65.91.99]:1526 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756033AbYLMGbI (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 13 Dec 2008 01:31:08 -0500
Received: (qmail 19373 invoked by uid 111); 13 Dec 2008 06:31:06 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.32) with SMTP; Sat, 13 Dec 2008 01:31:06 -0500
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Sat, 13 Dec 2008 01:31:05 -0500
Content-Disposition: inline
In-Reply-To: <UfCPFu_boLV0ycLKLmOno8GTqmtC4RSZZ9O6aRLGYjmSZOdKv6ywhCjApnplTHLxUIzO8KJ5Mww@cipher.nrlssc.navy.mil>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/102991>

On Fri, Dec 12, 2008 at 05:20:07PM -0600, Brandon Casey wrote:

> Make it easier to recover from a mistaken branch deletion by displaying the
> sha1 of the branch's tip commit.

This version looks fine to me, but one nit:

> -     test "$(git branch -d my7 2>&1)" = "Deleted branch my7."'
> +     sha1=$(git rev-parse my7 | cut -c 1-7) &&
> +     test "$(git branch -d my7 2>&1)" = "Deleted branch my7 ($sha1)."'

There is a very very small chance that this sha1 might require more
than 7 characters to be unique (small because we have such a tiny number
of objects in the trash repo). Maybe:

  sha1=$(git log --pretty=format:%h -1 my7)

is better (though I have to admit, if I were writing the test originally
I would have tested the exit value of "git branch" instead of the
message).

-Peff
