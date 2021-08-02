Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8199DC4338F
	for <git@archiver.kernel.org>; Mon,  2 Aug 2021 18:03:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5D23961050
	for <git@archiver.kernel.org>; Mon,  2 Aug 2021 18:03:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229722AbhHBSDc (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 2 Aug 2021 14:03:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46548 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229537AbhHBSDb (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 2 Aug 2021 14:03:31 -0400
Received: from mail-ot1-x330.google.com (mail-ot1-x330.google.com [IPv6:2607:f8b0:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9AB58C06175F
        for <git@vger.kernel.org>; Mon,  2 Aug 2021 11:03:20 -0700 (PDT)
Received: by mail-ot1-x330.google.com with SMTP id 61-20020a9d0d430000b02903eabfc221a9so18325589oti.0
        for <git@vger.kernel.org>; Mon, 02 Aug 2021 11:03:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=VZX1OiASETCDTe5ruy5IIjwOB7sNcarNT6OxUe982t4=;
        b=axEX7fL6L6gEefyKd+uJi/m4vKxUUTeaRdoIGbx/Gj7i27GsbqGuI399ch9SPltifJ
         pI0r3MDEgm8AYkzLNMRksjCT95k6SxvJSOcNJkGGNnVPoxY5ntlXEtgmHEyfQz2Oywan
         2K9kFw4V+NCjKW9pASZX6rLzKORJZwxphxFdbji4/zFg2OBSf0cUyGtONs3KFmokYo43
         9ii9j4XYXFrD3os2tBBu1UcrkkAFgblkZBKjl3RlV/ycBxiiBqZIbox+Fpcn5dW/+kOM
         U4P+yn/HWxBuzag9uvAuCIwwymvngnPN1n4Dl9wkDOZWSH0sWeKL2prZGS65WTVSCgxV
         KQKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=VZX1OiASETCDTe5ruy5IIjwOB7sNcarNT6OxUe982t4=;
        b=WZF43uYYw4xySYfimOkq2Dwryy6a4HPeu4o2Ff8qpeDersMz+VDFGh547z+6QwbUsU
         bIvG6du/kQSwIjVb+MifWvrVwcAYtciguuupdPBH0/plr5df6qT7qsykHs4bQb4OmeAZ
         vfNbYEDbKJRam+nVFj3Vx/2s9eqGE16tofRpaWWxkn/j9CTPP+B9SOkb5z/YsyNMTAlF
         2hqlq7rpvNNSl6P/vmdXPFLzQ+CHv9GmarTYBbD92rOvO0EIkRpO0f/QRgNRjmhD2+X/
         OP5qv78CTEWrEKUEMSWj3hpdCnE/MgRaNeJWnie8OgnBE0A73QJVelP3JMxrSgJxtQtu
         c9HQ==
X-Gm-Message-State: AOAM530k5Hld/A/HydgR0J88+iZvUKEx+Gz8egHxi8JdulHGBVIra79t
        J7em/ex/JFdcr2e9Eck/bik=
X-Google-Smtp-Source: ABdhPJzVUAUKbgTxC+XojAxW1B3B0o+fe8fz5vGwxyLHNYb5gyTj/sUYqwpSRQfP/Svw5SdV7CVk5Q==
X-Received: by 2002:a05:6830:1e96:: with SMTP id n22mr12314494otr.11.1627927399939;
        Mon, 02 Aug 2021 11:03:19 -0700 (PDT)
Received: from ?IPv6:2600:1700:e72:80a0:34d1:2d41:f9b7:ccbc? ([2600:1700:e72:80a0:34d1:2d41:f9b7:ccbc])
        by smtp.gmail.com with ESMTPSA id n21sm1845687ooj.22.2021.08.02.11.03.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 02 Aug 2021 11:03:19 -0700 (PDT)
Subject: Re: [PATCH 0/2] [RFC] Switch default merge backend from recursive to
 ort
To:     Elijah Newren <newren@gmail.com>
Cc:     Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Christian Couder <chriscool@tuxfamily.org>,
        Derrick Stolee <dstolee@microsoft.com>,
        Emily Shaffer <emilyshaffer@google.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Jeff King <peff@peff.net>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Junio C Hamano <gitster@pobox.com>,
        Phillip Wood <phillip.wood@dunelm.org.uk>,
        =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>,
        Taylor Blau <me@ttaylorr.com>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
References: <pull.1055.git.git.1627776461.gitgitgadget@gmail.com>
 <ec1bb449-347a-924d-7462-3cef6facc0e9@gmail.com>
 <CABPp-BHNYPzJc=oksWfkUGqsrmK_nhr_24WcaqjZoK_+4wG=tA@mail.gmail.com>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <c27894f0-b0d2-a1a6-bac3-31e82b0283df@gmail.com>
Date:   Mon, 2 Aug 2021 14:03:16 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <CABPp-BHNYPzJc=oksWfkUGqsrmK_nhr_24WcaqjZoK_+4wG=tA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 8/2/2021 12:27 PM, Elijah Newren wrote:
> On Mon, Aug 2, 2021 at 9:05 AM Derrick Stolee <stolee@gmail.com> wrote:
>> I've done my own share of testing on some of our private monorepos to see
>> how ORT compares to the recursive algorithm. My data is not perhaps as
>> rigorous as yours, but I did notice that the ORT algorithm was consistently
>> within the 5-6 second range while the recursive algorithm would vary within
>> the 7-20 second range (and some outliers near 30s).
...
> One quick question on your timings here, though: in the past, when you
> compared timings, you compared merge-recursive *without* rename
> detection to merge-ort *with* rename detection.  Are you doing the
> same here (just so others have a better sense of what is being
> compared)?

Yes, I continue to test with merge.renames=0 in the config. That makes
the data more impressive.

Thanks,
-Stolee
