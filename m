Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C626C77B7C
	for <git@archiver.kernel.org>; Thu,  4 May 2023 16:49:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229585AbjEDQt1 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 4 May 2023 12:49:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229470AbjEDQtY (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 4 May 2023 12:49:24 -0400
Received: from mail-pf1-x42b.google.com (mail-pf1-x42b.google.com [IPv6:2607:f8b0:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 634F730F7
        for <git@vger.kernel.org>; Thu,  4 May 2023 09:49:00 -0700 (PDT)
Received: by mail-pf1-x42b.google.com with SMTP id d2e1a72fcca58-643995a47f7so391606b3a.1
        for <git@vger.kernel.org>; Thu, 04 May 2023 09:49:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1683218938; x=1685810938;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=KxXN/eTtdTB0FrthhXvC896/Ay/c7BboJkkR2Wrppnk=;
        b=WleR1AW6yKtGmIBV31a6v0fdY5RChOkndRALoG0EGkTnGUT0SaTK4TusUOKy4du6Xw
         Ax7+bE6qBvv/07hY2X1jtTe2VA1XKYGTMzwWQHoMkYTbiyRrG6saCIJz087+sCP0SM8w
         XpWU0Kjn2qflliHH5+hQhZpLtbSoutXK+ln9XxdkjmGAap5iSvE5dkFM67w1JgfUaiXz
         Xy2VMWOQcwJ+nI+cpU9wCpq5a4eWCm7gwEHv6OfnI/fpI8GytF6nvjz4wR3rPB3BYrHE
         KONa6Lkp4q2HomzjuWnl5kuf88jU3jmrb90Je96k/gQSbvGmWvlYpaFtMgD6/RwWE43S
         tQNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683218938; x=1685810938;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=KxXN/eTtdTB0FrthhXvC896/Ay/c7BboJkkR2Wrppnk=;
        b=HmMU3/lNbcF23L+PcL4boQywUpLq3UfVOvO1XYtx+RtCNxL9tbPSPnouolYdPs1aPf
         LYM221QW8jZr5JM0/EsXdYrIMBvBD4tytI0zVE3PFwudKkIx98Zc/ElSxpPVf1M5yVhM
         6dMcF3rfju1oeidfgrhPiHwVuCtZbPl9mRQzHTawYpo0gbJ3xHGrm2Z+QdrCC6vjZk1q
         pXTrl512OCaolU6jQ0JELpNvzpjwYpm74lL74Ywhx1zvsScxRxUcBD1YR2w6Jzkqlvsb
         OmDUawVL856xRBvRyp1It5OjNG8gXxPW4q8hvhSn9tgdHywHqGan6U8EddcIZdFeCjoA
         1oTQ==
X-Gm-Message-State: AC+VfDwmapyUn68ra85TYXRu+eRg+IJTFxOyUGsFHwOjlzX58D5tTfyy
        6tMx3mp3ZkgNa+QqRbAbglY=
X-Google-Smtp-Source: ACHHUZ7zVXzUIaUkLjLFobMOqxPX4j0tj9IW4UpY8ZM4rUEedf+UMlU2t+YaFCnWKWq8Z6+Metp6Uw==
X-Received: by 2002:a05:6a00:98e:b0:63b:88f6:3817 with SMTP id u14-20020a056a00098e00b0063b88f63817mr3375972pfg.19.1683218938327;
        Thu, 04 May 2023 09:48:58 -0700 (PDT)
Received: from localhost (187.137.203.35.bc.googleusercontent.com. [35.203.137.187])
        by smtp.gmail.com with ESMTPSA id ei23-20020a056a0080d700b006410f4f3ecdsm14278659pfb.83.2023.05.04.09.48.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 May 2023 09:48:57 -0700 (PDT)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     "John Cai via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, John Cai <johncai86@gmail.com>,
        John Cai <jcai@gitlab.com>
Subject: Re: [PATCH] pack-refs: teach --exclude option to exclude refs from
 being packed
References: <pull.1501.git.git.1683215331910.gitgitgadget@gmail.com>
Date:   Thu, 04 May 2023 09:48:57 -0700
In-Reply-To: <pull.1501.git.git.1683215331910.gitgitgadget@gmail.com> (John
        Cai via GitGitGadget's message of "Thu, 04 May 2023 15:48:51 +0000")
Message-ID: <xmqq4joskpom.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"John Cai via GitGitGadget" <gitgitgadget@gmail.com> writes:

> From: John Cai <jcai@gitlab.com>
>
> Currently once refs are packed into a pack-refs file, deleting them can be
> slow since it involves a full file scan of the entire pack-refs file. At

"pack-refs" -> "packed-refs".

But performing a full file scan of 100MB file would take how many
milliseconds?  Having to remove many refs from a single packed-refs
file would be costly if it is done one-by-one, though.  I wonder how
effective our batched update mechanism is these days...

Sorry for straying to a tangent.  In any case, I do not think the
first sentence is necessary; just start it with "At GitLab, ..." to
say that you have a need to be more selective than "is it a tag or
not?" to choose refs to be and not to be packed.  The reason why we
may want to leave a ref loose is not limited to ref deletion
performance, and the benefit of this new feature is not limited to
it, either.

> GitLab, we have a system that creates ephemeral internal refs that don't
> live long before getting deleted. Having an option to not include certain
> refs from a pack-refs file allows these internal references to be deleted
> much more efficiently.

I think that is a valid use case.

If we step back a bit, we can see "pack-refs" has an option "--all"
that was added by b3d4204f (git-pack-refs --all, 2006-10-08), to
allow us pack only tags by default, because packing branches that
are meant to be updated often and also removed more often than tags
were found to be detrimental.  We can view this new option a
follow-up work for the commit, to allow the users to define what to
be and what not to be packed, depending on their workflow.

This observation also makes us realize that we should consider the
opposite.  It would benefit us to include some refs that we normally
do not pack and be more selective than "--all" ("--exclude" proposed
here is a way to leave some refs that we normally pack and be more
selective than not running pack-refs at all).  A set of branches
that are only occasionally used may want to be packed while the rest
of branches want to be left loose because they are more active, or
something.

> Add an --exclude option to the pack-refs builtin, and use the ref
> exclusions API to exclude certain refs from being packed into the final
> pack-refs file

"pack-refs" appears here, too.

>  Documentation/git-pack-refs.txt |  8 +++++++-
>  builtin/pack-refs.c             | 17 +++++++++++++++--
>  refs.c                          |  4 ++--
>  refs.h                          |  6 +++++-
>  refs/debug.c                    |  4 ++--
>  refs/files-backend.c            | 13 ++++++++++---
>  refs/packed-backend.c           |  3 ++-
>  refs/refs-internal.h            |  4 +++-
>  t/helper/test-ref-store.c       |  3 ++-
>  t/t3210-pack-refs.sh            | 18 ++++++++++++++++++
>  10 files changed, 66 insertions(+), 14 deletions(-)
>
> diff --git a/Documentation/git-pack-refs.txt b/Documentation/git-pack-refs.txt
> index 154081f2de2..d80e0a1562d 100644
> --- a/Documentation/git-pack-refs.txt
> +++ b/Documentation/git-pack-refs.txt
> @@ -8,7 +8,7 @@ git-pack-refs - Pack heads and tags for efficient repository access
>  SYNOPSIS
>  --------
>  [verse]
> -'git pack-refs' [--all] [--no-prune]
> +'git pack-refs' [--all] [--no-prune] [--exclude <pattern>]
>  
>  DESCRIPTION
>  -----------
> @@ -59,6 +59,12 @@ a repository with many branches of historical interests.
>  The command usually removes loose refs under `$GIT_DIR/refs`
>  hierarchy after packing them.  This option tells it not to.
>  
> +--exclude <pattern>::
> +
> +Do not pack refs matching the given `glob(7)` pattern. Repetitions of this option
> +accumulate exclusion patterns. Use `--no-exclude` to clear and reset the list of
> +patterns.

The interaction of this option with "--all" needs to be described
somewhere.  If we are to be adding "--include" for completeness,
that one also needs to interact with "--all".

> diff --git a/refs.c b/refs.c
> index d2a98e1c21f..637810347a0 100644
> --- a/refs.c
> +++ b/refs.c
> @@ -2132,9 +2132,9 @@ void base_ref_store_init(struct ref_store *refs, struct repository *repo,
>  }
>  
>  /* backend functions */
> -int refs_pack_refs(struct ref_store *refs, unsigned int flags)
> +int refs_pack_refs(struct ref_store *refs, unsigned int flags, struct pack_refs_opts *pack_opts)
>  {
> -	return refs->be->pack_refs(refs, flags);
> +	return refs->be->pack_refs(refs, flags, pack_opts);

That's a curious choice of the API.  It is not like backend methods
all share the same "flags" bitset (they share "refs" pointer to the
ref_store), so I would have expected that it would become part of
the pack_refs_opts structure.  Do not call the parameter pack_opts;
either spell it out as "pack_refs_opts", or just use "opts".  The
latter is probably more preferrable as I do not expect it to be
ambiguous with other kinds of "opts".

The rest of the pack I found nothing unexpected or surprising.
