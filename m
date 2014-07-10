From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] http: Add Accept-Language header if possible
Date: Thu, 10 Jul 2014 16:10:34 -0400
Message-ID: <20140710201034.GB15615@sigill.intra.peff.net>
References: <1404834846-11812-1-git-send-email-eungjun.yi@navercorp.com>
 <20140709051040.GB2318@sigill.intra.peff.net>
 <CAFT+Tg8HZTsbWK2WHHg_q04LY5Vm7cjfNkfHGBEdbKjf1==rKw@mail.gmail.com>
 <20140709061853.GA6731@sigill.intra.peff.net>
 <alpine.DEB.2.00.1407091142030.22132@ds9.cixit.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: "Yi, EungJun" <semtlenori@gmail.com>, git@vger.kernel.org
To: Peter Krefting <peter@softwolves.pp.se>
X-From: git-owner@vger.kernel.org Thu Jul 10 22:10:41 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1X5Kfw-0003No-SL
	for gcvg-git-2@plane.gmane.org; Thu, 10 Jul 2014 22:10:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751988AbaGJUKh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 10 Jul 2014 16:10:37 -0400
Received: from cloud.peff.net ([50.56.180.127]:59563 "HELO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751114AbaGJUKg (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 10 Jul 2014 16:10:36 -0400
Received: (qmail 11053 invoked by uid 102); 10 Jul 2014 20:10:36 -0000
Received: from c-71-63-4-13.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.63.4.13)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Thu, 10 Jul 2014 15:10:36 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 10 Jul 2014 16:10:34 -0400
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.00.1407091142030.22132@ds9.cixit.se>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/253206>

On Wed, Jul 09, 2014 at 11:46:14AM +0100, Peter Krefting wrote:

> Jeff King:
> 
> >I did some digging, and I think the public API is setlocale with a NULL
> >parameter, like:
> >
> > printf("%s\n", setlocale(LC_MESSAGES, NULL));
> >
> >That still will end up like "en_US.UTF-8", though;
> 
> And it only yields the highest-priority language, I think.

I wasn't clear on whether POSIX locale variables actually supported
multiple languages with priorities. I have never seen that, though the
original commit message indicated that LANGUAGE=x:y was a thing (I
wasn't sure if that was a made-up thing, or something that libc actually
supported).

> Debian's website has a nice writeup on the subject:
> http://www.debian.org/intro/cn#howtoset

That seems to be about language settings in browsers, which are a much
richer set of preferences than POSIX locales (I think).

It would not be wrong to have that level of configuration for git's http
requests, but I do not know if it is worth the effort. Mapping the
user's gettext locale into an accept-language header seems like a
straightforward way to communicate to the other side what the client is
using to show errors (so that errors coming from the server can match).

If that is the case, though, I wonder if we should actually be adding it
as a git-protocol header so that all transports can benefit (i.e., we
could be localizing human-readable error messages in upload-pack,
receive-pack, etc).

-Peff
