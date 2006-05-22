From: Jeff King <peff@peff.net>
Subject: Re: avoid atoi, when possible; int overflow -> heap corruption
Date: Mon, 22 May 2006 09:37:46 -0400
Message-ID: <20060522133746.GA12302@coredump.intra.peff.net>
References: <87mzdcjqey.fsf@rho.meyering.net> <7v3bf3jl15.fsf@assigned-by-dhcp.cox.net> <871wumim28.fsf_-_@rho.meyering.net> <118833cc0605220616t75a182b1oa404d5efe8a1f5d9@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon May 22 15:38:01 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FiAbX-00060H-K0
	for gcvg-git@gmane.org; Mon, 22 May 2006 15:37:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750812AbWEVNht (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 22 May 2006 09:37:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750828AbWEVNht
	(ORCPT <rfc822;git-outgoing>); Mon, 22 May 2006 09:37:49 -0400
Received: from 66-23-211-5.clients.speedfactory.net ([66.23.211.5]:11985 "EHLO
	peff.net") by vger.kernel.org with ESMTP id S1750812AbWEVNhs (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 22 May 2006 09:37:48 -0400
Received: (qmail 71973 invoked from network); 22 May 2006 13:37:46 -0000
Received: from unknown (HELO coredump.intra.peff.net) (10.0.0.2)
  by 0 with SMTP; 22 May 2006 13:37:46 -0000
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Mon, 22 May 2006 09:37:46 -0400
To: Morten Welinder <mwelinder@gmail.com>
Mail-Followup-To: Morten Welinder <mwelinder@gmail.com>,
	git@vger.kernel.org
Content-Disposition: inline
In-Reply-To: <118833cc0605220616t75a182b1oa404d5efe8a1f5d9@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/20505>

On Mon, May 22, 2006 at 09:16:50AM -0400, Morten Welinder wrote:

> atoi has undefined behaviour for "99-and-any-suffix".  You might
> get lucky and get back 99, but you might also get a random value
> or a core dump.

Where do you get that from? The standard claims that it converts "the
initial portion of the string pointed to" (7.20.1.2). Furthermore, atoi
is equivalent to strtol with a base of 10 (with the exception of range
errors). From 7.20.1.4, paragraph 2:
  The strtol [...] functions [...] decompose the input string into three
  parts: an initial, possibly empty, sequence of white-space characters
  [...], a subject sequence resembling an integer represented in some
  radix determined by the value of base, and a final string of one or
  more unrecognized characters...
If no conversion can be performed (i.e., you feed it garbage with no
number), zero is returned.

atoi does NOT handle range errors, however; the behavior is undefined in
that case. In practice, I expect most implementations do some sort of
wrapping.

-Peff
