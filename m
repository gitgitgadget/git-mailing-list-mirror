From: Jeff King <peff@peff.net>
Subject: Re: [PATCH v2 2/2] send-email: introduce sendemail.smtpsslcertpath
Date: Sun, 7 Jul 2013 01:54:38 -0400
Message-ID: <20130707055438.GA1730@sigill.intra.peff.net>
References: <1373025947-26495-1-git-send-email-artagnon@gmail.com>
 <1373025947-26495-3-git-send-email-artagnon@gmail.com>
 <20130705124536.GU862789@vauxhall.crustytoothpaste.net>
 <7vobag7wl0.fsf@alter.siamese.dyndns.org>
 <20130705202948.GW862789@vauxhall.crustytoothpaste.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>,
	Ramkumar Ramachandra <artagnon@gmail.com>,
	Git List <git@vger.kernel.org>
To: "brian m. carlson" <sandals@crustytoothpaste.net>
X-From: git-owner@vger.kernel.org Sun Jul 07 07:54:59 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Uvhw2-0005NB-35
	for gcvg-git-2@plane.gmane.org; Sun, 07 Jul 2013 07:54:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751295Ab3GGFym (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 7 Jul 2013 01:54:42 -0400
Received: from cloud.peff.net ([50.56.180.127]:45142 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751104Ab3GGFym (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 7 Jul 2013 01:54:42 -0400
Received: (qmail 779 invoked by uid 102); 7 Jul 2013 05:55:55 -0000
Received: from c-98-244-76-202.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (98.244.76.202)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Sun, 07 Jul 2013 00:55:55 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sun, 07 Jul 2013 01:54:38 -0400
Content-Disposition: inline
In-Reply-To: <20130705202948.GW862789@vauxhall.crustytoothpaste.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/229731>

On Fri, Jul 05, 2013 at 08:29:48PM +0000, brian m. carlson wrote:

> On Fri, Jul 05, 2013 at 10:20:11AM -0700, Junio C Hamano wrote:
> > +# Helper to come up with SSL/TLS certification validation params
> > +# and warn when doing no verification
> > +sub ssl_verify_params {
> > +	use IO::Socket::SSL qw(SSL_VERIFY_PEER SSL_VERIFY_NONE);
> 
> You might as well put this at the top of the file, because all use
> statements happen at compile time anyway, regardless of their location.
> If you want to lazy-load this, you need to do:
> 
> require IO::Socket::SSL;
> IO::Socket::SSL->import(qw(SSL_VERIFY_PEER SSL_VERIFY_NONE));
> 
> which is equivalent to "use" except that it happens at runtime.

I think we _must_ lazy load this, or else we are breaking git-send-email
users on platforms that do not have IO::Socket::SSL (and do not plan on
using SSL themselves).

The same goes for the "use" in patch 1/2.

-Peff
