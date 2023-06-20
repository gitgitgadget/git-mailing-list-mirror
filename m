Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E140CEB64D8
	for <git@archiver.kernel.org>; Tue, 20 Jun 2023 13:43:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233062AbjFTNnz (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 20 Jun 2023 09:43:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43158 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232963AbjFTNnw (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 20 Jun 2023 09:43:52 -0400
Received: from mail-yb1-xb33.google.com (mail-yb1-xb33.google.com [IPv6:2607:f8b0:4864:20::b33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB3BF1701
        for <git@vger.kernel.org>; Tue, 20 Jun 2023 06:43:48 -0700 (PDT)
Received: by mail-yb1-xb33.google.com with SMTP id 3f1490d57ef6-bad0c4f6f50so6885236276.1
        for <git@vger.kernel.org>; Tue, 20 Jun 2023 06:43:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=github.com; s=google; t=1687268628; x=1689860628;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=1zrtTHBCAkJdrgindZdRsrlq+72lEqIDkZxnr3SkYkI=;
        b=eseFbDc2ZIFe4j+3Z8PzTqZc9yHXW588pQh1bO55ik1VtZwHSGio2wVAnJSwKwSgts
         tAr7nXYFk4JQjvgxgTzuIBkXRd1GkFd9wJNRQIoj9qXwxxO3XlBdBeyDsrlgPgvhWsEq
         x6yM6bukSef2dX67r31/6Oss9MgbK0NLkQbYyv/nPUWBLKKP5cQ/JOxzNJbbz4XopNR1
         wp7AQAGieiSXnAxT4ctx3T9kkALsDIXj2TjJJZyGeH2wTq1Nf8YkfS3M2+WSpC3r9xQm
         XibEECoru5wgL5WHhG5n62PBab4sFi1nHdMThH7QhqL9x1sLdmNhVtlDSlphHBPG6Z7+
         dSGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687268628; x=1689860628;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=1zrtTHBCAkJdrgindZdRsrlq+72lEqIDkZxnr3SkYkI=;
        b=X62gvAvLdPwHlBzrCTOlKxRdHRp3awb0joGSEUwnGN3aSlAvBCNV6OGtHVG3RdrEV1
         PthJClGW/T8KAF3KjpfRXT66/KrBNGSAakS+MTz8ajP7t+6n+X6HULiBvOtG9k/oxcmO
         dXqiQRNGwjSGYKsxYkjIhqcRMTDNH7DMuOgTFJfAwkIaXdlXx976v2k61tvXIXXuMexM
         /SYeFQbEefvjrSovsARivSyIPixWbBLYTsQ4bAewyn3RdsWmkmmNMTveVxDBeGr0dyGi
         3Hla95Ql+BghW9Q/niebBlvE3ftRswFEIUiXPotKagWrl1KUs+l7f2iZEtd5jnm3DAys
         nYuw==
X-Gm-Message-State: AC+VfDx7ijM6Woh8ZrIKjDHcLwOK1ZG75Fs61O2ru7nbWQqq2CzW7PmU
        23ZMqUtLbMAjvTs4rBEJ9K33
X-Google-Smtp-Source: ACHHUZ6PtnY8f0NnIl4jVXzopNWaaoQyZVCMfw24U0NI6H1J7L8NyY7eL+x1BwF8CxkMKUVKO6SVlA==
X-Received: by 2002:a25:468b:0:b0:be5:521c:b3f1 with SMTP id t133-20020a25468b000000b00be5521cb3f1mr9877257yba.2.1687268627865;
        Tue, 20 Jun 2023 06:43:47 -0700 (PDT)
Received: from ?IPV6:2600:1700:e72:80a0:e8fd:3e8c:8558:4cd? ([2600:1700:e72:80a0:e8fd:3e8c:8558:4cd])
        by smtp.gmail.com with ESMTPSA id j129-20020a25d287000000b00bcfc06681besm361301ybg.60.2023.06.20.06.43.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 20 Jun 2023 06:43:47 -0700 (PDT)
Message-ID: <c7b66d2c-cdc3-1f0f-60a0-a2ee21c277bf@github.com>
Date:   Tue, 20 Jun 2023 09:43:46 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH v4 0/4] Changed path filter hash fix and version bump
Content-Language: en-US
To:     Junio C Hamano <gitster@pobox.com>,
        Jonathan Tan <jonathantanmy@google.com>
Cc:     git@vger.kernel.org, Ramsay Jones <ramsay@ramsayjones.plus.com>
References: <cover.1684790529.git.jonathantanmy@google.com>
 <cover.1686677910.git.jonathantanmy@google.com> <xmqq5y7r5fsx.fsf@gitster.g>
From:   Derrick Stolee <derrickstolee@github.com>
In-Reply-To: <xmqq5y7r5fsx.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 6/13/2023 3:21 PM, Junio C Hamano wrote:
> Jonathan Tan <jonathantanmy@google.com> writes:
> 
>> Thanks Ramsay for spotting the errors and mentioning that I can use
>> octal escapes. Here's an update taking into account their comments.
> 
> The changes look good.  Will queue.
> 
> Stolee, you had comments on an earlier round---how does this one
> look?

I'm sorry I'm so late to this. I've been meaning to get to it, but
it's been a crazy couple of weeks.

This version is not ready. The backwards compatibility story is
incomplete.

When commitGraph.changedPathsVersion is set, it does not allow
reading a previous filter version, leaving us in a poor performance
state until the commit-graph file can be rewritten.

While I was reviewing, it seemed reasonable to deprecate
commitGraph.readChangedPaths, but this use of "also restrict writes
to this version" didn't make sense to me at the time. Instead, it
would be good to have this clarity between the config options:

 commitGraph.readChangedPaths: should we read and use the filters
 that exist on disk? Defaults to 'true'.

 commitGraph.changedPathsVersion: Which version should we _write_
 when writing a new commit-graph? Defaults to '1' but will default
 to '2' in the next major verion, then '1' will no longer be an
 accepted value in the version after that.

The tricky part is that during the commit-graph write, you will
need to check the existing filter value to see if it matches. If
not, the filters will need to be recomputed from scratch. This
will change patch 4 a bit, but it's the right thing to do.

Thanks,
-Stolee

