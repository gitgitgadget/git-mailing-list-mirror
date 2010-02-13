From: Ron Garret <ron1@flownet.com>
Subject: Re: Individual file snapshots
Date: Fri, 12 Feb 2010 23:01:36 -0800
Organization: Amalgamated Widgets
Message-ID: <ron1-90D6E1.23013612022010@news.gmane.org>
References: <ron1-CD3223.04030512022010@news.gmane.org> <4B75BD06.1010802@lsrfire.ath.cx> <ron1-519083.13253112022010@news.gmane.org> <12B5BDAB-DD9C-4CED-9489-0773BF577DF3@silverinsanity.com> <ron1-62D136.13570812022010@news.gmane.org> <C022F034-F60E-4E89-A174-DC0F53ADEC19@silverinsanity.com> <ron1-5EFFD7.14390512022010@news.gmane.org> <ca433831002121633j5b96049bs71e539c96397aff4@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Feb 13 08:02:10 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NgC13-0002XP-Of
	for gcvg-git-2@lo.gmane.org; Sat, 13 Feb 2010 08:02:10 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751722Ab0BMHCA convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 13 Feb 2010 02:02:00 -0500
Received: from lo.gmane.org ([80.91.229.12]:44313 "EHLO lo.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751673Ab0BMHB7 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 13 Feb 2010 02:01:59 -0500
Received: from list by lo.gmane.org with local (Exim 4.69)
	(envelope-from <gcvg-git-2@m.gmane.org>)
	id 1NgC0s-0002T9-FW
	for git@vger.kernel.org; Sat, 13 Feb 2010 08:01:58 +0100
Received: from 68-190-211-184.dhcp.gldl.ca.charter.com ([68.190.211.184])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sat, 13 Feb 2010 08:01:58 +0100
Received: from ron1 by 68-190-211-184.dhcp.gldl.ca.charter.com with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sat, 13 Feb 2010 08:01:58 +0100
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: 68-190-211-184.dhcp.gldl.ca.charter.com
User-Agent: MT-NewsWatcher/3.5.1 (Intel Mac OS X)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/139777>

In article=20
<ca433831002121633j5b96049bs71e539c96397aff4@mail.gmail.com>,
 Mark Lodato <lodatom@gmail.com> wrote:

> Ron, I also could use a feature like this.  Sometimes I just have som=
e
> code that I don't want to just throw away, but it really doesn't go i=
n
> the history.  I usually just create a file called "junk" and add it t=
o
> .git/info/excludes, but I'd rather have it stored in git.
>=20
> On Fri, Feb 12, 2010 at 5:39 PM, Ron Garret <ron1@flownet.com> wrote:
> > Yes, I think the right answer is going to be something like this:
> >
> > git symbolic-ref HEAD refs/heads/snapshots
> > git rm --cached -r .
> > git commit --allow-empty -m 'Snapshot branch'
> >
> > Then, to take a snapshot:
> >
> > git branch snapshot
> > git checkout master -- path
> > git add path
> > git commit -a -m 'Snapshot of [path]'
> > git checkout master
> >
> > (All of that will be in a script of course.)
> >
> > And to rollback:
> >
> > git checkout snapshot-[n] -- path
> >
> > Or something like that. =C2=A0I haven't actually tried this yet, bu=
t it seems
> > like it ought to work.
>=20
> I took your idea and ran with it.  In my version, I don't bother
> switching branches and instead use plumbing commands to get the job
> done.  (This prevents issues if there's a conflict from the old
> commit.)  Also, I record HEAD as an additional parent of the commit,
> so I can see where the commit came from.
>=20
> I uploaded it as a Github Gist with a bunch of comments.  (It's much
> nicer to read it with syntax highlighting.)  You may be able to modif=
y
> this to suit your needs.  In particular, if you'd prefer it not to be
> a real branch, you could change $BRANCH to /refs/snapshots/foo or
> something like that to hide it.
>=20
> http://gist.github.com/303142
>=20
> The basic steps are:
>=20
> backup .git/index
> git add -a
> git write-tree
> git commit-tree
> restore .git/index
>=20
> I don't know much about git's plumbing commands, so I'd be interested
> in hearing from git experts to see if what I'm doing is a good idea.

Moving the index around seems kinda hacky.  You probably want git-mktre=
e.

rg
