From: Nicolas Pitre <nico@fluxnic.net>
Subject: Re: [PATCH] git-checkout.txt: improve detached HEAD documentation
Date: Thu, 17 Feb 2011 15:47:11 -0500 (EST)
Message-ID: <alpine.LFD.2.00.1102171545331.14920@xanadu.home>
References: <1297971966-58500-1-git-send-email-jaysoffian@gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: Jay Soffian <jaysoffian@gmail.com>
X-From: git-owner@vger.kernel.org Thu Feb 17 21:47:19 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PqAkx-0005px-1f
	for gcvg-git-2@lo.gmane.org; Thu, 17 Feb 2011 21:47:19 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757868Ab1BQUrO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 17 Feb 2011 15:47:14 -0500
Received: from relais.videotron.ca ([24.201.245.36]:19746 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755737Ab1BQUrN (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 17 Feb 2011 15:47:13 -0500
Received: from xanadu.home ([66.130.28.92]) by vl-mh-mrz21.ip.videotron.ca
 (Sun Java(tm) System Messaging Server 6.3-8.01 (built Dec 16 2008; 32bit))
 with ESMTP id <0LGS001LT4DZXY10@vl-mh-mrz21.ip.videotron.ca> for
 git@vger.kernel.org; Thu, 17 Feb 2011 15:46:47 -0500 (EST)
X-X-Sender: nico@xanadu.home
In-reply-to: <1297971966-58500-1-git-send-email-jaysoffian@gmail.com>
User-Agent: Alpine 2.00 (LFD 1167 2008-08-23)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/167115>

On Thu, 17 Feb 2011, Jay Soffian wrote:

> The detached HEAD state is a source of much confusion for users
> new to git. Here we try to document it better.
> 
> Reworked from http://article.gmane.org/gmane.comp.version-control.git/138440

Excellent!

> Requested-by: Nicolas Pitre <nico@fluxnic.net>
> Signed-off-by: Jay Soffian <jaysoffian@gmail.com>

Acked-by: Nicolas Pitre <nico@fluxnic.net>

> ---
> Nicolas only asked me to contribute this a full year ago, not too
> bad. :)

Better late than never.

>  Documentation/git-checkout.txt |  108 +++++++++++++++++++++++++++++++---------
>  1 files changed, 85 insertions(+), 23 deletions(-)
> 
> diff --git a/Documentation/git-checkout.txt b/Documentation/git-checkout.txt
> index 880763d..21abd2a 100644
> --- a/Documentation/git-checkout.txt
> +++ b/Documentation/git-checkout.txt
> @@ -206,40 +206,102 @@ leave out at most one of `A` and `B`, in which case it defaults to `HEAD`.
>  
>  Detached HEAD
>  -------------
> +HEAD normally refers to a named branch (e.g. "master"). Meanwhile, each
> +branch refers to a specific commit-id. Let's look at a repo with three
> +commits and with "master" checked out:
>  
> -It is sometimes useful to be able to 'checkout' a commit that is
> -not at the tip of one of your branches.  The most obvious
> -example is to check out the commit at a tagged official release
> -point, like this:
> +------------
> +           HEAD (refers to master)
> +            v
> +a---b---c  master (refers to c)
> +------------
> +
> +When a commit is created in this state, the branch is updated to the new
> +commit-id. Let's add a commit:
>  
>  ------------
> -$ git checkout v2.6.18
> +               HEAD (refers to master)
> +                v
> +a---b---c---d  master (refers to d)
>  ------------
>  
> -Earlier versions of git did not allow this and asked you to
> -create a temporary branch using the `-b` option, but starting from
> -version 1.5.0, the above command 'detaches' your HEAD from the
> -current branch and directly points at the commit named by the tag
> -(`v2.6.18` in the example above).
> +It is sometimes useful to be able to checkout a commit that is not at
> +the tip of any named branch, or even to create a new commit that is not
> +referenced by a named branch. Let's look at what happens when we
> +checkout commit b:
>  
> -You can use all git commands while in this state.  You can use
> -`git reset --hard $othercommit` to further move around, for
> -example.  You can make changes and create a new commit on top of
> -a detached HEAD.  You can even create a merge by using `git
> -merge $othercommit`.
> +------------
> +$ git checkout master^^
>  
> -The state you are in while your HEAD is detached is not recorded
> -by any branch (which is natural --- you are not on any branch).
> -What this means is that you can discard your temporary commits
> -and merges by switching back to an existing branch (e.g. `git
> -checkout master`), and a later `git prune` or `git gc` would
> -garbage-collect them.  If you did this by mistake, you can ask
> -the reflog for HEAD where you were, e.g.
> +   HEAD (refers to b)
> +    v
> +a---b---c---d  master (refers to d)
> +------------
> +
> +Notice that HEAD now refers directly to commit b. In git terminology,
> +this is known as having a detached HEAD. It means simply that HEAD
> +refers to a specific commit-id, as opposed to referring to a named
> +branch. Let's add a commit while HEAD is detached:
>  
>  ------------
> -$ git log -g -2 HEAD
> +     HEAD (refers to e)
> +      v
> +      e
> +     /
> +a---b---c---d  master (refers to d)
> +------------
> +
> +We have created a new commit, but it is referenced only by HEAD. We can
> +of course add yet another commit in this state:
> +
> +------------
> +         HEAD (refers to f)
> +          v
> +      e---f
> +     /
> +a---b---c---d  master (refers to d)
> +------------
> +
> +In fact, we can perform all the normal git operations. But, let's look
> +at what happens when we then checkout master:
> +
>  ------------
> +$ git checkout master
>  
> +      e---f    HEAD (refers to master)
> +     /          v
> +a---b---c---d  master (refers to d)
> +------------
> +
> +It is important to realize that at this point nothing refers to commits
> +e and f. Eventually these commits will be deleted by the routine git
> +garbage collection process, unless we create a reference before that
> +happens. If we have not yet moved away from commit f, any of these will
> +create a reference to it:
> +
> +------------
> +$ git checkout -b foo # (1)
> +$ git branch foo      # (2)
> +$ git tag foo         # (3)
> +------------
> +
> +(1) creates a new branch "foo", which refers to f, and then updates HEAD
> +to refer to "foo". In other words, we'll no longer be in detached HEAD
> +state after (1).
> +
> +(2) similarly creates a new branch "foo", which refers to f, but leaves
> +HEAD detached.
> +
> +(3) creates a new tag "foo", which refers to f, leaving HEAD detached.
> +
> +If we have moved away from commit f, then we must first recover its id
> +(typically by using git reflog), and then we can create a reference to
> +it. For example, to see the last two commits to which HEAD referred, we
> +can use:
> +
> +------------
> +$ git log -g -2 HEAD
> +------------
>  
>  EXAMPLES
>  --------
> -- 
> 1.7.4.1.29.g21713
> 
