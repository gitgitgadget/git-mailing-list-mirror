From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] Revert "completion: fix shell expansion of items"
Date: Wed, 26 Sep 2012 17:46:53 -0400
Message-ID: <20120926214653.GA18628@sigill.intra.peff.net>
References: <1348107315-25095-1-git-send-email-felipe.contreras@gmail.com>
 <20120920014608.GA27782@sigill.intra.peff.net>
 <20120920181152.GA4689@goldbirke>
 <20120925043119.GA6208@sigill.intra.peff.net>
 <20120925223725.GA12658@goldbirke>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Felipe Contreras <felipe.contreras@gmail.com>, git@vger.kernel.org,
	Junio C Hamano <gitster@pobox.com>
To: SZEDER =?utf-8?B?R8OhYm9y?= <szeder@ira.uka.de>
X-From: git-owner@vger.kernel.org Wed Sep 26 23:47:07 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TGzRi-0004Ht-4w
	for gcvg-git-2@plane.gmane.org; Wed, 26 Sep 2012 23:47:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751403Ab2IZVq5 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 26 Sep 2012 17:46:57 -0400
Received: from 75-15-5-89.uvs.iplsin.sbcglobal.net ([75.15.5.89]:59346 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751116Ab2IZVq4 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 26 Sep 2012 17:46:56 -0400
Received: (qmail 27948 invoked by uid 107); 26 Sep 2012 21:47:24 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Wed, 26 Sep 2012 17:47:24 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 26 Sep 2012 17:46:53 -0400
Content-Disposition: inline
In-Reply-To: <20120925223725.GA12658@goldbirke>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/206448>

On Wed, Sep 26, 2012 at 12:37:25AM +0200, SZEDER G=C3=A1bor wrote:

> I looked into this issue, but quickly got lost in quoting-escaping
> hell.  Ideally we could do some quoting in __gitcomp_nl(), so it woul=
d
> work for all kinds of input, but I couldn't come up with anything
> working.  Alternatively, we could modify __gitcomp_nl()'s callers, or
> rather the helper functions supplying input to __gitcomp_nl() to do
> the quoting or escaping themselves.  Actually, that's quite easy for
> local refs, at least, because for-each-ref's builtin quoting support
> does the trick:

I feel like insanity lies that way, because every caller is going to
have to do its own quoting. On the other hand, I think it would be the
only way to handle completion of entries with embedded newlines (as it
is now, we pass in a newline-delimited list with no opportunity for
quoting).

Here's a simple patch series that fixes the problem and adds a few basi=
c
sanity checks.

  [1/3]: t9902: add a few basic completion tests
  [2/3]: t9902: add completion tests for "odd" filenames
  [3/3]: completion: improve shell expansion of items

-Peff
