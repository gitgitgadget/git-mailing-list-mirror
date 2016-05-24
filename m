From: Christian Couder <christian.couder@gmail.com>
Subject: Re: [PATCH v8 3/3] bisect--helper: `write_terms` shell function in C
Date: Tue, 24 May 2016 09:33:18 +0200
Message-ID: <CAP8UFD1WZ=5e9u5awrHDG-vhMR5dw5NNY_yVEkp2o0rgx59nnQ@mail.gmail.com>
References: <1464014928-31548-1-git-send-email-pranit.bauva@gmail.com>
	<20160524072124.2945-1-pranit.bauva@gmail.com>
	<20160524072124.2945-4-pranit.bauva@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git <git@vger.kernel.org>,
	Lars Schneider <larsxschneider@gmail.com>,
	Christian Couder <chriscool@tuxfamily.org>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: Pranit Bauva <pranit.bauva@gmail.com>
X-From: git-owner@vger.kernel.org Tue May 24 09:33:27 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b56qD-0006b0-Ik
	for gcvg-git-2@plane.gmane.org; Tue, 24 May 2016 09:33:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752275AbcEXHdV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 24 May 2016 03:33:21 -0400
Received: from mail-wm0-f67.google.com ([74.125.82.67]:32918 "EHLO
	mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751937AbcEXHdU (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 24 May 2016 03:33:20 -0400
Received: by mail-wm0-f67.google.com with SMTP id 67so3359590wmg.0
        for <git@vger.kernel.org>; Tue, 24 May 2016 00:33:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc;
        bh=3vf9LMJLllugkWFhUDIoJFC9C+WuPMtBkO/h8hkHoyM=;
        b=EEC/f70JcW27Ia26lVSt+IrNpVBymU0bpKrPeirxAmXkz0ttD0cGWCakEY051c65z2
         aj+7vgnm4T0kdeYvAJDoVw42tRO0+gnRbtK5aK9SKz1fe2m3UhFE02iM4QKSxpe5Jsqc
         epD6FEAc4nmshmLdflNCwQOj4WZn/0DibwKF4bHrXFHUYRp7kE38Zjkp4hOaaAPXnWQP
         +LD6pWFnhVWQztIM3VhAC8G3lZn+7a/i/x9b0m/Zx7AOwpKmLbSQBeRUArX6mT82p1QU
         BaTjsYyx100TIbUURkSD4aDGQ8NVjFPMZkLVT9+qmydeootTmeCpa8vcIXQDouifKRrS
         DCXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc;
        bh=3vf9LMJLllugkWFhUDIoJFC9C+WuPMtBkO/h8hkHoyM=;
        b=GV/hqZHZSID3gFLQ48YQc3UV6evEy0Rvud3BlOAXF4YdM56ctw0MyDr8S1DQdM/Xdy
         wi/81nByHQQJB2gjziy5+6V/ulNtwNPGJj7rlBjk7ztQ8oiKpljZSLk/1d9pST9nNbFd
         oJLCf2BWgiZDP21CrQbj/te5b1DDcG/WxgWTOBuiIabmhc0f00WZu5bus8UOY0fqcuYp
         43A1LM2HiPuA5jSbXE515uDB6lSrgQ/slbgy9I0XaygkjJTTC8sCdowBDaJskZ/hmnzp
         AZPDS6ciG5mwPtkXIJDaT2n/PGkIKMhRHhcmH5BuP+m0DXHnjnF//FKBJrxT4Mj1R/5A
         z1UQ==
X-Gm-Message-State: ALyK8tIsDI9D8CFl7bTIoXnds4wkw1srwUlIhN9YkZnLkOAzWAD1rgQjsULaNJfJMPto+NqjeFDilHqlc+g9JA==
X-Received: by 10.28.23.143 with SMTP id 137mr665416wmx.89.1464075199002; Tue,
 24 May 2016 00:33:19 -0700 (PDT)
Received: by 10.194.148.146 with HTTP; Tue, 24 May 2016 00:33:18 -0700 (PDT)
In-Reply-To: <20160524072124.2945-4-pranit.bauva@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/295425>

On Tue, May 24, 2016 at 9:21 AM, Pranit Bauva <pranit.bauva@gmail.com> wrote:
> Reimplement the `write_terms` shell function in C and add a `write-terms`
> subcommand to `git bisect--helper` to call it from git-bisect.sh . Also
> remove the subcommand `--check-term-format` as it can now be called from
> inside the function write_terms() C implementation.
>
> Also `|| exit` is added when calling write-terms subcommand from
> git-bisect.sh so as to exit whenever there is an error.
>
> Using `--write-terms` subcommand is a temporary measure to port shell
> function to C so as to use the existing test suite. As more functions
> are ported, this subcommand will be retired and will be called by some
> other method.
>
> Mentored-by: Lars Schneider <larsxschneider@gmail.com>
> Mentored-by: Christian Couder <chriscool@tuxfamily.org>
> Signed-off-by: Pranit Bauva <pranit.bauva@gmail.com>
> ---
>  builtin/bisect--helper.c | 36 +++++++++++++++++++++++++++++-------
>  git-bisect.sh            | 22 +++++++---------------
>  2 files changed, 36 insertions(+), 22 deletions(-)
>
> diff --git a/builtin/bisect--helper.c b/builtin/bisect--helper.c
> index 3c748d1..91027b0 100644
> --- a/builtin/bisect--helper.c
> +++ b/builtin/bisect--helper.c
> @@ -4,9 +4,11 @@
>  #include "bisect.h"
>  #include "refs.h"
>
> +static GIT_PATH_FUNC(git_path_bisect_write_terms, "BISECT_TERMS")
> +
>  static const char * const git_bisect_helper_usage[] = {
>         N_("git bisect--helper --next-all [--no-checkout]"),
> -       N_("git bisect--helper --check-term-format <term> <orig_term>"),
> +       N_("git bisect--helper --write-terms <bad_term> <good_term>"),
>         NULL
>  };
>
> @@ -56,18 +58,38 @@ static int check_term_format(const char *term, const char *orig_term)
>         return 0;
>  }
>
> +static int write_terms(const char *bad, const char *good)
> +{
> +       FILE *fp;
> +       int res;
> +
> +       if (!strcmp(bad, good))
> +               return error(_("please use two different terms"));
> +
> +       if (check_term_format(bad, "bad") || check_term_format(good, "good"))
> +               return -1;
> +
> +       fp = fopen(git_path_bisect_write_terms(), "w");
> +       if (!fp)
> +               return error_errno(_("could not open the file BISECT_TERMS"));
> +
> +       res = fprintf(fp, "%s\n%s\n", bad, good);
> +       fclose(fp);
> +       return (res < 0) ? -1 : 0;
> +}
> +
>  int cmd_bisect__helper(int argc, const char **argv, const char *prefix)
>  {
>         enum {
>                 NEXT_ALL = 1,
> -               CHECK_TERM_FMT
> +               WRITE_TERMS
>         } cmdmode = 0;
>         int no_checkout = 0;
>         struct option options[] = {
>                 OPT_CMDMODE(0, "next-all", &cmdmode,
>                          N_("perform 'git bisect next'"), NEXT_ALL),
> -               OPT_CMDMODE(0, "check-term-format", &cmdmode,
> -                        N_("check format of the term"), CHECK_TERM_FMT),
> +               OPT_CMDMODE(0, "write-terms", &cmdmode,
> +                        N_("write the terms to .git/BISECT_TERMS"), WRITE_TERMS),
>                 OPT_BOOL(0, "no-checkout", &no_checkout,
>                          N_("update BISECT_HEAD instead of checking out the current commit")),
>                 OPT_END()
> @@ -82,10 +104,10 @@ int cmd_bisect__helper(int argc, const char **argv, const char *prefix)
>         switch (cmdmode) {
>         case NEXT_ALL:
>                 return bisect_next_all(prefix, no_checkout);
> -       case CHECK_TERM_FMT:
> +       case WRITE_TERMS:
>                 if (argc != 2)
> -                       die(_("--check-term-format requires two arguments"));
> -               return check_term_format(argv[0], argv[1]);
> +                       die(_("--write-terms requires two arguments"));
> +               return write_terms(argv[0], argv[1]);
>         default:
>                 die("BUG: unknown subcommand '%d'", cmdmode);
>         }
> diff --git a/git-bisect.sh b/git-bisect.sh
> index 7d7965d..cd39bd0 100755
> --- a/git-bisect.sh
> +++ b/git-bisect.sh
> @@ -210,7 +210,7 @@ bisect_start() {
>         eval "$eval true" &&
>         if test $must_write_terms -eq 1
>         then
> -               write_terms "$TERM_BAD" "$TERM_GOOD"
> +               git bisect--helper --write-terms "$TERM_BAD" "$TERM_GOOD" || exit

This `|| exit` is not needed because...

>         fi &&
>         echo "git bisect start$orig_args" >>"$GIT_DIR/BISECT_LOG" || exit

... there is an `|| exit` on the line above (which is chained using
`&&` to the previous lines).
