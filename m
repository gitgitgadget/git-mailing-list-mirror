From: Jeff King <peff@peff.net>
Subject: Re: What's cooking in git.git (Dec 2011, #02; Mon, 5)
Date: Tue, 6 Dec 2011 13:47:26 -0500
Message-ID: <20111206184726.GA9492@sigill.intra.peff.net>
References: <7v8vmqi98f.fsf@alter.siamese.dyndns.org>
 <20111206055239.GA20671@sigill.intra.peff.net>
 <7vhb1dh7ki.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Erik Faye-Lund <kusmabite@gmail.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Dec 06 19:47:37 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RY03D-0000vh-Jl
	for gcvg-git-2@lo.gmane.org; Tue, 06 Dec 2011 19:47:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753230Ab1LFSra (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 6 Dec 2011 13:47:30 -0500
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:41431
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751553Ab1LFSr3 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 6 Dec 2011 13:47:29 -0500
Received: (qmail 7015 invoked by uid 107); 6 Dec 2011 18:54:07 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Tue, 06 Dec 2011 13:54:07 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 06 Dec 2011 13:47:26 -0500
Content-Disposition: inline
In-Reply-To: <7vhb1dh7ki.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/186367>

On Tue, Dec 06, 2011 at 10:35:25AM -0800, Junio C Hamano wrote:

> > Also, let's drop the top git_getpass bits from the topic for now (they
> > will not be part of my rebase). They are a separate topic that can go on
> > top, but I think there was some question from Erik of whether we should
> > simply roll our own getpass().
> 
> Sounds sensible.
> 
> I suspect that there may be a codepath where we could ask both username
> and password; instead of making two consecutive calls to getpass() or
> git_prompt(), the series may want to give a higher level abstraction, so
> that GUI can show a dialog with two input fields (single-line input and
> password input) and interact only once with the user. Such an input widget
> could _show_ the username, and optionally even let it edited (there may be
> ramifications depending on how the codepath uses the username), while
> asking for the corresponding password.

Yes, I've considered that, too. But I think the idea of a combined
username/password is part of the credential code, and the right
call chain is something like:

  credential_fill
    -> call helpers with "get"; return if it works
    -> credential_getpass
       -> call helpers with "ask" for combined GUI prompt
       -> otherwise, use git_prompt
          -> git_prompt("username")
          -> git_prompt("password")

So the "switch getpass to a generic prompt" idea is separate from
providing that higher-level abstraction.

> >> * jk/maint-1.6.2-upload-archive (2011-11-21) 1 commit
> >>  - archive: don't let remote clients get unreachable commits
> >>  (this branch is used by jk/maint-upload-archive.)
> [...]
> I was planning to first have the really tight version graduate to 'master'
> and ship it in 1.7.9, while possibly merging that to 1.7.8.X series. If we
> hear complaints from real users in the meantime before or after such
> releases, we could apply loosening patch on top of these topics and call
> them "regression fix", but I have been assuming that nobody would have
> been using this backdoor for anything that really matters.

OK. I'll hold back on the loosening then.

-Peff
