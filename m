Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 350F8C77B73
	for <git@archiver.kernel.org>; Wed, 31 May 2023 22:37:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230312AbjEaWg7 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 31 May 2023 18:36:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49568 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230272AbjEaWg5 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 31 May 2023 18:36:57 -0400
Received: from ciao.gmane.io (ciao.gmane.io [116.202.254.214])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D9E2BB3
        for <git@vger.kernel.org>; Wed, 31 May 2023 15:36:55 -0700 (PDT)
Received: from list by ciao.gmane.io with local (Exim 4.92)
        (envelope-from <gcvg-git-3@m.gmane-mx.org>)
        id 1q4UR3-00059z-T5
        for git@vger.kernel.org; Thu, 01 Jun 2023 00:36:53 +0200
X-Injected-Via-Gmane: http://gmane.org/
To:     git@vger.kernel.org
From:   Carlos <kaploceh@gmail.com>
Subject: Re: not robust inconsistent git 2.40.1 with HEAD -> master,
 origin/main, origin/HEAD, origin/master, main
Date:   Wed, 31 May 2023 18:36:44 -0400
Message-ID: <kewfqedoob2cptihhxoe6pp4jj63pw7qcldqvmb52cg7fbhzv5@xypplc3psbv5>
References: <lxh4jpacuv5ivqp35w5vpbcjlw67r7ix3yog6cc3cu5ij7yqho@mrtr24xxdstx>
 <319cfa79-a508-127f-c201-9f50d5e6fe6a@iee.email>
 <30385b42-0c6a-3588-2b13-0552c23727f2@iee.email>
 <a7xmox7j6katje62wx6hhclb7itfbhxnda44s4ve7g3cjyzm6j@2tosx6g6cpgv>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a7xmox7j6katje62wx6hhclb7itfbhxnda44s4ve7g3cjyzm6j@2tosx6g6cpgv>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, May 31, 2023 at 05:35:58PM -0400, Carlos wrote:
> On Wed, May 31, 2023 at 02:22:59PM +0100, Philip Oakley wrote:
> > On 31/05/2023 11:57, Philip Oakley wrote:
> > > On 30/05/2023 19:14, Carlos wrote:
> > >> Running git 2.40.1 with HEAD -> master, origin/main, origin/HEAD, origin/master, main with initial commit on main does not show all the objects from master
> > >>
> > >>
> > >> ! [main] Initial commit
> > >>  * [master] Initial commit
> > >>   ! [origin/master] Initial commit
> > >> ---
> > >> +*+ [main] Initial commit
> > >>
> > > 
> > > this is the output of `git show-branch` [1] which has its own special
> > > display format. It's not often used these days.
> > > 
> > > The `!` are column markers, as is `*` for the current branch.
> > > You have three branches listed
> > > Then you have the `---` divider
> > > 
> > > Finally you has the single commit, showing which branches the commit is
> > > 'on'.
> > > 
> > > Be careful to discriminate between being 'on' a branch (at it's tip, by
> > > name); 'at' an oid (object id / hash); and `in` a branch (below its
> > > tip); etc.
> > > 
> > > 
> > > [1] https://git-scm.com/docs/git-show-branch
> > > 
> > >> the chunk of objects are on master and not main, and yet it shows
> > >> nothing once checking out to master. 
> > >>
> > >> the git-clone operation is not consistent either. It's a disaster.
> > >>
> > >> One would think that by now with the more developed work put on to git, it'd
> > >> be safe to assume the more sense there's on newer versions. But no. This
> > >>  is the opposite actually. 
> > >>
> > >> Now. If by any chance the git-branch operation were to return:
> > >>
> > >>   main
> > >> * master
> > >>
> > >> after git-clone, then objects are indeed in place. That is. On master
> > >>
> > >> but not if git-branch returns 
> > >>
> > >>   main
> > >> * master
> > >>   origin/master
> > >>
> > 
> > You may have accidentally created a local branch called `origin/master`
> > which you are now confusing with the (unlisted) remote tracking branches.
> > 
> 
> if the remotes are in place, 
> 
>   main
> * master
>   origin/master
>   remotes/origin/HEAD -> origin/main
>   remotes/origin/main
>   remotes/origin/master
> 
> 
> what exactly is origin/master doing there? even by assuming I created it
> (which I didn't but let's say I did) then:
> 
> git checkout origin/master
> 
> warning: refname 'origin/master' is ambiguous.
> Switched to branch 'origin/master'
> 
> confirms it that given the above, it follows that `git checkout
> origin/master` would fail to create and to be in quote  in 'detached
> HEAD' state. To look around, make experimental changes and commit them,
> and to discard any commits one makes in this state without impacting
> any branches by switching back to a branch` . blah blah blah
> 
> as does the one without the origin/master , right? 
> 

Fe de errata:

*unlike the one without the origin/master, which *successfully* does,
as shown below:

> Now, if I were to do the same under the worktree (the tree holding the
> contents correctly on both main and master, right?) with git branch -ra:
> 
> 
>   main
> * master
>   remotes/origin/HEAD -> origin/main
>   remotes/origin/main
>   remotes/origin/master
> 
> which behaves accordingly
> 
> * (HEAD detached at origin/master)
>   main
>   master
>   remotes/origin/HEAD -> origin/main
>   remotes/origin/main
>   remotes/origin/master
> 
> 
> > What does
> > 
> > 	git branch -ra
> > 
> > produce?
> > 
> > It will show the local branches first, and then your
> > `remotes/repo/branches` list (probably colourised).
> > 
> > This should help confirm what you have.
> > >>
> > >>
> > > Philip
> > P.
> > 
> 
> -- 
> Modeling paged and segmented memories is tricky business.
> 		-- P. J. Denning
> 
> 

-- 
Put no trust in cryptic comments.

