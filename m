From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 1/4] Introduce commit notes
Date: Sat, 20 Dec 2008 03:05:47 -0500
Message-ID: <20081220080546.GA4580@coredump.intra.peff.net>
References: <5d46db230812160015t55b4ff2fubbf1e2f826a97b98@mail.gmail.com> <alpine.DEB.1.00.0812200034450.30769@pacific.mpi-cbg.de> <20081220065337.GA2581@coredump.intra.peff.net> <200812200855.14915.robin.rosenberg.lists@dewire.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Govind Salinas <govind@sophiasuchtig.com>,
	Git Mailing List <git@vger.kernel.org>
To: Robin Rosenberg <robin.rosenberg.lists@dewire.com>
X-From: git-owner@vger.kernel.org Sat Dec 20 09:07:20 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LDwrn-00081y-NA
	for gcvg-git-2@gmane.org; Sat, 20 Dec 2008 09:07:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752429AbYLTIFu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 20 Dec 2008 03:05:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752428AbYLTIFu
	(ORCPT <rfc822;git-outgoing>); Sat, 20 Dec 2008 03:05:50 -0500
Received: from peff.net ([208.65.91.99]:2213 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752390AbYLTIFt (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 20 Dec 2008 03:05:49 -0500
Received: (qmail 22607 invoked by uid 111); 20 Dec 2008 08:05:48 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.32) with SMTP; Sat, 20 Dec 2008 03:05:48 -0500
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Sat, 20 Dec 2008 03:05:47 -0500
Content-Disposition: inline
In-Reply-To: <200812200855.14915.robin.rosenberg.lists@dewire.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/103630>

On Sat, Dec 20, 2008 at 08:55:14AM +0100, Robin Rosenberg wrote:

> > Hmm. I wanted to try some performance comparisons based on this
> > implementation, but I can't get your 1/4 to apply. Conflicts in
> > config.txt and cache.h when applying to master, and "sha1 information is
> > lacking or useless" for a 3-way merge. What did you base this on?
> 
> patch(1) however can crunch it, with the exception of cache.h. Shouldn't
> git am/appy and patch agree on git generated patches (without binary diffs)?

No. git apply is intentionally much more strict about applying under the
assumption that it is better to force a conflict than to silently apply
something that has a reasonable chance of being completely wrong.

And usually it is not a big deal because falling back to the 3-way merge
is a much nicer way of handling any conflicts _anyway_ (I find .rej
files so much more useless than conflict markers, personally).

In this case I was able to:

  1. git am /the/patch
  2. patch -p1 <.git/rebase-apply/patch
  3. manually inspect the results for sanity, and fix up the cache.h
     bit that failed totally
  4. git add -u && git add notes.[ch]
  5. git am --resolved

-Peff
