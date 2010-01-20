From: Jeff King <peff@peff.net>
Subject: Re: git notes: notes
Date: Wed, 20 Jan 2010 17:25:48 -0500
Message-ID: <20100120222548.GD15936@coredump.intra.peff.net>
References: <20100120050343.GA12860@gnu.kitenet.net>
 <201001201148.11701.johan@herland.net>
 <20100120182438.GB31507@gnu.kitenet.net>
 <7vhbqg376b.fsf@alter.siamese.dyndns.org>
 <20100120195626.GA6641@gnu.kitenet.net>
 <7vska01qrt.fsf@alter.siamese.dyndns.org>
 <4B576F5C.2050102@drmicha.warpmail.net>
 <7veilk1o3s.fsf@alter.siamese.dyndns.org>
 <7v3a201lpz.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Michael J Gruber <git@drmicha.warpmail.net>,
	Joey Hess <joey@kitenet.net>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Johan Herland <johan@herland.net>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Jan 20 23:25:58 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NXizr-00061r-6J
	for gcvg-git-2@lo.gmane.org; Wed, 20 Jan 2010 23:25:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753391Ab0ATWZv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 20 Jan 2010 17:25:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752517Ab0ATWZv
	(ORCPT <rfc822;git-outgoing>); Wed, 20 Jan 2010 17:25:51 -0500
Received: from peff.net ([208.65.91.99]:35965 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751796Ab0ATWZv (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 20 Jan 2010 17:25:51 -0500
Received: (qmail 10484 invoked by uid 107); 20 Jan 2010 22:30:44 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Wed, 20 Jan 2010 17:30:44 -0500
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Wed, 20 Jan 2010 17:25:48 -0500
Content-Disposition: inline
In-Reply-To: <7v3a201lpz.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/137594>

On Wed, Jan 20, 2010 at 01:59:36PM -0800, Junio C Hamano wrote:

> Subject: Fix "log" family not to be too agressive about showing notes
> 
> Giving "Notes" information in the default output format of "log" and
> "show" is a sensible progress (the user has asked for it by having the
> notes), but for some commands (e.g. "format-patch") spewing notes into the
> formatted commit log message without being asked is too aggressive.
> 
> Enable notes output only for "log", "show", "whatchanged" by default;
> other users can ask for it by setting show_notes field to true.

What I didn't get out of reading this but did from reading the code (I
think) is what you meant by "by default" here. That is, doing:

  git log

will show notes, but neither

  git log --pretty=raw

nor even

  git log --pretty=medium

will do so, even though the latter otherwise produces identical output
to the default.

That seems like a reasonable rule to me, but I just wanted to make sure
that was both what was happening and what was intended.

> Signed-off-by: Junio C Hamano <gitster@pobox.com>
> ---
>  builtin-log.c |    2 ++
>  commit.h      |    1 +
>  log-tree.c    |    1 +
>  pretty.c      |    2 +-
>  revision.c    |    4 ++++
>  revision.h    |    1 +
>  6 files changed, 10 insertions(+), 1 deletions(-)

No tests or docs, of course. :) You can squash the --pretty=raw test
from my patch, but you will need to exercise --show-notes and
--no-show-notes, too, as well as checking other formats and things like
format-patch. So probably writing your own tests will make it easier to
more thoroughly check each case.

-Peff
