From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] send-email: handle multiple Cc addresses when reading
	mbox message
Date: Fri, 13 Feb 2009 19:31:14 -0500
Message-ID: <20090214003113.GB7769@coredump.intra.peff.net>
References: <1234566313-36478-1-git-send-email-jaysoffian@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org, Ryan Anderson <ryan@michonline.com>,
	gitster@pobox.com
To: Jay Soffian <jaysoffian@gmail.com>
X-From: git-owner@vger.kernel.org Sat Feb 14 01:32:47 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LY8Sb-0003nb-4k
	for gcvg-git-2@gmane.org; Sat, 14 Feb 2009 01:32:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753402AbZBNAbQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 13 Feb 2009 19:31:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753368AbZBNAbQ
	(ORCPT <rfc822;git-outgoing>); Fri, 13 Feb 2009 19:31:16 -0500
Received: from peff.net ([208.65.91.99]:57445 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751648AbZBNAbQ (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 13 Feb 2009 19:31:16 -0500
Received: (qmail 27089 invoked by uid 107); 14 Feb 2009 00:31:34 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Fri, 13 Feb 2009 19:31:34 -0500
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Fri, 13 Feb 2009 19:31:14 -0500
Content-Disposition: inline
In-Reply-To: <1234566313-36478-1-git-send-email-jaysoffian@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/109791>

On Fri, Feb 13, 2009 at 06:05:13PM -0500, Jay Soffian wrote:

> This patch teaches it to unfold header lines by pre-processing the
> header before extracting any of its fields. It also teaches it to split
> the Cc line using Mail::Address if available, otherwise it just splits
> on a simple \s*,\s* regular expression.

Ugh. This is not in any way a comment on your patch, but it is really
painful to see time and again send-email bugs like this that could be
solved by using the wealth of existing perl modules.

I think send-email is stuck somewhere between "here is the bare minimum
to send some patches, and we don't want to require any fancy
dependencies" and "a full-fledged replacement for my MUA when dealing
with patches".

The approach of "use this module if we have it, otherwise do something
quick and dirty" might be the best approach. But I do wonder if the
"quick and dirty" code path will end up buggy due to lack of use, and/or
be surprising for people who expect send-email to be more thorough.

The other alternatives are to keep fixing bugs and improving
incrementally until it converges on being an actual MUA, or to simply
start a rewrite based on reasonable CPAN modules.

I don't know what the right solution is. I am certainly not volunteering
to rewrite; I am very happy just using my actual MUA to send patches. :)

-Peff
