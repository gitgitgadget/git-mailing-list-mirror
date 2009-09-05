From: =?iso-8859-1?Q?Bj=F6rn?= Steinbrink <B.Steinbrink@gmx.de>
Subject: Re: tracking branch for a rebase
Date: Sat, 5 Sep 2009 16:01:27 +0200
Message-ID: <20090905140127.GA29037@atjola.homenet>
References: <20090904135414.GA3728@honk.padd.com>
 <4AA124DD.1030208@drmicha.warpmail.net>
 <20090904181846.GC19093@coredump.intra.peff.net>
 <20090904185949.GA21583@atjola.homenet>
 <20090905061250.GA29863@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Michael J Gruber <git@drmicha.warpmail.net>,
	Pete Wyckoff <pw@padd.com>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Sat Sep 05 16:01:42 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Mjvpl-00007f-Ks
	for gcvg-git-2@lo.gmane.org; Sat, 05 Sep 2009 16:01:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751900AbZIEOBc convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 5 Sep 2009 10:01:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751795AbZIEOBb
	(ORCPT <rfc822;git-outgoing>); Sat, 5 Sep 2009 10:01:31 -0400
Received: from mail.gmx.net ([213.165.64.20]:46645 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751226AbZIEOBa (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 5 Sep 2009 10:01:30 -0400
Received: (qmail invoked by alias); 05 Sep 2009 14:01:31 -0000
Received: from i59F5744A.versanet.de (EHLO atjola.homenet) [89.245.116.74]
  by mail.gmx.net (mp025) with SMTP; 05 Sep 2009 16:01:31 +0200
X-Authenticated: #5039886
X-Provags-ID: V01U2FsdGVkX19b7fJ6liBbhetzTh5M6eDM3r3B50aSb1KLgmya9V
	b4zIATSn7Oa8L9
Content-Disposition: inline
In-Reply-To: <20090905061250.GA29863@coredump.intra.peff.net>
User-Agent: Mutt/1.5.20 (2009-06-14)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.6
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/127816>

On 2009.09.05 02:12:50 -0400, Jeff King wrote:
> On Fri, Sep 04, 2009 at 08:59:49PM +0200, Bj=F6rn Steinbrink wrote:
>=20
> > "git pull --rebase" is not the same as:
> > "git fetch origin && git rebase origin/foo", but:
> >=20
> > git fetch origin && git rebase --onto origin/foo $reflog_merge_base
> >=20
> > Where $reflog_merge_base is the first merge base is found between t=
he
> > current branch head, and the reflog entries for origin/foo.
>=20
> Thanks, I didn't know about the trick (not being, as I mentioned, a p=
ull
> --rebase user). I can see arguments for or against a rebase-default
> using that feature. On one hand, it simplifies the explanation for
> people going between "pull --rebase" and "fetch && rebase". And I thi=
nk
> it should generally Do What You Mean in the case that upstream hasn't
> rebased. Are there cases you know of where it will do the wrong thing=
?
>=20
> I don't know if people would be confused that "git rebase" does not
> exactly default to "git rebase $upstream", which is at least easy to
> explain.

=46or me, the confusion would arise from the fact that "git rebase"
(without args) would seem like a "pull --rebase" without the fetch, but
isn't. And to reducing the difference to just the fetch would require a
quite change in bahaviour.

Currently, when branch.<name>.merge is set:
"git rebase <upstream>" =3D=3D> Can't really be done with "pull --rebas=
e"
"git pull --rebase [...]" =3D=3D> Can't be done with "rebase" alone.

Currently, "pull" is a convenience thing, and thus may do more magic,
while "rebase" is dumb, and needs arguments. Starting to add _different=
_
magic to rebase seems wrong to me.

> And by automating the shorthand we reduce the chance of errors. For
> example, I usually base my topic branches from origin/master. But the
> other day I happened to be building a new branch, jk/date, off of
> lt/approxidate, salvaged from origin/pu. I did "git rebase -i
> origin/master" and accidentally rewrote the early part of
> lt/approxidate.

Hm, I'd prefer a shorthand for "upstream for this branch", instead of
magic defaults.

> > Now, basically "git svn rebase" is pretty much git-svn's "pull". Ma=
ybe
> > its idea could be taken, so we get "git pull --local" to just skip =
the
> > fetch part, but keep "git rebase" and "git merge" 'dumb', requiring
> > explicit arguments.
>=20
> That wouldn't help me, because you can't "pull -i". :)

I probably shouldn't tell anyone, as it's a crude hack, but "git pull
--rebase -s -i" does the trick... *hides*

Bj=F6rn
