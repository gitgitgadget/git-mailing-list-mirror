Return-Path: <SRS0=Rptp=ZP=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56E9FC43141
	for <git@archiver.kernel.org>; Sat, 23 Nov 2019 09:54:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2981C20714
	for <git@archiver.kernel.org>; Sat, 23 Nov 2019 09:54:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="tiJUBpMr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726620AbfKWJyx (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 23 Nov 2019 04:54:53 -0500
Received: from mail-wm1-f68.google.com ([209.85.128.68]:55421 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726141AbfKWJyx (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 23 Nov 2019 04:54:53 -0500
Received: by mail-wm1-f68.google.com with SMTP id b11so10029029wmb.5
        for <git@vger.kernel.org>; Sat, 23 Nov 2019 01:54:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=reply-to:subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=MTdM5R+tsriO3FD6WqnZmbrwHvtArvCKZXe2kn4Xd1w=;
        b=tiJUBpMrzRkd3HCMlbBWuACX3lAlU2ZjyyuxnWNKB1ESWS2a6EVZi7NYNNLpOvs9w0
         Cqk96dj7UFlJ7oXt9q6jLVJvTxOu6aVtssIofYf5aT79qwigsVbsfSZN8M5w2I6AKOzt
         SMtOyVV6CuCr7wfTt88BFque8wh9M+78luSPQkPAry2cG7KYXbeSHRC3nmUC7+vjcsVW
         SMB3NjaEPEyBt6VDxazL/ugMLOzicbDpMHnQoUwtTCGuxP+ptZk3L0bJninZuA7DuIQN
         07StrJQUPttK4zzEj8cQAv8BP+5aFw8D0a2mM0/X73/X7WWWJuMYTjm/cySSt8i0IEko
         br2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:reply-to:subject:to:cc:references:from
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=MTdM5R+tsriO3FD6WqnZmbrwHvtArvCKZXe2kn4Xd1w=;
        b=BCRYX+Bh0ZYLOkoGGJ2zYxoyUO/QiVRtE05OzczRwtAER+wwRt5DcH2YzSU2DLI8x/
         4yozHn/edMcIuFqQJbh6pULgDNZM6jLr0s1tJONEInTeiaa6IK61sjM7f8XZUZrEX/ND
         9EsY4VEw+/2wjMqLHLGZsICReQViFfN9pf8k/z9zP3XUoZbFeGZJTIco54QtkEHJckTs
         suxiSBHp8HR3IYwSoSO/DGOkhHT1yUm0aukUY+LviROt3Cu5nc0EcfNIuU2+kt7wZUNx
         2Y4uu3OssM5earnSDPQ4ds1lff+075WRZg2HAtZ/AfJLN12ixr8zJw8c0PNm4CEZC0bp
         FhAQ==
X-Gm-Message-State: APjAAAWN1kIhGWtRBVAqT3OisImdlMypTe1UpMGKjYTl7n+Vw1M3OztQ
        O2YHNCR+qkNe5/OG6axkHj4=
X-Google-Smtp-Source: APXvYqzPNGee/9PdhTpUVQaw0A6cvHq7lL0VPQMqZLaaPiRi9tJOimnwyOxcwcCX/+UPij0s3tOzoA==
X-Received: by 2002:a1c:9e58:: with SMTP id h85mr21190790wme.77.1574502891026;
        Sat, 23 Nov 2019 01:54:51 -0800 (PST)
Received: from [192.168.2.240] (host-92-22-28-211.as13285.net. [92.22.28.211])
        by smtp.gmail.com with ESMTPSA id g8sm1319254wmk.23.2019.11.23.01.54.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 23 Nov 2019 01:54:50 -0800 (PST)
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH v2 1/1] sequencer: fix empty commit check when amending
To:     Junio C Hamano <gitster@pobox.com>,
        Phillip Wood via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Phillip Wood <phillip.wood@dunelm.org.uk>
References: <pull.467.git.1574345181.gitgitgadget@gmail.com>
 <pull.467.v2.git.1574451783.gitgitgadget@gmail.com>
 <037f2b2975e06847443aef46939e3c712053dedf.1574451783.git.gitgitgadget@gmail.com>
 <xmqq5zjb2vsx.fsf@gitster-ct.c.googlers.com>
From:   Phillip Wood <phillip.wood123@gmail.com>
Message-ID: <340859a7-5cc4-f641-818d-fcedbf29a2a6@gmail.com>
Date:   Sat, 23 Nov 2019 09:54:49 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.0
MIME-Version: 1.0
In-Reply-To: <xmqq5zjb2vsx.fsf@gitster-ct.c.googlers.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB-large
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio

On 23/11/2019 02:03, Junio C Hamano wrote:
> "Phillip Wood via GitGitGadget" <gitgitgadget@gmail.com> writes:
> 
>> +	if (!(flags & ALLOW_EMPTY)) {
>> +		struct commit *first_parent = current_head;
>> +
>> +		if (flags & AMEND_MSG) {
>> +			if (current_head->parents) {
> 
> It is not apparent to me that somebody guarantees that this access
> is safe; would we need to do things differently when !current_head?

That's a good point, I'll fix it, thanks for catching this

Best Wishes

Phillip

> 
>> +				first_parent = current_head->parents->item;
>> +				if (repo_parse_commit(r, first_parent)) {
>> +					res = error(_("could not parse HEAD commit"));
>> +					goto out;
>> +				}
>> +			} else {
>> +				first_parent = NULL;
>> +			}
>> +		}
