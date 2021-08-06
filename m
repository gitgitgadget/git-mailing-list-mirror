Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47610C4338F
	for <git@archiver.kernel.org>; Fri,  6 Aug 2021 19:30:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1E4EB6115C
	for <git@archiver.kernel.org>; Fri,  6 Aug 2021 19:30:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243917AbhHFTbD convert rfc822-to-8bit (ORCPT
        <rfc822;git@archiver.kernel.org>); Fri, 6 Aug 2021 15:31:03 -0400
Received: from mail-ej1-f47.google.com ([209.85.218.47]:34720 "EHLO
        mail-ej1-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243646AbhHFTbC (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 6 Aug 2021 15:31:02 -0400
Received: by mail-ej1-f47.google.com with SMTP id u3so16790654ejz.1
        for <git@vger.kernel.org>; Fri, 06 Aug 2021 12:30:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=6oOC/yiemJfhzZZfjFuBejnWEH8NomGP3DPN3mLKCF0=;
        b=rhFT+GG2dJrFptaK7v2bOkbrz74vmrQNpcBHw7kepvUyFmR22FdLlQSP3XglIDE7Vm
         VZqyxuiV4VGw/Zs3JjabasKOh+tfcTlKIx4lO6kYQuh0rM5TzQ17LdM9irzDnzex8xvh
         Lgrs9Q+vbVBh+TTV5jZZ3KcmROtzQgbR6Hme0uMBfKSW2/+gG2OVm2jEdtoT0DvOQutx
         unGVIrO5HSmJNxLk7pjXjWkMfbEFonib2rBMmx9PsIQj/u6CKlkkA9NNO+8BUz9GVwe7
         0MURL6cBYdo8tFEzWYjvmQa4yB98t8ynpkxhw5DU6d89nNa0tuJ3yWtVX4gwejTMwSx5
         V5sg==
X-Gm-Message-State: AOAM530u+C5Fdic8ICWHHsgd9Hz3mGo5RTs4SLTbn88Yv7c7vIo4pMcG
        hTeTDlPvkNEyupkHRKLZSSkrqXqRlbSDy9KAstU=
X-Google-Smtp-Source: ABdhPJxEZIwyYtwJRty98UQK1Vdn8HckpyCbTJiEY2myjWDuRpxB+fyK7qSpAuKmi7AtrHFlgHZJ3YTkPJsm9UjeD30=
X-Received: by 2002:a17:906:b2d9:: with SMTP id cf25mr11665738ejb.138.1628278245743;
 Fri, 06 Aug 2021 12:30:45 -0700 (PDT)
MIME-Version: 1.0
References: <20210805230321.532218-1-mathstuf@gmail.com> <RFC-cover-v3-0.4-0000000000-20210806T191231Z-avarab@gmail.com>
 <RFC-patch-v3-2.4-eefcafcf8f-20210806T191231Z-avarab@gmail.com>
In-Reply-To: <RFC-patch-v3-2.4-eefcafcf8f-20210806T191231Z-avarab@gmail.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Fri, 6 Aug 2021 15:30:34 -0400
Message-ID: <CAPig+cQiSzXG4NBX+X+1XxjQ9AN4B6us3m-gj-11zctCcm0NqQ@mail.gmail.com>
Subject: Re: [RFC PATCH v3 2/4] advice: remove read uses of most global
 `advice_` variables
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Cc:     Git List <git@vger.kernel.org>, Ben Boeckel <mathstuf@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

/On Fri, Aug 6, 2021 at 3:13 PM Ævar Arnfjörð Bjarmason
<avarab@gmail.com> wrote:
> In c4a09cc9ccb (Merge branch 'hw/advise-ng', 2020-03-25), a new API for
> accessing advice variables was introduced and deprecated `advice_config`
> in favor of a new array, `advice_setting`.
>
> This patch ports all but two uses which read the status of the global
> `advice_` variables over to the new `advice_enabled` API. We'll deal
> with advice_add_embedded_repo and advice_graft_file_deprecated
> seperately.

s/seperately/separately/

> Signed-off-by: Ben Boeckel <mathstuf@gmail.com>
> Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
