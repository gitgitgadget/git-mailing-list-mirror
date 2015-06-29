From: Stefan Beller <sbeller@google.com>
Subject: Re: [PATCH v4 42/44] builtin-am: implement legacy -b/--binary option
Date: Mon, 29 Jun 2015 13:05:57 -0700
Message-ID: <CAGZ79kaCV-PbMOBKgPAdX0VK3vWVYrJy_gQJF6dxX9JZhatpcg@mail.gmail.com>
References: <1435500366-31700-1-git-send-email-pyokagan@gmail.com>
	<1435500366-31700-43-git-send-email-pyokagan@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: "git@vger.kernel.org" <git@vger.kernel.org>,
	Johannes Schindelin <johannes.schindelin@gmx.de>
To: Paul Tan <pyokagan@gmail.com>
X-From: git-owner@vger.kernel.org Mon Jun 29 22:06:06 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z9fJc-0006GJ-60
	for gcvg-git-2@plane.gmane.org; Mon, 29 Jun 2015 22:06:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752102AbbF2UGA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 29 Jun 2015 16:06:00 -0400
Received: from mail-yk0-f170.google.com ([209.85.160.170]:33222 "EHLO
	mail-yk0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752461AbbF2UF6 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 29 Jun 2015 16:05:58 -0400
Received: by ykdt186 with SMTP id t186so124931393ykd.0
        for <git@vger.kernel.org>; Mon, 29 Jun 2015 13:05:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=a3eQmsu1hcoXmAB6oszHChOgbRjJ2LYz1TpZTrLVJF4=;
        b=MOU42zpiuUK/qqvIe5jWp1ccbOOuoiP6H4F2kj3ORcx2VYDlA2fGSOnY/TEc7s7ALc
         mG/IunHN2MyYwQGMBF8I57zzHhWxCuyyn6tWl+RxXKVKV+GP7DuFTAUNtu7ASTCR1vMt
         IsqIZnhuV6X5WJyGKIzlHlDyDP9qpqO2sx2LgI69sij/a+3pkBPjKRyysBGiKSIb+rPm
         T8Liv7RYuZJMWWU5AzN+OJ0xd9ioDl62kr9nMaIkLZbalUzv9FoZUIKF9I/5DrjTxdjr
         zNmGZ7G/aOWdFy9t8V/cc+p594c5d5KBo4nsC96BsOvZAy991ul9uBdZJqx+JNccwB4S
         FP1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type;
        bh=a3eQmsu1hcoXmAB6oszHChOgbRjJ2LYz1TpZTrLVJF4=;
        b=g6co8cN3RQ41f45ygudCEE+Cj5M+kyDyO/UVF9suzgunmIp2gkpTGMiUKrZJLfL5b9
         krQnSjWpAtToD8oC4TDuCy0rrjnXjZwEq4ymwIlED0+ZGlQ74pW/IFFGE7O9g7HZEQpS
         ptmNtmllyT9/6nrgnXwVD5DedfPoSS4Rgz6pWj2xydEOE9MolAlOxOJXY8gyXrrscR0x
         dpnYsEVuVhFgpYGXML3uQfnn6bEpAgsnZckOage7MdqcPL74qYTG2EZNM7XTpC2IMQpE
         Wv3H+4x7SEQhlHRnqqXo97KvPKaqRHRQ1o8nl0Xh3jEmqZ2KsXaHgTike45C24dlozUQ
         zyXw==
X-Gm-Message-State: ALoCoQlV0WNzDfGIJ28dU1VM84ren1tmI6JoAGu0Cs0B1I3QGi8WG/0ItIlaKUAfjJvXiB/ijN43
X-Received: by 10.170.94.84 with SMTP id l81mr20532334yka.101.1435608357786;
 Mon, 29 Jun 2015 13:05:57 -0700 (PDT)
Received: by 10.37.4.80 with HTTP; Mon, 29 Jun 2015 13:05:57 -0700 (PDT)
In-Reply-To: <1435500366-31700-43-git-send-email-pyokagan@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/273000>

On Sun, Jun 28, 2015 at 7:06 AM, Paul Tan <pyokagan@gmail.com> wrote:
> The -b/--binary option was initially implemented in 087b674 (git-am:
> --binary; document --resume and --binary., 2005-11-16). The option will
> pass the --binary flag to git-apply to allow it to apply binary patches.
>
> However, in 2b6eef9 (Make apply --binary a no-op., 2006-09-06), --binary
> was been made a no-op in git-apply. Following that, since cb3a160
> (git-am: ignore --binary option, 2008-08-09), the --binary option in
> git-am is ignored as well.
>
> In 6c15a1c (am: officially deprecate -b/--binary option, 2012-03-13),
> the --binary option was tweaked to its present behavior: when set, the
> message:
>
>         The -b/--binary option has been a no-op for long time, and it
>         will be removed. Please do not use it anymore.
>
> will be printed.

I wonder if now would be the right time? The rewrite aim's at full
feature compatibility, but we may want to revert this commit on
top of patch 44 later.

>
> Re-implement this in builtin/am.c.
>
> Signed-off-by: Paul Tan <pyokagan@gmail.com>
> ---
>  builtin/am.c | 7 +++++++
>  1 file changed, 7 insertions(+)
>
> diff --git a/builtin/am.c b/builtin/am.c
> index f148f05..a46aa74 100644
> --- a/builtin/am.c
> +++ b/builtin/am.c
> @@ -2148,6 +2148,7 @@ enum resume_mode {
>  int cmd_am(int argc, const char **argv, const char *prefix)
>  {
>         struct am_state state;
> +       int binary = -1;
>         int keep_cr = -1;
>         int patch_format = PATCH_FORMAT_UNKNOWN;
>         enum resume_mode resume = RESUME_FALSE;
> @@ -2161,6 +2162,8 @@ int cmd_am(int argc, const char **argv, const char *prefix)
>         struct option options[] = {
>                 OPT_BOOL('i', "interactive", &state.interactive,
>                         N_("run interactively")),
> +               OPT_HIDDEN_BOOL('b', "binary", &binary,
> +                       N_("(historical option -- no-op")),
>                 OPT_BOOL('3', "3way", &state.threeway,
>                         N_("allow fall back on 3way merging if needed")),
>                 OPT__QUIET(&state.quiet, N_("be quiet")),
> @@ -2261,6 +2264,10 @@ int cmd_am(int argc, const char **argv, const char *prefix)
>
>         argc = parse_options(argc, argv, prefix, options, usage, 0);
>
> +       if (binary >= 0)
> +               fprintf_ln(stderr, _("The -b/--binary option has been a no-op for long time, and\n"
> +                               "it will be removed. Please do not use it anymore."));
> +
>         if (read_index_preload(&the_index, NULL) < 0)
>                 die(_("failed to read the index"));
>
> --
> 2.5.0.rc0.76.gb2c6e93
>
