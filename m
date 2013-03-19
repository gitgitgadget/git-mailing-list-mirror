From: Jeff King <peff@peff.net>
Subject: Re: regression in multi-threaded git-pack-index
Date: Tue, 19 Mar 2013 06:47:59 -0400
Message-ID: <20130319104759.GB9490@sigill.intra.peff.net>
References: <20130315224240.50AA340839@wince.sfo.corp.google.com>
 <20130316114118.GA1940@sigill.intra.peff.net>
 <87fvzrajmr.fsf@pctrast.inf.ethz.ch>
 <20130319093034.GA29997@sigill.intra.peff.net>
 <20130319095943.GA6031@sigill.intra.peff.net>
 <20130319100800.GA6341@sigill.intra.peff.net>
 <20130319102422.GB6341@sigill.intra.peff.net>
 <87obef8yy7.fsf@pctrast.inf.ethz.ch>
 <20130319103306.GA9490@sigill.intra.peff.net>
 <871ubb8y6z.fsf@pctrast.inf.ethz.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Stefan Zager <szager@google.com>, git@vger.kernel.org,
	=?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
To: Thomas Rast <trast@inf.ethz.ch>
X-From: git-owner@vger.kernel.org Tue Mar 19 11:48:34 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UHu5o-0004no-Vv
	for gcvg-git-2@plane.gmane.org; Tue, 19 Mar 2013 11:48:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750910Ab3CSKsF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 19 Mar 2013 06:48:05 -0400
Received: from 75-15-5-89.uvs.iplsin.sbcglobal.net ([75.15.5.89]:58193 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750784Ab3CSKsE (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 19 Mar 2013 06:48:04 -0400
Received: (qmail 27718 invoked by uid 107); 19 Mar 2013 10:49:47 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Tue, 19 Mar 2013 06:49:47 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 19 Mar 2013 06:47:59 -0400
Content-Disposition: inline
In-Reply-To: <871ubb8y6z.fsf@pctrast.inf.ethz.ch>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/218501>

On Tue, Mar 19, 2013 at 11:45:56AM +0100, Thomas Rast wrote:

> Now consider
> 
>   // somewhere on the stack
>   struct foo {
>     char c;
>     int i;
>   } a, b;
>   a.c = a.i = 0;
> 
>   memcpy(&b, &a, sizeof(struct foo));
> 
> The compiler could legitimately leave the padding between c and i
> uninitialized, and with your proposed "early" reporting the memcpy would
> complain.

Ah, good point. And valgrind does not have any way of knowing what is
padding and what is not, since it sees only the compiled contents.
Probably llvm's memory checker support could do a better job there.

-Peff
