Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C71A2C433EF
	for <git@archiver.kernel.org>; Thu, 17 Mar 2022 08:38:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231358AbiCQIj1 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 17 Mar 2022 04:39:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42244 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231343AbiCQIjZ (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 17 Mar 2022 04:39:25 -0400
Received: from mail-oo1-xc2b.google.com (mail-oo1-xc2b.google.com [IPv6:2607:f8b0:4864:20::c2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3625C2670
        for <git@vger.kernel.org>; Thu, 17 Mar 2022 01:38:06 -0700 (PDT)
Received: by mail-oo1-xc2b.google.com with SMTP id l24-20020a4a8558000000b00320d5a1f938so5619925ooh.8
        for <git@vger.kernel.org>; Thu, 17 Mar 2022 01:38:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=govvKbn5JHsvMlrhZkY//Fz/TMmgyy+/83bP+Tlb39Q=;
        b=SPQWtEIGZEnkXkt0v3OU2JaiQK3zckQO8vwcrZywH8kQhcm9YQ0yiYXa2SD5l1tY9Y
         N+U6fX7wNfWrNuJ9J6FH3y4R8JhKF/xk6vs9es3NYvl20IhffZYv7i3ggmdcoSXdSUrP
         3qRFGOwqs0XD+K59Tv96XiJIVlH8PQ6BMa7v+WfxPz9mdYm9/FE+nDGWB6Xat85BYnkU
         cHGjCkngWr7HFRcrRMptWqe9kkd0uAdhPxTCAEV79Qn8gKiYPPkRINq9lhJDEQbnQ4aD
         8Ha+VEpoj0ayCSYMTi1F1t7cgOTFI4/pveZNuobK7Jv14fH1T41Mxnyt3lbYvLcwbdP3
         J43A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=govvKbn5JHsvMlrhZkY//Fz/TMmgyy+/83bP+Tlb39Q=;
        b=dqtinTj5HLd9ODJbx/dcmaxYq3f0sR51mFyrLULbRWGzsTWuFl+XX7+UUYgxqGSO06
         hwxaS2xbv7tnJ8jo5U2Ylu22FvxqXC3PWj1jPjWxgodT9Zi64/wJ/iJRrgktP7ZxSK9E
         AagV9vo4MMMmmeWvq1xNVz7yH+T3Wx4M+qWDT1KBcZidvRD1KOEWAAExJ31Mi0G3V3Gr
         rhMzzXbF68HWirNRf3HuMtQuRyEDpSejf6Xw9uzhn9/NrMAvevtsaWhugjvdlLRgsVgz
         C0zuOlU3ceTMZXTqXzIunly/cWC/RWgQaU+SsGaAtrOPgcVQvIAY19odi9cisGgxcXvU
         dEVg==
X-Gm-Message-State: AOAM533olyb3VgWqwcP3SaRfWhX5tAeDoYIurXiUkA2Vbn/SnLL3P5Vj
        qUeLtm97a2GFhE0PViqRpV9bqPitHWPj1k+Bobk=
X-Google-Smtp-Source: ABdhPJyPnXdXdF4L4j+nDOYNlo9ZEPGQNvLm5KNpBQn/IeoOMmDK+ko73bxZz7R4LY5csfwWgWsGl9PbuRhork+CCaQ=
X-Received: by 2002:a05:6870:f713:b0:d2:8adb:aaeb with SMTP id
 ej19-20020a056870f71300b000d28adbaaebmr1344288oab.111.1647506285390; Thu, 17
 Mar 2022 01:38:05 -0700 (PDT)
MIME-Version: 1.0
References: <20220315100145.214054-1-shaoxuan.yuan02@gmail.com>
 <20220315100145.214054-2-shaoxuan.yuan02@gmail.com> <1ab24e4b-1feb-e1bc-4ae4-c28a69f77e05@github.com>
 <20ffd93d-e3dd-4df6-5ec7-d3577cac910d@github.com>
In-Reply-To: <20ffd93d-e3dd-4df6-5ec7-d3577cac910d@github.com>
From:   Shaoxuan Yuan <shaoxuan.yuan02@gmail.com>
Date:   Thu, 17 Mar 2022 16:37:52 +0800
Message-ID: <CAJyCBOTfaaeqhiRS6xFzQHpf-H35ATygKJqWYDijfPDJOGcShQ@mail.gmail.com>
Subject: Re: [RFC PATCH 1/1] mv: integrate with sparse-index
To:     Derrick Stolee <derrickstolee@github.com>
Cc:     Victoria Dye <vdye@github.com>, git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Derrick and Victoria.

On Wed, Mar 16, 2022 at 1:14 AM Derrick Stolee <derrickstolee@github.com> wrote:
> You mention in your cover letter that the ensure_not_expanded tests
> are not added yet (same with performance tests). Now that you've
> gotten feedback on this version of the patch, I might recommend the
> organization you might want for a full series:
>
> 1. Add these 'mv' tests to t1092 _without_ the code change. These
>    tests should work when the index is expanded, and making the
>    code change to not expand the index shouldn't change the
>    behavior.
>
> 2. Add the performance test so we have a baseline to measure how
>    well 'mv' does in the normal case (and how it is slower when
>    expanding the index).

I'm a bit caught up here.

Do I just do a before-code-change test and after-code-change test, and
benchmark the after against the before?

Or do you mean I should also perf test out-of-cone arguments with 'mv' so
that the index could be expanded? According to my understanding, the
sparse-index could be required to expand when out-of-cone actions
happen and the 'ensure_full_index()' is called. And do a 3-way comparison
among before-code-change, after-code-change, and after-code-change-
index-expanded, no?

-- 
Thanks & Regards,
Shaoxuan
