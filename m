From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 3/7] strbuf: introduce strbuf_read_cmd helper
Date: Sun, 22 Mar 2015 19:34:49 -0400
Message-ID: <20150322233448.GA21518@peff.net>
References: <20150322095924.GA24651@peff.net>
 <20150322100724.GC11615@peff.net>
 <CAPig+cR5Ur4xOKZ6K=bOwOVM8bHHjJJXHxzCbvYBhqOTtD6dXg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Wincent Colaiuta <win@wincent.com>, Git List <git@vger.kernel.org>
To: Eric Sunshine <sunshine@sunshineco.com>
X-From: git-owner@vger.kernel.org Mon Mar 23 00:35:00 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YZpOS-0000cJ-SO
	for gcvg-git-2@plane.gmane.org; Mon, 23 Mar 2015 00:34:57 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752090AbbCVXew (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 22 Mar 2015 19:34:52 -0400
Received: from cloud.peff.net ([50.56.180.127]:36936 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751962AbbCVXew (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 22 Mar 2015 19:34:52 -0400
Received: (qmail 2673 invoked by uid 102); 22 Mar 2015 23:34:52 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Sun, 22 Mar 2015 18:34:52 -0500
Received: (qmail 10999 invoked by uid 107); 22 Mar 2015 23:35:05 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Sun, 22 Mar 2015 19:35:05 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sun, 22 Mar 2015 19:34:49 -0400
Content-Disposition: inline
In-Reply-To: <CAPig+cR5Ur4xOKZ6K=bOwOVM8bHHjJJXHxzCbvYBhqOTtD6dXg@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/266107>

On Sun, Mar 22, 2015 at 03:36:01PM -0400, Eric Sunshine wrote:

> > This is really at the intersection of the strbuf and
> > run-command APIs, so you could argue for it being part of
> > either It is logically quite like the strbuf_read_file()
> > function, so I put it there.
> 
> It does feel like a layering violation. If moved to the run-command
> API, it could given one of the following names or something better:

A layering violation implies there is an ordering to the APIs. Certainly
we call APIs from other APIs all the time. I guess you could argue that
these are the "same" layer, and should be next to each, and not building
on each other (i.e., that strbuf has dependencies only on system APIs
like stdio.h, and run-command only on system APIs like unistd.h, etc).

But then reversing the order of the dependency does not really solve
that. You would have to introduce a new higher-level API that combines
them. But that seems silly for a single function (and I do not foresee
any other similar functions).

That being said, I'm not opposed to one of the reverse names if people
feel strongly (I also considered making it an option flag to
run_command_v_opt, but it ended up tangling things quite a bit more).

-Peff
