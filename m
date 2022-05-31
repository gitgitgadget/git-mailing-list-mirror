Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A21B5C433F5
	for <git@archiver.kernel.org>; Tue, 31 May 2022 08:06:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244701AbiEaIGY (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 31 May 2022 04:06:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57192 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237948AbiEaIGW (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 31 May 2022 04:06:22 -0400
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com [IPv6:2607:f8b0:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78B3491559
        for <git@vger.kernel.org>; Tue, 31 May 2022 01:06:21 -0700 (PDT)
Received: by mail-pl1-x635.google.com with SMTP id w3so12162260plp.13
        for <git@vger.kernel.org>; Tue, 31 May 2022 01:06:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=cCj6AO0n4mEpMCWzIUXfM2inCX3IxdGIyTKxZWCz5a0=;
        b=JWnQDB5SWMgEFbiVZDm83NxpxIT5ocj+ipJw4ZgiIiA5Enezy3+zSTgiyWRM8piLY6
         LWbeqizcT+RikWQDSctol2IeAzvs22RQ1u7dZ6ew+VBm7lBwMEHATk12snWqIvHM/znq
         1aSb5tphrWXWSKYvrSi6kqAMpSqgTAXXarpsBbeNyJFiKZI6FsDH/ou55F/qboKg/tfJ
         Notte+aTmgtJPGWl1DlHxVmn9M3wj7BYCYdGlyn00i6ZG956xNAaZydxD7olt4WGBOH3
         h41maczJRt8YF793AcZfoIDt6PjiW3xeFWC8ZwXEFc3UI2Hr24ilxuH7rWys3PfJfJ5E
         nPWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=cCj6AO0n4mEpMCWzIUXfM2inCX3IxdGIyTKxZWCz5a0=;
        b=SWmNfOELKLhIPC2LgQRlqG9stPKBZVM4VP04SLc5O/B0ch6PZmO0dJysLryy4ZqqF8
         vpPVaK5Nfwt7wy2mXBLu5wnl6bNR3yqLMLmjdKe/u4f7Kh0WFXOAfwh99RcrbPg/Q/Hd
         DRSFUZoajKVhz3SRUfADpkBRRkTwIKN5IJpPM7VX6r7bspCFFcPWfpLYBQUwptZai0Ue
         Fy2YTfR1+lY79nOUnjDMGvL0ZKd6tHNKVVR4GXSz3G6hDur43IccFECrki/OQ93hPLHv
         VRNtyv3YraU2BfuMmu90l61/qnDz7nzIamqm3kfd5w/9ViDCje3V6bqYlGHGzFIv1PBH
         +fyg==
X-Gm-Message-State: AOAM531AiZBzxCJh7fHj5K7FJyDs1BA3uKqKeaXY8HEC1taszWOrcnnH
        gZSCV5jWwxZkmOzL2iSf8rPN/ZoChKxFRBMHjUCnCiYJvZM=
X-Google-Smtp-Source: ABdhPJwqPHaNUcQkVltZf7FidQK8MBUxXTTXUF28Q5XteMBo591sYVbohPsABJTBOjI2FCMd2BJaUuTVvoTMtYwrmeU=
X-Received: by 2002:a17:90a:de15:b0:1df:63dd:9cfc with SMTP id
 m21-20020a17090ade1500b001df63dd9cfcmr27719961pjv.200.1653984380938; Tue, 31
 May 2022 01:06:20 -0700 (PDT)
MIME-Version: 1.0
References: <20220331091755.385961-1-shaoxuan.yuan02@gmail.com>
 <20220527100804.209890-1-shaoxuan.yuan02@gmail.com> <20220527100804.209890-3-shaoxuan.yuan02@gmail.com>
 <0884b97b-0745-5cad-3034-a679be5d6c3a@github.com>
In-Reply-To: <0884b97b-0745-5cad-3034-a679be5d6c3a@github.com>
From:   Shaoxuan Yuan <shaoxuan.yuan02@gmail.com>
Date:   Tue, 31 May 2022 16:06:08 +0800
Message-ID: <CAJyCBORP74=nC1cB5r41MqS+WD-JfNX+8AOv7jqevN9FZGWdSw@mail.gmail.com>
Subject: Re: [WIP v2 2/5] mv: check if out-of-cone file exists in index with
 SKIP_WORKTREE bit
To:     Derrick Stolee <derrickstolee@github.com>
Cc:     git@vger.kernel.org, vdye@github.com, gitster@pobox.com,
        newren@gmail.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, May 27, 2022 at 11:13 PM Derrick Stolee
<derrickstolee@github.com> wrote:
> > diff --git a/builtin/mv.c b/builtin/mv.c
> > index 83a465ba83..32ad4d5682 100644
> > --- a/builtin/mv.c
> > +++ b/builtin/mv.c
> > @@ -185,8 +185,32 @@ int cmd_mv(int argc, const char **argv, const char *prefix)
> >
> >               length = strlen(src);
> >               if (lstat(src, &st) < 0) {
> > +                     /*
> > +                      * TODO: for now, when you try to overwrite a <destination>
> > +                      * with your <source> as a sparse file, if you supply a "--sparse"
> > +                      * flag, then the action will be done without providing "--force"
> > +                      * and no warning.
> > +                      *
> > +                      * This is mainly because the sparse <source>
> > +                      * is not on-disk, and this if-else chain will be cut off early in
> > +                      * this check, thus the "--force" check is ignored. Need fix.
> > +                      */
>
> I wonder if this is worth the comment here, or if we'd rather see
> the mention in the commit message. You have documented tests that
> fail in this case, so we already have something that marks this
> as "TODO" in a more discoverable place.

This comment was added during my local development, it should be
removed.

> > +                     int pos = cache_name_pos(src, length);
> > +                     if (pos >= 0) {
> > +                             const struct cache_entry *ce = active_cache[pos];
> > +
> > +                             if (ce_skip_worktree(ce)) {
> > +                                     if (!ignore_sparse)
> > +                                             string_list_append(&only_match_skip_worktree, src);
> > +                                     else
> > +                                             modes[i] = SPARSE;
>
>
> > +                             }
> > +                             else
> > +                                     bad = _("bad source");
>
> style nit:
>
>         } else {
>                 bad = _("bad source");
>         }
>
> > +                     }
> >                       /* only error if existence is expected. */
> > -                     if (modes[i] != SPARSE)
> > +                     else if (modes[i] != SPARSE)
> >                               bad = _("bad source");
>
> For this one, the comment makes it difficult to connect the 'else
> if' to its corresponding 'if'. Perhaps:
>
>         } else if (modes[i] != SPARSE) {
>                 /* only error if existence is expected. */
>                 bad = _("bad source");
>         }
>
> >               } else if (!strncmp(src, dst, length) &&
> >                               (dst[length] == 0 || dst[length] == '/')) {
>
> In general, I found this if/else-if chain hard to grok, and
> a lot of it is because we have "simple" cases at the end
> and the complicated parts have ever-increasing nesting. This
> is mostly due to the existing if/else-if chain in this method.
>
> Here is a diff that replaces that if/else-if chain with a
> 'goto' trick to jump ahead, allowing some code to decrease in
> tabbing:
>
> ---- >8 ----

[cutting the proposed refactor for space]

> ---- >8 ----
>
> But mostly the reason for this refactor is that the following
> diff should be equivalent to yours:
>
> ---- >8 ----
>
> diff --git a/builtin/mv.c b/builtin/mv.c
> index d8b5c24fb5..add48e23b4 100644
> --- a/builtin/mv.c
> +++ b/builtin/mv.c
> @@ -185,11 +185,28 @@ int cmd_mv(int argc, const char **argv, const char *prefix)
>
>                 length = strlen(src);
>                 if (lstat(src, &st) < 0) {
> -                       /* only error if existence is expected. */
> -                       if (modes[i] != SPARSE) {
> +                       int pos;
> +                       const struct cache_entry *ce;
> +
> +                       pos = cache_name_pos(src, length);
> +                       if (pos < 0) {
> +                               /* only error if existence is expected. */
> +                               if (modes[i] != SPARSE)
> +                                       bad = _("bad source");
> +                               goto act_on_entry;
> +                       }
> +
> +                       ce = active_cache[pos];
> +                       if (!ce_skip_worktree(ce)) {
>                                 bad = _("bad source");
>                                 goto act_on_entry;
>                         }
> +
> +                       if (!ignore_sparse)
> +                               string_list_append(&only_match_skip_worktree, src);
> +                       else
> +                               modes[i] = SPARSE;
> +                       goto act_on_entry;
>                 }
>                 if (!strncmp(src, dst, length) &&
>                     (dst[length] == 0 || dst[length] == '/')) {
> ---- >8 ---
>
> To me, this is a bit easier to parse, since we find the error
> cases and jump to the action before continuing on the "happy
> path". It does involve that first big refactor first, so I'd
> like to hear opinions of other contributors before you jump to
> taking this suggestion.

True. I also find it easier to read. Though Victoria mentioned the
goto hazard, the gotos here decouples the huge chain and that
brings clarity and makes it easier to extend.

-- 
Thanks & Regards,
Shaoxuan
