From: Jeff King <peff@peff.net>
Subject: Re: [PATCH_v1] add 'git credential' plumbing command
Date: Mon, 11 Jun 2012 11:45:18 -0400
Message-ID: <20120611154518.GA12773@sigill.intra.peff.net>
References: <1339267502-13803-1-git-send-email-Javier.Roucher-Iglesias@ensimag.imag.fr>
 <20120610115619.GA6453@sigill.intra.peff.net>
 <7vlijt980w.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Javier.Roucher-Iglesias@ensimag.imag.fr, git@vger.kernel.org,
	Javier Roucher <jroucher@gmail.com>,
	Pavel Volek <Pavel.Volek@ensimag.imag.fr>,
	NGUYEN Kim Thuat <Kim-Thuat.Nguyen@ensimag.imag.fr>,
	ROUCHER IGLESIAS Javier <roucherj@ensimag.imag.fr>,
	Matthieu Moy <Matthieu.Moy@imag.fr>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Jun 11 17:45:36 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Se6o4-0002hN-56
	for gcvg-git-2@plane.gmane.org; Mon, 11 Jun 2012 17:45:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755848Ab2FKPpY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 11 Jun 2012 11:45:24 -0400
Received: from 99-108-225-23.lightspeed.iplsin.sbcglobal.net ([99.108.225.23]:50097
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755825Ab2FKPpX (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 11 Jun 2012 11:45:23 -0400
Received: (qmail 4257 invoked by uid 107); 11 Jun 2012 15:45:22 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Mon, 11 Jun 2012 11:45:22 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 11 Jun 2012 11:45:18 -0400
Content-Disposition: inline
In-Reply-To: <7vlijt980w.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/199665>

On Mon, Jun 11, 2012 at 08:34:55AM -0700, Junio C Hamano wrote:

> Jeff King <peff@peff.net> writes:
> 
> > Perhaps it would be simpler to accept a URL on the command line, and
> > also provide a --stdin option for callers that want to feed it directly.
> > So:
> >
> >   git credential fill https://example.com/foo.git
> >
> > would be identical to:
> >
> >   git credential --stdin fill <<\EOF
> >   protocol=https
> >   host=example.com
> >   path=foo.git
> >   EOF
> 
> and "git credential fill https://peff@example.com/foo.git" would be
> identical to the latter one with user=peff already filled in?

Exactly. Though see my other response to Matthieu, which notes that:

  git credential fill https://peff:supersecret@example.com/foo.git

is problematic. :(

Probably it should be spelled:

  git credential fill <<\EOF
  url=https://peff:supersecret@example.com/foo.git
  EOF

and then:

  git credential fill <<\EOF
  url=https://peff:supersecret@example.com/foo.git
  username=junio
  password=othersecret

would do what you expect (break the URL out into its components, and
then override particular fields).

-Peff
