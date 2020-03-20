Return-Path: <SRS0=v+yc=5F=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0301AC4332B
	for <git@archiver.kernel.org>; Fri, 20 Mar 2020 21:15:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C188D20767
	for <git@archiver.kernel.org>; Fri, 20 Mar 2020 21:14:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="j39p3oES"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727118AbgCTVO6 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 20 Mar 2020 17:14:58 -0400
Received: from mail-qk1-f195.google.com ([209.85.222.195]:35629 "EHLO
        mail-qk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726974AbgCTVO6 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 20 Mar 2020 17:14:58 -0400
Received: by mail-qk1-f195.google.com with SMTP id d8so8622414qka.2
        for <git@vger.kernel.org>; Fri, 20 Mar 2020 14:14:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=asw+cs5xqga6oeVwiofZyiRktErFqet3Jhg2tJJ6yVI=;
        b=j39p3oESUfDM/xsyB0WfZda0DcNe5AmQdyJ1sqYmEcqirDSnCg/EAyPwqYwUjvWUyG
         b6o2XvvFw58DXSCgZrSoftEtIBPgWqSToB/6AOekY20qVFls0JH9hB1G1je9Pwepod2C
         pra1oCY8pqgzG7mDq+DDCSKgw9nDHoIsmz09pcwuc3IpBoIvZBVWy+OyAL3g0/FjOYuB
         OJSzodDFx0HeaRPVYq5fNAwBdqU5zsjKzWFdzmyqOpbEpyLzdxPq1SmxqMzI4lsm9tjC
         ibP1D7zFBrh6Lr1lN+6GaKgKsPXQNKkMKCW88cgoDo89o6ybCIewU5osiLQ360mitn0y
         aw9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=asw+cs5xqga6oeVwiofZyiRktErFqet3Jhg2tJJ6yVI=;
        b=nbhQrX+G1qNnv3O49PflPqMG4Sg6nMwBmP0VUQOw4GOnxg0J0cBp2KuveSztJu8xdo
         PZWrO8D8UgmsVE3I1Fv3CclFPZl02wToAXeDjC6DkolrbM12Qx/yqS07nUdPMpezPRkp
         ZIG+R+VWyfjwXOpbCUzXV4opGCgbnNgUNJCIv5JONOQ2Fv8y3ctLYw9JywGqZ8csGsG/
         5t5qLq5Uahy3d1qUkkUBL5HUpr6ojX66TQr2XLpD/aJIm4wsooR1+FSH4fhHZw9ERtBk
         3peGKc4DueK11umw9UCCXlfa/LdlMGPF8Osy6nPWUzrDerxFWE8cINHhLUGrl3aydiHA
         EYjw==
X-Gm-Message-State: ANhLgQ3ZZvJ2aPDfwiBJzpzPqW6oLhXu8z/dMlQVGdyIiFQBHwnRROHi
        i6AILfQJemtYRHYE6N0XiMw=
X-Google-Smtp-Source: ADFU+vsNnRSSJK1USxBfQHCRMDisb0lggP01Ihs3vhqwjzqEWgIkAgEaAUa1IV+mT2EjNmtAJPwbgw==
X-Received: by 2002:a37:e40d:: with SMTP id y13mr10178329qkf.39.1584738897232;
        Fri, 20 Mar 2020 14:14:57 -0700 (PDT)
Received: from [192.168.1.76] ([99.85.27.166])
        by smtp.gmail.com with ESMTPSA id r29sm5873356qtj.76.2020.03.20.14.14.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 20 Mar 2020 14:14:56 -0700 (PDT)
Subject: Re: [PATCH v2] config: set pack.useSparse=true by default
To:     Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, me@ttaylorr.com, jrnieder@gmail.com,
        Derrick Stolee <dstolee@microsoft.com>
References: <pull.585.git.1584583110914.gitgitgadget@gmail.com>
 <pull.585.v2.git.1584707247753.gitgitgadget@gmail.com>
 <xmqqmu8abvuf.fsf@gitster.c.googlers.com>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <e35c1bc5-7569-defc-2cee-e47039506521@gmail.com>
Date:   Fri, 20 Mar 2020 17:14:56 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:75.0) Gecko/20100101
 Thunderbird/75.0
MIME-Version: 1.0
In-Reply-To: <xmqqmu8abvuf.fsf@gitster.c.googlers.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 3/20/2020 4:43 PM, Junio C Hamano wrote:
> "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com> writes:
> 
>>     Here is a small patch to convert pack.useSparse to true by default. It's
>>     been released for over a year, so the feature is quite stable.
> 
> I would not say anything more than "its' been released for over a
> year, so the feature is known not to cause problems when it is not
> enabled (in other words, we coded our if/else correctly)", unless
> some telemetry tells us that significant number of users with widely
> differing use patterns have enabled it and are not seeing much
> negative effect.  And we can tell if it is stable only if we flip
> the default.

True. I've done my best to advertise the feature but have heard very
little from users about it outside of our "captive audience" in the
Windows OS team. I've also been using it myself (as part of
features.experimental) on all of my machines, but that's hardly a
vote for rigorous use in strange patterns.

>> I'm submitting this now to allow it to cook for a while during the
>> next release cycle.
> 
> I agree that it is about time to see if flipping of default would be
> a good move for users whose usage patterns are unlike VFS for Git by
> cooking a change like this in 'next', definitely at least a cycle
> but possible a bit more, and it is a good idea to have it at the
> beginning of the next cycle.  Very much appreciated.

I'm happy to let you decide when this has cooked long enough. If
you feel that more than one cycle is needed, then absolutely let's
be cautious here.

Thanks,
-Stolee
