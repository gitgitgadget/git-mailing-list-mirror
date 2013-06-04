From: Jeff King <peff@peff.net>
Subject: Re: Can `git blame` show the date that each line was merged?
Date: Tue, 4 Jun 2013 13:44:20 -0400
Message-ID: <20130604174420.GA25318@sigill.intra.peff.net>
References: <CAJELnLEiK1C9PeimSwDoJoy=wFbFF0+KoK3jhXSAV4b2DsBKqw@mail.gmail.com>
 <20130604155605.GA15953@sigill.intra.peff.net>
 <7vfvwx9461.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Matt McClure <matthewlmcclure@gmail.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Jun 04 19:44:29 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UjvHY-0003Bd-TS
	for gcvg-git-2@plane.gmane.org; Tue, 04 Jun 2013 19:44:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752706Ab3FDRoZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 4 Jun 2013 13:44:25 -0400
Received: from cloud.peff.net ([50.56.180.127]:42823 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751415Ab3FDRoY (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 4 Jun 2013 13:44:24 -0400
Received: (qmail 30624 invoked by uid 102); 4 Jun 2013 17:45:09 -0000
Received: from c-71-62-74-146.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.62.74.146)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Tue, 04 Jun 2013 12:45:09 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 04 Jun 2013 13:44:20 -0400
Content-Disposition: inline
In-Reply-To: <7vfvwx9461.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/226386>

On Tue, Jun 04, 2013 at 10:28:06AM -0700, Junio C Hamano wrote:

> > (though I suspect it would interact oddly with the "--reverse" option,
> > and we would want to either declare them mutually exclusive or figure
> > out some sane semantics).
> 
> It is entirely unclear who the first child is, so I tend to think
> that they have to be mutually exclusive.

That's my thinking, too, but I didn't want to rule out somebody thinking
of something clever.

> > Your problem is not the presence of "--merges" here, but that you forgot
> > the necessary "file" argument. Try "git blame --merges foo.c".
> >
> > However, this suffers from the same problem as --first-parent, in that
> > it is accepted but not respected. Doing so would not be impossible, but
> > it is a little more than the two-liner above.
> 
> What the command does when it "respects" it is unclear to me.
> In a history like this:
> 
> ---A---B---C
>     \       \
>      E---F---G---H
> 
> and starting at H, pretend everything that happened in, B, C, E and
> F since A was done by G?  Who gets the blame for what A or H did?

In general, I would expect "git blame" with revision arguments to behave
as if it was fed the history graph (including parent rewriting). So in
this case, I would think it would blame everything before G on G
(assuming there are no merges before A), and everything in H would be
"not yet committed".

That being said, we do not seem to rewrite parents for min/max parent
cases even in "git log". I'm not sure why, nor can I seem to provoke it
with simplification options. So maybe I am missing something clever.

-Peff
