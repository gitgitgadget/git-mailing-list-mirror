From: "Dmitry Potapov" <dpotapov@gmail.com>
Subject: Re: Help using Git(-svn) for specific use case
Date: Mon, 15 Sep 2008 23:55:13 +0400
Message-ID: <37fcd2780809151255q278b1786ub4caec9022d7b082@mail.gmail.com>
References: <aa2b76740809150550q724ab0f4x99a27fa21d90c0fb@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: "Pico Geyer" <picogeyer@gmail.com>
X-From: git-owner@vger.kernel.org Mon Sep 15 21:56:32 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KfKBQ-0004Ca-Lr
	for gcvg-git-2@gmane.org; Mon, 15 Sep 2008 21:56:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753503AbYIOTzU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 15 Sep 2008 15:55:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753563AbYIOTzT
	(ORCPT <rfc822;git-outgoing>); Mon, 15 Sep 2008 15:55:19 -0400
Received: from wr-out-0506.google.com ([64.233.184.234]:47488 "EHLO
	wr-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751707AbYIOTzR (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 15 Sep 2008 15:55:17 -0400
Received: by wr-out-0506.google.com with SMTP id 69so1202705wri.5
        for <git@vger.kernel.org>; Mon, 15 Sep 2008 12:55:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=KiS9Y5aoLjgiZlCxaCc8qBmSnesEV2yFkbRhnvBneac=;
        b=sCpYKit0vPSv7MODJf2N7aiFjSLb4GAiZl3Keq5F/ZX5CAuvl/limjIswamQ8GiK+4
         8ZliRUCmyWkqlCBx9QZPk2ARnse/P5h7n689atI2J5jMbsmTsQkyyc6dUnnCM/mZZU4w
         CPRnuezde3YAo0/y5JBQIXZTic2+FpcwKmegA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references;
        b=CRLVcAGBGOdGnzKjN04i+rwNHU+QHpVreAeoq8/PRLtGYFKtCSCNbIdHrXv2woFFT+
         v5cNSmT1oVZTtTNXSSleBrHMAJlX83XJ4Uojl8XR204IIs4aGkkR4cAAdpQx/++UBnB5
         dxc8m9HRvkRGW9ZO3A7oGFUBgxYpRYcouEkwk=
Received: by 10.142.237.20 with SMTP id k20mr5778wfh.225.1221508513721;
        Mon, 15 Sep 2008 12:55:13 -0700 (PDT)
Received: by 10.142.106.16 with HTTP; Mon, 15 Sep 2008 12:55:13 -0700 (PDT)
In-Reply-To: <aa2b76740809150550q724ab0f4x99a27fa21d90c0fb@mail.gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/95934>

On Mon, Sep 15, 2008 at 4:50 PM, Pico Geyer <picogeyer@gmail.com> wrote:
>
> At the head office, we are (still) using a Subversion server to host
> our source code.
> At the branch office, we would like to do the following:
> * Fetch the latest code from the subversion server.
> * Push changes that we have made at the remote office back to upstream
> SVN server.
> * Be able to share source code changes locally (at the branch office)
> between developers.

I used Git in somewhat similar situation where almost all development
was done in Git mirror of SVN, and then the work was propagated to SVN.
There are some limitations with this approach. The most important is
that SVN does not support merges, so you have to linerialize all history
that you want to commit in SVN. That means that you are going to use git
rebase a lot to rewrite history, which is a PITA. Another problem with
this approach is that the author is not preserved. In SVN, all commits will
look like all changes are done by the person who run "git svn dcommit".

Yet, despite of all these limitations caused by using SVN as backend,
it was far more pleasant to work with Git than with SVN (you can save
your work in progress, you can easily organize the review process,
and many other features such as "git bisect" or "git log -S" just to
name a few...).

>
> The solution that I imagined is that we would setup a server (lets
> call it A) at the branch office with a Git repository, that all the
> developers can access.
> Developers would then clone the server repository A, make mods and
> then push changes back to A.
> It would be nice if git users could commit to a subversion branch.
> A merge master would then (as necessary) use svn dcommit to push the
> changes up to the svn server.
> Is this scenario possible?

Each user has its own copy of the whole repository and they always
commit to their _local_ branches. Then they can push their changes to
the Git repo on your server, but it is a bad idea to push changes to
a local branch of a non-bare repository especially if that branch is
checked out, because push does not (and should not!) update the working
tree and that leads to the situation where all pushed changes are
looked undo in the working tree of that repository. Therefore, you
will probably have a separately integration branch to which users
will push. Oftentimes, users will have to rebase their work on top the
integration branch to be able to push on it (only fast-forward push
should be allowed).

The merge master will merge this branch to the local branch assotiated
with subversion (it will be fast-forward, not a real merge) and then
run git svn dcommit to propagate to subversion.

If there were some conflicting changes in subversion repo, the merge
master will have to resolve them. After that update the merge base
should be updated (using git branch -f) to point out to the top of
the subversion branch.

If users have some changes that were based on the old integration
branches they will have to rebase them to the new position of the
integration branch. As I said above, git rebase is going to be very
often operation in this workflow.

NOTE: branches in git differs from what they are in subversion. In
essence, they are no more than pointers to where to add the next
commit. When I learned Git, I found very useful the article called
"Git for computer scientists" to understand basic ideas of how Git
works: http://eagain.net/articles/git-for-computer-scientists/

>
> From the git-svn man page: "git-clone does not clone branches under
> the refs/remotes/ hierarchy or any git-svn metadata, or config. So
> repositories created and managed with using git-svn should use rsync
> for cloning, if cloning is to be done at all."
> Does that mean that one should not push changes to a repository that
> was created with "git svn clone ..."?

No, what the above description says is that SVN specific information is
not cloned when you clone a repo created by svn. It means that users who
cloned from you will not be able to use git-svn to push their changes in
the original subversion repository. Yet, they can push to your repository
as to any other Git repository.

Dmitry
