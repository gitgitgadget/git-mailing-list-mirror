From: Jeff King <peff@peff.net>
Subject: Re: "git notes show" is orders of magnitude slower than doing it
 manually with ls-tree and cat-file
Date: Tue, 25 Nov 2014 20:00:51 -0500
Message-ID: <20141126010051.GA29830@peff.net>
References: <20141126004242.GA13915@glandium.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Johan Herland <johan@herland.net>, git@vger.kernel.org
To: Mike Hommey <mh@glandium.org>
X-From: git-owner@vger.kernel.org Wed Nov 26 02:00:57 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XtQyW-0003an-Vu
	for gcvg-git-2@plane.gmane.org; Wed, 26 Nov 2014 02:00:57 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751510AbaKZBAx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 25 Nov 2014 20:00:53 -0500
Received: from cloud.peff.net ([50.56.180.127]:45043 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751002AbaKZBAw (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 25 Nov 2014 20:00:52 -0500
Received: (qmail 16968 invoked by uid 102); 26 Nov 2014 01:00:52 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Tue, 25 Nov 2014 19:00:52 -0600
Received: (qmail 3157 invoked by uid 107); 26 Nov 2014 01:00:51 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Tue, 25 Nov 2014 20:00:51 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 25 Nov 2014 20:00:51 -0500
Content-Disposition: inline
In-Reply-To: <20141126004242.GA13915@glandium.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/260258>

On Wed, Nov 26, 2014 at 09:42:42AM +0900, Mike Hommey wrote:

> I have a note tree with a bit more than 200k notes.
>
> $ time git notes --ref foo show $sha1 > /dev/null
> real    0m0.147s
> user    0m0.136s
> sys     0m0.008s
> 
> That's a lot of time, especially when you have a script that does that
> on a fair amount of sha1s.

IIRC, the notes code populates an in-memory data structure, which gives
faster per-commit lookup at the cost of some setup time. Obviously for a
single lookup, that's going to be a bad tradeoff (but it does make sense
for "git log --notes"). I don't know offhand how difficult it would be
to tune the data structure differently (or avoid it altogether) if we
know ahead of time we are only going to do a small number of lookups.
But Johan (cc'd) might.

-Peff
