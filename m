From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 00/14] numparse module: systematically tighten up integer
 parsing
Date: Wed, 18 Mar 2015 06:03:38 -0400
Message-ID: <20150318100338.GA26998@peff.net>
References: <1426608016-2978-1-git-send-email-mhagger@alum.mit.edu>
 <CACsJy8AiHHKBD4vV5aJec9CGzBqfSCNU6-j=LjDhsp2VrC55+A@mail.gmail.com>
 <550949BC.1020500@alum.mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Duy Nguyen <pclouds@gmail.com>, Junio C Hamano <gitster@pobox.com>,
	Git Mailing List <git@vger.kernel.org>
To: Michael Haggerty <mhagger@alum.mit.edu>
X-From: git-owner@vger.kernel.org Wed Mar 18 11:03:53 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YYApL-00064z-GT
	for gcvg-git-2@plane.gmane.org; Wed, 18 Mar 2015 11:03:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932849AbbCRKDp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 18 Mar 2015 06:03:45 -0400
Received: from cloud.peff.net ([50.56.180.127]:34542 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1755609AbbCRKDl (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 18 Mar 2015 06:03:41 -0400
Received: (qmail 32001 invoked by uid 102); 18 Mar 2015 10:03:41 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Wed, 18 Mar 2015 05:03:41 -0500
Received: (qmail 1811 invoked by uid 107); 18 Mar 2015 10:03:52 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Wed, 18 Mar 2015 06:03:52 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 18 Mar 2015 06:03:38 -0400
Content-Disposition: inline
In-Reply-To: <550949BC.1020500@alum.mit.edu>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/265712>

On Wed, Mar 18, 2015 at 10:47:40AM +0100, Michael Haggerty wrote:

> But in case you have some reason that you want upload-pack.c to be
> converted right away, I just pushed that change (plus some related
> cleanups) to my GitHub repo [1]. The branch depends only on the first
> patch of the "numparse" patch series.
> 
> By the way, some other packet line parsing code in that file doesn't
> verify that there are no trailing characters on the lines that they
> process. That might be another thing that should be tightened up.

Do you mean that upload-pack gets a pkt-line of length N that contains a
line of length M, and then doesn't check that M==N?  We use the space
between M and N for passing capabilities and other metadata around.

Or do you mean that we see lines like:

  want [0-9a-f]{40} ...\n

and do not bother looking at the "..." that comes after the data we
expect? That I can believe, and I don't think it would hurt to tighten
up (we shouldn't need it for extensibility, as anybody trying to stick
extra data there should do so only after using a capability flag earlier
in the protocol).

-Peff
