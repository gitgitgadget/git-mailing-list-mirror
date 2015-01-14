From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] blame.c: fix garbled error message
Date: Wed, 14 Jan 2015 15:49:26 -0500
Message-ID: <20150114204926.GA1155@peff.net>
References: <1420925601-21615-1-git-send-email-git@cryptocrack.de>
 <xmqq4mrv95qt.fsf@gitster.dls.corp.google.com>
 <xmqqzj9n623h.fsf@gitster.dls.corp.google.com>
 <20150112231231.GA4023@peff.net>
 <xmqqzj9n4k11.fsf@gitster.dls.corp.google.com>
 <20150113015427.GA5497@peff.net>
 <20150114142146.16390.54937@typhoon.lan>
 <xmqqr3uxb7kj.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Lukas Fleischer <git@cryptocrack.de>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Jan 14 21:49:34 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YBUsf-0002Md-Mn
	for gcvg-git-2@plane.gmane.org; Wed, 14 Jan 2015 21:49:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751582AbbANUta (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 14 Jan 2015 15:49:30 -0500
Received: from cloud.peff.net ([50.56.180.127]:34563 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751331AbbANUt3 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 14 Jan 2015 15:49:29 -0500
Received: (qmail 13503 invoked by uid 102); 14 Jan 2015 20:49:29 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Wed, 14 Jan 2015 14:49:29 -0600
Received: (qmail 6345 invoked by uid 107); 14 Jan 2015 20:49:50 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Wed, 14 Jan 2015 15:49:50 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 14 Jan 2015 15:49:26 -0500
Content-Disposition: inline
In-Reply-To: <xmqqr3uxb7kj.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/262423>

On Wed, Jan 14, 2015 at 09:22:52AM -0800, Junio C Hamano wrote:

> Lukas Fleischer <git@cryptocrack.de> writes:
> 
> >>   [1/5]: git-compat-util: add xstrdup_or_null helper
> >>   [2/5]: builtin/apply.c: use xstrdup_or_null instead of null_strdup
> >>   [3/5]: builtin/commit.c: use xstrdup_or_null instead of envdup
> >>   [4/5]: use xstrdup_or_null to replace ternary conditionals
> >>   [5/5]: blame.c: fix garbled error message
> >> 
> >
> > Looks good to me! I am not sure whether those patches should be built on
> > top of (a fixed version of) my patch, though, which would make
> > backporting the fix to the maintenance branch straightforward. Junio?
> 
> We can queue these five on top of 1da1e07c (clean up name allocation
> in prepare_revision_walk, 2014-10-15), which changed the rule of the
> game to break this code, that only is in v2.2 and later.
> 
> And the result should merge just fine to 'maint'.

Are we in agreement then that the resulting code with the helper is
actually easier to read? I think replacing the straight ?: lines is, but
I am on the fence on whether:

  const char *x = some_fun(...);
  return xstrdup_or_null(x);

is better or worse than:

  return xstrdup_or_null(some_fun(....));

-Peff
