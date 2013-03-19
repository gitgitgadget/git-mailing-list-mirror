From: Jeff King <peff@peff.net>
Subject: Re: Make GIT_USE_LOOKUP default?
Date: Tue, 19 Mar 2013 11:55:44 -0400
Message-ID: <20130319155544.GB10010@sigill.intra.peff.net>
References: <CACsJy8AihriCDfN=cz7FjdHzZAhnPPGML_w8yWcVVrmTQLZyjw@mail.gmail.com>
 <7vd2uxrdh7.fsf@alter.siamese.dyndns.org>
 <20130318073229.GA5551@sigill.intra.peff.net>
 <CACsJy8BxbJU9-7Q-Ef3cG2VV2cW8YbBGcjNT9wjT+JywDOxyNg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>, Ingo Molnar <mingo@elte.hu>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
To: Duy Nguyen <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Tue Mar 19 16:56:18 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UHytc-0001tz-K7
	for gcvg-git-2@plane.gmane.org; Tue, 19 Mar 2013 16:56:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932875Ab3CSPzu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 19 Mar 2013 11:55:50 -0400
Received: from 75-15-5-89.uvs.iplsin.sbcglobal.net ([75.15.5.89]:58529 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756730Ab3CSPzu (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 19 Mar 2013 11:55:50 -0400
Received: (qmail 31044 invoked by uid 107); 19 Mar 2013 15:57:33 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Tue, 19 Mar 2013 11:57:33 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 19 Mar 2013 11:55:44 -0400
Content-Disposition: inline
In-Reply-To: <CACsJy8BxbJU9-7Q-Ef3cG2VV2cW8YbBGcjNT9wjT+JywDOxyNg@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/218531>

On Tue, Mar 19, 2013 at 10:43:40PM +0700, Nguyen Thai Ngoc Duy wrote:

> > I could not replicate his benchmarks at all. In fact, my measurements
> > showed a slight slowdown with 1a812f3 (hashcmp(): inline memcmp() by
> > hand to optimize, 2011-04-28).
> [...]
> 
> What gcc and glibc versions are you using? With gcc 4.5.3 I got "repz
> cmpsb" after reverting the patch, just like what Ingo described
> (although interestingly it ran a bit faster than current master, glibc
> 2.11.2 on Atom D510 32 bit). gcc 4.6.3 -O2 (on another machine, 64
> bit) produced a call to libc's memcmp instead of "repz cmpsb". I guess
> if "repz cmpsb" is what we are against, then we could pass
> -fno-builtin-memcmp (potential impact to other parts of git though).

I have glibc 2.13. And looking at the changelog, there were a ton of
ssse-optimized memcmp implementations that went into 2.13 [1], so I suspect
that is what is going on.

-Peff

PS As a side note, you may recall a year or two ago when these went in,
because the initial versions walked backwards, meaning memcpys of
overlapping regions started to fail (as they are allowed to, but many
programs do not properly use memmove).
