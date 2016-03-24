From: Jacob Keller <jacob.keller@gmail.com>
Subject: Re: [PATCH 3/4] submodule--helper list: lose the extra prefix option
Date: Thu, 24 Mar 2016 16:44:35 -0700
Message-ID: <CA+P7+xrZ+HrcB15nc7LhEe5MnNin7n-PXCYb_iZ2ZwSDg0smHw@mail.gmail.com>
References: <1458862468-12460-1-git-send-email-sbeller@google.com> <1458862468-12460-4-git-send-email-sbeller@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git mailing list <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>,
	Duy Nguyen <pclouds@gmail.com>,
	Jens Lehmann <Jens.Lehmann@web.de>
To: Stefan Beller <sbeller@google.com>
X-From: git-owner@vger.kernel.org Fri Mar 25 00:45:02 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ajEw0-00037F-OP
	for gcvg-git-2@plane.gmane.org; Fri, 25 Mar 2016 00:45:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751728AbcCXXo5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 24 Mar 2016 19:44:57 -0400
Received: from mail-ig0-f182.google.com ([209.85.213.182]:33614 "EHLO
	mail-ig0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750949AbcCXXoz (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 24 Mar 2016 19:44:55 -0400
Received: by mail-ig0-f182.google.com with SMTP id ig19so4376411igb.0
        for <git@vger.kernel.org>; Thu, 24 Mar 2016 16:44:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=TKV2HNq5wwKIt6+O45t0bZz4iwtBP+KJa/l2Ju8aysY=;
        b=aEp7O75Frr+9/k4MTpG3A6tCdj+A/+Mn7NoZYa9kzSZRLK3qyRGLnZEg3GLbgyfGEs
         tBed0dRVEiAj+600d605UfRdeWKLoeEMHNKxaqAel02hoxDG04WYYQ2wG8uV2W4vVrbI
         aMDGPc1WPGkfdJTpC7m3EP+T48oHL5KMKohU6tZI8dKpvAWhcm0l0qlxaSpdVWKKENqx
         W6Ox8cbfHPsKDW001hXK6g5IbaiLwATlRbZ211ZjNFvayweT5nLm4FtNJ+mvN0riepPF
         hKSdVUr4kF/p2k81zanJJ2meU1GSYpRQCBxVqV8L252tAl2/gp2pzxaPBvD8srvYdLOw
         jpPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=TKV2HNq5wwKIt6+O45t0bZz4iwtBP+KJa/l2Ju8aysY=;
        b=Lxt9WKPO8plDXAx35Egq1rveIgP95nbL5hx2wSbpv5oChno82oy4QKwVtQ0JfkQGgU
         270/7HBI2PYtZWqZ2tFEPRA5CuzX8Q9eC/GY+zktM26AY5f2+Pqw9y9M1IyxsfHPhgEZ
         sUPOsQy4+dt55C7LEooG/WFrWGO2WDBhVPpQ6GjFh5xEPrecPQXfZi4gtjKDKFfkv87Q
         6Oc4Qknehh/ZiIyRa2xVQdeO6GC70sLkIrIJ1hiDr415K1BreJbCw3vDgn5Di0WHUfP6
         t7YUE2AA5ZLZOZlsYCGyyte0OtLyc1PIFT8fl0ZtPXZ7Z+zqdqwMZFz2Xbx88M+dk4T0
         qMCw==
X-Gm-Message-State: AD7BkJIDOyUUnwEoHUWQDKLe+/PAsrg0atmpe3YHKaF08AKhtcbPOa/88dwuPXh4E1AlBjh7p5PJxACSE8mCjQ==
X-Received: by 10.50.143.105 with SMTP id sd9mr31022364igb.73.1458863094729;
 Thu, 24 Mar 2016 16:44:54 -0700 (PDT)
Received: by 10.107.10.202 with HTTP; Thu, 24 Mar 2016 16:44:35 -0700 (PDT)
In-Reply-To: <1458862468-12460-4-git-send-email-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/289831>

On Thu, Mar 24, 2016 at 4:34 PM, Stefan Beller <sbeller@google.com> wrote:
> The usual early machinery of Git is to change the directory to
> the top level of the working tree and pass the actual path inside
> the working tree as `prefix` to the command being run.
> This is the case both for commands written in C (where the
> prefix is passed into the command in a function parameter) as
> well as in git-submodule.sh where the setup code runs
>
>   wt_prefix=$(git rev-parse show-prefix)
>   cd_to_top_level
>
> So the prefix passed into the `submodule--helper list` is actually
> the relative path inside the working tree, but we were not using
> the standard way of passing it through.
>
> Adhere to Gits standard of passing the relative path inside the
> working tree by passing it via -C.
>
> We do not need to pass it for `submodule foreach` as that command
> doesn't take further arguments ('$@') to operate on a subset of
> submodules, such that it is irrelevant for listing the submodules.
> The computation of the displaypath ('Entering <path>') is done
> separately there.
>
> Signed-off-by: Stefan Beller <sbeller@google.com>
> ---

It is nice to see the format for doing this standardized, and reduce
extra code in the submodule--helper. I had wondered why we used
--prefix before.

Reviewed-by: Jacob Keller <jacob.e.keller@intel.com>

>  builtin/submodule--helper.c |  5 +----
>  git-submodule.sh            | 12 ++++++------
>  2 files changed, 7 insertions(+), 10 deletions(-)
>
> diff --git a/builtin/submodule--helper.c b/builtin/submodule--helper.c
> index ed764c9..2983783 100644
> --- a/builtin/submodule--helper.c
> +++ b/builtin/submodule--helper.c
> @@ -68,14 +68,11 @@ static int module_list(int argc, const char **argv, const char *prefix)
>         struct module_list list = MODULE_LIST_INIT;
>
>         struct option module_list_options[] = {
> -               OPT_STRING(0, "prefix", &prefix,
> -                          N_("path"),
> -                          N_("alternative anchor for relative paths")),
>                 OPT_END()
>         };
>
>         const char *const git_submodule_helper_usage[] = {
> -               N_("git submodule--helper list [--prefix=<path>] [<path>...]"),
> +               N_("git submodule--helper list [<path>...]"),
>                 NULL
>         };
>
> diff --git a/git-submodule.sh b/git-submodule.sh
> index 6b18a03..1f7ad6e 100755
> --- a/git-submodule.sh
> +++ b/git-submodule.sh
> @@ -407,7 +407,7 @@ cmd_foreach()
>         # command in the subshell (and a recursive call to this function)
>         exec 3<&0
>
> -       git submodule--helper list --prefix "$wt_prefix"|
> +       git submodule--helper list |
>         while read mode sha1 stage sm_path
>         do
>                 die_if_unmatched "$mode"
> @@ -467,7 +467,7 @@ cmd_init()
>                 shift
>         done
>
> -       git submodule--helper list --prefix "$wt_prefix" "$@" |
> +       git -C "$wt_prefix" submodule--helper list "$@" |
>         while read mode sha1 stage sm_path
>         do
>                 die_if_unmatched "$mode"
> @@ -549,7 +549,7 @@ cmd_deinit()
>                 die "$(eval_gettext "Use '.' if you really want to deinitialize all submodules")"
>         fi
>
> -       git submodule--helper list --prefix "$wt_prefix" "$@" |
> +       git -C "$wt_prefix" submodule--helper list "$@" |
>         while read mode sha1 stage sm_path
>         do
>                 die_if_unmatched "$mode"
> @@ -683,7 +683,7 @@ cmd_update()
>         fi
>
>         cloned_modules=
> -       git submodule--helper list --prefix "$wt_prefix" "$@" | {
> +       git -C "$wt_prefix" submodule--helper list "$@" | {
>         err=
>         while read mode sha1 stage sm_path
>         do
> @@ -1121,7 +1121,7 @@ cmd_status()
>                 shift
>         done
>
> -       git submodule--helper list --prefix "$wt_prefix" "$@" |
> +       git -C "$wt_prefix" submodule--helper list "$@" |
>         while read mode sha1 stage sm_path
>         do
>                 die_if_unmatched "$mode"
> @@ -1199,7 +1199,7 @@ cmd_sync()
>                 esac
>         done
>         cd_to_toplevel
> -       git submodule--helper list --prefix "$wt_prefix" "$@" |
> +       git -C "$wt_prefix" submodule--helper list "$@" |
>         while read mode sha1 stage sm_path
>         do
>                 die_if_unmatched "$mode"
> --
> 2.8.0.rc4.10.g52f3f33
>

Regards,
Jake
