From: Jeff King <peff@peff.net>
Subject: Re: [PATCH v3 2/4] t/t7030-verify-tag.sh: Adds validation for
 multiple tags
Date: Sun, 3 Apr 2016 09:07:25 -0400
Message-ID: <20160403130724.GA16206@sigill.intra.peff.net>
References: <1459638975-17705-1-git-send-email-santiago@nyu.edu>
 <1459638975-17705-3-git-send-email-santiago@nyu.edu>
 <20160403044054.GB1519@sigill.intra.peff.net>
 <CAPig+cQp2t0y7imR5tTHdLdMO6w13ia-GxZXxq4c2NGaZTjErw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Santiago Torres <santiago@nyu.edu>, Git List <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>
To: Eric Sunshine <sunshine@sunshineco.com>
X-From: git-owner@vger.kernel.org Sun Apr 03 15:07:37 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1amhke-0004WH-Lk
	for gcvg-git-2@plane.gmane.org; Sun, 03 Apr 2016 15:07:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753491AbcDCNH3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 3 Apr 2016 09:07:29 -0400
Received: from cloud.peff.net ([50.56.180.127]:43337 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751566AbcDCNH2 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 3 Apr 2016 09:07:28 -0400
Received: (qmail 27770 invoked by uid 102); 3 Apr 2016 13:07:27 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Sun, 03 Apr 2016 09:07:27 -0400
Received: (qmail 16847 invoked by uid 107); 3 Apr 2016 13:07:28 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Sun, 03 Apr 2016 09:07:28 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sun, 03 Apr 2016 09:07:25 -0400
Content-Disposition: inline
In-Reply-To: <CAPig+cQp2t0y7imR5tTHdLdMO6w13ia-GxZXxq4c2NGaZTjErw@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/290639>

On Sun, Apr 03, 2016 at 03:59:46AM -0400, Eric Sunshine wrote:

> On Sun, Apr 3, 2016 at 12:40 AM, Jeff King <peff@peff.net> wrote:
> > In fact, I suspect you could replace the "GOODSIG" check as well by
> > doing something like:
> >
> >   # verifying 3 tags in one invocation should be exactly like
> >   # verifying the 3 separately
> >   tags="fourth-signed sixth-signed seventh-signed"
> >   for i in $tags; do
> >           git verify-tag -v --raw $i || return 1
> >   done >expect.stdout 2>expect.stderr &&
> >   git verify-tag -v --raw $tags >actual.stdout 2>actual.stderr &&
> >   test_cmp expect.stdout actual.stdout &&
> >   test_cmp expect.stderr actual.stderr
> 
> Hmm, does [1] suggest that using test_cmp on stderr here would be
> contraindicated?
> 
> [1]: http://article.gmane.org/gmane.comp.version-control.git/289077

It does, but I am not sure I agree with the advice in that email in the
general case (I like making "-x" work, too, but not at the cost of
making the tests harder to read and write). In this case, I suppose you
could grep for gpg raw-output on stderr, though, and compare only that.

-Peff
