Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E820EB64D9
	for <git@archiver.kernel.org>; Wed, 28 Jun 2023 00:30:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230229AbjF1Aa1 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 27 Jun 2023 20:30:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33358 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229647AbjF1AaZ (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 27 Jun 2023 20:30:25 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C485026BF
        for <git@vger.kernel.org>; Tue, 27 Jun 2023 17:30:24 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id 3f1490d57ef6-c108dd0d9deso5906776276.3
        for <git@vger.kernel.org>; Tue, 27 Jun 2023 17:30:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1687912224; x=1690504224;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=3MLUa+NpgHzguuWJpU+ByGJnbNP3EfMpcjzouFythEM=;
        b=aa/MLHyb4o/Ka0WS4r/04yy5dOMN9C0M/+OcssCsmU8izcv/U6Q0KtoejvRy9Nqx3w
         LgVVyA9QUj8gf4sfxq7ZTa5kIPNYBYt29/hnxZ9Ct1h7vfWazqh4e5PXiubYxkls8yEq
         njkBD1NEiXC5b9BhYSHelEaM3P4RelvZ/ayzdTmnU0ns0O1zZITYccIS+lRBzfso9oIH
         3HZ3unTSlntbqF0T/6wgbowSyMWNg25w4dTTEaHNmf7zTjLbqv2nxlGwmgE8TAVlE3FS
         nAuddncrtmYqlJ6MxqRvZb8qfagNOMMrqBZsWsz40it6j46P/Gw28hN8CGD7sgNSzGr2
         NdBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687912224; x=1690504224;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=3MLUa+NpgHzguuWJpU+ByGJnbNP3EfMpcjzouFythEM=;
        b=JD9NVCMij01Hsb982WqThLxnd7TXe8SCKTI1y4PcMGoVJxfq/F12P7yNLiwkg7i4HJ
         7Z9ayYIr20MWdyH9zPoQ6h+wiHM9qE9we2AZwmXKxiWXJ8i+2UelW/Ziu1VNHwEhWDCw
         FERcsdLCoJBCy8FYD7ZvXrdQpg0PWz4WVMx1ESVECpnZUgfBYKm7CFZOSaMtWL5rsWgK
         uovWQ3Z1B9R4PwwE/yl/lID4VcByhI5khM2FpToRStBlnJBuFfPngrY1LoYEwdeDeKYt
         k3TkPXuHJgejMLi3MBAUO7nicfjfJ43tzuen4yxvq42NDLbsFeTD7t5FrZzMzJMG3qdZ
         gIwg==
X-Gm-Message-State: AC+VfDyynDObIj5wcGgq5TTGc1HuzEr/9SRpyrWxOm5qtrv9pFZcrr4F
        fZnG/G1WOFAQ7mRwZTJ6SvKmar5797YnGw==
X-Google-Smtp-Source: ACHHUZ4DA6boZCNbq3hPvGB63y8NWGPNpkj3KJ69pGGbhbntzjI4ER9tGvB2BAhKmiQqrxY05zVgyEq9odNo9w==
X-Received: from chooglen.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:3a07])
 (user=chooglen job=sendgmr) by 2002:a05:6902:18c4:b0:c1c:e037:136c with SMTP
 id ck4-20020a05690218c400b00c1ce037136cmr5702136ybb.0.1687912224065; Tue, 27
 Jun 2023 17:30:24 -0700 (PDT)
Date:   Tue, 27 Jun 2023 17:30:22 -0700
In-Reply-To: <xmqq1qhwfr46.fsf@gitster.g>
Mime-Version: 1.0
References: <20230627195251.1973421-1-calvinwan@google.com>
 <20230627195251.1973421-7-calvinwan@google.com> <xmqq1qhwfr46.fsf@gitster.g>
Message-ID: <kl6lv8f8qvhd.fsf@chooglen-macbookpro.roam.corp.google.com>
Subject: Re: [RFC PATCH 6/8] pager: remove pager_in_use()
From:   Glen Choo <chooglen@google.com>
To:     Junio C Hamano <gitster@pobox.com>,
        Calvin Wan <calvinwan@google.com>
Cc:     git@vger.kernel.org, nasamuffin@google.com,
        johnathantanmy@google.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

>> pager_in_use() is simply a wrapper around
>> git_env_bool("GIT_PAGER_IN_USE", 0). Other places that call
>> git_env_bool() in this fashion also do not have a wrapper function
>> around it. By removing pager_in_use(), we can also get rid of the
>> pager.h dependency from a few files.
>
> With so many (read: more than 3) callsites, I am not sure if this is
> an improvement.  pager_in_use() cannot be misspelt without getting
> noticed by compilers, but git_env_bool("GIT_PAGOR_IN_USE", 0) will
> go silently unnoticed.  Is there no other way to lose the dependency
> you do not like?

Having the function isn't just nice for typo prevention - it's also a
reasonable boundary around the pager subsystem. We could imagine a
world where we wanted to track the pager status using a static
var instead of an env var (not that we'd even want that :P), and this
inlining makes that harder.

From the cover letter, it seems like we only need this to remove
"#include pager.h" from date.c, and that's only used in
parse_date_format(). Could we add a is_pager/pager_in_use to that
function and push the pager.h dependency upwards?
