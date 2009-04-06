From: Jeff King <peff@peff.net>
Subject: Re: [question] how can i verify whether a local branch is tracking
	a remote branch?
Date: Mon, 6 Apr 2009 01:49:20 -0400
Message-ID: <20090406054920.GA19214@coredump.intra.peff.net>
References: <4d8e3fd30904050332w394cccbaq5b82d2a53ed357a3@mail.gmail.com> <20090405144413.GC2076@sigill.intra.peff.net> <4d8e3fd30904051425w6739a12fp5666e71e8b2d7958@mail.gmail.com> <20090406043426.GC12341@coredump.intra.peff.net> <7vy6uecpwd.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Paolo Ciarrocchi <paolo.ciarrocchi@gmail.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Apr 06 07:51:17 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Lqhjm-0008CE-0Q
	for gcvg-git-2@gmane.org; Mon, 06 Apr 2009 07:51:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752141AbZDFFtk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 6 Apr 2009 01:49:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752001AbZDFFtk
	(ORCPT <rfc822;git-outgoing>); Mon, 6 Apr 2009 01:49:40 -0400
Received: from peff.net ([208.65.91.99]:49417 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751962AbZDFFtk (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 6 Apr 2009 01:49:40 -0400
Received: (qmail 21282 invoked by uid 107); 6 Apr 2009 05:49:58 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Mon, 06 Apr 2009 01:49:58 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Mon, 06 Apr 2009 01:49:20 -0400
Content-Disposition: inline
In-Reply-To: <7vy6uecpwd.fsf@gitster.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/115767>

On Sun, Apr 05, 2009 at 10:28:02PM -0700, Junio C Hamano wrote:

> > I don't think it would be unreasonable to expose this functionality via
> > "for-each-ref". Something like this (which would need cleanup,
> > documentation, and perhaps a :short variant):
> 
> I think that is a sane approach, but isn't "tracking" a misnomer?  I think
> what you are describing is what is called "the upstream branch" by the
> description of Documentation/config.txt::branch.<name>.merge, and not what
> people call "tracking branch" (see Documentation/glossary-content.txt).

I think this is the classic "both of these concepts are called
tracking and it is confusing" that people complain about from time to
time. This is the value created by "--track", and most of the internal
functions call it that (e.g., stat_tracking_info, fill_tracking_info,
etc).

But I am happy to call it something else if it will reduce confusion.
"upstream" is a fine name, I think (though that is often referring to
the upstream _repository_, so maybe somebody might expect it to print
"origin" here).

> I also wonder if you want to say "this remote" and "that branch"
> separately.  As far as I can tell you are not giving the former but only
> the latter information?

Well, I don't think they are two separate parts. "that branch" has
already used information about the remote to reach its answer, and is
self-contained. It's all you need to know to do any non-fetching
operations (like seeing how your commits compare with upstream's, for
example).

Which isn't to say "this remote" might not be interesting. But I think
that is somewhat independent of this value, and moreover, it is already
trivial to find via "branch.*.remote" (or are there lookup rules I am
forgetting about?). The point of this exercise was that it is very
tricky to do the "upstream" correctly, so exposing the C code makes
sense.

-Peff
