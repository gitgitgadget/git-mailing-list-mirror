Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB39FC4332F
	for <git@archiver.kernel.org>; Fri,  9 Dec 2022 18:27:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229891AbiLIS1F (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 9 Dec 2022 13:27:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51636 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229591AbiLIS07 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 9 Dec 2022 13:26:59 -0500
Received: from mail-pf1-x44a.google.com (mail-pf1-x44a.google.com [IPv6:2607:f8b0:4864:20::44a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 32A7C379E9
        for <git@vger.kernel.org>; Fri,  9 Dec 2022 10:26:59 -0800 (PST)
Received: by mail-pf1-x44a.google.com with SMTP id 191-20020a6214c8000000b00577ab8701b0so3796472pfu.0
        for <git@vger.kernel.org>; Fri, 09 Dec 2022 10:26:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:mime-version:in-reply-to:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=enMA1Z9xSWE56IA1Msn96Fgc7iHwIaG+IbBqR8qiFDs=;
        b=YKT3r6OKcYySlAb0ZwnSopGunT/yukLj0EvHIXs41ccQKscNn16eU/lgG57sr62BjP
         Oq2e4mjMrvC++lBWafpoBTKWTr0l6D01Hvw6vFKj/Dzm2Mwz2FQISwjXz0Fwf2ZI1FlI
         NsAiXNtlH1AVat7R/wamaGuxMZKG2stS5IZHaGv8Z6FTVIzcaXQVgmx7jFiYGDSh3hD1
         AZyal/RxYgc4hNXzgaSTEswdpAMcqgihoauBZu8Mn67Djl1fyEpyZifsLAI7k0y9UOq8
         k51M6ErC3q4MFzi3cMPcQflBkxXRj6gfI4asvtUnnFmhNXGCXAWkbC2HdeK5Y4hRqsjQ
         ZG/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=enMA1Z9xSWE56IA1Msn96Fgc7iHwIaG+IbBqR8qiFDs=;
        b=ZsqsEXXrNcetve8Cqww/eczxEWZIWUdqGqzuXzgFcfF2C2zI0PjkGxFIrntzxq3q+G
         rW4+eS/uqxxuoFiBi8EfzjUBmKgA/xYpynnlYGs64EFvI5EmXZD51/xk1RAREo71kgKt
         K4pAcqmyZpL1qCOfSL89ZNhoIAw63VLJdwL0tGPyEpcRjP2KqhNNsHNRPZnY2V2ldDAH
         4pWp3F6s74sZnVZkFF+g6DrVOBqcyHt3H0LB2kc2gdKssOueruKbFjVJznD7TS+fJazt
         wR4t38xHizZG1lFNjhc3BI7bLdcywhkyoKF/LcEFEuvKjTacIkEZ4+e778PQqXYCw8Ub
         TKFw==
X-Gm-Message-State: ANoB5pmH9zNvBFOsA4ajWWFd4d/zKhnx4E6eiQ4ywsl0HedR9AxTa/DO
        osMmhupKyJqyJg8y4XmjtxrqLtukRaVbmKo3vtch
X-Google-Smtp-Source: AA0mqf5fQB21yTZuDqwSqshD8yCuF69YBPSskCirnyK33Xp7YubnaQKvL+GChWZ/NsSj/cssXkrnQD61czEc59JFY9mj
X-Received: from twelve4.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:437a])
 (user=jonathantanmy job=sendgmr) by 2002:a17:90a:43a4:b0:219:1d0a:34a6 with
 SMTP id r33-20020a17090a43a400b002191d0a34a6mr5823518pjg.1.1670610418410;
 Fri, 09 Dec 2022 10:26:58 -0800 (PST)
Date:   Fri,  9 Dec 2022 10:26:56 -0800
In-Reply-To: <Y5KV0vIkxyA95/xf@coredump.intra.peff.net>
Mime-Version: 1.0
X-Mailer: git-send-email 2.39.0.rc1.256.g54fd8350bd-goog
Message-ID: <20221209182656.108137-1-jonathantanmy@google.com>
Subject: Re: [PATCH v3 3/4] object-file: emit corruption errors when detected
From:   Jonathan Tan <jonathantanmy@google.com>
To:     Jeff King <peff@peff.net>
Cc:     Jonathan Tan <jonathantanmy@google.com>, git@vger.kernel.org,
        avarab@gmail.com, gitster@pobox.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:
> I think this version still has the small issue that we'll _only_ surface
> a generic error return in such a case, and never report EMFILE
> specifically. I.e., I think we'd still want something like this on top:

[snip]

OK, I'll do this. This also has the advantage of not using
map_loose_object_1, so I'll be able to inline it in the previous patch.
