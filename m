From: Phil Hord <phil.hord@gmail.com>
Subject: Re: [PATCH] diffcore-pickaxe doc: document -S and -G properly
Date: Tue, 14 May 2013 13:44:58 -0400
Message-ID: <CABURp0r808KeSRwhgPw98vUC+JSErvSYHFyAvn-=8JhQzn8e1Q@mail.gmail.com>
References: <1368540759-25598-1-git-send-email-artagnon@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Tue May 14 19:45:27 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UcJHy-0001Ce-4w
	for gcvg-git-2@plane.gmane.org; Tue, 14 May 2013 19:45:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754830Ab3ENRpW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 14 May 2013 13:45:22 -0400
Received: from mail-vc0-f171.google.com ([209.85.220.171]:36582 "EHLO
	mail-vc0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753398Ab3ENRpU (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 14 May 2013 13:45:20 -0400
Received: by mail-vc0-f171.google.com with SMTP id m16so876149vca.16
        for <git@vger.kernel.org>; Tue, 14 May 2013 10:45:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:mime-version:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-type;
        bh=AJo6oTQL5LcKsD4iuidmEoJ8FZ38txYP1ExvUWrNlSo=;
        b=x+UB9kh9IvJZSuBB1PDc2EZQ2qqd7b6/tg+u+DXofYG+WHqW473R4RaeJDE0yIDQGX
         9LnMc6Sh0x41v/gjqXUuq8bb5bfDbTIgh9kqj07+JFoyZuRp7G1Ah4cq3fIRUrMAuFTI
         TEu3z40hRVQ6kQRLHkR+ThvqDzNEOIK5n5H0qDvrHHGB4+IVhVeZp5nn0Z+b/aRzl5Px
         kPvP29jq5MwehTodYzm63rlEjSLeXs9t10FhrqAEO18W/1uOFOCkysXFI/CdFT5umqh0
         h5YoWBUlWJYKQiJpQHzkoY9A5VF9hc+75KYEpKSEt2CVYbI5tU36oREMOA+qPWypMDvm
         MhVg==
X-Received: by 10.52.76.6 with SMTP id g6mr19017797vdw.13.1368553519785; Tue,
 14 May 2013 10:45:19 -0700 (PDT)
Received: by 10.58.135.1 with HTTP; Tue, 14 May 2013 10:44:58 -0700 (PDT)
In-Reply-To: <1368540759-25598-1-git-send-email-artagnon@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/224304>

On Tue, May 14, 2013 at 10:12 AM, Ramkumar Ramachandra
<artagnon@gmail.com> wrote:
> The documentation of -S and -G is very sketchy.  Completely rewrite the
> sections in Documentation/diff-options.txt and
> Documentation/gitdiffcore.txt.
>
> References:
> 52e9578 ([PATCH] Introducing software archaeologist's tool "pickaxe".)
> f506b8e (git log/diff: add -G<regexp> that greps in the patch text)
>
> Signed-off-by: Ramkumar Ramachandra <artagnon@gmail.com>
> ---
>  I spent some time reading the code and history to figure out what -S
>  and -G really do.  I hope I've done justice.
>
>  Documentation/diff-options.txt | 35 +++++++++++++++++++++++++++-------
>  Documentation/gitdiffcore.txt  | 43 +++++++++++++++++++++++-------------------
>  2 files changed, 52 insertions(+), 26 deletions(-)
>
> diff --git a/Documentation/diff-options.txt b/Documentation/diff-options.txt
> index 104579d..765abc5 100644
> --- a/Documentation/diff-options.txt
> +++ b/Documentation/diff-options.txt
> @@ -383,14 +383,35 @@ ifndef::git-format-patch[]
>         that matches other criteria, nothing is selected.
>
>  -S<string>::
> -       Look for differences that introduce or remove an instance of
> -       <string>. Note that this is different than the string simply
> -       appearing in diff output; see the 'pickaxe' entry in
> -       linkgit:gitdiffcore[7] for more details.
> +       Look for commits where the specified string was added or
> +       removed.  More precisely, find commits that change the number
> +       of occurrences of the specified string.
> ++
> +It is often useful when you're looking for an exact string (like a
> +function prototype), and want to know the history of that string since
> +it first came into being.
>
>  -G<regex>::

It looks like you have deleted the -S and -G references here.  Am I
reading this right?

> -       Look for differences whose added or removed line matches
> -       the given <regex>.
> +       Grep through the patch text of commits for added/removed lines
> +       that match <regex>.  `--pickaxe-regex` is implied in this
> +       mode.
> ++
> +To illustrate the difference between `-S<regex> --pickaxe-regex` and
> +`-G<regex>`, consider a commit with the following diff in the same
> +file:
> ++
> +----
> ++    return !regexec(regexp, two->ptr, 1, &regmatch, 0);
> +...
> +-    hit = !regexec(regexp, mf2.ptr, 1, &regmatch, 0);
> +----
> ++
> +While `git log -G"regexec\(regexp"` will show this commit, `git log
> +-S"regexec\(regexp" --pickaxe-regex` will not (because the number of
> +occurrences of that string didn't change).

References to git-log seem out of place to me here in git-diffcore.  I
know it's only an example, but it seems that Git normally describes
these 'reference selectors' more generically.  The generic description
may be more confusing to new users, but this patch is not the place to
consider whether it should change.

> ++
> +See the 'pickaxe' entry in linkgit:gitdiffcore[7] for more
> +information.
>
>  --pickaxe-all::
>         When `-S` or `-G` finds a change, show all the changes in that
> @@ -399,7 +420,7 @@ ifndef::git-format-patch[]
>
>  --pickaxe-regex::
>         Make the <string> not a plain string but an extended POSIX
> -       regex to match.
> +       regex to match.  Implied when using `-G`.
>  endif::git-format-patch[]
>
>  -O<orderfile>::
> diff --git a/Documentation/gitdiffcore.txt b/Documentation/gitdiffcore.txt
> index 568d757..39b9c51 100644
> --- a/Documentation/gitdiffcore.txt
> +++ b/Documentation/gitdiffcore.txt
> @@ -222,25 +222,30 @@ version prefixed with '+'.
>  diffcore-pickaxe: For Detecting Addition/Deletion of Specified String
>  ---------------------------------------------------------------------
>
> -This transformation is used to find filepairs that represent
> -changes that touch a specified string, and is controlled by the
> --S option and the `--pickaxe-all` option to the 'git diff-*'
> -commands.
> -
> -When diffcore-pickaxe is in use, it checks if there are
> -filepairs whose "result" side and whose "origin" side have
> -different number of specified string.  Such a filepair represents
> -"the string appeared in this changeset".  It also checks for the
> -opposite case that loses the specified string.
> -
> -When `--pickaxe-all` is not in effect, diffcore-pickaxe leaves
> -only such filepairs that touch the specified string in its
> -output.  When `--pickaxe-all` is used, diffcore-pickaxe leaves all
> -filepairs intact if there is such a filepair, or makes the
> -output empty otherwise.  The latter behaviour is designed to
> -make reviewing of the changes in the context of the whole
> -changeset easier.
> -
> +There are two kinds of pickaxe: the S kind (corresponding to 'git log
> +-S') and the G kind (corresponding to 'git log -G').

While the switches are called -S and -G, I do not think it is helpful
to name the two pickaxe options as "the S kind" and "the G kind".

> +
> +The S kind detects filepairs whose "result" side and "origin" side
> +have different number of occurrences of specified string.  While
> +rename detection works as usual, 'git log -S' cannot omit commits

The "cannot omit" feels like a confusing double-negative.  How about
"includes" instead?

> +where a the small string being looked for is moved verbatim from one

s/a the/the/

> +file to another (since the number of occurrences of that string
> +changed in each of those two filepairs). The implementation
> +essentially runs a count, and is significantly cheaper than the G
> +kind.
> +
> +The G kind detects filepairs whose patch text has an added or a
> +deleted line that matches the given regexp.  This means that it can
> +detect in-file (or what rename-detection considers the same file)
> +moves.  The implementation of 'git log -G' runs diff twice and greps,
> +and this can be quite expensive.
> +
> +A diffcore-pickaxe option worth mentioning: `--pickaxe-all`.  When not

Is it worth mentioning that something in the documentation is "worth
mentioning"?

> +in effect, diffcore-pickaxe leaves only such filepairs that touch the
> +specified string in its output.  When in effect, diffcore-pickaxe
> +leaves all filepairs intact if there is such a filepair, or makes the
> +output empty otherwise.  The latter behavior is designed to make
> +reviewing of the changes in the context of the whole changeset easier.

I find this description (from the original code, not from this commit)
somewhat confusing.  It is written from the implementer's POV. Does
this seem clearer to you?

    Normally the pickaxe options limit the diff output to those files which
    contained the changes being searched; that is, those files which
    had modifications including the search string.  With the --pickaxe-all
    option, the diff of the entire commit will be shown including files
    which did not have modifications including the search string.  This
    is designed to make it easier to review the changes in the context
    of the whole commit.

>
>  diffcore-order: For Sorting the Output Based on Filenames
>  ---------------------------------------------------------
> --
> 1.8.3.rc1.61.g2cacfff
>
> --
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
