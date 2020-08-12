Return-Path: <SRS0=KdtI=BW=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE5B4C433E0
	for <git@archiver.kernel.org>; Wed, 12 Aug 2020 08:08:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 849AB20768
	for <git@archiver.kernel.org>; Wed, 12 Aug 2020 08:08:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QbZEfrjD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726695AbgHLIIY (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 12 Aug 2020 04:08:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44390 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726479AbgHLIIX (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 12 Aug 2020 04:08:23 -0400
Received: from mail-lj1-x244.google.com (mail-lj1-x244.google.com [IPv6:2a00:1450:4864:20::244])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B139C06174A
        for <git@vger.kernel.org>; Wed, 12 Aug 2020 01:08:23 -0700 (PDT)
Received: by mail-lj1-x244.google.com with SMTP id t6so1206572ljk.9
        for <git@vger.kernel.org>; Wed, 12 Aug 2020 01:08:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=dY2BThUJUcgMwhk9lKQ1hLM46zrLJpdgSiv9BI4KMEk=;
        b=QbZEfrjDHBgRDeogA5bAnpK+YMQRM1uw+w/uSmyr10Lc3niQxZJDRmUEtImKscjsnq
         2213aEWBiDdxhbj0yKLHu3l+Bs+y9gG8cbJl02HWAvDFWc/CbT9mqReUHEbWh5LajTqV
         dk8RpjzL3E6K3F9QC5BN5UelnGqSOhnPcgmfGfBtMmmOtfJbxTsNSkEJ2VCIdqzeQMFI
         sR37AGZ62RKOblip3+XpLDau2slxgAM4pfC16lFD3Sz2Nzh78vW82bMqQQUtnD4jQUhV
         2rmTFgcAiiW4jNA6Gw4EVdgiK1U01jjb11M5gEirLqpvdB3NZFy1Jy/ZtYUV2wZ+7Kfx
         WQrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:date:in-reply-to
         :message-id:user-agent:mime-version;
        bh=dY2BThUJUcgMwhk9lKQ1hLM46zrLJpdgSiv9BI4KMEk=;
        b=uZP+z9AAUHQSetN9sA2HQXk//nKfQ/3cSlJESL57YSdTZileNHa9C1Fp6U7SWc71eq
         WPIsfWAKxMLrICP5klresy5lg9z5yv9A5oOxPGxB1ppABN2JGKlz2eogiQfJYktWEzfu
         VLwl3lwpLxgxsMuOtdkrLDprZWJ9pA0lGvZbrCU//dSqQxF7iRuqRb9CRzs/bU5TDP2M
         S+u1GHC7AyUbav0qs3mOkHagPPIr83g91LNACfEPmp4nRfFp2CCR52jX++6fqDw3SYjm
         6wgST5uSZT/GtkTAtNeOaNeto0yD1tZVueF+5Iab4Fl55mJnzax7GB0LiLoUBKGJXSjU
         aIoQ==
X-Gm-Message-State: AOAM533pAIvRtoSslVdl8l6n2oEFmW732J0s3PIvpBQkxkOMCCJniVep
        a2tjCEO4TFja03AqvZUFl3qwYyay
X-Google-Smtp-Source: ABdhPJz5Taa4KOrLdPF/ygMXPylqxz+tCRrlWBH+Fh1+3URd0+tsAbihwLKtuNyCg+Nv2chT4167Nw==
X-Received: by 2002:a2e:531c:: with SMTP id h28mr5050861ljb.322.1597219701516;
        Wed, 12 Aug 2020 01:08:21 -0700 (PDT)
Received: from osv.localdomain ([89.175.180.246])
        by smtp.gmail.com with ESMTPSA id 72sm288616lfh.97.2020.08.12.01.08.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Aug 2020 01:08:20 -0700 (PDT)
From:   Sergey Organov <sorganov@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Jeff King <peff@peff.net>, git@vger.kernel.org
Subject: Re: [PATCH  2/3] doc/git-log: describe --diff-merges=off
References: <20200805220832.3800-1-sorganov@gmail.com>
        <20200805220832.3800-3-sorganov@gmail.com>
        <xmqq8sek917j.fsf@gitster.c.googlers.com>
        <xmqqzh707kq1.fsf@gitster.c.googlers.com>
Date:   Wed, 12 Aug 2020 11:08:20 +0300
In-Reply-To: <xmqqzh707kq1.fsf@gitster.c.googlers.com> (Junio C. Hamano's
        message of "Tue, 11 Aug 2020 17:48:22 -0700")
Message-ID: <87imdoe16z.fsf@osv.gnss.ru>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.0.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

> Junio C Hamano <gitster@pobox.com> writes:
>
>> Sergey Organov <sorganov@gmail.com> writes:
>>
>>> Signed-off-by: Sergey Organov <sorganov@gmail.com>
>>> ---
>>>  Documentation/git-log.txt | 6 +++++-
>>>  1 file changed, 5 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/Documentation/git-log.txt b/Documentation/git-log.txt
>>> index 9ccba65469d7..f3727c786453 100644
>>> --- a/Documentation/git-log.txt
>>> +++ b/Documentation/git-log.txt
>>> @@ -145,7 +145,6 @@ combined-diff option or with `--no-diff-merges`).
>>>  	rename or copy detection have been requested).
>>>  
>>>  -m::
>>> ---diff-merges::
>>
>> Shouldn't this "--diff-merges" be removed from here?
>
> Sorry, my eyes.  Yes, you are removing it from here.

Don't mention it, -- these "---" caught me as well when I first looked
at the diff!

Thanks,
-- Sergey
