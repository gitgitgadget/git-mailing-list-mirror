From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] git-parse-remote: fix ambiguous shell bug in expand_refs_wildcard
Date: Mon, 7 May 2007 02:36:22 -0400
Message-ID: <20070507063621.GB31445@coredump.intra.peff.net>
References: <20061218080941.GA3857@coredump.intra.peff.net> <7v4prtx9hu.fsf@assigned-by-dhcp.cox.net> <20061218224505.GB13034@coredump.intra.peff.net> <20061219003557.GA17799@gondor.apana.org.au> <20070505080313.GA12170@gondor.apana.org.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
To: Herbert Xu <herbert@gondor.apana.org.au>
X-From: git-owner@vger.kernel.org Mon May 07 08:36:50 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Hkwq1-0002Fa-Ov
	for gcvg-git@gmane.org; Mon, 07 May 2007 08:36:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754046AbXEGGgZ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 7 May 2007 02:36:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754048AbXEGGgZ
	(ORCPT <rfc822;git-outgoing>); Mon, 7 May 2007 02:36:25 -0400
Received: from 66-23-211-5.clients.speedfactory.net ([66.23.211.5]:2769 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754046AbXEGGgY (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 7 May 2007 02:36:24 -0400
Received: (qmail 1097 invoked from network); 7 May 2007 06:36:16 -0000
Received: from coredump.intra.peff.net (10.0.0.2)
  by peff.net with (DHE-RSA-AES128-SHA encrypted) SMTP; 7 May 2007 06:36:16 -0000
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Mon, 07 May 2007 02:36:22 -0400
Content-Disposition: inline
In-Reply-To: <20070505080313.GA12170@gondor.apana.org.au>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/46418>

On Sat, May 05, 2007 at 06:03:13PM +1000, Herbert Xu wrote:

> In fact the rationale (C.2.2.3) in the POSIX document explicitly
> disallows the aformentioned usage as it violates the rule that an
> even number of single quotes if any can occur in an ${...} expression
> enclosed by double quotes.

Yes, there's not much room for interpretation; the old git code was
clearly bogus (we are working around it by using sed instead). Thanks
for tracking this down, Herbert.

It looks like bash is actually broken in POSIXLY_CORRECT mode, then:

$ echo $BASH_VERSION
3.1.17(1)-release
$ POSIXLY_CORRECT=1
$ foo=bar}
$ echo "${foo%'}'}"
bar

My interpretation of the correct behavior is that it should remove a
single quote from the end of foo, and then print '} literally (that is,
single quote and brace).

-Peff
