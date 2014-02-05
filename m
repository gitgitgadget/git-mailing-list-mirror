From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 11/13] Makefile: auto-build C strings from make variables
Date: Wed, 5 Feb 2014 14:20:33 -0500
Message-ID: <20140205192033.GB15489@sigill.intra.peff.net>
References: <20140205174823.GA15070@sigill.intra.peff.net>
 <20140205180206.GK15218@sigill.intra.peff.net>
 <xmqqeh3h4beu.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Feb 05 20:20:49 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WB81f-0001V3-Fv
	for gcvg-git-2@plane.gmane.org; Wed, 05 Feb 2014 20:20:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751531AbaBETUj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 5 Feb 2014 14:20:39 -0500
Received: from cloud.peff.net ([50.56.180.127]:45220 "HELO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751679AbaBETUf (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 5 Feb 2014 14:20:35 -0500
Received: (qmail 12394 invoked by uid 102); 5 Feb 2014 19:20:35 -0000
Received: from c-71-63-4-13.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.63.4.13)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Wed, 05 Feb 2014 13:20:35 -0600
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 05 Feb 2014 14:20:33 -0500
Content-Disposition: inline
In-Reply-To: <xmqqeh3h4beu.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/241643>

On Wed, Feb 05, 2014 at 11:17:13AM -0800, Junio C Hamano wrote:

> Jeff King <peff@peff.net> writes:
> 
> > diff --git a/script/mkcstring b/script/mkcstring
> > new file mode 100644
> > index 0000000..c01f430
> > --- /dev/null
> > +++ b/script/mkcstring
> > @@ -0,0 +1,18 @@
> > +#!/bin/sh
> > +
> > +name=$1; shift
> > +
> > +c_quote() {
> > +	sed 's/\\/\\\\/g; s/"/\\"/'
> 
> No 'g' for the second one?

That's a bug. Thanks for catching.

I tested most of these changes manually, but I missed this one by only
testing a value with a single quote. At one point I had introduced:

  $(eval $(call make-var,FOO,debug variable,$(FOO)))

so you could do "make MAKE/FOO" and "make MAKE/foo-string.c", but I did
not include it in the series. Adding a test suite to our Makefile kind
of seems like overkill, but as it gets complex, maybe some simple sanity
checks are worthwhile (not part of the regular test suite, but maybe
just a "./test-make" script to make sure it behaves). I dunno.

-Peff
