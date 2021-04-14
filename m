Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.3 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DFDC8C433ED
	for <git@archiver.kernel.org>; Wed, 14 Apr 2021 17:14:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AF13561179
	for <git@archiver.kernel.org>; Wed, 14 Apr 2021 17:14:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348498AbhDNROv (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 14 Apr 2021 13:14:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42372 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234007AbhDNROu (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 14 Apr 2021 13:14:50 -0400
Received: from mail-pg1-x54a.google.com (mail-pg1-x54a.google.com [IPv6:2607:f8b0:4864:20::54a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F2654C061574
        for <git@vger.kernel.org>; Wed, 14 Apr 2021 10:14:28 -0700 (PDT)
Received: by mail-pg1-x54a.google.com with SMTP id b17so1053506pgh.17
        for <git@vger.kernel.org>; Wed, 14 Apr 2021 10:14:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=9hCdnvYd1SQIOAlqdR96aAUBeh8ThLFwCp+qTJHjku4=;
        b=B7M1AG84dexNARkzW+524O9lJwZs9P0bsYv727Nse3UCOlEdjhs+cPbxLiUn5mAwfR
         vQD6WYQgrrEdXZkIKeaoIP+tArSx9cQI5uMAToNetfWLUX4miARrSQ86DJvllz0U0jm2
         P61V4IdleC18+bWzRzbjuU7lJLmTWdkYInWm7PZmdrWwPgLE5cCHkmnL+M4lc1xWdtcT
         9kcYuFszQVLnN1lwc7Wv7mrANFNAN4/dkieo1ePLialc0Qj4Fcbs5ht7oVCoccwIAKgZ
         c/F/0grLgzVst/UwU0Ba7cFVTensBwzx0vHS/rJ+PJ060NFiLORFzB6lDwJkZXfvXMGI
         SmfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=9hCdnvYd1SQIOAlqdR96aAUBeh8ThLFwCp+qTJHjku4=;
        b=mr85ijTrJoMxZjADoOy3xCv7hN+7DT8Sss6wxnMNl6mVHEPONyQHfqti1WZcLPiPQ2
         TOjY5zp9YLJoThgrV8L0duniJROrwsdYTBBgO+XvO1umUc4y6sQphrj28o7ual41fd3K
         Ll8wwIFcJSGmg/J945ql2pVNrTjW02dKCOfE8hLF56Vwd7VhPMufSJzvzUUDOY8Kjyov
         b1WOUY0mQQ/M5Uy9aTM3hVJnn+6ldbKxlesF3vi3mxUF3ifN/ebVHlU0P7rnitdir5tQ
         HoRWUaaSv/DPwv4W4qWJyIX4zkOV0y+CdzTruqTv+Yddopby7w0gfoZy9QI4LTMvLhIr
         QBiQ==
X-Gm-Message-State: AOAM530Y9h6qd5/D5VceO2BzX6sTxv2ViPjnBTTYrMvErvfZDPPMphIb
        +pHRWWBJAEN8y5/wMNYd1WPaMnA0o44qugrLRDmf
X-Google-Smtp-Source: ABdhPJxnaETSzRrSTpBkvZ6nnH4WTW2OOrUkZ1SkUh+gp2E1337XIvPjeRheSz2fysp6A9Zo5DmItO7m8SZOzHdyHSAk
X-Received: from twelve4.c.googlers.com ([fda3:e722:ac3:10:24:72f4:c0a8:437a])
 (user=jonathantanmy job=sendgmr) by 2002:aa7:9ab7:0:b029:242:318e:6cba with
 SMTP id x23-20020aa79ab70000b0290242318e6cbamr35013402pfi.17.1618420468436;
 Wed, 14 Apr 2021 10:14:28 -0700 (PDT)
Date:   Wed, 14 Apr 2021 10:14:19 -0700
In-Reply-To: <YHVECXHfZ1bidTJH@coredump.intra.peff.net>
Message-Id: <20210414171419.3980561-1-jonathantanmy@google.com>
Mime-Version: 1.0
References: <YHVECXHfZ1bidTJH@coredump.intra.peff.net>
X-Mailer: git-send-email 2.31.1.295.g9ea45b61b8-goog
Subject: Re: [PATCH 0/3] low-hanging performance fruit with promisor packs
From:   Jonathan Tan <jonathantanmy@google.com>
To:     peff@peff.net
Cc:     szeder.dev@gmail.com, rafaeloliveira.cs@gmail.com,
        jonathantanmy@google.com, git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

> Here are some cleaned-up patches that I think improve the situation
> quite a bit. This is just the low-hanging fruit from this part of the
> discussion; I'm sure there's more to do to make using partial clones
> pleasant. In particular:

[snip]

Thanks, Peff. These patches look good to me.
