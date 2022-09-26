Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00AA2C6FA82
	for <git@archiver.kernel.org>; Mon, 26 Sep 2022 17:19:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230425AbiIZRTs (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 26 Sep 2022 13:19:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33146 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230280AbiIZRTW (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 26 Sep 2022 13:19:22 -0400
Received: from mail-yw1-x1134.google.com (mail-yw1-x1134.google.com [IPv6:2607:f8b0:4864:20::1134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 48300EBD64
        for <git@vger.kernel.org>; Mon, 26 Sep 2022 09:33:38 -0700 (PDT)
Received: by mail-yw1-x1134.google.com with SMTP id 00721157ae682-351630b1728so5148337b3.1
        for <git@vger.kernel.org>; Mon, 26 Sep 2022 09:33:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=Hscr+f7kByQbw1ymeguawCDJZtJAzHGwZNQqnhWa/8w=;
        b=RoaQL6ISISEpO6sAOj46EAXSm4I6ymGi6R2OcGaCRgoX3tOoji5GG78w+ORzQ/NE+D
         hmcHHHiyYR/+5Symvl4ukTEhqdJc86XNT2HJbYhkYAuFf910KWYTVwUoYZsJVKgVoktX
         338c4A4ihTpXTaG8AUZmP7qKz3N+heQXksinq/+Cr3IEcipFaZpqYfVpliqKn/kBKReA
         UTZBfQMR2gpTMtpkbl75dOGzVp8+YyMYtg9Tt0apUquIBvCPKZRuCuUowf0z/0WydcqT
         mEViNXQE271mZiuoHX6LbnFgLeUD+PjvTaH2vGOyryzx2TNq4Y1hJWqm4lfvHNSVJMVn
         BdsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=Hscr+f7kByQbw1ymeguawCDJZtJAzHGwZNQqnhWa/8w=;
        b=3tDrzSDeHaKuhUAG2XJFdnR/kWnUVn/m+ut09Y11HCLxCRgxA8zJ37MwS9503IaPZI
         btzLkD3ZstNVAUBs7E0aAOPfUextjRZu9xumR+hDKliqeAsM/uxzIJNmsHgcZXv6fV3y
         Af155J/G2BFm4v6TspvntPu1Ai1sxKnlsUY8YDVUl/+kGuxB6s4CI6x1aXBdUgYGB54w
         4U9OEwqCsnrr3SK5FnRx5FpkDrd8lZxcp/5epvhQUoqv5GYrJTiTmVVr+T+LFOIT6nwr
         lk7axfHCC7GiHOBdIHCKEi60e6YjFqLlYGlrkYuTbh0ZPQLpYaJFACBZTydxvQcVzVkJ
         quCw==
X-Gm-Message-State: ACrzQf12sHWosvgJhvPkWiCfytnYXZTWzZ6riOp9ZN72D+U3ybqu3qgn
        WYR1shLaVehHN/PYUs+zM5NLaN4zW7HpRINROTY13w==
X-Google-Smtp-Source: AMsMyM6DQ3LI8jLHiRYBgWGqJO7N4dMHiDsCpRoECMwqaXgwRAis3VcRAIQMVg9KFIM2T1tqmwvxWJzTjJq3EFO1aFE=
X-Received: by 2002:a81:7182:0:b0:349:de4c:7a00 with SMTP id
 m124-20020a817182000000b00349de4c7a00mr21300972ywc.385.1664210004370; Mon, 26
 Sep 2022 09:33:24 -0700 (PDT)
MIME-Version: 1.0
References: <20220922232947.631309-1-calvinwan@google.com> <xmqqleq9snr8.fsf@gitster.g>
In-Reply-To: <xmqqleq9snr8.fsf@gitster.g>
From:   Calvin Wan <calvinwan@google.com>
Date:   Mon, 26 Sep 2022 09:33:13 -0700
Message-ID: <CAFySSZDDGiSsrcioa_JsgtoqH1aMJfKV2UyCxwkjxa3eX+-Oww@mail.gmail.com>
Subject: Re: [PATCH 0/4] submodule: parallelize status
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, emilyshaffer@google.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

I'm getting the following error running that command locally:
Bailout called.  Further testing stopped:
GIT_TEST_PASSING_SANITIZE_LEAK=true has no effect except when
compiled with SANITIZE=leak
