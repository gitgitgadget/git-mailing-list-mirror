From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 1/2] Complain in the tests about git config not failing
 with, keys without a section
Date: Mon, 5 Mar 2012 05:37:14 -0500
Message-ID: <20120305103714.GA30463@sigill.intra.peff.net>
References: <4F50A79E.5060206@philosof.dk>
 <7v8vjiethh.fsf@alter.siamese.dyndns.org>
 <4F547261.7000506@philosof.dk>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Rune Philosof <rune@philosof.dk>
X-From: git-owner@vger.kernel.org Mon Mar 05 11:37:26 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S4VIB-0007oJ-Uy
	for gcvg-git-2@plane.gmane.org; Mon, 05 Mar 2012 11:37:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756795Ab2CEKhS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 5 Mar 2012 05:37:18 -0500
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:37620
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756418Ab2CEKhR (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 5 Mar 2012 05:37:17 -0500
Received: (qmail 28287 invoked by uid 107); 5 Mar 2012 10:37:23 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Mon, 05 Mar 2012 05:37:23 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 05 Mar 2012 05:37:14 -0500
Content-Disposition: inline
In-Reply-To: <4F547261.7000506@philosof.dk>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/192223>

On Mon, Mar 05, 2012 at 08:59:29AM +0100, Rune Philosof wrote:

> On 02-03-2012 19:40, Junio C Hamano wrote:
> >>git is supposed to fail when having a key without a section, but does not.
> >I do not think anybody said it is supposed to fail in this case.
> >
> >the behaviour for a single level name is just "undefined", which is very different from "must fail".
> 
> Quoting from `git help config`:
> This command will fail if:
>  3. no section was provided,

The text you are quoting is not about what is in the config file, but
rather the config name given on the command line (which we would be
trying to look up). And we do correctly complain about that:

  $ git config foo
  error: key does not contain a section: foo

But:

> under SYNTAX
>  Each variable must belong to some section, which means that there
> must be a section header before the first
>        setting of a variable.

Yes, everything is supposed to be in a section.  Historically we have
not complained, but instead just treated it as a single-level variable.
For internal git use this never mattered, as git only looked at
variables with section names. For "git config foo", it also does not
matter, since we will notice the lack of section before even doing a
lookup.

For "git config --list", as you noticed, we include it in the output. I
suspect we should simply omit it as cruft. But we could also issue a
warning, and/or die.

-Peff
