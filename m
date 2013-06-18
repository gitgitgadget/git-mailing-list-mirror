From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] git-add--interactive.perl: Permit word-based diff
Date: Tue, 18 Jun 2013 13:23:22 -0400
Message-ID: <20130618172300.GA3557@sigill.intra.peff.net>
References: <CAMNuMARruu+1=kny=g5O1MoxCXuoT3BHdSEEPSqvyn2t2JsAYg@mail.gmail.com>
 <20130618063144.GA6276@sigill.intra.peff.net>
 <87k3lrzxw7.fsf@hexa.v.cablecom.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Mark Abraham <mark.j.abraham@gmail.com>, git@vger.kernel.org,
	Junio C Hamano <gitster@pobox.com>
To: Thomas Rast <trast@inf.ethz.ch>
X-From: git-owner@vger.kernel.org Tue Jun 18 19:23:36 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Uozd1-0000Ya-Q4
	for gcvg-git-2@plane.gmane.org; Tue, 18 Jun 2013 19:23:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933274Ab3FRRXb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 18 Jun 2013 13:23:31 -0400
Received: from cloud.peff.net ([50.56.180.127]:39031 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932631Ab3FRRXb (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 18 Jun 2013 13:23:31 -0400
Received: (qmail 22738 invoked by uid 102); 18 Jun 2013 17:24:28 -0000
Received: from mobile-032-141-227-127.mycingular.net (HELO sigill.intra.peff.net) (32.141.227.127)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Tue, 18 Jun 2013 12:24:28 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 18 Jun 2013 13:23:22 -0400
Content-Disposition: inline
In-Reply-To: <87k3lrzxw7.fsf@hexa.v.cablecom.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/228285>

On Tue, Jun 18, 2013 at 09:22:16AM +0200, Thomas Rast wrote:

> [I don't seem to have received a copy of the original mail, so I can
> only guess...]

Yes, the original doesn't seem to have made it to the list. Sorry, I
don't have a copy (I am in the habit of deleting direct mails that are
cc'd to the list, as I keep a separate list archive).

Mark, did you happen to send an HTML mail? The list will silently
reject such mail.

> > Note that the number of lines in your --word-diff=color hunk and the
> > actual diff will not necessarily be the same.  What happens if I split a
> > hunk with your patch?
> 
> If it's actually what you hint at, there's another problem: the word
> diff might not even have the same number of hunks.  For example, a
> long-standing bug (or feature, depending on POV) of word-diff is that it
> does not take opportunities to completely drop hunks that did not make
> any word-level changes.

Yeah, I didn't even think of that.

In general, I think one can assume 1-to-1 correspondence between whole
regular diffs and whole word-diffs, but not below that (i.e., neither a
correspondence between hunks nor between lines).

With something like contrib/diff-highlight, you get some decoration, and
can assume a 1-to-1 line correspondence.

However, I think that when reviewing text (especially re-wrapped
paragraphs) that word-diff can be much easier to read, _because_ it
throws away the line correspondence. To be correct, though, I think we
would have to simply show the whole word-diff for a file and say "is
this OK?". Which sort of defeats the purpose of "add -p" as a hunk
selector (you could just as easily run "git diff --color-words foo" and
"git add foo"). But it does save keystrokes if your workflow is to
simply "add -p" everything to double-check it before adding.

So I dunno. I could see myself using it, but I certainly wouldn't want a
config variable that turns it on all the time (which is what the
original patch did).

-Peff
