From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 1/5] t5312: test object deletion code paths in a
 corrupted repository
Date: Thu, 19 Mar 2015 17:47:07 -0400
Message-ID: <20150319214707.GA8680@peff.net>
References: <20150317072750.GA22155@peff.net>
 <20150317072844.GA25191@peff.net>
 <xmqqfv90iwjj.fsf@gitster.dls.corp.google.com>
 <20150319205147.GA7775@peff.net>
 <xmqqvbhwheb6.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org, Michael Haggerty <mhagger@alum.mit.edu>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Mar 19 22:47:22 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YYiHc-00050l-MC
	for gcvg-git-2@plane.gmane.org; Thu, 19 Mar 2015 22:47:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751132AbbCSVrM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 19 Mar 2015 17:47:12 -0400
Received: from cloud.peff.net ([50.56.180.127]:35493 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1750839AbbCSVrL (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 19 Mar 2015 17:47:11 -0400
Received: (qmail 6566 invoked by uid 102); 19 Mar 2015 21:47:11 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Thu, 19 Mar 2015 16:47:10 -0500
Received: (qmail 17890 invoked by uid 107); 19 Mar 2015 21:47:21 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Thu, 19 Mar 2015 17:47:21 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 19 Mar 2015 17:47:07 -0400
Content-Disposition: inline
In-Reply-To: <xmqqvbhwheb6.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/265840>

On Thu, Mar 19, 2015 at 02:23:25PM -0700, Junio C Hamano wrote:

> Jeff King <peff@peff.net> writes:
> 
> >> A safer check may be to pack and then make it missing, I guess, but
> >> I do not know if the difference matters.
> >
> > Yeah, I considered that. The trouble is that we are relying on the
> > earlier setup that made the object go missing. We cannot pack the refs
> > in the setup step, because the earlier tests are checking the loose-ref
> > behavior. So we would have to actually restore the object, pack, and
> > then re-delete it.
> 
> Yes, "restore pack redelete" was what I had in mind when I wondered
> such a sequence of extra steps is worth and the difference between
> such an approach and an approach to use a hand-crafted packed-refs
> file matters.

I took a look at this. It turns out to be rather annoying, because we
can't just restore $missing. The earlier tests may have deleted other
random objects (like $recoverable) depending on whether or not they
actually failed.

So I'm inclined to leave it (we do confirm with the rev-parse call at
the end of the setup that our packed-refs file is working) unless you
feel strongly. If you do, I'd rather go the route of sticking each
corruption in its own separate sub-repo.

-Peff
