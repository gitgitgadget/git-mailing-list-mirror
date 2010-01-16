From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] grep --no-index: allow use of "git grep" outside a git
 repository
Date: Fri, 15 Jan 2010 20:15:12 -0500
Message-ID: <20100116011512.GA27082@coredump.intra.peff.net>
References: <201001131713.05505.agruen@suse.de>
 <7vfx69k0bu.fsf@alter.siamese.dyndns.org>
 <20100115223259.6117@nanako3.lavabit.com>
 <7vska71br0.fsf@alter.siamese.dyndns.org>
 <7vzl4fum3r.fsf_-_@alter.siamese.dyndns.org>
 <20100115210854.GA21540@coredump.intra.peff.net>
 <7vwrzin9jt.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org, Nanako Shiraishi <nanako3@lavabit.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Jan 16 02:15:27 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NVxGA-0002b8-BB
	for gcvg-git-2@lo.gmane.org; Sat, 16 Jan 2010 02:15:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758566Ab0APBPT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 15 Jan 2010 20:15:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758439Ab0APBPT
	(ORCPT <rfc822;git-outgoing>); Fri, 15 Jan 2010 20:15:19 -0500
Received: from peff.net ([208.65.91.99]:37287 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758259Ab0APBPS (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 15 Jan 2010 20:15:18 -0500
Received: (qmail 1711 invoked by uid 107); 16 Jan 2010 01:20:08 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Fri, 15 Jan 2010 20:20:08 -0500
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Fri, 15 Jan 2010 20:15:12 -0500
Content-Disposition: inline
In-Reply-To: <7vwrzin9jt.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/137188>

On Fri, Jan 15, 2010 at 05:05:42PM -0800, Junio C Hamano wrote:

> > Out of curiosity, what are the interesting features in git grep versus
> > other greps?
> 
> Three examples:
> 
>     git grep -e Junio --and -e Dscho --and -e Peff
> 
> is different from
> 
>     grep "Junio.*Dscho.*Peff"

Right. I would do:

  grep Junio | grep Dscho | grep Peff

No, it's not quite as accurate, as you are grepping the filenames too.

And no, it's not as efficient, but given that the first grep eliminates
most of your input anyway, it's generally not a big deal.

So the short answer to my question seems to be "git grep has logical
operators". I don't find that compelling, but I guess some people do.
Thanks for satisfying my curiosity.

> I don't know how you would do these with "grep":
> 
>     git grep -e Junio --and -e Dscho --and --not -e Linus

I would do "grep Junio | grep Dscho | grep -v Linus".

>     git grep --all-match -e Junio -e Dscho

That one is a little harder (though it is not something I do very often,
and I had to actually read the docs to find what --all-match does):

  grep Junio `grep -l Dscho *`

which of course has problems with exotic filenames.

-Peff
