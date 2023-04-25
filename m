Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 568CEC6FD18
	for <git@archiver.kernel.org>; Tue, 25 Apr 2023 13:35:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234156AbjDYNfQ (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 25 Apr 2023 09:35:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33548 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233452AbjDYNfO (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 25 Apr 2023 09:35:14 -0400
Received: from mail-yw1-x112d.google.com (mail-yw1-x112d.google.com [IPv6:2607:f8b0:4864:20::112d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E9F09146D7
        for <git@vger.kernel.org>; Tue, 25 Apr 2023 06:34:43 -0700 (PDT)
Received: by mail-yw1-x112d.google.com with SMTP id 00721157ae682-54fb4c97d55so41377947b3.0
        for <git@vger.kernel.org>; Tue, 25 Apr 2023 06:34:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=github.com; s=google; t=1682429681; x=1685021681;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=DqpPOA3XimWJrrRMe0WfXKe2AzhockhB4Zj3npWaIAo=;
        b=gRTwCs5CwYvbHTkbeoU6YNl/kEanBGXZJ5GbQLzSbSQzYndhRW2bCVG8rAexlePK+1
         ja3rjSNee74YwrfI/zKB7+MbjM2E49+hhBI4uykw9wvZIZWAFJIsrymb70ssLj9pexQs
         TdJ1V4Mkcvo7UkLHM+FEu/UCvS5q7MX7JBkBDV1SRGRqiMr7rii4e+kyTUg10AhNb2XO
         t0LdshXUMHcgEB8cSZ4w2RfnhYn2Y8mRQ9K4PQn8+HXtIKq/B0/nlIXrdRiaMmMB7+Ee
         GzAhT4uPaAa0dskfsQWZ1OYu7DCaqwliCDuLlVoF4h8Ax2tcjKjXwnGR2D+CG5K3d4Th
         fAzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682429681; x=1685021681;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=DqpPOA3XimWJrrRMe0WfXKe2AzhockhB4Zj3npWaIAo=;
        b=HH8lQGVsKazBJhL8sIJFalOdU6MqpA+fQm1/LOxuvvEYZkPSc/24d1PFkYF3y5EX0Q
         astBI00lLQUF+CrwUY+XZLnRFh3HB0IstizAbH57cGReY2pn/YoQxcTHdaG2k4fyLuxL
         BH8cME3yehreboyt6gSeNZt+PYbRsz8WruptuyDNcpPP0zyZwPfHr1gzbjBqrOLj3tPH
         hDVkkthkU0r4fqzJVAByoVGWoyvASYNt46zy/UkJmOGzcCDaBZdd6ycO9mI2UgPBJOir
         Oj0EQLnsm488cTeL1wL2cAjeik4vjwR9pO7KpNjKK33gdzF/GhbLvHvaXknxiX+WF4DK
         0pXg==
X-Gm-Message-State: AAQBX9fEgFBpqLsY7Pnh35YujSEa5SEvMAlc9VUDjY7DE/uKDbjl+gTQ
        SbhYu8DtfK81ShM0VydU2xMNgXkAGDbQ3UlOoQ==
X-Google-Smtp-Source: AKy350ZxQu89Zd3umFDphO3MTwGrC0g5pUt7wXK6YizMKbC667XeV9Kll0vo8ozsqX5t8M+g5Y+8uQ==
X-Received: by 2002:a0d:c606:0:b0:54f:e33d:f1d1 with SMTP id i6-20020a0dc606000000b0054fe33df1d1mr10158619ywd.13.1682429680832;
        Tue, 25 Apr 2023 06:34:40 -0700 (PDT)
Received: from ?IPV6:2600:1700:e72:80a0:9117:8293:39bd:7100? ([2600:1700:e72:80a0:9117:8293:39bd:7100])
        by smtp.gmail.com with ESMTPSA id b124-20020a0dd982000000b0054f6f2d291dsm3591827ywe.34.2023.04.25.06.34.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 25 Apr 2023 06:34:40 -0700 (PDT)
Message-ID: <4ddb4030-0789-5ed4-448d-96f6afb48334@github.com>
Date:   Tue, 25 Apr 2023 09:34:38 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [External] Re: [PATCH v1] negotiator/default.c: avoid stack
 overflow
To:     Han Xin <hanxin.hx@bytedance.com>
Cc:     git@vger.kernel.org, xingxin.xx@bytedance.com,
        jonathantanmy@google.com, Junio C Hamano <gitster@pobox.com>
References: <20230424022318.80469-1-hanxin.hx@bytedance.com>
 <2bcaeba9-20bc-1ca8-849b-ac54342c71e3@github.com>
 <CAKgqsWUEnbmhLL3p9+_P4yH_=A+hz+bBPqmfb8FyRUeW-u7_gw@mail.gmail.com>
Content-Language: en-US
From:   Derrick Stolee <derrickstolee@github.com>
In-Reply-To: <CAKgqsWUEnbmhLL3p9+_P4yH_=A+hz+bBPqmfb8FyRUeW-u7_gw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 4/24/2023 11:02 PM, Han Xin wrote:
> On Mon, Apr 24, 2023 at 10:44 PM Derrick Stolee
> <derrickstolee@github.com> wrote:

>>> @@ -70,15 +76,17 @@ static void mark_common(struct negotiation_state *ns, struct commit *commit,
>>>                               ns->non_common_revs--;
>>>                       if (!o->parsed && !dont_parse)
>>>                               if (repo_parse_commit(the_repository, commit))
>>> -                                     return;
>>> +                                     continue;
>>>
>>> +                     ancestors_only = 0;
>>
>> This caught me off guard, but this flag essentially says "should
>> I mark the first commit as common or not?". It would probably be
>> clearer if this was done before the loop, and then was ignored
>> within the loop, setting the flag on each parent in this loop:
>>
>>>                       for (parents = commit->parents;
>>>                                       parents;
>>>                                       parents = parents->next)
>>> -                             mark_common(ns, parents->item, 0,
>>> -                                         dont_parse);
>>> +                             prio_queue_put(&queue, parents->item);
>>
> 
> I'll think about how to optimize this again.
> 
> ancestors_only is used multiple times in the original logic:
> 1.
>               if (!ancestors_only)
>                      o->flags |= COMMON;
> 2.
>              if (!(o->flags & SEEN))
>                      rev_list_push(ns, commit, SEEN);
>              else {
>                      struct commit_list *parents;
> 
>                      if (!ancestors_only && !(o->flags & POPPED))
>                              ns->non_common_revs--;

Good point. Thanks for checking.
 
> Should we use this ?
> 
>              if (!ancestors_only) {
>                     commit->object.flags |= COMMON;
> 
>                     if ((commit->object.flags & SEEN) &&
> !(commit->object.flags & POPPED))
>                              ns->non_common_revs--;
>              }

This seems correct, although your email seems to have done a strange
line wrap that I'm sure you'll fix in the actual patch.

> and
> 
>                    for (parents = commit->parents;
>                              parents;
>                              parents = parents->next) {
>                              if (parents->item->object.flags & COMMON)
>                                       continue;
> 
>                             parents->item->object.flags |= COMMON;

Thanks, this part avoids duplicate additions to the queue.

>                             if ((parents->item->object.flags & SEEN)
>                                      && !(parents->item->object.flags & POPPED))
>                                       ns->non_common_revs--;

And this matches the non_common_revs part.

If you want this code to be a little cleaner, you could add

	struct commit *p = parents->item;

at the start of the loop and then s/parents->item/p/ for the rest
of the uses in the loop.

>                             prio_queue_put(&queue, parents->item);
>                    }

>> In addition, the mark_common() method there seems to have a few
>> problems:
...
>> Consider fixing these issues while you are here.
>>
> 
> Make sense.

I'm looking forward to your v2!

Thanks,
-Stolee
