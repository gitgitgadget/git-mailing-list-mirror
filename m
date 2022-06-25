Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40FB7C43334
	for <git@archiver.kernel.org>; Sat, 25 Jun 2022 02:31:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231434AbiFYCbc (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 24 Jun 2022 22:31:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51378 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230224AbiFYCbb (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 24 Jun 2022 22:31:31 -0400
Received: from mail-yb1-xb35.google.com (mail-yb1-xb35.google.com [IPv6:2607:f8b0:4864:20::b35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A84944A30
        for <git@vger.kernel.org>; Fri, 24 Jun 2022 19:31:31 -0700 (PDT)
Received: by mail-yb1-xb35.google.com with SMTP id x184so4673092ybg.12
        for <git@vger.kernel.org>; Fri, 24 Jun 2022 19:31:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=LOs0+jP5EvWCEjiRklv+w0uoW8YEVYn6YuhC/Np6+Pg=;
        b=eN3nnkjNT3UFp61oUjf4dWVW9o/JyhoGeo178szC49E6ZXLb2Efg+TJ99UW6107JF2
         3HIrfHNzDanugyAarFWxcs7xIzPmJX/iI4L7rQMhSSz6eB4OLVj/WatEgzG/vld8jtOw
         TWShhZJpwnoCRAghJLL8G8OgT29kC+m4lN9DPNpXtqySnXacZbUtCXg92SDIX3ErkOj8
         xetJkojaffU7uVbT6CSei+0gSahk+jOyeoHLV8O6EeJJ43mJ0HVbIoXgjrWpKhwrz/fx
         nZsVaT+UBV+TmDtxbe01BNsGWx0ZlB/0f61ErfFNxJwkCoI2JoECMVgFWXpnO/I2MKaY
         ZMrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=LOs0+jP5EvWCEjiRklv+w0uoW8YEVYn6YuhC/Np6+Pg=;
        b=D5D1cN9t9jrgxd0FqztM5eGcOO3mTuwuJQ3JVtuyRM3/uLMPU1bmKclgNTGyucWOoU
         8QpmDMiD5gsJ+giX+UMtd1cKA9wgLzTxonO7NxEHkVLHAWfzSDbMgAzuvIZmZ4PQKcUN
         29hX0/KCsTVlXvpS203QUZhxaP3e7hxHyUIxBu5InDRdriqYyXTnw3BTCsX2bvCvtvWt
         XiYKmNUiyhMK4c/G6/WKzKO2drxML0p2KZgKCPVFMA2NL3R4U0zjBLV43ufYY9UYLwU+
         +TJgBqgZBt25QD3C1IWqW867ho4lM6+Ke+KhIr95umDRzU0c9h77ZESnAQmuppe3KR+K
         A58A==
X-Gm-Message-State: AJIora8ySi0kQ3up7BaqQbGX74mGXPNjp6NVj6eM4cAbZh/R9JFXffME
        oYg4X3mlXT3mbkQOqNAh6OsxBMWZXsBf9MG6H0f8TA==
X-Google-Smtp-Source: AGRyM1vBdHJ4gSZHENzNrSpTrogdVwo5YBr4tF6Qhj1PmhqCjCc4YaGtlbz7SW2JCdG9NnqwrToBdB/sdc+oECnu8+E=
X-Received: by 2002:a25:3c45:0:b0:664:cf75:c2d6 with SMTP id
 j66-20020a253c45000000b00664cf75c2d6mr2206300yba.446.1656124290390; Fri, 24
 Jun 2022 19:31:30 -0700 (PDT)
MIME-Version: 1.0
References: <20220618030130.36419-1-hanxin.hx@bytedance.com>
 <cover.1656044659.git.hanxin.hx@bytedance.com> <d3a99a5c5ae538b626e04d7069dd2fc316605dfc.1656044659.git.hanxin.hx@bytedance.com>
 <xmqqpmiyuhjj.fsf@gitster.g> <CAKgqsWXwf5h7r4fqOnfTbe6vyR25PzQ+hhEddCQV3cMis2ruEg@mail.gmail.com>
In-Reply-To: <CAKgqsWXwf5h7r4fqOnfTbe6vyR25PzQ+hhEddCQV3cMis2ruEg@mail.gmail.com>
From:   Han Xin <hanxin.hx@bytedance.com>
Date:   Sat, 25 Jun 2022 10:31:19 +0800
Message-ID: <CAKgqsWXm6aUjG1i7Z7GzKKbs8+yw=dQSu2LWj3fB19LR5aVh_g@mail.gmail.com>
Subject: Re: Re: [PATCH v2 2/2] commit-graph.c: no lazy fetch in lookup_commit_in_graph()
To:     Junio C Hamano <gitster@pobox.com>
Cc:     chiyutianyi@gmail.com, derrickstolee@github.com,
        git@vger.kernel.org, haiyangtand@gmail.com,
        Jonathan Tan <jonathantanmy@google.com>,
        Taylor Blau <me@ttaylorr.com>, Patrick Steinhardt <ps@pks.im>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Jun 25, 2022 at 10:25 AM Han Xin <hanxin.hx@bytedance.com> wrote:
>
> The "bug" depends on the commit exist in the commit-graph but
> missing in the repository.
>
> I didn't find a better way to make this kind of scene.
>
> This bug was first found when alternates and commit-graph were
> both used. Since the promise did not maintain all the references,
> I suspect that the "auto gc" during the update process of the promise
> caused the loss of the unreachable commits in the promise.
>

Some mistakes here:
This bug was first found when alternates and commit-graph were
both used. Since the promise did not maintain all the references,
I suspect that the "auto gc" during the update of the alternates
caused the loss of the unreachable commits.
