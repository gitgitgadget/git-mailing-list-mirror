Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5719C76196
	for <git@archiver.kernel.org>; Thu, 16 Mar 2023 22:30:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229652AbjCPWaJ (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 16 Mar 2023 18:30:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49396 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230281AbjCPW37 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 16 Mar 2023 18:29:59 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D43D9B7193
        for <git@vger.kernel.org>; Thu, 16 Mar 2023 15:29:26 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id l84-20020a252557000000b00b61b96282a4so1389856ybl.0
        for <git@vger.kernel.org>; Thu, 16 Mar 2023 15:29:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112; t=1679005765;
        h=cc:to:from:subject:message-id:mime-version:in-reply-to:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=uubF65/pfPy4h6mNk2dcg+vr8YJqDvdvuyPu/c9E3Ts=;
        b=J5TmHMcIwe6/47+Ru93x2G1cL8uam/B0TCVggbspk4iSVqbS6PCR80VbaSZd4kzlUp
         ah5eLk9Izairx/AVQvT+7wVRwVTYymm/mxW61rGD45ez1mbCIoWUNOUTMiaW01mHcQU7
         PlL6DyH1NQWXL6GJp9I8VfFsXZBmi+w/pe5fiRMGdeeGGcDeES9WXpu9OU2V9ZQI/xLY
         S9rrpezxXPXds5eypjg4YR83ZSgsmnJfNzzfUV8u4grYiqxHoxo/MIEQpk8YBABdZ4MD
         51rQ0Evi/FxIab/3+FTrON24V3Jm7t2zE57v0swcGYe9oh+NJ9tXnq8OOSCVlcEjaTOC
         E4Ig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679005765;
        h=cc:to:from:subject:message-id:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=uubF65/pfPy4h6mNk2dcg+vr8YJqDvdvuyPu/c9E3Ts=;
        b=tGTKahoqOPqXdrexSBSsq6RnTOCfMeB+v8SLv4DHfNYk2N3l/rEhw/d0Dmz/EQIe/y
         6rPVaBRTWfulDzwItdhy4bdZkg4LV+H1pZKmrYPOBn1pvNYrpyOWpJJHN0k5wBgVmUkA
         q+15HBHrKT8hWx5SwBlIGh/rFp0yN0dipuyZSsq0vhkPtbWi2rjRhyw5r1yR4XHEdpRZ
         3RoUH0y8uU+pKuQBj/t88LT+ngCFvJEimN6xeXbEfB/t3XeJscQ9JIABUyhBpaREjR4w
         i9GJbqYDr+U33IYcJDAt+dhfJHFqjtDzWDeeqHwc658JiV5DM6b47tgrupaVhD6CIGqX
         P+FA==
X-Gm-Message-State: AO0yUKUS1nacHY2ZxWhDr4ufcEvmcESwsWmlxht5TiaiSvjLK3ddSG0S
        xtr9xmj49HbcmdmI3WmBwvI75DBlNNAdknX6Vogj
X-Google-Smtp-Source: AK7set+XtbiGon3LrUba6k/zIULjsdqb7u0drMCbZGK27Z8lY+S4prPYN1NUWYYJ1RYPqHggHTavqqtR66SARvF9ifzP
X-Received: from jonathantanmy0.svl.corp.google.com ([2620:15c:2d3:202:9170:84f8:2856:fe19])
 (user=jonathantanmy job=sendgmr) by 2002:a5b:112:0:b0:b17:294f:fb30 with SMTP
 id 18-20020a5b0112000000b00b17294ffb30mr22256475ybx.2.1679005765286; Thu, 16
 Mar 2023 15:29:25 -0700 (PDT)
Date:   Thu, 16 Mar 2023 15:29:23 -0700
In-Reply-To: <pull.1463.v2.git.git.1678925506.gitgitgadget@gmail.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.40.0.rc2.332.ga46443480c-goog
Message-ID: <20230316222923.321352-1-jonathantanmy@google.com>
Subject: Re: [PATCH v2 0/8] config.c: use struct for config reading state
From:   Jonathan Tan <jonathantanmy@google.com>
To:     Glen Choo via GitGitGadget <gitgitgadget@gmail.com>
Cc:     Jonathan Tan <jonathantanmy@google.com>, git@vger.kernel.org,
        Emily Shaffer <nasamuffin@google.com>,
        Jeff King <peff@peff.net>,
        Derrick Stolee <derrickstolee@github.com>,
        Calvin Wan <calvinwan@google.com>,
        "=?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?=" 
        <avarab@gmail.com>, Glen Choo <chooglen@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

So overall what this series does is to create a struct that contains
config parsing state (roughly speaking...it's either parsing state or
a "kvi" that contains some of the parsing state that existed when its
value was parsed), starts a pattern in config.c in which that struct
is passed between functions as much as possible, and establishes a few
functions like reader_origin_type() that make it convenient to work
on the basis of this struct as opposed to on the config_source and kvi
individually. And following this pattern, I think, likely would have
enabled us to avoid the bug in patch 7/8 and enable us to avoid similar
bugs in the future, so overall I'm happy with this series.

"Glen Choo via GitGitGadget" <gitgitgadget@gmail.com> writes:
>    Introduce 8/8 to get rid of the confusing acronym "struct config_source
>    cf", but I don't mind ejecting it if it's too much churn.

I think patch 8/8 is not worth including, so I didn't leave comments on
it, but I'm fine if it ends up merged too.
 
