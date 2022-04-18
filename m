Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0BF7EC433F5
	for <git@archiver.kernel.org>; Mon, 18 Apr 2022 17:33:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347098AbiDRRfq (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 18 Apr 2022 13:35:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55868 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241994AbiDRRfp (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 18 Apr 2022 13:35:45 -0400
Received: from mail-lf1-x130.google.com (mail-lf1-x130.google.com [IPv6:2a00:1450:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3FBE12E9D0
        for <git@vger.kernel.org>; Mon, 18 Apr 2022 10:33:05 -0700 (PDT)
Received: by mail-lf1-x130.google.com with SMTP id x17so25205766lfa.10
        for <git@vger.kernel.org>; Mon, 18 Apr 2022 10:33:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=8e68M8kqZPQnIi7USlWOKvnGzZ1h0lPpFOQfW8GuXhU=;
        b=TH6sPLffiGh8u436kTuCS1Q9+8ruTkDyZqhxnkHywYOPw/Wf5530xl6xMeqf0fY48/
         R1BjjJFdyFeGl2ZHkXD0yDKFYrJAha1y5tt2J1GfrV32d4NfDcJOoHHBlaXRs3TP8yWQ
         66TRlyL5szRdhE7x6LXcRHMO4BttlnoN7ziZy2d3uG1D5+Mzp//FWXeScEKIkFuKYbXn
         nnxTYGDsVQ2cfu1mbHWU9jOCqw5fVAncP/hmQIfQPrqRgH0+WOXetZptjzEVXH2IOFr2
         t1hpQAoZx67360R71cgq+qubFSYynf8iPo5wxuvYnSyBnVq3I51PE5Dw3DpptNjoHwJI
         A/Lg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:references:date:in-reply-to
         :message-id:user-agent:mime-version;
        bh=8e68M8kqZPQnIi7USlWOKvnGzZ1h0lPpFOQfW8GuXhU=;
        b=Ij07uu+X0dQrWSH997dVT2q/NiyjUP653CSzmZH8bI4qWu3Tmh0oNrgwZpVzND0V8N
         n884WkVer2Jm1alwGLqhvm8EVFm/WWJ8TjNaTrNUbRhHOLcuEOpuAnI+JtkThF2ZbRB1
         +ENBcZRirdEEN2YSqm83/wLND0AU02rAIdu4X0Zx6YHiuVzesC+aWvZLlhmOEAfGb9bT
         YpMz5UnsDbL8bcNUmS4Nvs0zPOYOGzoyT2d+GCdcXomwLbLA1tKyt+5gN0iwtFIm4yrz
         csnS2WZuTPFZdJ58W1Kn5WKM5I0EZd2lOnLbr8uq9alUlvM6YNkQ1mG9lA2/QjuQmzTp
         L1qA==
X-Gm-Message-State: AOAM53122MHjYhAUhA40TpWrH+zjtMSwZYrTOqgBDFWGabBY35Koet45
        s4D0RI6KOEobbrsdnIoLYmY8KKdDYRo=
X-Google-Smtp-Source: ABdhPJzzdYfR+6ZAIs6BnmNKNQL35nAAX5XoqgSOZf9dgCPYQh8mNiviBS1GPL7gOGQ8VZnhh3UGvg==
X-Received: by 2002:a05:6512:1082:b0:44a:a6be:90b with SMTP id j2-20020a056512108200b0044aa6be090bmr9035824lfg.45.1650303183084;
        Mon, 18 Apr 2022 10:33:03 -0700 (PDT)
Received: from osv.localdomain ([89.175.180.246])
        by smtp.gmail.com with ESMTPSA id w23-20020a197b17000000b0046d1729e7d9sm1266535lfc.294.2022.04.18.10.33.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Apr 2022 10:33:02 -0700 (PDT)
From:   Sergey Organov <sorganov@gmail.com>
To:     Elijah Newren <newren@gmail.com>
Cc:     Edmundo Carmona Antoranz <eantoranz@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        Git List <git@vger.kernel.org>
Subject: Re: [RFC] introducing git replay
References: <20220413164336.101390-1-eantoranz@gmail.com>
        <xmqq4k2wap8g.fsf@gitster.g>
        <CAOc6etYvOhqQn3icWj3Ny1m+J_60h7aiqW-gvm=dQyDLgG=6NA@mail.gmail.com>
        <xmqqbkx2ccj4.fsf@gitster.g>
        <CAOc6etYwMtfytbw6iRfnJnsexJhe7UydVu0OFUbWP0byS9i=MQ@mail.gmail.com>
        <CABPp-BE=H-OcvGNJKm2zTvV3jEcUV0L=6W76ctpwOewZg56FKg@mail.gmail.com>
        <87lew226iw.fsf@osv.gnss.ru>
        <CABPp-BGQSN2iRWco4pQCVKA3AM6J0L0vyFMnYdrOgK0Pa26tWw@mail.gmail.com>
Date:   Mon, 18 Apr 2022 20:33:01 +0300
In-Reply-To: <CABPp-BGQSN2iRWco4pQCVKA3AM6J0L0vyFMnYdrOgK0Pa26tWw@mail.gmail.com>
        (Elijah Newren's message of "Mon, 18 Apr 2022 09:27:54 -0700")
Message-ID: <87czhewb3m.fsf@osv.gnss.ru>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.0.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Elijah Newren <newren@gmail.com> writes:

> Hi Sergey,
>
> On Mon, Apr 18, 2022 at 12:30 AM Sergey Organov <sorganov@gmail.com> wrote:
>>
>> Elijah Newren <newren@gmail.com> writes:
>>
> [...]
>> > Replaying merges is something I've put a little thought into, so allow
>> > me to provide some pointers that may help.  Merges need special
>> > handling for replaying, and in my opinion, doing either just a new
>> > merge of the new trees (what rebase --rebase-merges does), or just
>> > reusing existing trees (what you proposed to start this thread) are
>> > both suboptimal, though the former is likely to just be annoying and
>> > require potentially unnecessary user refixing,
>>
>> It silently drops user changes as well, and that's the worst thing about
>> it, not annoyance.
>
> Yes, I mentioned that later in the email, but omitted it in the
> summary you highlight here just because the fixed-tree case was so
> much more likely to do it.  Anyway, sorry for the inaccuracy in the
> summarized version.
>
>> > whereas the latter can silently discard changes or reintroduce
>> > discarded changes and could be dangerous. More details on both of
>> > these...
>>
>> Please consider yet another option:
>
> I linked to where I had given another option.
>
>> https://public-inbox.org/git/87r2oxe3o1.fsf@javad.com/
>>
>> that at least is safe with respect to user changes.
>
> If you read the suggestion I made (which I'll reinclude here at [1]),
> you'll note that I read the old thread you link to with both your and
> Phillips' suggestions.  I dug into them with some examples, and came
> to the conclusion that we needed something better, as I briefly
> commented when proposing my suggested alternative (at [1]).  I
> appreciate your suggestion and the time you put into it, but based on
> my earlier investigation, I believe my suggestion would be a better
> way of preserving user changes in merges and I'll be implementing it.
> The fact that Martin (in this thread) independently came up with the
> same basic idea and implemented it in jj (though he apparently has
> some further tweaks around the object model) and it works well
> suggests to me that the idea has some real world testing too that
> gives me further confidence in the idea.

Yep, whoever is going to actually implement something always wins, and
that's a good thing. I'm looking forward for the outcome of all this
with a hope.

Thanks,
-- Sergey Organov
