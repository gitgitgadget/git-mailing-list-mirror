From: Jeff King <peff@peff.net>
Subject: Re: [RFC PATCH] stash: accept options also when subcommand 'save'
 is omitted
Date: Tue, 18 Aug 2009 13:45:09 -0400
Message-ID: <20090818174509.GA27518@coredump.intra.peff.net>
References: <1250599567-31428-1-git-send-email-Matthieu.Moy@imag.fr>
 <vpqws51l1hb.fsf@bauges.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org,
	Johannes Schindelin <johannes.schindelin@gmx.de>
To: Matthieu Moy <Matthieu.Moy@imag.fr>
X-From: git-owner@vger.kernel.org Tue Aug 18 19:45:26 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MdSkJ-0006cN-RN
	for gcvg-git-2@lo.gmane.org; Tue, 18 Aug 2009 19:45:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759325AbZHRRpJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 18 Aug 2009 13:45:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759020AbZHRRpJ
	(ORCPT <rfc822;git-outgoing>); Tue, 18 Aug 2009 13:45:09 -0400
Received: from peff.net ([208.65.91.99]:56913 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751393AbZHRRpI (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 18 Aug 2009 13:45:08 -0400
Received: (qmail 12106 invoked by uid 107); 18 Aug 2009 17:45:14 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Tue, 18 Aug 2009 13:45:14 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Tue, 18 Aug 2009 13:45:09 -0400
Content-Disposition: inline
In-Reply-To: <vpqws51l1hb.fsf@bauges.imag.fr>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/126428>

On Tue, Aug 18, 2009 at 03:01:52PM +0200, Matthieu Moy wrote:

> Hmm, googling a bit, I just noticed that there's already something in
> pu:
> ea41cfc4f (Make 'git stash -k' a short form for 'git stash save --keep-index')
> which also does the trick, while adding a -k alias for --keep-index.
>
> [...]
> 
> Mine has at least two advantages:
> 
> * It won't require changing the code again when new options are added
>   to 'git stash save'.
> 
> * It works with 'git stash -k -q' for example, while the other
>   proposal checks that $# == 1, which won't work if there are more
>   than one option.

I think yours is nicer, especially as we have just added the
'-p|--patch' option, as well. With what is there now, you can do "git
stash -p", but not "git stash -p -k".

> But I may have missed its drawbacks ;-)

The only I can think of is that bogus input will provoke 'save'. So
something like:

  git stash --apply

will invoke "git stash save --apply", which doesn't even complain. It
just tries to make a stash with message --apply. Now of course this
input is obviously bogus, but probably the right thing to do is
complain.

OTOH, I think it is the fault of "git stash save --apply" for not doing
the complaining, so your patch really isn't making it worse. Probably it
should barf on anything unrecognized starting with a '-', and allow '--'
to separate the message from the rest of the options (in the rare case
that you want a message starting with '-').

-Peff
