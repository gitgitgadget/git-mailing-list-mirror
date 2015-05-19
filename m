From: Stefan Beller <sbeller@google.com>
Subject: Re: [PATCH 14/14] pull --rebase: error on no merge candidate cases
Date: Mon, 18 May 2015 17:12:14 -0700
Message-ID: <CAGZ79kbhA2+AJ1Vtz6khX5uEBCCUBUuXhpBezZApZsC_txhewA@mail.gmail.com>
References: <1431961571-20370-1-git-send-email-pyokagan@gmail.com>
	<1431961571-20370-15-git-send-email-pyokagan@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: "git@vger.kernel.org" <git@vger.kernel.org>,
	Johannes Schindelin <johannes.schindelin@gmx.de>,
	Stephen Robin <stephen.robin@gmail.com>
To: Paul Tan <pyokagan@gmail.com>
X-From: git-owner@vger.kernel.org Tue May 19 02:12:21 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YuV8v-0003P6-62
	for gcvg-git-2@plane.gmane.org; Tue, 19 May 2015 02:12:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751819AbbESAMQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 18 May 2015 20:12:16 -0400
Received: from mail-ie0-f171.google.com ([209.85.223.171]:35031 "EHLO
	mail-ie0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750787AbbESAMP (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 18 May 2015 20:12:15 -0400
Received: by iesa3 with SMTP id a3so1812682ies.2
        for <git@vger.kernel.org>; Mon, 18 May 2015 17:12:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=latRnuj1GSycQ84U2LlHl+MkHWwzooFS6IOm8JiLK64=;
        b=YOb0B/Y+B/HszJImy7QvCFpp3010TCu8s6F4QDFEVA75zDeusP56nxvFNyJHOR0ff5
         XY8UM1ID12EQRYq37FpBavRoljGtRL50Lf5DRWehGaPXM7HThvgbzb5/iOzUqasYFR6E
         VdFf0iqjKNe1TlmWZD2CecNfxjXONN+XULZMdO9vpBf6msjzEGS7fscOOwiDolyPxBcC
         EAWx2uk8fCrviWDIa83VncGnMKeEqDw8ejABmufb6AfbtR9WhasBFUiUXK6W0vj20b8i
         QjJP2sOwnxG5qpEldkXD89HxcV8BvsJctnL5ZAC+hli8FhUtvIQ1bpoRm8Ei2PwwI1QT
         ewTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type;
        bh=latRnuj1GSycQ84U2LlHl+MkHWwzooFS6IOm8JiLK64=;
        b=G7CgZrKa9JqXTBrJOg3zf8RKPq6Ie5R+ole1BtpY46XqezrEI+s1JuOzVTgKhGtKnF
         jI+8mXBDSyjjtXOlsasLZZhJNKvz7ruzsjkSOOSb8i7dtgEl1p71mtoBCbBMLlV8TEtc
         qM1Mx8tHwbjMXqPWuAxS5I5pQms1/rOvOvQywETmY9ZIFo6ifLQbI+IHpbwruKEEV0ua
         P6icK6XBCSknQs8D3yic/EWmSyHHXvFWnugNZM7j3ulnRViAK2hg+9g4OeKHFpiK9mwk
         eH82j2w1mDT/XoPavE/teoP4Hdf8U32SK/EVgPIAJgJu1mnJzRqVgdpJoCXEV+9yf3fo
         AARQ==
X-Gm-Message-State: ALoCoQnQq31GUxrpf1Sa8yR0j5DpS3z5qJxfKpfB34m7tWZV/xLqAMq1Lnl4JRl6DtMDC2r0tJCl
X-Received: by 10.107.8.144 with SMTP id h16mr552569ioi.49.1431994334855; Mon,
 18 May 2015 17:12:14 -0700 (PDT)
Received: by 10.107.46.22 with HTTP; Mon, 18 May 2015 17:12:14 -0700 (PDT)
In-Reply-To: <1431961571-20370-15-git-send-email-pyokagan@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/269333>

On Mon, May 18, 2015 at 8:06 AM, Paul Tan <pyokagan@gmail.com> wrote:
> Tweak the error messages printed by die_no_merge_candidates() to take
> into account that we may be "rebasing against" rather than "merging
> with".
>
> Signed-off-by: Paul Tan <pyokagan@gmail.com>
> ---
>  builtin/pull.c | 42 +++++++++++++++++++++++++-----------------
>  1 file changed, 25 insertions(+), 17 deletions(-)
>
> diff --git a/builtin/pull.c b/builtin/pull.c
> index c8d673d..15b65a0 100644
> --- a/builtin/pull.c
> +++ b/builtin/pull.c
> @@ -474,10 +474,12 @@ static void NORETURN die_no_merge_candidates(const char *repo, const char **refs
>         const char *remote = curr_branch ? curr_branch->remote_name : NULL;
>
>         if (*refspecs) {
> -               fprintf(stderr,
> -                       _("There are no candidates for merging among the refs that you just fetched.\n"
> -                       "Generally this means that you provided a wildcard refspec which had no\n"
> -                       "matches on the remote end.\n"));
> +               if (opt_rebase)
> +                       fputs(_("There is no candidate for rebasing against among the refs that you just fetched."), stderr);

Is there a reason you switch to fputs, instead of fprintf?
$grep -I -r fputs|wc -l
123
$ grep -I -r fprintf|wc -l
689

fputs seems to be used already, though I never came across these parts
of the code
myself, so I wondered if we had fputs in the code base already.

My next guess would have been personal preference, though there seem to be
actual reasons[1] why to use fputs.

Maybe mention the switch in the commit message (As the formatting is
unnecessary,
switch to the lighter fputs function)?

[1] http://stackoverflow.com/questions/5690979/fputs-vs-fprintf


> +               else
> +                       fputs(_("There are no candidates for merging among the refs that you just fetched."), stderr);
> +               fputs(_("Generally this means that you provided a wildcard refspec which had no\n"
> +                       "matches on the remote end."), stderr);
>         } else if (repo && curr_branch && (!remote || strcmp(repo, remote))) {
>                 fprintf(stderr,
>                         _("You asked to pull from the remote '%s', but did not specify\n"
> @@ -485,12 +487,15 @@ static void NORETURN die_no_merge_candidates(const char *repo, const char **refs
>                         "for your current branch, you must specify a branch on the command line.\n"),
>                         repo);
>         } else if (!curr_branch) {
> -               fprintf(stderr,
> -                       _("You are not currently on a branch. Please specify which\n"
> -                       "branch you want to merge with. See git-pull(1) for details.\n"
> -                       "\n"
> -                       "    git pull <remote> <branch>\n"
> -                       "\n"));
> +               fputs(_("You are not currently on a branch."), stderr);
> +               if (opt_rebase)
> +                       fputs(_("Please specify which branch you want to rebase against."), stderr);
> +               else
> +                       fputs(_("Please specify which branch you want to merge with."), stderr);
> +               fputs(_("See git-pull(1) for details."), stderr);
> +               fputs("", stderr);
> +               fputs("    git pull <remote> <branch>", stderr);
> +               fputs("", stderr);
>         } else if (!curr_branch->merge_nr) {
>                 struct known_remote *remotes = NULL;
>                 const char *remote_name = "<remote>";
> @@ -499,14 +504,17 @@ static void NORETURN die_no_merge_candidates(const char *repo, const char **refs
>                 if (remotes && !remotes->next)
>                         remote_name = remotes->remote->name;
>
> +               fputs(_("There is no tracking information for the current branch."), stderr);
> +               if (opt_rebase)
> +                       fputs(_("Please specify which branch you want to rebase against."), stderr);
> +               else
> +                       fputs(_("Please specify which branch you want to merge with."), stderr);
> +               fputs(_("See git-pull(1) for details."), stderr);
> +               fputs("", stderr);
> +               fputs("    git pull <remote> <branch>", stderr);
> +               fputs("", stderr);
>                 fprintf(stderr,
> -                       _("There is no tracking information for the current branch.\n"
> -                       "Please specify which branch you want to merge with.\n"
> -                       "See git-pull(1) for details.\n"
> -                       "\n"
> -                       "    git pull <remote> <branch>\n"
> -                       "\n"
> -                       "If you wish to set tracking information for this branch you can do so with:\n"
> +                       _("If you wish to set tracking information for this branch you can do so with:\n"
>                         "\n"
>                         "    git branch --set-upstream-to=%s/<branch> %s\n"
>                         "\n"),
> --
> 2.1.4
>
