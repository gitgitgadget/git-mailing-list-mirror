Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7FA4C47082
	for <git@archiver.kernel.org>; Tue,  8 Jun 2021 17:51:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9E9CB61370
	for <git@archiver.kernel.org>; Tue,  8 Jun 2021 17:51:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233931AbhFHRxM (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 8 Jun 2021 13:53:12 -0400
Received: from mail-ot1-f42.google.com ([209.85.210.42]:37730 "EHLO
        mail-ot1-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233699AbhFHRxJ (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 8 Jun 2021 13:53:09 -0400
Received: by mail-ot1-f42.google.com with SMTP id v19-20020a0568301413b0290304f00e3d88so21142188otp.4
        for <git@vger.kernel.org>; Tue, 08 Jun 2021 10:51:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=f96nXztP7mtv4hJl7WSVkdopBKpTi6+fs0s+wXSk26E=;
        b=VHZIfc1pobiVV9QsEm63fDA04u0Irr/JJ2n/SYTE6tTy4elBgosXLg6WMyQ1k5IkIb
         jC1/xrsF0uO4qCWaJiNHOZKGzE4ScHr9+6BkwZAD8NOsSLMMVE6wyWAsc1k9hXskamDA
         rlhWQrr5TZd2QepyzVMtnCWbOa4KET2WBs5Y/xcZarjJhkfaSMb1+iZZQjPyi89FHMeR
         Z4GoacStPR31QgAur5ACa5iHpsA6oo32vDlo260JxUN+/xvalZug6C8yljUzoO49CNvo
         m/EDBgWpd5cM3LY0EEPwEW/3pnvuhA+O4ckbM1m1K666zAnI3iMcgEzD46DsEyD3WyiS
         TuBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=f96nXztP7mtv4hJl7WSVkdopBKpTi6+fs0s+wXSk26E=;
        b=AtnkMkvfg5nqLMldJB07QKVE8p0+6dUcVII8FyM9XcZPn+lKTBvhhBQGPhjJQePuMw
         m5qiULtClXiz9NzGYxUAgdKpOLvZClbPFzq3IFpkXAYNhzsB/nD7APgx2QOguTQT6Srj
         2KmScVUQUzMf5CnNLpRpDICz1Y719B9WG7rE1el7nhA+zHfkH3WFUDy6f+V6Bfm4Xlec
         BEFQ6mIVcxnARtNm37dNISfBOhnxvYPd19tnV07Ib3L71dUuZ8iN2n2HLdVd6TuEho3B
         yYl3U83nbkPhEHxf+uMjRMz/3fBpW9djY0jOoEnIK4frmP/OlN+nm2cvLTGXHc/++1ao
         9F5g==
X-Gm-Message-State: AOAM530vX/vSopUB/cf3DnncXB3uD1SnNYp+abmpfGLaTYPCs25IM8Ws
        dvjnmVowIwOk7zGPFKKWMX6AIrNAVe+MDr8qIn4=
X-Google-Smtp-Source: ABdhPJyuYz86k0lPrj6dBljSAmkiDMZsmRj/ngmYJxy5hDtGusLT69G1DXy2nNNlVmbSUAPUBBiWNx9jBKB8UiA0/ug=
X-Received: by 2002:a9d:7c8f:: with SMTP id q15mr3614980otn.162.1623174616642;
 Tue, 08 Jun 2021 10:50:16 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1622580781.git.jonathantanmy@google.com> <cover.1623111879.git.jonathantanmy@google.com>
In-Reply-To: <cover.1623111879.git.jonathantanmy@google.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Tue, 8 Jun 2021 10:50:05 -0700
Message-ID: <CABPp-BGL3L5uReVHtSUsNJ7fYgBV_Us5ZYv7e9FPHT2DuY-dyg@mail.gmail.com>
Subject: Re: [PATCH v2 0/4] First steps towards partial clone submodules
To:     Jonathan Tan <jonathantanmy@google.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Taylor Blau <me@ttaylorr.com>,
        Emily Shaffer <emilyshaffer@google.com>,
        Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Jun 7, 2021 at 5:26 PM Jonathan Tan <jonathantanmy@google.com> wrote:
>
> Thanks everyone for your reviews. I believe I've addressed all review
> comments, including the one from Elijah about the test failing with
> sha256 (which turns out to be because I didn't add a call to
> setup_git_directory(), which the other test helpers do).

Thanks for fixing those up.  I spotted some minor nits/questions, but
nothing big.

Looks like Junio did spot some bigger items...which raises a question
for me.  I have a series
(https://lore.kernel.org/git/pull.969.git.1622856485.gitgitgadget@gmail.com/)
that also touches partial clones.  Our series are semantically
independent, but we both add a repository parameter to
fetch_objects().  So we both make the same change, but you also make
additional nearby changes, resulting in two trivial conflicts.  So,
should I rebase my series on yours, should you rebase on mine, or
should we just let both proceed independently and double-check Junio
resolves the trivial conflicts in favor of your side?

Thoughts?
