From: Jeff King <peff@peff.net>
Subject: Re: [RFC/PATCH] git checkout $tree path
Date: Tue, 4 Oct 2011 03:42:12 -0400
Message-ID: <20111004074212.GB7308@sigill.intra.peff.net>
References: <7vk48rq854.fsf@alter.siamese.dyndns.org>
 <20111003102647.GD16078@sigill.intra.peff.net>
 <7vmxdigirk.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Oct 04 09:42:20 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RAzdr-0005Iy-J4
	for gcvg-git-2@lo.gmane.org; Tue, 04 Oct 2011 09:42:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755112Ab1JDHmP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 4 Oct 2011 03:42:15 -0400
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:52010
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755062Ab1JDHmP (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 4 Oct 2011 03:42:15 -0400
Received: (qmail 4518 invoked by uid 107); 4 Oct 2011 07:47:20 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Tue, 04 Oct 2011 03:47:20 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 04 Oct 2011 03:42:12 -0400
Content-Disposition: inline
In-Reply-To: <7vmxdigirk.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/182739>

On Mon, Oct 03, 2011 at 09:08:31AM -0700, Junio C Hamano wrote:

> We can think of it both ways, but the "make it look like the other one"
> unfortunately is too big a departure from the traditional semantics. At
> least I wanted "checkout master -- $path" to mean "I want to copy $path
> out of master and _overlay_ that on top of what I have now", similar to
> the way how "tar xf master.tar $path" and "cp -r ../master/$path $path"
> would be used, so that the command can help the user advance what is in
> progress and already underway in $path in the current working tree.

Yeah, I think the "overlay" semantics at least makes some sense. The
strongest argument for "replace" semantics is that "git reset <path>"
uses them, and it would be nice if they were consistent. But I agree
that the overlay is closer to what happens now.

> Replacing could be easily done with "git rm -r [--cached] $path" followed
> by "git checkout $tree $path" under the original semantics, but overlaying
> is not very easily done if "git checkout $tree $path" had your "make $path
> look like it does in $tree" semantics.

True.

> The change brought in by the RFC/PATCH does change the behaviour, and I am
> fairly comfortable now to say that it is a bugfix ("copy and overlay" a la
> "tar xf" never clobbers/removes files not in the source, but the current
> code does).

That sounds good to me, and I think properly doing a pure overlay is way
better than the prior behavior.

This is sufficiently tricky and subtle that it is probably worth
future-proofing with some tests (e.g., the example you gave in the
commit message).

-Peff
