From: Jeff King <peff@peff.net>
Subject: Re: [RFC] Case insensitive URL rewrite
Date: Fri, 11 Dec 2015 14:15:13 -0500
Message-ID: <20151211191512.GA5361@sigill.intra.peff.net>
References: <B207EFC1-48DF-4B8F-8373-28A0CB5660B0@gmail.com>
 <xmqq7fkkg7tq.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Lars Schneider <larsxschneider@gmail.com>,
	Git Users <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Dec 11 20:15:25 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1a7TA3-0004mb-At
	for gcvg-git-2@plane.gmane.org; Fri, 11 Dec 2015 20:15:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752763AbbLKTPT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 11 Dec 2015 14:15:19 -0500
Received: from cloud.peff.net ([50.56.180.127]:40394 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751562AbbLKTPQ (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 11 Dec 2015 14:15:16 -0500
Received: (qmail 21737 invoked by uid 102); 11 Dec 2015 19:15:15 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Fri, 11 Dec 2015 13:15:15 -0600
Received: (qmail 956 invoked by uid 107); 11 Dec 2015 19:15:21 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Fri, 11 Dec 2015 14:15:21 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 11 Dec 2015 14:15:13 -0500
Content-Disposition: inline
In-Reply-To: <xmqq7fkkg7tq.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/282270>

On Fri, Dec 11, 2015 at 10:26:41AM -0800, Junio C Hamano wrote:

> Lars Schneider <larsxschneider@gmail.com> writes:
> 
> > What do you think about a flag that makes these rewrites case insensitive? E.g. with the following config flag:
> >
> > [url "<actual url base>"]
> > 	insteadOf = <other url base>
> > 	ignorecase = true
> 
> I am with Daniel on this.
> 
> It is perfectly fine to consider these two equivalent.
> 
>     git clone https://github.com/git/git (canonical one)
>     git clone https://GitHub.com/git/git (host part in funny case)
> 
> In fact, I think we should do this without any additional
> configuration variable.
> 
> On the other hand, these two MUST be treated as different by
> default:
> 
>     git clone https://github.com/GIT/GIT (differences outside host part)
>     git clone git@github.com:GIT/GIT     (differences outside host part)

I haven't looked, but the code in urlmatch.c probably gets all of this
right already. It was written much later than the insteadOf code, as it
was part of the http.$url.* matching, and it may be reasonable to simply
teach the insteadOf code to use it. OTOH, it may need tweaked because
I'm not sure how it would handle non-URLs like the "host:path" ssh form.

-Peff
