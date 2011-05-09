From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] only warn about ambiguous refs if stderr is a tty
Date: Mon, 9 May 2011 08:49:31 -0400
Message-ID: <20110509124931.GA18197@sigill.intra.peff.net>
References: <BANLkTinLCirA4XP9AOb9piGo9ucMsmrmkQ@mail.gmail.com>
 <1304927478-3112-1-git-send-email-kusmabite@gmail.com>
 <20110509080315.GA6205@sigill.intra.peff.net>
 <BANLkTimR_S-px-MfRy0pKGrjxOgSC_=e=A@mail.gmail.com>
 <20110509103208.GA9060@sigill.intra.peff.net>
 <BANLkTimn7542tji-Uu5iH72HS9fcnaywvg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org, steveire@gmail.com,
	felipe.contreras@gmail.com, gitster@pobox.com
To: Erik Faye-Lund <kusmabite@gmail.com>
X-From: git-owner@vger.kernel.org Mon May 09 14:49:43 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QJPu9-0004ZM-Pa
	for gcvg-git-2@lo.gmane.org; Mon, 09 May 2011 14:49:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752870Ab1EIMte (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 9 May 2011 08:49:34 -0400
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:37035
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752142Ab1EIMtd (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 9 May 2011 08:49:33 -0400
Received: (qmail 8671 invoked by uid 107); 9 May 2011 12:51:29 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Mon, 09 May 2011 08:51:29 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 09 May 2011 08:49:31 -0400
Content-Disposition: inline
In-Reply-To: <BANLkTimn7542tji-Uu5iH72HS9fcnaywvg@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/173228>

On Mon, May 09, 2011 at 02:37:48PM +0200, Erik Faye-Lund wrote:

> Yeah, I understood that part. My point was that once the output is
> wanted for diagnostics, you probably also want verbose output. And
> warnings should probably always be output if we're verbose.

Ah, I see. I think my main concern is that the behavior you proposed
would simply be surprising to people used to normal unix conventions.
But it sounds like we both agree that isn't the right direction anyway.

> > Of course, because there is no refs/HEAD at all. I meant "if you have
> > ambiguity between $GIT_DIR/HEAD and $GIT_DIR/refs/HEAD", then saying
> > "refs/HEAD" should disambiguate already. In your example, there is no
> > ambiguity.
> 
> I meant that "refs/HEAD" could be an non-ambiguous alias for HEAD, but
> it's probably easier to just say that 'HEAD' isn't ambiguous. Your
> suggestion of only checking for ambiguousness on the same level is IMO
> an elegant way of doing this.

OK, I see what you meant. But "refs/HEAD" cannot be a shortcut for
"HEAD", as it means something totally different. You can have "HEAD",
"refs/HEAD", "refs/heads/HEAD" all co-existing.

> I agree. There could be a remote chance that you can get a branch
> called 'HEAD' from some foreign vcs or something, though. But I don't
> think it's very likely, and the problem will also go away if we go
> with your approach mentioned above.

Thinking on it more, I think warning is probably the only sane thing to
do there. Having a branch with that name is just going to be confusing
in the long run, and the sooner we start making the user aware of the
situation, the better.

> > I admit I haven't been following this
> > thread too closely. What is the reason not to tell the user "sorry, that
> > is an insane branch name. Accept the ambiguity warning, or choose a
> > different name"?
> 
> I think having the ambiguity warning in itself isn't the problem, it's
> gitk not swallowing it that is.

Agreed.

> The reporter also had some problems pushing with a branch named 'HEAD'
> in his repo, but I didn't look into that part at all.

I expect that would be a separate issue entirely (if it were fetching, I
wouldn't be surprised if it was the "fake" refs/remotes/*/HEAD symref we
create getting in the way).

-Peff
