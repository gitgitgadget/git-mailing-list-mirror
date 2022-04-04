Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC9DDC433EF
	for <git@archiver.kernel.org>; Mon,  4 Apr 2022 12:43:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347628AbiDDMps (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 4 Apr 2022 08:45:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54518 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347542AbiDDMpr (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 4 Apr 2022 08:45:47 -0400
Received: from mail-qk1-x734.google.com (mail-qk1-x734.google.com [IPv6:2607:f8b0:4864:20::734])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2B0B1D332
        for <git@vger.kernel.org>; Mon,  4 Apr 2022 05:43:48 -0700 (PDT)
Received: by mail-qk1-x734.google.com with SMTP id g8so7460391qke.2
        for <git@vger.kernel.org>; Mon, 04 Apr 2022 05:43:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=github.com; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=gPT+uO2p/suozBxCf9zPydHK/j8LRcTgPNXZadvICHM=;
        b=jFTat7pwtyrM6RJf144C7Lp2ERGKdMKX2qSPhdNBF7TdslegWJxE+0JW6O61RX+yiS
         3bRkJDzxZPONTNDjkKBwup+erBD6NXfvZT/ECifkoarv0KOi76ieeRxLpjpPb8bdZtVm
         WXv5xNSCcqzAdCeFH4CEuNpkAwj4ALm7/ijRj2HW5qnXUz86WV1qFewkGADpa4kXWMH9
         0HxKctII8HId+PID4DU4PttfMQ1jeVBFKXxq+zYAC6frFfjyLQH/6d4XUFfYNDWDXBDl
         s2wlvB/bKLyL6p3nmAp81aXcIv20zbsyH55eytXxjO9YL2GOMXPcPl+GkGWq9WvKqYEO
         zdmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=gPT+uO2p/suozBxCf9zPydHK/j8LRcTgPNXZadvICHM=;
        b=pkcc/Igw7BIrlpJyeNrub28VOT4UnMJV/0ZO0J5jlCbU6nH70q3FixjAqzZDEsFXyM
         D+PKAP0ZNBc2DK49b01+c/MQ8k2GRToD19SXEJznsjci37ODTlaePWkkGvmPkDNyBMhO
         LND5G/Nes4n4p4XhlmDBHdq0hlA6gXiELD22yEkqautmWBSJRz6+hwUm5pugsVqWlGsF
         k+Gn89w5Ya4UBYUUKM5jUtmv9FeTOvNtboMMlR/HQCEFfS3D4Q41Fs4tJGDYOJdBz+TN
         wH+RgV9K8gLdUmF1Qg700b0waoubRdVcH+aYWuMlZaMjyGQAC1LYB1/sA9R9nsmGlHHN
         q/lA==
X-Gm-Message-State: AOAM532gcZYF0SfZ5omtA9xTH45Zt2suFshciid8YiZVferQbysAKt/k
        WphDrdT7JjTSb1ZHS2mEyZnbHl73bLyA
X-Google-Smtp-Source: ABdhPJz4MB176kYUv/uZuSTxgQ3+J1ppFOB3JUnvQ88FQBzCtSleBCPVfTtv0AdP5hDF7X98VwBb7w==
X-Received: by 2002:a37:664e:0:b0:67b:309f:3c03 with SMTP id a75-20020a37664e000000b0067b309f3c03mr13511887qkc.677.1649076227971;
        Mon, 04 Apr 2022 05:43:47 -0700 (PDT)
Received: from [192.168.1.110] ([99.85.27.166])
        by smtp.gmail.com with ESMTPSA id d19-20020a05622a05d300b002e1e720ddcesm8784462qtb.4.2022.04.04.05.43.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 04 Apr 2022 05:43:47 -0700 (PDT)
Message-ID: <68e1703d-7a4a-cc83-f344-494533297e3d@github.com>
Date:   Mon, 4 Apr 2022 08:43:44 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [WIP v1 2/4] mv: add check_dir_in_index() and solve general dir
 check issue
Content-Language: en-US
To:     Shaoxuan Yuan <shaoxuan.yuan02@gmail.com>
Cc:     Victoria Dye <vdye@github.com>, git@vger.kernel.org,
        gitster@pobox.com
References: <20220331091755.385961-1-shaoxuan.yuan02@gmail.com>
 <20220331091755.385961-3-shaoxuan.yuan02@gmail.com>
 <52784078-c748-a4a0-68b4-db3c133dfa80@github.com>
 <CAJyCBOQmUYe53ahpEXQZAWMoers0o7b1xuCYu_k-LrfvKTkV-g@mail.gmail.com>
 <22aadea2-9330-aa9e-7b6a-834585189144@github.com>
 <CAJyCBOSQVA5oEW7_iKZW895ycQ4T=XAx422s4m+6VFDSDVeNMA@mail.gmail.com>
 <CAJyCBOREzrGSwzjAz_89q1+O2X-qqa-qB2ywPVGU=q37O-QdzQ@mail.gmail.com>
From:   Derrick Stolee <derrickstolee@github.com>
In-Reply-To: <CAJyCBOREzrGSwzjAz_89q1+O2X-qqa-qB2ywPVGU=q37O-QdzQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 4/4/2022 3:49 AM, Shaoxuan Yuan wrote:
> On Mon, Apr 4, 2022 at 3:25 PM Shaoxuan Yuan <shaoxuan.yuan02@gmail.com> wrote:
>> I read and think about this part a few times, but I'm still confused.
>>
>> As Victoria pointed out earlier, and I quote, "Sparse directories *only* appear
>> when you're using a sparse index, so, theoretically, this shouldn't ever
>> come up (and thus isn't testable) until you're using a sparse index."
>> So I'm not so sure what do you mean by putting "full index" and "sparse
>> directory" together.
>>
>> Thus, I go ahead and try to detect a directory that is outside of
>> sparse-checkout cone, without sparse-index enabled.
>>
>> I found a problem that if you use cache_name_pos() to do this
>> detection, I imagined the following example (I'm trying to imitate an
>> output of "git ls-files -t"):
>>
>> H a
>> H b
>> S d/file1
>> H e/file1
>>
>> So in this index, I use cache_name_pos() to find a directory "c/". I imagine the
>> the value returned would be -3, which indicates this directory would be inserted
>> at index position 2. However, the cache entry at position 2 is
>> "d/file1", which is
>> marked with SKIP_WORKTREE, and this fact cannot guarantee that "c/" is
>> a sparse directory, since ''c/" is not in the index per se.

I was thinking more about the case where you find a tracked directory that
has all contained files marked with SKIP_WORTKREE.

If you search for "d/" you will also get -3. Then, you will see that at
position 2 the cache entry d/file1 has SKIP_WORKTREE. The directory "d/"
should exist on disk if there are any entries starting with "d/" that do
not have the SKIP_WORKTREE bit.

Interesting things happen if you are in the scenario where d/f is in the
cone-mode sparse-checkout definition and you see this list of cache entries:

S d/a
H d/f/b
S d/g

Again, d/f/b should imply the existence of the directory d/ in the worktree.
>> Probably I'm missing something, or I'm just dumb.
> 
> Though I think doing a strncmp() after the cache_name_pos()
> can get the job done :)
 
I think this is the way to do it, including index_range_of_same_dir() in
builtin/mv.c.

Thanks,
-Stolee
