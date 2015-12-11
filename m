From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] rebase -i: remember merge options beyond continue actions
Date: Fri, 11 Dec 2015 12:07:18 -0800
Message-ID: <CAPc5daV_tPh9pt4YSpsBSCvrvGOqC7+9eTZkS1bV2ZAE2YoxzA@mail.gmail.com>
References: <53965334.3030206@gmail.com> <1449863646-26067-1-git-send-email-ralf.thielow@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git Mailing List <git@vger.kernel.org>, bafain@gmail.com,
	campos@esss.com.br, Michael Haggerty <mhagger@alum.mit.edu>,
	Eric Sunshine <sunshine@sunshineco.com>
To: Ralf Thielow <ralf.thielow@gmail.com>
X-From: git-owner@vger.kernel.org Fri Dec 11 21:07:46 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1a7Tyi-0000Az-Rh
	for gcvg-git-2@plane.gmane.org; Fri, 11 Dec 2015 21:07:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752815AbbLKUHj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 11 Dec 2015 15:07:39 -0500
Received: from mail-ig0-f180.google.com ([209.85.213.180]:36297 "EHLO
	mail-ig0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752733AbbLKUHj (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 11 Dec 2015 15:07:39 -0500
Received: by mail-ig0-f180.google.com with SMTP id ph11so46122930igc.1
        for <git@vger.kernel.org>; Fri, 11 Dec 2015 12:07:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-type;
        bh=Lm651b4pwyxE4pT9zzCW5EXgmVeOz6QS05rEsBgHsvM=;
        b=CjuOXEPRkck8j9Q6jXQ8UaIDyrMHtMiTYBmkZ8k+DdkSEAkRrIsOUp129Mte6+juIo
         TIapE1tfuLAnAq3Ew6TV9qBxBqygCICirESjwmm6AIeb8Ox8H6ob8oKCLPDNaoeqMlFM
         FsjEEgpPfWDdBG6k2jNzIL/6w0Kk73aVV2n7yoj3r9PcBzVqMJracOtgyGGGEOUMc5hH
         dGhLF1lDbWOu3eBB5zf9vffWqT+sRNXBehYFVnjbydbamUz7cBkFiWvn+mHTyi8ydkey
         qAlnnONwN9A+FrE6uRSvtra19vmV9+KoL366z8UMCJmrohznbZRnW6QurmhB3TXqcQlB
         vYwg==
X-Received: by 10.50.103.38 with SMTP id ft6mr2867628igb.60.1449864458223;
 Fri, 11 Dec 2015 12:07:38 -0800 (PST)
Received: by 10.36.52.203 with HTTP; Fri, 11 Dec 2015 12:07:18 -0800 (PST)
In-Reply-To: <1449863646-26067-1-git-send-email-ralf.thielow@gmail.com>
X-Google-Sender-Auth: 1d7A_UDo8i6U43w1Y4512qnAdgA
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/282277>

On Fri, Dec 11, 2015 at 11:54 AM, Ralf Thielow <ralf.thielow@gmail.com> wrote:
> From: Fabian Ruch <bafain@gmail.com>
>
> If the user specifies a merge strategy or strategy options in
> "rebase --interactive", also use these in subsequent calls of
> "rebase --continue".
>
> In the implementation, the "do_merge" guard to check for a given
> merge strategy or strategy options is implied by passing these
> options, but not stored.  This prevents subsequent calls of
> "rebase --continue" to use this setting again later.  Remove this
> "do_merge" guard to allow a later usage.
>
> Reported-by: Diogo de Campos <campos@esss.com.br>
> Signed-off-by: Fabian Ruch <bafain@gmail.com>
> Helped-by: Michael Haggerty <mhagger@alum.mit.edu>
> Signed-off-by: Ralf Thielow <ralf.thielow@gmail.com>
> ---
> I've been applying the original patch for a long time to my tree,
> as it helps me to resolve conflicts e.g. when rebasing .po files.
> I also think it's a reasonable change for git-rebase.
>
> I've rebased it agains the current master and rewrote the
> commit message to try to make this change technically a bit more
> easy to understand.

Thanks. I wonder if Michael's rephrasing in $gmane/251386 still applies, which
I found by far the most readable.

http://thread.gmane.org/gmane.comp.version-control.git/251147/focus=251386



>
> Original patch submit:
> http://thread.gmane.org/gmane.comp.version-control.git/251147/
>
>  git-rebase--interactive.sh    | 18 +++++++-----------
>  t/t3404-rebase-interactive.sh | 16 ++++++++++++++++
>  2 files changed, 23 insertions(+), 11 deletions(-)
>
> diff --git a/git-rebase--interactive.sh b/git-rebase--interactive.sh
> index b938a6d..c0cfe88 100644
> --- a/git-rebase--interactive.sh
> +++ b/git-rebase--interactive.sh
> @@ -81,17 +81,13 @@ rewritten_pending="$state_dir"/rewritten-pending
>  # and leaves CR at the end instead.
>  cr=$(printf "\015")
>
> -strategy_args=
> -if test -n "$do_merge"
> -then
> -       strategy_args=${strategy:+--strategy=$strategy}
> -       eval '
> -               for strategy_opt in '"$strategy_opts"'
> -               do
> -                       strategy_args="$strategy_args -X$(git rev-parse --sq-quote "${strategy_opt#--}")"
> -               done
> -       '
> -fi
> +strategy_args=${strategy:+--strategy=$strategy}
> +eval '
> +       for strategy_opt in '"$strategy_opts"'
> +       do
> +               strategy_args="$strategy_args -X$(git rev-parse --sq-quote "${strategy_opt#--}")"
> +       done
> +'
>
>  GIT_CHERRY_PICK_HELP="$resolvemsg"
>  export GIT_CHERRY_PICK_HELP
> diff --git a/t/t3404-rebase-interactive.sh b/t/t3404-rebase-interactive.sh
> index 98eb49a..9a2461c 100755
> --- a/t/t3404-rebase-interactive.sh
> +++ b/t/t3404-rebase-interactive.sh
> @@ -1006,6 +1006,22 @@ test_expect_success 'rebase -i with --strategy and -X' '
>         test $(cat file1) = Z
>  '
>
> +test_expect_success 'interrupted rebase -i with --strategy and -X' '
> +       git checkout -b conflict-merge-use-theirs-interrupted conflict-branch &&
> +       git reset --hard HEAD^ &&
> +       >breakpoint &&
> +       git add breakpoint &&
> +       git commit -m "breakpoint for interactive mode" &&
> +       echo five >conflict &&
> +       echo Z >file1 &&
> +       git commit -a -m "one file conflict" &&
> +       set_fake_editor &&
> +       FAKE_LINES="edit 1 2" git rebase -i --strategy=recursive -Xours conflict-branch &&
> +       git rebase --continue &&
> +       test $(git show conflict-branch:conflict) = $(cat conflict) &&
> +       test $(cat file1) = Z
> +'
> +
>  test_expect_success 'rebase -i error on commits with \ in message' '
>         current_head=$(git rev-parse HEAD) &&
>         test_when_finished "git rebase --abort; git reset --hard $current_head; rm -f error" &&
> --
> 2.7.0.rc0.174.g1b62464
>
> --
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
