From: Stefan Beller <sbeller@google.com>
Subject: Re: [PATCH v4 31/44] builtin-am: implement -S/--gpg-sign, commit.gpgsign
Date: Mon, 29 Jun 2015 16:51:18 -0700
Message-ID: <CAGZ79kZSNXRfgngA6QsVwYiM=4nqk9rkuHxMOD-sPcaHKOPSkQ@mail.gmail.com>
References: <1435500366-31700-1-git-send-email-pyokagan@gmail.com>
	<1435500366-31700-32-git-send-email-pyokagan@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: "git@vger.kernel.org" <git@vger.kernel.org>,
	Johannes Schindelin <johannes.schindelin@gmx.de>
To: Paul Tan <pyokagan@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jun 30 01:51:31 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z9ipl-0004XU-Vu
	for gcvg-git-2@plane.gmane.org; Tue, 30 Jun 2015 01:51:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752102AbbF2XvV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 29 Jun 2015 19:51:21 -0400
Received: from mail-yk0-f177.google.com ([209.85.160.177]:36480 "EHLO
	mail-yk0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752003AbbF2XvT (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 29 Jun 2015 19:51:19 -0400
Received: by ykdr198 with SMTP id r198so129325742ykd.3
        for <git@vger.kernel.org>; Mon, 29 Jun 2015 16:51:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=TMv3iS6nlKZlzgDskE4vWQo2Xb1mJhkihdecV3IJXus=;
        b=T9xjUdKY8Fv8nved4UKM6qGBAJWm5jBsCZi75MpMlKb22wMpJhDway5R1h+3YZhYtr
         5WD9hU1KxQMkrQZXflHaudSxD12y+2kMCZgrYYk3bPQusXPT1e/anx3Ltn+BeVqkxVMv
         3Ah7t0/Vv2zfycdoK+sSO0mK6gI/yDtp4KambfR2U4AcCJGdzEwU9nKHsRk6pJ30kw2Z
         Z+u7Cg6OsLFMuFZgBTrhlbO3ehUJQYNFSNbVTwxshqsYMcVaT0wGwZEmFf2nqvOy9gmN
         hNSeNEQWfwkqSKOjWf2DAQSfQ704wXRa3OMoyPupsRhKRLm+EhvqSYI0nIyr9Q8QS5kf
         +tbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type;
        bh=TMv3iS6nlKZlzgDskE4vWQo2Xb1mJhkihdecV3IJXus=;
        b=J6V4Kn7Aeae4fcHudx08DSXsoCXomg4OaLzUp8Q+aGyjoAH7t6aYNxC6ZNE9jjmnRP
         pLLO7d4QzSu5I+awCH1N1q0D1Ii4sxaF7CqnNzqqQYmW+qSBSRjIXA49NDz+siN+ifBE
         eRknVSCeOAlOsGcwkLu7fVxh6jQd+ucUP4Hq6vnXKreqIG6Wq/0s9pLDa4KTdlX9qlky
         sLcdgS6fIXtDXYHK0q4x+j5EmBQibCtwAEFFP7P1nbBmAA7l4kfPaAV2UQCfi2fmVGKq
         TFi48pFDT37RF05213tYRqDIz5l/KbsmX6isuudToat0QJ4M8TKGUK83MUOGgVGpHrm2
         grkQ==
X-Gm-Message-State: ALoCoQnLWPqQAZTbJdzV5ZcsiDb6YamQWvnuITpA8XVzwn5TNi+wOaI2NYirrJBVwDis3OK1bs+y
X-Received: by 10.129.98.198 with SMTP id w189mr13033573ywb.32.1435621878776;
 Mon, 29 Jun 2015 16:51:18 -0700 (PDT)
Received: by 10.37.4.80 with HTTP; Mon, 29 Jun 2015 16:51:18 -0700 (PDT)
In-Reply-To: <1435500366-31700-32-git-send-email-pyokagan@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/273028>

On Sun, Jun 28, 2015 at 7:05 AM, Paul Tan <pyokagan@gmail.com> wrote:
> Since 3b4e395 (am: add the --gpg-sign option, 2014-02-01), git-am.sh
> supported the --gpg-sign option, and would pass it to git-commit-tree,
> thus GPG-signing the commit object.
>
> Re-implement this option in builtin/am.c.
>
> git-commit-tree would also sign the commit by default if the
> commit.gpgsign setting is true. Since we do not run commit-tree, we
> re-implement this behavior by handling the commit.gpgsign setting
> ourselves.
>
> Signed-off-by: Paul Tan <pyokagan@gmail.com>
> ---
>  builtin/am.c | 11 ++++++++++-
>  1 file changed, 10 insertions(+), 1 deletion(-)
>
> diff --git a/builtin/am.c b/builtin/am.c
> index 80850e8..d44f5e2 100644
> --- a/builtin/am.c
> +++ b/builtin/am.c
> @@ -124,6 +124,8 @@ struct am_state {
>
>         int ignore_date;
>
> +       const char *sign_commit;
> +
>         int rebasing;
>  };
>
> @@ -134,6 +136,7 @@ struct am_state {
>  static void am_state_init(struct am_state *state, const char *dir)
>  {
>         const char *quiet;
> +       int sign_commit;

I needed to read this patch a few times as this patch introduces `sign_commit`
twice. This is mostly a review problem I'd guess as in the code it
just affects this
method and you'd see all the code of the method easily compared to hunks sent
via email. But renaming this variable doesn't hurt.

>
>         memset(state, 0, sizeof(*state));
>
> @@ -155,6 +158,9 @@ static void am_state_init(struct am_state *state, const char *dir)
>         state->scissors = SCISSORS_UNSET;
>
>         argv_array_init(&state->git_apply_opts);
> +
> +       if (!git_config_get_bool("commit.gpgsign", &sign_commit))
> +               state->sign_commit = sign_commit ? "" : NULL;
>  }
>
>  /**
> @@ -1272,7 +1278,7 @@ static void do_commit(const struct am_state *state)
>                         state->ignore_date ? "" : state->author_date, 1);
>
>         if (commit_tree(state->msg, state->msg_len, tree, parents, commit,
> -                               author, NULL))
> +                               author, state->sign_commit))
>                 die(_("failed to write commit object"));
>
>         reflog_msg = getenv("GIT_REFLOG_ACTION");
> @@ -1694,6 +1700,9 @@ int cmd_am(int argc, const char **argv, const char *prefix)
>                         N_("lie about committer date")),
>                 OPT_BOOL(0, "ignore-date", &state.ignore_date,
>                         N_("use current timestamp for author date")),
> +               { OPTION_STRING, 'S', "gpg-sign", &state.sign_commit, N_("key-id"),
> +                 N_("GPG-sign commits"),
> +                 PARSE_OPT_OPTARG, NULL, (intptr_t) "" },
>                 OPT_HIDDEN_BOOL(0, "rebasing", &state.rebasing,
>                         N_("(internal use for git-rebase)")),
>                 OPT_END()
> --
> 2.5.0.rc0.76.gb2c6e93
>
