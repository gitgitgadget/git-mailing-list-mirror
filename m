From: Stefan Beller <sbeller@google.com>
Subject: Re: [PATCH v6 5/7] submodule: fix segmentation fault in
 submodule--helper clone
Date: Mon, 29 Feb 2016 15:20:53 -0800
Message-ID: <CAGZ79kZdct21==TeRoVr4NpgeKuHeUfpJ1Qsh+_tPJt0apr5DA@mail.gmail.com>
References: <1456786715-24256-1-git-send-email-jacob.e.keller@intel.com>
	<1456786715-24256-6-git-send-email-jacob.e.keller@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: "git@vger.kernel.org" <git@vger.kernel.org>,
	Jeff King <peff@peff.net>,
	Mark Strapetz <marc.strapetz@syntevo.com>,
	Junio C Hamano <gitster@pobox.com>,
	Jacob Keller <jacob.keller@gmail.com>
To: Jacob Keller <jacob.e.keller@intel.com>
X-From: git-owner@vger.kernel.org Tue Mar 01 00:21:01 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aaX7b-0000WV-TK
	for gcvg-git-2@plane.gmane.org; Tue, 01 Mar 2016 00:21:00 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752769AbcB2XUz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 29 Feb 2016 18:20:55 -0500
Received: from mail-ig0-f173.google.com ([209.85.213.173]:33731 "EHLO
	mail-ig0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750942AbcB2XUy (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 29 Feb 2016 18:20:54 -0500
Received: by mail-ig0-f173.google.com with SMTP id y8so7638814igp.0
        for <git@vger.kernel.org>; Mon, 29 Feb 2016 15:20:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc;
        bh=Xri7mkdRVQxZ9qta6zAiCQRnYKdg9ic3DneDJmQpVm0=;
        b=LftfOoZvZEIVi9NxoxiedGjVcND2ti8kHqPrRw3sJ5iZF9LNM2klTp+AZ5syG/nvpP
         d4pgaV1ExK2Xl0RwwV4zn83OTHW/h1Ly7YZ86PSaz/Cm7GuZvXjt2IZN06jzYUbMVsiP
         oBR2Vzzpr+etMMqyDyBHpbPZgc20Q6fAwcewNInLvcmOWfXL+hk6pe4dgOzqB/TYdepp
         U+SaB+TDZSenOekX9QdBA1jY0yOMvDc9rRNAZR3j9N1+Nx2yQGvB+LQi3KKYwJXp7Lch
         nzhSliKDEqwxT9+WtK4c3dwzkyzv88CZtQU98oWsJWAA+qX4bH9GJsLh4T/ZYhWJDfMk
         PkKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc;
        bh=Xri7mkdRVQxZ9qta6zAiCQRnYKdg9ic3DneDJmQpVm0=;
        b=hIM5N1ImCz8Z8aAs1dNz1Z+FnE+3iH9VDLIgSuanKWY1BrOl2fQo+d0MvcipjjYwip
         hZ5D2sab2U5/5PdJuzIdssxCxcwBflnIK78tpIz7Fu3UaPPquchG3WcJix2WMlNKqAc6
         UIo2MVCsYsBil+6GjGjLef0nkgnufUOi0K/zzIMOsMvyKvkgxVqMs/OyO28mYz30v8WT
         p3dJpAJKxviY/Y/l+XYZZFawtchwCsQvXDQs0mqzCgvlF2LmkEL3QmcC6ZHBJos7VKzm
         LpFoav+1tTiK4D0AaYGO45gLmpzqqg30dw9TLuAbue/71y3Mc/2HN43JhS4j4TxzRkRy
         SFJg==
X-Gm-Message-State: AD7BkJKUxnencSN3sHDmsHeNmY/ZhYExY8MvAenYJO6La6EDzSZy6F+ooIZ3XeVXMnIOJ7en0+Zg9UQwbjGH/Qna
X-Received: by 10.50.112.10 with SMTP id im10mr460087igb.93.1456788053900;
 Mon, 29 Feb 2016 15:20:53 -0800 (PST)
Received: by 10.107.58.6 with HTTP; Mon, 29 Feb 2016 15:20:53 -0800 (PST)
In-Reply-To: <1456786715-24256-6-git-send-email-jacob.e.keller@intel.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/287937>

On Mon, Feb 29, 2016 at 2:58 PM, Jacob Keller <jacob.e.keller@intel.com> wrote:
> From: Jacob Keller <jacob.keller@gmail.com>
>
> The git submodule--helper clone command will fail with a segmentation
> fault when given a null url or null path variable. Since these are
> required for proper functioning of the submodule--helper clone
> subcommand, add checks to prevent running and fail gracefully when
> missing.
>
> Update the usage string to reflect the requirement that the --url and
> --path "options" are required.
>
> Signed-off-by: Jacob Keller <jacob.keller@gmail.com>
> ---
> This bug was discovered when trying to test the usage string of the
> previous change. I bisected and this has been in the submodule--helper
> code since the first iteration of module_clone. I am not really sure how
> much we care, since only internal callers will be using
> submodule--helper, but I suspect that it was not intended to segfault.
>
> I fixed the usage string to remove the [] around the url and path
> options, hopefully indicating they aren't "optional". Alternatively we
> could start requiring them as regular arguments if we wanted.
>
> Note the error message resulting from --url="" or --path="" are not very
> obvious but they do not result in a segfault so I didn't check for those
> in this patch.

I think this bug was put in, by "literally" translating from shell,
see ee8838d15776, where the shell code was rewritten to C,
specially:

 git clone $quiet ${depth:+"$depth"} -n ${reference:+"$reference"} \
     --separate-git-dir "$gitdir" "$url" "$sm_path"

Anything except url and path are done optionally, but url, and path not so.
The C code was inspired by this and aligned.

This patch makes sense to me,
Thanks,
Stefan


>
>  builtin/submodule--helper.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/builtin/submodule--helper.c b/builtin/submodule--helper.c
> index 3c4d3ff7f4af..35ae85a7e1bc 100644
> --- a/builtin/submodule--helper.c
> +++ b/builtin/submodule--helper.c
> @@ -186,15 +186,15 @@ static int module_clone(int argc, const char **argv, const char *prefix)
>
>         const char *const git_submodule_helper_usage[] = {
>                 N_("git submodule--helper clone [--prefix=<path>] [--quiet] "
> -                  "[--reference <repository>] [--name <name>] [--url <url>]"
> -                  "[--depth <depth>] [--path <path>]"),
> +                  "[--reference <repository>] [--name <name>] [--depth <depth>] "
> +                  "--url <url> --path <path>"),
>                 NULL
>         };
>
>         argc = parse_options(argc, argv, prefix, module_clone_options,
>                              git_submodule_helper_usage, 0);
>
> -       if (argc)
> +       if (argc || !url || !path)
>                 usage_with_options(git_submodule_helper_usage,
>                                    module_clone_options);
>
> --
> 2.7.1.429.g45cd78e
>
