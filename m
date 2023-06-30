Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5BCBEB64D9
	for <git@archiver.kernel.org>; Fri, 30 Jun 2023 00:11:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232103AbjF3ALq (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 29 Jun 2023 20:11:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48746 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231953AbjF3ALo (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 29 Jun 2023 20:11:44 -0400
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4AB4D2D52
        for <git@vger.kernel.org>; Thu, 29 Jun 2023 17:11:43 -0700 (PDT)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-57059e6f9c7so19352057b3.0
        for <git@vger.kernel.org>; Thu, 29 Jun 2023 17:11:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1688083902; x=1690675902;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=mDqYblaVVkRCwhgOKiWYX1KeC9xEQJkrFGtjmIuqN/U=;
        b=sDNhLmXNWMCc8sXywR6tn/iILBDIC7x0WezLco3T0iOFw0Ra5G3Ks/o+CoHObbXQeT
         NQ1FVt0aQa5yrRWtwbxXlfFIZjolAY9AuWoKP9R+dzSBiOTg6bc9k9q4dnPiOyIcYPHr
         JzAF3C+IH3k20TemEchDZznSR4NhvcSi7eKgjwJUJYY8eY8YDwjc+AITVf47yPJLAZ9d
         ODbFKgpa2NTFRAFhnRZGbhSEPWS5+neNgMH5FbcGn2Gh7GFr5OrcG55L+8q0Vq8wnBgN
         ZtrmupgFuQKa0NIZlHqS2G7eGxzp4HnrPJfSnKChMTGZflNMbD/FJmFMFI9s7TYyREdR
         XduA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688083902; x=1690675902;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=mDqYblaVVkRCwhgOKiWYX1KeC9xEQJkrFGtjmIuqN/U=;
        b=MeHRJt5xfCo/3nuoxxxkx+Tok/z6CNhROcPC4OETXTkaLVRWnBqBWdSE5x5SMwtsIn
         f1GZdbE7zaBp67LdsQ7UWJ7ZYtv7xFK5xqvT3IRSCfSM97SYo7k1YhiLV97hQPKKaieE
         17c5mSaFKX/ErTvPilpVX66ZLjPo5TQuuPPeokOoS9QRos3h7eoGGFEoHKjzqoTWfxKX
         I/SjlO5DIEnt0Y826qkJn+yGisjmYNXuzHJbAQDdMCH2sfVvb1AaSkiv5eTd01Wm1iDm
         MmTq/r01sg3ot1IEfnKbcjeYo3vVlAoqrqP+2fSVRf21ujNKt4OUxflWKehl3fj9I1RQ
         8S9Q==
X-Gm-Message-State: ABy/qLaoAMDoclK54x3Gdqb/ieULRwdDmBxhfgFOLAbSNUBou+/Mj/3g
        eVvfdAsTZOOHjtizVSMmieVST6HLZ9o=
X-Google-Smtp-Source: APBJJlEDB0t5SWQ1bTkBOF1Wacq/77vQgXxStgG9RicpNasBMmQ/1qpjBEIT6B3xLiPpLRv/6CXM2KjLmcg=
X-Received: from fine.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:2221])
 (user=linusa job=sendgmr) by 2002:a05:690c:d81:b0:577:1689:d784 with SMTP id
 da1-20020a05690c0d8100b005771689d784mr83334ywb.4.1688083902577; Thu, 29 Jun
 2023 17:11:42 -0700 (PDT)
Date:   Thu, 29 Jun 2023 17:11:40 -0700
In-Reply-To: <xmqqedlu7yn2.fsf@gitster.g>
Mime-Version: 1.0
References: <20230517-unit-tests-v2-v2-0-21b5b60f4b32@google.com>
 <8afdb215d7e10ca16a2ce8226b4127b3d8a2d971.1686352386.git.steadmon@google.com>
 <owlybkgy837j.fsf@fine.c.googlers.com> <xmqqedlu7yn2.fsf@gitster.g>
Message-ID: <owly7crl95c3.fsf@fine.c.googlers.com>
Subject: Re: [RFC PATCH v3 1/1] unit tests: Add a project plan document
From:   Linus Arver <linusa@google.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Josh Steadmon <steadmon@google.com>, git@vger.kernel.org,
        calvinwan@gmail.com, szeder.dev@gmail.com,
        phillip.wood123@gmail.com, chooglen@google.com, avarab@gmail.com,
        sandals@crustytoothpaste.net
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

>> I can think of some other metrics to add to the comparison, namely:
>>
>>     1. Age (how old is the framework)
>>     2. Size in KLOC (thousands of lines of code)
>>     3. Adoption rate (which notable C projects already use this framework?)
>>     4. Project health (how active are its developers?)
>>
>> I think for 3 and 4, we could probably mine some data out of GitHub
>> itself.
>
> Great additions (if we are mere users do we care much about #2,
> though?).

Sorry, I forgot to add why I think these metrics are useful: I think
they give some signal about how much influence/respect the framework has
in our industry, with the assumption that the influence/respect
positively correlates with how "good" (sound architecture, well-written,
easy to use, simple to understand, etc) the framework is. For the
frameworks hosted in GitHub, perhaps the number of GitHub Stars is a
better estimate for measuring influence/respect.

That said, I think #2 (measuring KLOC) would still be useful to know
(and is easy enough with tools like tokei [1]), mainly for the scenario
where the framework becomes abandonware. Certainly, a framework with a
lower KLOC count would have a lower maintenance burden if we ever need
to step in to help maintain the framework ourselves. To me this is one
reason why I like the idea of using Phillip Wood's framework [2]
(granted, it is currently only a proof of concept).

[1] https://github.com/XAMPPRocky/tokei
[2] https://lore.kernel.org/git/c902a166-98ce-afba-93f2-ea6027557176@gmail.com/
