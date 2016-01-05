From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 03/16] refs: add methods for the ref iterators
Date: Mon, 4 Jan 2016 20:17:11 -0500
Message-ID: <20160105011711.GA31667@sigill.intra.peff.net>
References: <1449102921-7707-1-git-send-email-dturner@twopensource.com>
 <1449102921-7707-4-git-send-email-dturner@twopensource.com>
 <20160103000623.GB14424@gmail.com>
 <CAL=YDW=3JE==2s7Y3-fVRnTgaAzT674CAnypuXOKynpfD0q=Bg@mail.gmail.com>
 <xmqqegdxnlba.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Ronnie Sahlberg <sahlberg@google.com>,
	David Aguilar <davvid@gmail.com>,
	David Turner <dturner@twopensource.com>,
	"git@vger.kernel.org" <git@vger.kernel.org>,
	Michael Haggerty <mhagger@alum.mit.edu>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Jan 05 02:17:23 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aGGFT-00060O-PS
	for gcvg-git-2@plane.gmane.org; Tue, 05 Jan 2016 02:17:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753815AbcAEBRP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 4 Jan 2016 20:17:15 -0500
Received: from cloud.peff.net ([50.56.180.127]:48587 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1753688AbcAEBRO (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 4 Jan 2016 20:17:14 -0500
Received: (qmail 12426 invoked by uid 102); 5 Jan 2016 01:17:14 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Mon, 04 Jan 2016 20:17:14 -0500
Received: (qmail 7464 invoked by uid 107); 5 Jan 2016 01:17:28 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Mon, 04 Jan 2016 20:17:28 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 04 Jan 2016 20:17:11 -0500
Content-Disposition: inline
In-Reply-To: <xmqqegdxnlba.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/283338>

On Mon, Jan 04, 2016 at 12:26:01PM -0800, Junio C Hamano wrote:

> An API enhancement to allow us to handle refs in multiple
> repositories separately would be a very welcome move (it would get
> rid of the hacky interface for_each_ref_in_submodule(), for one
> thing), but even after that happens, I'd expect we would have most
> callers asking to interact with "the_backend", the single default
> instance.

I am just a bystander here, but I think I agree. I do not know how we
will handle migrations from one format to another, but if we can
instantiate two separate ref backends at once, it seems like we should
be able to just for_each_ref() in the "old" backend, and update_ref() in
the new one.

I did not dig in the code, but I think that is similar to why we have
the multiple-index code. It is not about juggling a bunch of independent
instances, but about moving data between them (though not specifically
for migration in the case of the index).

As much as it would be nice to clean this up before moving to multiple
backends, though, I don't think we should make it a pre-requisite. This
is a difficult topic as it is, and I'd rather see us make incremental
improvement (backends, then hopefully more flexible mixing of backends)
than get bogged down and get neither.

-Peff
