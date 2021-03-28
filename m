Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 882BFC433DB
	for <git@archiver.kernel.org>; Sun, 28 Mar 2021 08:25:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 465B46195F
	for <git@archiver.kernel.org>; Sun, 28 Mar 2021 08:25:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229668AbhC1IYB (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 28 Mar 2021 04:24:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51890 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229489AbhC1IXf (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 28 Mar 2021 04:23:35 -0400
Received: from mail-pg1-x52f.google.com (mail-pg1-x52f.google.com [IPv6:2607:f8b0:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 827F3C061762
        for <git@vger.kernel.org>; Sun, 28 Mar 2021 01:23:35 -0700 (PDT)
Received: by mail-pg1-x52f.google.com with SMTP id 33so1594540pgy.4
        for <git@vger.kernel.org>; Sun, 28 Mar 2021 01:23:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-transfer-encoding:content-language;
        bh=euI5XzETxcJtixV366sirCscwCgyabs0rA6C9wiDH1Y=;
        b=WNXG9LIVAaovT+MeQLHHCk0pg8H0KsNYQb/4JNVEmP5X5CWzJKlbBbbfB3e5HWRyQp
         KhBrqMQl3u3Wiegt1Ub2wlYM6NYVishGLz/xlh06I54amLUJK47uRl0aona1Rt+nxsb0
         ykx+sHfX/kuMut+SPX0x00ASxdVzulDcD3Kjtt0dI+L/xusfCAcfgHVmcLm9Qbyxf3xJ
         d+XQ1zwKShMcPMtSYE3daUqs+2ww7KY+k7Vz7xcllQzvgZoP0XHOePBz9B3YL84TLjW/
         fOTxVEOV0ZP9gDbqMAf/2wzTXsRGdbFNtZkF9N3bPysn9M/E74Q8CpoZrWvmxxnuHYfG
         nN0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=euI5XzETxcJtixV366sirCscwCgyabs0rA6C9wiDH1Y=;
        b=N1svNye4O5uIWigIrQ0nYcZqzY7WRIJon5ubFM4Cde/U1FY62kHMeTRLXIwK40fc17
         kSZ5Cwfdn/p3TurSmIdmfuXdU0tRszn+sWP7uEywq9IF9w8MRm1oo0FANOO1rRwdcfHK
         c8Gev+h2PQJHAtvB3BKZlEj6quO2Prf8gw577VdmL/khGOGPh9T5FJ6B+/EetjVfUyyT
         PdMWBRXau2++5OALQKqKbalmvP+lvPZxcS/n8iaqQz0YPPE7MS+G1uCdONvaVbqXjiqm
         UeRd6cTU4ZBVpq26vWHZ8sydcfU/80lagj+qrwvwkFg6bQIjEP3LqFDZJ63+lB4+XSrf
         2NHA==
X-Gm-Message-State: AOAM531Esa1eUF6rlI5a76kKZ8pssdC2I7cdfGyBbLU380vCfBKu7QyS
        nH3Q9jNu0VARqUu6sQkXBaOr2OR2/NNFq6MR
X-Google-Smtp-Source: ABdhPJwf6ErXdJRtHuiOPCuMOSROXhzflr5AV9Y47ANEYQDNMWjPe9lsoZXVpZ/L2tdq82Y9UXtvHg==
X-Received: by 2002:a63:79c6:: with SMTP id u189mr6655268pgc.154.1616919814416;
        Sun, 28 Mar 2021 01:23:34 -0700 (PDT)
Received: from [192.168.10.22] ([125.21.249.98])
        by smtp.gmail.com with ESMTPSA id y23sm13937673pfo.50.2021.03.28.01.23.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 28 Mar 2021 01:23:33 -0700 (PDT)
Subject: Re: [PATCH] Documentation: amended usages of various (sub)commands
To:     Bagas Sanjaya <bagasdotme@gmail.com>, git@vger.kernel.org
References: <pull.920.git.1616913298624.gitgitgadget@gmail.com>
 <e85a653c-2650-313d-b5ca-5874559d9528@gmail.com>
 <de6d56b5-89e4-1e50-1011-0a9b9c46f4d9@gmail.com>
From:   Chinmoy Chakraborty <chinmoy12c@gmail.com>
Message-ID: <2ccb53ea-e92d-f7ba-f480-467a0269548c@gmail.com>
Date:   Sun, 28 Mar 2021 13:54:51 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.9.0
MIME-Version: 1.0
In-Reply-To: <de6d56b5-89e4-1e50-1011-0a9b9c46f4d9@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On 3/28/21 1:43 PM, Bagas Sanjaya wrote:
> Oops, I don't see that diff above. Sorry for that.
That's fine :).
>
> What about this patch title below?:
>
> `Make (sub)command options conform to TD of option parsing`
>
Sure I'll update the title. Thanks for the suggestion.
