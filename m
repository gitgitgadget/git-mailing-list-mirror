From: Jeff King <peff@peff.net>
Subject: Re: git auto-repack is broken...
Date: Fri, 2 Dec 2011 13:13:59 -0500
Message-ID: <20111202181358.GD24093@sigill.intra.peff.net>
References: <CA+55aFznj49hx6Ce6NhJ1rRd2nvNyOERseyyrC6SNcW-z9dyfg@mail.gmail.com>
 <CACBZZX7Q5qb1r_Oh0QfMiWh9UAM1c6QWBn4abv-xHpFBaKuyKg@mail.gmail.com>
 <CA+55aFyq28vmo9dk-5mVm+nNn86qSjNT6VJGc09iaJo=+OP1Sg@mail.gmail.com>
 <20111202171017.GB23447@sigill.intra.peff.net>
 <7vobvqoozr.fsf@alter.siamese.dyndns.org>
 <20111202174546.GA24093@sigill.intra.peff.net>
 <7vd3c6onhs.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	=?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Dec 02 19:14:08 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RWXcd-0003wv-Nt
	for gcvg-git-2@lo.gmane.org; Fri, 02 Dec 2011 19:14:08 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932102Ab1LBSOC (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 2 Dec 2011 13:14:02 -0500
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:39092
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932085Ab1LBSOA (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 2 Dec 2011 13:14:00 -0500
Received: (qmail 8836 invoked by uid 107); 2 Dec 2011 18:20:36 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Fri, 02 Dec 2011 13:20:36 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 02 Dec 2011 13:13:59 -0500
Content-Disposition: inline
In-Reply-To: <7vd3c6onhs.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/186237>

On Fri, Dec 02, 2011 at 10:08:15AM -0800, Junio C Hamano wrote:

> Jeff King <peff@peff.net> writes:
> 
> > But we shouldn't be packing totally unreferenced objects.
> 
> Everything you said is correct in today's Git and I obviously know it, but
> I was taking the "Or have an extra option to..." at the end of the OP's
> message in the thread into account, so...

Ah, sorry, I missed the subtlety of Linus's "repacking the objects
results in problems..." from his later message and thought he just meant
repacking in general. Yes, it's a bad idea to repack unreachable objects
because then you could never prune anything.

I think just shrinking the --expire window that we already use is a much
more reasonable bet. It's not about preventing the loss of old work
(reflogs are there for that), but about avoiding hurting an actively
running, about-to-reference-the-objects git process. And 2 weeks is
quite conservative for that.

-Peff
