From: Stefan Beller <sbeller@google.com>
Subject: Re: [PATCH 47/83] builtin/apply: move applying patches into apply_all_patches()
Date: Mon, 25 Apr 2016 15:00:44 -0700
Message-ID: <CAGZ79kZ4UprHxtmO-rgiOo=od0U2nraq6m6wYcm_g87bsrL-Wg@mail.gmail.com>
References: <1461504863-15946-1-git-send-email-chriscool@tuxfamily.org>
	<1461504863-15946-48-git-send-email-chriscool@tuxfamily.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: "git@vger.kernel.org" <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>,
	Jeff King <peff@peff.net>,
	=?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
	Karsten Blees <karsten.blees@gmail.com>,
	Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Christian Couder <chriscool@tuxfamily.org>
To: Christian Couder <christian.couder@gmail.com>
X-From: git-owner@vger.kernel.org Tue Apr 26 00:00:53 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1auoYl-0001Xh-No
	for gcvg-git-2@plane.gmane.org; Tue, 26 Apr 2016 00:00:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965301AbcDYWAq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 25 Apr 2016 18:00:46 -0400
Received: from mail-ig0-f173.google.com ([209.85.213.173]:37984 "EHLO
	mail-ig0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965214AbcDYWAp (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 25 Apr 2016 18:00:45 -0400
Received: by mail-ig0-f173.google.com with SMTP id m9so75451375ige.1
        for <git@vger.kernel.org>; Mon, 25 Apr 2016 15:00:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc;
        bh=sFPqswODrGqYYic1tTBf1S+jPAOSvVqvDxVIp67f6Gw=;
        b=mVFQrp6TA1aozbUK/h7/CE961QE8MjDfdBzGzj8Q8XQyt7Ry+sPi0c6oke9xcyOWG5
         nr/bKf5KITN8Vn2unraPqCONKVyN/FF3o53MnCJOJtRANvn8mdHavEB4/SuQE/uGwWBe
         q40Pc/hB71tFTQ/mrnIgCgzBojp2avGQzNSUDF8CQBRywU0aYTHpnh4ogEmQGR1HswpW
         MA2kNbX1xBBgfPElXpTLvZ/mYacJ1CTBDNNo7ecgSbXwCWApsHgWva+UWyPWVUDZS9HR
         JEwUtj773Oj5MUDtgGY5XClWI3yFBd+W8GfIw38ySZpdfccxwPqvhHJVZB/dWEhIeHsb
         SDUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc;
        bh=sFPqswODrGqYYic1tTBf1S+jPAOSvVqvDxVIp67f6Gw=;
        b=IMboyFlWqTH3+kDxo3M9e+llJQZMvHVcvd+Vd4LaNYxq4Ig651frPstbmGTMZUid+d
         FY2LuPhBCyoUe83TefhnYF2QHZskonVMrvMRVatGiecuWGC/Z7zdW9Z9Oq62W6Pwz7/H
         hsch3xMCOzaV/FjtHn7iwtmrw26qwq7HhJB5WO+EuJjqHf71E2lUi9bOfa2p45sFhpox
         GThkTgThKQ4MTa29S1jL6L0+42RmopvpyqOPOLBp0n48t1rN2no15iNEkr5J/BJUva07
         dkuuT0VbHqwdDQ4FTLaIa7PtLu6nLQzjLmiK6tRG4RKG/ha+NUZ9XGjZJAGajoBq8Wdf
         waCg==
X-Gm-Message-State: AOPr4FVGKJ3Dvh9K/rUSdWi0iLEPRuy7IEFV87LMNQohtlPjQH+fZmspM/YyB/V/WWS/cdTkN+rhDgkHbWEDt4Jq
X-Received: by 10.50.98.195 with SMTP id ek3mr15403515igb.85.1461621644822;
 Mon, 25 Apr 2016 15:00:44 -0700 (PDT)
Received: by 10.107.2.3 with HTTP; Mon, 25 Apr 2016 15:00:44 -0700 (PDT)
In-Reply-To: <1461504863-15946-48-git-send-email-chriscool@tuxfamily.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/292574>

On Sun, Apr 24, 2016 at 6:33 AM, Christian Couder
<christian.couder@gmail.com> wrote:
> Signed-off-by: Christian Couder <chriscool@tuxfamily.org>

Up to this patch, have a
Reviewed-by: Stefan Beller <sbeller@google.com>
in case you want to split the series in here (as indicated in the
cover letter, this was the last
patch rerolled, the next patches are new and may need more discussion).

I had some nits, but they cleared up in later patches.

Thanks,
Stefan

> ---
>  builtin/apply.c | 128 ++++++++++++++++++++++++++++++--------------------------
>  1 file changed, 69 insertions(+), 59 deletions(-)
>
> diff --git a/builtin/apply.c b/builtin/apply.c
> index 94bf120..787426f 100644
> --- a/builtin/apply.c
> +++ b/builtin/apply.c
> @@ -4720,13 +4720,79 @@ static void check_apply_state(struct apply_state *state, int force_apply)
>                 state->unsafe_paths = 0;
>  }
>
> -int cmd_apply(int argc, const char **argv, const char *prefix_)
> +static int apply_all_patches(struct apply_state *state,
> +                            int argc,
> +                            const char **argv,
> +                            int options)
>  {
>         int i;
>         int errs = 0;
> +       int read_stdin = 1;
> +
> +       for (i = 0; i < argc; i++) {
> +               const char *arg = argv[i];
> +               int fd;
> +
> +               if (!strcmp(arg, "-")) {
> +                       errs |= apply_patch(state, 0, "<stdin>", options);
> +                       read_stdin = 0;
> +                       continue;
> +               } else if (0 < state->prefix_length)
> +                       arg = prefix_filename(state->prefix,
> +                                             state->prefix_length,
> +                                             arg);
> +
> +               fd = open(arg, O_RDONLY);
> +               if (fd < 0)
> +                       die_errno(_("can't open patch '%s'"), arg);
> +               read_stdin = 0;
> +               set_default_whitespace_mode(state);
> +               errs |= apply_patch(state, fd, arg, options);
> +               close(fd);
> +       }
> +       set_default_whitespace_mode(state);
> +       if (read_stdin)
> +               errs |= apply_patch(state, 0, "<stdin>", options);
> +
> +       if (state->whitespace_error) {
> +               if (state->squelch_whitespace_errors &&
> +                   state->squelch_whitespace_errors < state->whitespace_error) {
> +                       int squelched =
> +                               state->whitespace_error - state->squelch_whitespace_errors;
> +                       warning(Q_("squelched %d whitespace error",
> +                                  "squelched %d whitespace errors",
> +                                  squelched),
> +                               squelched);
> +               }
> +               if (state->ws_error_action == die_on_ws_error)
> +                       die(Q_("%d line adds whitespace errors.",
> +                              "%d lines add whitespace errors.",
> +                              state->whitespace_error),
> +                           state->whitespace_error);
> +               if (state->applied_after_fixing_ws && state->apply)
> +                       warning("%d line%s applied after"
> +                               " fixing whitespace errors.",
> +                               state->applied_after_fixing_ws,
> +                               state->applied_after_fixing_ws == 1 ? "" : "s");
> +               else if (state->whitespace_error)
> +                       warning(Q_("%d line adds whitespace errors.",
> +                                  "%d lines add whitespace errors.",
> +                                  state->whitespace_error),
> +                               state->whitespace_error);
> +       }
> +
> +       if (state->update_index) {
> +               if (write_locked_index(&the_index, &lock_file, COMMIT_LOCK))
> +                       die(_("Unable to write new index file"));
> +       }
> +
> +       return !!errs;
> +}
> +
> +int cmd_apply(int argc, const char **argv, const char *prefix_)
> +{
>         int force_apply = 0;
>         int options = 0;
> -       int read_stdin = 1;
>         struct apply_state state;
>
>         struct option builtin_apply_options[] = {
> @@ -4805,61 +4871,5 @@ int cmd_apply(int argc, const char **argv, const char *prefix_)
>
>         check_apply_state(&state, force_apply);
>
> -       for (i = 0; i < argc; i++) {
> -               const char *arg = argv[i];
> -               int fd;
> -
> -               if (!strcmp(arg, "-")) {
> -                       errs |= apply_patch(&state, 0, "<stdin>", options);
> -                       read_stdin = 0;
> -                       continue;
> -               } else if (0 < state.prefix_length)
> -                       arg = prefix_filename(state.prefix,
> -                                             state.prefix_length,
> -                                             arg);
> -
> -               fd = open(arg, O_RDONLY);
> -               if (fd < 0)
> -                       die_errno(_("can't open patch '%s'"), arg);
> -               read_stdin = 0;
> -               set_default_whitespace_mode(&state);
> -               errs |= apply_patch(&state, fd, arg, options);
> -               close(fd);
> -       }
> -       set_default_whitespace_mode(&state);
> -       if (read_stdin)
> -               errs |= apply_patch(&state, 0, "<stdin>", options);
> -       if (state.whitespace_error) {
> -               if (state.squelch_whitespace_errors &&
> -                   state.squelch_whitespace_errors < state.whitespace_error) {
> -                       int squelched =
> -                               state.whitespace_error - state.squelch_whitespace_errors;
> -                       warning(Q_("squelched %d whitespace error",
> -                                  "squelched %d whitespace errors",
> -                                  squelched),
> -                               squelched);
> -               }
> -               if (state.ws_error_action == die_on_ws_error)
> -                       die(Q_("%d line adds whitespace errors.",
> -                              "%d lines add whitespace errors.",
> -                              state.whitespace_error),
> -                           state.whitespace_error);
> -               if (state.applied_after_fixing_ws && state.apply)
> -                       warning("%d line%s applied after"
> -                               " fixing whitespace errors.",
> -                               state.applied_after_fixing_ws,
> -                               state.applied_after_fixing_ws == 1 ? "" : "s");
> -               else if (state.whitespace_error)
> -                       warning(Q_("%d line adds whitespace errors.",
> -                                  "%d lines add whitespace errors.",
> -                                  state.whitespace_error),
> -                               state.whitespace_error);
> -       }
> -
> -       if (state.update_index) {
> -               if (write_locked_index(&the_index, &lock_file, COMMIT_LOCK))
> -                       die(_("Unable to write new index file"));
> -       }
> -
> -       return !!errs;
> +       return apply_all_patches(&state, argc, argv, options);
>  }
> --
> 2.8.1.300.g5fed0c0
>
