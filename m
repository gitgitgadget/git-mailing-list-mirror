From: Jeff King <peff@peff.net>
Subject: Re: Rebase & Trailing Whitespace
Date: Wed, 31 Aug 2011 22:31:27 -0400
Message-ID: <20110901023127.GB31838@sigill.intra.peff.net>
References: <CAE1pOi0rY4kRR4rvEdFhzzTgfhUczHMX=H5_9+o5aHnv4vTadw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Git Users <git@vger.kernel.org>
To: Hilco Wijbenga <hilco.wijbenga@gmail.com>
X-From: git-owner@vger.kernel.org Thu Sep 01 04:31:38 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Qyx46-0002pT-Ex
	for gcvg-git-2@lo.gmane.org; Thu, 01 Sep 2011 04:31:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757458Ab1IACbb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 31 Aug 2011 22:31:31 -0400
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:43541
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757388Ab1IACba (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 31 Aug 2011 22:31:30 -0400
Received: (qmail 9643 invoked by uid 107); 1 Sep 2011 02:32:15 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Wed, 31 Aug 2011 22:32:15 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 31 Aug 2011 22:31:27 -0400
Content-Disposition: inline
In-Reply-To: <CAE1pOi0rY4kRR4rvEdFhzzTgfhUczHMX=H5_9+o5aHnv4vTadw@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/180516>

On Wed, Aug 31, 2011 at 04:55:03PM -0700, Hilco Wijbenga wrote:

> hilco@centaur ~/workspaces/project-next project-next (next $)$ git rebase master
> [...]
> <stdin>:721810: trailing whitespace.
> [...]
> Note the trailing whitespace warnings. How do I find out which file(s)
> generated these warnings? Would it be possible to add the file name
> causing the warnings to be output? By default? (Using --verbose
> doesn't seem to make any difference where the whitespace warnings are
> concerned.)

You can see any whitespace warnings in your repository (and in which
commit they were introduced) by doing something like:

  git log --oneline --check

The "--check" option is just another diff output format, so you use it
with "log" or "diff". For example, if you want to see just whitespace
problems that still exist in your current tree, you can diff against the
empty tree with --check, like:

  git diff --check 4b825dc642cb6eb9a060e54bf8d69288fbee4904

where "4b825dc..." is the well-known sha1 of an empty tree[1].

> Furthermore, why didn't I get these or similar warnings when I
> committed/pushed that particular commit ("Use static WAR for SWF files
> and assets.")? I did just find "[core] whitespace = trailing-space"
> which I will add to my .gitconfig, I suppose. So I guess what I really
> mean to ask is, why do rebase (and merge?) behave differently from
> commit?

Because these warnings are only triggered by default when applying
patches. And the idea of rebase is to apply patches from one place to
another. I thought we squelched whitespace warnings for rebase these
days (since they are somewhat pointless; you are moving around your own
commits, not applying commits from some other contributor), but maybe I
am misremembering. Or maybe you have an older version of git. Which
version are you using?

If you want to enforce whitespace checks during commit or push, you can
do so with a hook. The sample "pre-commit" hook, for example, uses "diff
--check" for just this purpose. See "git help hooks" for more
information.

-Peff

[1] If you don't remember the empty tree sha1, you can always derive it
    with:

        git hash-object -t tree /dev/null
