From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] grep: --full-tree
Date: Wed, 25 Nov 2009 15:52:32 -0500
Message-ID: <20091125205232.GB18487@coredump.intra.peff.net>
References: <7vk4xggv27.fsf@alter.siamese.dyndns.org>
 <fabb9a1e0911250656k31229c42jd79fb94c1a619e59@mail.gmail.com>
 <7vr5rmwgbn.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Sverre Rabbelier <srabbelier@gmail.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Nov 25 21:52:45 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NDOqr-0006OT-IC
	for gcvg-git-2@lo.gmane.org; Wed, 25 Nov 2009 21:52:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S935042AbZKYUwZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 25 Nov 2009 15:52:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S935040AbZKYUwY
	(ORCPT <rfc822;git-outgoing>); Wed, 25 Nov 2009 15:52:24 -0500
Received: from peff.net ([208.65.91.99]:45665 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S935039AbZKYUwY (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 25 Nov 2009 15:52:24 -0500
Received: (qmail 16217 invoked by uid 107); 25 Nov 2009 20:56:55 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Wed, 25 Nov 2009 15:56:55 -0500
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Wed, 25 Nov 2009 15:52:32 -0500
Content-Disposition: inline
In-Reply-To: <7vr5rmwgbn.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/133672>

On Wed, Nov 25, 2009 at 11:32:44AM -0800, Junio C Hamano wrote:

> But if a command like "grep" that "does one small thing and do it well"
> changes its behaviour drastically depending on a config variable or an
> environment variable, it won't be a command that you can rely upon any
> more in your scripts and hooks.  It's the same insanity as GREP_OPTIONS
> environment variable.

I know this is the attitude we have taken in the past, and I am worried
it is part of what hurts the usability of git. Just consider for a
moment: git grows some feature with a default behavior X. Time passes.
Some people like behavior Y instead. How can we help the people who like
Y?

  1. Declare Y better than X, and default to it. This hurts people who
     like X. It also hurts scripts built around X.

  2. Add a config option to switch the behavior to Y. This hurts people
     or scripts unexpectedly using somebody's configuration with Y.

  3. Add a --Y command line option. Now the Y people have to remember to
     use that option. Every single time they invoke the command.

  4. Tell them to alias "git foo-y" to "git foo --Y". IMHO, this is
     completely unscalable. They can't just call it "foo", so they have
     to remember to invoke "foo-y" each time. And when they forget,
     instead of getting an error, they get the X behavior. Furthermore,
     as time goes on, they basically develop a vocabulary of git
     commands that is totally unlike anybody else's, making their
     scripts and git knowledge unportable to other people's setups (sort
     of like in (2) above).

So as a Y user, what is the impression of git that I am left with? It
doesn't do what I want unless I remember an option every time, or create
an arcane pseudo-porcelain interface through my set of aliases. Patches
to fix the situation are blocked by compatibility issues. Y users remain
frustrated indefinitely.

I know that (1) and (2) have their problems. But I think by not giving a
little on those compatibility issues, we end up with an equally bad or
worse outcome. In other words, I think in this case that (2) may be the
lesser of many evils.

-Peff
