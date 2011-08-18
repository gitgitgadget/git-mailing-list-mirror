From: Jeff King <peff@peff.net>
Subject: Re: [PATCH RFC] gitk: Allow commit editing
Date: Thu, 18 Aug 2011 15:33:47 -0700
Message-ID: <20110818223346.GA8481@sigill.intra.peff.net>
References: <1313610971-1741-1-git-send-email-sojka@os.inf.tu-dresden.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org, paulus@samba.org
To: Michal Sojka <sojka@os.inf.tu-dresden.de>
X-From: git-owner@vger.kernel.org Fri Aug 19 00:33:56 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QuB9v-0007Eh-9G
	for gcvg-git-2@lo.gmane.org; Fri, 19 Aug 2011 00:33:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755076Ab1HRWdu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 18 Aug 2011 18:33:50 -0400
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:36400
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754985Ab1HRWdu (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 18 Aug 2011 18:33:50 -0400
Received: (qmail 26263 invoked by uid 107); 18 Aug 2011 22:34:30 -0000
Received: from 173-164-171-125-SFBA.hfc.comcastbusiness.net (HELO sigill.intra.peff.net) (173.164.171.125)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Thu, 18 Aug 2011 18:34:30 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 18 Aug 2011 15:33:47 -0700
Content-Disposition: inline
In-Reply-To: <1313610971-1741-1-git-send-email-sojka@os.inf.tu-dresden.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/179647>

On Wed, Aug 17, 2011 at 09:56:11PM +0200, Michal Sojka wrote:

> Hi, this is a proof of concept patch that allows editing of commits
> from gitk. I often review patches before pushing in gitk and if I
> would like to have an easy way of fixing typos in commit messages etc.
> 
> So the patch adds "Edit this commit" item to gitk's context menu and
> the actual editing is done by non-interactively invoking interactive
> rebase :-) and git gui.

Invoking rebase behind the scenes makes me very nervous. In particular:

  1. There is nothing to indicate to the user that they are rewriting a
     string of commits, which is going to wreak havoc if any of the
     commits have been published elsewhere (either pushed somewhere, or
     even present in another local branch). I.e., rebasing generally
     needs to be a conscious decision of the user.

     Yes, a veteran user who thinks about it will realize there is no
     way to edit an old commit without rebasing, but I suspect relying
     on that is not enough. There should probably be a prominent
     warning at least the first time somebody uses this feature.

  2. Even if you accept the hazard of rewriting commits, you don't pass
     "-p" to rebase. So it will linearize your history. I don't know how
     robust "-p" is these days, and if it's up to the challenge of
     people using it to rebase potentially large segments of complex
     history.

So I think your idea is sane, and if you use it appropriately (by
editing commits in recent-ish linear stretches of history) your patch
works fine. But I really worry that it is going to be a problem for less
clueful users to stumble across in the menu.

-Peff
