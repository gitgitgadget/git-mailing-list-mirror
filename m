Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F380C433DB
	for <git@archiver.kernel.org>; Tue,  9 Mar 2021 22:52:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 49247650FD
	for <git@archiver.kernel.org>; Tue,  9 Mar 2021 22:52:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232117AbhCIWwL (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 9 Mar 2021 17:52:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55022 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230122AbhCIWv7 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 9 Mar 2021 17:51:59 -0500
Received: from mail-ot1-x332.google.com (mail-ot1-x332.google.com [IPv6:2607:f8b0:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 53421C06174A
        for <git@vger.kernel.org>; Tue,  9 Mar 2021 14:51:59 -0800 (PST)
Received: by mail-ot1-x332.google.com with SMTP id r24so6388972otp.12
        for <git@vger.kernel.org>; Tue, 09 Mar 2021 14:51:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=kjIGNokeKRABBe7BLZvFZflpmjf8tXYwQwTLumk9pf0=;
        b=ZSwrOkskgCQbju1gPOPsASqe9MOM4gReAONUXLGmExTvlcqMls7x96U5SLLBModKpJ
         UL1dMktg9m4I6l7dRJIVdUwrYftkIaedN4F9Bnbhw0mHpfm4ziUUbyHVIRzc5c3lHcuJ
         KoLGSYgoWR4lrbv7x9XLUSaR+ncK88l9TO0JBqGpTfmNANV7MZH3G/BKBhGiUXGvjMfI
         CcK7z5D2qTDsCn8Kz8rImqokmNfRcC+X0C4G+77V+szC0EAx2bP5KAOF2h9uJiugJu2S
         bWSrLf56uuhxoIXnUaEXvoxxYjdJP4R6m6DfKIZLrCgUAy6RoUIcv6xwCvNKD9omq+i5
         m8Pg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=kjIGNokeKRABBe7BLZvFZflpmjf8tXYwQwTLumk9pf0=;
        b=D1+9P4Bcrclr0TbvJV8ZQlzfGibnWOdxXtU/0vuynEg67lprHb2FdT/ENtJC2KFWv6
         w0uXXmeHhFZ771PMIfULrShZBcLu3dftMy37fIeoRWD4QmqzuqIS3v033KTKAZzoLoPx
         0rehVcSvoKUuD8DEpuXua3ozdRlVozbCb2grCOp2UkVGBiUZPdHodZzxzHnii5xzvLhv
         r3wKUWXd0klQ4QFh90CFvK0a7OOw10gauR5vyluCh3t8mqIUnBkxQ7k6Uucs0r+hc5k1
         oF2itUXbzSb5Taje6LoxQqpY53+Dd0+S+Bc2uLzfHNj71qKdf4WIz9ljp+URD+xDRIg7
         pfYg==
X-Gm-Message-State: AOAM531oit6GUusqDF7AzflDVRxTBUa3oALonH6ifQ/++6nHTIq382jG
        x95xJUw3Mxz6qh0oX0P7gMbbLOxA16Czag==
X-Google-Smtp-Source: ABdhPJyb5PduAZ3SmBjpY4ACuP0b8ix1g8mg4Dn+V7Vd9sHCoCANH2R6e0X+REtzwCaLLVl3VoVkUA==
X-Received: by 2002:a05:6830:232f:: with SMTP id q15mr340097otg.165.1615330318740;
        Tue, 09 Mar 2021 14:51:58 -0800 (PST)
Received: from ?IPv6:2600:1700:e72:80a0:88a7:dd04:71df:86ee? ([2600:1700:e72:80a0:88a7:dd04:71df:86ee])
        by smtp.gmail.com with ESMTPSA id p67sm3389130oih.21.2021.03.09.14.51.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 09 Mar 2021 14:51:58 -0800 (PST)
Subject: Re: [PATCH v2 7/8] merge-ort: skip rename detection entirely if
 possible
To:     Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Cc:     Derrick Stolee <dstolee@microsoft.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Taylor Blau <me@ttaylorr.com>,
        Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Elijah Newren <newren@gmail.com>
References: <pull.845.git.1614484707.gitgitgadget@gmail.com>
 <pull.845.v2.git.1615248599.gitgitgadget@gmail.com>
 <cd931286f24d66efbf6b0f0a1f520b58ac468f88.1615248599.git.gitgitgadget@gmail.com>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <82be59b5-a930-ddca-c694-14f27a9fbae6@gmail.com>
Date:   Tue, 9 Mar 2021 17:51:57 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.0
MIME-Version: 1.0
In-Reply-To: <cd931286f24d66efbf6b0f0a1f520b58ac468f88.1615248599.git.gitgitgadget@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 3/8/2021 7:09 PM, Elijah Newren via GitGitGadget wrote:> +	goto simple_cleanup; /* collect_renames() handles some of cleanup */
> +
> +cleanup:
> +	/*
> +	 * Free now unneeded filepairs, which would have been handled
> +	 * in collect_renames() normally but we're about to skip that
> +	 * code...
> +	 */

"but we're about to skip that code"

Haven't you skipped it already, earlier in the above part? This should
instead say "but we skipped that code", right?

Thanks,
-Stolee
