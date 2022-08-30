Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A962DECAAD5
	for <git@archiver.kernel.org>; Tue, 30 Aug 2022 19:09:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231149AbiH3TJd (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 30 Aug 2022 15:09:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36402 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231199AbiH3TJb (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 30 Aug 2022 15:09:31 -0400
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D2587331E
        for <git@vger.kernel.org>; Tue, 30 Aug 2022 12:09:30 -0700 (PDT)
Received: by mail-pj1-x1035.google.com with SMTP id u9-20020a17090a1f0900b001fde6477464so5783697pja.4
        for <git@vger.kernel.org>; Tue, 30 Aug 2022 12:09:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:user-agent:message-id:date:references:subject:cc:to
         :from:sender:from:to:cc:subject:date;
        bh=QP7uxzGOrQSg8uXSvSp8cRm1mdFl9nt2+DdbZU1vtOs=;
        b=alH1RAlidNl5ySk8jiCa9GpOZCwDWQFrGz31oXFHiYFi8deKYu9qIukpAZjyamykXG
         Q+eeMLJ/Yj2WzSkMhy5y7BPBK6GjML2UzsSOvt/R+Rgi+iVKm8OGfICq90aLVKKOJLtD
         NJroJ/eJCjKyZC8wWVAscHE4MgTI/uQSExUWEVY9StpgkizPlZ26XNjbpRfuDKgHThi1
         vKIC99sbiGvRxHEoMsb+4uNjVqNRpr2o+ezkpjbKYpAcWPf/4GOISHXvO8caaScJ4ygv
         cB8bld0VMeeSofl4mQY00X5YQZcp/raCrbIQLPk0/o6X0dhme2GdsNNEqBofnROQ0Ks1
         ljYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:user-agent:message-id:date:references:subject:cc:to
         :from:sender:x-gm-message-state:from:to:cc:subject:date;
        bh=QP7uxzGOrQSg8uXSvSp8cRm1mdFl9nt2+DdbZU1vtOs=;
        b=LjEM7hx87nuhjqSSNMY5fGQY4OdpGewf+BjsIz2WnKujgvVWuRjjOzYGp+A+SAB+W9
         f0/6k91qrMfNFZvrrFyg8RM1oiXOqv5jnJHq32Jq46vGGJTlAkMRSk7/zKZt+9OJKQQr
         yrRP6ppNutXFlFZ2hmiaElsRJHctfBMm9lYDiYR1sVE9WFtfSoqV2XmJePX4PgLQx5mC
         2VolBW9xuB8rHwz4BwmwyEExs4pv1/+wiU0nBhB3KyP4UGbaC+nlHlMetJd0RvRTimiz
         2wtU0k7uD8zpEgoDq86yMkwaFw/4GKbFac/C4zpqtvOc1584E/NZGNWqiLmx2GYnPEcK
         zp2g==
X-Gm-Message-State: ACgBeo23ZOlDtH43qA2nRankpd1BFSNj+H9N0cbycyL0blk+aclS0mCI
        kJ5LCbB4xrYU6WQHBp4YnaA=
X-Google-Smtp-Source: AA6agR5LsVepdvbFWfXvHApfkZafYhcghtPNsfUMT9XzRlxOwcG4lVWiT6ZNweJOyfJgzw73DJ0niQ==
X-Received: by 2002:a17:90b:1e45:b0:1fa:f63a:87fc with SMTP id pi5-20020a17090b1e4500b001faf63a87fcmr25437608pjb.208.1661886569940;
        Tue, 30 Aug 2022 12:09:29 -0700 (PDT)
Received: from localhost (33.5.83.34.bc.googleusercontent.com. [34.83.5.33])
        by smtp.gmail.com with ESMTPSA id gf23-20020a17090ac7d700b001f216407204sm8938217pjb.36.2022.08.30.12.09.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Aug 2022 12:09:29 -0700 (PDT)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH 1/3] add -p: avoid ambiguous signed/unsigned comparison
References: <pull.1340.git.1661867664.gitgitgadget@gmail.com>
        <0691d7eaaa03e8bf8b460b9e20ec05eec09fb574.1661867664.git.gitgitgadget@gmail.com>
Date:   Tue, 30 Aug 2022 12:09:29 -0700
Message-ID: <xmqqtu5tk0pi.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
writes:

> From: Johannes Schindelin <johannes.schindelin@gmx.de>
>
> In the interactive `add` operation, users can choose to jump to specific
> hunks, and Git will present the hunk list in that case. To avoid showing
> too many lines at once, only a maximum of 21 hunks are shown, skipping
> the "mode change" pseudo hunk.

Wow.

While the whole "add -i" was what I started, I admit that everything
more recent than the support of the "edit" action in "add -p" is
foreign to me.  I didn't remember the existence of, and the
justification for, the 20-line limit.  It seems that this came from
3f6aff68 (Add subroutine to display one-line summary of hunks,
2008-12-04).

> The comparison performed to skip the "mode change" pseudo hunk (if any)
> compares a signed integer `i` to the unsigned value `mode_change` (which
> can be 0 or 1 because it is a 1-bit type).

OK, that warrants a casting to signed, surely.

> Note: This is a long-standing bug in the Visual C build of Git, but it
> has never been caught because t3701 is skipped when `NO_PERL` is set,
> which is the case in the `vs-test` jobs of Git's CI runs.

Good finding.

> Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
> ---
>  add-patch.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/add-patch.c b/add-patch.c
> index 509ca04456b..3524555e2b0 100644
> --- a/add-patch.c
> +++ b/add-patch.c
> @@ -1547,7 +1547,7 @@ soft_increment:
>  			strbuf_remove(&s->answer, 0, 1);
>  			strbuf_trim(&s->answer);
>  			i = hunk_index - DISPLAY_HUNKS_LINES / 2;
> -			if (i < file_diff->mode_change)
> +			if (i < (int)file_diff->mode_change)
>  				i = file_diff->mode_change;
>  			while (s->answer.len == 0) {
>  				i = display_hunks(s, file_diff, i);
