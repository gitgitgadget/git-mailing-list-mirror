From: =?iso-8859-1?Q?Bj=F6rn?= Steinbrink <B.Steinbrink@gmx.de>
Subject: Re: Commited to wrong branch
Date: Tue, 15 Sep 2009 13:19:22 +0200
Message-ID: <20090915111922.GB31846@atjola.homenet>
References: <26ae428a0909150331q391ed39ak622902d175b46d84@mail.gmail.com>
 <46a038f90909150355h20b39c71w4af7e2be2920fdbb@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Howard Miller <howard@e-learndesign.co.uk>, git@vger.kernel.org
To: Martin Langhoff <martin.langhoff@gmail.com>
X-From: git-owner@vger.kernel.org Tue Sep 15 13:20:06 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MnW4r-0003Wz-7z
	for gcvg-git-2@lo.gmane.org; Tue, 15 Sep 2009 13:20:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753006AbZIOLTY convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 15 Sep 2009 07:19:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752950AbZIOLTY
	(ORCPT <rfc822;git-outgoing>); Tue, 15 Sep 2009 07:19:24 -0400
Received: from mail.gmx.net ([213.165.64.20]:43859 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752901AbZIOLTX (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 15 Sep 2009 07:19:23 -0400
Received: (qmail invoked by alias); 15 Sep 2009 11:19:25 -0000
Received: from i59F56716.versanet.de (EHLO atjola.homenet) [89.245.103.22]
  by mail.gmx.net (mp046) with SMTP; 15 Sep 2009 13:19:25 +0200
X-Authenticated: #5039886
X-Provags-ID: V01U2FsdGVkX18pD2N4APcph6DNDoXjVW2p75hk+QT8c+A0fmgfMG
	qbakIZQvTtKyz9
Content-Disposition: inline
In-Reply-To: <46a038f90909150355h20b39c71w4af7e2be2920fdbb@mail.gmail.com>
User-Agent: Mutt/1.5.20 (2009-06-14)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.5
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/128529>

On 2009.09.15 12:55:58 +0200, Martin Langhoff wrote:
> On Tue, Sep 15, 2009 at 12:31 PM, Howard Miller
> <howard@e-learndesign.co.uk> wrote:
> > I am resurrecting a discussion from a week or two back (been on
> > holiday). =A0As follows...
> >
> > I had made some changes to some files and then done a commit. Only
> > then did I realise that I had the wrong branch checked out. To make
> > matters worse I then did a 'git reset HEAD^' which means that I can
> > now no longer switch branches. I am stuck. I had some advice (thank=
s!)
> > but it was not complete. I'd appreciate some more help.
>=20
> Hi Howard,
>=20
> just to make sure I understand your issue
>=20
>   1 - you were on branch X, thinking your were on branch Y
>   2 - edit, diff, commit, realised the mistake
>   3 - git reset HEAD^
>=20
> so if you now run `git status` and `git diff` it will show your
> changes as if they were uncommitted and unstaged.

Not "as if", they are.

> (Before you start with various attempts to recover below, a great
> trick is to make an instant-backup in case things go wrong: cd .. / ;
> cp -pr moodle.git moodle-backup.git ; cd moodle.git )
>=20
> You can now try do do
>=20
>   4 - git checkout Y
>=20
> and if the changes are on files that don't change between X and Y,
> then git will change the branches and keep your changes there. If the
> files are different between X and Y, it won't work.

Well, then you could use "git checkout -m Y", to have git try a
three-way merge (which might of course leave conflicts).

> What I can recommend is to save your patch, as follows
>=20
>   5 - git diff > tempchanges.patch
>   6 - git reset --hard # this will discard your changes, careful
>   7 - git checkout Y
>   8 - patch -p1 < tempchanges.patch
>=20
> The patch may not apply cleanly :-) -- note that patch is more
> tolerant of iffy merges than git's internal implementation ("git
> apply") -- so it will succeed more often... but the results need
> review.

But a lot worse than the usual 3-way merge stuff, like "checkout -m" or
"stash apply". The advantage of "stash" + "stash apply" is that, in cas=
e
of conflicts, you can easily retry to fix them over and over again,
while with "checkout -m", you can't easily start over AFAIK.

> There is a more git-style approach that is to use git-stash -- it use=
s
> git-apply and may not do what you want.

Only "stash apply --index" uses "git apply", and only to re-apply the
staged changes. The changes for the working tree are applied using a
3way merge.

Bj=F6rn
