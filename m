From: Jeff King <peff@peff.net>
Subject: Re: [IGNORETHIS/PATCH] Choosing the sha1 prefix of your commits
Date: Thu, 20 Oct 2011 00:34:48 -0400
Message-ID: <20111020043448.GA7628@sigill.intra.peff.net>
References: <CACBZZX5PqYa0uWiGgs952rk2cy+QRCU95kF63qzSi3fKK-YrCQ@mail.gmail.com>
 <20111019190114.GA4670@sigill.intra.peff.net>
 <20111019193834.GA14168@sigill.intra.peff.net>
 <7vvcrk9td7.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Oct 20 06:34:57 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RGkLI-0007FN-MK
	for gcvg-git-2@lo.gmane.org; Thu, 20 Oct 2011 06:34:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751693Ab1JTEew (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 20 Oct 2011 00:34:52 -0400
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:35999
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751292Ab1JTEev (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 20 Oct 2011 00:34:51 -0400
Received: (qmail 6615 invoked by uid 107); 20 Oct 2011 04:34:58 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Thu, 20 Oct 2011 00:34:58 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 20 Oct 2011 00:34:48 -0400
Content-Disposition: inline
In-Reply-To: <7vvcrk9td7.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/184005>

On Wed, Oct 19, 2011 at 09:31:16PM -0700, Junio C Hamano wrote:

> Jeff King <peff@peff.net> writes:
> 
> > And nothing shows up in the body, because git truncates at the NUL we
> > added:
> >
> >   $ git show
> >   commit 31337a1093af2d97eb2e6c08b261c2946395fdd3
> >   Author: Jeff King <peff@peff.net>
> >   Date:   Wed Oct 19 15:34:00 2011 -0400
> >
> >       10
> >
> >   diff --git a/file b/file
> 
> But you cannot hide from "cat-file commit" ;-)

Yes. The implementation is a horrible hack, second only in grossness to
the original idea. :)

> With the recent push to more (perceived) security, it may probably make
> sense to teach "log" family commands to quote-show ^@ and what is behind
> in their output by default, perhaps with an option to turn it off.

Agreed. Having hidden cruft makes birthday collision attacks easier (or
it will, if sha1 ever gets broken to that point).  Unfortunately, there
is a _ton_ of code which assumes that commit messages are
NUL-terminated, as they always have been since e871b64 (2005-05-25).

-Peff
