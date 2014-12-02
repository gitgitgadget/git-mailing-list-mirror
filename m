From: Jeff King <peff@peff.net>
Subject: Re: http-protocol question
Date: Tue, 2 Dec 2014 00:52:29 -0500
Message-ID: <20141202055228.GA2708@peff.net>
References: <CAGyf7-HmvvHQZkyLgKAs2rrZTTLFkBa8s828hbS9LedLNb2fWA@mail.gmail.com>
 <20141202033416.GY6527@google.com>
 <CAGyf7-GZbRBN4O_yNgrmJCya=6f8XQ4O8m7WBa1k8Ve196ajYQ@mail.gmail.com>
 <20141202044522.GZ6527@google.com>
 <CAGyf7-Gx1VU-1OicCHG0sStUnNXy_0Y8VYUP+PZjpN6nz7dTrw@mail.gmail.com>
 <20141202053331.GA31516@peff.net>
 <CAGyf7-FDRS_zGQSFKhV8UGfN5GjGcyo0yCz8bcjEALYF3oj=Bg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Jonathan Nieder <jrnieder@gmail.com>,
	Git Users <git@vger.kernel.org>
To: Bryan Turner <bturner@atlassian.com>
X-From: git-owner@vger.kernel.org Tue Dec 02 06:52:36 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XvgO3-0005ba-Q1
	for gcvg-git-2@plane.gmane.org; Tue, 02 Dec 2014 06:52:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754478AbaLBFw3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 2 Dec 2014 00:52:29 -0500
Received: from cloud.peff.net ([50.56.180.127]:46979 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1754475AbaLBFw2 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 2 Dec 2014 00:52:28 -0500
Received: (qmail 20538 invoked by uid 102); 2 Dec 2014 05:52:28 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Mon, 01 Dec 2014 23:52:28 -0600
Received: (qmail 13200 invoked by uid 107); 2 Dec 2014 05:52:29 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Tue, 02 Dec 2014 00:52:29 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 02 Dec 2014 00:52:29 -0500
Content-Disposition: inline
In-Reply-To: <CAGyf7-FDRS_zGQSFKhV8UGfN5GjGcyo0yCz8bcjEALYF3oj=Bg@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/260540>

On Tue, Dec 02, 2014 at 04:47:50PM +1100, Bryan Turner wrote:

> > There is a practical reason to care. Ref deletion will also delete the
> > reflog, leaving no trace of the reachability. Whereas a non-fast-forward
> > push could be resolved by looking in the reflog.
> 
> A fair point. I had mistakenly thought that reflogs would survive the
> ref's deletion and be "pruned" as part of garbage collection, but a
> quick test shows that, as I'm sure you already know, that's not true.

I wish it worked that way. Unfortunately there are complications with
keeping the old reflogs in place, because they sometimes cause conflicts
with new refs being created (e.g., a reflog in ".git/logs/refs/heads/foo"
would prevent ".git/logs/refs/heads/foo/bar" from being created). I had
some patches long ago to try to keep a "reflog graveyard" around, but
they were quite invasive, and there were some corner cases that caused
weird errors.

Handling this sort of D/F conflict more gracefully is one of the things
I'd like to experiment with once we have pluggable ref backends (I think
we'll also disallow "foo/bar" if "foo" exists, but the storage could at
least keep the reflogs around).

-Peff
