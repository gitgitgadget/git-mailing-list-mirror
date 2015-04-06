From: Jens Lehmann <Jens.Lehmann@web.de>
Subject: Re: Why can't I stash submodule changes?
Date: Mon, 06 Apr 2015 19:58:03 +0200
Message-ID: <5522C92B.6090700@web.de>
References: <CAAKwDd8SVA=ynzH_U1M3bb+mLZMnF79-imBLrU+x9qcbXfWO3g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: Shane da Silva <shane@dasilva.io>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Apr 06 19:58:20 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YfBHu-0006w2-Vi
	for gcvg-git-2@plane.gmane.org; Mon, 06 Apr 2015 19:58:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753010AbbDFR6O convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 6 Apr 2015 13:58:14 -0400
Received: from mout.web.de ([212.227.17.11]:49777 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752779AbbDFR6N (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 6 Apr 2015 13:58:13 -0400
Received: from [192.168.178.41] ([79.211.114.215]) by smtp.web.de (mrweb102)
 with ESMTPSA (Nemesis) id 0M1o3y-1ZXPpr2fPe-00tmtE; Mon, 06 Apr 2015 19:58:09
 +0200
User-Agent: Mozilla/5.0 (X11; Linux i686 on x86_64; rv:31.0) Gecko/20100101 Thunderbird/31.6.0
In-Reply-To: <CAAKwDd8SVA=ynzH_U1M3bb+mLZMnF79-imBLrU+x9qcbXfWO3g@mail.gmail.com>
X-Provags-ID: V03:K0:T8Ja5RytsXFULtpwViWcmiIaMMXGoSlbb8PhjXs2zxRbo5MajKl
 486SxOfmyXFWyXrhO47rGYYq+t5SlX37Samrv/grn9awtmZjBdDZA7YYXLx0ZWi8M8896OV
 FF5b2z8KnOZefvn5p6vflveNGJEhwRabjQCkSi4wtWvV7DeumH89uqEpOs6A6SKlEEvTwSx
 mZEjiDhI0X4h9HxSTlEOw==
X-UI-Out-Filterresults: notjunk:1;
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/266875>

Am 06.04.2015 um 04:15 schrieb Shane da Silva:
> I=E2=80=99m having trouble understanding why I cannot stash changes t=
o a submodule.
>
> When adding a submodule to a repository (`git submodule add
> ./sub-repo`), I can then run `git stash` and `git stash pop` with
> expected results=E2=80=94the submodule disappears and reappears in th=
e working
> tree.

Just to be sure: Only the index of the superproject and the .gitmodules
file are updated by stash to either contain the submodule or not. But
the subdirectory "sub-repo" stays unchanged and won't be removed or
reappear, right?

> However, when I try stashing an update to a submodule, `git stash`
> reports =E2=80=9CNo local changes to save=E2=80=9D. The following she=
ll script
> illustrates this behavior:
>
>
> # Create repo
> mkdir test-repo
> cd test-repo
> git init
> git commit --allow-empty -m "Initial commit"
>
> # Create submodule
> mkdir sub-repo
> cd sub-repo
> git init
> git commit --allow-empty -m "Initial commit"
> cd -
>
> # Add submodule
> git submodule add ./sub-repo
> git commit -m "Add submodule"
>
> # Modify submodule
> cd sub-repo
> touch foo
> git add foo
> git commit -m "Submodule changed"
> cd -
>
> # Stash submodule change
> git stash # <---------------------------Displays "No local changes to=
 save=E2=80=9D

Thanks for providing a recipe to reproduce this!

> I=E2=80=99m trying to wrap my head around why this is the current beh=
avior, as
> I suspect this is intentional but it seems unexpected. If anyone can
> shed any light on this, I would really appreciate it!

The current behavior of git is that submodule contents aren't updated
when the superproject changes. Running "git submodule update" later
will then update their content to most submodule changes (but e.g. it
won't remove a deleted submodule from the work tree). So yes, this is
expected until recursive submodule update materializes (and even then
I'm not sure how to handle untracked but not ignored files inside a
submodule when stashing will result in the submodule directory to be
removed).
