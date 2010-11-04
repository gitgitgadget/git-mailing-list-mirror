From: Jeff King <peff@peff.net>
Subject: Re: certificate problem for *.github.com
Date: Thu, 4 Nov 2010 11:46:00 -0400
Message-ID: <20101104154600.GA30026@sigill.intra.peff.net>
References: <20101104162135.47chayboagwwkcc8@webmail.uu.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Mattia Tomasoni <Mattia.Tomasoni.8371@student.uu.se>
X-From: git-owner@vger.kernel.org Thu Nov 04 16:45:28 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PE20F-0007HG-LY
	for gcvg-git-2@lo.gmane.org; Thu, 04 Nov 2010 16:45:28 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752484Ab0KDPpU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 4 Nov 2010 11:45:20 -0400
Received: from xen6.gtisc.gatech.edu ([143.215.130.70]:37705 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752431Ab0KDPpT (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 4 Nov 2010 11:45:19 -0400
Received: (qmail 32145 invoked by uid 111); 4 Nov 2010 15:45:18 -0000
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net (HELO sigill.intra.peff.net) (99.108.226.0)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.40) with ESMTPA; Thu, 04 Nov 2010 15:45:18 +0000
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 04 Nov 2010 11:46:00 -0400
Content-Disposition: inline
In-Reply-To: <20101104162135.47chayboagwwkcc8@webmail.uu.se>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/160729>

On Thu, Nov 04, 2010 at 04:21:35PM +0100, Mattia Tomasoni wrote:

> I get:
> certificate common name `*.github.com' doesn't match requested host
> name `github.com'
> 
> wget --no-check-certificate works...

The problem is that wildcard names in certificates are not
well-specified. RFC 2818 leaves this particular case (matching
"*.domain" to "domain") ambiguous:

  Names may contain the wildcard character * which is considered to
  match any single domain name component or component fragment. E.g.,
  *.a.com matches foo.a.com but not bar.foo.a.com. f*.com matches
  foo.com but not bar.com.

RFC 2595 specifically outlaws it, but is talking about other non-HTTP
protocols (it is for TLS with IMAP, POP, and ACAP):

  A "*" wildcard character MAY be used as the left-most name component
  in the certificate.  For example, *.example.com would match
  a.example.com, foo.example.com, etc. but would not match example.com.

So you can either send a bug report to wget to handle this case better,
or you can complain to github not to use wildcard certificates in this
way.

-Peff
