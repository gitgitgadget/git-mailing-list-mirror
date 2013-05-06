From: Jeff King <peff@peff.net>
Subject: Re: [PATCH v2 2/3] fast-export: improve speed by skipping blobs
Date: Mon, 6 May 2013 12:40:46 -0400
Message-ID: <20130506164046.GA20257@sigill.intra.peff.net>
References: <1367793534-8401-1-git-send-email-felipe.contreras@gmail.com>
 <1367793534-8401-3-git-send-email-felipe.contreras@gmail.com>
 <20130506123111.GB3809@sigill.intra.peff.net>
 <7v7gjctabm.fsf@alter.siamese.dyndns.org>
 <20130506162008.GB7992@sigill.intra.peff.net>
 <7vli7srrva.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Felipe Contreras <felipe.contreras@gmail.com>, git@vger.kernel.org,
	Antoine Pelisse <apelisse@gmail.com>,
	Johannes Schindelin <johannes.schindelin@gmx.de>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon May 06 18:41:01 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UZOT7-0007aR-Kq
	for gcvg-git-2@plane.gmane.org; Mon, 06 May 2013 18:40:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754600Ab3EFQkt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 6 May 2013 12:40:49 -0400
Received: from cloud.peff.net ([50.56.180.127]:39653 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753525Ab3EFQks (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 6 May 2013 12:40:48 -0400
Received: (qmail 14842 invoked by uid 102); 6 May 2013 16:41:08 -0000
Received: from c-71-206-173-132.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.206.173.132)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Mon, 06 May 2013 11:41:08 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 06 May 2013 12:40:46 -0400
Content-Disposition: inline
In-Reply-To: <7vli7srrva.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/223471>

On Mon, May 06, 2013 at 09:32:41AM -0700, Junio C Hamano wrote:

> > OK. If the argument is "we do not write them, so do not bother reading
> > them back in", I think that is reasonable.
> 
> The way I read builtin/fast-export.c::import_marks() is that it is
> more like "we do not write them, and we do not read them back in
> either IN THE CURRENT CODE".

Ahh...I see now. It is not about skipping the blobs as a new behavior,
but rather about skipping them _earlier_, before we have loaded the
object contents from disk.

I took the "we don't care about" as "the general use of fast-export does
not care about", but it is "we will literally just drop them a few lines
later".

So yes, I think this is an obviously correct optimization. Thanks for
clarifying, and sorry to be so slow.

-Peff
