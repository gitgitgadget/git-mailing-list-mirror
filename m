From: "Lars Hjemli" <hjemli@gmail.com>
Subject: Re: Terminology question about remote branches.
Date: Sat, 4 Aug 2007 16:03:48 +0200
Message-ID: <8c5c35580708040703w44781498t7396588a3f8c81c8@mail.gmail.com>
References: <854pjfin68.fsf@lola.goethe.zz> <85tzrfh3yg.fsf@lola.goethe.zz>
	 <8c5c35580708040607ya186edcg89fbc90587b64d68@mail.gmail.com>
	 <85k5sbh129.fsf@lola.goethe.zz>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: "Jeff King" <peff@peff.net>, git@vger.kernel.org
To: "David Kastrup" <dak@gnu.org>
X-From: git-owner@vger.kernel.org Sat Aug 04 16:03:52 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IHKES-00059v-B0
	for gcvg-git@gmane.org; Sat, 04 Aug 2007 16:03:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760382AbXHDODt (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 4 Aug 2007 10:03:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759249AbXHDODt
	(ORCPT <rfc822;git-outgoing>); Sat, 4 Aug 2007 10:03:49 -0400
Received: from wa-out-1112.google.com ([209.85.146.183]:14975 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758818AbXHDODs (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 4 Aug 2007 10:03:48 -0400
Received: by wa-out-1112.google.com with SMTP id v27so1174129wah
        for <git@vger.kernel.org>; Sat, 04 Aug 2007 07:03:48 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=sZQpcFC3rhLs97IJPgXHJnpD52d2tbKt9QnrEYSM8W8sElx8cMleedZash8iNXOJW8aeCDuIFlTzK7i9Hku5wSiUOPr/77o2/oeRbR2Yrb1CO7HFZMFRVjU8mXURwugl1atisbfh/VhMM3FmLIo0QkP9eoyZ1egjoWQYL/r/6KY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=U7SeRfWdjgpD83MMM9ThnD6VGlE6ybl1GUrnvtXVNmRxj5lD9Ta6ccMXH5Ulj8h9c6w/S2BY0jt5XxX7JQF6pK0sp9BRI2q+qcFGRJ3ytNn+WnieNrnAGW7VGVo0szLL++gima9VPUxytHOnCVoOsWgNUpO1ogENlYxcULiBFSM=
Received: by 10.114.199.1 with SMTP id w1mr3944383waf.1186236228303;
        Sat, 04 Aug 2007 07:03:48 -0700 (PDT)
Received: by 10.114.235.4 with HTTP; Sat, 4 Aug 2007 07:03:48 -0700 (PDT)
In-Reply-To: <85k5sbh129.fsf@lola.goethe.zz>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/54850>

On 8/4/07, David Kastrup <dak@gnu.org> wrote:
> "Lars Hjemli" <lh@elementstorage.no> writes:
>
> > On 8/4/07, David Kastrup <dak@gnu.org> wrote:
> >> Now I think that I basically have no chance figuring this out on my
> >> own sufficiently well to be able to improve the documentation.
> >
> > Remote-tracking branch:
> >   A local copy of a branch in another repository. This kind of branch
> >   cannot be updated by 'git-commit' but only by 'git-fetch' (hence
> >   indirectly by 'git-pull' and 'git-remote update'). If you try to
> >   'git-checkout' a remote-tracking branch, you will get a detached HEAD.
> >
> > Local branch:
> >   A branch to which you may commit changes. Optionally, the branch can be
> >   configured to "follow" one of your remote-tracking branches. This means
> >   that a 'git-pull' without arguments (when your local branch is checked
> >   out), will automatically 'git-fetch' and then 'git-merge' the remote-
> >   tracking branch.
>
> Does that mean that specifying "--track" to git-checkout or git-branch
> never creates a remote-tracking branch?

Yes. The "--track" option just adds some extra info in .git/config:

[branch "master"]
  remote = origin
  merge = refs/heads/master


This info is then used by "git-pull" to
1. fetch updates from the remote repository "origin"
2. merge those updates from refs/remotes/origin/master

>
> > Example:
> >
> > Your local branch 'master' is setup to "follow"
> > 'refs/remotes/origin/master'.
>
> So --track/--no-track are actually supposed to be --follow and
> --no-follow?

Maybe ;-)

I just tried to avoid using the word "track" in more than one context,
since it seemed to be a main source of confusion.

>
> > So if you do this:
> >
> > $ git checkout master
> > $ git pull
> >
> > Then the 'git pull'-command will do this:
> >
> > $ git fetch -f origin master:remotes/origin/master
>
> This is then tracking?

Yes, this is the part that downloads objects from the remote
repository and updates refs/remotes/origin/master to refer to the same
commit as the master branch in the remote repository.

>
> > $ git merge remotes/origin/master
>
> And this is then following?

Yes, this updates your local 'master' with the commits downloaded by git-fetch


>
> > The magic setup that makes this happen is the following lines in .git/config:
> >
> > [remote "origin"]
> Namely: a remote-tracking branch "origin"

No. A remote repository: the name 'origin' can be used as an alias for

  git://git.kernel.org/pub/scm/git/git.git

>
> >         url = git://git.kernel.org/pub/scm/git/git.git
> >         fetch = +refs/heads/*:refs/remotes/origin/*
> >
> > [branch "master"]
> >         remote = origin
>
> Namely: follow the remote tracking branch origin?

No. Fetch objects from the remote repository alias "origin"

>
> >         merge = refs/heads/master

And this is the info added  by "git branch --track" which enables the
automatic merging of refs/remotes/origin/master (since
refs/remotes/origin/master is your local copy of refs/heads/master in
the 'origin' repository)


> >
> >
> > Was this helpful?

Talking to myself: obviously not


-- 
larsh
