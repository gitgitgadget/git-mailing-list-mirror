Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B41E4C6FD1F
	for <git@archiver.kernel.org>; Thu, 16 Mar 2023 21:16:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229900AbjCPVQb (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 16 Mar 2023 17:16:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35778 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230020AbjCPVQ0 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 16 Mar 2023 17:16:26 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D1B7D30AC
        for <git@vger.kernel.org>; Thu, 16 Mar 2023 14:16:19 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id 4-20020a250204000000b00b63937e3c7fso115948ybc.20
        for <git@vger.kernel.org>; Thu, 16 Mar 2023 14:16:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112; t=1679001379;
        h=cc:to:from:subject:message-id:mime-version:in-reply-to:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=waBMyCoOIQcUxFr3j2qj3keJ24aBKipO/GqNMyr83j8=;
        b=rue6+QT5RI2xGprzgjYN+55fFN8Xe8xsibl4/+CNe1DcFuPUnjFoV8L8g8ig1VBCaS
         ItQzuQkJFg8gIvwFz59OHKD48Bx8N2K6XGuWPvXzmTW8lZKF7Fd3AIpVAl8+DoEtzaHR
         S9OugcHLmqlOuqa/bcgT5EOGOfw1lePNjQzsEDNNmkSN1cmbDmoh3G5wrzg6YSfg/GWC
         fMSf7b5IOIc1FOWfYRfHWt5Lwteett+9WhdC7QdkiLl9ax/VU/TelRdJ21SrhPhQPaa4
         o7F+hkBp4CSGfozOmRX6xDHzeuO15kSdXX5hbAfJjQNVEyvCAZmSKZ3DmriNgGyxML0G
         G2bw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679001379;
        h=cc:to:from:subject:message-id:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=waBMyCoOIQcUxFr3j2qj3keJ24aBKipO/GqNMyr83j8=;
        b=X2izsyi2mMCnul3FvRuCPCU6K/30eclo3dlraMqV28SH264T1rX6Vw4g6ovU9MENuP
         XO1Za4PjJMGfQ0CRPW1F7WTQBZzb8ZUPIbZuyp6BgMxG+DBJrIOSnc26A3A9mZQh6+DI
         Ig5m83wO8fo70shtYvg7Pj9C9R5Iu9VA6dARb8ca0SQfnXoYQ5gzq6iy2c92Quf+raTR
         ewtGFZ/pAYPFzxx/MicFj5Im5j/CG7AxOhAw80+ULNoB8yHfcRSAV6sMOOCxW6S6OXrM
         8djlN6f2vRJsj1apfPZ/cE4/ckfpGXbfXQxunMLAEN+t6dtt43BSkoSb5m+8HBY+J9y5
         5eLQ==
X-Gm-Message-State: AO0yUKW30s4QX/SvcmzZQQr+EQD9qppkbH43r10zjFrZqd74Yhdu3MAO
        DXDo+MT5WdFC5ZWIv6UuAb7rXqDzWqgRuX/zI9QG
X-Google-Smtp-Source: AK7set9GoBCbUToNUtlsga91geu6/kQHFjz05iRpx34MKgWmdxc/ZqkDDfT552lifHsyPgqf8RVRnU4JYVwB4US4nJgY
X-Received: from jonathantanmy0.svl.corp.google.com ([2620:15c:2d3:202:9170:84f8:2856:fe19])
 (user=jonathantanmy job=sendgmr) by 2002:a81:1904:0:b0:542:927b:1c79 with
 SMTP id 4-20020a811904000000b00542927b1c79mr543811ywz.3.1679001379022; Thu,
 16 Mar 2023 14:16:19 -0700 (PDT)
Date:   Thu, 16 Mar 2023 14:16:16 -0700
In-Reply-To: <75d0f0efb7924fa6ce2387b1a8e4105d672a991f.1678925506.git.gitgitgadget@gmail.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.40.0.rc2.332.ga46443480c-goog
Message-ID: <20230316211616.312796-1-jonathantanmy@google.com>
Subject: Re: [PATCH v2 1/8] config.c: plumb config_source through static fns
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

"Glen Choo via GitGitGadget" <gitgitgadget@gmail.com> writes:
> but we will rename "cf" to "cs" by the end of the
> series.

Let's remember that this might not happen if we decide to drop the last
patch. Other than that, everything looks good in this patch.
 
