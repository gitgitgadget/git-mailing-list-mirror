Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 539301F404
	for <e@80x24.org>; Tue,  3 Apr 2018 18:49:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752547AbeDCSt3 (ORCPT <rfc822;e@80x24.org>);
        Tue, 3 Apr 2018 14:49:29 -0400
Received: from mail-yb0-f171.google.com ([209.85.213.171]:35211 "EHLO
        mail-yb0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752117AbeDCSt2 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 3 Apr 2018 14:49:28 -0400
Received: by mail-yb0-f171.google.com with SMTP id c1-v6so4155214ybm.2
        for <git@vger.kernel.org>; Tue, 03 Apr 2018 11:49:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=MBHSADtyCOuoaPAOHOvBwS6NW5qM+DTMVuhTr2zRWbc=;
        b=txVKXyYYakjYT4LxPlv8hPRoekbel84U1BEJtmR6pudRegrMFergLwz3SNJQBixa15
         phIHVHfQbrC7f1f+OSSI3U7ejDBgIB7tZ9heLMWeQpOieunSm+nFYztsBpaM4L+nxzmo
         SmizvWkoZ8mAe6esa5uFdso2n+fHX3ODntNOhRkIiPbbLweL5oQq9vqP+O2eK4eVd5U/
         lyrqWqWhhh0Uxwk2uEszUiOs3ZPSCrXklFetQ6lGrO90GAmzJ3tEzFtkftaQ1tLhzjzO
         P4qAa6U0VcunW1L8ze55iBAM2FszlDC5ZmaLr4AYyjQOVxt+KSUU1eV8zZobR87GQNRN
         XxvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=MBHSADtyCOuoaPAOHOvBwS6NW5qM+DTMVuhTr2zRWbc=;
        b=ZmcvlBEruh5iD9MbnPt2NypNT4hVSzxP0HIP8e5PtP2pgJTT7eakm3S5bbPMu5cJXj
         pVfqN/V0SSDJBdoYpFvGXmwSe7h3Kp79T6WG/aaVU7zEd/FqlxaN6Nq5KGLuC3MJqZ1a
         h9wvnS+w1iGdwfN4F877LKIDMNcKalrqlkSjAfAsZZ/QT8zqdy+b4GALRHh0MYnOHje9
         Mh7+ZYmHTQyWJXF+uaEsA66bsQlG/+7H6/Er01bEVK0c03feLG8scy4WCdPIQiNZfyFb
         9wcPTqRtmZSsKkXs3BFQUleKcrfs4Z97pJBtR4ixebGxFS2uQOgNg7EiTSqp/ulLfcdM
         SGdA==
X-Gm-Message-State: ALQs6tCC2BEABGD2yPIWfXBqSJ9dnLZviepiykrdnAZvDcKF0bYTZ9AE
        RoL4hV9LHJNzYgw35i0eTRmuBPOzIdEzSnNeEMu1uw==
X-Google-Smtp-Source: AIpwx48FjA/1UXe+GaB6nMAa4dwWbxnCjhf4uhshVvfr140gCk1P9LOhInbZB2KEV7vZXVjEvUU8glA1MQBmgZikoGk=
X-Received: by 10.129.232.5 with SMTP id a5mr317293ywm.421.1522781367692; Tue,
 03 Apr 2018 11:49:27 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a25:cf81:0:0:0:0:0 with HTTP; Tue, 3 Apr 2018 11:49:27 -0700 (PDT)
In-Reply-To: <20180403113010.170ef6a14b0c126f99651bc4@google.com>
References: <20180403165143.80661-1-dstolee@microsoft.com> <20180403165143.80661-4-dstolee@microsoft.com>
 <20180403113010.170ef6a14b0c126f99651bc4@google.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Tue, 3 Apr 2018 11:49:27 -0700
Message-ID: <CAGZ79kY1z5gYph3S4uiLZddjSmwPMAxyTCEWGaUsOZLbAu01xw@mail.gmail.com>
Subject: Re: [PATCH 3/6] commit-graph: compute generation numbers
To:     Jonathan Tan <jonathantanmy@google.com>
Cc:     Derrick Stolee <dstolee@microsoft.com>, git <git@vger.kernel.org>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Lars Schneider <larsxschneider@gmail.com>,
        Jeff King <peff@peff.net>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Apr 3, 2018 at 11:30 AM, Jonathan Tan <jonathantanmy@google.com> wrote:
> On Tue,  3 Apr 2018 12:51:40 -0400
> Derrick Stolee <dstolee@microsoft.com> wrote:
>
>> +             if ((*list)->generation != GENERATION_NUMBER_UNDEF) {
>> +                     if ((*list)->generation > GENERATION_NUMBER_MAX)
>> +                             die("generation number %u is too large to store in commit-graph",
>> +                                 (*list)->generation);
>> +                     packedDate[0] |= htonl((*list)->generation << 2);
>> +             }
>
> The die() should have "BUG:" if you agree with my comment below.

I would remove the BUG/die() altogether and keep going.
(But do not write it out, i.e. warn and skip the next line)

A degraded commit graph with partial generation numbers is better
than Git refusing to write any part of the commit graph (which later on
will be part of many maintenance operations I would think, leading to
more immediate headache rather than "working but slightly slower")

>
>> +static void compute_generation_numbers(struct commit** commits,
>> +                                    int nr_commits)
>
> Style: space before **, not after.
>
>> +                     if (all_parents_computed) {
>> +                             current->generation = max_generation + 1;
>> +                             pop_commit(&list);
>> +                     }
>
> I think the current->generation should be clamped to _MAX here. If we do, then
> the die() I mentioned in my first comment will have "BUG:", since we are never
> meant to write any number larger than _MAX in ->generation.

When we clamp here, we'd have to treat the _MAX specially
in all our use cases or we'd encounter funny bugs due to miss ordered
commits later?
