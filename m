Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0E5FC433F5
	for <git@archiver.kernel.org>; Thu, 31 Mar 2022 09:29:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234203AbiCaJbD (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 31 Mar 2022 05:31:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37598 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233375AbiCaJar (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 31 Mar 2022 05:30:47 -0400
Received: from mail-oa1-x35.google.com (mail-oa1-x35.google.com [IPv6:2001:4860:4864:20::35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E19F91965F3
        for <git@vger.kernel.org>; Thu, 31 Mar 2022 02:28:30 -0700 (PDT)
Received: by mail-oa1-x35.google.com with SMTP id 586e51a60fabf-deb9295679so17500894fac.6
        for <git@vger.kernel.org>; Thu, 31 Mar 2022 02:28:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Znkf53A37ZgNx04pYd4FqtZWtnox82yeKcd2OVDOa3g=;
        b=C2tnW4QOfVn7RjPOB3XVxK7uXktLTdcEq4otKgkuhRcZjykTbCrxymy1+BIwnmZyAy
         HYCup5PAFWlc+iMcM2CuNVvcG2PcB4jRF5lgsTN/doXi3tCoHeZySpTVsrsTdQvocJKa
         W3MH2psxxL7C2EFRpURCNNFmWlJBqYM0TKyqml9Le5/4/BsDj1dC3prthkeuYJnRPmvc
         4n65PC9s67XwrAVi7ckC1cKOsrO92rICfTD62Y9hwyg0r2Y/uKCln2mfX5QeSri+pKe9
         yOL4WgSOyi9SOEFpDUJMrok4lGg/kpcs9834FpkuPBa6HnU82U2DjFltAJr+3mJA8DC0
         Dohw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Znkf53A37ZgNx04pYd4FqtZWtnox82yeKcd2OVDOa3g=;
        b=VR42afMud7bftRRS/TmwyeDvi53/sNlwygV1UW7PkqmHsvW0eH4nbcoBzLvRyNI8Bb
         uGhMhZwwEd9dWPxjrU22IDauAd3CGveu6KOfjdFFI4l7NtyYlFrsujaLRKlT9hqw9V0w
         tuszX3gqYJfqybp5YaPj9PfzxZh+LZrrXQzIb1+fXF6jp0LHtU/Iuj9wT8mbP1zJFq85
         7/iB32GoV9cn4xJFlYR+rOn1OSOEkexK+SWPjXhcaRJXLp228uWqZyKIiJMxsocivxPK
         swPx8BLoYn7MOwfKIMVQsQNpbB54CH8z6ExNkF0cIoPlTnzlNhsTbObs8rkljG+3oFYY
         iVXg==
X-Gm-Message-State: AOAM531xgnVkUq/4ENuJnsyTFU6bzu3ZPvAfYQCK+naqzPEtEgzAtRIp
        w4FUJO3o+hQ2yfYHMqOn/Dd5yXz+OG6s1U7EWWsEKi86ohc=
X-Google-Smtp-Source: ABdhPJzvPMoKmg1fJ68jn8LqdcUYpM56uYyBQS4TFcn+Om4eAOpT3cDAQEkaxv8LOWXsnlgrimzfiA0jDNyG6N5E2xM=
X-Received: by 2002:a05:6870:f697:b0:da:b3f:3268 with SMTP id
 el23-20020a056870f69700b000da0b3f3268mr2203779oab.280.1648718909220; Thu, 31
 Mar 2022 02:28:29 -0700 (PDT)
MIME-Version: 1.0
References: <20220331091755.385961-1-shaoxuan.yuan02@gmail.com>
In-Reply-To: <20220331091755.385961-1-shaoxuan.yuan02@gmail.com>
From:   Shaoxuan Yuan <shaoxuan.yuan02@gmail.com>
Date:   Thu, 31 Mar 2022 17:28:18 +0800
Message-ID: <CAJyCBOQaojt8u_KaobDuQS7hWRC0Bgf82c_geZj4hOw_HB4ZNA@mail.gmail.com>
Subject: Re: [WIP v1 0/4] mv: fix out-of-cone file/directory move logic
To:     git@vger.kernel.org
Cc:     vdye@github.com, derrickstolee@github.com, gitster@pobox.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Mar 31, 2022 at 5:20 PM Shaoxuan Yuan <shaoxuan.yuan02@gmail.com> wrote:
>
> Before integrating 'mv' with sparse-index, I still find some possibly buggy
> UX when 'mv' is interacting with 'sparse-checkout'.
>
> So I kept sparse-index off in order to sort things out without a sparse index.
> We can proceed to integrate with sparse-index once these changes are solid.
>
> Note that this patch is tentative, and still have known glitches, but it
> illustrates a general approach that I intended to harmonize 'mv'
> with 'sparse-checkout'.
>
> Shaoxuan Yuan (4):
>   mv: check if out-of-cone file exists in index with SKIP_WORKTREE bit
>   mv: add check_dir_in_index() and solve general dir check issue
>   mv: add advise_to_reapply hint for moving file into cone
>   t7002: add tests for moving out-of-cone file/directory
>
>  builtin/mv.c                  | 76 ++++++++++++++++++++++++++++++++---
>  t/t7002-mv-sparse-checkout.sh | 72 +++++++++++++++++++++++++++++++++
>  2 files changed, 142 insertions(+), 6 deletions(-)
>
>
> base-commit: 805e0a68082a217f0112db9ee86a022227a9c81b
> --
> 2.35.1
>

The original related RFC patch is [1], and this patch should be
--in-reply-to [2].

[1] https://lore.kernel.org/git/20220315100145.214054-1-shaoxuan.yuan02@gmail.com/
[2] https://lore.kernel.org/git/97a665fe-07c9-c4f6-4ab6-b6c0e1397c31@github.com/

-- 
Thanks & Regards,
Shaoxuan
