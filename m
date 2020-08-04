Return-Path: <SRS0=W4Po=BO=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94CD1C433E0
	for <git@archiver.kernel.org>; Tue,  4 Aug 2020 12:32:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 73E4B207FC
	for <git@archiver.kernel.org>; Tue,  4 Aug 2020 12:32:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nkMUjyz1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727768AbgHDMc3 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 4 Aug 2020 08:32:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39224 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726624AbgHDMb5 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 4 Aug 2020 08:31:57 -0400
Received: from mail-qv1-xf43.google.com (mail-qv1-xf43.google.com [IPv6:2607:f8b0:4864:20::f43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0B20C06174A
        for <git@vger.kernel.org>; Tue,  4 Aug 2020 05:31:55 -0700 (PDT)
Received: by mail-qv1-xf43.google.com with SMTP id l13so12523682qvt.10
        for <git@vger.kernel.org>; Tue, 04 Aug 2020 05:31:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=fmE0ipGC9I6ZLQ6Lm7FwZLv8LZPT6gs9BVtiJNTUNfo=;
        b=nkMUjyz1gXLCEWa1JgFe4yweXhcHqmGxmbezll/thz674TD4dfhbQbjzt6uBLW7w3s
         uMvC/9geg5rVId/1Hze51Zmog+JtYdakWJ49lXMPkddcgBbQoLbHHqUDmjyzmbwxZZGY
         uaWVYV1zSqeCfw/L4aakLWBBVJ6yyG5aaObx2RmIRt54tQa6aPFJ2U5Ya5KNJwqbdfNV
         SKzThh3DAD8HLBnwtKbzDJHrtzDHPRgiw7CAD5UbMt50wgqGcopsYqhIHOxEJ+KJ5hyc
         ir5EziX+VIbAAHUilflzvZcpm1H59orYjZdJB4XraecTcf2PpXzlZRBpwStC5o276Xzs
         zbhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=fmE0ipGC9I6ZLQ6Lm7FwZLv8LZPT6gs9BVtiJNTUNfo=;
        b=uXtxPQjpL+9KoFVxohhoK6M4ddurAn7LSnom9meQy16yZ59DlsWeqa0D9KRhK+HFjP
         r+oMpDuls1okM0FjJz9009YSql5m0mkxtGXdWqrLwYmegiLbua/iIaG580098seuuREP
         jfcUQyXvKWQtrHM++rw1K7T9ZINCTB5lDhIzAzsbir6IKEXVsLsFmcyMQ8NzfFBmy+5a
         /AZAIjWp/Rb3uh9+cSrtvBhvGOi8tJjAgrkt9cAh8yMiWny7qfb3pk1TUIBQy9lLR3q6
         HPn+LCh9M0MWHMNuawfYR0AIvqw1ExRCpHh1ZS/JTZq3RjuFh7SxeVEG0OUw8ICztImn
         AERw==
X-Gm-Message-State: AOAM532DFRUnuyRJ79t+a+4knrT8t4xIg0ZAM4Rk8lGnFRI6tXjqqW42
        aQxhBA29izxhW66yNqcDSlE=
X-Google-Smtp-Source: ABdhPJyM0iqP7sEh4kAcLWY8vawrNYaYRkuKEpWrOD/A8gy7sNLPdrLOcQjcDHRPl8HvBWlAd3YApA==
X-Received: by 2002:a0c:f9cd:: with SMTP id j13mr10678015qvo.227.1596544315011;
        Tue, 04 Aug 2020 05:31:55 -0700 (PDT)
Received: from ?IPv6:2600:1700:e72:80a0:359e:33e7:c1bc:799? ([2600:1700:e72:80a0:359e:33e7:c1bc:799])
        by smtp.gmail.com with ESMTPSA id 20sm1365165qtp.53.2020.08.04.05.31.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 04 Aug 2020 05:31:54 -0700 (PDT)
Subject: Re: [PATCH 06/10] commit-graph.c: sort index into commits list
To:     Taylor Blau <me@ttaylorr.com>, git@vger.kernel.org
Cc:     peff@peff.net, dstolee@microsoft.com
References: <cover.1596480582.git.me@ttaylorr.com>
 <b31c60d71266c40ae23a619d5ac5fd99148e1649.1596480582.git.me@ttaylorr.com>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <8bf3b41e-a597-3691-66e0-2be2f5f7e15e@gmail.com>
Date:   Tue, 4 Aug 2020 08:31:53 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:80.0) Gecko/20100101
 Thunderbird/80.0
MIME-Version: 1.0
In-Reply-To: <b31c60d71266c40ae23a619d5ac5fd99148e1649.1596480582.git.me@ttaylorr.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 8/3/2020 2:57 PM, Taylor Blau wrote:
> For locality, 'compute_bloom_filters()' sorts the commits for which it
> wants to compute Bloom filters in a preferred order (cf., 3d11275505
> (commit-graph: examine commits by generation number, 2020-03-30) for
> details).
> 
> The subsequent patch will want to recover the new graph position of each
> commit. Since the 'packed_commit_list' already stores a double-pointer,
> avoid a 'COPY_ARRAY' and instead keep track of an index into the
> original list. (Use an integer index instead of a memory address, since
> this involves a needlessly confusing triple-pointer).

It took me a little while to grok that we are switching from sorting
a list of commit pointers to sorting a list of integers. However, that
makes a lot of sense. It preserves the commit list sorted by OID for
binary search, which you will need soon. Perhaps another change would
need that at another time, too.

> Alter the two sorting routines 'commit_pos_cmp' and 'commit_gen_cmp' to
> take into account the packed_commit_list they are sorting with respect
> to. Since 'compute_bloom_filters()' is the only caller for each of those
> comparison functions, no other call-sites need updating.

Parsing the changes to these functions is the most complicated, because
of the int-to-commit indirection. I think they are correct and as easy
to read as possible.

-Stolee
