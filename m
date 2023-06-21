Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A01FEB64D8
	for <git@archiver.kernel.org>; Wed, 21 Jun 2023 09:02:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229925AbjFUJCO (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 21 Jun 2023 05:02:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45152 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230433AbjFUJB3 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 21 Jun 2023 05:01:29 -0400
Received: from mail-yw1-x1131.google.com (mail-yw1-x1131.google.com [IPv6:2607:f8b0:4864:20::1131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 62E7E198D
        for <git@vger.kernel.org>; Wed, 21 Jun 2023 02:01:15 -0700 (PDT)
Received: by mail-yw1-x1131.google.com with SMTP id 00721157ae682-56fff21c2ebso60620557b3.3
        for <git@vger.kernel.org>; Wed, 21 Jun 2023 02:01:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20221208.gappssmtp.com; s=20221208; t=1687338074; x=1689930074;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=pAs6QZfI36nfUOHIjZ6IKiv5UWaBv7EPWQh20lYRmM8=;
        b=gJp6tA3+pQ0sV2CC5wECj8HauvyyIJtdqrN1A2HMDlH0AQL3ilEOhWYiPYpTEh+KK3
         AxmENAZ2EXBJ3/jbtqeNl5dABn9iueQnPLXgUtf+VgyWOc+mJiIt9z6gMnBSUYeUvagb
         /Px4jLmGoYkU1xrJHNyKN9btwo7gfwffk2yMCZYWRuzx7mBRq8WNYB/Z/bp/bDAmEpFZ
         77rvbO/KvLHPkKouPLgNKVrhnIGsacPFugU6C8WzQMakP854taWkeYRSs5c8wQk9BFCi
         UBf3RB9NzpGHG4zeoGZl3DNkZmPo99yQQc155fbkY6s6VznVjIe1OSCLrfiwJ4pC8r7Z
         N1YQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687338074; x=1689930074;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pAs6QZfI36nfUOHIjZ6IKiv5UWaBv7EPWQh20lYRmM8=;
        b=U5fOCYTf6CzUUf9ARBkKsaX4ot6E2vgxA96M7WGVAcoNrzIHfIAHLXRlZx6pa91GCn
         wTo9w50oi00tbJnFzOQjtDwbdHpyLbCaQUJuBZcGoF98Tzt1hwb+0E5GHWO32gRPq8lK
         Je842pr0mvL/AXIUgg1c6346j29aMCZ3444bvIWXLTazJ7MmD4U/V3ucuSQsv+99R1/d
         g0blA3rARsX8NqeDwZPwjJyUdPeQ9R8yuCQJLsTI/e2+tarPc3Mwri55oT3F87DUd3t4
         j2mAG5apfhN/biX5Wiyax8SuEFDjDvd5AFCweZbkzrCrii9HdGrmOiz//eU2dtgfOJrM
         TsTQ==
X-Gm-Message-State: AC+VfDwJUJ6OO41DUGk4wbWHDdzJ4uszUA9t+ZqFJBygnlJQ13vMN5d0
        rdTjPEJtiVjNtqQtegrN62BfWQ==
X-Google-Smtp-Source: ACHHUZ61peTTJ4QMm+2cBaEdom4ziXeJURerjgxZdTqCOL8byVZFzrFFm/MtyVJK2WMsJtLVX8ENIQ==
X-Received: by 2002:a5b:c06:0:b0:ba8:4688:fbc with SMTP id f6-20020a5b0c06000000b00ba846880fbcmr10485484ybq.32.1687338074499;
        Wed, 21 Jun 2023 02:01:14 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id 8-20020a250d08000000b00bd6cdef2eeesm836185ybn.46.2023.06.21.02.01.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Jun 2023 02:01:13 -0700 (PDT)
Date:   Wed, 21 Jun 2023 05:01:10 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, gitster@pobox.com,
        Derrick Stolee <derrickstolee@github.com>,
        Jeff King <peff@peff.net>
Subject: Re: [PATCH] repack: only repack .packs that exist
Message-ID: <ZJK8VsH27a4bPYgh@nand.local>
References: <pull.1546.git.1687287782439.gitgitgadget@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <pull.1546.git.1687287782439.gitgitgadget@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Jun 20, 2023 at 07:03:02PM +0000, Derrick Stolee via GitGitGadget wrote:
> From: Derrick Stolee <derrickstolee@github.com>
>
> In 73320e49add (builtin/repack.c: only collect fully-formed packs,
> 2023-06-07), we switched the check for which packs to collect by
> starting at the .idx files and looking for matching .pack files. This
> avoids trying to repack pack-files that have not had their pack-indexes
> installed yet.

Right; the motivation behind this change is based on the principle that
we consider a packfile (and any corresponding metadata it might have,
like .keep, .bitmap, .rev, etc.) to be accessible exactly when there is
an .idx file in place.

So if pack-P.idx exists, we expect to be able to read the contents of
pack-P.pack (and any other pack-P.* files that happen to be laying
around). The idea with 73320e49add is to make `collect_pack_filenames()`
consistent with the same pack existence check that we use everywhere
else.

> However, it does cause maintenance to halt if we find the (problematic,
> but not insurmountable) case of a .idx file without a corresponding
> .pack file. In an environment where packfile maintenance is a critical
> function, such a hard stop is costly and requires human intervention to
> resolve (by deleting the .idx file).

Do all cases fall into the "problematic, but not insurmountable"
category? I'm not entirely sure. One instance that is definitely OK is
having a partially unstaged pack whose objects were repacked elsewhere,
but the 'repack' process doing so died between unlink()-ing the ".pack"
file and the ".idx". This matches the patch that you and I discussed
yesterday to switch the order and restore git-repack.sh's original
behavior, which is correct.

But what about someone accidentally deleting a ".pack" file and leaving
around its index? Or copying files from one repository to another and
only partially copying the contents of $GIT_DIR/objects/pack?

What makes me leery about this kind of change is that there are
potentially many more cases like the above. And even if the interesting
cases are somehow limited to the above, continuing on in the face of a
malformed pack group doesn't seem like the right thing for repack to be
doing.

> This was not the case before. We successfully repacked through this
> scenario until the recent change to scan for .idx files.

Right, my feeling is that the new behavior post-73320e49add is arguably
more correct.

> In other cases, Git prepares its list of packfiles by scanning .idx
> files and then only adds it to the packfile list if the corresponding
> .pack file exists. It even does so without a warning! (See
> add_packed_git() in packfile.c for details.)

This is by design: we only try to open the pack itself when we call
`open_packed_git()`. All packs start out initialized with just their
".idx" as you note.

This feels similar to what you are trying to do here, but I do think
that it's different. While we're performing object reads, there may be
concurrent writers adding (e.g. from pushes) or removing packs (e.g.
from repacking) in the repository. So there we have to be resilient
to thinking that we might have a copy of some object in a given pack,
but still being able to handle the case where that pack disappears and
the object is actually found in some other pack.

Repacking feels different to me. There we are modifying the packs
themselves, so having a incorrectly staged pack group feels like a
condition that we should stop on, because we can no longer completely
trust the data that we are operating on.

> diff --git a/t/t7700-repack.sh b/t/t7700-repack.sh
> index 08b5ba0c150..e780efe5e0c 100755
> --- a/t/t7700-repack.sh
> +++ b/t/t7700-repack.sh
> @@ -239,6 +239,10 @@ test_expect_success 'repack --keep-pack' '
>  			mv "$from" "$to" || return 1
>  		done &&
>
> +		# A .idx file without a .pack should not stop us from
> +		# repacking what we can.
> +		touch .git/objects/pack/pack-does-not-exist.idx &&
> +
>  		git repack --cruft -d --keep-pack $P1 --keep-pack $P4 &&
>
>  		ls .git/objects/pack/*.pack >newer-counts &&

If we do end up pursuing this patch, it may be worthwhile to ensure that
the dangling .idx file remains in place after the repack is complete.
You test for this implicitly below, but doing so here explicitly feels
worthwhile to me.

Thanks,
Taylor
