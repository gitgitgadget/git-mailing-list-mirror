Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02738C433F5
	for <git@archiver.kernel.org>; Thu,  7 Oct 2021 16:10:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D86E26109F
	for <git@archiver.kernel.org>; Thu,  7 Oct 2021 16:10:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242030AbhJGQMv (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 7 Oct 2021 12:12:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51804 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232604AbhJGQMu (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 7 Oct 2021 12:12:50 -0400
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1D91C061570
        for <git@vger.kernel.org>; Thu,  7 Oct 2021 09:10:56 -0700 (PDT)
Received: by mail-ed1-x535.google.com with SMTP id p13so25560254edw.0
        for <git@vger.kernel.org>; Thu, 07 Oct 2021 09:10:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=WkAEMqCycbYpVVc/66J7JsQPluNLJYNw3A1LZeW0fT8=;
        b=mr41RCIoibMqKE3kTYuKACYPI5R11AaNXmVHdhjOB0hmYXhtvBcBt1U+pWtLTF1IT2
         H8ewhBYI7N/vA/r+VFfbvFhdyqzj0cDZgeapDvdv5eOnZ6Omk2iASj8lrloYkFKw24YW
         3rIFo+k3BtaJyJWKt8pRYrMCa9Hop4HLyiwDpcNppgzdUKTBI6bpH9TsaplSDyHFJnPM
         ibF58zd+6GDCBt1ktJcRp2y6IpU+6gzYrIP/Niy8FgyBUlzVH/yBNypell/Muy1uGYpa
         /HKeDbz8SXcgio79ngxxyhNW/P1AHxAD9xVgUun7aSKH9H6qknP6+kBxeglgM38wdBC2
         RhNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=WkAEMqCycbYpVVc/66J7JsQPluNLJYNw3A1LZeW0fT8=;
        b=XJ8Ya0RiVATYXvndV7/qEmU70LLKRmradoanqTecXBsGYIxAbfBmHS3nQRHPHPQCur
         77FHcFk4Mr4ejvE3pphFF43NdUYB/f0vz+p9yXuI7zBdw0Nc7ZpYK+DcYftHaps6LYqy
         TTpJ96q/wN5dr/yuuD/mR7fPqCUVxGiCnv1D0vjCfrlccfOrJbL0/mQMW2iVdkiiHl4H
         NFvX23gakbfvl2ARLNKtzQutVpRfcQW6gO5RwWbq0nIAI4s3FY+gdVbvFyE4md94hmKp
         yIeCa2aM6zD8xE7HhlfQnzTeJjnPOpwlO5qlTEGB1YJ9PEISybb2lhTyjqMKGw27GD+e
         UVig==
X-Gm-Message-State: AOAM531h7DGTduOWXo6WGCJyQm0hMgnbiy6nPqxWb6n+8rY5l+ifcH2v
        fGkfaFGBLqEIDnT/m5rH3ra16RsQTeg1oReMnpI=
X-Google-Smtp-Source: ABdhPJzTqa4cP6FPxe+wP4NB/K+KfTO1vQDhU7LMDlQGeiLX9xOiNwOGpb1+X6IIEHBDzW4gwq1Lo5G3UVpprEKxmqU=
X-Received: by 2002:a17:906:eda6:: with SMTP id sa6mr6539111ejb.443.1633623055323;
 Thu, 07 Oct 2021 09:10:55 -0700 (PDT)
MIME-Version: 1.0
References: <cover-0.2-00000000000-20211006T093405Z-avarab@gmail.com> <cover-v2-0.3-00000000000-20211007T094019Z-avarab@gmail.com>
In-Reply-To: <cover-v2-0.3-00000000000-20211007T094019Z-avarab@gmail.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Thu, 7 Oct 2021 09:10:43 -0700
Message-ID: <CABPp-BGb2kkwRgu-c6DDBOTDCgJYWW+zmhV_ZgOogYqyVpGdLw@mail.gmail.com>
Subject: Re: [PATCH v2 0/3] unpack-trees: memory-leak fixes
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?Q?Martin_=C3=85gren?= <martin.agren@gmail.com>,
        Andrzej Hunt <ajrhunt@google.com>, Jeff King <peff@peff.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Oct 7, 2021 at 2:46 AM =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avar=
ab@gmail.com> wrote:
>
> These patches fix a couple of stray memory leaks in unpack-trees.c.
>
> This goes on top of ab/sanitize-leak-ci (but not
> en/removing-untracked-fixes, although they combine to fix more leaks
> in the area).
>
> Changes since v1[1]:
>
> In rebasing v1 from some earlier patches I came up with something that
> didn't make sense with related fixes in Elijah's
> en/removing-untracked-fixes. This hopefully makes sense:
>
>  * The old 3/3 is gone, but there's a new 2-3/3 which fix the only
>    actual leak that was left, i.e. the one in sequencer.c.
>
>  * We might want something like the 3/3 from v1 of this series where
>    we call clear_unpack_trees_porcelain() everywhere (and rename it to
>    unpack_trees_options_release()) just for good measure and in case
>    we'd ever add something to the struct that needs unconditional
>    freeing.
>
>    But let's punt on that here and just keep the current
>    setup_unpack_trees_porcelain()/clear_unpack_trees_porcelain()
>    behavior, callers who don't use setup_unpack_trees_porcelain() but
>    use "struct unpack_trees_options" don't need to call any free-like
>    function at the end.
>
> 1. https://lore.kernel.org/git/cover-0.2-00000000000-20211006T093405Z-ava=
rab@gmail.com/
>
> =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason (3):
>   unpack-trees: don't leak memory in verify_clean_subdirectory()
>   sequencer: add a "goto cleanup" to do_reset()
>   sequencer: fix a memory leak in do_reset()

Left a bunch of comments on patch 2.  The upshot is anywhere from "the
commit message just needs a few tweaks" to "well, maybe we should
clean up these other things too, and we could restructure some related
code...".  I'll let you pick where in that spectrum you want to take
things, because the other possible changes I mention beyond fixing the
commit message don't need to hold up this series.
