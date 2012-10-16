From: James Nylen <jnylen@gmail.com>
Subject: Re: [PATCH] Add --unannotate option to git-subtree
Date: Tue, 16 Oct 2012 08:47:09 -0400
Message-ID: <CABVa4NgdaiwfTvFe1CU+24QF-BA45tM2e3+9e2PJ_4ecuD0Cyg@mail.gmail.com>
References: <CABVa4NinSighUn7GKbzMx9qZj3Ao2dCtEZxUqCPwO9TocZ8Kkg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Oct 16 14:47:27 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TO6YM-0004OC-8o
	for gcvg-git-2@plane.gmane.org; Tue, 16 Oct 2012 14:47:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752663Ab2JPMrL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 16 Oct 2012 08:47:11 -0400
Received: from mail-ie0-f174.google.com ([209.85.223.174]:54758 "EHLO
	mail-ie0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752207Ab2JPMrK (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 16 Oct 2012 08:47:10 -0400
Received: by mail-ie0-f174.google.com with SMTP id k13so9652430iea.19
        for <git@vger.kernel.org>; Tue, 16 Oct 2012 05:47:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :content-type;
        bh=ph9Xq6fuFvfKzEW5oZ7h7AobLe/9B5CQiZ3rTU0IzwE=;
        b=u86zRPEUUh2ju66uiyDKYfnn0xKTjek7in82Lxz5pAsPgJi8+0fIJklc8UZxdraoCJ
         hNEFlLDUcjwz5kxPHOJbi+HOxJxpAStLODousB8Q0PXBa9UyAAPB4qxW3CAqN21EaAAn
         kMtudWLWqd+Y/khx6Bwb1UnIbQxOE+UKZibqdo+hj3kpfQBTs4n19JwQkCVNk2xCO78E
         sSeIbzDFOFCmx0a0Lp7s0JwoBtm1FOF5vPcf9UKBmzMLKR2g+R3lcs5DfN/xUUSEdIBb
         MrC5HNoeodybaVd/m/pWCYR8CDG3PJ1/e/+p/D8HpRsPiOgwU/DIH4pzhqn02UBF+PCw
         DCbQ==
Received: by 10.50.178.106 with SMTP id cx10mr11959153igc.24.1350391629781;
 Tue, 16 Oct 2012 05:47:09 -0700 (PDT)
Received: by 10.42.173.130 with HTTP; Tue, 16 Oct 2012 05:47:09 -0700 (PDT)
In-Reply-To: <CABVa4NinSighUn7GKbzMx9qZj3Ao2dCtEZxUqCPwO9TocZ8Kkg@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/207822>

On Tue, Oct 9, 2012 at 4:26 PM, James Nylen <jnylen@gmail.com> wrote:
> This new option does the reverse of --annotate, which is more useful
> when contributing back to a library which is also included in the
> repository for a larger project, and perhaps in other situations as
> well.
>
> Rather than adding a marker to each commit when splitting out the
> commits back to the subproject, --unannotate removes the specified
> string (or bash glob pattern) from the beginning of the first line of
> the commit message.  This enables the following workflow:
>
>  - Commit to a library included in a large project, with message:
>      Library: Make some amazing change
>
>  - Use `git-subtree split` to send this change to the library maintainer
>
>  - Pass ` --unannotate='Library: ' ` or ` --unannotate='*: ' `
>
>  - This will turn the commit message for the library project into:
>      Make some amazing change
>
> This helps to keep the commit messages meaningful in both the large
> project and the library project.
>
> Signed-off-by: James Nylen <jnylen@gmail.com>
> ---

Has anybody looked at this?

It has been very useful for me.

> Let me know if gmail has munged this patch.  You can also get at it
> like this:
>
> $ git remote add nylen git://github.com/nylen/git.git
> $ git fetch nylen
> $ git show nylen/subtree-unannotate
> ---
>  contrib/subtree/git-subtree.sh  | 11 +++++++++--
>  contrib/subtree/git-subtree.txt | 15 +++++++++++++++
>  2 files changed, 24 insertions(+), 2 deletions(-)
>
> diff --git a/contrib/subtree/git-subtree.sh b/contrib/subtree/git-subtree.sh
> index 920c664..8d1ed05 100755
> --- a/contrib/subtree/git-subtree.sh
> +++ b/contrib/subtree/git-subtree.sh
> @@ -21,6 +21,7 @@ P,prefix=     the name of the subdir to split out
>  m,message=    use the given message as the commit message for the merge commit
>   options for 'split'
>  annotate=     add a prefix to commit message of new commits
> +unannotate=   remove a prefix from new commit messages (supports bash globbing)
>  b,branch=     create a new branch from the split subtree
>  ignore-joins  ignore prior --rejoin commits
>  onto=         try connecting new tree to an existing one
> @@ -43,6 +44,7 @@ onto=
>  rejoin=
>  ignore_joins=
>  annotate=
> +unannotate=
>  squash=
>  message=
>
> @@ -80,6 +82,8 @@ while [ $# -gt 0 ]; do
>                 -d) debug=1 ;;
>                 --annotate) annotate="$1"; shift ;;
>                 --no-annotate) annotate= ;;
> +               --unannotate) unannotate="$1"; shift ;;
> +               --no-unannotate) unannotate= ;;
>                 -b) branch="$1"; shift ;;
>                 -P) prefix="$1"; shift ;;
>                 -m) message="$1"; shift ;;
> @@ -310,8 +314,11 @@ copy_commit()
>                         GIT_COMMITTER_NAME \
>                         GIT_COMMITTER_EMAIL \
>                         GIT_COMMITTER_DATE
> -               (echo -n "$annotate"; cat ) |
> -               git commit-tree "$2" $3  # reads the rest of stdin
> +               (
> +                       read FIRST_LINE
> +                       echo "$annotate${FIRST_LINE#$unannotate}"
> +                       cat  # reads the rest of stdin
> +               ) | git commit-tree "$2" $3
>         ) || die "Can't copy commit $1"
>  }
>
> diff --git a/contrib/subtree/git-subtree.txt b/contrib/subtree/git-subtree.txt
> index 0c44fda..ae420aa 100644
> --- a/contrib/subtree/git-subtree.txt
> +++ b/contrib/subtree/git-subtree.txt
> @@ -198,6 +198,21 @@ OPTIONS FOR split
>         git subtree tries to make it work anyway, particularly
>         if you use --rejoin, but it may not always be effective.
>
> +--unannotate=<annotation>::
> +       This option is only valid for the split command.
> +
> +       When generating synthetic history, try to remove the prefix
> +       <annotation> from each commit message (using bash's "strip
> +       shortest match from beginning" command, which supports
> +       globbing).  This makes sense if you format library commits
> +       like "library: Change something or other" when you're working
> +       in your project's repository, but you want to remove this
> +       prefix when pushing back to the library's upstream repository.
> +       (In this case --unannotate='*: ' would work well.)
> +
> +       Like --annotate,  you need to use the same <annotation>
> +       whenever you split, or you may run into problems.
> +
>  -b <branch>::
>  --branch=<branch>::
>         This option is only valid for the split command.
> --
> 1.7.11.3
