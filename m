From: Johan Herland <johan@herland.net>
Subject: Re: git-svn: Use prefix by default?
Date: Tue, 1 Oct 2013 00:39:16 +0200
Message-ID: <CALKQrgeXAtWeTedqkVtcTAUgbsBA9U6rbqUntu_ArmPgL9R3pg@mail.gmail.com>
References: <CAEcj5uVRcXF+XADFvy_q2mbQOdWPZkz57q1vePOqroMbQw4+HA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: "git@vger.kernel.org" <git@vger.kernel.org>
To: Thomas Ferris Nicolaisen <tfnico@gmail.com>
X-From: git-owner@vger.kernel.org Tue Oct 01 00:39:37 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VQm7r-00021B-QO
	for gcvg-git-2@plane.gmane.org; Tue, 01 Oct 2013 00:39:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754816Ab3I3WjY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 30 Sep 2013 18:39:24 -0400
Received: from mail12.copyleft.no ([188.94.218.224]:57790 "EHLO
	mail12.copyleft.no" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754561Ab3I3WjX (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 30 Sep 2013 18:39:23 -0400
Received: from locusts.copyleft.no ([188.94.218.116] helo=mail.mailgateway.no)
	by mail12.copyleft.no with esmtp (Exim 4.76)
	(envelope-from <johan@herland.net>)
	id 1VQm7c-0003QT-RE
	for git@vger.kernel.org; Tue, 01 Oct 2013 00:39:20 +0200
Received: from mail-pd0-f179.google.com ([209.85.192.179])
	by mail.mailgateway.no with esmtpsa (TLSv1:RC4-SHA:128)
	(Exim 4.72 (FreeBSD))
	(envelope-from <johan@herland.net>)
	id 1VQm7c-000BNx-Ei
	for git@vger.kernel.org; Tue, 01 Oct 2013 00:39:20 +0200
Received: by mail-pd0-f179.google.com with SMTP id v10so6323476pde.10
        for <git@vger.kernel.org>; Mon, 30 Sep 2013 15:39:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=VZ7Cm3SLRtQRgotnuB+ZUiRTeKkSj9E79QhqiqMYj00=;
        b=I3qFeafIw8dqW0r4lfZfNvpEZOJP4DmBhcNoVqf2rQhZbEe58ic1U2q23ikDqmBF7l
         tbBnev066INpgF/EUEvgVjKLjr5zlNs3L741oEAjqn2vFFO2pDDadhIZD7i8phReU/Zw
         sh+OESPXpm3OSD3Q6pG/LApWP/GOTHtmt72DbXvGCNrymlQteLUUxHYCyHejwGlgf9bz
         0uyPFR+RUz8Ez3vWLRnvGckiJ+QO/7GT+Ra4Lwvx9ikK7KU/bLBicmzQ0Fp08CX3fJqr
         ZxbZOooOWWxEnwU93nhP4z3S8gyCp09sLYYJLX2ieS7Lk6HG0bohaWfxzb0XbEOot5JR
         jX6Q==
X-Received: by 10.68.137.161 with SMTP id qj1mr26182589pbb.50.1380580756536;
 Mon, 30 Sep 2013 15:39:16 -0700 (PDT)
Received: by 10.70.24.226 with HTTP; Mon, 30 Sep 2013 15:39:16 -0700 (PDT)
In-Reply-To: <CAEcj5uVRcXF+XADFvy_q2mbQOdWPZkz57q1vePOqroMbQw4+HA@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/235632>

On Thu, Aug 22, 2013 at 11:02 AM, Thomas Ferris Nicolaisen
<tfnico@gmail.com> wrote:
> I've recently been forced back into using git-svn, and while I was at
> it, I noticed that git-svn generally behaves a lot better when it is
> initialized using the --prefix option.

Thanks for raising this issue. Although I'm not using git-svn myself,
I have been aware of how git-svn pollutes the refs/remote/* namespace
for a while. In addition to being messy, it causes potential problems
for the remote ref namespaces being discussed in other threads.
The issue is even recognized by the git-svn author (see e.g.
http://www.mail-archive.com/git@vger.kernel.org/msg26248.html ).

I have some bad news, and some good news for you. Read on...

> For example, I make a standard-layout svn clone:
>
> $ git svn clone -s https://svn.company.com/repos/project-foo/
>
> .. and end up with this .gitconfig:
>
> [svn-remote "svn"]
>         url = https://svn.company.com/repos/
>         fetch = project-foo/trunk:refs/remotes/trunk
>         branches = project-foo/branches/*:refs/remotes/*
>         tags = project-foo/tags/*:refs/remotes/tags/*
>
> And my remote branches looks like this:
>     remotes/trunk
>     remotes/feat-bar
>
> Now, let's say I want to work on the feat-bar branch, so I attempt to
> create a tracking branch by the same name:
>
> $ git checkout feat-bar  # will detach head
> $ git checkout remotes/feat-bar  # will detach head
> $ git checkout -t remotes/feat-bar # fatal: Missing branch name; try -b
> $ git checkout -tb remotes/feat-bar # Branch remotes/feat-bar set up
> to track local branch master.
>
> Well, that's not what I wanted.. So I end up doing it the good
> old-fashioned way:
>
> $ git checkout -tb feat-bar remotes/feat-bar # works

The bad news is that the upstream relationship you're trying to create
between your local feat-bar and git-svn's remotes/feat-bar is not a
valid upstream relationship.

An upstream relationship in Git is encoded in the branch.foo.remote and
branch.foo.merge configuration variables. These specify the name of the
upstream remote, and which branch at that remote to pull from,
respectively. However, in your case, there is no git remote associated
with refs/remotes/feat-bar (nor with refs/remotes/mirror/feat-bar which
you create below), and hence there is no valid remote name to assign to
branch.feat-bar.remote.

Prior to v1.8.3.2 this still sort-of works (as you observe below),
because the code fails to realize the remote is invalid, and falls back
to setting branch.feat-bar.remote = "." (i.e. the current repo). This
might seem like an ok practice until you realize that a "git push" back
to that invalid upstream would happily overwrite
refs/remotes/(mirror/)feat-bar, and thus break git-svn's internal state.

This bug was fixed in v1.8.3.2, more specifically 41c21f22 (branch.c:
Validate tracking branches with refspecs instead of refs/remotes/*),
and you can read more about the rationale in that commit message.

The end result for you is that setting up your local feat-bar to track
git-svn's feat-bar will no longer be accepted once you upgrade to >=
v1.8.3.2. The correct way to set up a local feat-bar branch to work on
top of git-svn's feat-bar is instead to forgo the upstream relationship
and simply do "git checkout -b feat-bar refs/remotes/(mirror/)feat-bar".

> Now I am up and rolling, but I get this warning with every checkout or rebase:
>
>      warning: refname 'feat-bar' is ambiguous.
>
> So, let's see what happens when I create the svn clone using a
> --prefix=mirror/ instead. Here's the config:
>
> [svn-remote "svn"]
>         url = https://svn.company.com/repos/
>         fetch = project-foo/trunk:refs/remotes/mirror/trunk
>         branches = project-foo/branches/*:refs/remotes/mirror/*
>         tags = project-foo/tags/*:refs/remotes/mirror/tags/*
>
> Here are my remote branches:
>      remotes/mirror/trunk
>      remotes/mirror/feat-bar
>
> Let's create the tracking branch:
>
> $ git checkout feat-bar  # Branch feat-bar set up to track remote
> branch feat-bar from mirror.

As I explained above, this no longer works in >= v1.8.3.2...

> Voila, worked on the first try. And no more warnings about ambiguous refnames.

...but the warning about ambiguous refnames can and should be fixed,
by making git-svn's --prefix default to adding an extra level below
refs/remotes.

> So now my question is: If using a prefix is so healthy for git's
> branch tracking conventions, why doesn't git-svn default to use some
> prefix like 'origin' or something when initializing a git svn clone?

Exactly, and the good news is that I finally got around to writing that
patch, which I'll post in a minute...


Hope this helps,

...Johan

--
Johan Herland, <johan@herland.net>
www.herland.net
