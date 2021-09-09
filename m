Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.3 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E515C433EF
	for <git@archiver.kernel.org>; Thu,  9 Sep 2021 17:48:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DF95A6101A
	for <git@archiver.kernel.org>; Thu,  9 Sep 2021 17:48:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237287AbhIIRtO (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 9 Sep 2021 13:49:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34244 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237196AbhIIRtO (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 9 Sep 2021 13:49:14 -0400
Received: from mail-qk1-x749.google.com (mail-qk1-x749.google.com [IPv6:2607:f8b0:4864:20::749])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71264C061574
        for <git@vger.kernel.org>; Thu,  9 Sep 2021 10:48:04 -0700 (PDT)
Received: by mail-qk1-x749.google.com with SMTP id t18-20020a05620a0b1200b003f8729fdd04so5499971qkg.5
        for <git@vger.kernel.org>; Thu, 09 Sep 2021 10:48:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=REVKoPKTIAKdPsjX1WMNEBaRXAzpxaADdW06ERvvqr8=;
        b=VwPW9SbBt2eSA2ExXZoQTpA3tqHy8psveUykV2CDmHOcwZYtY2RiKFTBXOwX9/PPG8
         /2IJvJoe+zqBTwp2rRV9MzIaXrkYEGTK85dksfrbMyHCuMEGFD+SMHo8YVQUqZDfO2Yn
         4aLqLsrpW1n+eNmvBPOw/5MwuYZHrQR/HwnLSHgN4X4CFZ76imfsNVO2HXRlZxcZU8RQ
         dY+bD72CFpdtaZav54BYugokkTINwA+xHuv+1r9ndJphwZ0wF3I8YKDl9FaXrW8Uzbk+
         vDOaeypZ2UVLgQD0VrpQYxpabxJRO04ANgku7mw0PgR27Mt2BQdq1JZdr1TPvxPz/Mw4
         JVgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=REVKoPKTIAKdPsjX1WMNEBaRXAzpxaADdW06ERvvqr8=;
        b=grfpA46wD8hLNCzmWEonNlcDwkkKX7UNUXFTnV4DGfwGy6n0U7M+VVLX78JpY5JA+u
         4kEm+RPqhhwtS3wc5yuipYPLHj+6wdmqiws4A1jWhbgo5/4gc5KpwoIepAjWBFY3YsWa
         p7nc4POd6wMhtocBiy5L21kq7JHGHhndz0schIEYjQBzuLX5pKp1I2X0gHjBdHQJnjQg
         M5drIYKPaIZtC5HMtxIiZ91/vScUDG5emzhFo63+Uu5HR1ZfzQdA5EcYjWso6+Cj5ucO
         9LmT3JORYMeU/rXG7l/fCKti6KGa+vUQOl2jCKsG6HCPsuZ3exZyMUIS91x2zbbk14AZ
         9nRg==
X-Gm-Message-State: AOAM533CpM4IMQesjN5eCPdYRu//GSXAXCKoBUgpdgAQngMpV+kIfZGv
        DWIYtltoBGeJzA4Z/OlNc8pqWjLDCCGmxQ04owGM
X-Google-Smtp-Source: ABdhPJwiEhdrDBtss9ZgE4W4LyKWD/fE7QFONnkcyGCELC132sPuL1CHIheEpgykiPxNiEL9te5qsy2YkaHW9Fk56oDY
X-Received: from twelve4.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:437a])
 (user=jonathantanmy job=sendgmr) by 2002:a05:6214:20eb:: with SMTP id
 11mr4298209qvk.52.1631209683597; Thu, 09 Sep 2021 10:48:03 -0700 (PDT)
Date:   Thu,  9 Sep 2021 10:47:58 -0700
In-Reply-To: <xmqqwnnq1zh9.fsf@gitster.g>
Message-Id: <20210909174758.2550040-1-jonathantanmy@google.com>
Mime-Version: 1.0
References: <xmqqwnnq1zh9.fsf@gitster.g>
X-Mailer: git-send-email 2.33.0.309.g3052b89438-goog
Subject: Re: [PATCH 1/3] t6437: run absorbgitdirs on repos
From:   Jonathan Tan <jonathantanmy@google.com>
To:     gitster@pobox.com
Cc:     jonathantanmy@google.com, git@vger.kernel.org, newren@gmail.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

> Quite honestly, if repo_submodule_init() can only work with the
> "absorbed" form, isn't it simply a bug?
> 
> Two independent (i.e. we can do either or both) things may improve
> the situation:
> 
>  - allow repo_submodule_init() to work on both forms (in place---no
>    cheating by calling "absorb" behind user's back).
> 
>  - teach "git submodule add" to transition an old-style submodule
>    into the "absorbed" form (either with an option, or do so by
>    default with an escape hatch to disable).
> 
> The latter indirectly attacks the "repo_submodule_init() can only
> work with absorbed form" issue by making it harder to create a
> non-absorbed submodule to begin with.

Thanks for taking a look.

I took a further look and it doesn't look too difficult to teach
repo_submodule_init() to work on both forms (without calling
"absorbgitdirs") - I'll send an updated patch set soon. As for "git
submodule add" transitioning it into the absorbed form, I'll leave that
for someone else to do - although if repo_submodule_init() supports the
unabsorbed form now, that is not so urgent to do, I think.
