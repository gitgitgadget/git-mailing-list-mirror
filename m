From: Jeff King <peff@peff.net>
Subject: Re: [PATCH v2 12/12] refs: move the remaining ref module
 declarations to refs.h
Date: Mon, 15 Jun 2015 14:35:05 -0400
Message-ID: <20150615183504.GB4041@peff.net>
References: <cover.1434206062.git.mhagger@alum.mit.edu>
 <79947baebd702f8e9fe9b667e2eeb69afa73094b.1434206062.git.mhagger@alum.mit.edu>
 <xmqqfv5salh9.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Michael Haggerty <mhagger@alum.mit.edu>,
	Stefan Beller <sbeller@google.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Jun 15 20:35:14 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z4ZE1-0006bN-EW
	for gcvg-git-2@plane.gmane.org; Mon, 15 Jun 2015 20:35:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755914AbbFOSfI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 15 Jun 2015 14:35:08 -0400
Received: from cloud.peff.net ([50.56.180.127]:46342 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1754236AbbFOSfH (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 15 Jun 2015 14:35:07 -0400
Received: (qmail 1701 invoked by uid 102); 15 Jun 2015 18:35:07 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Mon, 15 Jun 2015 13:35:07 -0500
Received: (qmail 5991 invoked by uid 107); 15 Jun 2015 18:35:12 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Mon, 15 Jun 2015 14:35:12 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 15 Jun 2015 14:35:05 -0400
Content-Disposition: inline
In-Reply-To: <xmqqfv5salh9.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/271701>

On Mon, Jun 15, 2015 at 11:13:22AM -0700, Junio C Hamano wrote:

> > @@ -78,15 +170,15 @@ typedef int each_ref_fn(const char *refname,
> >   * modifies the reference also returns a nonzero value to immediately
> >   * stop the iteration.
> >   */
> > -extern int head_ref(each_ref_fn, void *);
> > +extern int head_ref(each_ref_fn fn, void *cb_data);
> 
> For example, between these two, what did we gain?
> 
> Because of their types, it already was clear what the two parameters
> are in the original, without noisewords like "fn" (which obviously
> stands for a "function", but that is clear due to "each_ref_fn").

I think the real benefit of naming parameters is that you can talk about
"fn" and "cb_data" by name in the docstring[1]. Of course we do not do
that here, so we could clearly wait until "if-and-when" we do so. But I
do not think it is a big deal for our style guide to say "we always name
parameters in declarations", and to bring things in line there (though
perhaps it should be a separate patch in that case).

[1] For instance, in the docstring here, which is just outside the
    context, we use the awkward phrase "the specified callback
    function". That would be much simpler as just `fn`, though having so
    few parameters to these functions, it is fairly clear already.

> > -extern int for_each_glob_ref_in(each_ref_fn, const char *pattern, const char* prefix, void *);
> > +extern int for_each_glob_ref_in(each_ref_fn fn, const char *pattern, const char* prefix, void *cb_data);
> 
> Likewise for addition of fn and cb_data.
> 
> If you really want to make unrelated changes to this file, what you
> should fix is to update "const char* prefix" to "const char *prefix"
> ;-)

IMHO they are in the same boat (style fixes), and I would be happy to
see both improved. :)

-Peff
