From: Jeff King <peff@peff.net>
Subject: Re: tracking branch for a rebase
Date: Sat, 5 Sep 2009 02:12:50 -0400
Message-ID: <20090905061250.GA29863@coredump.intra.peff.net>
References: <20090904135414.GA3728@honk.padd.com>
 <4AA124DD.1030208@drmicha.warpmail.net>
 <20090904181846.GC19093@coredump.intra.peff.net>
 <20090904185949.GA21583@atjola.homenet>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Michael J Gruber <git@drmicha.warpmail.net>,
	Pete Wyckoff <pw@padd.com>, git@vger.kernel.org
To: =?utf-8?B?QmrDtnJu?= Steinbrink <B.Steinbrink@gmx.de>
X-From: git-owner@vger.kernel.org Sat Sep 05 08:13:01 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MjoWD-000718-3o
	for gcvg-git-2@lo.gmane.org; Sat, 05 Sep 2009 08:13:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751225AbZIEGMw convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 5 Sep 2009 02:12:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751089AbZIEGMv
	(ORCPT <rfc822;git-outgoing>); Sat, 5 Sep 2009 02:12:51 -0400
Received: from peff.net ([208.65.91.99]:58088 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751088AbZIEGMu (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 5 Sep 2009 02:12:50 -0400
Received: (qmail 25083 invoked by uid 107); 5 Sep 2009 06:13:06 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Sat, 05 Sep 2009 02:13:06 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Sat, 05 Sep 2009 02:12:50 -0400
Content-Disposition: inline
In-Reply-To: <20090904185949.GA21583@atjola.homenet>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/127778>

On Fri, Sep 04, 2009 at 08:59:49PM +0200, Bj=C3=B6rn Steinbrink wrote:

> "git pull --rebase" is not the same as:
> "git fetch origin && git rebase origin/foo", but:
>=20
> git fetch origin && git rebase --onto origin/foo $reflog_merge_base
>=20
> Where $reflog_merge_base is the first merge base is found between the
> current branch head, and the reflog entries for origin/foo.

Thanks, I didn't know about the trick (not being, as I mentioned, a pul=
l
--rebase user). I can see arguments for or against a rebase-default
using that feature. On one hand, it simplifies the explanation for
people going between "pull --rebase" and "fetch && rebase". And I think
it should generally Do What You Mean in the case that upstream hasn't
rebased. Are there cases you know of where it will do the wrong thing?

I don't know if people would be confused that "git rebase" does not
exactly default to "git rebase $upstream", which is at least easy to
explain.

> > The biggest question is whether it should respect branch.*.merge, o=
r
> > just branch.*.rebase (I never use the latter simply because I never=
 use
> > "git pull", but I think it is probably reasonable to restrict it to
> > cases where you said you are interested in rebasing in general).
>=20
> Hm, you'll probably want "git merge" to pickup the default as well th=
en,
> right? And that should only do so if branch.*.rebase is not set. So
> effectively, you still have to use the right command, but can skip th=
e
> argument. Having to deal a lot with git-svn, I also regulary use its
> "git svn rebase --local", which means "just rebase, don't fetch".

I hadn't considered whether "git merge" should get a default. To be
honest, my intended use case was not really to replace pull, but as a
shorthand for running "git rebase -i". Upstream has the published
commits, so it is a nice shortcut to say "let me munge all of the
commits that I haven't published yet".

Of course the "published" status of those commits is not guaranteed
(they might have been published in another branch, your
tracking refs might not be up to date, etc) but I think it's a good rul=
e
of thumb.

And by automating the shorthand we reduce the chance of errors. For
example, I usually base my topic branches from origin/master. But the
other day I happened to be building a new branch, jk/date, off of
lt/approxidate, salvaged from origin/pu. I did "git rebase -i
origin/master" and accidentally rewrote the early part of
lt/approxidate.

> Now, basically "git svn rebase" is pretty much git-svn's "pull". Mayb=
e
> its idea could be taken, so we get "git pull --local" to just skip th=
e
> fetch part, but keep "git rebase" and "git merge" 'dumb', requiring
> explicit arguments.

That wouldn't help me, because you can't "pull -i". :)

-Peff
