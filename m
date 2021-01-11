Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55DFBC433DB
	for <git@archiver.kernel.org>; Mon, 11 Jan 2021 17:12:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 274CB229CA
	for <git@archiver.kernel.org>; Mon, 11 Jan 2021 17:12:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389159AbhAKRLz (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 11 Jan 2021 12:11:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44292 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728844AbhAKRLy (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 11 Jan 2021 12:11:54 -0500
Received: from mail-oi1-x233.google.com (mail-oi1-x233.google.com [IPv6:2607:f8b0:4864:20::233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B81DC061794
        for <git@vger.kernel.org>; Mon, 11 Jan 2021 09:11:14 -0800 (PST)
Received: by mail-oi1-x233.google.com with SMTP id q205so20787938oig.13
        for <git@vger.kernel.org>; Mon, 11 Jan 2021 09:11:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=HrniTzL780Bboky7xkv1cXBppm0aVSgo0zH80JTjRAM=;
        b=fqHPX7VaLXdC8B2IWkQQs4iWxMaUZ4U+cEPGBlSb/gxXmC1oHOPZQT9aNku6XdB/gV
         q5IPex1cVN4lYVjJf7Wt1dwIdxNqM27yfWCV81DvKKGfzj02omfS7tgQjWnetmrUD5TA
         kuJBQP6UCyHLBNwinmUf3AYCSVK8WOkPXbIgW3GXN2yYASo53wuwos3BiHsNyxSI5WMU
         Bz3UPBHK+s5nRQVG154NHQB2Ox2I/DAnnOGh56bO3d85+1/kC1rRvRdjK8x/9J2tq7jH
         r4/sYc205su/D55qLLKVPBtjgiEBZ0P2IoHouz5Jo/Gj2NQT067cttjowOYyHrIiMBpu
         YrcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=HrniTzL780Bboky7xkv1cXBppm0aVSgo0zH80JTjRAM=;
        b=j8w/j+Souh6azVHHumRdmQr42+SHZY5b454o+M94GZbvC1Ed3as20CstzgBW2c2Ssq
         RYlR4gUOyIutJbsgat2qNYf6z8qLsUp+xDaNEYWq5xgY2XUTq1o967/8PG0K0zqvVmiX
         ivu+cjJzQONQfgnkOCb9QbzZRUOzH+iSFHUvPwFBM3h4d2xo5ssKdbfGiMbOEQYHybLj
         8IKh+m4rAmvKd5VBFxgKi8gm6lj/PWMYpeo1zi7EnVuqI2JU7J0ADNCx/7IytsTUJ8o7
         VxMOW2VJvgctSeYZHFZb+oqVY/G7KAc+HiBcrRyrfvSwPhKuOmgpIruMD6sU5aOw7U1M
         3xew==
X-Gm-Message-State: AOAM532/uNRbITKL2oTQiJdZ+dlxMb0QrXMi+5SWJCfT20Z7X7kitXFc
        wfNyv5f5liX6zK9ZyGaL+1Y=
X-Google-Smtp-Source: ABdhPJxumN4IZcWviqE9o6c79Njc92gCND7imOKbd+05zz7rakltB2n75hj/YKgA8G+8d0cKqu54xA==
X-Received: by 2002:aca:4355:: with SMTP id q82mr236715oia.132.1610385073866;
        Mon, 11 Jan 2021 09:11:13 -0800 (PST)
Received: from ?IPv6:2600:1700:e72:80a0:605d:243e:92dd:9289? ([2600:1700:e72:80a0:605d:243e:92dd:9289])
        by smtp.gmail.com with UTF8SMTPSA id f145sm20418oob.18.2021.01.11.09.11.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 11 Jan 2021 09:11:12 -0800 (PST)
Subject: Re: [PATCH 18/20] pack-revindex: remove unused
 'find_revindex_position()'
To:     Taylor Blau <me@ttaylorr.com>
Cc:     git@vger.kernel.org, peff@peff.net, jrnieder@gmail.com
References: <cover.1610129796.git.me@ttaylorr.com>
 <d60411d524656f4680ac578765b2a8704325a060.1610129796.git.me@ttaylorr.com>
 <624d0642-b6c9-7c76-aeb6-d7e18b0aad1f@gmail.com>
 <X/x8dXFfQUdpKeVn@nand.local>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <61f6acde-3788-03ee-8dce-f621984a3402@gmail.com>
Date:   Mon, 11 Jan 2021 12:11:12 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:85.0) Gecko/20100101
 Thunderbird/85.0
MIME-Version: 1.0
In-Reply-To: <X/x8dXFfQUdpKeVn@nand.local>
Content-Type: text/plain; charset=UTF-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 1/11/2021 11:27 AM, Taylor Blau wrote:
> On Mon, Jan 11, 2021 at 06:57:00AM -0500, Derrick Stolee wrote:
>> Not that this is new to the current patch, but this patch made me
>> wonder if we should initialize *pos = -1 in the case of a failure
>> to find the position? A correct caller should not use the value
>> if they are checking for the fail-to-find case properly. But, I
>> could see someone making a mistake and having trouble diagnosing
>> the problem because their position variable was initialized to
>> zero or a previous successful case.
> 
> *pos = -1 may be more confusing than clarifying since pos is unsigned.

RIGHT. My bad.

> It would be nice if there was a clear signal beyond returning a negative
> value. I guess you could take a double pointer here which would allow
> you to assign NULL, but that feels rather cumbersome as a means to catch
> callers who failed to check the return value.
> 
> It does raise the argument of whether or not we should allow the
> program to continue at all if 'ret < 0' (i.e., 'offset_to_pack_pos()'
> either 'die()'s or returns a usable uint32_t), but I'm OK with the
> current behavior.

I was thinking "*pos = -1" was a free way to "help" a developer
who uses the API incorrectly, but it's _not_ free. Ignore me.

Thanks,
-Stolee
