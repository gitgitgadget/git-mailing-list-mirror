From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] http: Add Accept-Language header if possible
Date: Wed, 9 Jul 2014 02:18:53 -0400
Message-ID: <20140709061853.GA6731@sigill.intra.peff.net>
References: <1404834846-11812-1-git-send-email-eungjun.yi@navercorp.com>
 <20140709051040.GB2318@sigill.intra.peff.net>
 <CAFT+Tg8HZTsbWK2WHHg_q04LY5Vm7cjfNkfHGBEdbKjf1==rKw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: "Yi, EungJun" <semtlenori@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jul 09 08:19:00 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1X4lDX-0005kB-Id
	for gcvg-git-2@plane.gmane.org; Wed, 09 Jul 2014 08:18:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751709AbaGIGSz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 9 Jul 2014 02:18:55 -0400
Received: from cloud.peff.net ([50.56.180.127]:58518 "HELO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751054AbaGIGSz (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 9 Jul 2014 02:18:55 -0400
Received: (qmail 26267 invoked by uid 102); 9 Jul 2014 06:18:55 -0000
Received: from c-71-63-4-13.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.63.4.13)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Wed, 09 Jul 2014 01:18:55 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 09 Jul 2014 02:18:53 -0400
Content-Disposition: inline
In-Reply-To: <CAFT+Tg8HZTsbWK2WHHg_q04LY5Vm7cjfNkfHGBEdbKjf1==rKw@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/253069>

On Wed, Jul 09, 2014 at 02:46:35PM +0900, Yi, EungJun wrote:

> I agree with you. In fact, I tried to get user's preferred language in
> the same way as gettext. It has guess_category_value() to do that and
> the function is good enough because it considers $LANGUAGE, $LC_ALL,
> $LANG, and also system-dependent preferences. But the function does
> not seem a public API and I don't know how can I use the function in
> Git. So I chose to use $LANGUAGE only.

I did some digging, and I think the public API is setlocale with a NULL
parameter, like:

  printf("%s\n", setlocale(LC_MESSAGES, NULL));

That still will end up like "en_US.UTF-8", though; I couldn't find any
standard functions for parsing that. It seems like it would be pretty
straightforward to do so, though.

>From my brief reading of rfc2616, that should probably become "en-us",
and any time we add "x-y", we may want to add "x" as a fallback (that is
certainly true for English; I don't know about other languages with
dialects).

-Peff
