From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 0/9] respect binary attribute in grep
Date: Thu, 2 Feb 2012 06:07:19 -0500
Message-ID: <20120202110719.GA29870@sigill.intra.peff.net>
References: <20120201221437.GA19044@sigill.intra.peff.net>
 <20120201232109.GA2652@sigill.intra.peff.net>
 <7vhaza12ol.fsf@alter.siamese.dyndns.org>
 <20120202005209.GA6883@sigill.intra.peff.net>
 <20120202081747.GA10271@sigill.intra.peff.net>
 <87vcnp5wkg.fsf@thomas.inf.ethz.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>,
	Thomas Rast <trast@student.ethz.ch>,
	Conrad Irwin <conrad.irwin@gmail.com>, git@vger.kernel.org,
	Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
	Dov Grobgeld <dov.grobgeld@gmail.com>
To: Thomas Rast <trast@inf.ethz.ch>
X-From: git-owner@vger.kernel.org Thu Feb 02 12:07:28 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RsuVj-00037g-PV
	for gcvg-git-2@plane.gmane.org; Thu, 02 Feb 2012 12:07:28 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755651Ab2BBLHX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 2 Feb 2012 06:07:23 -0500
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:53275
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753447Ab2BBLHW (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 2 Feb 2012 06:07:22 -0500
Received: (qmail 21002 invoked by uid 107); 2 Feb 2012 11:14:27 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Thu, 02 Feb 2012 06:14:27 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 02 Feb 2012 06:07:19 -0500
Content-Disposition: inline
In-Reply-To: <87vcnp5wkg.fsf@thomas.inf.ethz.ch>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/189627>

On Thu, Feb 02, 2012 at 12:00:47PM +0100, Thomas Rast wrote:

> My original plan was to make use_threads git-global, instead of
> grep-global (and shift responsibility to the subsystems instead of their
> users), but that's just me and the patches aren't ready yet.

Yeah, having just dug into the threading code in grep a bit, I agree
that would be a saner approach. The locking is all bolted-on, so you end
up with these weird contracts between code, like the low-level grep code
asking anybody who might be multi-threading it to initialize the mutexes
to cover access to a totally different subsystem. I'd much rather each
subsystem just take care of itself.

-Peff
