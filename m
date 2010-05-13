From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] git-rebase--interactive: Handle commit messages that
 end in backslash
Date: Thu, 13 May 2010 10:33:50 -0400
Message-ID: <20100513143350.GA2742@sigill.intra.peff.net>
References: <20100513133955.05493175@bobcat.office>
 <20100513135807.548594f9@bobcat.office>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Chris Lamb <lamby@debian.org>
X-From: git-owner@vger.kernel.org Thu May 13 16:34:00 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OCZU6-0003ZB-I7
	for gcvg-git-2@lo.gmane.org; Thu, 13 May 2010 16:33:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758463Ab0EMOdx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 13 May 2010 10:33:53 -0400
Received: from peff.net ([208.65.91.99]:57238 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756919Ab0EMOdx (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 13 May 2010 10:33:53 -0400
Received: (qmail 19624 invoked by uid 107); 13 May 2010 14:33:52 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.40) with ESMTPA; Thu, 13 May 2010 10:33:52 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 13 May 2010 10:33:50 -0400
Content-Disposition: inline
In-Reply-To: <20100513135807.548594f9@bobcat.office>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/147014>

On Thu, May 13, 2010 at 01:58:07PM +0100, Chris Lamb wrote:

> Disregard the patch; it has some funky side-effect which breaks ONTO
> parsing and I don't know why.
>
> (The problem still exists though.)

Hmm. It looks like there is more weirdness, too. Try

  git commit -m 'magic \\n newline'

I get a stray newline in the git-rebase-todo file. IIRC, we had this
problem before because some shells' "echo" will interpret, and some will
not (I think bash will not, but dash will). So there are a few "echo"
calls that need to be "printf %s" in git-rebase--interactive.

But I wonder if we would do better to simply sanitize the subject line
of metacharacters. As I understand it[1], the subject line shown is for
human consumption only, and the actual operations happen on the included
sha1. So we could munge it in a non-reversible way without breaking
anything.

-Peff

[1] I may be wrong. This is not code I'm too familiar with, and I do
remember a proposal at some point for automagically handling subjects
with "wip" or "squash" in them. Still, a light munging may work.
