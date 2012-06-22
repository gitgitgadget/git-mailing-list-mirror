From: Phil Hord <phil.hord@gmail.com>
Subject: Re: Master and origin/master diverged
Date: Fri, 22 Jun 2012 14:34:35 -0400
Message-ID: <CABURp0oCrmJzfFtX9UujMfoTPeCBPeuri6pb4nTq57XvuO98aQ@mail.gmail.com>
References: <CAE1pOi1Ot0Fyv=2_XYKyUcsKp-m+CkT-miF=jC=wt9Rbz_dXqQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Git Users <git@vger.kernel.org>
To: Hilco Wijbenga <hilco.wijbenga@gmail.com>
X-From: git-owner@vger.kernel.org Fri Jun 22 20:35:08 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Si8hB-00079q-IQ
	for gcvg-git-2@plane.gmane.org; Fri, 22 Jun 2012 20:35:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755803Ab2FVSe5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 22 Jun 2012 14:34:57 -0400
Received: from mail-yw0-f51.google.com ([209.85.213.51]:62384 "EHLO
	mail-yw0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753254Ab2FVSe4 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 22 Jun 2012 14:34:56 -0400
Received: by yhnn12 with SMTP id n12so2136567yhn.10
        for <git@vger.kernel.org>; Fri, 22 Jun 2012 11:34:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=SaVy0I8KLk+A9hXZYnFJhirdlub7Y8/EI+8MScxNK9s=;
        b=szpE7BkdrblQJ2KD+zJqbkk48HVi5xviuQ2S5/PgBk2tGG5LdSyKZcga0pyXojBsQB
         1RJiGi+7Ctvynsjjgh0lwNlgm19p6YtdJgH7McbexyPgkb6eh9J5BZLvUfwyWwpun0g0
         awh6Vc2JdyxpbxowGK9ZWS53BloIv6MD9hR58l1nQ5poR6LwNWenykK5F1qFzzDzFC29
         LMWEctH6YXIn7XuZZYePT3GuHhGkQZI97Mbin3aFmgvBLgFddafneQ8H9VK27PHkUmqG
         ERThRWWnT3UT6k742vDr+G/7o0FXjcG7pOGaDIkhwzOHktrqZ07jbTtM+DMsOeegEAdG
         Kp3Q==
Received: by 10.236.193.99 with SMTP id j63mr3504673yhn.45.1340390095505; Fri,
 22 Jun 2012 11:34:55 -0700 (PDT)
Received: by 10.146.150.18 with HTTP; Fri, 22 Jun 2012 11:34:35 -0700 (PDT)
In-Reply-To: <CAE1pOi1Ot0Fyv=2_XYKyUcsKp-m+CkT-miF=jC=wt9Rbz_dXqQ@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/200457>

On Fri, Jun 22, 2012 at 1:53 PM, Hilco Wijbenga
<hilco.wijbenga@gmail.com> wrote:
> One of my developers managed to push something that somehow "diverged"
> origin/master from everyone else's local master.
>
> A --> B --> C --> D (everybody's local master)
> |
> \--> B' --> C' --> D' --> E (origin/master)
>
> (i.e., A is the commit where things diverged; everyone's local master
> points to D but the new commit (E) that was pushed to origin/master
> uses different SHA1s for B, C, and D). I hope I explained it clearly
> enough.
>
> Now running git pull creates a merge commit joining D and E.
>
> When I asked the developer what he had done he told me everything had
> looked normal. No Git warnings, nothing strange in gitk (i.e. normal
> linear history). So I do not understand what went wrong.
>
> Does anyone have any idea as to what might have happened? Perhaps if I
> understand how this happened I might be able to prevent it from
> happening again.

There are a number of ways this can happen, but they all involve
rewriting history.  Usually that is something your developer would be
aware of doing.  It does not usually happen by mistake.

Also, in order to push the new E commit, the developer would have to
"force" the push by placing a "+" in front of the references, like
this:

  git push origin +master:master

If he used a gui, then I do not know how this option would be spelled,
but it may be called "force" or something else.

You can look at the reflog on the developer's machine to determine
where the new commits came from.  For example, here are some commits I
rebased a few weeks ago in a repository on my machine:

$ git reflog --relative-date
c93b31b HEAD@{6 weeks ago}: checkout: moving from mine to c93b31b
93a357f HEAD@{6 weeks ago}: rebase finished: returning to refs/heads/mine
93a357f HEAD@{6 weeks ago}: rebase: Add a makefile to help me remember
how to make
f804993 HEAD@{6 weeks ago}: rebase: Allow working in multiple branches
c93b31b HEAD@{6 weeks ago}: rebase: Update Gerrit 2.4 ReleaseNotes
5cac09e HEAD@{6 weeks ago}: rebase: Gerrit 2.4 ReleaseNotes
f41a9b4 HEAD@{6 weeks ago}: checkout: moving from mine to
f41a9b447304733a1784ece373723f8622c8dbad^0
879e5d9 HEAD@{6 weeks ago}: rebase finished: returning to refs/heads/mine
879e5d9 HEAD@{6 weeks ago}: rebase: Add a makefile to help me remember
how to make
35d7a48 HEAD@{6 weeks ago}: rebase: Allow working in multiple branches
c7a845a HEAD@{6 weeks ago}: rebase: Update Gerrit 2.4 ReleaseNotes
7b51315 HEAD@{6 weeks ago}: rebase: Gerrit 2.4 ReleaseNotes
d6799b1 HEAD@{6 weeks ago}: checkout: moving from mine to
d6799b1d40ffc5412e4174fd95bd5fb412781537^0
d9bb39b HEAD@{6 weeks ago}: checkout: moving from
d6799b1d40ffc5412e4174fd95bd5fb412781537 to mine
d6799b1 HEAD@{6 weeks ago}: checkout: moving from mine to origin/master
d9bb39b HEAD@{6 weeks ago}: commit (amend): Add a makefile to help me
remember how to make
62097f8 HEAD@{6 weeks ago}: commit: Add a makefile to help me remember
how to make
dfa61e4 HEAD@{6 weeks ago}: checkout: moving from
dfa61e465bcb27f5698c48d1ec9d32e8fd62c604 to mine


You can see the new commit SHA-1's on the lines that say "rebase:
<original commit message>"

But there are other ways to rewrite history, such as filter-branch.

You can also compare the commits to see what the differences are.
This may trigger  the developer's memory about how it might have
happened.

Phil
