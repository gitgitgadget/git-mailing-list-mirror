Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8F8B51F453
	for <e@80x24.org>; Mon,  1 Oct 2018 12:41:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729195AbeJATSl (ORCPT <rfc822;e@80x24.org>);
        Mon, 1 Oct 2018 15:18:41 -0400
Received: from mail-qt1-f169.google.com ([209.85.160.169]:33103 "EHLO
        mail-qt1-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729017AbeJATSl (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 1 Oct 2018 15:18:41 -0400
Received: by mail-qt1-f169.google.com with SMTP id q40-v6so775468qte.0
        for <git@vger.kernel.org>; Mon, 01 Oct 2018 05:41:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=64QMvqxLVBW/MPt8XqW2PyiVFRt3FFbWPeaOvRHQvSY=;
        b=VrMiLCdvzYrgXCY4cI8FwcWcHtsIz25L7lLLB3nUmc3qgbgRkzLy7khXVYt9hZ5jTg
         ep5rkFuTB7cG0Dc2F7MRnsPAs5JPebP77NUz7iIsWpyYNre/PgoRxX03ww9qHb2s/3MN
         u1XJ42kbB3NOFqoR5GX97EwmBDnGwPRzRPjryHgdjHWlu2QYAbFnqtVinOH1M49j8Oj2
         CAD0BtuZqksEJTyBAEJhuZslWJKxqXxXXIASqPGiaU0eC+C4MIXT70HClT61n0CanYCW
         O2JkvW9N6YGMqW2iB5fbDwIf5OGaOxkiRpNkwvTLuGJRd8dmA+xxwgq2ftll5IBzp7tT
         /4Qw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=64QMvqxLVBW/MPt8XqW2PyiVFRt3FFbWPeaOvRHQvSY=;
        b=rkuoDkRiA59fASiKWN1rw7EajlGZYznU04NEgSXriWn8z6ACmXCljFx5GYjFCOoC7m
         CSsYQRfPywbG55I3zSdXsUPaMr7SEF/y060tQR/47zdvaoJVyTZb3kUadv+PFkbZZVu5
         L971rxF6ZJT3a02obcHIXv1iMS1xTi18ZBs3OWSiyscKP3HTI1WmXR7J6zGc4TTlUqc0
         KXFyN02SGSxt1ATf9p+xrBqn1f0r6HSQUarQh1C7wGquN9GCd61BLlWbsTQ6xeEBhft5
         7IarTbrx19Mi2MFWpoJhxLHTgWe4K9aiOx+zJlOAowfKZolQoTgWzC5a+/LuMXGlrhIM
         mHUQ==
X-Gm-Message-State: ABuFfogchNwpAw9sq1oywHF0IkRAD2z3dTUwWElnMP7X+kxi44c4A13q
        s5lWeA8eJraxkYjMUgW4mcmx+y82
X-Google-Smtp-Source: ACcGV63jLt3JTw3rMnxj2EH7QAXzlJPyvc3jHRot3acryXnS65LSo/qoiBUuVTWSZoR7Gi4a2y402g==
X-Received: by 2002:a0c:8ab0:: with SMTP id 45-v6mr8237754qvv.159.1538397662921;
        Mon, 01 Oct 2018 05:41:02 -0700 (PDT)
Received: from ?IPv6:2001:4898:6808:13e:f5be:873:b4e5:f5e1? ([2001:4898:8010:0:def4:873:b4e5:f5e1])
        by smtp.gmail.com with ESMTPSA id x34-v6sm3996758qth.86.2018.10.01.05.41.01
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 01 Oct 2018 05:41:01 -0700 (PDT)
Subject: Re: [PATCH] read-cache: fix division by zero core-dump
To:     Ramsay Jones <ramsay@ramsayjones.plus.com>,
        Ben Peart <peartben@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>,
        GIT Mailing-list <git@vger.kernel.org>
References: <476b5678-41b2-d2f8-1890-ba315354ebc0@ramsayjones.plus.com>
 <8a76234e-fcf8-f435-33e9-1846c3b6ad14@gmail.com>
 <da607bd3-c91b-556d-b342-927cb2f773c7@ramsayjones.plus.com>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <b30e106e-b34b-2738-d4a2-001d77d1b08b@gmail.com>
Date:   Mon, 1 Oct 2018 08:41:01 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.0
MIME-Version: 1.0
In-Reply-To: <da607bd3-c91b-556d-b342-927cb2f773c7@ramsayjones.plus.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 9/28/2018 11:31 AM, Ramsay Jones wrote:
> Also, this is not the first time some multi-threaded code in git
> has 'failed' by assuming more than one cpu, so ...
>
I wonder if this is a good time to create a GIT_TEST_CPU_COUNT variable 
so we can mock out single-processor environments instead of relying on 
old hardware or custom VMs.

Thanks,
-Stolee
