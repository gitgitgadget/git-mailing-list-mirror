Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.5 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7355C433E0
	for <git@archiver.kernel.org>; Wed,  6 Jan 2021 12:03:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8412923117
	for <git@archiver.kernel.org>; Wed,  6 Jan 2021 12:03:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725896AbhAFMDs (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 6 Jan 2021 07:03:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34246 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725803AbhAFMDs (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 6 Jan 2021 07:03:48 -0500
Received: from mail-qt1-x830.google.com (mail-qt1-x830.google.com [IPv6:2607:f8b0:4864:20::830])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF613C06134C
        for <git@vger.kernel.org>; Wed,  6 Jan 2021 04:03:07 -0800 (PST)
Received: by mail-qt1-x830.google.com with SMTP id 7so1874894qtp.1
        for <git@vger.kernel.org>; Wed, 06 Jan 2021 04:03:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=ruidNjEKudoaWKoyGzFvt8ynWSnjYBezkBT2Sbrzd40=;
        b=hVe6VGHb5vgPqdsmViiaUK8O6LCTA0OZM4cxG7++5Mfxxc3+giq1jIAFISvrjLnORw
         ejY7RzjQ0yw2KQ3lUx77K1pKrBFgNGLYhuhOn3U1zctmZOrEw/MhiA/1kBx7X5dmIIGs
         PnudtpDDmhR2DpveDiiDXpnT/O5AeUN8JoCmrosGrk8/ml9yKBKA0F1syM3HtrM2/nuM
         ma5Tz0WteuO7vrF9wgiS6P583+pt/LxNmGYBG6UY2JIDRzfa3EtyfQZXq7bQygo40GrY
         4JTEV8N3mNv2IFnFK4cgswGxCNPvWAIaNbpCqpx5Sz077glEzFD+cCTPOpOW3I6AsMjk
         /Y5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=ruidNjEKudoaWKoyGzFvt8ynWSnjYBezkBT2Sbrzd40=;
        b=B5bUN2BLQ1YtqI7rEIcgywOsYYuNAZjmibFmv3wleYs18nhMniMbTZZyJMxqGYfzaw
         YcXGYPKv726Q8GksaztxLErSkoarBbWdmX8iEwyfX/eTKvDcogBPErRx4txc6MAlXpi0
         cd1vZMIbTXa0sN9RtJwOvt1pE+KQCNufC4vFnC5Jvcf9Cyb8FWCj2kBpU89dbyJP6aom
         51DlrB+Snh7YGniGJsuXh8yiId609zlkktAcRypAdf0BxWzxYSZRgx56ghazrJOFchsY
         XTRpGoQig3zFnAYRZnv16Pb/CH0uoxKdR5j/vP18cL1jxRoTzNrtnMzDTZ26uOJIwp6K
         YnUQ==
X-Gm-Message-State: AOAM53037IuDr1CloXX72rh8sQEeIRBZNRAu/d+ldrsMQw5hAvocuTew
        B1pLHQb/5djgLKSWvYIFwc0=
X-Google-Smtp-Source: ABdhPJztQqwKTnYFI50BhI5P5STNgnevR/fdBk6ywssgHN/IxdDpNTt8Vc1QX4JXh+Cmsn/p9B10zA==
X-Received: by 2002:ac8:7190:: with SMTP id w16mr3659631qto.134.1609934587027;
        Wed, 06 Jan 2021 04:03:07 -0800 (PST)
Received: from ?IPv6:2600:1700:e72:80a0:605d:243e:92dd:9289? ([2600:1700:e72:80a0:605d:243e:92dd:9289])
        by smtp.gmail.com with UTF8SMTPSA id m85sm1179709qke.33.2021.01.06.04.03.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 06 Jan 2021 04:03:06 -0800 (PST)
Subject: Re: Re* [PATCH] builtin/*: update usage format
To:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?B?6Zi/5b6354OIIHZpYSBHaXRHaXRHYWRnZXQ=?= 
        <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org,
        =?UTF-8?B?6Zi/5b6354OI?= <adlternative@gmail.com>
References: <pull.822.git.1609232114080.gitgitgadget@gmail.com>
 <xmqqwnwqtuj1.fsf@gitster.c.googlers.com>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <b6c68abd-e6b7-acec-6b1f-f915fe20e2e1@gmail.com>
Date:   Wed, 6 Jan 2021 07:03:05 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:85.0) Gecko/20100101
 Thunderbird/85.0
MIME-Version: 1.0
In-Reply-To: <xmqqwnwqtuj1.fsf@gitster.c.googlers.com>
Content-Type: text/plain; charset=UTF-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 1/6/2021 2:05 AM, Junio C Hamano wrote:
> Subject: parse-options: format argh like error messages
> 
> "Keep it homogeneous across the repository" is in general a
> guideline that can be used to converge to a good practice, but
> we can be a bit more prescriptive in this case.  Just like the
> messages we give die(_("...")) are formatted without the final
> full stop and without the initial capitalization, most of the
> argument help text are already formatted that way, and we want
> to encourage that as the house style.

It's tough to "keep it homogeneous" when the repository isn't
already in that state. Thanks, ZheNing, for working to improve
that situation.

>   * `argh`::
> - *   token to explain the kind of argument this option wants. Keep it
> - *   homogeneous across the repository. Should be wrapped by N_() for
> - *   translation.
> + *   token to explain the kind of argument this option wants. Does not
> + *   begin in capital letter, and does not end with a full stop.
> + *   Should be wrapped by N_() for translation.

I think this more-specific language is helpful.

Thanks,
-Stolee

