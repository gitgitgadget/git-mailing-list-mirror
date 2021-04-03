Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A320C433ED
	for <git@archiver.kernel.org>; Sat,  3 Apr 2021 03:46:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 053B96113E
	for <git@archiver.kernel.org>; Sat,  3 Apr 2021 03:46:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235538AbhDCDrA (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 2 Apr 2021 23:47:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48502 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234488AbhDCDq7 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 2 Apr 2021 23:46:59 -0400
Received: from mail-ot1-x336.google.com (mail-ot1-x336.google.com [IPv6:2607:f8b0:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B84CC0613E6
        for <git@vger.kernel.org>; Fri,  2 Apr 2021 20:46:56 -0700 (PDT)
Received: by mail-ot1-x336.google.com with SMTP id m21-20020a9d7ad50000b02901b83efc84a0so6479954otn.10
        for <git@vger.kernel.org>; Fri, 02 Apr 2021 20:46:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=NTAjnEI0vA99qOG1qYuVrxg5DPjXWSyfIL7xe+xWdEY=;
        b=SdWhAu419CL7PPjGivv0VS6aq5GKppYnie1JKA/ck42tQvsXEmaHF+XjEyx4fwY85k
         gODu4C3x4qrdkNFz1ebCoNawJJeeWTfLw/WS49j/n3ep5Wcj0kqlzm+eF0Ii5z+Ej81v
         rn98UFHOx1fazwrL8QCXsTsnx5aLXp+vQ+MpfCGRISFF3C25cfGFWMiO7iKYkvxT+K5t
         ieaZxXqlXwjkRYlRdi4j2YkDyick0xEDMoG+hXdzVIyrr6Me6sMIy+o7Lz6gtaqf0r21
         k+LPrX0+3YiP1hXeoVrl10PCW1pZIz8B4LvSUUwfsdwajj9t1LEZ4mAYXYR6eXqfo+f7
         ortw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=NTAjnEI0vA99qOG1qYuVrxg5DPjXWSyfIL7xe+xWdEY=;
        b=dFXmuwuxqTLMdehezw0/Trr9RDlv6soAvZGTz1J3Nmf0B2GBXlyHkWK0LU0dI13HWy
         E2GVJ8NEoptxADy7AvRP5HkyoU+tLTm+dZfQo966XkbDrdKVsxF3OHgd9kcQvlCxxq1p
         Ll5h/TIde+XD1jHwqcST+2m25EInzvuwfstsJ9qixXAMpkc4KHLNErmNLneLVomVZiWT
         N5cX/cVzMjqBcDBjVBHhrzZqF+s05y7VpkiOHpSChw3rgCmXxe7pHjOYkejgIotU0yd9
         S2AJy2oAdhD6FkImoHVmw5z74rF3aKjPNS0628Li8590JcnXAYAXOq8CreSmEVCEMbRN
         JYXw==
X-Gm-Message-State: AOAM531Rxfp/nVWy4u/SSKSWXbeCYkijH3SPObVez+CAA/n+UNeYNbQ7
        m6qxOGPECNtLhWP1svCYbP+LNzOg673jA95eP5I=
X-Google-Smtp-Source: ABdhPJyAlVnWYY+QVbJSfmxNRsrjz2Q0ecL1b9z/6uVDirHThEoBnCP8gzuj1ZUVS2kqyE+GB6xMzQ2p9vJzsT/3T0c=
X-Received: by 2002:a9d:8ae:: with SMTP id 43mr13606424otf.162.1617421615388;
 Fri, 02 Apr 2021 20:46:55 -0700 (PDT)
MIME-Version: 1.0
References: <20210403013410.32064-1-jerry@skydio.com> <20210403013410.32064-2-jerry@skydio.com>
In-Reply-To: <20210403013410.32064-2-jerry@skydio.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Fri, 2 Apr 2021 20:46:44 -0700
Message-ID: <CABPp-BGhvQF9k1Jw9NPbZWMkNSffqR777-4S-y-Sh=Etvw-SAA@mail.gmail.com>
Subject: Re: [PATCH 1/1] git-apply: Allow simultaneous --cached and --3way options
To:     Jerry Zhang <jerry@skydio.com>
Cc:     Git Mailing List <git@vger.kernel.org>, ross@skydio.com,
        abe@skydio.com, brian.kubisiask@skydio.com,
        Jerry Zhang <jerryxzha@googlemail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

I'm not that familiar with apply.c, but let me attempt to take a look...

On Fri, Apr 2, 2021 at 6:36 PM Jerry Zhang <jerry@skydio.com> wrote:
>
> Previously, --cached and --3way were not
> allowed to be used together, since --3way
> wrote conflict markers into the working tree.
>
> These changes change semantics so that if
> these flags are given together and there is
> a conflict, the conflict markers are added
> directly to cache. If there is no conflict,
> the patch is applied directly to cache as
> expected.
>
> Signed-off-by: Jerry Zhang <jerry@skydio.com>
> Signed-off-by: Jerry Zhang <jerryxzha@googlemail.com>
> ---
>  Documentation/git-apply.txt |  4 +++-
>  apply.c                     | 13 +++++++------
>  2 files changed, 10 insertions(+), 7 deletions(-)
>
> diff --git a/Documentation/git-apply.txt b/Documentation/git-apply.txt
> index 91d9a8601c..3dc0085066 100644
> --- a/Documentation/git-apply.txt
> +++ b/Documentation/git-apply.txt
> @@ -89,7 +89,9 @@ OPTIONS
>         and we have those blobs available locally, possibly leaving the
>         conflict markers in the files in the working tree for the user to
>         resolve.  This option implies the `--index` option, and is incompatible
> -       with the `--reject` and the `--cached` options.
> +       with the `--reject` option. When used with the --cached option, any
> +       conflict markers are added directly to the cache rather than the
> +       working tree.
>
>  --build-fake-ancestor=<file>::
>         Newer 'git diff' output has embedded 'index information'
> diff --git a/apply.c b/apply.c
> index 6695a931e9..fc94ca0e99 100644
> --- a/apply.c
> +++ b/apply.c
> @@ -133,8 +133,6 @@ int check_apply_state(struct apply_state *state, int force_apply)
>
>         if (state->apply_with_reject && state->threeway)
>                 return error(_("--reject and --3way cannot be used together."));
> -       if (state->cached && state->threeway)
> -               return error(_("--cached and --3way cannot be used together."));
>         if (state->threeway) {
>                 if (is_not_gitdir)
>                         return error(_("--3way outside a repository"));
> @@ -4490,13 +4488,16 @@ static int create_file(struct apply_state *state, struct patch *patch)
>
>         if (!mode)
>                 mode = S_IFREG | 0644;
> -       if (create_one_file(state, path, mode, buf, size))
> -               return -1;
> +       if (!state->cached) {

Why add this check?  create_one_file() already has an early return if
state->cached is true.

> +               if (create_one_file(state, path, mode, buf, size))
> +                       return -1;
> +       }
>
> -       if (patch->conflicted_threeway)
> +       if (patch->conflicted_threeway && !state->cached)
>                 return add_conflicted_stages_file(state, patch);
> -       else if (state->update_index)
> +       else if (state->update_index) {
>                 return add_index_file(state, path, mode, buf, size);

So if something had conflicts, you ignore the various conflicted
modes, and just add it to the index as it stands.  What if it was
deleted upstream and modified locally?  Doesn't that just ignore the
conflict, make it invisible to the user, and add the locally modified
version?  Similarly if it was renamed upstream and modified locally,
doesn't that end up in both files being present?  And if there's a
directory/file conflict, due to the lack of ADD_CACHE_SKIP_DFCHECK (or
whatever it's called), the add is just going to fail, but perhaps
that's the most reasonable case as it'd print an error message and
return -1, I think.

Again, I didn't test any of this out and I'm not so familiar with this
code, so I'm guessing at these scenarios.  If I'm wrong about how this
works, the commit message probably deserves an explanation about why
they work, and we'd definitely need a few testcases for these types of
scenarios.  If I'm right, the current implementation is problematic at
least if not the idea of using these options together.
