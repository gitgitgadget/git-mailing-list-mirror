Return-Path: <SRS0=IlH6=24=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29DD0C33C8C
	for <git@archiver.kernel.org>; Tue,  7 Jan 2020 12:22:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 018C82081E
	for <git@archiver.kernel.org>; Tue,  7 Jan 2020 12:22:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PbJxmtxZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727913AbgAGMWK (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 7 Jan 2020 07:22:10 -0500
Received: from mail-qk1-f174.google.com ([209.85.222.174]:34227 "EHLO
        mail-qk1-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728204AbgAGMWK (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 7 Jan 2020 07:22:10 -0500
Received: by mail-qk1-f174.google.com with SMTP id j9so42824651qkk.1
        for <git@vger.kernel.org>; Tue, 07 Jan 2020 04:22:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=QQIxBl+6lb1s6VUDYAtwTTVQVZ+kcTGLMyZJTlp7ppE=;
        b=PbJxmtxZIul5oL9ohYlQYJZXFjLeMpWAyurR9UYEhYGfFJqw7RfPwEjysC4lHEBhlj
         M7o6dzEUyd16IhY6QYPCb+qNfuJgtGdkem6gS6XTq0GS3aVYI311I+FAztkKZo9xne36
         bNr4Piy7aVYv3UNhUucHPvmdbV+4qlLXLPAYdoKZtm6fUtoX46kP8OyKRbzqPP4KavFv
         W+fD83Rc7466pPucqHi8EBdfrmF0eSxvxJxIXIYqxAF022+iBNqRxZwBfPsyVmksF4Rp
         ObI1ceAe9burKErOCQ1Shx55tAHMfyBrq2sAFwhkvGHjkP6VeDbdQhKa00YHpLQOLpfs
         7xmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=QQIxBl+6lb1s6VUDYAtwTTVQVZ+kcTGLMyZJTlp7ppE=;
        b=mszxWgVaBZdVAoU/YFurRDpzJwbAr+i90QIg2LygkAZp4+vCEQ47KDxTvUE221DJSQ
         7jOGfgQsVQiDdGmvWjTXMsK6DBE7DWBko1rMK0YOG8bxb2KDC6iUDH4c8CWsdijxWe0o
         353JP/ptOEc2u8yVnmhF9PWPehl/BU1qMtWqyyCz4JDZKZKnQItnC8kRxVUpyi38OG/F
         0tyfAaCxLnTm8oWnBmY+FmjEm1JgmUMZpfN+6Mv5l4GDHqQULmrJad13Xo960252uELV
         NYxaCPnTo2PHtcd3jTC5ptzVRyyHHn/GalBGoTS/1F+YDNtjACK/+dC1blSRDGpA8vKR
         W1lg==
X-Gm-Message-State: APjAAAWlkUoyTDLAXrEyrFGg7TM6Rrgv6AmHtM5QO86w0Q0CWtEtcqIM
        DTydvZnKHAbapfiFxtPPRvnjNTmb
X-Google-Smtp-Source: APXvYqxCfWFPLnYbBEgy/A1TeW9IFeI+AYaFxVW4VeP5Va/Zia77RIe5WUYBWSuxDXuLiZpRx/e3rQ==
X-Received: by 2002:a05:620a:74f:: with SMTP id i15mr90026192qki.93.1578399728490;
        Tue, 07 Jan 2020 04:22:08 -0800 (PST)
Received: from ?IPv6:2001:4898:6808:13e:4018:daf7:6551:6995? ([2001:4898:a800:1010:f14d:daf7:6551:6995])
        by smtp.gmail.com with ESMTPSA id x24sm25302511qtx.1.2020.01.07.04.22.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 07 Jan 2020 04:22:08 -0800 (PST)
Subject: Re: Assertion in git log graphing [regression in v2.25]
To:     Jeff King <peff@peff.net>, Bradley Smith <brad@brad-smith.co.uk>
Cc:     Junio C Hamano <gitster@pobox.com>,
        James Coglan <jcoglan@gmail.com>, git@vger.kernel.org
References: <CAHt=fUXTHc4JPsapvHKnw5vHhp2cBOYRNfdaSDWBUnKt8fWfeA@mail.gmail.com>
 <20200107114812.GE1073219@coredump.intra.peff.net>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <d694a5b5-9c88-0a34-b9fd-050e5e02c312@gmail.com>
Date:   Tue, 7 Jan 2020 07:22:07 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:72.0) Gecko/20100101
 Thunderbird/72.0
MIME-Version: 1.0
In-Reply-To: <20200107114812.GE1073219@coredump.intra.peff.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 1/7/2020 6:48 AM, Jeff King wrote:
> On Tue, Jan 07, 2020 at 11:24:50AM +0000, Bradley Smith wrote:
> 
>> The following git repository (https://github.com/brads55/git-testcase)
>> causes an assertion when running:
>>
>>   $ git log --oneline --graph --all
>>
>>   git-log: graph.c:1228: graph_output_collapsing_line: Assertion
>> `graph->mapping[i - 3] == target' failed.
> 
> Thanks for the report, and especially for providing a reproduction case!
> 
> The problem is new in the v2.25 release candidates, so we should try to
> deal with it before the release.
> 
>> The assertion seems to be caused by commit
>> 0f0f389f12029b1c3745f8ed7aacfe6b2fc7a6cc. The graph structure of the
>> above repository is as follows (as produced by v2.24.1):
> 
> Yeah, I can confirm that this introduces the problem. I admit to not
> following the recent graph changes too closely, so I'll add James to the
> cc for attention.

I'm also going to take a look this morning, starting by creating a test.
I reviewed what I could of James' patch series, but I was also unfamiliar
with graph.c and relied on his very substantial test cases to verify the
correctness. Looks like a corner case got missed.

Thanks,
-Stolee

