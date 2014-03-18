From: Jeff King <peff@peff.net>
Subject: Re: [RFC/PATCH] diff: simplify cpp funcname regex
Date: Tue, 18 Mar 2014 01:24:56 -0400
Message-ID: <20140318052456.GA17454@sigill.intra.peff.net>
References: <20140305003639.GA9474@sigill.intra.peff.net>
 <5316D922.9010501@viscovery.net>
 <20140306212835.GA11743@sigill.intra.peff.net>
 <531973D9.9070803@viscovery.net>
 <20140314035457.GA31906@sigill.intra.peff.net>
 <5322A82E.9060808@viscovery.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org, Thomas Rast <tr@thomasrast.ch>
To: Johannes Sixt <j.sixt@viscovery.net>
X-From: git-owner@vger.kernel.org Tue Mar 18 06:25:06 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WPmWO-0008ES-0T
	for gcvg-git-2@plane.gmane.org; Tue, 18 Mar 2014 06:25:04 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751887AbaCRFY7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 18 Mar 2014 01:24:59 -0400
Received: from cloud.peff.net ([50.56.180.127]:41651 "HELO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751083AbaCRFY6 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 18 Mar 2014 01:24:58 -0400
Received: (qmail 23282 invoked by uid 102); 18 Mar 2014 05:24:58 -0000
Received: from c-71-63-4-13.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.63.4.13)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Tue, 18 Mar 2014 00:24:58 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 18 Mar 2014 01:24:56 -0400
Content-Disposition: inline
In-Reply-To: <5322A82E.9060808@viscovery.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/244333>

On Fri, Mar 14, 2014 at 07:56:46AM +0100, Johannes Sixt wrote:

> Consider this code:
> 
>   void above()
>   {}
>   static int Y;
>   static int A;
>   int bar()
>   {
>     return X;
>   }
>   void below()
>   {}

Thanks, this example is very helpful.

> When you 'git grep --function-context X', then you get this output with
> the current pattern, you proposal, and my proposal (file name etc omitted
> for brevity):
> 
>   int bar()
>   {
>     return X;
>   }

Right, that makes sense to me.

> When you 'git grep --function-context Y', what do you want to see? With
> the current pattern, and with your pattern that forbids semicolon we get:
> 
>   void above()
>   {}
>   static int Y;
>   static int A;
> 
> and with my simple pattern, which allows semicolon, we get merely
> 
>   static int Y;
> 
> because the line itself is a hunk header (and we do not look back any
> further) and the next line is as well. That is not exactly "function
> context", and that is what I'm a bit worried about.

Hmm. To be honest, I do not see yours as all that bad. Is "above()" or
"A" actually interesting here? I'm not sure that they are. But then I do
not use --function-context myself.

I guess it violates the "show things that are vaguely nearby, rather
than a container" view of context that we discussed earlier. But somehow
that seems less important to me with "--function-context".

So I dunno. I kind of like your version.

-Peff
