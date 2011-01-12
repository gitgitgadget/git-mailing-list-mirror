From: Jeff King <peff@peff.net>
Subject: Re: Git Rebase blows away GIT_AUTHOR_NAME
Date: Wed, 12 Jan 2011 13:21:50 -0500
Message-ID: <20110112182150.GC31747@sigill.intra.peff.net>
References: <AANLkTinMX0yEPvSc-c=96R42SbFZTjW5Mnveuxk3ZHS=@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: JT Olds <jtolds@xnet5.com>
X-From: git-owner@vger.kernel.org Wed Jan 12 19:22:17 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Pd5Kq-0004S9-QR
	for gcvg-git-2@lo.gmane.org; Wed, 12 Jan 2011 19:22:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755695Ab1ALSVy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 12 Jan 2011 13:21:54 -0500
Received: from xen6.gtisc.gatech.edu ([143.215.130.70]:58750 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754957Ab1ALSVx (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 12 Jan 2011 13:21:53 -0500
Received: (qmail 22910 invoked by uid 111); 12 Jan 2011 18:21:52 -0000
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net (HELO sigill.intra.peff.net) (99.108.226.0)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.40) with ESMTPA; Wed, 12 Jan 2011 18:21:52 +0000
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 12 Jan 2011 13:21:50 -0500
Content-Disposition: inline
In-Reply-To: <AANLkTinMX0yEPvSc-c=96R42SbFZTjW5Mnveuxk3ZHS=@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/165024>

On Wed, Jan 12, 2011 at 09:15:41AM -0700, JT Olds wrote:

> On every fresh install of Ubuntu that I have used (by default, I use
> ecryptfs for my home directory, which of course has its own set of
> silly Git errors right now), when I clone from a remote repository,
> have changes local to me, and changes on the remote repository, do
> 'git pull --rebase', occasionally my GIT_AUTHOR_NAME gets set to my
> GIT_AUTHOR_EMAIL on my changes that get applied on top of the remote
> changes.

Weird. I have never heard of anything like it.

Some things off the top of my head: Does your GIT_AUTHOR_NAME or
GIT_AUTHOR_EMAIL contain any odd characters that might confuse a parser?
Do you do anything special with setting up those environment variables
in your shell (e.g., in a .bashrc or .profile; those files _shouldn't_
be read by a non-interactive shell, but it's something to investigate)?
For that matter, how do you set up your identity in general (by
environment, or in ~/.gitconfig, or a local .git/config in each repo),
and what does it contain?

Can you try running this in a repo that's giving you problems:

  . git-sh-setup
  git log --format=%H --author=your.name |
  while read rev; do
    get_author_ident_from_commit $rev
    git format-patch -1 --stdout $rev |
      git mailinfo /dev/null /dev/null
  done | less

and check that the output looks sane? I want to make sure there's
nothing in your commits that is confusing our parser.

If that doesn't turn up anything, I think the next thing to try would be
making a script that reproduces the problem for you, and see if I can
reproduce it here.

-Peff
