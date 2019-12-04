Return-Path: <SRS0=IU/p=Z2=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94A65C43603
	for <git@archiver.kernel.org>; Wed,  4 Dec 2019 18:55:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5C7E720661
	for <git@archiver.kernel.org>; Wed,  4 Dec 2019 18:55:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iyAGHK7m"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728664AbfLDSz2 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 4 Dec 2019 13:55:28 -0500
Received: from mail-oi1-f195.google.com ([209.85.167.195]:43569 "EHLO
        mail-oi1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728153AbfLDSz2 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 4 Dec 2019 13:55:28 -0500
Received: by mail-oi1-f195.google.com with SMTP id t25so213800oij.10
        for <git@vger.kernel.org>; Wed, 04 Dec 2019 10:55:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=A9O3VU9qReEYspcUPnfHIn6zGNNtJi4BsQlRV548jcE=;
        b=iyAGHK7mODQcgsSgrs8Bgi19RFGHKg77nVTuzmx29kpS6UKRMOPoXRZOaQgaY5fGoN
         oATMK/3YmtJif/4cp7DOHcI6KhYGjQlPJOHf+dYXE04EzkNP5wX8cTQuQ41n1/7UkFoD
         E6CgopxnvsgDLWidMc/mqKZ6KOKgPmCEjyrAhLqf3ZfQVJY0AFKqCcIL2gXKCWTNov9G
         Db04i1C4GYjsRVCJbnR50iiOjWN8i1DmyCQlmVqFhlxWx8WdgnCQ1ah9Q3VHbLQVNEyh
         c5RUP/Ty+ghH3pPvB8l73HGTvbIQ6qXb2/xmIZ2v2KDplwatQhGbL/GwFp3KWHwKLu/4
         v8ZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=A9O3VU9qReEYspcUPnfHIn6zGNNtJi4BsQlRV548jcE=;
        b=ceDTVR0MHc1PFS5EEmaYWVIeJQQKGKivh37UHx1lEokIouW4Q4l9DQghY6N1MH2Dqr
         5GPNazoSr2zaZOgMEHU+Vu9Q4j27fV3YfxkNBQZVNRzah96+7GmqUq5LNVrVpfwJ6r12
         7MQs56dqpRPr39RdrQ1H+cpOMmYvg1YsJLFvjlUTQWJsnVS++3Ggc/jSTFMVdjJx83z2
         +Gzqz8AdBU3n3C1GbhQfV3HguT3XIB+2zXhpqptWE9xInQgVDyBdiHogjK7IlVwa4qEy
         CZMdiZo8R2f/I8QQdketWvH9prRNtl23L5Om4eLbOPmReKj71i37V1X6MY+VUuFRsHQQ
         eexw==
X-Gm-Message-State: APjAAAX2Rn0IT2v9hMCOReXFrECF8EE5NFhV4JHwT27s3hNH64SJYzVD
        Ci08c6JR8rDgGix+j+ixTpj6pPgE
X-Google-Smtp-Source: APXvYqy1W6bA8xl8vCRMWCMKZ7z6ZNIQSIAowQaBznR9v/JNinfebzk6JJ/+B0WCSxWW+KzImt+GhA==
X-Received: by 2002:a05:6808:12:: with SMTP id u18mr3795191oic.51.1575485726901;
        Wed, 04 Dec 2019 10:55:26 -0800 (PST)
Received: from [192.168.1.76] ([99.85.27.166])
        by smtp.gmail.com with ESMTPSA id h1sm2460398otm.34.2019.12.04.10.55.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 04 Dec 2019 10:55:25 -0800 (PST)
Subject: Re: [PATCH 2/2] revision: free topo_walk_info before creating a new
 one in init_topo_walk
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Mike Hommey <mh@glandium.org>, git@vger.kernel.org
References: <20191122083704.29267-1-mh@glandium.org>
 <20191122083704.29267-2-mh@glandium.org>
 <46c47a21-d0e1-296f-5563-ae29597f995c@gmail.com>
 <xmqqsgm4yq0m.fsf@gitster-ct.c.googlers.com>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <ba4095d7-e142-c9a4-ea41-04789be84d0b@gmail.com>
Date:   Wed, 4 Dec 2019 13:55:20 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:71.0) Gecko/20100101
 Thunderbird/71.0
MIME-Version: 1.0
In-Reply-To: <xmqqsgm4yq0m.fsf@gitster-ct.c.googlers.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 12/1/2019 11:22 AM, Junio C Hamano wrote:
> Derrick Stolee <stolee@gmail.com> writes:
> 
>> In general I like this change. I'm happy that this was split into a
>> method instead of crammed into the block of the "if" below.
>>
>>> +	clear_author_date_slab(&info->author_date);
>>
>> The only issue I have is that the author_date slab should not be
>> cleared. That is used by more than the topo-walk AND the values for
>> author dates will not change between subsequent revision walks. Just
>> drop that line and we should be good to go!
> 
> Hmph, isn't this merely a performance thing, or would a slab that
> was once cleared never repopulate upon its second use (i.e.
> affecting correctness)?

Yes, this is only a performance thing. If you think it is safest to
clear it here, then it can stay.

-Stolee
