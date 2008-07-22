From: Jeff King <peff@peff.net>
Subject: Re: git status in clean working dir
Date: Tue, 22 Jul 2008 05:40:55 -0400
Message-ID: <20080722094054.GA5720@sigill.intra.peff.net>
References: <0ttzeirft8.wl%bremner@pivot.cs.unb.ca> <7vy73ur6pz.fsf@gitster.siamese.dyndns.org> <7vtzeir68z.fsf@gitster.siamese.dyndns.org> <20080722044157.GA20787@sigill.intra.peff.net> <20080722053921.GA4983@glandium.org> <20080722060643.GA25023@sigill.intra.peff.net> <20080722061807.GA6714@glandium.org> <20080722064603.GA25221@sigill.intra.peff.net> <20080722071009.GA3610@sigill.intra.peff.net> <7viquymg5k.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Mike Hommey <mh@glandium.org>, git@vger.kernel.org,
	David Bremner <bremner@unb.ca>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Jul 22 11:42:01 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KLENZ-0007CQ-1z
	for gcvg-git-2@gmane.org; Tue, 22 Jul 2008 11:41:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753041AbYGVJk5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 22 Jul 2008 05:40:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752984AbYGVJk5
	(ORCPT <rfc822;git-outgoing>); Tue, 22 Jul 2008 05:40:57 -0400
Received: from peff.net ([208.65.91.99]:4137 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752259AbYGVJk5 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 22 Jul 2008 05:40:57 -0400
Received: (qmail 4337 invoked by uid 111); 22 Jul 2008 09:40:55 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.32) with ESMTP; Tue, 22 Jul 2008 05:40:55 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 22 Jul 2008 05:40:55 -0400
Content-Disposition: inline
In-Reply-To: <7viquymg5k.fsf@gitster.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/89478>

On Tue, Jul 22, 2008 at 02:17:43AM -0700, Junio C Hamano wrote:

> Another slight worry I have is if the now-parent git process does the
> right thing when the user kills the pager without viewing the output to
> the end.  git itself will get stuck with write() while the user is
> reading, and then notice that the pipe does not have any more reader when
> the pager is killed.  This fact itself won't change by swapping the
> parent-child relationship, but would we get a sensible behaviour after
> that, or have we been ignoring what happens afterwards only because our
> exit status has been hidden behind the pager?  Running "git log" and
> killing it by "q" (my pager is "less") makes it exit with 141.

Hmm, good point. Though previously in this case, we were getting
whatever code the pager provided. Which means nobody probably cared that
much. Though I suppose that people who use "$?" in their prompt might
see scariness.

> I shouldn't worry, if everything is written correctly in the other parts
> of the system, this swap should not have much ill effect.

I am a little unhappy about the git process hanging around, but I don't
know if it is worth making a meta-process just to manage the pager.

Also, I think people with a pager that has spaces in in it will now need
to quote it (e.g., PAGER="/path with space/less" used to work, but now
is passed to the shell). Arguably, this brings it in line with other
spawned programs, like EDITOR, but it is a difference, and we are in
release freeze. That could be fixed with some magic in run_command.
(Note that it has always been run by the shell under Windows, so again,
this is making things more consistent).

> By the way [2/2] was not signed-off.  Just forgotten?

Yes, forgotten. If you are planning on applying, please forge (and
squash the portability fix).

-Peff
