Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55926C433EF
	for <git@archiver.kernel.org>; Thu, 17 Feb 2022 01:32:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230438AbiBQBcY (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 16 Feb 2022 20:32:24 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:50250 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229569AbiBQBcX (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 16 Feb 2022 20:32:23 -0500
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com [IPv6:2a00:1450:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B81C0137005
        for <git@vger.kernel.org>; Wed, 16 Feb 2022 17:32:09 -0800 (PST)
Received: by mail-ej1-x631.google.com with SMTP id gb39so3377523ejc.1
        for <git@vger.kernel.org>; Wed, 16 Feb 2022 17:32:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Sp8ejbq/3LnzFXX59RBt1aiPXO/yjzMrgsYYMesR6kw=;
        b=dbrrUCgpDk8wK9bZBjhJ8YJwi7Zi1ZaDdujh9mS1PixVoLSOs0NC0ifwtCyIHx8zzI
         vGajQlaGf25ELRgkBgVru/8hnEQspxGX0U/lpHN2oxiI0L/kFf60XzZE5g1PetXoWKUJ
         B80vvyxRixwPWXRvYMVxEIzzVnWZmTQNMvZzI/F0w/zBnxCKDXiFd2Xu58F/DZkR60Et
         +1EbFM5NbcVVSWmn18R7zTyZwHH2VavKys0fb7lyLRJlZBanSN6GBAeFDmFz5p0VJ/pQ
         b7X9BSYbAyxfcZ5WD+ZThh+SwFmy5jFePiNgOAB6v9SBVq+LGk+ATnDmo4aBFTgGd1h8
         gpSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Sp8ejbq/3LnzFXX59RBt1aiPXO/yjzMrgsYYMesR6kw=;
        b=2AllQlw4fFSj3UGQ3TNrC7LShtZfzJZoYHnSyErcmqJhphgDEiX9SM6ATFI/dxZ1yU
         Nn0hHg7cUT0g3ei3W+5FURoKWrIgSR7p+RB1HxWlBiP0FXBgLjkyhsT/+lfu5f+WAGOi
         RqvaViSh+v4OgyDJi5lzBCwlLS9/7eRZaQB3EmhWf3eoFEbXW5fMtVnsZCuQ4256uPBG
         DJJQzlslVIBCqU56OcdBjJ80PNgFz4Cw+MDPXmdZfnRhB225CI67gktqUt9SqZeovqSF
         uHlAdEyltQyUIp5usbDJfbsqA6rLaQNEkqIoyrek4ey8ZdvjFeMU/dpyPlkBfNzx7nrp
         aDiQ==
X-Gm-Message-State: AOAM531XEgYQBkZzqtExCBT1qgISF8nSFD0yLr4QcG3AdSuqQnmuwsmh
        conxZCEljjpRhfQY8fuH+pb3wsd+GIofywIbu/3mPfGr6g0=
X-Google-Smtp-Source: ABdhPJxcatfRd7Mxv3TsFpHy6f53yejIdC59zVO+wjGD8apR+3+/MjYEeyTcliD0nG5M/rAxIxV8uKvy6pleUtrmeWk=
X-Received: by 2002:a17:906:350d:b0:6b9:5871:8f34 with SMTP id
 r13-20020a170906350d00b006b958718f34mr550979eja.493.1645061528129; Wed, 16
 Feb 2022 17:32:08 -0800 (PST)
MIME-Version: 1.0
References: <cover.1644565025.git.ps@pks.im> <54fdee845bea7f67f46817417f8e5a504bd39665.1644565025.git.ps@pks.im>
In-Reply-To: <54fdee845bea7f67f46817417f8e5a504bd39665.1644565025.git.ps@pks.im>
From:   Elijah Newren <newren@gmail.com>
Date:   Wed, 16 Feb 2022 17:31:56 -0800
Message-ID: <CABPp-BFC-BavQEreJQ+APhxSNHenij568Mr-0ME+YF+7gzwtBQ@mail.gmail.com>
Subject: Re: [PATCH 4/6] fetch: report errors when backfilling tags fails
To:     Patrick Steinhardt <ps@pks.im>
Cc:     Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Feb 11, 2022 at 12:03 PM Patrick Steinhardt <ps@pks.im> wrote:
>
> When the backfilling of tags fails we do not report this error to the
> caller, but only report it implicitly at a later point when reporting
> updated references. This leaves callers unable to act upon the
> information of whether the backfilling succeeded or not.
>
> Refactor the function to return an error code and pass it up the
> callstack. This causes us to correctly propagate the error back to the
> user of git-fetch(1).
>
> Signed-off-by: Patrick Steinhardt <ps@pks.im>
> ---
>  builtin/fetch.c      | 29 +++++++++++++++++++++--------
>  t/t5503-tagfollow.sh |  4 +---
>  2 files changed, 22 insertions(+), 11 deletions(-)
>
> diff --git a/builtin/fetch.c b/builtin/fetch.c
> index 627847e2f8..1eda0b68ff 100644
> --- a/builtin/fetch.c
> +++ b/builtin/fetch.c
> @@ -1495,12 +1495,12 @@ static struct transport *prepare_transport(struct remote *remote, int deepen)
>         return transport;
>  }
>
> -static void backfill_tags(struct transport *transport,
> -                         struct ref *ref_map,
> -                         struct fetch_head *fetch_head,
> -                         struct worktree **worktrees)
> +static int backfill_tags(struct transport *transport,
> +                        struct ref *ref_map,
> +                        struct fetch_head *fetch_head,
> +                        struct worktree **worktrees)
>  {
> -       int cannot_reuse;
> +       int retcode, cannot_reuse;
>
>         /*
>          * Once we have set TRANS_OPT_DEEPEN_SINCE, we can't unset it
> @@ -1519,12 +1519,14 @@ static void backfill_tags(struct transport *transport,
>         transport_set_option(transport, TRANS_OPT_FOLLOWTAGS, NULL);
>         transport_set_option(transport, TRANS_OPT_DEPTH, "0");
>         transport_set_option(transport, TRANS_OPT_DEEPEN_RELATIVE, NULL);
> -       fetch_and_consume_refs(transport, ref_map, fetch_head, worktrees);
> +       retcode = fetch_and_consume_refs(transport, ref_map, fetch_head, worktrees);
>
>         if (gsecondary) {
>                 transport_disconnect(gsecondary);
>                 gsecondary = NULL;
>         }
> +
> +       return retcode;
>  }
>
>  static int do_fetch(struct transport *transport,
> @@ -1628,8 +1630,19 @@ static int do_fetch(struct transport *transport,
>                 struct ref *tags_ref_map = NULL, **tail = &tags_ref_map;
>
>                 find_non_local_tags(remote_refs, &tags_ref_map, &tail);
> -               if (tags_ref_map)
> -                       backfill_tags(transport, tags_ref_map, &fetch_head, worktrees);
> +               if (tags_ref_map) {
> +                       /*
> +                        * If backfilling tags succeeds we used to not return
> +                        * an error code to the user at all. Instead, we
> +                        * silently swallowed that error and updated the local
> +                        * state of the repository. We now notify the user of
> +                        * any such errors, but we continue to make sure that
> +                        * FETCH_HEAD and the upstream branch are configured as
> +                        * expected.
> +                        */

nit: I'd prefer to see code comments explain what we currently do, and
move history lessons to the commit message.


> +                       if (backfill_tags(transport, tags_ref_map, &fetch_head, worktrees))
> +                               retcode = 1;
> +               }
>
>                 free_refs(tags_ref_map);
>         }
> diff --git a/t/t5503-tagfollow.sh b/t/t5503-tagfollow.sh
> index 888305ad4d..549f908b90 100755
> --- a/t/t5503-tagfollow.sh
> +++ b/t/t5503-tagfollow.sh
> @@ -237,9 +237,7 @@ test_expect_success 'backfill failure causes command to fail' '
>                 done
>         EOF
>
> -       # Even though we fail to create refs/tags/tag1 the below command
> -       # unexpectedly succeeds.
> -       git -C clone5 fetch .. $B:refs/heads/something &&
> +       test_must_fail git -C clone5 fetch .. $B:refs/heads/something &&
>         test $B = $(git -C clone5 rev-parse --verify refs/heads/something) &&
>         test $S = $(git -C clone5 rev-parse --verify tag2) &&
>         test_must_fail git -C clone5 rev-parse --verify tag1
> --
> 2.35.1
>
