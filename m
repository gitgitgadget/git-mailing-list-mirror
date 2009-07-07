From: Bruno Haible <bruno@clisp.org>
Subject: Re: request for documentation about branch surgery
Date: Tue, 7 Jul 2009 12:13:24 +0200
Message-ID: <200907071213.25418.bruno@clisp.org>
References: <200907070105.12821.bruno@clisp.org> <7vab3hb40x.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Jul 07 12:13:57 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MO7gS-0002a6-5s
	for gcvg-git-2@gmane.org; Tue, 07 Jul 2009 12:13:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754797AbZGGKNq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 7 Jul 2009 06:13:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753669AbZGGKNp
	(ORCPT <rfc822;git-outgoing>); Tue, 7 Jul 2009 06:13:45 -0400
Received: from mo-p00-ob.rzone.de ([81.169.146.160]:25633 "EHLO
	mo-p00-ob.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751659AbZGGKNo (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 7 Jul 2009 06:13:44 -0400
X-RZG-AUTH: :Ln4Re0+Ic/6oZXR1YgKryK8brksyK8dozXDwHXjf9hj/zDNRbfU4489asA==
X-RZG-CLASS-ID: mo00
Received: from linuix.haible.de
	(dslb-088-068-043-109.pools.arcor-ip.net [88.68.43.109])
	by post.strato.de (klopstock mo46) (RZmta 18.49)
	with ESMTP id D01297l679eK8M ; Tue, 7 Jul 2009 12:13:45 +0200 (MEST)
User-Agent: KMail/1.9.9
In-Reply-To: <7vab3hb40x.fsf@alter.siamese.dyndns.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/122833>

Hi Junio,

> You learn new things every day, and today is such a day ;-)
> 
> >   If you want to add a commit in the middle of a branch:
> >
> >             A---C---...---Z    master
> >
> >   =>
> >
> >             A---B---C---...---Z    master
> >
> >   it is achieved by
> 
>         $ git checkout master~25 ;# detach HEAD at A
>         $ edit edit edit
>         $ git commit ;# creates B
> 
> which makes
> 
>                B              HEAD (detached)
>               /
>              A---C---...---Z    master
> 
> and then
> 
>         $ git rebase HEAD master
> 
> which reshapes the history into
> 
> 
>                B---C'--...---Z' master
>               /
>              A---C---...---Z    master@{1}
> 
> and you are done.

Cool! I wouldn't have guessed that. Now you wrote it into the mailing list
archives. It would be even better if it were mentioned in the user's manual,
chapter "Rewriting history and maintaining patch series"

> > 3) When do I need "git merge", and when do I need "git rebase", in the
> >    context of branch surgery?
> >
> >    The simple answer, that I would find worth mentioning, is:
> >      - "git merge" copies commits from one branch to another.
> >      - "git rebase" only moves commits around to make history more linear.
> 
> If you think "git merge" _copies_, you will never understand what "merge"
> does. ... There is no copying involved anywhere .  It only creates a new
> commit 

There are two cases of "git merge" operation: the one that creates a diamond
commit, and the one that doesn't (the "simple" case of "git merge"). The latter
operation I found useful in achieving this surgery:

            C---D---E              topic
           /
      A---B                        master

  =>

            C---D---E              topic
           /
      A---B---C---D---E            master

How do I do this, if not by using "git merge"? Is there a way to do it with
"git rebase" only?

If I have a certain task at hand, what rule of thumb would you give me,
when can I do it with "git rebase", and when can I do it with the simple case
of "git merge"?

> > 4) It would be good to have a section "Cutting branches"
> >
> >    How do I remove the N most recent commits from a branch?
> >
> >                D---E---F---G---H---.........---Y---Z master
> >
> >   =>
> >                D---E master
> 
> And it is not even cutting.  It merely makes this:
> 
>                       F---G---H---.........---Y---Z master@{1}
>                      /
>                 D---E
>                     ^master

I regularly use "git repack -a -d", so that branches like that
master@{1} get garbage collected. So from the point of view of someone
who considers only the contents of the commits that sit on branches,
it *does* cut the branch.

I know that all commits are still present and reachable by their ID,
as long as they have not been garbage collected. But when doing
branch surgery, only the contents of the labelled branches matters to me.

> I think your confusion is primarily coming from not understanding what a
> branch in git is.  A branch in git does not have its own identity per-se,
> and a commit does _not_ belong to a branch, in the sense that a commit
> object does not record anywhere on which branch it was created on.  A
> branch is just a pointer into a dag and the pointer can be moved.

Oh, I do and did know all this. There is no confusion about that. My problem
was that
  - I had a couple of "how do I ..." questions regarding branch surgery,
  - the mapping between such a task and the git command to use is not clear
    (combinations of "git checkout", "git branch", "git rebase", "git merge",
    "git reset", "git cherry-pick" - enough complicated commands to get
    confused),
  - the user's manual answered only half of my questions.

Bruno
