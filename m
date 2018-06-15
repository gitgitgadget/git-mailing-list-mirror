Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 65A301F403
	for <e@80x24.org>; Fri, 15 Jun 2018 16:11:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965935AbeFOQLZ (ORCPT <rfc822;e@80x24.org>);
        Fri, 15 Jun 2018 12:11:25 -0400
Received: from mail-wr0-f193.google.com ([209.85.128.193]:44352 "EHLO
        mail-wr0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S964966AbeFOQLY (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 15 Jun 2018 12:11:24 -0400
Received: by mail-wr0-f193.google.com with SMTP id x4-v6so10446849wro.11
        for <git@vger.kernel.org>; Fri, 15 Jun 2018 09:11:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-transfer-encoding;
        bh=KTy3PN/Eq41NZra0DicG1QJc7HF80XbqP9JWP02uK0U=;
        b=Qj3qn6foP75Qly9npHAVAWCqap3MViKjyhsvagtlhwl6ZOXaxrktpXAgfi8N+BW/9w
         d4XzYFPzRZjPSfrjFCjyJBGeXkp+m+pCrOwkQXJl6OuJKWDfohlp6csnkc6YORyAAq/q
         UkOxjj5WKXin1HGEqfeHODaw2c+UtTQ4ewCzyonqNEbnSBqS5+C6+AsinPoI95r4Af3W
         kGJjc5q2a5yErZsoMx5yVWEYYBLG3DJ6flk5QlRpMQQjBqyw0fD0YpsktVBk/4hRONkH
         Wd67PSqO8tFZDmY08O/z9m/LxYWz67NwPWUWmwhRECCdeYZzZBf4vJ3XElz+Z/xRmXIU
         x+nQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version
         :content-transfer-encoding;
        bh=KTy3PN/Eq41NZra0DicG1QJc7HF80XbqP9JWP02uK0U=;
        b=TigGBteIWpzA3ZZa9Ew6hpwrlWhdi7n/du8miZK+Se+4J7UTwIKMMd9LBmdAMaGEhT
         TcqE2H3Yw6xKQ3erP2PYZxm5LHfxqnrfpKrMLyUQerDG93A5Ze9aYRTNAiioLuNDlLMY
         WWiAC5gpk3q7nxGyytoDCODeux9LORXwWij3Sn5YMC2Jdk3t0tIiDVQ89+hYTLh+EhZZ
         ZeHW7TuHs/4C60jGaAXCZx6ujP7TvQa7pmiZ9yeMQfJ6L5NO5Jc14qfbhRNVimIbvAq3
         +xftRXGak04vnHZLm1C2A1fbiKeq9qbHEQa6NOeYqtd79B39dGIDcQxWD0JD11NRuFAI
         ZK4w==
X-Gm-Message-State: APt69E0nTAWqRAff+9HnwJkWEJQ1hA0Au6r1wWLKS/l2PaywYEvCPbKq
        PMXuCXfgURVWZsQ/DVVvYZM=
X-Google-Smtp-Source: ADUXVKLeDACLtH5keZOQsj9RTXNl5IfO4pVa34qY9UDjwL3+acY0MnYoC0DRe/WLG+rMP+Iqs4GxzA==
X-Received: by 2002:adf:f811:: with SMTP id s17-v6mr2097048wrp.172.1529079082995;
        Fri, 15 Jun 2018 09:11:22 -0700 (PDT)
Received: from localhost (168.50.187.35.bc.googleusercontent.com. [35.187.50.168])
        by smtp.gmail.com with ESMTPSA id w15-v6sm12370859wro.52.2018.06.15.09.11.22
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 15 Jun 2018 09:11:22 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     Luat Nguyen <root@l4w.io>, git@vger.kernel.org
Subject: Re: security: potential out-of-bound read at ewah_io.c |ewah_read_mmap|
References: <2067D731-C415-4D19-8CDA-90D7DC638397@l4w.io>
        <20180615032850.GA23241@sigill.intra.peff.net>
Date:   Fri, 15 Jun 2018 09:11:21 -0700
In-Reply-To: <20180615032850.GA23241@sigill.intra.peff.net> (Jeff King's
        message of "Thu, 14 Jun 2018 23:28:51 -0400")
Message-ID: <xmqqa7rw2fo6.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> On Fri, Jun 15, 2018 at 06:59:43AM +0800, Luat Nguyen wrote:
>
>> Recently, I’ve found a security issue related to out-of-bound read at function named `ewah_read_mmap`
>
> Thanks, this is definitely a bug worth addressing. But note...
>
>> Assume that, an attacker can put malicious `./git/index` into a repo by somehow.
>
> We generally don't consider .git/index (or pack .bitmap files, which
> also use this implementation) to be a major part of Git's attack
> surface, since they are generated locally. And if you can write to
> somebody's .git directory, there are already much easier ways to execute
> arbitrary code.

Thanks for giving a fair assessment on the gravity of the issue, to
which I agree fully, and also fixes and clean-ups.



>
>> Since there is lack of check whether the remaining size of `ptr`is
>> equal to `buffer_size` or not.
>
> Yep. We also fail to check if we even have enough bytes to read the
> buffer_size in the first place.
>
> Here are some patches. The first one fixes the problem you found. The
> second one drops some dead code that has a related problem. And the
> third just drops some dead code that I noticed in the same file. :)
>
>   [1/3]: ewah_read_mmap: bounds-check mmap reads
>   [2/3]: ewah: drop ewah_deserialize function
>   [3/3]: ewah: drop ewah_serialize_native function
>
>  ewah/ewah_io.c          | 106 ++++++++--------------------------------
>  ewah/ewok.h             |   4 +-
>  t/t5310-pack-bitmaps.sh |  13 +++++
>  3 files changed, 35 insertions(+), 88 deletions(-)
>
> -Peff
