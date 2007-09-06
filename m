From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 1/7] Rework strbuf API and semantics.
Date: Thu, 6 Sep 2007 11:36:13 -0400
Message-ID: <20070906153613.GA4008@coredump.intra.peff.net>
References: <20070902224213.GB431@artemis.corp> <11890776114037-git-send-email-madcoder@debian.org> <118907761140-git-send-email-madcoder@debian.org> <Pine.LNX.4.64.0709061506330.28586@racer.site> <20070906142155.GB3002@coredump.intra.peff.net> <857in3dfad.fsf@lola.goethe.zz> <20070906145035.GA3546@coredump.intra.peff.net> <85tzq7bzoz.fsf@lola.goethe.zz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Pierre Habouzit <madcoder@debian.org>, git@vger.kernel.org
To: David Kastrup <dak@gnu.org>
X-From: git-owner@vger.kernel.org Thu Sep 06 17:36:34 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1ITJP3-00020I-Qe
	for gcvg-git@gmane.org; Thu, 06 Sep 2007 17:36:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756844AbXIFPgQ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 6 Sep 2007 11:36:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756443AbXIFPgQ
	(ORCPT <rfc822;git-outgoing>); Thu, 6 Sep 2007 11:36:16 -0400
Received: from 66-23-211-5.clients.speedfactory.net ([66.23.211.5]:4043 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756760AbXIFPgP (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 6 Sep 2007 11:36:15 -0400
Received: (qmail 22690 invoked by uid 111); 6 Sep 2007 15:36:14 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.32) with SMTP; Thu, 06 Sep 2007 11:36:14 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Thu, 06 Sep 2007 11:36:13 -0400
Content-Disposition: inline
In-Reply-To: <85tzq7bzoz.fsf@lola.goethe.zz>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/57891>

On Thu, Sep 06, 2007 at 05:06:52PM +0200, David Kastrup wrote:

> >   If an object that has automatic storage duration is not initialized
> >   explicitly, its value is indeterminate. If an object that has static
> >   storage duration is not initialized explicitly, then:
> >
> >   -- if it has pointer type, it is initialized to a null pointer;
> 
> That's actually a new one to me.  I don't think that it has been
> always the case in ANSI C.

I don't have the C89 standard, so it's hard to be authoritative.
However, according to TCOR1 to the C89 standard, the original text of
6.5.7 contained:

  If an object that has static storage duration is not initialized
  explicitly, it is initialized implicitly as if every member that has
  arithmetic type were assigned 0 and every member that has pointer type
  were assigned a null pointer constant.

and was changed to:

  If an object that has static storage duration is not initialized
  explicitly, then:

    - if it has pointer type, it is initialized to a null pointer;

    - if it has arithmetic type, it is initialized to zero;

    - if it is an aggregate, every member is initialized (recursively)
      according to these rules;

    - if it is a union, the first named member is initialized
      (recursively) according to these rules.

But for the case of pointer initializations, both have the same effect.
So I think it has always been the case. Pre-ANSI, who knows. :)

You can find TCOR1 here:

  http://www.open-std.org/jtc1/sc22/wg14/www/docs/tc1.htm

And now I must go get some real work done instead of snooping through
standards. :)

-Peff
