From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 3/5] clone: find the current branch more explicitly
Date: Sun, 30 Nov 2008 13:10:11 -0500
Message-ID: <20081130181011.GB10375@coredump.intra.peff.net>
References: <1228039053-31099-1-git-send-email-gitster@pobox.com> <1228039053-31099-2-git-send-email-gitster@pobox.com> <1228039053-31099-3-git-send-email-gitster@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Nov 30 19:11:35 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1L6qlZ-0003UG-FH
	for gcvg-git-2@gmane.org; Sun, 30 Nov 2008 19:11:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752162AbYK3SKP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 30 Nov 2008 13:10:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752488AbYK3SKP
	(ORCPT <rfc822;git-outgoing>); Sun, 30 Nov 2008 13:10:15 -0500
Received: from peff.net ([208.65.91.99]:4223 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751937AbYK3SKN (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 30 Nov 2008 13:10:13 -0500
Received: (qmail 9241 invoked by uid 111); 30 Nov 2008 18:10:13 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.32) with SMTP; Sun, 30 Nov 2008 13:10:13 -0500
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Sun, 30 Nov 2008 13:10:11 -0500
Content-Disposition: inline
In-Reply-To: <1228039053-31099-3-git-send-email-gitster@pobox.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/101981>

On Sun, Nov 30, 2008 at 01:57:30AM -0800, Junio C Hamano wrote:

> +			sym = find_ref_by_name(refs, symref);
> +			if (!sym) {
> +				/*
> +				 * NEEDSWORK: perhaps create the symref ref
> +				 * that is still unborn and queue it?
> +				 */
> +				continue;
> +			}

I don't see any reason not to create the pointer to an unborn branch. I
think it would be nice eventually to allow cloning an empty repository
(i.e., to facilitate:

  mkdir foo &&
  (cd foo && git --bare init) &&
  git clone foo bar &&
  cd bar &&
  echo content >file && git add file && git commit -m content &&
  git push

) which people have asked for from time to time.

> +			if (sym->symref)
> +				die("symref line says %s points at %s "
> +				    "but earlier it said it points at %s",
> +				    symref, target, sym->symref);

I wonder if there would ever be a use for sending multiple symref
packets for the same ref. IOW, should we "be liberal in what we accept"
here and just choose some sane behavior (like picking the first or last
to be sent), and allow room for expansion there.

I can't actually think of a possible use for that, but nor can I think
of any particular reason to die here (save for detecting bugs in
upload-pack :) ). But just consider that we will be stuck with clients
with the "die" behavior forever.

-Peff
