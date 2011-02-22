From: Jeff King <peff@peff.net>
Subject: Re: How do I make git-format-patch reject 8-bit encodings?
Date: Tue, 22 Feb 2011 02:33:30 -0500
Message-ID: <20110222073330.GA8626@sigill.intra.peff.net>
References: <4D62E315.7040506@freescale.com>
 <7vbp24hqez.fsf@alter.siamese.dyndns.org>
 <4D6302E6.1070602@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>,
	"git@vger.kernel.org" <git@vger.kernel.org>
To: Tabi Timur-B04825 <B04825@freescale.com>
X-From: git-owner@vger.kernel.org Tue Feb 22 08:33:40 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Prmkd-0002Hx-Ml
	for gcvg-git-2@lo.gmane.org; Tue, 22 Feb 2011 08:33:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753814Ab1BVHdf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 22 Feb 2011 02:33:35 -0500
Received: from xen6.gtisc.gatech.edu ([143.215.130.70]:51070 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753503Ab1BVHdf (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 22 Feb 2011 02:33:35 -0500
Received: (qmail 30809 invoked by uid 111); 22 Feb 2011 07:33:34 -0000
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net (HELO sigill.intra.peff.net) (99.108.226.0)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.40) with ESMTPA; Tue, 22 Feb 2011 07:33:34 +0000
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 22 Feb 2011 02:33:30 -0500
Content-Disposition: inline
In-Reply-To: <4D6302E6.1070602@freescale.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/167530>

On Tue, Feb 22, 2011 at 12:27:19AM +0000, Tabi Timur-B04825 wrote:

> Junio C Hamano wrote:
> > Feels like an X-Y problem, but wouldn't it be an option to let
> > format-patch write into individual files, check these files and reject
> > ones that are not 8-bit clean, and then send the result out via
> > send-email?  You should be proofreading the format-patch output to catch
> > and fix typos before hading them to send-email anyway, so the above would
> > be the natural thing to do.
> 
> The problem is that it appears that git-send-email is taking
> normal-looking patches and encoding them as base64, and I don't know
> about it until after the email is sent.

Can you provide an example of a message that is base64-encoded? I didn't
think we base64-encoded anything in send-email (we do rfc2047-encode
8-bit header lines, but using quoted-printable). And looking through it,
I don't see any code to do so.

It's possible that I'm missing the code. Or that one of the underlying
modules is doing it for us. Or it's possible that one of the SMTP
servers in your route is doing it.

If you can send an example of original format-patch output that you fed
to git-send-email, and the resulting mail that was delivered, then we
can know more.

I have a suspicion it is the last one (some MTA doing it), because git
tends to generate messages with an 8bit transfer encoding. If we hit a
server that doesn't advertise support for 8BIT SMTP extensions, I
believe the sending MTA is required to encode (or bounce). That would
also account for the inconsistency you noted. It depends on the
recipient and the exact route of SMTP servers in the delivery.

-Peff
