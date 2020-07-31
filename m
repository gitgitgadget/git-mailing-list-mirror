Return-Path: <SRS0=dkLL=BK=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE3FFC433E1
	for <git@archiver.kernel.org>; Fri, 31 Jul 2020 19:31:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 88F50208E4
	for <git@archiver.kernel.org>; Fri, 31 Jul 2020 19:31:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kTXP1cZH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729570AbgGaTb2 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 31 Jul 2020 15:31:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40648 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726726AbgGaTb1 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 31 Jul 2020 15:31:27 -0400
Received: from mail-ej1-x641.google.com (mail-ej1-x641.google.com [IPv6:2a00:1450:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0AE5EC061574
        for <git@vger.kernel.org>; Fri, 31 Jul 2020 12:31:27 -0700 (PDT)
Received: by mail-ej1-x641.google.com with SMTP id d6so18665079ejr.5
        for <git@vger.kernel.org>; Fri, 31 Jul 2020 12:31:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=3ZHr1LVZNksQlg1VFUnqfZ3grK7SNKLZwiNyQhFoTog=;
        b=kTXP1cZHm/MaDdRCdOdsCt5pB9/k+8E13H76Fm3EsY0lOxQ6KcOuyIL2OZwRj1mxK4
         chZxufM8DxhHoKCEE2dW3XqyZoggS2mq4zXWikbC2bTUIjMdiucH3iqrWNbdpW0G0Uzo
         NPvN9wpyBkDsQDJescrlFKzDKEKuN4mTURcHc+vfimstsuYZFsUpdV/ULHtA2TKC4XPv
         /dMuuT8lSkjbHFSXfjfEie9yivcCV16UtTsWmd/czVma6azklN7boAhBBXUKzy/PuE5Z
         c5tLoFFWH9Ju3NW0DphUkedxLLQaLDKHiREc5GRpcMqQFrtCiCWQ2cvARe7BNO8TNlvj
         Ow3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=3ZHr1LVZNksQlg1VFUnqfZ3grK7SNKLZwiNyQhFoTog=;
        b=P3syu+gnc+wv2JdimzNaDAor2Zd8Tl7mndPqNiJw0wpEHK+gZuRRogVNCHQjVFVMOq
         zyaG5aa/Gbc30eUqb1i7WGonxAC8kYyiX1WLVnmWIfZW5+pzchOlU/vX1W01fTBAvgLp
         CNGzvMcxXoc/ZR/J3K9mQ6b7IHzBk34SNYJuBdnSoHjMtWe8QZE/LUA6W1c+wvJVt/Om
         CimW+bpK9nQaasR7Q1hasFMUhu27AdQyskS+shJOLoeLTnTGsgQSIsCcvdvxhoKbEmLF
         iK7DQAROMN/ou7yl8DNpp3vQF9lW/ttFQ3VOqRXuSUlNRDwZJGXuOJKYzo2sCfOImUJo
         4gRw==
X-Gm-Message-State: AOAM533vJVjYTY27iKlrlWpKxl9LxsTCbwg61VN0MXNLXryuzP32TmAd
        MqD5+Jw6ZNsX78UKvVC5LjE=
X-Google-Smtp-Source: ABdhPJzlWqeEIkpfwbwJotJTXrQ55NhWlrvkadtfZBnP66NzlH2S54mq/CgM4cfFjBS2ESrXmfh0jQ==
X-Received: by 2002:a17:906:4aca:: with SMTP id u10mr3787010ejt.320.1596223885728;
        Fri, 31 Jul 2020 12:31:25 -0700 (PDT)
Received: from ?IPv6:2a02:a210:ca2:9c00:a841:62ef:78bb:55a5? ([2a02:a210:ca2:9c00:a841:62ef:78bb:55a5])
        by smtp.gmail.com with ESMTPSA id r25sm9843874edy.93.2020.07.31.12.31.25
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 31 Jul 2020 12:31:25 -0700 (PDT)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 13.4 \(3608.120.23.2.1\))
Subject: Re: [PATCH] commit-graph: add verify changed paths option
From:   Son Luong Ngoc <sluongng@gmail.com>
In-Reply-To: <20200731191448.GA848793@coredump.intra.peff.net>
Date:   Fri, 31 Jul 2020 21:31:23 +0200
Cc:     Taylor Blau <me@ttaylorr.com>,
        Son Luong Ngoc via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Content-Transfer-Encoding: 7bit
Message-Id: <E6157D6A-52FB-4E0D-BFE7-8F3B0848F8A3@gmail.com>
References: <pull.687.git.1596181765336.gitgitgadget@gmail.com>
 <20200731180235.GA846620@coredump.intra.peff.net>
 <20200731180956.GA60133@syl.lan>
 <20200731191448.GA848793@coredump.intra.peff.net>
To:     Jeff King <peff@peff.net>
X-Mailer: Apple Mail (2.3608.120.23.2.1)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Note: re-send  to mailing list due to me forgot to turn on Plain Text format.
(sorry for the noise)

Hi Peff, Taylor, Junio and Christian,

Thanks a lot for the valuable feedbacks.
This is exactly what I was hoping for by sending out the patch early!

> On Jul 31, 2020, at 21:14, Jeff King <peff@peff.net> wrote:
> 
> On Fri, Jul 31, 2020 at 02:09:56PM -0400, Taylor Blau wrote:
> 
>>> Is a single boolean flag sufficient? If you have incrementals, you might
>>> have some slices with this chunk and some without. What should the
>>> boolean be in that case?
>> 
>> I think you'd really want to know which layers do and don't have
>> filters. It might be even more interesting to have a tool like what 'git
>> show-index' is to '*.idx' files, maybe something like 'git show-graph'
>> or 'git show-commit-graph'. Its output would be one line per commit that
>> shows:
>> 
>>  - what layer in the chain it's located at
>>  - its graph_pos
>>  - its generation number
>>  - whether or not it has a Bloom filter
>>  - ???
>> 
>> That would be a useful tool for debugging anyway, even outside of the
>> test suite. It would be even better if we could replace the test-tool
>> with it.
> 
> Yeah, that was exactly what I had in mind, except that I'd make it a
> sub-command of "git commit-graph" ("show" or perhaps "dump").

I loved Junio's initial suggestion and the follow up here.
I was thinking of something like 'git commit-graph verify --verbose' but 
now I agree that a distinct command such as 'show' might be more 
distinct and better communicate the purpose.

I will stick with my poor-man bash/golang script for now to invalidate
the commit-graph (chain or no-chain) as it does the job just fine.

Let me see if I have the capacity to implement 'show' sub-command
after. ^_^!

> 
> -Peff

Cheers,
Son Luong.
