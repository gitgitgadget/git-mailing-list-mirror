From: Jeff King <peff@peff.net>
Subject: Re: [PATCH v5 1/5] setup: add gentle version of read_gitfile
Date: Tue, 28 Apr 2015 16:48:53 -0400
Message-ID: <20150428204853.GA12153@peff.net>
References: <xmqqfv7nzf56.fsf@gitster.dls.corp.google.com>
 <1430030985-14499-1-git-send-email-erik.elfstrom@gmail.com>
 <1430030985-14499-2-git-send-email-erik.elfstrom@gmail.com>
 <20150428061741.GL24580@peff.net>
 <CAMpP7Nb3aiMoTjtPJNJPv38G54ZawS8B+NDX0x2iNe6FA-L+Lw@mail.gmail.com>
 <20150428201918.GA10902@peff.net>
 <20150428203400.GN5467@google.com>
 <20150428203645.GA11473@peff.net>
 <20150428204213.GO5467@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: erik =?utf-8?B?ZWxmc3Ryw7Zt?= <erik.elfstrom@gmail.com>,
	Git List <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Tue Apr 28 22:49:02 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YnCRB-0003VO-C6
	for gcvg-git-2@plane.gmane.org; Tue, 28 Apr 2015 22:49:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S966058AbbD1Us4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 28 Apr 2015 16:48:56 -0400
Received: from cloud.peff.net ([50.56.180.127]:51356 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S966038AbbD1Usz (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 28 Apr 2015 16:48:55 -0400
Received: (qmail 9966 invoked by uid 102); 28 Apr 2015 20:48:55 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Tue, 28 Apr 2015 15:48:55 -0500
Received: (qmail 20294 invoked by uid 107); 28 Apr 2015 20:49:24 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Tue, 28 Apr 2015 16:49:24 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 28 Apr 2015 16:48:53 -0400
Content-Disposition: inline
In-Reply-To: <20150428204213.GO5467@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/267944>

On Tue, Apr 28, 2015 at 01:42:13PM -0700, Jonathan Nieder wrote:

> Jeff King wrote:
> 
> > But the NULL does not carry the information about _which_ error, and
> > Erik is suggesting that the caller may need to change behavior based on
> > that information. IOW, his current patch (return NULL and set the
> > specific integer code in a variable) allows this, but switching the
> > integer code out for a human-readable strbuf does not.
> 
> Right.  Two ways to handle that are:

Sure, but "this system" that I was referring to one was not one of
those ways. :)

>  - two out parameters: an integer code and a human-readable string, or
> 
>  - an integer code returned using the ERR_PTR method and a
>    human-readable string out parameter
> 
> The point I was trying to make clear is that the human-readable error
> message and the integer to affect control flow have different purposes
> and are not tightly related except in that they are produced at the
> same time.
> 
> Using an integer to convey the human-readable error message (like errno
> does) unnecessarily forces the message to be more vague (by not being
> parameterized, and by always using the same error message for the same
> integer error).

Yes, I agree converting the integer back into a string later does not
always carry all of the data. OTOH, the caller can often supply the
context (i.e., this is basically how "errno" works). This gets back to
the idea we discussed a while ago of having a "struct error" that can
carry the code and the parameters (or if you like, the code and a
finished error message). It just feels in some ways like that ends up
with the worst of both worlds (a lot of boilerplate for integer codes,
_and_ the allocation and cleanup issues associated with a string error
message).

I dunno. I'd be interested to see a rough draft of an idea applied to a
specific callsite.

-Peff
