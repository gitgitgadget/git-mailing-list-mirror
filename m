From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 3/4] cat-file: add --batch-disk-sizes option
Date: Wed, 10 Jul 2013 07:04:04 -0400
Message-ID: <20130710110402.GD9724@sigill.intra.peff.net>
References: <20130707100133.GA18717@sigill.intra.peff.net>
 <20130707100949.GC19143@sigill.intra.peff.net>
 <7vtxk645vp.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Jul 10 13:04:17 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UwsC1-0004pq-2m
	for gcvg-git-2@plane.gmane.org; Wed, 10 Jul 2013 13:04:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752658Ab3GJLEN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 10 Jul 2013 07:04:13 -0400
Received: from cloud.peff.net ([50.56.180.127]:47498 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751173Ab3GJLEM (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 10 Jul 2013 07:04:12 -0400
Received: (qmail 23324 invoked by uid 102); 10 Jul 2013 11:05:27 -0000
Received: from c-98-244-76-202.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (98.244.76.202)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Wed, 10 Jul 2013 06:05:27 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 10 Jul 2013 07:04:04 -0400
Content-Disposition: inline
In-Reply-To: <7vtxk645vp.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/230039>

On Sun, Jul 07, 2013 at 10:49:46AM -0700, Junio C Hamano wrote:

> Jeff King <peff@peff.net> writes:
> 
> > Perhaps we need
> >
> >   git cat-file --batch-format="%(disk-size) %(object)"
> >
> > or similar.
> 
> I agree with your reasoning.  It may be simpler to give an interface
> to ask for which pieces of info, e.g. --batch-cols=size,disksize,
> without giving the readers a flexible "format".

I started on this, and it turned out not to really be any simpler. In
particular there is the question of whether

  git cat-file --batch-cols=size,type

is different from

  git cat-file --batch-cols=type,size

If so, then you are basically implementing the equivalent of a macro
format anyway (you have to parse it left to right to know the order).
And if not, you end up translating the column list into a bit-field, and
the boilerplate for adding a new item is about the same as for a macro
format.

So I went ahead with the full formats for my re-roll. It turned out
pretty reasonable, I think.

-Peff
