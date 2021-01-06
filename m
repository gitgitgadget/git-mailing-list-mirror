Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.5 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 033EBC433DB
	for <git@archiver.kernel.org>; Wed,  6 Jan 2021 12:08:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D2D862311B
	for <git@archiver.kernel.org>; Wed,  6 Jan 2021 12:08:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726253AbhAFMIs (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 6 Jan 2021 07:08:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35020 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725789AbhAFMIr (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 6 Jan 2021 07:08:47 -0500
Received: from mail-qk1-x734.google.com (mail-qk1-x734.google.com [IPv6:2607:f8b0:4864:20::734])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A72EC06134C
        for <git@vger.kernel.org>; Wed,  6 Jan 2021 04:08:07 -0800 (PST)
Received: by mail-qk1-x734.google.com with SMTP id f26so2254308qka.0
        for <git@vger.kernel.org>; Wed, 06 Jan 2021 04:08:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=/ylydjbnPnWLqA52Za9Y0dPz8fgvV7rPpPvFtDkk3WE=;
        b=Uf9LYpqho7iOtRP9Ae+vy01Avj9LQ5oBGEMvqSmfmLktRlohv2zfZUfiG+peQSxz7B
         Y1jx0uwz4deD3n17H6zGahmqyv0Iui2gxskHdju5AgSlak8PhXAyBy24DP4hR0M/lkhz
         qFrNNYTxgNv1KhflWnrNi/hEgLSyeVBp/baFY5Vv5LCrRiPGm1eHABcPNtR6MP+oQO/B
         C28dQr8Er2tBTXEougjEjQImXszesZVhs2zSxCoJ+SjkSJQ0us/M9Irjb+JrhCL7CxHC
         PdmDTxk1k1vem4dvWyFEgL7JNDoSC4fpj5thsXN6yKLckhB5Xlq+lykD/6AVYY2uep4L
         VVTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=/ylydjbnPnWLqA52Za9Y0dPz8fgvV7rPpPvFtDkk3WE=;
        b=L3f5nwQ+24rb8KjbXPO5venJO9VMJx9gI5uW8To+j7J86MosxWUW224aFITbE8mebO
         UjPVKFckfW/mHbqxDFQ0QVMOJfIHi85du5zmNvVJmKlVbok5Lss4CE2wyzKj642+HlO6
         +v7IFQ7SjkwA8geWrLRCtdDuTA/PFIjCT/2V/xQV1rkp+4QMq88+JTx+xp3nVmWVqguc
         ieI/thsEQt0GSkq9icjLGnEH4D3NP3Zhp0f5NSBKM5kT2X4E8979vQCbO74hhH1003sz
         iyJelvxEZGQYyZtzuwX+rQZqJOy2W1f1DWELW9F25NlnCdaklmf36EvvCRSlYNAs/agN
         WF1g==
X-Gm-Message-State: AOAM532Gw/NOX1LdPaxU8A/F20MNgmIW+rS81ZMUUR/9a3K4aNplj1Po
        u9x4Mq0tw1ft7zuV+A3+9JM=
X-Google-Smtp-Source: ABdhPJxQ6p7uvwxswrqH+YxMNt5qrDqi+8s8pDikj3sUrPQxFeXZ6ClhBOwuB8T2C9yU8MmJy/fdGg==
X-Received: by 2002:a37:5c81:: with SMTP id q123mr3825792qkb.309.1609934886494;
        Wed, 06 Jan 2021 04:08:06 -0800 (PST)
Received: from ?IPv6:2600:1700:e72:80a0:605d:243e:92dd:9289? ([2600:1700:e72:80a0:605d:243e:92dd:9289])
        by smtp.gmail.com with UTF8SMTPSA id 8sm1176886qkr.28.2021.01.06.04.08.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 06 Jan 2021 04:08:05 -0800 (PST)
Subject: Re: [PATCH 8/8] cache-tree: avoid path comparison loop when silent
To:     Junio C Hamano <gitster@pobox.com>,
        Elijah Newren <newren@gmail.com>
Cc:     Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee <dstolee@microsoft.com>
References: <pull.829.git.1609356413.gitgitgadget@gmail.com>
 <20ea7050324cdd78b0966f54366b26224dfc7814.1609356414.git.gitgitgadget@gmail.com>
 <CABPp-BFp5=C+6B1WUarXzabo0fU4xotP5UG91-hYahCHDA6Cng@mail.gmail.com>
 <xmqqble2sav9.fsf@gitster.c.googlers.com>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <9df34ae5-2be0-40b8-b1e3-0198e3dcef53@gmail.com>
Date:   Wed, 6 Jan 2021 07:08:06 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:85.0) Gecko/20100101
 Thunderbird/85.0
MIME-Version: 1.0
In-Reply-To: <xmqqble2sav9.fsf@gitster.c.googlers.com>
Content-Type: text/plain; charset=UTF-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 1/6/2021 3:55 AM, Junio C Hamano wrote:
> Elijah Newren <newren@gmail.com> writes:
> 
>> Looking through that code, I come to the same conclusion, though it
>> might be nice to have Junio confirm (and to explain the "if (10 <
>> ++funny)" section; did that help debugging too?).   The second part of
>> the loop was part of his initial commit adding the cache-tree
>> extension in commit 749864627c ("Add cache-tree.", 2006-04-23)
> 
> This is not about debugging our implementation.  The verification
> was done to protect against the on-disk index file left by broken
> implementations of other people.  Either JGit or Dulwich (I do not
> recall which one) used to have such a broken sort long time ago,
> IIRC, and the thing is, a broken implementation can be internally
> consistent.
> 
> I do not think we've heard problem reports discovered by this check
> about other peoples' broken implementation, but a chicken-and-egg is
> certainly in action here.  The check would have caught any new and
> broken implementation of Git before it got released to the wild to
> cause harm and that is probably we haven't heard.
 Thanks for the additional context. I think the performance
enhancements in v2 are enough to satisfy me for now without
completely removing the functionality.

Thanks,
-Stolee
