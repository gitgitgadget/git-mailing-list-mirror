Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33978C77B73
	for <git@archiver.kernel.org>; Fri, 19 May 2023 01:32:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229648AbjESBcS (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 18 May 2023 21:32:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59948 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229522AbjESBcR (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 18 May 2023 21:32:17 -0400
Received: from mail-pl1-x633.google.com (mail-pl1-x633.google.com [IPv6:2607:f8b0:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 29B3299
        for <git@vger.kernel.org>; Thu, 18 May 2023 18:32:16 -0700 (PDT)
Received: by mail-pl1-x633.google.com with SMTP id d9443c01a7336-1ae6dce19f7so8803445ad.3
        for <git@vger.kernel.org>; Thu, 18 May 2023 18:32:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1684459935; x=1687051935;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ZOBZYiyb+IjwHoemyQ5n3argMNoDVUPhEbJojl04X3E=;
        b=m3rDfuE9K5OHbJiuKwgEmBaO9yl9bGjcpCeL6SH4UDHWqpKpffeaFuAEU8FJ6ZUdRz
         gtQgWieKZkoQ5ZICZ8fA5MlsqTV3LZPahQt2cdbz2WsBJjYt3TcCZITxsbQBht01KzAq
         gshESj/lcKAEAs2sohNk4DMH7Mnxny9UFgGTIccS9DCzArBCqrm29/zCFr+UhDSjlu4/
         AHd9wp404OU8iRvbsL9OcP546OiP/qUV0JM6giEpPlF6W989bQudxJIYECAsnxtiCyAo
         vPkldtjyy6Gb3JRMHmrQaxIT0VnfpaAu7sL3/C6IKBrSqGocdZpvm6GHCxNFeeYkgtv6
         CeFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684459935; x=1687051935;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=ZOBZYiyb+IjwHoemyQ5n3argMNoDVUPhEbJojl04X3E=;
        b=Q2y77tbP0Kf+hxXH3A3ViE1h3jeEWW9wGv0MFei1ugg+dy9+aKD3k//dQ1+vv600ib
         rnw+70UxSYsrGsGHzr4Q5uGe5t4DE/cUUuf6XagJU5ifFJpxwjAz/RKkbYjuzcLQ6/du
         4oaAzbqUAVgO3zKb5No0Q8QzBtlF6huiUumaVMt9QkHgDKu6uUUpfdz50qeu2uPjShxX
         g+ckzgdiR0AADAQsB6UBluE75KT1RUHxd8URmRNdCRbokNBZQLX/6O2crtDpFGDFJ+k8
         eAKhzEPVpeqfRYZMKV+o96Qa90NCLlRZ3uss3Es8/HUVqNMgn7jIWyKBe8/3uaQYj6H1
         ZUzg==
X-Gm-Message-State: AC+VfDxb4z8PEh6+AMTRW84KIf6bTUOybylbMbtN6zbvQ+3sDqYgnWOv
        HKXG8Yv8YhOSVtZ7do1EGZpIofHoEIw=
X-Google-Smtp-Source: ACHHUZ76MRY1638b09d/IiQIa2S03jbNGEoiaNbXOtTob4UMoSwueinx6hr/1zLTNzWsiOIabKnPAw==
X-Received: by 2002:a17:903:26cb:b0:1ae:7421:82b5 with SMTP id jg11-20020a17090326cb00b001ae742182b5mr990661plb.45.1684459935470;
        Thu, 18 May 2023 18:32:15 -0700 (PDT)
Received: from localhost (187.137.203.35.bc.googleusercontent.com. [35.203.137.187])
        by smtp.gmail.com with ESMTPSA id iw10-20020a170903044a00b001aaf370b1c7sm2079211plb.278.2023.05.18.18.32.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 May 2023 18:32:14 -0700 (PDT)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH 2/2] format-patch: free elements of rev.ref_message_ids
 list
References: <20230519000239.GA1975039@coredump.intra.peff.net>
        <20230519000543.GB1975194@coredump.intra.peff.net>
Date:   Thu, 18 May 2023 18:32:14 -0700
In-Reply-To: <20230519000543.GB1975194@coredump.intra.peff.net> (Jeff King's
        message of "Thu, 18 May 2023 20:05:43 -0400")
Message-ID: <xmqqttw9qf6p.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> When we are showing multiple patches with format-patch, we have to
> repeatedly overwrite the rev.message_id field. We take care to avoid
> leaking the old value by either freeing it, or adding it to
> ref_message_ids, a string list of ids to reference in subsequent
> messages.
>
> But unfortunately we do leak the value via that string list. We try
> to clear the string list, courtesy of 89f45cf4eb (format-patch: don't
> leak "extra_headers" or "ref_message_ids", 2022-04-13). But since it was
> initialized as "nodup", the string list doesn't realize it owns the
> strings, and it leaks them.
>
> We have two options here:
>
>   1. Continue to init with "nodup", but then tweak the value of
>      ref_message_ids.strdup_strings just before clearing.
>
>   2. Init with "dup", but use "append_nodup" when transferring ownership
>      of strings to the list. Clearing just works.
>
> I picked the second here, as I think it calls attention to the tricky
> part (transferring ownership via the nodup call).

This is pretty much what I had in mind wheh I wrote the log message
for the follow-up "Yikes, for now let's mark the test no longer
sanitizer clean" patch.  Very pleased to see a clean-up I punted
materialize while I was looking the other way ;-)

> There's one other related fix we have to do, though. We also insert the
> result of clean_message_id() into the list. This _sometimes_ allocates
> and sometimes does not, depending on whether we have to remove cruft
> from the end of the string. Let's teach it to consistently return an
> allocated string, so that the caller knows it must be freed.

Yes!

Thanks.
