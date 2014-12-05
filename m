From: Jeff King <peff@peff.net>
Subject: Re: [PATCH/RFC] doc: document error handling functions and
 conventions (Re: [PATCH 03/14] copy_fd: pass error message back through a
 strbuf)
Date: Thu, 4 Dec 2014 19:01:28 -0500
Message-ID: <20141205000128.GA30048@peff.net>
References: <20141118004841.GE4336@google.com>
 <CAGZ79kbF6JjxgHX2KZFhSh9QyGOXeS=cVK0z=CM4n9-ErRDJ8A@mail.gmail.com>
 <20141203050217.GJ6527@google.com>
 <20141203051344.GM6527@google.com>
 <xmqqzjb4h823.fsf@gitster.dls.corp.google.com>
 <20141204030133.GA16345@google.com>
 <xmqqy4qnq9m2.fsf@gitster.dls.corp.google.com>
 <20141204234147.GF16345@google.com>
 <20141204234432.GA29953@peff.net>
 <CAPc5daW3+8xjG3z3WgOMfqzWJUiPdcN1-FVgVc0fAjH7tgCa4A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Jonathan Nieder <jrnieder@gmail.com>,
	Stefan Beller <sbeller@google.com>,
	Git Mailing List <git@vger.kernel.org>,
	Michael Haggerty <mhagger@alum.mit.edu>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Dec 05 01:01:35 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XwgL0-0006tE-QK
	for gcvg-git-2@plane.gmane.org; Fri, 05 Dec 2014 01:01:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933419AbaLEABb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 4 Dec 2014 19:01:31 -0500
Received: from cloud.peff.net ([50.56.180.127]:48670 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S933324AbaLEABa (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 4 Dec 2014 19:01:30 -0500
Received: (qmail 27915 invoked by uid 102); 5 Dec 2014 00:01:30 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Thu, 04 Dec 2014 18:01:30 -0600
Received: (qmail 10896 invoked by uid 107); 5 Dec 2014 00:01:33 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Thu, 04 Dec 2014 19:01:33 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 04 Dec 2014 19:01:28 -0500
Content-Disposition: inline
In-Reply-To: <CAPc5daW3+8xjG3z3WgOMfqzWJUiPdcN1-FVgVc0fAjH7tgCa4A@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/260847>

On Thu, Dec 04, 2014 at 03:52:45PM -0800, Junio C Hamano wrote:

> Yeah, that is what I meant. The earlier part will not go to waste no matter
> what happens to the discussion.
> 
> I am not a fan of char[1024], if only because our error message may have
> to mention things whose length is not under our control, e.g. a filename
> in the working tree, but I do share your concern that "strbuf"-approach
> calls for more boilerplate. I offhand do not have a magic silver bullet for
> it, though.

The only downside I can think of is that we may truncate the message in
exceptional circumstances. But is it really any less helpful to say:

  error: unable to open file: some-incredibly-long-filename-aaaaaa...

than printing out an extra 100 lines of "a"? And I mean the "..."
literally. I think mkerror() should indicate the truncation with a
"...", just so that it is clear to the user. It should almost never
happen, but when it does, it can be helpful to show the user that yes,
we know we are truncating the message, and it is not that git truncated
your filename during the operation.

Is this truncation really a concern, and/or is there some other downside
I'm not thinking of?

-Peff
