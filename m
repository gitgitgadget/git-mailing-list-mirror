From: Jeff King <peff@peff.net>
Subject: Re: git-grep: option parsing conflicts with prefix-dash searches
Date: Sat, 6 Feb 2010 06:58:17 -0500
Message-ID: <20100206115817.GA11605@sigill.intra.peff.net>
References: <alpine.LSU.2.01.1002052351060.30204@obet.zrqbmnf.qr>
 <7vsk9fs1j9.fsf@alter.siamese.dyndns.org>
 <20100206035143.GA31784@sigill.intra.peff.net>
 <7v7hqrdkxb.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Jan Engelhardt <jengelh@medozas.de>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Feb 06 13:00:37 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NdjKz-0000Nr-GU
	for gcvg-git-2@lo.gmane.org; Sat, 06 Feb 2010 13:00:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755488Ab0BFL6U (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 6 Feb 2010 06:58:20 -0500
Received: from peff.net ([208.65.91.99]:42898 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752900Ab0BFL6U (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 6 Feb 2010 06:58:20 -0500
Received: (qmail 5546 invoked by uid 107); 6 Feb 2010 11:58:25 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.40) with ESMTPA; Sat, 06 Feb 2010 06:58:25 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sat, 06 Feb 2010 06:58:17 -0500
Content-Disposition: inline
In-Reply-To: <7v7hqrdkxb.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/139159>

On Fri, Feb 05, 2010 at 08:53:36PM -0800, Junio C Hamano wrote:

> >   git grep -- pattern revision -- pathname
> [...]
> I don't think if "ambiguous or not" is what we are after to begin with.
> 
> I have known GNU extended grep implementations long enough but never saw
> that "--" used to quote a pattern.  Is it worth supporting to begin with?

I think so. It was the first thing the original poster in this thread
tried. It is also something I have tried (and still do, then grumblingly
retype "-e pattern"). And it certainly makes sense from a user
perspective; it is the same end-of-options signal that most other
programs take.

So I think it is a convenient interface improvement, nothing more. If it
were somehow onerous to support, I would say that no, it is not worth
it. But it really is only a few lines of code, and I do not think the
behavior change is hurting any real-world cases (which is what I was
trying to show earlier).

I suspect you are not familiar with it because you are enough of an
old-timer to have worked with the many non-GNU greps that require "-e"
to specify a funny pattern and so got used to that habit.

> I would say "git grep -- pattern" is sufficiently insane enough that
> I'm not worried about it at all.  Interpreting "git grep --" as a request
> to look for double-dash feels million times saner than that, actually.

I don't think "grep --" is sane at all, since it is broken under GNU
grep. And because "--" is a special token in option parsing, I would
expect it to need "git grep -e --".

> Unless somebody comes up with example of that pattern's wide use.  Point
> me to some well known open source software's source trees that use "--"
> for such a purpose in one of its shell script or Makefile.

OK. Try:

  http://www.google.com/codesearch?hl=en&sa=N&q=grep.*%5Cs--%5Cs++lang:shell&ct=rr&cs_r=lang:shell

Some are false positives, but it looks like libtool's generated
configure scripts use it (which is in literally hundreds of projects),
openssh's fixpaths script, ffmpeg's configure script, even a use in a
plan9 script.

And that's just the first page of results. So I think I am not the only
one.

-Peff
