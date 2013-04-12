From: Jeff King <peff@peff.net>
Subject: Re: regression: "96b9e0e3 config: treat user and xdg config
 permission problems as errors" busted git-daemon
Date: Fri, 12 Apr 2013 12:16:01 -0400
Message-ID: <20130412161600.GA20492@sigill.intra.peff.net>
References: <7vip3shfpd.fsf@alter.siamese.dyndns.org>
 <20130411222301.GA11283@sigill.intra.peff.net>
 <20130412005748.GA17116@odin.tremily.us>
 <7vvc7sfkwn.fsf@alter.siamese.dyndns.org>
 <20130412043501.GA12942@sigill.intra.peff.net>
 <7vr4igfj9w.fsf@alter.siamese.dyndns.org>
 <20130412050550.GA15724@sigill.intra.peff.net>
 <20130412112636.GC20178@odin.tremily.us>
 <20130412144855.GA17968@sigill.intra.peff.net>
 <7vk3o7g29s.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: "W. Trevor King" <wking@tremily.us>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Mike Galbraith <bitbucket@online.de>, git <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Apr 12 18:16:11 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UQge2-00082E-H9
	for gcvg-git-2@plane.gmane.org; Fri, 12 Apr 2013 18:16:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753304Ab3DLQQF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 12 Apr 2013 12:16:05 -0400
Received: from 75-15-5-89.uvs.iplsin.sbcglobal.net ([75.15.5.89]:42902 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751864Ab3DLQQE (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 12 Apr 2013 12:16:04 -0400
Received: (qmail 27241 invoked by uid 107); 12 Apr 2013 16:17:57 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Fri, 12 Apr 2013 12:17:57 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 12 Apr 2013 12:16:01 -0400
Content-Disposition: inline
In-Reply-To: <7vk3o7g29s.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/220996>

On Fri, Apr 12, 2013 at 09:08:31AM -0700, Junio C Hamano wrote:

> OK, then...

> -- >8 --
> Subject: [PATCH] doc: clarify that "git daemon --user=<user>" option does not export HOME=~user

I'd add this motiviation to the body of the commit message:

  The fact that we don't set $HOME may confuse admins who
  expect $HOME/.gitconfig to be respected. And worse, since
  96b9e0e3, a git-daemon started by root is likely to fail
  to run at all, as the user we switch to generally cannot
  read ~root.

This still feels ugly, like we are documenting some gotcha
that is going to hit most admins, when we could be helping
them in the code.

One option we have not explored is an environment variable
to loosen git's requirement. I'm thinking something like
GIT_INACCESSIBLE_HOMEDIR_OK, which could be set by default
when git-daemon uses --user.

That would leave all existing setups working, but would
still enable the extra protections for people not running
git-daemon (and people who use git via sudo could choose to
set it, too, if they would prefer that to setting up HOME).

-Peff
