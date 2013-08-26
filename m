From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] commit: search author pattern against mailmap
Date: Mon, 26 Aug 2013 17:38:31 -0400
Message-ID: <20130826213831.GA6219@sigill.intra.peff.net>
References: <xmqqob8ml588.fsf@gitster.dls.corp.google.com>
 <1377424889-15399-1-git-send-email-apelisse@gmail.com>
 <20130825103041.GB12556@sigill.intra.peff.net>
 <CALWbr2zfpZYGri9aGL3DGhadnYF=0xx_h95ZjN7S4beoAES68A@mail.gmail.com>
 <20130825165153.GC21092@sigill.intra.peff.net>
 <xmqq1u5hkomf.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Antoine Pelisse <apelisse@gmail.com>, git <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Aug 26 23:38:40 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VE4Uh-0005iq-PZ
	for gcvg-git-2@plane.gmane.org; Mon, 26 Aug 2013 23:38:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752638Ab3HZVif (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 26 Aug 2013 17:38:35 -0400
Received: from cloud.peff.net ([50.56.180.127]:40247 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752597Ab3HZVie (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 26 Aug 2013 17:38:34 -0400
Received: (qmail 995 invoked by uid 102); 26 Aug 2013 21:38:35 -0000
Received: from c-71-63-4-13.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.63.4.13)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Mon, 26 Aug 2013 16:38:35 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 26 Aug 2013 17:38:31 -0400
Content-Disposition: inline
In-Reply-To: <xmqq1u5hkomf.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/233035>

On Sun, Aug 25, 2013 at 10:27:52PM -0700, Junio C Hamano wrote:

> > I'm on the fence. It doesn't actually save that many lines of code, and
> > I guess it's possible that somebody would want a custom mailmap in the
> > future. Even though you can't do it right now, all it would take is
> > exposing read_mailmap_file and read_mailmap_blob outside of mailmap.c.
> > Of course, it would be easy to expose map_user_from at the same time.
> 
> I am of two minds on this, but if I were forced to pick one _today_,
> I would have to say that I am moderately negative to the approach.
> 
> Having to always specify that you want to use mailmap and make sure
> you read it is a bit cumbersome from callers' point of view, and
> using a singleton global may be one attractive way to do so.

It is also slightly wasteful, in that we may parse and store the mailmap
multiple times. But I doubt it's a big deal.

> I think it is a reasonable tentative solution to hook a singleton
> instance to something that is commonly used, e.g. the rev_info
> structure, for large subset of commands that do use the structure
> chosen to host that singleton instance, but those that do not work
> based on revision traversal (e.g. "grep") need to also honor mailmap
> consistently, so we must keep the lower level API that takes an
> explicit mailmap instance for them anyway.

My patch kept the lower-level API (well, it de-publicized it because
nobody was using it, but we do not need to do that part).

But as I said, I am on the fence, and you do not seem enthused, so let's
just drop it.

-Peff
