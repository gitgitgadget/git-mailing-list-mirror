Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 035ACC6FA8E
	for <git@archiver.kernel.org>; Sat, 25 Feb 2023 00:41:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229554AbjBYAlA (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 24 Feb 2023 19:41:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55580 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229464AbjBYAk6 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 24 Feb 2023 19:40:58 -0500
Received: from mail-lj1-x235.google.com (mail-lj1-x235.google.com [IPv6:2a00:1450:4864:20::235])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 893535D469
        for <git@vger.kernel.org>; Fri, 24 Feb 2023 16:40:57 -0800 (PST)
Received: by mail-lj1-x235.google.com with SMTP id z42so746546ljq.13
        for <git@vger.kernel.org>; Fri, 24 Feb 2023 16:40:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=uOOdH41ghRQWGv/o/kThLNUFnPI1tfuK15yR9Qz+gbE=;
        b=lBhIJD4+FBV75j2U5N26/dB9JTj6oCNqv63xsylYsbvClqXKTq1thnXIO5Efn1CLP1
         GVgYbJNf582Na+h9boOfBGVhgJyAT8YW1HoYzCr8dkDcX+Caw1Xcb+PipwgTVBHoDRfg
         nt4wjtmM3vs8kIJYtblr38ky3CqqTnHoNwQsWmwTnbIL5UNxbsRI3pkdQHrAr88s+Lta
         RXj6FULMCpRYg41acYC0JojCW6USfTK3TQZmJlhqdZhePs0dyqsLDG8kM5fdscuH0GYz
         Y5qlxZT6qdTnl8zPpahgYTYAlCC4SbJAcHeqXAtQwfyPY6MmurV6UR0nTrCT+wQeNsLb
         7ywg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=uOOdH41ghRQWGv/o/kThLNUFnPI1tfuK15yR9Qz+gbE=;
        b=sYjQGb9MHbMMXzoXojzxmM03wsYWB89mAjPtkOneSmvcqoT9iimPnlj9MoLgLLA1Vt
         F42m//aHwqoNrbYpVGUCLUvcavPjnx8yOj3XvKAE2OAHWr6ME/zeVK0FNPyhlrwq9sox
         GJRUtG17Vp4twAicZMmRF81chjzNhKLs23Sy0QlqLwMf7BCZDW5VBIQUwbEgK5RCzgzv
         KNLlUg65xpk16XXZF86lvw4AAnWkpK33Bm7KXJ3DjUzuI21E2jNwtI5pY8fSiS9y40W2
         xFBRj+TCFac+0KhH+BbgIPoMM8OJq8amKp9VnOqD5QPRS+nqjxmcpm1J8Qy8qUbPSWKO
         CZFg==
X-Gm-Message-State: AO0yUKUAFXTYByvt3pyEY91cpBWCeH19dgofMZFX9Y1wCCc67bdu7nuQ
        1iUFZS1oxXMF8g4+z7/iktw6PmzmR3F3ujNVbtW2xx1X5s8=
X-Google-Smtp-Source: AK7set8cXmoQHDeEwijpmgk/8xAV7/Cisy2S6yYPcoQ0REefIoEfteJXWG4V/Z9AUP4p46czF/vhr7WoBzQro0VIZ3s=
X-Received: by 2002:a05:651c:3dd:b0:293:47b3:474a with SMTP id
 f29-20020a05651c03dd00b0029347b3474amr5495028ljp.6.1677285655768; Fri, 24 Feb
 2023 16:40:55 -0800 (PST)
MIME-Version: 1.0
References: <8955b45e35474e5feb826101423470d0b51e5470.1677143700.git.gitgitgadget@gmail.com>
 <20230224232256.2038749-1-jonathantanmy@google.com>
In-Reply-To: <20230224232256.2038749-1-jonathantanmy@google.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Fri, 24 Feb 2023 16:40:43 -0800
Message-ID: <CABPp-BEbZZjAE8N4OgWMEiV=MpGhEef0G4zytTTwrEjpGq0Qfw@mail.gmail.com>
Subject: Re: [PATCH 06/11] sparse-checkout: avoid using internal API of
 unpack-trees, take 2
To:     Jonathan Tan <jonathantanmy@google.com>
Cc:     Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Feb 24, 2023 at 3:22 PM Jonathan Tan <jonathantanmy@google.com> wrote:
>
> "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com> writes:
> > From: Elijah Newren <newren@gmail.com>
> >
> > Commit 2f6b1eb794 ("cache API: add a "INDEX_STATE_INIT" macro/function,
> > add release_index()", 2023-01-12) mistakenly added some initialization
> > of a member of unpack_trees_options that was intended to be
> > internal-only.  Further, it served no purpose as it simply duplicated
> > the initialization that unpack-trees.c code was already doing.
> >
> > Signed-off-by: Elijah Newren <newren@gmail.com>
> > ---
> >  builtin/sparse-checkout.c | 1 -
> >  1 file changed, 1 deletion(-)
> >
> > diff --git a/builtin/sparse-checkout.c b/builtin/sparse-checkout.c
> > index 4b7390ce367..8d5ae6f2a60 100644
> > --- a/builtin/sparse-checkout.c
> > +++ b/builtin/sparse-checkout.c
> > @@ -217,7 +217,6 @@ static int update_working_directory(struct pattern_list *pl)
> >       o.head_idx = -1;
> >       o.src_index = r->index;
> >       o.dst_index = r->index;
> > -     index_state_init(&o.result, r);
> >       o.skip_sparse_checkout = 0;
> >
> >       setup_work_tree();
>
> The commit message seems to imply that in this code path, there is some
> code in unpack-trees.c that runs index_state_init(), but that doesn't
> seem to be the case. memset-ting the result field with a junk value
> causes valgrind to fail with the following trace:
>
>   ==2035705== Invalid read of size 8
>   ==2035705==    at 0x30D982: lazy_init_name_hash (name-hash.c:602)
>   ==2035705==    by 0x30DDDA: index_file_exists (name-hash.c:721)
>   ==2035705==    by 0x3F71A8: check_ok_to_remove (unpack-trees.c:2430)
>   ==2035705==    by 0x3F74EE: verify_absent_1 (unpack-trees.c:2495)
>   ==2035705==    by 0x3F75C6: verify_absent_sparse (unpack-trees.c:2523)
>   ==2035705==    by 0x3F2A15: apply_sparse_checkout (unpack-trees.c:566)
>   ==2035705==    by 0x3F6849: update_sparsity (unpack-trees.c:2147)
>   ==2035705==    by 0x1FC105: update_working_directory (sparse-checkout.c:228)
>
> so it might be better to move the init invocation to update_sparsity()
> instead of only removing it.

Actually, my commit message was implying o->result is only used by
unpack_trees() and not update_sparsity().  While that implication is
*mostly* true, I forgot about check_ok_to_remove().  Doh!

Thanks for reviewing so carefully; I'll move the initialization to
update_sparsity() instead.
