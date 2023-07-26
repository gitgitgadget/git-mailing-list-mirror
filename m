Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 976D3C001DE
	for <git@archiver.kernel.org>; Wed, 26 Jul 2023 05:41:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231516AbjGZFlP convert rfc822-to-8bit (ORCPT
        <rfc822;git@archiver.kernel.org>); Wed, 26 Jul 2023 01:41:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36544 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229932AbjGZFk5 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 26 Jul 2023 01:40:57 -0400
Received: from mail-qv1-f52.google.com (mail-qv1-f52.google.com [209.85.219.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2CB92693
        for <git@vger.kernel.org>; Tue, 25 Jul 2023 22:40:55 -0700 (PDT)
Received: by mail-qv1-f52.google.com with SMTP id 6a1803df08f44-63cebd0a7c5so18087636d6.3
        for <git@vger.kernel.org>; Tue, 25 Jul 2023 22:40:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690350055; x=1690954855;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QTCdfCJhPCk5GkYf0jxlRWSzbfmxPlDvL83mBm2vI/U=;
        b=SUYAJFodVCmsxrg9AY0Fcj8GD51rRbmVMLHVMswsjPn2NNWSgFHS0oBtFq/RDP1cXr
         kV1xgM6kMcHxDFPWsrSn9i9+TGxFwJ7KITB6OnkhQOXM3n2wa3NVIkY+UADKx1/gpJWS
         aKW+xSVCSLkAFbUtxg5evoM/5LzrHzBQTqIq3OOR9aD9u8iicqPTmNpk67dXztaGjuph
         HCSua6IlwJTENjeumktoq2mpRKiKEOEtWMS3XPfNUuPHDmN2f3JB8Bcsq1MxtmypUtbB
         9b96rHK1/rRRt1/BdbFg/HplW19NLFItTHciP+R6fPq10jS9mue3Jsfj0ZNeXiI+Fokl
         5qtQ==
X-Gm-Message-State: ABy/qLbpk17jmXrCkiUtPtxFYYpk/eumRLQN0DEm6hhId1deumViers5
        TNEGESLwf7Nua5HtoDvokWdX41YzTb4o7Dv8frk=
X-Google-Smtp-Source: APBJJlHOl6TbswLx5pKHx4cNcrNQ3GNtpv+yBoHza8AV+wuPs9tAbLJcxSPw2HOXfQ3tqKYYDXLC3SFjl1tL88VBhho=
X-Received: by 2002:ad4:414a:0:b0:63c:f325:5aac with SMTP id
 z10-20020ad4414a000000b0063cf3255aacmr896824qvp.19.1690350054742; Tue, 25 Jul
 2023 22:40:54 -0700 (PDT)
MIME-Version: 1.0
References: <pull.1556.v2.git.1689314493.gitgitgadget@gmail.com>
 <pull.1556.v3.git.1690340701.gitgitgadget@gmail.com> <xmqqh6prfe0u.fsf_-_@gitster.g>
In-Reply-To: <xmqqh6prfe0u.fsf_-_@gitster.g>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Wed, 26 Jul 2023 01:40:43 -0400
Message-ID: <CAPig+cSheNKUg7=v4i6Kr6zs8Jftooq4c_4gkGUcpMRDia-0oQ@mail.gmail.com>
Subject: Re: [PATCH v3 6/5] SubmittingPatches: choice of base for fixing an
 older maintenance track
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Linus Arver via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Linus Arver <linusa@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Jul 26, 2023 at 1:38 AM Junio C Hamano <gitster@pobox.com> wrote:
> When working on an high-value bugfix that must be given to ancient
> maintenance tracks, a starting point that is older than `maint` may
> have to be chosen.
>
> Helped-by: Linus Arver <linusa@google.com>
> Signed-off-by: Junio C Hamano <gitster@pobox.com>
> ---
> diff --git a/Documentation/SubmittingPatches b/Documentation/SubmittingPatches
> @@ -46,7 +46,12 @@ latest HEAD commit of `maint` or `master` based on the following cases:
>  * If you are fixing bugs in the released version, use `maint` as the
>    starting point (which may mean you have to fix things without using
>    new API features on the cutting edge that recently appeared in
> -  `master` but were not available in the released version).
> +  `master` but were not available in the released version). If the bug
> +  exists in an older version (e.g., commit `X` introduced the bug, and
> +  `git describe --containx X` says `v2.30.0-rc2-gXXXXXX` has it), then

s/containx/contains/

> +  use the tip of the maintenance branch for the 2.30.x versions in the
> +  `maint-2.30` branch in https://github.com/gitster/git[the maintainer's
> +  repo].
