Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F655C54E94
	for <git@archiver.kernel.org>; Thu, 26 Jan 2023 08:45:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233471AbjAZIpX (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 26 Jan 2023 03:45:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36178 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229677AbjAZIpV (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 26 Jan 2023 03:45:21 -0500
Received: from mail-pj1-x104a.google.com (mail-pj1-x104a.google.com [IPv6:2607:f8b0:4864:20::104a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C804CA273
        for <git@vger.kernel.org>; Thu, 26 Jan 2023 00:45:20 -0800 (PST)
Received: by mail-pj1-x104a.google.com with SMTP id me17-20020a17090b17d100b0022901e51ab3so2392387pjb.2
        for <git@vger.kernel.org>; Thu, 26 Jan 2023 00:45:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=MQ0fH64BE4Sbi7jdCWZHsiakyrlyxN+pxWAwEfSPMZw=;
        b=EpoxzG6TbfejPYWBY2R8y9blCzxAG5WkUGfUcZtPWCqQSsqSsSE+2WR8b4AHeQPpfZ
         Y+RXMiwa2Uj4Z1/KJBUeJ6QpKqUN4eDimv0Ki0pFMDxo9KC54CIzR1qneIba7cn86J6I
         qLrLUWp1GlIRZmQRVobYcROUNdqfhlowAm8vq6Vey3LdtZH5jQSb/tmTKVPlQYfZaEtJ
         W3QXwOyXJnpb46xWri84RXSdPLHRrqau/FS94YEftq3j256hZ1ZGVJBoOtO+HF9lz5gC
         W+ex8h/4p4ObXmtlKNMLi9+EDVzhuuXQ3Wkee35OFqXARw7/6b9okUkcfYguxxGc97Y3
         teAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=MQ0fH64BE4Sbi7jdCWZHsiakyrlyxN+pxWAwEfSPMZw=;
        b=5mfuOmr7/WTAOXoX02Qjw4Sa+2OXTBssPNW/v4dbCBgfkTfPFSJCnEzcEYNIHL+iTN
         8yfBewyKWWdlMCyO9RS0n9MoKgP2GPKq/FtuULJNHJG5hLocaeQJe48DWDSjnKt5PlfJ
         GYrGCgRsOo3YxYH1GTRLTqDcSWezDCr21PIh9Q01pUy7ciSVtXJKvZBgVdQRbo1Nimsr
         Tbz5xh2ELwSFdmOHIUehZrew0/m27XRD7j156kiF0l1II7DrT4ro8MehKG47VR4pNjax
         xTLlOWbc/EARVZ3HMPPCA+HaJVZm56dDvOM1BliA0i1HHbFjugop7Di86xSc3OGdDpcb
         zEEw==
X-Gm-Message-State: AFqh2kpT8vClEom5bB6xqOGTZN2qRYpuehukj0HaBW6qhr6wdCfY/b6I
        kK40I2wLXR4r9aUGPoHqc0PQono/1ZKxVg==
X-Google-Smtp-Source: AMrXdXsSDYd7weSYcWaOYgLrPC0PfUKtDZcgpixf26ggSm5BygBnMwdpZSik0kee0R3LCZ4CyV+GTQyTXuPQMg==
X-Received: from chooglen.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:26d9])
 (user=chooglen job=sendgmr) by 2002:a17:90b:3647:b0:228:ccad:2089 with SMTP
 id nh7-20020a17090b364700b00228ccad2089mr3772609pjb.19.1674722720168; Thu, 26
 Jan 2023 00:45:20 -0800 (PST)
Date:   Thu, 26 Jan 2023 16:45:18 +0800
In-Reply-To: <kl6lv8ktvhrp.fsf@chooglen-macbookpro.roam.corp.google.com>
Mime-Version: 1.0
References: <20230104215415.1083526-1-calvinwan@google.com>
 <20230117193041.708692-7-calvinwan@google.com> <kl6lv8ktvhrp.fsf@chooglen-macbookpro.roam.corp.google.com>
Message-ID: <kl6lo7qlvg4h.fsf@chooglen-macbookpro.roam.corp.google.com>
Subject: Re: [PATCH v6 6/6] submodule: call parallel code from serial status
From:   Glen Choo <chooglen@google.com>
To:     Calvin Wan <calvinwan@google.com>, git@vger.kernel.org
Cc:     Calvin Wan <calvinwan@google.com>, emilyshaffer@google.com,
        avarab@gmail.com, phillip.wood123@gmail.com, newren@gmail.com,
        jonathantanmy@google.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Glen Choo <chooglen@google.com> writes:

> Calvin Wan <calvinwan@google.com> writes:
>
>> Remove the serial implementation of status inside of
>> is_submodule_modified since the parallel implementation of status with
>> one job accomplishes the same task.
>
> I see that this is in direct response to Jonathan's earlier comment [1]
> that we should have only one implementation. Thanks, this is helpful.
> Definitely a step in the right direction.
>
> That said, I don't think this patch's position in the series makes
> sense. I would have expected a patch like this to come before 5/6. I.e.
> this series duplicates code in 5/6 and deletes it in 6/6 so that we only
> have one implementation for both serial and parallel submodule status.
>
> Instead, I would have expected we would refactor out the serial
> implementation, then use the refactored code for the parallel
> implementation. Not having duplicated code in 5/6 would shrink the line
> count a lot and make it easier to review.
>
> [1] https://lore.kernel.org/git/20221128210125.2751300-1-jonathantanmy@google.com/

Ah, I realize I completely misunderstood this patch. I thought that this
was deleting code that was duplicated between the serial and parallel
implementations in 5/6 such that both ended up sharing just one copy of
the code.

Instead, this patch deletes the serial implementation altogether and
replaces it with the parallel one. As such, this patch can't come
earlier than 5/6, because we need the parallel implementation to exist
before we can use it.

For reviewability of 5/6, I'd still strongly prefer that we refactor out
functions (I'll leave more specific comments on that patch). We could
still consider replacing the serial implementation with "parallel with a
single job", though I suspect that it will be unnecessary if we do the
refactoring well. I'm also not sure how idiomatic it is to call
run_processes_parallel() with a hardcoded value of 1, but I don't feel
too strongly about that.
