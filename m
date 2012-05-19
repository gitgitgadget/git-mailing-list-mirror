From: Jeff King <peff@peff.net>
Subject: Re: git-completion with bash alias
Date: Fri, 18 May 2012 20:41:47 -0400
Message-ID: <20120519004147.GE765@sigill.intra.peff.net>
References: <CACY+Hvqd6L7gWgDBvjPmLPsfA2o1CVKuqkDZ_j7XYf=WjuwvKQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Felipe Contreras <felipe.contreras@gmail.com>, git@vger.kernel.org
To: Carsten Mattner <carstenmattner@googlemail.com>
X-From: git-owner@vger.kernel.org Sat May 19 02:41:57 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SVXk4-0004Og-Lo
	for gcvg-git-2@plane.gmane.org; Sat, 19 May 2012 02:41:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965128Ab2ESAlw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 18 May 2012 20:41:52 -0400
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:48900
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S964782Ab2ESAlv (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 18 May 2012 20:41:51 -0400
Received: (qmail 10078 invoked by uid 107); 19 May 2012 00:42:14 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Fri, 18 May 2012 20:42:14 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 18 May 2012 20:41:47 -0400
Content-Disposition: inline
In-Reply-To: <CACY+Hvqd6L7gWgDBvjPmLPsfA2o1CVKuqkDZ_j7XYf=WjuwvKQ@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/198000>

On Fri, May 18, 2012 at 01:35:24PM +0200, Carsten Mattner wrote:

> Completion works when used as "git checkout foo" but fails with
> "bash: [: 1: unary operator expected" when trying to complete
> via a single character shell alias like "alias g=git" as in
> "g checkout foo".
> 
> git version 1.7.10.2.548.g9de9681

Hmm. Are you invoking the completion like:

  complete -F _git g

? That used to work, but was broken by the recent 6b179ad (completion:
add new __git_complete helper, 2012-05-14).

The "new" way seems to be:

  __git_complete g _git

but that function is explicitly labeled as "not public". It looks like
there was a follow-on patch that was discussed to make a public version,
but it got dropped.

I'm not sure if this regression is intentional, or if the "old" way even
worked reliably (I seem to recall people running into issues with
_get_comp_words_by_ref not being called properly sometimes, but I don't
remember the details). So it's not clear to me if the right way forward
is fixing "complete -F _git" to work again, or if that way is just
broken, and a public version of __git_complete is the right path.

Felipe, can you comment?

-Peff
