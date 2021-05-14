Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68F01C433ED
	for <git@archiver.kernel.org>; Fri, 14 May 2021 18:28:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3B4EB61442
	for <git@archiver.kernel.org>; Fri, 14 May 2021 18:28:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232171AbhENSaI (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 14 May 2021 14:30:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49686 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229701AbhENSaH (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 14 May 2021 14:30:07 -0400
Received: from mail-qk1-x72d.google.com (mail-qk1-x72d.google.com [IPv6:2607:f8b0:4864:20::72d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3955AC061574
        for <git@vger.kernel.org>; Fri, 14 May 2021 11:28:56 -0700 (PDT)
Received: by mail-qk1-x72d.google.com with SMTP id 197so29596165qkl.12
        for <git@vger.kernel.org>; Fri, 14 May 2021 11:28:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=p4CcrxXiry8GE2S6AfXJ0coDODOl4JqyU0smOQyDcU8=;
        b=UEYUcuLg4Bs8fA7Y5o3iyj7rPVNDR/t0DIOl9rnGSTsAnSUf9vhjyswP/BC6Ghid/7
         QO/YRd+pzGEvTxnaWnHE1Mr/X2mU1aOVl87dFIiWgCdZuJ0b01yV6n30yP5Aq4Hkkby3
         3PhiFnPwe5CCNAMbs7B3dnuFRkYLnlnAQIsAB4Yuzlp4mZW8dXC2TlsktUbR92dX1WBB
         ApZkJyIMlOp0S62LtuzVtd0phMJqwxP+Z7P7hYmZyKVPcZhZ1ngaw5Y+4sKZkcOGF1II
         vImSe+jtS2j0Gqu/FoctNcBwENlZtOp4hn6MnIScfZX3TydrHy2DOifCttvzpdqyaBv3
         L9bw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=p4CcrxXiry8GE2S6AfXJ0coDODOl4JqyU0smOQyDcU8=;
        b=oTCVgRO+5qmh6ur6GvzlrxrSId0XIGYWiAslt672G0XNhEoO3I6nUy2miCx9UkUYKM
         TdFU2xLXpWde+nT5lg8ZyZPm0j+Sql6KC5yvduICP+yaXPwxw30YCOI6ieRrIalxjNec
         ei7PYslV9vMyIXqijpEIi2Z6LD8CvhlVFVhqWiCNuAwBaAN6v8siA78xmh2EiZppRBWd
         gbDaVBZssx1J+nxuclPSae3rirmYmuLd2kodMdAzg2l4BIJroq9qPm/RLSImttbpSv85
         Po00YUDiArcRPVI24b2lc1RV5TEynohvufbuVSxKolfaUzhVfp+kefdpdWJPtN3bqt0v
         DP9Q==
X-Gm-Message-State: AOAM532tJOj0Tl9VP1ejdYGonMx3GdMp7Z1vNeiInPS8jjDXIT2A3v3g
        Xzk+0yna8U+iml8U7Er+d2g=
X-Google-Smtp-Source: ABdhPJygyZ6gS5gaSrUigwYAGOT6c2TRhfDBbUmiReo+ikXke2+VUTxfTIgMjUkY5N2IM0BAVB4UUw==
X-Received: by 2002:a37:b4e:: with SMTP id 75mr45984319qkl.281.1621016935417;
        Fri, 14 May 2021 11:28:55 -0700 (PDT)
Received: from ?IPv6:2600:1700:e72:80a0:6c05:727e:b905:fa7e? ([2600:1700:e72:80a0:6c05:727e:b905:fa7e])
        by smtp.gmail.com with ESMTPSA id g4sm4900571qtg.86.2021.05.14.11.28.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 14 May 2021 11:28:55 -0700 (PDT)
Subject: Re: [PATCH v2 0/8] Sparse-index: integrate with status
To:     Elijah Newren <newren@gmail.com>,
        Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Matheus Tavares Bernardino <matheus.bernardino@usp.br>,
        Derrick Stolee <derrickstolee@github.com>
References: <pull.932.git.1618322497.gitgitgadget@gmail.com>
 <pull.932.v2.git.1619213665.gitgitgadget@gmail.com>
 <CABPp-BF0EGo-WLTN45qOu02O4sEzmSCUXT3XeoKQdbTHToNQOw@mail.gmail.com>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <9204f7f6-85d5-f974-a77f-4e8e412cdc55@gmail.com>
Date:   Fri, 14 May 2021 14:28:54 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <CABPp-BF0EGo-WLTN45qOu02O4sEzmSCUXT3XeoKQdbTHToNQOw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 5/13/2021 12:12 AM, Elijah Newren wrote:
> On Fri, Apr 23, 2021 at 2:34 PM Derrick Stolee via GitGitGadget
> <gitgitgadget@gmail.com> wrote:
>>
>> This is the first "payoff" series in the sparse-index work. It makes 'git
>> status' very fast when a sparse-index is enabled on a repository with
>> cone-mode sparse-checkout (and a small populated set).
> 
> I read through the topic, both my old comments, the range-diff, and
> the new patches where the range-diff wasn't enough.  I tried to spot
> issues, and was hoping to find problems you alluded to in your recent
> comments at https://lore.kernel.org/git/05932ebc-04ac-b3c5-a460-5d37d8604fd9@gmail.com/,
> but I failed to spot them.  I hope it has to do with the cache bottom
> stuff that I just don't understand, because otherwise I just missed
> the problems in my review.  I can say that in v2 you fixed the issues
> I did spot in my review of v1.
> 
> I'll look forward to v3 to see what it was I missed.  If I somehow
> don't respond soon (in a week at the latest), do feel free to ping me;
> sorry for somehow having this one slip through the cracks.

v3 is on the way. The changes related to issues I found in my
deeper testing are more about what wasn't previously tested in
my test script as opposed to things actually being wrong in
the patch series. (There is one case where some new code was
incorrect, but it wasn't being tested because of the test repo's
data shape.)

Thanks,
-Stolee
