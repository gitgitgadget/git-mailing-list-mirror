Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 733DCC433EF
	for <git@archiver.kernel.org>; Thu, 23 Sep 2021 05:46:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 38A3B60FC1
	for <git@archiver.kernel.org>; Thu, 23 Sep 2021 05:46:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239185AbhIWFsA (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 23 Sep 2021 01:48:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229890AbhIWFr7 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 23 Sep 2021 01:47:59 -0400
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com [IPv6:2607:f8b0:4864:20::1032])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE840C061574
        for <git@vger.kernel.org>; Wed, 22 Sep 2021 22:46:28 -0700 (PDT)
Received: by mail-pj1-x1032.google.com with SMTP id lb1-20020a17090b4a4100b001993f863df2so4057269pjb.5
        for <git@vger.kernel.org>; Wed, 22 Sep 2021 22:46:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=oL8R5QmwL+flyY/NWlinuKa1s65MRnqgdY9aAR2yBO8=;
        b=dj+SFMWJlrfcZUDebFrkytZ/1hwF3COvXIXpjZxgEiQjONcQ86/WHgG+CeTc3DRHBS
         ijl0ysXmffPPYFPzwS+c/0ARNdYwVPVNFnLATXak2nl0A0/+Wv5+o1eZA2jUJXZwhjkc
         C8is6DSlEdGCbNxQNF+5fUlPJ3xW40LvzYHFGj9i8WOO4+nYXv7Ipjcx8hQsnpYc53p5
         +Bja4bWvNveay+r4odUFT/Xke6Yy2Tniarvr/rhFu8/9QTK0j679XcxiP1Aqkb6+bnNc
         hUYFmb9WNuu29RNITm1ymmyzaeHSHI1j4pil6zMRPZYw/BPNmaQJRdEB8btPzIdgzguj
         1e8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=oL8R5QmwL+flyY/NWlinuKa1s65MRnqgdY9aAR2yBO8=;
        b=Lr5lMqLoKp/0XTiXKzWdy0mKzJgnv27CrHcJMp/pgo0OOCOKm6J/7Uq9PRpvwU7WER
         jDmezJVsxm4mvYEYFnsSLhErcm5BPURq/wgOcCyNA/hhm0gB3EjHQNzE2sJcYyIBZiKI
         HEx0LBc8jdSkJ+pbVkmAE96b1JD1JCDoMX0NdjE0ZmdEgwVdVKGz65QbYhiP7Omlb3cK
         NQDu+Mjt5Oskcaoh/sfkqxAF624JNcm4tIU0guMitelh1WWCCc4p5PEkNT7hNdDkm6FO
         dthUQTNaZMg95GDTRI2H5WAQqL/Dt2cMOL5N/aexCOjb6EeFOypmPVI3boC6QJnPfCG1
         9Axg==
X-Gm-Message-State: AOAM5316PIMM60he5tiZo401ENI0l1unvr08gwM4ViGcFHHxvzD81YK8
        RTwjxI1W8JeQaLAw3Vbg2WHn9Us1dSupCw==
X-Google-Smtp-Source: ABdhPJwyllR1/7VuvWNgcl2OHZo6OXZPx7A8jD2tjJZPOt3ey2kjnEe8TC3Gtv45ivm82McyluwOxg==
X-Received: by 2002:a17:90b:4c09:: with SMTP id na9mr15830913pjb.172.1632375988070;
        Wed, 22 Sep 2021 22:46:28 -0700 (PDT)
Received: from [192.168.43.80] (subs09b-223-255-225-239.three.co.id. [223.255.225.239])
        by smtp.gmail.com with ESMTPSA id b6sm3974711pfo.98.2021.09.22.22.46.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 22 Sep 2021 22:46:27 -0700 (PDT)
Subject: Re: [PATCH v2] MyFirstContribution: Document --range-diff option when
 writing v2
To:     Philip Oakley <philipoakley@iee.email>,
        Glen Choo <chooglen@google.com>, git@vger.kernel.org
References: <20210913194816.51182-1-chooglen@google.com>
 <20210920223226.25877-1-chooglen@google.com>
 <77a8b8d9-4e13-8c5b-c313-512fc7c2c953@iee.email>
From:   Bagas Sanjaya <bagasdotme@gmail.com>
Message-ID: <7357be42-57d4-0ecd-5635-b42c5b5c4d59@gmail.com>
Date:   Thu, 23 Sep 2021 12:46:25 +0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <77a8b8d9-4e13-8c5b-c313-512fc7c2c953@iee.email>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 22/09/21 19.18, Philip Oakley wrote:
> Do we need a line to cover/suggest how the V2 to V3 follow up to further
> review commands are tweaked.
> 
> This sort of follows from the discussion about keeping the branch `psuh`
> as the working branch, and the `-v1`, -`v2`, `-v3` as the record of
> former submissions. The range-diff is then tweaked to be `--range-diff
> master..psuh-v<N>` where N is the last proper submission (just in case
> one version was a not-submitted dud).

Yes, the process is similar to v2.

-- 
An old man doll... just what I always wanted! - Clara
