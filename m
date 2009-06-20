From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 1/7] fast-export: Omit tags that tag trees
Date: Sat, 20 Jun 2009 14:52:37 -0400
Message-ID: <20090620185236.GA8847@coredump.intra.peff.net>
References: <1245472623-28103-1-git-send-email-newren@gmail.com>
 <1245472623-28103-2-git-send-email-newren@gmail.com>
 <20090620173128.GE31022@coredump.intra.peff.net>
 <51419b2c0906201101u2f8e6981q84ab7acc13dc9135@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org, Johannes.Schindelin@gmx.de,
	kusmabite@gmail.com
To: Elijah Newren <newren@gmail.com>
X-From: git-owner@vger.kernel.org Sat Jun 20 20:54:46 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MI5i2-0000t8-Rr
	for gcvg-git-2@gmane.org; Sat, 20 Jun 2009 20:54:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760413AbZFTSwl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 20 Jun 2009 14:52:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759927AbZFTSwk
	(ORCPT <rfc822;git-outgoing>); Sat, 20 Jun 2009 14:52:40 -0400
Received: from peff.net ([208.65.91.99]:53876 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757195AbZFTSwk (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 20 Jun 2009 14:52:40 -0400
Received: (qmail 27816 invoked by uid 107); 20 Jun 2009 18:54:27 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Sat, 20 Jun 2009 14:54:27 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Sat, 20 Jun 2009 14:52:37 -0400
Content-Disposition: inline
In-Reply-To: <51419b2c0906201101u2f8e6981q84ab7acc13dc9135@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/121950>

On Sat, Jun 20, 2009 at 12:01:00PM -0600, Elijah Newren wrote:

> I don't see how we could do something similar for the tree case
> without making some significant change to the output/input of both
> fast-export and fast-import.  Tag objects are part of the output of
> fast-export, thus we can add a mark line to give the object a name and
> thus provide us a valid mark we can make the outer tag point to.
> Trees are not output by fast-export (other than implicitly by
> including files in commits), so we have nothing to point such a tag
> at.  If we were to do something like use the full sha1sum instead of

Ah, right. That falls under the "I didn't look at this too closely" part
of my previous message. :)

It does seem a shame not to be able to say "and now here is a tree" in
the same way we say "and now here is a commit". And since that is not
possible without add-ons that might cause compatibility issues, your fix
seems reasonable to at least avoid generating bogus output.

Another option would be to generate a pseudo-commit with no parentage
that holds the tree, and then point the tag at that. It's obviously not
exactly what the user wanted, but neither is simply omitting. You could
even mark the commit message with a "THIS IS REALLY A TREE" magic
string, and then have fast-import recognize and convert those back to a
tree (by just peeling the commit away).

-Peff
