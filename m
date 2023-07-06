Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F88FEB64D9
	for <git@archiver.kernel.org>; Thu,  6 Jul 2023 22:48:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231576AbjGFWsX (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 6 Jul 2023 18:48:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55930 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229650AbjGFWsW (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 6 Jul 2023 18:48:22 -0400
Received: from mail-pf1-x44a.google.com (mail-pf1-x44a.google.com [IPv6:2607:f8b0:4864:20::44a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5610DFF
        for <git@vger.kernel.org>; Thu,  6 Jul 2023 15:48:21 -0700 (PDT)
Received: by mail-pf1-x44a.google.com with SMTP id d2e1a72fcca58-666e87eff0eso1958037b3a.3
        for <git@vger.kernel.org>; Thu, 06 Jul 2023 15:48:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1688683701; x=1691275701;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=ty8ley0CDMJbBZOM+lwKycn9rm88RYfRKIa3AzPoHf8=;
        b=fLBbBn1HNe7mQZ5sYH7uBNrrioCJVOoY3AlL6DkxHj0Zk4Ms1CuIz0VEBc58yfq1vG
         b6PrbeckJyByOiaTZvs6d2cZVRcFyg92pSQLyS8CZXWk1YcpybPtt5uh1L+Yxgc/xPjH
         4+1/Wy+gvLJPzsbfuZo9bf9Hlv+EQb/uF73zR8lNJYI7IyIkPeQ03NGbGejTe/4r2Vgu
         yq605bl669PbZlb18wVxQaGfTMlkr2NEw5DuzXeEqHtcp2HTtMkpVQm9nIWvdy10L85C
         NQa7M/qClMTNU70Ct7PJFIFSr6AFJ7OXOLYqqjW8rz9UbyM9rY5leItORxx/G2HvwHVh
         IrwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688683701; x=1691275701;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ty8ley0CDMJbBZOM+lwKycn9rm88RYfRKIa3AzPoHf8=;
        b=i2FmlAfq0mz/INmLWW/ynK3V4HRvaIsZp2nAMcNUDiZPHolw9pfH+tq4accDKddZeP
         kTQ6dvdQdWTkvQxFRW5eGd5/AM6A+Q9y81x99s6hBx/phVV+kPuvz/FCGJMOugxb4AIY
         PA8JQazs2gg8zWJHYRG3VvbBbss6dw2vyMm1AxGRFIJIMOLWHCGjTMHNYPRouHcOQ10z
         lmwZNdIAnPIQ4J4zH8CkZCTgQR49unEsKc1KE8kTwLqL0IEFfW090T5rGn8qv7wTd81t
         RaWS6o/+aq6HqW6AQDbjZk8BTeDm/PZ7ksEQu2WxGZJ67t+V/XgJi+SXtx5lrBHtujzf
         U3Og==
X-Gm-Message-State: ABy/qLauMxvDYFHO8CzBZKt+1axUv5YzGHblx49JKIT8IpkJg4YI4Vk+
        NzDAuynugDywRJE1q/e5t5S6l5bthJh79A==
X-Google-Smtp-Source: APBJJlFd8ztIBRXmSiq9Yg2ZmgOLrMM5QyoOMkJ8RoA09IBSjf8pmTpGZx8o2UM+8HrL0TquNIQGUXyEu4tmZg==
X-Received: from chooglen.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:3a07])
 (user=chooglen job=sendgmr) by 2002:a05:6a00:b51:b0:66e:4df5:6c15 with SMTP
 id p17-20020a056a000b5100b0066e4df56c15mr4476166pfo.4.1688683700792; Thu, 06
 Jul 2023 15:48:20 -0700 (PDT)
Date:   Thu, 06 Jul 2023 15:48:11 -0700
In-Reply-To: <xmqqzg48dfsq.fsf@gitster.g>
Mime-Version: 1.0
References: <20230517-unit-tests-v2-v2-0-21b5b60f4b32@google.com>
 <8afdb215d7e10ca16a2ce8226b4127b3d8a2d971.1686352386.git.steadmon@google.com>
 <owlybkgy837j.fsf@fine.c.googlers.com> <ZJ3uGBEEvYmbPnoQ@google.com>
 <owlywmzk7nnb.fsf@fine.c.googlers.com> <kl6l1qhkrj83.fsf@chooglen-macbookpro.roam.corp.google.com>
 <xmqqzg48dfsq.fsf@gitster.g>
Message-ID: <kl6ly1jspsgk.fsf@chooglen-macbookpro.roam.corp.google.com>
Subject: Re: [RFC PATCH v3 1/1] unit tests: Add a project plan document
From:   Glen Choo <chooglen@google.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Linus Arver <linusa@google.com>,
        Josh Steadmon <steadmon@google.com>, git@vger.kernel.org,
        calvinwan@gmail.com, szeder.dev@gmail.com,
        phillip.wood123@gmail.com, avarab@gmail.com,
        sandals@crustytoothpaste.net
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

> Glen Choo <chooglen@google.com> writes:
>
>> - Inline tests are, by nature, non-production 'noise' in the source
>>   file, and can hamper readability of the file. This will probably be
>>   exaggerated in Git because our interfaces weren't designed with unit
>>   tests in mind, so tests may be extremley noisy to set up.
>
> I do agree with the first sentence, but I am not sure what you mean
> by "our interfaces weren't designed with unit tests in mind".

[...]

> Do
> you mean that in the longer term it would be good to tweak the
> interfaces with "unit tests in mind" (and add new interfaces that
> way?

Ah. I agree, but this isn't what I meant.

> Or do you mean interfaces that are written with "unit tests
> in mind" inherently becomes noisy when inline non-production tests
> are mixed in?

I meant the opposite of this actually. Interfaces with "unit tests" in
mind result in simpler tests, so they will be less complicated to setup
and thus be less noisy. Testing the existing, pre-unit test interfaces
will be very noisy, so I don't think they will lend themselves well to
inline tests.

But of course, (per the prior point) we are trying to make the
interfaces cleaner, which should naturally make them more unit
test-friendly, so this will become less important over time. I think the
other objection - that we want unit tests to enforce cleanliness of our
build dependencies - is the more important one.
