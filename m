From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] Try an uppercase version of $prot_proxy env var
Date: Fri, 27 Apr 2012 04:12:20 -0400
Message-ID: <20120427081220.GC12092@sigill.intra.peff.net>
References: <xmqq8vhmhzpk.fsf@junio.mtv.corp.google.com>
 <4F966F0C.6090504@seap.minhap.es>
 <xmqqipgpgdpl.fsf@junio.mtv.corp.google.com>
 <4F994AC3.2070708@seap.minhap.es>
 <20120426130854.GC27785@sigill.intra.peff.net>
 <xmqqehraa5ct.fsf@junio.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Nelson Benitez Leon <nelsonjesus.benitez@seap.minhap.es>,
	git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Apr 27 10:12:32 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SNgI3-00042l-Cd
	for gcvg-git-2@plane.gmane.org; Fri, 27 Apr 2012 10:12:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759185Ab2D0IMZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 27 Apr 2012 04:12:25 -0400
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:47779
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756968Ab2D0IMW (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 27 Apr 2012 04:12:22 -0400
Received: (qmail 25853 invoked by uid 107); 27 Apr 2012 08:12:35 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Fri, 27 Apr 2012 04:12:35 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 27 Apr 2012 04:12:20 -0400
Content-Disposition: inline
In-Reply-To: <xmqqehraa5ct.fsf@junio.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/196452>

On Thu, Apr 26, 2012 at 08:18:58AM -0700, Junio C Hamano wrote:

> Jeff King <peff@peff.net> writes:
> 
> > Don't we explicitly not want to do this when the protocol is http? Curl
> > doesn't respect HTTP_PROXY.
> 
> Yes.  Here is what I'll queue.

I had raised several other points in my (admittedly belated) review[1].
So I was kind of expecting a re-roll rather than a patch on top. It was
mostly readability issues, but there is also a potential segfault when
the url has no protocol. I'm not sure it can happen in normal git use,
but:

  git remote-https url-without-protocol

may dereference null (it's via snprintf, so on my system glibc magically
rewrites this as "(null)_proxy", but other systems will segfault).

-Peff

[1] http://article.gmane.org/gmane.comp.version-control.git/195443
    http://article.gmane.org/gmane.comp.version-control.git/195445
