From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: Re: [PATCH v2 2/2] Porcelain scripts: Rewrite cryptic "needs
 update" error message
Date: Fri, 1 Oct 2010 10:44:28 +0530
Message-ID: <20101001051426.GF20098@kytes>
References: <1285877017-8060-1-git-send-email-artagnon@gmail.com>
 <1285877017-8060-3-git-send-email-artagnon@gmail.com>
 <7vzkuzgcs6.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git List <git@vger.kernel.org>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Joshua Jensen <jjensen@workspacewhiz.com>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Oct 01 07:15:46 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P1XyC-0003Sx-Cq
	for gcvg-git-2@lo.gmane.org; Fri, 01 Oct 2010 07:15:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751519Ab0JAFPj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 1 Oct 2010 01:15:39 -0400
Received: from mail-yw0-f46.google.com ([209.85.213.46]:39107 "EHLO
	mail-yw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751093Ab0JAFPj (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 1 Oct 2010 01:15:39 -0400
Received: by ywh1 with SMTP id 1so888781ywh.19
        for <git@vger.kernel.org>; Thu, 30 Sep 2010 22:15:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=QsfD1oF1L+KjuXjsWc8YZOxWJzsVRxVyPE+s7gG6MUI=;
        b=SuGQnjIxbbcUxF+ticyycp2afbbBh0dwd+jYcHnxQXZ2F6JihsdI2Tma3+DzRv9QLS
         qkXpzBamXjx1JRkHrXCeOUNQ89pjjVzNwUo7tM8H7lles01WmSCEP4fsEnlA/2jbRA/v
         Tp+PJceoCtlzz8A+8jKamENAjCwIdrNO6Q4Jo=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=MatTl/4gSvMayUlqr4DQs9//3qOj714BssXybxnNn3BsIi7PjWdHV4Ho1qs3/UIlGI
         xnTnoZKSx+FCdmf/Ymav1ljXIljEnp9ZJUVAYeQGp2hEIhIWz2XDiI3eA6oKF6KU2ugl
         ikYqpz+0w8CT1UZ8KtUpejWcozGMZLBU7kVRk=
Received: by 10.236.109.50 with SMTP id r38mr2554753yhg.65.1285910138414;
        Thu, 30 Sep 2010 22:15:38 -0700 (PDT)
Received: from kytes ([203.110.240.41])
        by mx.google.com with ESMTPS id c32sm1081827anc.1.2010.09.30.22.15.34
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Thu, 30 Sep 2010 22:15:37 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <7vzkuzgcs6.fsf@alter.siamese.dyndns.org>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/157731>

Hi again,

Junio C Hamano writes:
> Ramkumar Ramachandra <artagnon@gmail.com> writes:
> 
> > diff --git a/git-pull.sh b/git-pull.sh
> > index 8eb74d4..a15b545 100755
> > --- a/git-pull.sh
> > +++ b/git-pull.sh
> > @@ -201,10 +201,7 @@ test true = "$rebase" && {
> >  			die "updating an unborn branch with changes added to the index"
> >  		fi
> >  	else
> > -		git update-index --ignore-submodules --refresh &&
> > -		git diff-files --ignore-submodules --quiet &&
> > -		git diff-index --ignore-submodules --cached --quiet HEAD -- ||
> > -		die "refusing to pull with rebase: your working tree is not up-to-date"
> > +		require_clean_work_tree "pull with rebase"
> 
> Ok, this wants both the working tree and the index clean, and it will exit
> with non-zero.  The original message mentioned "working tree" but by
> calling require_clean_work_tree the user won't see that word anymore.

Right. I suppose this hunk is alright.

> > diff --git a/git-rebase--interactive.sh b/git-rebase--interactive.sh
> > index a27952d..9546975 100755
> > --- a/git-rebase--interactive.sh
> > +++ b/git-rebase--interactive.sh
> > @@ -153,14 +153,6 @@ run_pre_rebase_hook () {
> >  	fi
> >  }
> >  
> > -require_clean_work_tree () {
> > -	# test if working tree is dirty
> > -	git rev-parse --verify HEAD > /dev/null &&
> > -	git update-index --ignore-submodules --refresh &&
> > -	git diff-files --quiet --ignore-submodules &&
> > -	git diff-index --cached --quiet HEAD --ignore-submodules -- ||
> > -	die "Working tree is dirty"
> > -}
> 
> We used to test and exit early if HEAD cannot be read (e.g. empty
> history), but now require_clean_work_tree() will probably spit a cryptic
> error from diff-index it makes.  Don't you need to have an equivalent
> check for HEAD somewhere before you make the first call to r-c-w-t?

Ok. I'll add that in the next iteration.

> > @@ -557,12 +549,9 @@ do_next () {
> >  			exit "$status"
> >  		fi
> >  		# Run in subshell because require_clean_work_tree can die.
> > -		if ! (require_clean_work_tree)
> > +		if ! (require_clean_work_tree "rebase")
> >  		then
> > -			warn "Commit or stash your changes, and then run"
> > -			warn
> > -			warn "	git rebase --continue"
> > -			warn
> > +			warn "Then run git rebase --continue."
> 
> We will see something like:
> 
> 	cannot rebase: you have unstaged changes.
> 	M Makefile
> 	cannot rebase: you index contains uncommitted changes.
> 	M Makefile
>         M hello.c
>         M goodbye.c
>         ... 147 other paths that make the above scroll away ...
>         Please commit or stash them.
>         Then run git rebase --continue.
> 
> Is this what we really want?  Also the messages seem somewhat
> case-challenged.

This is one of the concerns I had while creating this iteration. What
do you suggest? Should we limit the number of paths listed like this?
(I've limited it to 3 paths in this example). Also, is the case
alright now?

 	Cannot rebase: you have unstaged changes.
 	 M Makefile
	 M ram.c
	 M junio.c
	 (and 372 more)
 	Cannot rebase: your index contains uncommitted changes.
 	 M Makefile
         M hello.c
         M goodbye.c
         (and 147 more)
         Please commit or stash them.
	 Then run 'git rebase --continue'.

> > @@ -740,7 +729,7 @@ do
> >  			die "Cannot read HEAD"
> >  		git update-index --ignore-submodules --refresh &&
> >  			git diff-files --quiet --ignore-submodules ||
> > -			die "Working tree is dirty"
> > +			die "Working tree is dirty. Please commit or stash your changes to proceed."
> 
> I wonder if it is a good advice to choose between committing and stashing.
> 
> This codepath is for --continue, and by definition when rebase started
> there wasn't any local modification (otherwise it wouldn't have started
> and we wouldn't have come this far), so the change must have come from the
> end user who wanted to amend (or resolve conflicts), thought that s/he
> included all the changes s/he did in the working tree in the amended
> commit and told us to continue.  We however found some leftover local
> modifications.
> 
> "Please commit or stash" is probably the worst advice we can give in this
> particular situation.  It is likely to be something s/he forgot to add;
> the existing advice that says "Please commit them first and then ..." you
> can see a few lines down this part is probably better.

Right. I didn't think about this enough.
- If it's an "edit", "squash" or "fixup" interactive rebase step, the
  staged changes are automatically committed to the current commit:
  you don't have to explicity commit --amend.
- If the user doesn't want to squash all the changes into the current
  commit, he should stage the changes he wants to be included in the
  commit and stash the rest for use in another step.
- If it's a "reword" step, staged changes/ dirty working tree don't
  mean anything. The use should simply stash everything and continue
  in this case.

I suppose I can come up with a way to check which path was taken and
print more targeted advice. Will do in the next iteration.

> In other codepaths, aborting rebase and cleaning the work area first
> before attempting a rebase might be a better choice than either committing
> or stashing.  Often, I find that is the least confusing choise, at least.

I think we should remove the advice from the r-c-w-t and add more
targeted advice in the caller.

> > diff --git a/git-rebase.sh b/git-rebase.sh
> > index 3335cee..c3ca8d5 100755
> > --- a/git-rebase.sh
> > +++ b/git-rebase.sh
> > @@ -416,19 +416,7 @@ else
> >  	fi
> >  fi
> >  
> > -# The tree must be really really clean.
> > -if ! git update-index --ignore-submodules --refresh > /dev/null; then
> > -	echo >&2 "cannot rebase: you have unstaged changes"
> > -	git diff-files --name-status -r --ignore-submodules -- >&2
> > -	exit 1
> > -fi
> > -diff=$(git diff-index --cached --name-status -r --ignore-submodules HEAD --)
> > -case "$diff" in
> > -?*)	echo >&2 "cannot rebase: your index contains uncommitted changes"
> > -	echo >&2 "$diff"
> > -	exit 1
> > -	;;
> > -esac
> > +require_clean_work_tree "rebase"
> 
> This side is uncontroversial, except that it has the same "is commit/stash
> the best advice?" issue.

Ok, I'll come up with something nicer in the next iteration.

-- Ram
