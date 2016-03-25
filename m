From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] tag.c: move PGP verification code from plumbing
Date: Fri, 25 Mar 2016 01:31:34 -0400
Message-ID: <20160325053134.GA27614@sigill.intra.peff.net>
References: <1458866017-15490-1-git-send-email-santiago@nyu.edu>
 <CAPig+cQe5bwHXq4_qegBCM8Kqoqiz7K2ZtVk0FGMSEUPWQHyYA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: santiago@nyu.edu, Git List <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>
To: Eric Sunshine <sunshine@sunshineco.com>
X-From: git-owner@vger.kernel.org Fri Mar 25 06:31:45 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ajKLW-0005Cq-UN
	for gcvg-git-2@plane.gmane.org; Fri, 25 Mar 2016 06:31:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751468AbcCYFbi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 25 Mar 2016 01:31:38 -0400
Received: from cloud.peff.net ([50.56.180.127]:38003 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751087AbcCYFbh (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 25 Mar 2016 01:31:37 -0400
Received: (qmail 22963 invoked by uid 102); 25 Mar 2016 05:31:37 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Fri, 25 Mar 2016 01:31:37 -0400
Received: (qmail 20605 invoked by uid 107); 25 Mar 2016 05:31:57 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Fri, 25 Mar 2016 01:31:57 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 25 Mar 2016 01:31:34 -0400
Content-Disposition: inline
In-Reply-To: <CAPig+cQe5bwHXq4_qegBCM8Kqoqiz7K2ZtVk0FGMSEUPWQHyYA@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/289848>

On Fri, Mar 25, 2016 at 01:23:57AM -0400, Eric Sunshine wrote:

> On Thu, Mar 24, 2016 at 8:33 PM,  <santiago@nyu.edu> wrote:
> > The verify tag function is just a thin wrapper around the verify-tag
> > command. We can avoid one fork call by doing the verification inside
> > the tag builtin instead.
> 
> Hopefully, the below review comments are meaningful, however, aside
> from having just read Peff's review of the previous version of this
> patch, I haven't been following this discussion, so it's possible some
> comments may be off the mark. Caveat emptor.

Thanks for reviewing.  I agree with all of the comments you made, but
I'd add a little more to the last one:

> > +
> > +       /* sometimes the program was terminated because this signal
> > +        * was received in the process of writing the gpg input.
> > +        * We ignore it for this call and restore it afterwards */
> 
> I realize that the bulk of this comment block was merely relocated
> from builtin/verify-tag.c, however, now would be a good time to fix
> its style violation and format it like this:
> 
>     /*
>      * This is a multi-line
>      * comment.
>      */
> 
> Also, the last line of the comment, which you added when relocating
> it, merely repeats what the code itself already says clearly, thus is
> not particularly useful and should be dropped.

I actually think we can drop this comment entirely. Pushing and popping
SIGPIPE when piping to a sub-program like this is not that exotic in our
code base. And if the SIGPIPE handling here is done in its own patch,
then if somebody wants to see more discussion or reasoning, they can go
to its commit message (which can then go into more detail about why we
might see SIGPIPE, and not just a vague "sometimes...").

-Peff
