Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82C27C001DE
	for <git@archiver.kernel.org>; Mon, 31 Jul 2023 16:30:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232312AbjGaQaL (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 31 Jul 2023 12:30:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33026 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233143AbjGaQ3m (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 31 Jul 2023 12:29:42 -0400
Received: from mail-oo1-xc29.google.com (mail-oo1-xc29.google.com [IPv6:2607:f8b0:4864:20::c29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 531762103
        for <git@vger.kernel.org>; Mon, 31 Jul 2023 09:29:18 -0700 (PDT)
Received: by mail-oo1-xc29.google.com with SMTP id 006d021491bc7-565f2567422so3223055eaf.2
        for <git@vger.kernel.org>; Mon, 31 Jul 2023 09:29:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20221208.gappssmtp.com; s=20221208; t=1690820956; x=1691425756;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=cD6adWQGerycZ5YlwtcxGkV+Ub5F5az98nmOoB/3dHA=;
        b=YtmxX/6HHvpmB5cukACWA5YPl3DvwTPWMW//qA4vQHaUrMNUaU9keR5xMlrf71XA5u
         HmtZs+VAZKoGqVpzKbvbMru563xAJJg7M98MAO4DmDdRzhdurtnLw6NaDFOr8IoIgUku
         1ZHtV6o26N9iY5DWQRUAEL96JU4NpnekJyjT9iJikNsY7GQeqX14HD36HL3kVPq218Vh
         Gog9WaD67ohbV9hSRJ5EArfxkK/KoIJmvzDW2XAMfX8jeYqG1qumQRS1tmPIe3ZA3gRB
         tT2/SKHes8FUAC6B/j45SXysMc1l67stkhr1MJeqU/JM1LpdF5P0Z+VZy6y33DQj46tq
         V92g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690820956; x=1691425756;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cD6adWQGerycZ5YlwtcxGkV+Ub5F5az98nmOoB/3dHA=;
        b=ZaWZucKrRJW1ZqjGziUF1Px5OOgRP5qINHh5MTCFBgQ2uUujHqW1vyj+6YyCzYKEXF
         xaRhMKxgOHyU5MEdzVWN55rLUmnqg2l+FC9eIPg583/8wA+HLCuBikGbYp/8VUMQzHXm
         eEsVKKwcxmUDc/V9R/rqFLDm0Hw9uZpS/iauW6DuSS2HHRLOLQCUasGxtitlg1tUm22s
         g36UgIHPd318tyjoCbX2ftqJrl8eZHEC5Sg+kHvwd1wbsLpXBu4azthhWgLDCWpu+IX0
         yJI/z1+ZmZf2Yo5aAv3vp8ggL4rhqmTRBhdSzFpYPs4H8MEbX8nsyVmtH4eSm6kMOf0r
         SYqw==
X-Gm-Message-State: ABy/qLaU+PQ9Zq6fYhLie+9Oyx/yiP1uCF7F10JwAldjYSqLpHEGjsNV
        cqZWPCiD6PIf/nFzuBUCkfZtdBYIkaLC7WVmLknhyg==
X-Google-Smtp-Source: APBJJlGC6LK5jgFGf6nHWXXbcHRLmrh8TFAGZ1CDpbZFC19lyUNA2tdEZLRh5YA3N/9aum37zjle4g==
X-Received: by 2002:a05:6358:2910:b0:135:69d5:1b13 with SMTP id y16-20020a056358291000b0013569d51b13mr564421rwb.0.1690820956313;
        Mon, 31 Jul 2023 09:29:16 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id m128-20020a0dfc86000000b005732b228a83sm3056280ywf.140.2023.07.31.09.29.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 31 Jul 2023 09:29:15 -0700 (PDT)
Date:   Mon, 31 Jul 2023 12:29:14 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org
Subject: tb/commit-graph-tests (was: Re: What's cooking in git.git (Jul 2023,
 #06; Thu, 27))
Message-ID: <ZMfhWkd24y7XjEIw@nand.local>
References: <xmqqh6po95a5.fsf@gitster.g>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqh6po95a5.fsf@gitster.g>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Jul 27, 2023 at 06:46:42PM -0700, Junio C Hamano wrote:
> * tb/commit-graph-tests (2023-07-24) 5 commits
>  - t/lib-commit-graph.sh: avoid sub-shell in `graph_git_behavior()`
>  - t5328: avoid top-level directory changes
>  - t5318: avoid top-level directory changes
>  - t/lib-commit-graph.sh: avoid directory change in `graph_git_behavior()`
>  - t/lib-commit-graph.sh: allow `graph_read_expect()` in sub-directories
>
>  Test updates.
>
>  Will merge to 'next'?
>  source: <cover.1690216758.git.me@ttaylorr.com>

I think this one is ready to go. Eric Sunshine gave the earlier round a
review, and I made sure to address his feedback in the subsequent
version.

I'm happy to wait for an ACK from him, but I think this is low-risk
enough that you could merge it as-is. Either way :-).

Thanks,
Taylor
