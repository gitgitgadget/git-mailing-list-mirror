Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 989E9C433FE
	for <git@archiver.kernel.org>; Thu, 10 Nov 2022 23:50:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231358AbiKJXuB (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 10 Nov 2022 18:50:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41270 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229528AbiKJXuA (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 10 Nov 2022 18:50:00 -0500
Received: from mail-pl1-x64a.google.com (mail-pl1-x64a.google.com [IPv6:2607:f8b0:4864:20::64a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F332963EC
        for <git@vger.kernel.org>; Thu, 10 Nov 2022 15:49:59 -0800 (PST)
Received: by mail-pl1-x64a.google.com with SMTP id x18-20020a170902ec9200b001869f20da7eso2357359plg.10
        for <git@vger.kernel.org>; Thu, 10 Nov 2022 15:49:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=DddtChqisOrVTvWRLFWt8N3/Cmvm7nggWak4HXWzcn4=;
        b=WweBLXpvbHztmT0eHisL+wCtsQSdjJqIKJRbIXDktAtKQLxjJGFdg8sEilb/PnZGdL
         Q3ftyfMP38XZuID/2tu7Nv5+t3Ds8XYcliBc9Lk9IhiQSnmBtRLU1TnazgJkCIhFLg0J
         jworaOI91DaN17Dq9MX81W9o4Nmb4lqd0sSRz80L8s/kQF/X6em0dcXpOeMy9HBkUBKG
         HynUBn8M6L3JyqX6i0P5ZotG8WBxA2VWR0Hw2aIoZgaXPURdO9BjstMRt1JtJDKVxMBl
         qI0jo+72iCWpZ/YfR+7a8YvyVZi8bZwl4jVFu0c2iXXHZySnZj7egMzQYSa7fwcmDzwW
         DvwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=DddtChqisOrVTvWRLFWt8N3/Cmvm7nggWak4HXWzcn4=;
        b=szf0GGQGCyach0S+0yCOexLMprTOZ6urHiykCjx9GvW7xvf+izJb7JdlmcYWtohWrq
         mBOG/gpcn3e1EVkd3f5Cw+TYAd3bi8P/GdsiRs7Z5QCgl24wDapozKC8aSareJJNW/6x
         UQIeWjuNaWy5L2XwfjW9WQPC5goStY9P8YyCEZ3lHHc5oT7iHSSdxTRf1fKLHHVg1Kyn
         k4DxEV1+tsuAL5/df0YkdPKRA3wPL/i3Ot1aG63aIfSuo9iUzm7ysro9Pwa03bZGrW2n
         cyh5DJ4Tb65cLmSl0Z22Ugnj6LWbwrOfPOOG7yUjVshQUzBKvyHPpFsODw2vBkSWc+0q
         QImA==
X-Gm-Message-State: ACrzQf2EJMzw/3Utje9PA/vurG1DCG7Ps4ywsYqTMuurrwF1KrO4UNbw
        uAHAjgVDpEKAstm2DutWuYhnAh79p+tF+g==
X-Google-Smtp-Source: AMsMyM5erKdQIO55kxa2sQXEFpOBMkJpt8gtZzBNsKXh1nOeULcBFEsrN+LQ9BIppWQ46YTUi5qm0RiPBir1bg==
X-Received: from chooglen.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:26d9])
 (user=chooglen job=sendgmr) by 2002:a17:90a:bd93:b0:213:9df5:43b2 with SMTP
 id z19-20020a17090abd9300b002139df543b2mr2581545pjr.86.1668124199345; Thu, 10
 Nov 2022 15:49:59 -0800 (PST)
Date:   Thu, 10 Nov 2022 15:49:57 -0800
In-Reply-To: <Y2xebII98xXBZqPq@nand.local>
Mime-Version: 1.0
References: <20221109004708.97668-1-chooglen@google.com> <Y2wYnpASncR2E0Ja@nand.local>
 <kl6lwn833cp0.fsf@chooglen-macbookpro.roam.corp.google.com> <Y2xebII98xXBZqPq@nand.local>
Message-ID: <kl6lfseq2wuy.fsf@chooglen-macbookpro.roam.corp.google.com>
Subject: Re: [RFC PATCH 0/4] git: remove --super-prefix
From:   Glen Choo <chooglen@google.com>
To:     Taylor Blau <me@ttaylorr.com>
Cc:     Taylor Blau <me@ttaylorr.com>, git@vger.kernel.org,
        "=?utf-8?B?w4Z2YXIg?= =?utf-8?B?QXJuZmrDtnLDsA==?= Bjarmason" 
        <avarab@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Taylor Blau <me@ttaylorr.com> writes:

> On Wed, Nov 09, 2022 at 03:55:39PM -0800, Glen Choo wrote:
>> > It looks like this series is broken, at least in my application of it.
>> > On the first patch, running t7401, for example, I get:
>> >
>> >     BUG: builtin/submodule--helper.c:121: cannot have prefix 'sub/' and toplevel_cwd_prefix ''
>> >     Aborted
>> >
>> > after running the first test (-x shows that it happens after running
>> > 'git submodule summary', unsurprisingly).
>> >
>> > I pushed out the result of what I have to the 'gc/remove--super-prefix'
>> > branch of git@github.com:ttaylorr/git.git. As you'll see, the base is
>> > 'master' (as of 319605f8f0 (The eleventh batch, 2022-11-08)) with a
>> > --no-ff merge of 'ab/submodule-helper-prep-only'.
>> >
>> > Let me know if I'm holding it wrong.
>>
>> No, the problem seems to be entirely on my end. (I could've sworn I sent
>> this to CI..)
>>
>> Given that we have another competing RFC, it doesn't seem like a great
>> use of time to reroll this just to unbreak "seen", but let me know if
>> I'm missing somthing.
>
> No problem. Let's drop this one for now, unless you have strong
> objections.

Yes let's drop my RFC for now, thanks.

>
> Thanks,
> Taylor
