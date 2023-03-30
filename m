Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF1F0C6FD1D
	for <git@archiver.kernel.org>; Thu, 30 Mar 2023 15:26:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233069AbjC3P07 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 30 Mar 2023 11:26:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40572 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233064AbjC3P0k (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 30 Mar 2023 11:26:40 -0400
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2658D538
        for <git@vger.kernel.org>; Thu, 30 Mar 2023 08:26:19 -0700 (PDT)
Received: by mail-pj1-x1030.google.com with SMTP id gp15-20020a17090adf0f00b0023d1bbd9f9eso22371257pjb.0
        for <git@vger.kernel.org>; Thu, 30 Mar 2023 08:26:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680189927;
        h=content-transfer-encoding:mime-version:user-agent:message-id
         :in-reply-to:date:references:subject:cc:to:from:sender:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ldWvFz54+puxOrlwA1i/Z9AxK0Zw21P+QKCkqxwXGDc=;
        b=SYYGq8zLFW0ZcJbCGPil5PS9Zu6Fz8k7fmsbbc32VT+YBuhO1JapzKWOyh9bIRZIUr
         w0zA3VqNxorxcUizVYf60s2eyyTO7S8xYrIyI0F5UBqUOBuw0BHlCXLOoRItMn8W16s/
         kiZKwYqOnDvxgwW8OYwS/VC9xddqFA1UV7bv3ncvjhe1qlODqcgUCCm+QwhywmRHGoDv
         hhubQUIxAza1SZ7iEh2YNk2GsWk02tys1x5RXydbC+eWXa4+H3gUKFLT80L0NCx6w4C8
         1zoYjdXBjn/lPFXFDaKPM03MNezNw09BJnzY2sWoKhXHaq6gZlvQZTpiHExhMsYF0X94
         CwtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680189927;
        h=content-transfer-encoding:mime-version:user-agent:message-id
         :in-reply-to:date:references:subject:cc:to:from:sender
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ldWvFz54+puxOrlwA1i/Z9AxK0Zw21P+QKCkqxwXGDc=;
        b=bFnI69mwLOg8NFZ2MK+TzXIbb+2V4AY1Wmd32smXEYUvi8ycklgDpRhoYENS4l8wfO
         QWndtDC0SgOBmbQ0ZH5k0z0a6fHc7kIktI+1qKKYsKqVypAq1YCxn06H/Cs0tp1f5zFt
         Pz6ktOYCsDqdUxd4DfjEQ7j7p45RBlxcvZoihoplOLnsYOUkb96vYGWt1i+9GwuDW502
         pKR0akZhN8sAqCT7rLEWgXoFbR2Sa/kIsDAHSuAPyF8iQ5iHJZ5FBAmYhcSPPby9ML0s
         rlbLd/t5yoLOJnKtsH/JmTD/XiLfWzOXAW005+ARfb1VK4Eyq1iMDB2HO15vKQjjxsOL
         Bmjw==
X-Gm-Message-State: AO0yUKX53Xz8HQIUG5dd5efLV4ID5/dSxFFuXUUMG3xey5ygt7j+XjoD
        QFa5fC/ShS6XKhEEdWBai7c=
X-Google-Smtp-Source: AK7set9FowaHn7PrWrMhVZJYmjlBW7A1R4IG94jo80z6PDgTpzPbPhk15DAmvOsnnq96nhWd5A6/4w==
X-Received: by 2002:a05:6a20:be29:b0:d9:e45d:95c8 with SMTP id ge41-20020a056a20be2900b000d9e45d95c8mr17330404pzb.30.1680189926762;
        Thu, 30 Mar 2023 08:25:26 -0700 (PDT)
Received: from localhost (83.92.168.34.bc.googleusercontent.com. [34.168.92.83])
        by smtp.gmail.com with ESMTPSA id x24-20020a62fb18000000b00582f222f088sm28389pfm.47.2023.03.30.08.25.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Mar 2023 08:25:26 -0700 (PDT)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?Q?=C3=98ystein?= Walle <oystwa@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH 1/2] ref-filter: remove unused ref_format member
References: <20230330112133.4437-1-oystwa@gmail.com>
        <20230330112133.4437-2-oystwa@gmail.com> <xmqqo7oa2rjs.fsf@gitster.g>
Date:   Thu, 30 Mar 2023 08:25:26 -0700
In-Reply-To: <xmqqo7oa2rjs.fsf@gitster.g> (Junio C. Hamano's message of "Thu,
        30 Mar 2023 08:21:43 -0700")
Message-ID: <xmqqjzyy2rdl.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

> Øystein Walle <oystwa@gmail.com> writes:
>
>> use_rest was added in b9dee075eb (ref-filter: add %(rest) atom,
>> 2021-07-26) but was never used. As far as I can tell it was used in a
>> later patch that was submitted to the mailing list but never applied.
>>
>> Signed-off-by: Øystein Walle <oystwa@gmail.com>
>> ---
>> Would be nice to have a link to the email thread here, but I don't know
>> how.
>
>
> Here is a link to the patch that led to that commit you cited:
>
> https://lore.kernel.org/git/207cc5129649e767036d8467ea7c884c3f664cc7.1627270010.git.gitgitgadget@gmail.com/
>
> It indeed is cumbersome to add, as the Message-Ids for patches from
> GitGitGadget tend to be ultra long.
>
> But b9dee075eb was the last one in the 5-patch series; I do
> not see any "later patch there in the thread.

I think there was a follow-up RFC series that was written to use the
value of the member, cf.

https://lore.kernel.org/git/9c5fddf6885875ccd3ce3f047bb938c77d9bbca2.1628842990.git.gitgitgadget@gmail.com/

but it seems there was no review on the series.
