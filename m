From: Jeff King <peff@peff.net>
Subject: Re: [PATCH RFC] git-am: support any number of signatures
Date: Tue, 7 Oct 2014 17:39:00 -0400
Message-ID: <20141007213859.GB24508@peff.net>
References: <xmqqy4x03ecm.fsf@gitster.dls.corp.google.com>
 <20140615102736.GA11798@redhat.com>
 <xmqqy4wwraoz.fsf@gitster.dls.corp.google.com>
 <20140618030903.GA19593@redhat.com>
 <CAPc5daVTZynCKMubZmreAjBh3i51wPaAA+8vSRwB9dGrrJb6FA@mail.gmail.com>
 <xmqq38f2jed3.fsf@gitster.dls.corp.google.com>
 <20140922140144.GA9769@redhat.com>
 <CAP8UFD2W1r9859FgpBXqvdNLAfXoCwjpEFpTKXU6fGuC_8uvBg@mail.gmail.com>
 <xmqqbnq6jm0s.fsf@gitster.dls.corp.google.com>
 <20141007212937.GA14632@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>,
	Christian Couder <christian.couder@gmail.com>,
	Git Mailing List <git@vger.kernel.org>,
	Christian Couder <chriscool@tuxfamily.org>
To: "Michael S. Tsirkin" <mst@redhat.com>
X-From: git-owner@vger.kernel.org Tue Oct 07 23:39:12 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XbcTN-0007Lq-17
	for gcvg-git-2@plane.gmane.org; Tue, 07 Oct 2014 23:39:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755245AbaJGVjE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 7 Oct 2014 17:39:04 -0400
Received: from cloud.peff.net ([50.56.180.127]:55984 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1755102AbaJGVjD (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 7 Oct 2014 17:39:03 -0400
Received: (qmail 10011 invoked by uid 102); 7 Oct 2014 21:39:02 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Tue, 07 Oct 2014 16:39:02 -0500
Received: (qmail 9840 invoked by uid 107); 7 Oct 2014 21:39:03 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Tue, 07 Oct 2014 17:39:03 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 07 Oct 2014 17:39:00 -0400
Content-Disposition: inline
In-Reply-To: <20141007212937.GA14632@redhat.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Oct 08, 2014 at 12:29:37AM +0300, Michael S. Tsirkin wrote:

> > If I understand it correctly, Michael is envisioning to implement
> > his "git am -s art" (I would recommend against reusing -s for this,
> > though.  "git am --trailer art" is fine) and doing so by using
> > interpret-trailers as an internal implementation detail, so I would
> > say the above is a perfectly fine way to do so.  An equivalent of
> > that command line is synthesized and run internally in his version
> > of "git am" when his "git am" sees "--trailer art" option using
> > those am.{"a","r","t"}.trailer configuration variables.
> 
> Hmm I wonder why do you dislike reusing -s with a parameter for this.
> To me, this looks like a superset of the default -s functionality: -s
> adds the default signature, -s "x" adds signature "x" ...  Users don't
> really care that one is implemented as a trailer and another isn't.  In
> fact, default -s can be implemented as a trailer too, right?
> 
> Could you clarify please?

Optional parameters for arguments make backwards-compatibility tricky.
In this case, the command:

  git am -s mbox1 mbox2

means "apply the patches from mbox1 and mbox2, and signoff the patches".
Under your scheme, it now means "apply from mbox2, and use the trailer
mbox1".

I think it would make more sense for "-s" to use a trailer called
"signoff" if it is configured (and if not, have a baked-in "signoff"
trailer config that behaves like "-s" does now). So "-s" (and
"--signoff") become "sign off in the way I usually do for my project",
not just "add a signed-off-by line". If you want to something more
fancy, you have to use "--trailer=...".

Just my two cents, as one who has not been closely following this
discussion. Apologies if this idea was already presented and shot down.
:)

-Peff
