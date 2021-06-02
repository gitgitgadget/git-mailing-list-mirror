Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DAFF5C47083
	for <git@archiver.kernel.org>; Wed,  2 Jun 2021 11:14:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B07926135D
	for <git@archiver.kernel.org>; Wed,  2 Jun 2021 11:14:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230131AbhFBLQf (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 2 Jun 2021 07:16:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51076 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229603AbhFBLQf (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 2 Jun 2021 07:16:35 -0400
Received: from mail-pg1-x533.google.com (mail-pg1-x533.google.com [IPv6:2607:f8b0:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 614E0C061574
        for <git@vger.kernel.org>; Wed,  2 Jun 2021 04:14:51 -0700 (PDT)
Received: by mail-pg1-x533.google.com with SMTP id t9so1965054pgn.4
        for <git@vger.kernel.org>; Wed, 02 Jun 2021 04:14:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=1hXeaUP2lkJ3rfJSPADL9YA8tiH1QWtHIWhV5Qm0hFM=;
        b=AvEHsS4u8xWWJGbT90K1tNK4gSAhmAhsF5PNn7Rg4YVRS1GrfJ7KHKFmPAzNUHPCa5
         3Y/cnEHRe6t7NJDpBqD6726lbigsEww7jPcMf70zTtWGH5N+9QT0KQXKUsf9QivyMkFb
         GIBxcrvMT7tch9Ophw0fU2XaIbYlLngLIKRrwD0G33PuZvWRFZoVgdmpHeU87gvF5LIk
         vMpGs8nblZr8Kjt7peas0Aw34YSZ9qVwxwUEoma7LuOkX1Oq2uaa+1RX1Z6AgLX45hnV
         pEY3sYDCFTxOmjz+TzMw1wVWsDRWR7O/nZVUZggyYzdb4rEHHT4UcPJw7OCGplb//gqG
         g/fA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=1hXeaUP2lkJ3rfJSPADL9YA8tiH1QWtHIWhV5Qm0hFM=;
        b=ghx3Se41tvwf+t46WajmtlbEhwMaMPUu3Jfc6V8h8eUQuu7EYFTNXk5OKYnuBfRLgJ
         epzlysTDgIl/P/Jt6gtr6qJ2awo+zyxtZyYFYPY7/MZCORWO53okjKVcc/Bx6UU+Mx/q
         WeeFtJ++i/YDUaHhYRks+AcPJ3cDM+PaHO/mmw2Dv9nNDhuKaniRZauu6CQy3GRUYlyi
         PRN5MP0HskqAy3naoRW9yZSthBcNCtDbjmzTXEMDep2TR48j/ST5yZyF8UToREfhJVUn
         YKNHvTB7QXAywCMkD/ztobxcaQ/VZ0fMI1mr2i/NsARd/Rjbini+ssQCpaoRpDHT6VTU
         LidA==
X-Gm-Message-State: AOAM531UpdvP4xc0qI794EVHRFHsau2A6Tb7Jhd6zpguyIjV6WN31bJ5
        w6p8juRMAUkjxKlgKQxxgrY=
X-Google-Smtp-Source: ABdhPJx7YdImF5+159U8oG+SHjwAuo/e35UyLbvUdlVJYDhaim5h56scSBaXqwOp/QfHOIUYDk196w==
X-Received: by 2002:a63:da15:: with SMTP id c21mr32887843pgh.227.1622632490844;
        Wed, 02 Jun 2021 04:14:50 -0700 (PDT)
Received: from [192.168.43.80] (subs02-180-214-232-93.three.co.id. [180.214.232.93])
        by smtp.gmail.com with ESMTPSA id z19sm15648369pjn.0.2021.06.02.04.14.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 02 Jun 2021 04:14:50 -0700 (PDT)
Subject: Re: [PATCH] t2080: fix cp invocation to copy symlinks instead of
 following them
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        =?UTF-8?B?xJBvw6BuIFRy4bqnbiBDw7RuZyBEYW5o?= <congdanhqx@gmail.com>
Cc:     Matheus Tavares <matheus.bernardino@usp.br>, gitster@pobox.com,
        git@vger.kernel.org,
        "brian m . carlson" <sandals@crustytoothpaste.net>
References: <5386ee606567248464d39c313ee6177862a1f337.1622071475.git.matheus.bernardino@usp.br>
 <87r1hsl4qb.fsf@evledraar.gmail.com> <871r9n2dlu.fsf@evledraar.gmail.com>
 <YLbgi0jQn8BJ1ue2@danh.dev> <87pmx47cs9.fsf@evledraar.gmail.com>
From:   Bagas Sanjaya <bagasdotme@gmail.com>
Message-ID: <6b868297-0e1d-22ca-f896-f51dcedf0b3e@gmail.com>
Date:   Wed, 2 Jun 2021 18:14:47 +0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.2
MIME-Version: 1.0
In-Reply-To: <87pmx47cs9.fsf@evledraar.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 02/06/21 17.50, Ævar Arnfjörð Bjarmason wrote:
> So from the outset the code added around 79444c92943 (utf8: handle
> systems that don't write BOM for UTF-16, 2019-02-12) needs to be more
> careful (although this looked broken before), i.e. we should test exact
> known-good bytes and see if UTF-16 is really what we think it is,
> etc. This is likely broken on any big-endian non-GNUish iconv
> implementation.
> 
So we're still fixing for utf-16le case, right?

And what about known-good bytes on utf-16be?

-- 
An old man doll... just what I always wanted! - Clara
