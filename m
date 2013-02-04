From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] git-send-email: add ~/.authinfo parsing
Date: Mon, 4 Feb 2013 16:22:03 -0500
Message-ID: <20130204212203.GC13186@sigill.intra.peff.net>
References: <2f93ce7b6b5d3f6c6d1b99958330601a5560d4ba.1359486391.git.mina86@mina86.com>
 <7vvcafojf4.fsf@alter.siamese.dyndns.org>
 <20130130074306.GA17868@sigill.intra.peff.net>
 <xa1tmwvk9gy1.fsf@mina86.com>
 <878v74vwst.fsf@lifelogs.com>
 <20130204201040.GA13272@sigill.intra.peff.net>
 <87a9rju8l7.fsf@lifelogs.com>
 <20130204205911.GA13186@sigill.intra.peff.net>
 <8738xbu6qj.fsf@lifelogs.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Michal Nazarewicz <mina86@mina86.com>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Krzysztof Mazur <krzysiek@podlesie.net>
To: Ted Zlatanov <tzz@lifelogs.com>
X-From: git-owner@vger.kernel.org Mon Feb 04 22:22:33 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U2TUl-00077X-87
	for gcvg-git-2@plane.gmane.org; Mon, 04 Feb 2013 22:22:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755105Ab3BDVWI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 4 Feb 2013 16:22:08 -0500
Received: from 75-15-5-89.uvs.iplsin.sbcglobal.net ([75.15.5.89]:60666 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754019Ab3BDVWH (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 4 Feb 2013 16:22:07 -0500
Received: (qmail 22518 invoked by uid 107); 4 Feb 2013 21:23:32 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Mon, 04 Feb 2013 16:23:32 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 04 Feb 2013 16:22:03 -0500
Content-Disposition: inline
In-Reply-To: <8738xbu6qj.fsf@lifelogs.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/215422>

On Mon, Feb 04, 2013 at 04:08:52PM -0500, Ted Zlatanov wrote:

> >> That would create the following possibilities:
> >> 
> >> * host example.com:31337, protocol https
> >> * host example.com:31337, protocol unspecified
> >> * host example.com, protocol https
> >> * host example.com, protocol unspecified
> 
> JK> Possibilities for .netrc, or for git? Git will always specify the
> JK> protocol.
> 
> Possibilities for the netrc data.  How clever do we want to be with
> taking 31337 and mapping it to the "protocol"?  My preference is to be
> very simple here.

I think simple is OK, as we can iterate on it as specific use-cases come
up. The important thing is to make sure we err on the side of "does not
match" and not "oops, we accidentally sent your plaintext credentials to
the wrong server".

> Currently, we map both the "port" and "protocol" netrc tokens to the
> credential helper protocol's "protocol".  So this will have undefined
> results.  To do what you specify could be pretty simple: we could do a
> preliminary scan of the tokens, looking for "host X port Y" where Y is
> an integer, and rewriting the host to be "X:Y".  That would be clean and
> simple, unless the user breaks it with "host x:23 port 22".  Let me know
> if you agree and I'll do.

Yeah, I think that is simple and obvious. If the user is saying "host
x:23 port 22", that is nonsensical.

-Peff
