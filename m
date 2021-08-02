Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.2 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1DB1CC4320A
	for <git@archiver.kernel.org>; Mon,  2 Aug 2021 21:56:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 064BC60E78
	for <git@archiver.kernel.org>; Mon,  2 Aug 2021 21:56:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231894AbhHBV42 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 2 Aug 2021 17:56:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47812 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230313AbhHBV41 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 2 Aug 2021 17:56:27 -0400
Received: from mail-lf1-x129.google.com (mail-lf1-x129.google.com [IPv6:2a00:1450:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 027E2C06175F
        for <git@vger.kernel.org>; Mon,  2 Aug 2021 14:56:17 -0700 (PDT)
Received: by mail-lf1-x129.google.com with SMTP id z2so36395542lft.1
        for <git@vger.kernel.org>; Mon, 02 Aug 2021 14:56:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=HxXh+PJGJ1kBUyN7H+uoTmIBzSn59BcL2iePJF+lnoo=;
        b=ViBgS//7SILHhjWBT82XC/u0BYWIdCljTDRv+R2IeMpkeFW5L0zrLHq3FRUmwcM3yJ
         gYprE69K4bjFU54VE81BHavfqBbP2DjqvEmLF1X2PQBSdDZ2SBBgFhnF6g2YHmf762VU
         W8PSSGn/KhgWv7b6mMFJ2t3cKu974QUoIzn4PFXc5xInRKHspqXPzlu4cY8oKIelySU1
         73g/WayJBmBv+w1HHg12h350Zs0dABNDWQDVtmk4VRVzJwnlBnE1YE/I+O5OcqZryTzp
         iR89sfOMbH1I5qCVS30bYD8chU2PDJvHEl+NngQMQZi06pNNW24aJpZAPpy2P1k3hDUV
         nMmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=HxXh+PJGJ1kBUyN7H+uoTmIBzSn59BcL2iePJF+lnoo=;
        b=UtTEXghufohdM8ng+SFOpe3ptA9wRTOsxyteWu3Ja/tc145Vl01CIhVqvseu15CbYg
         qEwUn7t11g+E9VtECdsotPrkT2JTdYVtraYMLGbAplLWT0rJh0Sh6wwOrEgtuOASMbH+
         i3kNyQZUjkVixb9C9y52YElEDQEQ6Tqr/22GKVTz9711K3bK394/3FCY7SsNAjGuuHTH
         5YIJSDIUC56RYdVtvT87t5/8gELrlKVsbCmzDdbPkT/pI+NWzuuMW/b4fwA/ocOGwIUp
         e5HRA5tMYza9DgNbEYvu8hSQruHo7rvsoMm/w1qsVWTQDrTuAowDl+uRLqszTGmaYLg2
         du4w==
X-Gm-Message-State: AOAM530vpXSfJkLDcrXknQEp9aQP+mbwBEk+Luhcd7n7Z+wIz+HNaVNG
        AxDUfWIEMfSZzwp8TT4lC51DHh/pvXkyItV4Ro0epnr+cZ8=
X-Google-Smtp-Source: ABdhPJwLT15BpeuHqZ/510YCU//iB4u9opj5zFMJD6PvaxpCocOSiDQxvS/HsqRJGjXSZKT3Q9Vqg7pfVrg48iRYH3c=
X-Received: by 2002:a05:6512:3fa7:: with SMTP id x39mr14161877lfa.621.1627941374971;
 Mon, 02 Aug 2021 14:56:14 -0700 (PDT)
MIME-Version: 1.0
References: <xmqqk0l4xuvo.fsf@gitster.g>
In-Reply-To: <xmqqk0l4xuvo.fsf@gitster.g>
From:   Emily Shaffer <emilyshaffer@google.com>
Date:   Mon, 2 Aug 2021 14:56:03 -0700
Message-ID: <CAJoAoZnsMPV+By_sYrqhRsZp6PiZk_0ZcC=2sjvPLaNNxpAPxQ@mail.gmail.com>
Subject: Re: What's cooking in git.git (Aug 2021, #01; Sun, 1)
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Git List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Aug 1, 2021 at 10:45 PM Junio C Hamano <gitster@pobox.com> wrote:
> * es/trace2-log-parent-process-name (2021-07-22) 2 commits
>  - tr2: log parent process name
>  - tr2: make process info collection platform-generic
>
>  trace2 logs learned to show parent process name to see in what
>  context Git was invoked.
>
>  Looking good.  Ready for 'next'?

I think so, unless anybody is really keen to comment still. I feel
much more comfortable with this change after making the build changes
suggested by Jeff H., and he left a LGTM.
 - Emily
