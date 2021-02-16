Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67043C433DB
	for <git@archiver.kernel.org>; Tue, 16 Feb 2021 11:50:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 300C564DA8
	for <git@archiver.kernel.org>; Tue, 16 Feb 2021 11:50:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230206AbhBPLtz (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 16 Feb 2021 06:49:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45320 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230480AbhBPLrt (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 16 Feb 2021 06:47:49 -0500
Received: from mail-ot1-x329.google.com (mail-ot1-x329.google.com [IPv6:2607:f8b0:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 05D5FC061574
        for <git@vger.kernel.org>; Tue, 16 Feb 2021 03:47:09 -0800 (PST)
Received: by mail-ot1-x329.google.com with SMTP id d7so8735342otq.6
        for <git@vger.kernel.org>; Tue, 16 Feb 2021 03:47:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=FEXzDdtb537+ItZ70THJo+mXyDZM6FHm1S15TTxc0Sg=;
        b=pWGRnDaN+0DEVHnsMANfG2TolDEngXcKcsppYNkfGTJD16xmY/afGNEtJzOU8Y5807
         8mReZJxfCw04kOjVT5LBWoBmLF7XirefjVIYvZE3dHplxNGgxPeJjK/IfXxN4vqMBlEa
         daG9cVUsd84c1bQIPs5csIEZXzJwiWbTl+2f1T8nBP+KjRO+CFN0MTIxALvCm6IaXPvb
         3cYksv0Eiby3gD8+IxKMbQU6xysoPgIDzVuJ5sH8ea+MG5YtkbINzmzhN5qSPbaVllez
         NpFS4HLR+SNQOq6vVS2FXjvJ4pxz3DEEES7fpA7nhbMDRwlA/BHETJNSL17S46/ovk7c
         0/6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=FEXzDdtb537+ItZ70THJo+mXyDZM6FHm1S15TTxc0Sg=;
        b=hvuDMk2fUJ9O60aInb3zsuxXjRUEfObyxv49q9m+88Lmt7ik5F8lEF6Ghkh6fHOpZy
         Y1Hsti2bvWO2SRchEArYIEhF5lo0SSI8E0YbW2qrKemdza/9UXZ7agjGvVbLYH7JmdyZ
         qQoHgGi8r93GNoJQUktasz3Ws1YedW7leHkOXMZYLYayO9FXNw3QU0h/Cjfm2DLWf5W6
         tP+tujpytqnWje9rvnGRZQmltcele7aIA/JvN3ptwNWPYQi3BLoLnbNg3eGf592Ax4BC
         5WsSQEoDCOv3W4+SkotsxVCTjYZujoA9PO4A0EcfopKS/QqiZ8mUhS0du+295WiYbAqr
         XOeA==
X-Gm-Message-State: AOAM531VNMZU8fjosO7KKevbkqzAQRoHmyVwcqwf/lN98DOKh3VM2Ffz
        fd0G5cEUnGl5Ipb/EHRQCw8=
X-Google-Smtp-Source: ABdhPJwjNYmitYfa1YjVodaObVndHxNIOwgdahj+OfZiFiU8zfMnh+9fuMFgjU+pg+ZxS81/XReb0A==
X-Received: by 2002:a05:6830:16cb:: with SMTP id l11mr14714916otr.83.1613476028441;
        Tue, 16 Feb 2021 03:47:08 -0800 (PST)
Received: from ?IPv6:2600:1700:e72:80a0:bccc:aed3:3481:8d68? ([2600:1700:e72:80a0:bccc:aed3:3481:8d68])
        by smtp.gmail.com with UTF8SMTPSA id a88sm1429552otb.54.2021.02.16.03.47.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 16 Feb 2021 03:47:07 -0800 (PST)
Message-ID: <030f1d2f-62eb-03c0-b23e-d491fac50463@gmail.com>
Date:   Tue, 16 Feb 2021 06:47:06 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:86.0) Gecko/20100101
 Thunderbird/86.0
Subject: Re: [PATCH v2 2/4] builtin/multi-pack-index.c: don't handle
 'progress' separately
Content-Language: en-US
To:     Taylor Blau <me@ttaylorr.com>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFy?= =?UTF-8?Q?mason?= 
        <avarab@gmail.com>
Cc:     git@vger.kernel.org, peff@peff.net, dstolee@microsoft.com,
        szeder.dev@gmail.com, gitster@pobox.com
References: <87r1lhb6z7.fsf@evledraar.gmail.com>
 <cover.1613422804.git.me@ttaylorr.com>
 <abcc7fb7312b349562fe6d13e2250496e107c9ed.1613422804.git.me@ttaylorr.com>
 <87a6s5au4b.fsf@evledraar.gmail.com> <YCrrauGOiVkpM2fP@nand.local>
From:   Derrick Stolee <stolee@gmail.com>
In-Reply-To: <YCrrauGOiVkpM2fP@nand.local>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 2/15/2021 4:45 PM, Taylor Blau wrote:
> On Mon, Feb 15, 2021 at 10:39:16PM +0100, Ævar Arnfjörð Bjarmason wrote:
>> Funnily enough we could also just do:
>>
>>     opts.flags = isatty(2);
>>
>> Since there's a grand total of one flag it knows about, and
>> MIDX_PROGRESS is defined as 1.
> 
> :-). I have a handful of branches that add some new flags (including the
> original series I sent down-thread), so I'm not sure that I'm in favor
> of this (admittedly cute) hack.

It's also _wrong_ if the user passes in '--progress' but redirects stderr
to a file. I don't know why someone would want to do that, but they
could, and we honor that throughout all commands.

Thanks,
-Stolee
