From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: Pull is Mostly Evil
Date: Sat, 03 May 2014 22:08:35 -0500
Message-ID: <5365af33825c3_520db2b308bf@nysa.notmuch>
References: <5363BB9F.40102@xiplink.com>
 <xmqqoazgaw0y.fsf@gitster.dls.corp.google.com>
 <5364A143.1060404@bbn.com>
 <5364b62d5fb7b_ac68dd30816@nysa.notmuch>
 <5365691C.1010208@bbn.com>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit
Cc: Git Mailing List <git@vger.kernel.org>
To: Richard Hansen <rhansen@bbn.com>,
	Felipe Contreras <felipe.contreras@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Marc Branchaud <marcnarc@xiplink.com>
X-From: git-owner@vger.kernel.org Sun May 04 05:19:24 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WgmxW-00034e-4I
	for gcvg-git-2@plane.gmane.org; Sun, 04 May 2014 05:19:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753404AbaEDDTR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 3 May 2014 23:19:17 -0400
Received: from mail-ob0-f182.google.com ([209.85.214.182]:36163 "EHLO
	mail-ob0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753210AbaEDDTQ (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 3 May 2014 23:19:16 -0400
Received: by mail-ob0-f182.google.com with SMTP id wn1so2194605obc.41
        for <git@vger.kernel.org>; Sat, 03 May 2014 20:19:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:message-id:in-reply-to:references:subject
         :mime-version:content-type:content-transfer-encoding;
        bh=DKeWXJaeiibfVUaZgtu5RNLcr6jORGB0YlSQz+fBjH8=;
        b=aIlegOhJfQb1xrJYMHbd+nGAak6xNWT2Sg19+AKFCTNL/WvHc4kBdmNMzFUcno3oI4
         g4sUoge3Dt5LCt4jX/IkLvxbdRLgx77voouQZ/PlnuICOyB7/ohKhh7O/hU0vdutR9dS
         Nj3iy0PVp1kyU2lemK5Nn5lXnaBlToDkuXEY6c7Ee23+c/+FyVzeqRjcuFgrnPMoXExc
         2FnSdrAiWe9rCQJLhMn71KAHY2JvAuMoRSFj6BTE5AOEfTvPPhIJnbGsDgSQ/5au61m/
         vG2LY4TsvnlQ+s8xBVIyxpjvjxTyEKCqQz6VuIjN6qL6wm0b7tpBhULd8fWc5zCi+RsU
         1aVg==
X-Received: by 10.60.115.129 with SMTP id jo1mr25795273oeb.0.1399173556303;
        Sat, 03 May 2014 20:19:16 -0700 (PDT)
Received: from localhost (189-211-224-40.static.axtel.net. [189.211.224.40])
        by mx.google.com with ESMTPSA id ko3sm18038827oeb.1.2014.05.03.20.19.13
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 03 May 2014 20:19:14 -0700 (PDT)
In-Reply-To: <5365691C.1010208@bbn.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/248068>

Richard Hansen wrote:
> On 2014-05-03 05:26, Felipe Contreras wrote:
> > Richard Hansen wrote:
> > 
> >> I think the fundamental difference is in the relationship between the
> >> local and the remote branch (which branch derives from the other).
> >> The relationship between the branches determines what the user wants
> >> from 'git pull'.
> >>
> >> In my experience 'git pull' is mostly (only?) used for the following
> >> three tasks:
> > 
> > I agree.
> > 
> >>  1. update a local branch to incorporate the latest upstream changes
> >>
> >>     In this case, the local branch (master) is a derivative of the
> >>     upstream branch (origin/master).  The user wants all of the
> >>     commits in the remote branch to be in the local branch.  And the
> >>     user would like the local changes, if any, to descend from the tip
> >>     of the remote branch.
> > 
> > My current propsal of making `git pull` by default do --ff-only would
> > solve this.
> 
> It would go a long way toward improving the situation, yes.
> 
> > In addition I think by default 'master' should be merged to
> > 'origin/master', if say --merge is given.
> 
> This would break cases #2 and #3.  (With cases #2 and #3 you want the
> fetched branch to be the second parent, not the first.)
> 
> Or are you proposing that pull --merge should reverse the parents if and
> only if the remote ref is @{u}?

Only if no remote or branch are specified `git pull --merge`.

> > 
> >>     For this case, 'git pull --ff-only' followed by 'git rebase -p'
> >>     works well, as does 'git pull --rebase=preserve' if the user is
> >>     comfortable rebasing without reviewing the incoming commits first.
> > 
> > I suppose you mean a `git rebase -p` if the `git pull --ff-only` failed.
> 
> Yes.
> 
> > This might be OK on most projects, but not all.
> 
> The rebase only affects the local repository (the commits haven't been
> pushed yet or else they'd be in @{u} already), so I'd say it's more of
> an individual developer decision than a project decision.
> 
> In my opinion rebase would be the best option here, but if the project
> is OK with developers pushing merge or merge-there commits and the
> developer isn't yet comfortable with rebasing, then merge is also an
> acceptable option.

Precisely for that reason.

> >>  2. update a published feature branch with the latest changes from its
> >>     parent branch

> > We probably shouldn't change that.
> 
> If we change 'git pull' to default to --ff-only but let 'git pull
> $remote [$refspec]' continue to default to --ff then we have two
> different behaviors depending on how 'git pull' is invoked.  I'm worried
> that this would trip up users.  I'm not convinced that having two
> different behaviors would be bad, but I'm not convinced that it would be
> good either.

It is the only solution that has been proposed.

Moreover, while it's a bit worrisome, it wouldn't create any actual
problems. Since `git pull $what` remains the same, there's no problems
there. The only change would be on `git pull`.

Since most users are not going to do `git pull $what` therefore it would
only be a small subset of users that would notice the discrepancy
between running with $what, or not. And the only discrepancy they could
notice is that when they run `git pull $what` they expect it to be
--ff-only, or when the run `git pull` they don't. Only the former could
be an issue, but even then, it's highly unlikely that `git pull $what`
would ever be a fast-forward.

So althought conceptually it doesn't look clean, in reality there
wouldn't be any problems.

> >>  3. integrate a more-or-less complete feature/fix back into the line
> >>     of development it forked off of
> >>
> >>     In this case the local branch is a primary line of development and
> >>     the remote branch contains the derivative work.  Think Linus
> >>     pulling in contributions.  Different situations will call for
> >>     different ways to handle this case, but most will probably want
> >>     some or all of:
> >>
> >>      * rebase the remote commits onto local HEAD
> > 
> > No. Most people will merge the remote branch as it is. There's no reason
> > to rebase, specially if you are creating a merge commit.
> 
> I disagree.  I prefer to rebase a topic branch before merging (no-ff) to
> the main line of development for a couple of reasons:

Well that is *your* preference. Most people would prefer to preserve the
history.

>   * It makes commits easier to review.

The review in the vast majority of cases happens *before* the
integration.

And the problem comes when the integrator makes a mistake, which they
inevitable do (we all do), then there's no history about how the
conflict was resolved, and what whas the original patch.

That's why most people don't do this.

>   * Rebasing makes the commit history pretty and easier to understand.

It is more important to be able to track integration errors than to have
a pretty history. That is for most people.

I like to have a pretty history for my own local branches, but once
something gets integrated it's important to see who did exactly what
(the integrator did the merge).
> > It is very rare that an integrator is even able to do a fast-forward
> > merge anyway.
> 
> It depends on the level of project activity.  A project as active as the
> Linux kernel or Git will almost never have fast-forwards.  But
> occasional contributions by random users to a small, simple project will
> likely be fast-forwards.

And small simple projects don't care about such issues.

> > So being explicit about --no-ff might better, but it would
> > hardly make a difference. Either way, a good integrator would configure
> > pull.ff = false.
> 
> Configuring pull.ff = false is OK if the integrator only integrates and
> only uses one machine.  But if the integrator also wants to develop in
> the same repository, or if the integrator uses multiple machines to do
> the integration work (e.g., office desktop and laptop), then setting
> pull.ff may be less convenient, not more.

Any good integrator would find solutions for those problems easily.

Either way I don't see any proposed solutions.

> > I'd say `git pull origin master` already works fine for this case.
> 
> It does, but again preserving the current behavior would cause the
> behavior of 'git pull origin master' to be inconsistent with the
> proposed ff-only default for a plain 'git pull'.

Yes, it doesn't look clean. But I don't see any proposed alternatives.

-- 
Felipe Contreras
