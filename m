From: Jeff King <peff@peff.net>
Subject: Re: Stashing individual files
Date: Tue, 3 Jan 2012 14:06:12 -0500
Message-ID: <20120103190612.GC20926@sigill.intra.peff.net>
References: <CAJ6vYjduoBNrRcvcvQbX_yY-3-Qm5ZbXOM0WQpWRwC1H1OCqaA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Chris Leong <walkraft@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jan 03 20:06:21 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ri9gi-0002gB-Ln
	for gcvg-git-2@lo.gmane.org; Tue, 03 Jan 2012 20:06:21 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754729Ab2ACTGQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 3 Jan 2012 14:06:16 -0500
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:55503
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754680Ab2ACTGP (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 3 Jan 2012 14:06:15 -0500
Received: (qmail 8668 invoked by uid 107); 3 Jan 2012 19:13:05 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Tue, 03 Jan 2012 14:13:05 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 03 Jan 2012 14:06:12 -0500
Content-Disposition: inline
In-Reply-To: <CAJ6vYjduoBNrRcvcvQbX_yY-3-Qm5ZbXOM0WQpWRwC1H1OCqaA@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/187875>

On Tue, Jan 03, 2012 at 10:32:02AM +1100, Chris Leong wrote:

> Thanks for making such a wonderful product. I find the stash command
> really useful, but it doesn't work very well when I just need to
> temporarily revert one or two files. I know that there is the
> interactive command, but if you have modified a large number of files,
> then it takes quite a bit of effort. Is there any way I can define an
> alias, stashfiles, so that I can just type git stashfiles file1 file2?
> Also, please consider adding such a feature into a future version.

I have sometimes wanted this, too. One problem is that the arguments in
a "stash save" get sucked into the message. I really wish it were:

  git stash save [-m <msg>] [[--] <pathspec...>]

which would match other git commands. And related, it would be nice to
have:

  git stash foo.c bar.c

but that conflicts with our safety-valve to avoid accidentally stashing
when no command is given.

For now, we could probably do it like this:

  git stash save [<message>] [-- <pathspec...>]

IOW, make the "--" a requirement for specifying filenames. The only
regression is that "--" as a single argument can no longer be used in
stash messages. So this works now:

  git stash save working on foo -- needs bar

but would be interpreted under my proposal as stashing "needs" and "bar"
with the message "working on foo". You would instead have to spell it:

  git stash save "working on foo -- needs bar"

I think that would be OK compromise, though. I'd rather not introduce a
whole new "stashfiles" command (or even a new subcommand of stash) if we
can avoid it.

-Peff
