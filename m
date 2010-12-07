From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] logging branch deletion to help recovering from mistakes
Date: Tue, 7 Dec 2010 12:06:23 -0500
Message-ID: <20101207170623.GB21749@sigill.intra.peff.net>
References: <7vlj42siu5.fsf@alter.siamese.dyndns.org>
 <AANLkTikbsyFUzZeu8R6yAND6spV6OnvYL08gYZ+ZgJCh@mail.gmail.com>
 <7vmxoiqeoq.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Nguyen Thai Ngoc Duy <pclouds@gmail.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Dec 07 18:06:41 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PQ0zq-0005Tj-Lg
	for gcvg-git-2@lo.gmane.org; Tue, 07 Dec 2010 18:06:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752182Ab0LGRG1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 7 Dec 2010 12:06:27 -0500
Received: from xen6.gtisc.gatech.edu ([143.215.130.70]:49422 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751871Ab0LGRG0 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 7 Dec 2010 12:06:26 -0500
Received: (qmail 25430 invoked by uid 111); 7 Dec 2010 17:06:25 -0000
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net (HELO sigill.intra.peff.net) (99.108.226.0)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.40) with ESMTPA; Tue, 07 Dec 2010 17:06:25 +0000
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 07 Dec 2010 12:06:23 -0500
Content-Disposition: inline
In-Reply-To: <7vmxoiqeoq.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/163091>

On Mon, Dec 06, 2010 at 10:28:53PM -0800, Junio C Hamano wrote:

> > Should this special log be mentioned in git-update-ref.txt or
> > gitrepository-layout.txt?
> 
> Perhaps, but I wasn't sure if this patch itself is a good idea to begin
> with.  Not the problem it tries to solve, but its approach.
> 
> For example, this cannot be shown with "reflog show" or "log -g" due to
> the way these frontends locate the reflog file to read (the logic wants to
> have an underlying ref).

Yeah, I think this is not _quite_ what people want in this area. A base
requirement from past discussions, I think, is that the whole reflog of
the deleted branch be saved rather than just the tip. And then "reflog
show" would make a lot more sense on such saved reflogs.

I'm not sure in practice how important that distinction is, as we are
not saving deleted branch reflogs _at all_ right now, so the
requirements are mostly speculation at this point.

The most recent discussion I recall is this one:

  http://thread.gmane.org/gmane.comp.version-control.git/144250/focus=145353

where the general idea was to just keep deleted reflogs around, append
to them if the branch was recreated, and use a consistent renaming
scheme to avoid D/F naming conflicts (e.g., "foo" is a deleted ref, and
you create "foo/bar").

-Peff
