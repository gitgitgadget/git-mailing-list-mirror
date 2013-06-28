From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 1/2] status: really ignore config with --porcelain
Date: Fri, 28 Jun 2013 15:31:04 -0400
Message-ID: <20130628193104.GA12625@sigill.intra.peff.net>
References: <1372077912-18625-2-git-send-email-artagnon@gmail.com>
 <vpqhagnwraj.fsf@anie.imag.fr>
 <CALkWK0=F_i95S+53eZmOAJtA+jG=jvi5-sDc3BgW3rNQo=n3Ng@mail.gmail.com>
 <vpqhagnv9xq.fsf@anie.imag.fr>
 <7vk3ljbh5r.fsf@alter.siamese.dyndns.org>
 <vpq7ghjtpv1.fsf@anie.imag.fr>
 <7vk3lj9xwn.fsf@alter.siamese.dyndns.org>
 <20130628014011.GA620@sigill.intra.peff.net>
 <7v61wyrikr.fsf@alter.siamese.dyndns.org>
 <7vhagip25l.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Ramkumar Ramachandra <artagnon@gmail.com>,
	Git List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Jun 28 21:32:35 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UsePI-0003Z3-Ob
	for gcvg-git-2@plane.gmane.org; Fri, 28 Jun 2013 21:32:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752768Ab3F1Tc3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 28 Jun 2013 15:32:29 -0400
Received: from cloud.peff.net ([50.56.180.127]:50705 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752597Ab3F1TbI (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 28 Jun 2013 15:31:08 -0400
Received: (qmail 17167 invoked by uid 102); 28 Jun 2013 19:32:14 -0000
Received: from c-98-244-76-202.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (98.244.76.202)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Fri, 28 Jun 2013 14:32:14 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 28 Jun 2013 15:31:04 -0400
Content-Disposition: inline
In-Reply-To: <7vhagip25l.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/229228>

On Fri, Jun 28, 2013 at 10:37:26AM -0700, Junio C Hamano wrote:

> > The final patch ended up folding that "-z" default logic into the
> > same function, so it probably is saner to remove UNSPECIFIED.
> 
> Actually, the code needs to be able to differentiate between
> 
> 	git status --no-short
>         git status
> 
> the former telling us explicitly to defeat status.short while the
> latter telling us to use whatever random value we happen to have in
> the configuration.  Initializing the variable to UNSPECIFIED is one
> way to achieve that, as the former will explicitly set it to NONE
> while the latter will leave it UNSPECIFIED when the command line
> parsing finishes.

Hmm. I would have thought --no-short would just set it to LONG. That is,
we are no longer NONE at that point, as the user has told us something
on the command line. So we are whatever --no-short is, which is LONG.

But I guess that would wreck

  git status --no-short -z

which currently defaults to porcelain. Which, to be honest, seems a
little crazy to me, but I guess there is no reason to break it.

I am just trying to prevent the future maintenance confusion where a
reader of the code says "Huh? What is the difference between NONE and
UNSPECIFIED?"

-Peff
