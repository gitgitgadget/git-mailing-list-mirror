Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69F7AC433B4
	for <git@archiver.kernel.org>; Tue, 18 May 2021 03:45:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 44558611CC
	for <git@archiver.kernel.org>; Tue, 18 May 2021 03:45:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239123AbhERDrJ (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 17 May 2021 23:47:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50392 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236460AbhERDrI (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 17 May 2021 23:47:08 -0400
Received: from mail-pg1-x534.google.com (mail-pg1-x534.google.com [IPv6:2607:f8b0:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63F42C061573;
        Mon, 17 May 2021 20:45:51 -0700 (PDT)
Received: by mail-pg1-x534.google.com with SMTP id m124so6035364pgm.13;
        Mon, 17 May 2021 20:45:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=8R9lSw+Qvose5mbTLAUO7OtRB4diR/Qj4KIusA5FFXw=;
        b=bJ+G0OHpXo/7wLGcghue6jo+aQ4lQJBXSJYDotisavxInu9RfNZSJemrBxlJ8biqgL
         3Ed/LqWvY5OQ2wi7o07F7trLdwCSJw0/U244ETHB/JmgGMJTGR7PjL/5rB5QHmB2O8Fg
         fxmL/N+i7dVEN8kRVvIiEouavUDBTqb0Io5S6m0kxIuqRVr58NQhgn2qVijeMWto4jAB
         AxwZ+xd4WF5iXUXWYu6mJWkPmPiN9Dx7o1xetqcN3S92MyQ2au9S+3RFw11myEMk7mU3
         0Q1kdMhTuIzN0vnMeAPMpDzL4jdsfbjXBiaDKaE25XL30z1aAE/F0iMYyMETOAXjOU1j
         Q8wQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=8R9lSw+Qvose5mbTLAUO7OtRB4diR/Qj4KIusA5FFXw=;
        b=BmV6IxvrMydhdNXx1S693VMqpQHlj6I2aD3kHVeaz+RwzOd2xpNyjU1I0xaybyl74H
         t9juYDoLR06ZNaQ5HOoOSJxUAMYvgLKE97efp0jWWexBsI2pU+2EIv+SxAHwhaFKrxXF
         dke10bYYws8k3iK2PNtpUi3N5truplWkI4AXw4muIGhZ0vDczeb180Mfvjk3a4Y4qtFq
         LF0NCR3rT1ZEL4cCc/nETSBfNl4HHzUkWkNSbmOfirzCF2L7bGvL7FYa9flm8XB9xTlI
         i20l2hxQ2lY5dySnUvlAUA4dIjXrVYYUfEKIS5KHE1tFU5StWnrVJ60GKCjdHptX9bV7
         qqvQ==
X-Gm-Message-State: AOAM530MetemrmyDSOUgPwqCU/9QGakW8C0OZSKZCbTOk5kS8zaBAeot
        /s++Q5xweE/BTVqR7pGvYQc=
X-Google-Smtp-Source: ABdhPJz8uR1PN7Y4jihXpXiBxw8uFopCao0dfyFJxK1X1l4QgdvdlT3LFOcJSXM41SiZtVto8GFmTw==
X-Received: by 2002:a63:4d22:: with SMTP id a34mr2892907pgb.421.1621309550929;
        Mon, 17 May 2021 20:45:50 -0700 (PDT)
Received: from [192.168.43.80] (subs32-116-206-28-34.three.co.id. [116.206.28.34])
        by smtp.gmail.com with ESMTPSA id j26sm10949930pfn.47.2021.05.17.20.45.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 17 May 2021 20:45:50 -0700 (PDT)
Subject: Re: [Broken] RE: [ANNOUNCE] Git v2.32.0-rc0
To:     "Randall S. Becker" <rsbecker@nexbridge.com>,
        'Junio C Hamano' <gitster@pobox.com>, git@vger.kernel.org
Cc:     'Linux Kernel' <linux-kernel@vger.kernel.org>,
        git-packagers@googlegroups.com
References: <007201d74b25$de5f2710$9b1d7530$@nexbridge.com>
From:   Bagas Sanjaya <bagasdotme@gmail.com>
Message-ID: <d24c956a-895c-b196-579b-fa57d1f99daf@gmail.com>
Date:   Tue, 18 May 2021 10:45:47 +0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <007201d74b25$de5f2710$9b1d7530$@nexbridge.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 17/05/21 21.06, Randall S. Becker wrote:
> Git 2.23.0 no longer builds on NonStop x86. Reference to pthreads is not permitted in s non-pthread build.
> 
> **** ERROR **** [1210]:
>     libgit.a(ipc-unix-socket.o): In function `thread_block_sigpipe':
>     ipc-unix-socket.o(.text+0xb87): unresolved reference to pthread_sigmask.
> 
> We are not building with pthreads. This is net-new for 2.32.0-rc0, not seen in 2.31.0.
> 
> I'm unsure as to why this file is even being included in a non-thread build.
> 
> Randall
> 
> 

I can confirm the issue on my Linux box (Ubuntu).

Thanks for the reporting.

-- 
An old man doll... just what I always wanted! - Clara
