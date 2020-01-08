Return-Path: <SRS0=ZiOn=25=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26B7AC282DD
	for <git@archiver.kernel.org>; Wed,  8 Jan 2020 20:05:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F18312073A
	for <git@archiver.kernel.org>; Wed,  8 Jan 2020 20:05:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="c3tE+wEL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726525AbgAHUFx (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 8 Jan 2020 15:05:53 -0500
Received: from mail-qt1-f195.google.com ([209.85.160.195]:38181 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725835AbgAHUFx (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 8 Jan 2020 15:05:53 -0500
Received: by mail-qt1-f195.google.com with SMTP id n15so3863517qtp.5
        for <git@vger.kernel.org>; Wed, 08 Jan 2020 12:05:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=o1pRgoh5wGPmUV1PNXsMhBLNbhDmFZ8YEY37BdPrSN4=;
        b=c3tE+wELhWy69b33S07egqgEQwOrMKwCvrFX8GmAD5oGhJjA9j7+kK0SkrVv5/hCJR
         WEVb7eSiPf+u8y+7IHl7RyezUozlAamzlsPIscxeLT2VuoBOpL3AE2ZyYq6l4sKGW+UH
         MJ+xXRq1ymUekk/HX54dP+S/dMXnS8dEYvTTxviJa5Au2s0ubdF60DC0qZloM+AY9AgE
         oLJPGjTH7M3z57GkFrJtIg07dOQZDA2VmostUVgLTQaPBOVb5wWqtMuuHJJzXYvQogOK
         Wqmku3CknFOtwOKWXn8ik1qcwTU9xv9Hx2WLZpQUeJX+i5RF8mji+bXRDzJiTtmArNL4
         AYZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=o1pRgoh5wGPmUV1PNXsMhBLNbhDmFZ8YEY37BdPrSN4=;
        b=E5jJe8yGhV3WD2RTBOdcIJq3YI0zdNC6m47g5fcwLHouxYJxgm8JGblSlMgZQ3znOD
         cWW799XSiGfC84mbxub0CL7bcUIOYuhuwVayelrgvdyovrIxXdrQIBHd33XPSajth3X8
         nF1258qDQxV1TOgGlFwRWJRYD/0+wsCEHGsjYmJAyRm7pnVifGXjpMCfdZ/qMKqresO6
         nmSNV3dEu97KTQcYajigJoJe7ofzrhrR7vW+RgpnFMfsL0wtM3lkSzkXRfXi1RojwjzX
         2A9Uu7XHVBgXSld1hAJ/5TaaMX1yEuE6aXkZ/InolcHY4WAOgPPJN3EqlVtyeethhN67
         sRjw==
X-Gm-Message-State: APjAAAVcUJzaJkmPMTUVOJPtEjkogyILtuGUiwrhXrRyPMKBTOwr3tGc
        lML/lpslRJkzTaxxlsXXk0g=
X-Google-Smtp-Source: APXvYqyDl6xS+GUeqiVVjuUbxmPkN0FVCHDg3jrhoR3d0rZqwuwazZf5SEpDqutpPKHd4B0rWbUhnw==
X-Received: by 2002:ac8:3234:: with SMTP id x49mr5107889qta.209.1578513951783;
        Wed, 08 Jan 2020 12:05:51 -0800 (PST)
Received: from ?IPv6:2001:4898:6808:13e:3d10:d3f7:2db7:a1e2? ([2001:4898:a800:1010:ee45:d3f7:2db7:a1e2])
        by smtp.gmail.com with ESMTPSA id x6sm1882451qkh.20.2020.01.08.12.05.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 08 Jan 2020 12:05:51 -0800 (PST)
Subject: Re: [PATCH 0/2] Graph horizontal fix
To:     Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, peff@peff.net, jcoglan@gmail.com,
        Derrick Stolee <dstolee@microsoft.com>
References: <pull.518.git.1578457675.gitgitgadget@gmail.com>
 <xmqq5zhl3jrm.fsf@gitster-ct.c.googlers.com>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <c69afbe7-3a9c-0619-594f-f5ba980ae7b8@gmail.com>
Date:   Wed, 8 Jan 2020 15:05:50 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:72.0) Gecko/20100101
 Thunderbird/72.0
MIME-Version: 1.0
In-Reply-To: <xmqq5zhl3jrm.fsf@gitster-ct.c.googlers.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 1/8/2020 1:06 PM, Junio C Hamano wrote:
> "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com> writes:
> 
>> This depends on ds/graph-assert-fix.
>>
>> This is a non-critical (not needed for v2.25.0) response to the previous
>> discussions [1] [2].
>>
>> While working to resolve the fix for the assert() bug, I noticed this
>> regression when multiple edges wanted to collapse with horizontal lines. It
>> takes a reasonably large graph, but real projects are likely to demonstrate
>> this behavior.
>>
>> I arranged the series into two patches: 1. the (failing) test, and 2. the
>> fix.
>>
>> The fix commit includes some details about why the change to compress merge
>> commits caused this regression, and why I feel relatively confident that
>> this is a correct resolution.
> 
> I am not sure if this is "fix" of "bug" in that what is shown
> without 2/2 (iow, "before this change" in the description of 2/2) is
> "wrong" per-se---it is just that it leaves room to be made even more
> compact.  It still is an improvement, of course, though.

I guess I was incomplete in my first example. The full horizontal behavior
before 0f0f389f was

	| | | | | | *-.
	| | | | | | |\ \
	| |_|_|_|_|/ | |
	|/| | | | | / /
	| | |_|_|_|/ /
	| |/| | | | /
	| | | |_|_|/
	| | |/| | | 

and 0f0f389f added a compact merge commit, but lost two horizontal lines.

	| | | | | | *
	| |_|_|_|_|/|\
	|/| | | | |/ /
	| | | | |/| /
	| | | |/| |/
	| | |/| |/|
	| |/| |/| |
	| | |/| | |

This change brings the horizontal lines back.

	| | | | | | *
	| |_|_|_|_|/|\
	|/| | | | |/ /
	| | |_|_|/| /
	| |/| | | |/
	| | | |_|/|
	| | |/| | |

Whether this qualifies as a "bug" is debatable, for sure. That's why I
believe this change is below the bar for the release candidate.

Thanks,
-Stolee
