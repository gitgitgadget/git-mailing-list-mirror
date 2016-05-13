From: Jeff King <peff@peff.net>
Subject: Re: t3404 static check of bad SHA-1 failure
Date: Fri, 13 May 2016 16:02:33 -0400
Message-ID: <20160513200232.GA10371@sigill.intra.peff.net>
References: <CALR6jEiH6oxq=KXfz1pqOue9VKnkp=S8zNqC4OFmbuhRFFxoMw@mail.gmail.com>
 <20160513182325.GB30700@sigill.intra.peff.net>
 <xmqqwpmx91mb.fsf@gitster.mtv.corp.google.com>
 <20160513195911.GE9890@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Armin Kunaschik <megabreit@googlemail.com>,
	Git List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri May 13 22:02:43 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b1JIG-0000La-No
	for gcvg-git-2@plane.gmane.org; Fri, 13 May 2016 22:02:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753490AbcEMUCg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 13 May 2016 16:02:36 -0400
Received: from cloud.peff.net ([50.56.180.127]:39330 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1753479AbcEMUCf (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 13 May 2016 16:02:35 -0400
Received: (qmail 14604 invoked by uid 102); 13 May 2016 20:02:35 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Fri, 13 May 2016 16:02:35 -0400
Received: (qmail 21251 invoked by uid 107); 13 May 2016 20:02:35 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Fri, 13 May 2016 16:02:35 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 13 May 2016 16:02:33 -0400
Content-Disposition: inline
In-Reply-To: <20160513195911.GE9890@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/294569>

On Fri, May 13, 2016 at 03:59:11PM -0400, Jeff King wrote:

> On Fri, May 13, 2016 at 12:52:44PM -0700, Junio C Hamano wrote:
> 
> > I _think_ "test -z" should succeed according to POSIX, because
> > 
> >  (1) it is not "test -z string" because it lacks string,
> > 
> >  (2) it is not any of the other "test -<option> thing" because -z,
> >     and
> > 
> >  (3) the only thing it matches in the supported form of "test" is
> >      "test <string>" that tests if the <string> is not the null
> >      string, and "-z" indeed is not the null string.
> > 
> > For the same reason, "test -n" succeeds.
> 
> Yeah, I think you're right; POSIX is pretty clear that this falls under
> case 3. So that means "test -z" quietly does what we want. But it means
> that "test -n" does the _opposite_ of what we want.
> 
> And sadly,
> 
>   git grep 'test -n [^"]'
> 
> is not empty.
> 
> > But working around older/broken shells is easy and the resulting
> > script it more readable, so let's take this.  It makes the resulting
> > code easier to understand even when we know we run it under POSIX
> > shell.
> 
> Yep. The POSIX-explanation of what is going on might be worth putting in
> the commit message for the "-z" case (i.e., it should work, but the
> "why" is subtle).

I think we can just lump all of these into a single patch, but there are
a few related cleanups, including the SVN stuff I just sent. So let me
send out a unified patch series in a moment.

-Peff
