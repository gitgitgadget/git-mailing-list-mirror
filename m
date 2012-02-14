From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 2/2] git-svn, perl/Git.pm: extend and use Git->prompt
 method for querying users
Date: Tue, 14 Feb 2012 17:20:55 -0500
Message-ID: <20120214222055.GE24802@sigill.intra.peff.net>
References: <4EF9ED58.8080205@tu-clausthal.de>
 <20120103184022.GA20926@sigill.intra.peff.net>
 <4F37E2B0.9060007@tu-clausthal.de>
 <201202121711.45920.jnareb@gmail.com>
 <4F37E843.6070107@tu-clausthal.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Jakub Narebski <jnareb@gmail.com>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Sven Strickroth <sven.strickroth@tu-clausthal.de>
X-From: git-owner@vger.kernel.org Tue Feb 14 23:21:08 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RxQkE-0007JF-6i
	for gcvg-git-2@plane.gmane.org; Tue, 14 Feb 2012 23:21:06 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757277Ab2BNWVA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 14 Feb 2012 17:21:00 -0500
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:35986
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754480Ab2BNWU7 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 14 Feb 2012 17:20:59 -0500
Received: (qmail 13022 invoked by uid 107); 14 Feb 2012 22:28:10 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Tue, 14 Feb 2012 17:28:10 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 14 Feb 2012 17:20:55 -0500
Content-Disposition: inline
In-Reply-To: <4F37E843.6070107@tu-clausthal.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/190778>

On Sun, Feb 12, 2012 at 05:26:43PM +0100, Sven Strickroth wrote:

> Am 12.02.2012 17:11 schrieb Jakub Narebski:
> > Doesn't Subversion use SSH directly?  If it is so, the question is
> > about how SSH itself supports SSH_ASKPASS.
> 
> Oh sorry, I mixed up SSH and SVN_ASKPASS. :( Of couse SSH_ASKPASS is
> provided by the ssh-client itself.

That raises an interesting point for git (I don't remember seeing this
in the previous discussion, so apologies if I'm repeating). We sometimes
use SSH_ASKPASS for internal prompting, and sometimes via calling out to
ssh. So forgetting about git being consistent with the rest of the
world for a moment, I think we are inconsistent with ourselves. E.g.:

  export SSH_ASKPASS=whatever

  # this will try the terminal first, then SSH_ASKPASS, because it is
  # ssh doing the asking
  git push ssh://example.com/repo.git

  # this will try SSH_ASKPASS first, then the terminal, because git is
  # doing the asking
  git push https://example.com/repo.git

So now I'm more convinced than ever that the order should be
GIT_ASKPASS, terminal, SSH_ASKPASS.

-Peff
