From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] t9100: fix breakage when SHELL_PATH is not /bin/sh
Date: Mon, 8 Feb 2016 08:50:13 -0500
Message-ID: <20160208135013.GA27054@sigill.intra.peff.net>
References: <982f6f499c988e1063275e2951c9856d622a83f3.1454872161.git.git@drmicha.warpmail.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org,
	Johannes Schindelin <johannes.schindelin@gmx.de>,
	Junio C Hamano <gitster@pobox.com>
To: Michael J Gruber <git@drmicha.warpmail.net>
X-From: git-owner@vger.kernel.org Mon Feb 08 14:50:25 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aSmCt-0005tl-L7
	for gcvg-git-2@plane.gmane.org; Mon, 08 Feb 2016 14:50:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751762AbcBHNuR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 8 Feb 2016 08:50:17 -0500
Received: from cloud.peff.net ([50.56.180.127]:39166 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751258AbcBHNuQ (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 8 Feb 2016 08:50:16 -0500
Received: (qmail 29719 invoked by uid 102); 8 Feb 2016 13:50:15 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Mon, 08 Feb 2016 08:50:15 -0500
Received: (qmail 4956 invoked by uid 107); 8 Feb 2016 13:50:17 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Mon, 08 Feb 2016 08:50:17 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 08 Feb 2016 08:50:13 -0500
Content-Disposition: inline
In-Reply-To: <982f6f499c988e1063275e2951c9856d622a83f3.1454872161.git.git@drmicha.warpmail.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/285764>

On Sun, Feb 07, 2016 at 08:11:37PM +0100, Michael J Gruber wrote:

> bcb11f1 (mingw: mark t9100's test cases with appropriate prereqs, 2016-01-27)
> replaced "/bin/sh" in exec.sh by the shell specified in SHELL_PATH, but
> that breaks the subtest which checks for a specific checksum of a tree
> containing.
> 
> Revert that change that was not explained in the commit message anyways
> (exec.sh is never executed).

I think this just re-breaks things on Windows. That first setup test
used "chmod +x" (which is brought back by your patch), without having
the POSIXPERM prerequisite.

We probably do not want to mark the whole setup test as POSIXPERM, as
that would effectively break all of the other tests on Windows. The rest
of the tests need to be able to work whether or not the "chmod +x" was
run. It may be simpler to just break the executable-bit tests, including
setup, out to their own section of the script.

That being said, t9100 seems to pass for me, even at bcb11f1. Can you
show us the breakage you are seeing?

-Peff
