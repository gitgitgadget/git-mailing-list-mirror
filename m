Return-Path: <SRS0=3T2S=5I=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E137C3F2CD
	for <git@archiver.kernel.org>; Mon, 23 Mar 2020 18:21:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 32B0F2051A
	for <git@archiver.kernel.org>; Mon, 23 Mar 2020 18:21:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GafIJ3ug"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727470AbgCWSVa (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 23 Mar 2020 14:21:30 -0400
Received: from mail-ot1-f68.google.com ([209.85.210.68]:44466 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727091AbgCWSVa (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 23 Mar 2020 14:21:30 -0400
Received: by mail-ot1-f68.google.com with SMTP id a49so14386151otc.11
        for <git@vger.kernel.org>; Mon, 23 Mar 2020 11:21:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=PUX4/8QJ19WYqA1zZ1/P8qDt8D89PmOhNbnRqkjgWj0=;
        b=GafIJ3ugO9a2wcbgbH8k3syFNzQGbqb9q9oLrwdAJwEHDNBhKlg2bg6WIaYcA/o0N+
         3jcysLxxoDgrCVuA43TB6OGoS9+8CM3i+bMhEA3NlVD/nJpmioozMpz+diXMzWAqtUAj
         tGJhMiWyikgcFTSsSSYiolNeuii6HNaf7FSirzWrt8h6ilI4S1ZSHVBc9vZE08WGnQh+
         Gw7BNrXOqoV0zp66qPmz5y4ha6vQAJbOxw/Hsn9d1vwvP+O1QbGz6FFHralajVaj+wSZ
         3rUsxTuXFg+mvGnSmbQEufPMOvFh6y5ed+zcEy/1crUXaDkv9fwYZaJN1ke8rTrKxRIT
         VRtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=PUX4/8QJ19WYqA1zZ1/P8qDt8D89PmOhNbnRqkjgWj0=;
        b=ah8MoYl92/6DaWAO3hbf2hx1kRTIErSzyS2x6grIsq/guh449yPcjICup68FCsKuuu
         FTFrlv17GrZvvLTiSLKP6v3eAK9F78GafAT57lz5TK90gDCzjGVDcpmRZNxfRmMtYTHQ
         /k43PjU5jdzwPzLeDREGKpBcFQSYB5KcUTqqpp4DCGpm3NVy7PSI0gzy60zbHY9ecA8T
         feLPWTonHxbZv7/Dp1OEB2ugR0TfUf5yzVx9mFaF1BKnBDUG7fvsENDGYmXDFV8f7Uvc
         VsTv6mf9lEn7CcHZBFvaIV9tI47TZz+dbA5zCmVQFz9Y35k8txEU4EiKsyEbzNa4gIb9
         6mfw==
X-Gm-Message-State: ANhLgQ2WBwhmPf14aXdaZ8KSaiAan7JFkeQ7LTECzE/n6jO9hR1tpG5j
        2kotRJ3/QqJgqr2aaamOyEE=
X-Google-Smtp-Source: ADFU+vtFc5g93y0VbCv1h4XSxH4kYx/JhUK27DO/Csx6W+F/iyPRZTx0kQTvuSoExmgvLI8PJ0F5Ww==
X-Received: by 2002:a9d:5e06:: with SMTP id d6mr19525981oti.311.1584987689097;
        Mon, 23 Mar 2020 11:21:29 -0700 (PDT)
Received: from [192.168.1.83] ([99.85.27.166])
        by smtp.gmail.com with ESMTPSA id f45sm928603otf.30.2020.03.23.11.21.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 23 Mar 2020 11:21:28 -0700 (PDT)
Subject: Re: [PATCH v2 09/18] unpack-trees: add a new update_sparsity()
 function
To:     Elijah Newren <newren@gmail.com>
Cc:     Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Derrick Stolee <dstolee@microsoft.com>
References: <pull.726.git.git.1584169893.gitgitgadget@gmail.com>
 <pull.726.v2.git.git.1584813609.gitgitgadget@gmail.com>
 <a46439c8536f912ad4a1e1751852cf477d3d7dc7.1584813609.git.gitgitgadget@gmail.com>
 <9501e018-fe87-16b8-b0d8-913e4331778d@gmail.com>
 <CABPp-BF7=jJ2fWFcriC3E0=ZrUWawXoLbz659jtYdtkTJ4we_w@mail.gmail.com>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <5a83259e-af03-1930-a62b-75ad37b05f37@gmail.com>
Date:   Mon, 23 Mar 2020 14:21:27 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:75.0) Gecko/20100101
 Thunderbird/75.0
MIME-Version: 1.0
In-Reply-To: <CABPp-BF7=jJ2fWFcriC3E0=ZrUWawXoLbz659jtYdtkTJ4we_w@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 3/23/2020 2:10 PM, Elijah Newren wrote:
> On Mon, Mar 23, 2020 at 11:02 AM Derrick Stolee <stolee@gmail.com> wrote:
>>
>> On 3/21/2020 2:00 PM, Elijah Newren via GitGitGadget wrote:
>>> +enum update_sparsity_result {
>>> +     UPDATE_SPARSITY_SUCCESS = 0,
>>> +     UPDATE_SPARSITY_WARNINGS = 1,
>>> +     UPDATE_SPARSITY_INDEX_UPDATE_FAILURES = -1,
>>> +     UPDATE_SPARSITY_WORKTREE_UPDATE_FAILURES = -2
>>> +};
>>> +
>>
>> Is there a reason this isn't located just before
>> update_sparsity()?
> 
> You mean move it to unpack-trees.c?  If I did that, the code in
> sparse-checkout.c that uses two of these values would fail to compile.

No, I just meant the function declaration below in unpack-trees.h.

>>> +int update_sparsity(struct unpack_trees_options *options);
>>> +
>>
>> This appears to not use the enum as it should.
> 
> Whoops!  Will fix.  (Interesting that the compiler didn't flag any
> kind of warning based on mismatch of declared function return types
> for update_sparsity() in the .c and .h files...)

*shrug* enums are essentially decoration over an int, so I'm not
surprised it can happen.

-Stolee
