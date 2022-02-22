Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 265ABC433F5
	for <git@archiver.kernel.org>; Tue, 22 Feb 2022 01:48:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234803AbiBVBtR (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 21 Feb 2022 20:49:17 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:37298 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230417AbiBVBtP (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 21 Feb 2022 20:49:15 -0500
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3FE5325C4B
        for <git@vger.kernel.org>; Mon, 21 Feb 2022 17:48:51 -0800 (PST)
Received: by mail-ed1-x52b.google.com with SMTP id x5so33037740edd.11
        for <git@vger.kernel.org>; Mon, 21 Feb 2022 17:48:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=dgyp6kZebuKH3qKNeIIMY+CIP1Xp7PkK5Z+DLY8TkKo=;
        b=pEVarpUXIl596NcULgcw8+0oIHntfxi5qh98KIueLHV2XVWnvoTQpug7j+IxZdVABe
         Se1gw2YxpsVLlnEORZVYS+OQ/BRfusgAoUwHlXw81+LcoGnEadWv0QNwT0e0/6TUlDcT
         sBb7nuLYPPLRV0kQSDp4RzqkExEWlclFfsVA+LXixOLe7Z2Q1+Iz2zYa6oVvN0UL0Led
         19NCt3iSI5M2bvEDgJLwpAHvza3QOXbbnAPfcnF2SFwxas4uCIeMoGjvKejztNqGgMTv
         8Hcpp1bOa/vgARQuOU8qWGDzXi48MqdhzPEaPTqZlxqBvqkEpUh/bk1aV/cvP3WGzROR
         NJMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=dgyp6kZebuKH3qKNeIIMY+CIP1Xp7PkK5Z+DLY8TkKo=;
        b=eweNq5lv9UZ0z0H/LlIqxbko6FB46ak3CnaMmXnPBppfUXhT95Yv5fRwORFqqmBPXR
         T+qcvgULWrgTOVhk3OPTiT3BPsC97PJBPTZnM/AjQHEpAsk4phu3K2mwU0L9hEhv8T0y
         ZttKx8t/ToFHjNGnb312Pm+OgRAIEPEuShAGTS3jy9SDearoJZlwWj8UgT/pBGQWII0l
         MAvl9Wsh/eAW6lU5XOelXDV+fFMS32qxnuywsS6uVebLPORpvUVm4GOuB9kYMNLzo6OS
         73Q5EX3qUSDrgHDCvZF1d5jP/6U7WHMUU1i+EbOH3mTnkSAbB336DRpqPaDiC+0CPvYJ
         Mt9g==
X-Gm-Message-State: AOAM532KQy1rrZJhc32LZV2g4ppcCqChMGkb5WOfMNc+LS28+pj9/Nu8
        27wSw6UNQJ+TGH8sxu7rU6qQBxNBJelYbmoC9Mw2P25c
X-Google-Smtp-Source: ABdhPJz4ZuQ3Zob56Vua2WnV4XtuS+8b/K36wk0ktFVk+Sl3O/+ISGG9f2upyIpuDfEy5Sofy87Ua1xEZrMkbtqLT1U=
X-Received: by 2002:aa7:cc12:0:b0:410:cb7b:a9ba with SMTP id
 q18-20020aa7cc12000000b00410cb7ba9bamr23627185edt.196.1645494529674; Mon, 21
 Feb 2022 17:48:49 -0800 (PST)
MIME-Version: 1.0
References: <20220221090034.4615-1-patrick.marlier@gmail.com> <20220221090034.4615-2-patrick.marlier@gmail.com>
In-Reply-To: <20220221090034.4615-2-patrick.marlier@gmail.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Mon, 21 Feb 2022 17:48:37 -0800
Message-ID: <CABPp-BGdkgaRC+wBobhzyge=di8uE3kzHiO8v26bi2v0kTXerw@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] clean: avoid traversing into untracked dirs when unnecessary
To:     Patrick Marlier <patrick.marlier@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Feb 21, 2022 at 1:00 AM Patrick Marlier
<patrick.marlier@gmail.com> wrote:
>
> When deleting all untracked and ignored files and any nested
> repositories (such as with `git clean -ffdx`), we do not need to recurse
> into an untracked directory to see if any of the entries under it are
> ignored or a nested repository.  Special case this condition to avoid
> unnecessary recursion.
> ---
>  builtin/clean.c  |  4 +++-
>  t/t7300-clean.sh | 24 ++++++++++++++++++++++++
>  2 files changed, 27 insertions(+), 1 deletion(-)
>
> diff --git a/builtin/clean.c b/builtin/clean.c
> index 18b37e3fd9..1b1454d052 100644
> --- a/builtin/clean.c
> +++ b/builtin/clean.c
> @@ -978,7 +978,9 @@ int cmd_clean(int argc, const char **argv, const char *prefix)
>                 remove_directories = 1;
>         }
>
> -       if (remove_directories && !ignored_only) {
> +       if (remove_directories && ignored && !exclude_list.nr && force > 1)
> +               ; /* No need to recurse to look for ignored files */
> +       else if (remove_directories && !ignored_only) {
>                 /*
>                  * We need to know about ignored files too:
>                  *
> diff --git a/t/t7300-clean.sh b/t/t7300-clean.sh
> index 0399701e62..ceab7c4883 100755
> --- a/t/t7300-clean.sh
> +++ b/t/t7300-clean.sh
> @@ -788,4 +788,28 @@ test_expect_success 'traverse into directories that may have ignored entries' '
>         )
>  '
>
> +test_expect_success 'avoid traversing into untracked directories' '
> +       test_when_finished rm -f output error trace.* &&
> +       git init avoid-traversing-untracked-hierarchy &&
> +       (
> +               cd avoid-traversing-untracked-hierarchy &&
> +
> +               mkdir -p untracked/subdir/with/b &&
> +               mkdir -p untracked/subdir/with/a &&
> +               >untracked/subdir/with/a/random-file.txt &&
> +
> +               GIT_TRACE2_PERF="$TRASH_DIRECTORY/trace.output" \
> +               git clean -ffdx
> +       ) &&
> +
> +       # Make sure we only visited into the top-level directory, and did
> +       # not traverse into the "untracked" subdirectory since it was excluded
> +       grep data.*read_directo.*directories-visited trace.output |
> +               cut -d "|" -f 9 >trace.relevant &&
> +       cat >trace.expect <<-EOF &&
> +        ..directories-visited:1
> +       EOF
> +       test_cmp trace.expect trace.relevant
> +'
> +
>  test_done
> --
> 2.35.1

Thanks, this round looks good to me.  Both patches are:

Reviewed-by: Elijah Newren <newren@gmail.com>
