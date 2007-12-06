From: Jeff King <peff@peff.net>
Subject: Re: [PATCH v4] Allow update hooks to update refs on their own.
Date: Thu, 6 Dec 2007 01:36:26 -0500
Message-ID: <20071206063626.GA18698@coredump.intra.peff.net>
References: <7vr6i8sfsa.fsf@gitster.siamese.dyndns.org> <20071202212224.GA22117@midwinter.com> <20071203021333.GC8322@coredump.intra.peff.net> <7vlk8csetl.fsf@gitster.siamese.dyndns.org> <5920F34B-A94B-4C24-A95B-D35F35A4F0C0@midwinter.com> <7vhciwn5rl.fsf@gitster.siamese.dyndns.org> <20071206055723.GB23309@coredump.intra.peff.net> <7veje0gwru.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Steven Grimm <koreth@midwinter.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Dec 06 07:36:51 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J0ALp-0000WL-KW
	for gcvg-git-2@gmane.org; Thu, 06 Dec 2007 07:36:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752821AbXLFGg3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 6 Dec 2007 01:36:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752732AbXLFGg3
	(ORCPT <rfc822;git-outgoing>); Thu, 6 Dec 2007 01:36:29 -0500
Received: from 66-23-211-5.clients.speedfactory.net ([66.23.211.5]:3880 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752181AbXLFGg2 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 6 Dec 2007 01:36:28 -0500
Received: (qmail 28404 invoked by uid 111); 6 Dec 2007 06:36:27 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.32) with SMTP; Thu, 06 Dec 2007 01:36:27 -0500
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Thu, 06 Dec 2007 01:36:26 -0500
Content-Disposition: inline
In-Reply-To: <7veje0gwru.fsf@gitster.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/67256>

On Wed, Dec 05, 2007 at 10:30:45PM -0800, Junio C Hamano wrote:

> The rebase would be "rebase --onto W' X Z", so it is not strictly
> necessary to keep the fact that X corresponds to X', but somehow I
> thought it was necessary, and Steven's message was hinting about that:
> 
>   > If we want that status in principle, I'd argue that sending down the
>   > updated commit SHA1 is actually the right way to indicate it, because
>   > it gives the client all the information it needs to make an
>   > intelligent choice about what to do next. If you don't transmit the
>   > modified SHA1, the client will have to do another fetch to find out
>   > what rewriting was done by the server, and if another push happened in
>   > the meantime, the client will have to basically guess about which
>   > commits correspond to the ones it pushed.
> 
> (notice the last part).
> 
> So if we want to transmit minimum amount of information, we can just
> send a bit ("the ref was rewritten") back to send-pack without telling
> it what X' is (but it would not hurt to send it back either).  With that
> one bit of information, send-pack can refrain from updating tracking ref
> from Y to X.

Ah, I thought his argument was "we have to send back a bit, so why not
just send the hash we made for informational purposes? It doesn't hurt,
and maybe we can make use of it later."

I was assuming that we were interested _only_ in fixing the send-pack
issues at this time, and that the rebasing or merging part of the
workflow would be figured out later. But it is probably sensible to
consider the whole workflow to see what is necessary at each step.

-Peff
