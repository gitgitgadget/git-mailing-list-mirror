Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84A3CC433EF
	for <git@archiver.kernel.org>; Tue, 15 Feb 2022 21:18:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243026AbiBOVTG (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 15 Feb 2022 16:19:06 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:56054 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237030AbiBOVTF (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 15 Feb 2022 16:19:05 -0500
Received: from mail-pg1-x549.google.com (mail-pg1-x549.google.com [IPv6:2607:f8b0:4864:20::549])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F13829AE48
        for <git@vger.kernel.org>; Tue, 15 Feb 2022 13:18:54 -0800 (PST)
Received: by mail-pg1-x549.google.com with SMTP id 37-20020a630e65000000b0036c461afa9aso21436pgo.20
        for <git@vger.kernel.org>; Tue, 15 Feb 2022 13:18:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:subject:from:to:cc;
        bh=shhAtW3MEQzdTgzH7DMi6JAHbmNLjSvtPh+QpyrAmUw=;
        b=W7/cjJNReTnc6MQtlb6XhMqwsZ5A+KCXW8tm7JD1zbcvmIX6uo1l+DuimfVe3Ui7Ot
         UQ3OMHeJmBfrkIms745xutJeS/Mt22wPyj6fh5/VzlyG4KJRhPgP8ordWF2ytSVRNtsL
         fnhiwZ/5+Fo6RUcm0eSvGT6Hj5UXV6roLihbN0PDNLrDNgzz71fte+Sxxh6JRmnHo9VL
         PuoxIOXWg13cWMgx8jNZvtEu7Z4aWdtQES3OBgcApiQRcSb/wrBHS18kfMT/Qt+bHMuo
         7e8dkr/YXT5un69xPfgoO2mPySlVBQlMRGYhD2yf1FjUM7ajwfk1e5yUcUt9WwFpO+ru
         VIbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version:subject
         :from:to:cc;
        bh=shhAtW3MEQzdTgzH7DMi6JAHbmNLjSvtPh+QpyrAmUw=;
        b=XHmzH0QcU/sKIvBHXQqGonWO2EJP+fp/IOkpsCEu1uuwELtKwR+HObX9YRqt6/5GSt
         wZiC6KPbgAzz/2J5wJw74XlMJG7JCBBAOmL4OUM5FpdEwsL0GeWF2wrcZqJRf/pb3y1U
         TJoOnz6HBiL/2j/LgSsJLQroZQ+TFqvLb2nxOnhuwSI9mJdGEnrpsHgCrpUHKW1iF3pa
         4ZlT5C1AAyBIkTlSeenYUXKbfLcl+7LwYk8RXMzgti4t0A6n/SFSMCoYCJQKkJdxyMoD
         2aCRPZL+H1nNgN268BZFacp39uDAobWvxDygq4vXprlLJCwGLHpuSUv8ZZ+K2kQ3sN8A
         ghxA==
X-Gm-Message-State: AOAM532VktS8+9zzAQEG/EVsrNrPL/n0vm0Oo4HF5O3AX7nA9KGR63Fo
        0ePv1kDsiJ2bAjexaAb3oaAuDe5OEVnZQRqqEwBK
X-Google-Smtp-Source: ABdhPJzOw9yN/eefZV9umxGNPNxY3qv2wipPgBoUktLghPacleAW/R7qQPBTYlEx2YovDHPCihCviLPAvg0B8F5QZ/25
X-Received: from twelve4.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:437a])
 (user=jonathantanmy job=sendgmr) by 2002:a17:902:ce92:: with SMTP id
 f18mr768559plg.68.1644959934385; Tue, 15 Feb 2022 13:18:54 -0800 (PST)
Date:   Tue, 15 Feb 2022 13:18:47 -0800
In-Reply-To: <20220215172318.73533-4-chooglen@google.com>
Message-Id: <20220215211848.1620058-1-jonathantanmy@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.35.1.265.g69c8d7142f-goog
Subject: Re: [PATCH v2 3/9] submodule: make static functions read submodules
 from commits
From:   Jonathan Tan <jonathantanmy@google.com>
To:     Glen Choo <chooglen@google.com>
Cc:     Jonathan Tan <jonathantanmy@google.com>, git@vger.kernel.org,
        Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

First of all, patches 1 and 2 look good since they are the same as in
v1 and I have reviewed them. Moving on...

Glen Choo <chooglen@google.com> writes:
> The changed function signatures follow repo_submodule_init()'s argument
> order, i.e. "path" then "treeish_name". Where needed, reorder the
> arguments of functions that already take "path" and "treeish_name" to be
> consistent with this convention.

This paragraph made me nervous, but looking at the diff, you didn't
actually reorder any arguments. Probably best to delete this paragraph.

The fact that the additional functionality is not used also means that
we can't tell for sure if all relevant functions are indeed changed, but
perhaps we can determine this in a later patch.
