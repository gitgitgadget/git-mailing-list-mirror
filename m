From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 2/2] config: treat user and xdg config permission
 problems as errors
Date: Sun, 14 Oct 2012 02:22:18 -0400
Message-ID: <20121014062218.GB13477@sigill.intra.peff.net>
References: <20121014000210.GA19094@elie.Belkin>
 <20121014000402.GB11399@elie.Belkin>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Sun Oct 14 08:22:33 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TNHar-0003FT-Gn
	for gcvg-git-2@plane.gmane.org; Sun, 14 Oct 2012 08:22:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751096Ab2JNGWU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 14 Oct 2012 02:22:20 -0400
Received: from 75-15-5-89.uvs.iplsin.sbcglobal.net ([75.15.5.89]:51963 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750898Ab2JNGWU (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 14 Oct 2012 02:22:20 -0400
Received: (qmail 18483 invoked by uid 107); 14 Oct 2012 06:22:55 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Sun, 14 Oct 2012 02:22:55 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sun, 14 Oct 2012 02:22:18 -0400
Content-Disposition: inline
In-Reply-To: <20121014000402.GB11399@elie.Belkin>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/207640>

On Sat, Oct 13, 2012 at 05:04:02PM -0700, Jonathan Nieder wrote:

> Better to error out and ask the user to correct the problem.
> 
> This only affects the user and xdg config files, since the user
> presumably has enough access to fix their permissions.  If the system
> config file is unreadable, the best we can do is to warn about it so
> the user knows to notify someone and get on with work in the meantime.

I'm on the fence about treating the systme config specially. On the one
hand, I see the convenience if somebody has a bogus /etc/gitconfig and
gets EPERM but can't fix it. On the other hand, if we get EIO, isn't
that a good indication that we would want to die?

For example, servers may depend on /etc/gitconfig to enforce security
policy (e.g., setting transfer.fsckObjects or receive.deny*). Perhaps
our default should be safe, and people can use GIT_CONFIG_NOSYSTEM to
work around a broken machine.

-Peff
