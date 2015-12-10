From: Stefan Beller <sbeller@google.com>
Subject: Re: [PATCH 2/2] push: Use "last one wins" convention for --recurse-submodules
Date: Thu, 10 Dec 2015 15:31:42 -0800
Message-ID: <CAGZ79kbxvrMHnJx9iACus44+rmFf6ZNFPArrpVhNr6ZTDj+XOg@mail.gmail.com>
References: <20151203131006.GA5119@mcrowe.com>
	<1449148235-29569-1-git-send-email-mac@mcrowe.com>
	<1449148235-29569-2-git-send-email-mac@mcrowe.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: "git@vger.kernel.org" <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>
To: Mike Crowe <mac@mcrowe.com>
X-From: git-owner@vger.kernel.org Fri Dec 11 00:31:56 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1a7Agh-0000fa-Fm
	for gcvg-git-2@plane.gmane.org; Fri, 11 Dec 2015 00:31:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754213AbbLJXbq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 10 Dec 2015 18:31:46 -0500
Received: from mail-io0-f181.google.com ([209.85.223.181]:33184 "EHLO
	mail-io0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754183AbbLJXbn (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 10 Dec 2015 18:31:43 -0500
Received: by iouu10 with SMTP id u10so111812799iou.0
        for <git@vger.kernel.org>; Thu, 10 Dec 2015 15:31:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=obzQs5Z8N3DlowBEHQiOVFbL5FFiUk+/3lVFiieD2m0=;
        b=JmkGJXYuZrCvShUTduqifXeTRoyCuVZxm72i/1XykEQGWMxsVh8QJckA4UTGdxMiUb
         K1Wfv0sroJ3O4MvWGCEE8WmxF/0cWiXy7IP7u2N2BfOzyfqteRjF5oLXNhjTiHHoXhEF
         n7ejptxoyqZhBenUhTz6EJwiB7Eb0B7NsiN5CrSde2xSQjyOpY4TVCi8RIt9mBBq1shS
         6SLME4bpPv+YnNueRZsUsxsOD84mZzX3n94bIoDplH2bbTKSzYcczsgqaCxv0PFMbNB4
         Cs4VSkBdH0hinRzSiJNC7daSAEiav/G5VGQXIaSkxeR0J2X+RiJ03CfpwzAMNGqeZ2T3
         2oxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type;
        bh=obzQs5Z8N3DlowBEHQiOVFbL5FFiUk+/3lVFiieD2m0=;
        b=DbwQqsb1JHSkEezUljTjCHpF2LujyL55486TSYmkSpC2G/yJ4lUiLPa5qTxmgGlwdH
         JulSL5dO9XQ19daFuap/uzmz+8nm1DpIXeW9YGXZNOa+5RlJrNir3rRzWnBpatAt4mRY
         +m2Hb50EhW+7tFkRuX/BjVU77KbbG6wwq/NJBJ4iLHPVze9iqdNOdDU7AqldXmATvYvp
         bhhuI1AwNZIyuNbOMHfy53Rp44SL5/YB+sKrGrkGcUkqEyK/SO4gmQL5R45sxp6slV3X
         WpHrCAwBwZDaYcpwxX0N9yH00GygU0CdHsMV/7M+2u7ITG0l2QIDJDMUHcQpmVMgt5RL
         NoKQ==
X-Gm-Message-State: ALoCoQly9Lmy+Bht2ZFJu51SPUTO/Omw2dQCmofEf0wJQu9YFjVzawiX2RSbsNk42VQn7cNjZ/a/Nw9BlRQwwCsze5V6C6VxYxP1paBGaAHzinw/MRRan3g=
X-Received: by 10.107.129.164 with SMTP id l36mr13649446ioi.174.1449790302418;
 Thu, 10 Dec 2015 15:31:42 -0800 (PST)
Received: by 10.107.19.26 with HTTP; Thu, 10 Dec 2015 15:31:42 -0800 (PST)
In-Reply-To: <1449148235-29569-2-git-send-email-mac@mcrowe.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/282240>

On Thu, Dec 3, 2015 at 5:10 AM, Mike Crowe <mac@mcrowe.com> wrote:
> Use the "last one wins" convention for --recurse-submodules rather than
> treating conflicting options as an error.
>
> Also, fix the declaration of the file-scope recurse_submodules global
> variable to put it on a separate line.
>
> Signed-off-by: Mike Crowe <mac@mcrowe.com>
> ---
>  builtin/push.c                 | 12 +++---------
>  t/t5531-deep-submodule-push.sh | 41 +++++++++++++++++++++++++++++++++++++++++
>  2 files changed, 44 insertions(+), 9 deletions(-)
>
> diff --git a/builtin/push.c b/builtin/push.c
> index f9b59b4..cc29277 100644
> --- a/builtin/push.c
> +++ b/builtin/push.c
> @@ -21,7 +21,8 @@ static int thin = 1;
>  static int deleterefs;
>  static const char *receivepack;
>  static int verbosity;
> -static int progress = -1, recurse_submodules = RECURSE_SUBMODULES_DEFAULT;
> +static int progress = -1;
> +static int recurse_submodules = RECURSE_SUBMODULES_DEFAULT;
>
>  static struct push_cas_option cas;
>
> @@ -455,9 +456,6 @@ static int option_parse_recurse_submodules(const struct option *opt,
>  {
>         int *recurse_submodules = opt->value;
>
> -       if (*recurse_submodules != RECURSE_SUBMODULES_DEFAULT)
> -               die("%s can only be used once.", opt->long_name);
> -
>         if (unset)
>                 *recurse_submodules = RECURSE_SUBMODULES_OFF;
>         else if (arg)
> @@ -532,7 +530,6 @@ int cmd_push(int argc, const char **argv, const char *prefix)
>         int flags = 0;
>         int tags = 0;
>         int push_cert = -1;
> -       int recurse_submodules_from_cmdline = RECURSE_SUBMODULES_DEFAULT;
>         int rc;
>         const char *repo = NULL;        /* default repository */
>         struct option options[] = {
> @@ -550,7 +547,7 @@ int cmd_push(int argc, const char **argv, const char *prefix)
>                   0, CAS_OPT_NAME, &cas, N_("refname>:<expect"),
>                   N_("require old value of ref to be at this value"),
>                   PARSE_OPT_OPTARG, parseopt_push_cas_option },
> -               { OPTION_CALLBACK, 0, "recurse-submodules", &recurse_submodules_from_cmdline, N_("check|on-demand|no"),
> +               { OPTION_CALLBACK, 0, "recurse-submodules", &recurse_submodules, N_("check|on-demand|no"),
>                         N_("control recursive pushing of submodules"),
>                         PARSE_OPT_OPTARG, option_parse_recurse_submodules },
>                 OPT_BOOL( 0 , "thin", &thin, N_("use thin pack")),
> @@ -581,9 +578,6 @@ int cmd_push(int argc, const char **argv, const char *prefix)
>         if (deleterefs && argc < 2)
>                 die(_("--delete doesn't make sense without any refs"));
>
> -       if (recurse_submodules_from_cmdline != RECURSE_SUBMODULES_DEFAULT)
> -               recurse_submodules = recurse_submodules_from_cmdline;
> -
>         if (recurse_submodules == RECURSE_SUBMODULES_CHECK)
>                 flags |= TRANSPORT_RECURSE_SUBMODULES_CHECK;
>         else if (recurse_submodules == RECURSE_SUBMODULES_ON_DEMAND)
> diff --git a/t/t5531-deep-submodule-push.sh b/t/t5531-deep-submodule-push.sh
> index 721be32..198ce84 100755
> --- a/t/t5531-deep-submodule-push.sh
> +++ b/t/t5531-deep-submodule-push.sh
> @@ -171,6 +171,47 @@ test_expect_success 'push recurse-submodules on command line overrides config' '
>         )
>  '
>
> +test_expect_success 'push recurse-submodules last one wins on command line' '
> +       (
> +               cd work/gar/bage &&
> +               >recurse-check-on-command-line-overriding-earlier-command-line &&
> +               git add recurse-check-on-command-line-overriding-earlier-command-line &&
> +               git commit -m "Recurse on command-line overridiing earlier command-line junk"
> +       ) &&
> +       (
> +               cd work &&
> +               git add gar/bage &&
> +               git commit -m "Recurse on command-line overriding earlier command-line for gar/bage" &&
> +
> +               # should result in "check"
> +               test_must_fail git push --recurse-submodules=on-demand --recurse-submodules=check ../pub.git master &&
> +               # Check that the supermodule commit did not get there
> +               git fetch ../pub.git &&
> +               git diff --quiet FETCH_HEAD master^ &&
> +               # Check that the submodule commit did not get there
> +               (cd gar/bage && git diff --quiet origin/master master^) &&
> +
> +               # should result in "no"
> +               git push --recurse-submodules=on-demand --recurse-submodules=no ../pub.git master &&
> +               # Check that the supermodule commit did get there
> +               git fetch ../pub.git &&
> +               git diff --quiet FETCH_HEAD master &&
> +               # Check that the submodule commit did not get there
> +               (cd gar/bage && git diff --quiet origin/master master^) &&
> +
> +               # should result in "no"
> +               git push --recurse-submodules=on-demand --no-recurse-submodules ../pub.git master &&
> +               # Check that the submodule commit did not get there

Do we want to check here that the supermodule commit did get there,
instead of only checking the submodule?
I just wonder why we stop checking the superproject starting here, so
either it makes sense to drop
that check before or continue to check the superproject check here, no?

> +               (cd gar/bage && git diff --quiet origin/master master^) &&
> +
> +               # But the options in the other order should push the submodule
> +               git push --recurse-submodules=check --recurse-submodules=on-demand ../pub.git master &&
> +               # Check that the submodule commit did get there
> +               git fetch ../pub.git &&
> +               (cd gar/bage && git diff --quiet origin/master master)
> +       )
> +'
> +
>  test_expect_success 'push succeeds if submodule commit not on remote using on-demand from cmdline overriding config' '
>         (
>                 cd work/gar/bage &&
> --
> 2.1.4
>
> --
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
