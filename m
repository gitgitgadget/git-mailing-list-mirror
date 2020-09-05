Return-Path: <SRS0=od8b=CO=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96A3AC433E2
	for <git@archiver.kernel.org>; Sat,  5 Sep 2020 17:23:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 452162078E
	for <git@archiver.kernel.org>; Sat,  5 Sep 2020 17:23:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PDXHLn+7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728301AbgIERX6 (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 5 Sep 2020 13:23:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53396 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726568AbgIERX4 (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 5 Sep 2020 13:23:56 -0400
Received: from mail-pg1-x542.google.com (mail-pg1-x542.google.com [IPv6:2607:f8b0:4864:20::542])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 271F9C061244
        for <git@vger.kernel.org>; Sat,  5 Sep 2020 10:23:55 -0700 (PDT)
Received: by mail-pg1-x542.google.com with SMTP id m5so5947416pgj.9
        for <git@vger.kernel.org>; Sat, 05 Sep 2020 10:23:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:reply-to:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=IATNSDWlr6MUOZS/TvjCWPfxL3fJq1IxrmPqHQaAHzc=;
        b=PDXHLn+7ivZxuHyyCzLwrrQvlqqpGTEG7CmdEsn0XLxHGQHikGesIaUxWy/rC9I70F
         alaThH7qZ2l7LjXYGD/BZmj8TegkbdGdJ8WAy3YoPTKYFmAGO8xoWlalrXdjWKot1MXU
         3g0EaVsQEN8AXcO8wLJZMsdgeyIb5FbzwLu2srG++ds190iu+3YG5Q5jfGC813G3PgYY
         Bh4bqpKPsfJEhcG9sQZPxQbHtuZbie+UT7gwPhlTqt53tWdxavmQiaZe0ggjkWUws+iy
         an0FMmqEdOWZR3V43bhvFyqfh6DyHUWHHPThNyJdVkcVsHwqTQN3IEGXsyqJ7AWivmeJ
         qOZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:reply-to
         :references:mime-version:content-disposition
         :content-transfer-encoding:in-reply-to;
        bh=IATNSDWlr6MUOZS/TvjCWPfxL3fJq1IxrmPqHQaAHzc=;
        b=LZQkjr00S7qLc/J1XQfVJFF5J7wutRwSkS3xgvcIX+aqQNFA7Ngp3hG+DC4qIzoev4
         2Gn7eFVMkpo6TpRVNjYQqStie8mpNIlEt9hT9mxsXxSVmC9NfYrNwgnPb55JuhtNrG+f
         c+XrEeRfZgB26CcDNkoWQ20c+LIjpOfwbZmoXO/579J/plRzuBSnZprXF0K6N5EUiTbW
         pH1i73ci8IosE6i62wsBprzANmptwvtY1T8tUuCYUExj/pY64tJmZ6s2VDPcFvxq/YRA
         QN9jLzRK90mHLOZzJ0nwJEt7KpR0WVoyBUYh9FJc1YvCPItSrBd8mVV/kY80Mh3ut+Hf
         rNpQ==
X-Gm-Message-State: AOAM532NfO2fFkhH+2oHI5oxnGPKJ9KNUrjTxwUrCFyjxbgdLHd9ADuO
        Wy3kcMH60X6T3eIpI3lHfxTzprmSjALPSw==
X-Google-Smtp-Source: ABdhPJyq3kF8zGPWuJovQWbzmrvM9mKg6Faz2EEVyWlQ0dcYqDTAGMGycjB3hKa6VgiEL07NzJxbKA==
X-Received: by 2002:a63:754:: with SMTP id 81mr11165277pgh.435.1599326634422;
        Sat, 05 Sep 2020 10:23:54 -0700 (PDT)
Received: from Abhishek-Arch ([2409:4064:4e05:5392:130e:dca6:bf2a:67c9])
        by smtp.gmail.com with ESMTPSA id u63sm10415668pfu.34.2020.09.05.10.23.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 05 Sep 2020 10:23:53 -0700 (PDT)
Date:   Sat, 5 Sep 2020 22:51:27 +0530
From:   Abhishek Kumar <abhishekkumar8222@gmail.com>
To:     Jakub =?utf-8?B?TmFyxJlic2tp?= <jnareb@gmail.com>
Cc:     abhishekkumar8222@gmail.com, git@vger.kernel.org, stolee@gmail.com,
        gitgitgadget@gmail.com
Subject: Re: [PATCH v3 05/11] commit-graph: return 64-bit generation number
Message-ID: <20200905172127.GA1382@Abhishek-Arch>
Reply-To: 851rjjasdo.fsf@gmail.com
References: <pull.676.v2.git.1596941624.gitgitgadget@gmail.com>
 <pull.676.v3.git.1597509583.gitgitgadget@gmail.com>
 <6be759a9542114e4de41422efa18491085e19682.1597509583.git.gitgitgadget@gmail.com>
 <85d03km98l.fsf@gmail.com>
 <20200825050448.GA21012@Abhishek-Arch>
 <85ft8adilr.fsf@gmail.com>
 <20200901120653.GA59580@Abhishek-Arch>
 <851rjjasdo.fsf@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <851rjjasdo.fsf@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Sep 03, 2020 at 03:42:43PM +0200, Jakub Narębski wrote:
> Hi,
> 
> Abhishek Kumar <abhishekkumar8222@gmail.com> writes:
> > On Tue, Aug 25, 2020 at 02:18:24PM +0200, Jakub Narębski wrote:
> >> Abhishek Kumar <abhishekkumar8222@gmail.com> writes:
> >> 
> >> ...
> >> 
> >> However, as I wrote, handling GENERATION_NUMBER_V2_OFFSET_MAX is
> >> difficult.  As far as I can see, we can choose one of the *three*
> >> solutions (the third one is _new_):
> >> 
> >> a. store 64-bit corrected commit date in the GDAT chunk
> >>    all possible values are able to be stored, no need for
> >>    GENERATION_NUMBER_V2_MAX,
> >> 
> >> b. store 32-bit corrected commit date offset in the GDAT chunk,
> >>    if its value is larger than GENERATION_NUMBER_V2_OFFSET_MAX,
> >>    do not write GDAT chunk at all (like for backward compatibility
> >>    with mixed-version chains of split commit-graph layers),
> >> 
> >> c. store 32-bit corrected commit date offset in the GDAT chunk,
> >>    using some kind of overflow handling scheme; for example if
> >>    the most significant bit of 32-bit value is 1, then the
> >>    rest 31-bits are position in GDOV chunk, which uses 64-bit
> >>    to store those corrected commit date offsets that do not
> >>    fit in 32 bits.
> 
> Note that I have posted more detailed analysis of advantages and
> disadvantages of each of the above solutions in response to 11/11
> https://public-inbox.org/git/85o8mwb6nq.fsf@gmail.com/
> 
> I can think of yet another solution, a variant of approach 'c' with
> different overflow handling scheme:
> 
> c'.  Store 32-bit corrected commit date offset in the GDAT chunk,
>      using the following overflow handling scheme: if the value
>      is 0xFFFFFFFF (all bits set to 1, the maximum possible value
>      for uint32_t), then the corrected commit date or corrected
>      commit date offset can be found in GDOV chunk (Generation
>      Data OVerflow handling).
> 
>      The GDOV chunk is composed of:
>      - H bytes of commit OID, or 4 bytes (32 bits) of commit pos
>      - 8 bytes (64 bits) of corrected commit date or its offset
>      
>      Commits in GDOV chunk are sorted; as we expect for the number
>      of commits that require GDOV to be zero or a very small number
>      there is no need for GDO Fanout chunk.
>      
>    - advantages:
>      * commit-graph is smaller, increasing for abnormal repos
>      * overflow limit reduced only by 1 (a single value)
>    - disadvantages:
>      * most complex code of all proposed solutions
>        even more complicated than for solution 'c',
>        different from EDGE chunk handling
>      * tests would be needed to exercise the overflow code
> 
> Or we can split overflow handling into two chunks: GDOI (Generation Data
> Overflow Index) and GDOV, where GDOI would be composed of H bytes of
> commit OID or 4 bytes of commit graph position (sorted), and GDOV would
> be composed oly of 8 bytes (64 bits) of corrected commit date data.
> 
> This c'') variant has the same advantages and disadvantages as c'), with
> negligibly slightly larger disk size and possibly slightly better
> performance because of better data locality.
> 

The primary benefit of c') over c) seems to the range of valid offsets -
c') can range from [0, 0xFFFFFFFF) whereas offsets for c) can range
betwen [0, 0x7FFFFFF].

In other words, we should prefer c') over c) only if the offsets are
usually in the range [0x7FFFFFFF + 1, 0xFFFFFFFF)

Commits were overflowing corrected committer date offsets are rare, and
offsets in that particular range are doubly rare. To be wrong within
the range would be have an offset of 68 to 136 years, so that's possible
only if the corrupted timestamp is in future (it's been 50.68 years since
Unix epoch 0 so far).

Thikning back to the linux repository, the largest offset was around of
the order of 2 ^ 25 (offset of 1.06 years) and I would assume that holds

Overall, I don't think the added complexity (compared to c) approach)
makes up for by greater versatility.

[1]: https://lore.kernel.org/git/20200703082842.GA28027@Abhishek-Arch/

Thanks
- Abhishek
