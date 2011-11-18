From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 8/8] Enable GIT_DEBUG_MEMCHECK on git_pathname()
Date: Thu, 17 Nov 2011 20:27:15 -0500
Message-ID: <20111118012715.GA7826@sigill.intra.peff.net>
References: <1321522335-24193-1-git-send-email-pclouds@gmail.com>
 <1321522335-24193-9-git-send-email-pclouds@gmail.com>
 <CALkWK0ndE1Q_jNSV7CBB5W2NyVhcy7kgNO5woWWOw6CXx3cxcA@mail.gmail.com>
 <20111117134201.GA30718@sigill.intra.peff.net>
 <CACsJy8A25SyLVKv8GwkYaHBJwU5tHqgdJK6L-upF9HWseFzCtQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Ramkumar Ramachandra <artagnon@gmail.com>, git@vger.kernel.org,
	Junio C Hamano <gitster@pobox.com>,
	Michael Haggerty <mhagger@alum.mit.edu>,
	Jonathan Nieder <jrnieder@gmail.com>
To: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Fri Nov 18 02:27:29 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RRDEm-00025M-HD
	for gcvg-git-2@lo.gmane.org; Fri, 18 Nov 2011 02:27:28 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755605Ab1KRB1U (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 17 Nov 2011 20:27:20 -0500
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:44486
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755474Ab1KRB1R (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 17 Nov 2011 20:27:17 -0500
Received: (qmail 26856 invoked by uid 107); 18 Nov 2011 01:27:23 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Thu, 17 Nov 2011 20:27:23 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 17 Nov 2011 20:27:15 -0500
Content-Disposition: inline
In-Reply-To: <CACsJy8A25SyLVKv8GwkYaHBJwU5tHqgdJK6L-upF9HWseFzCtQ@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/185617>

On Fri, Nov 18, 2011 at 08:12:27AM +0700, Nguyen Thai Ngoc Duy wrote:

> > Older compilers will probably barf on the variable-argument macros.
> 
> Anyway to detect if __VA_ARGS__ is supported at compile time? I guess
> #ifdef __GNUC__ is the last resort.

You can check "#if __STDC_VERSION__ >= 19901L", but that will of course
only tell you whether you have C99; older gcc (and possibly other
compilers) supported __VA_ARGS__ even before it was standardized.

But more annoying is that there isn't a great fallback to __VA_ARGS__.
If you can't use it, then every callsite has to have the same number of
arguments. So it's not like you can localize the fallback code to just
the definition.

Unless you really need macro-like behavior, you're probably better off
using a variadic function and making it a static inline on platforms
which can do so.

> notes-merge.c introduces __VA_ARGS__ since v1.7.4 so we may want to do
> something there too.

I hadn't noticed. That definitely violates our usual rules about
portability.  That usage can easily be turned into an inline function.
However, since nobody has complained in the past year, it makes me
wonder if we are overly conservative (my guess is that people on crazy
old compilers just don't keep up with git. Which maybe means they aren't
worth worrying about. But who knows).

-Peff
