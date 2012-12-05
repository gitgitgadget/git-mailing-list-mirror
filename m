From: Jeff King <peff@peff.net>
Subject: Re: [RFC] Add basic syntax check on shell scripts
Date: Wed, 5 Dec 2012 02:54:02 -0500
Message-ID: <20121205075401.GB5776@sigill.intra.peff.net>
References: <201212021417.25525.tboegi@web.de>
 <7vzk1vrs63.fsf@alter.siamese.dyndns.org>
 <CACsJy8BxviWRHqGvptsJVmkFM6HQa9HnLWsh5V6Ec6Fqv52sGA@mail.gmail.com>
 <7vobi9mwt4.fsf@alter.siamese.dyndns.org>
 <CACsJy8BtX9fMkGDoVGKzgz7SSinbt0561B1ZKHu6fs+n8ewKGg@mail.gmail.com>
 <20121205073055.GA5776@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>,
	Torsten =?utf-8?Q?B=C3=B6gershausen?= <tboegi@web.de>,
	git@vger.kernel.org
To: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Wed Dec 05 08:54:26 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Tg9oE-000341-0P
	for gcvg-git-2@plane.gmane.org; Wed, 05 Dec 2012 08:54:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752534Ab2LEHyG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 5 Dec 2012 02:54:06 -0500
Received: from 75-15-5-89.uvs.iplsin.sbcglobal.net ([75.15.5.89]:59112 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752455Ab2LEHyE (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 5 Dec 2012 02:54:04 -0500
Received: (qmail 16815 invoked by uid 107); 5 Dec 2012 07:55:03 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Wed, 05 Dec 2012 02:55:03 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 05 Dec 2012 02:54:02 -0500
Content-Disposition: inline
In-Reply-To: <20121205073055.GA5776@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/211113>

On Wed, Dec 05, 2012 at 02:30:56AM -0500, Jeff King wrote:

> Anyway, I do think a "shell portability lint" would be a great addition
> to "test-lint", but I am slightly skeptical that it will be easy to
> write a good one that does not have false positives. Still, there may be
> some low-hanging fruit. I have not looked carefully at Torsten's patch
> yet.

Hrm. I had the impression initially that Torsten's patch was about
testing the test scripts themselves. But it is really about testing the
installed shell scripts. In that sense, test-lint is not the right
place.

You would want a "check shell script portability" script, and you would
probably want to run it:

  - on the regular built scripts; possibly during build time (I have done
    this before with "perl -c" for perl scripts and it is reasonably
    successful). Or in a test script, as added in his patch (though I
    note it does not seem to pass as posted, getting confused by trying
    to grep "git-gui").

  - on the test scripts themselves via test-lint

I think as long as such a script erred on the side of false negatives,
it would be OK (because false positives are a giant headache, and
ultimately the real test is people exercising the code itself on their
shells; this is just an early check to help contributors who do not have
such shells).

-Peff

PS Debian developers use a checkbashisms script to find some portability
   problems. It might be worth looking at, though I notice it generates
   a lot of bogus "unterminated string" results for our t/t*.sh scripts.
