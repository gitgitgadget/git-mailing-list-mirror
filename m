From: Jeff King <peff@peff.net>
Subject: Re: Proposal: branch.<name>.remotepush
Date: Fri, 8 Feb 2013 01:28:56 -0500
Message-ID: <20130208062855.GA12271@sigill.intra.peff.net>
References: <CALkWK0nA4hQ0VWivk3AVVVq8Rbb-9CpQ9xFsSOsTQtvo4w08rw@mail.gmail.com>
 <20130208044836.GC4157@sigill.intra.peff.net>
 <7vliaz49sf.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Ramkumar Ramachandra <artagnon@gmail.com>,
	Git List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Feb 08 07:29:23 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U3hSb-0004bC-9F
	for gcvg-git-2@plane.gmane.org; Fri, 08 Feb 2013 07:29:21 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1945995Ab3BHG26 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 8 Feb 2013 01:28:58 -0500
Received: from 75-15-5-89.uvs.iplsin.sbcglobal.net ([75.15.5.89]:39154 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753107Ab3BHG26 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 8 Feb 2013 01:28:58 -0500
Received: (qmail 26680 invoked by uid 107); 8 Feb 2013 06:30:24 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Fri, 08 Feb 2013 01:30:24 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 08 Feb 2013 01:28:56 -0500
Content-Disposition: inline
In-Reply-To: <7vliaz49sf.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/215761>

On Thu, Feb 07, 2013 at 10:08:48PM -0800, Junio C Hamano wrote:

> How best to express the triangle is somewhat tricky, but I think it
> is sensible to say you have "origin" that points to your upstream
> (i.e. me), and "peff" that points to your publishing point, in other
> words, make it explicit that the user deals with two remotes.  Then
> have push.default name the remote "peff", so that "git push" goes to
> that remote by default (and have "git fetch/pull" go to "origin).
> You will have two sets of remote tracking branches (one from "origin"
> that your push will never pretend to have fetched immediately after
> finishing, the other from "peff" that keeps track of what you pushed
> the last time).

Exactly. That is what I have set up now, except that I have to type "git
push peff" because there is no such push.default (with the minor nit
that push.default does something else, so the config should be called
remote.pushDefault or something). The entirety of the feature would be
saving the user from the annoyance of:

  $ git push
  fatal: remote error:
    You can't push to git://github.com/gitster/git.git
    Use git@github.com:gitster/git.git

  [doh! Stupid git, why don't you do what I mean, not what I say?]
  $ git push peff
  ... it works ...

> Of course, some people may have "I use this and that branches to
> interact with upstream X while I use these other branches to
> interacct with upstream Y, and all of them push to different
> places", and supporting that may need complex per branch "On this
> branch fetch from and integrate with remote X, and push to remote Z"
> settings, but as you said, "I fetch from and integrate with X, and
> result is pushed out to Y" should be the most common, and it would
> be desirable to have a simple way to express it with just a single
> new configuration variable.

Right. Frankly, I do not care that much about the per-branch push remote
myself. In the rules I gave earlier, that was my complete
backwards-compatible vision, so that we do not paint ourselves into a
corner compatibility-wise when somebody wants it later. Just
implementing the default push remote part would be a fine first step.

I also indicated in my rules that we could have a branch.*.fetchRemote,
as well, but I do not think it is strictly necessary. I think the
non-specific branch.*.remote could continue to be used for fetching, and
as a backup when the push-specific variables are not set.

> *1* It also happens to work reasonably well for people like Linus
> and I with the "I pull from random places, I locally integrate and I
> publish the results" workflow, because we are trained to think that
> it is not just being lazy but simply meaningless to say "git pull"
> without saying "fetch and integrate _what_ and from _whom_", and
> that is only because we do not have a fixed upstream.  Linus and I
> would practically never fetch from "origin", i.e. from ourselves.

Right, I think "git pull" is more useful in a centralized repo setting
where there is one branch and one repo, so there is no "what and whom"
to specify. Personally I do not use it much at all, as I do a separate
fetch, inspect, and merge, but that is somewhat orthogonal to your
reasons. :)

-Peff
