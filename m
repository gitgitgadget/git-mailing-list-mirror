Return-Path: <SRS0=cWmm=5W=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E166C2BA19
	for <git@archiver.kernel.org>; Mon,  6 Apr 2020 11:57:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 261C42072A
	for <git@archiver.kernel.org>; Mon,  6 Apr 2020 11:57:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FR4rAERM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727769AbgDFL5k (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 6 Apr 2020 07:57:40 -0400
Received: from mail-ot1-f67.google.com ([209.85.210.67]:33058 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727635AbgDFL5k (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 6 Apr 2020 07:57:40 -0400
Received: by mail-ot1-f67.google.com with SMTP id 22so15045640otf.0
        for <git@vger.kernel.org>; Mon, 06 Apr 2020 04:57:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=pKrS//9cwAkvJ0ZPRyxQoJ/A5UaKaCQT7Ub0qxmbyUE=;
        b=FR4rAERM+iO8m4NpFQIkHHSNdoz2O56NxsaFUA/uKDd/jzhQ17qWXrh9P153Dojgk6
         3LCW+0B7GBb1n+0CkQBQwqsnJmZqjo4h8urzVN9DGyLO+TYzX8K5LUs0hjgHiLNz0EdO
         Kp1n63WsLMNJUcra+vCURGSjmcR50tHcP9+CjQQTt55zkpmLae1/0PoSjMenaJThB5uD
         Nw8KmWomfc38+Xe6tB9Isc7+Jef8gVoIUR8tzTfR1OqH2nE4myYd72YXO71D4BqkRR/Z
         sKMPzYlH1ijN9sWLImX9B7t+a3ydNkd6McSmfVLYKn4WrstcpAYcbNP28xfurAEYIPwq
         Jaog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=pKrS//9cwAkvJ0ZPRyxQoJ/A5UaKaCQT7Ub0qxmbyUE=;
        b=UGPSCyAAUCT0qU3c4ZPOw1kp7WMUWieFpkYE48YO1cNJWHMA/6DIutBBQtGkPW1o8G
         T33Bahgk6wpZGg2vYkn6WmhmtBG8uQkwezMynV+7jiq7vF0olTgoPHYdvy0NA8KniKBO
         0yXLcfD19mXszfZ303wSKpKE8t4eXsp/Jtf/4a8wgTjSLIysjAhd/CnO1DpEVm3B8YMh
         GcsMgjXEYyCv3Nq7hjrcbKnUm3WI8p6hziSynark2dP6AWm+MynQsWyBh895WZAukLNk
         8RdRmGJr7zStM1vkAdz/9b1SfhTNIw/D8PB5WiaSfX09rXdb3vhbx632A7tvUwE7ebVk
         /Oqw==
X-Gm-Message-State: AGi0PuabuEefWFH68llLLmUN1P42ffZymCZi5fyDlyZuARGwjRRKNR7f
        cFVTBlN06yhYczDWflWkyVQ=
X-Google-Smtp-Source: APiQypLAvTCZUN2Gpl2wxde9B2KTD4EEmTyWHxsn02U/82wUykqWs6DqeeJCdvrXSXpQIYEgqrW9Sg==
X-Received: by 2002:a9d:27c7:: with SMTP id c65mr17723856otb.318.1586174259191;
        Mon, 06 Apr 2020 04:57:39 -0700 (PDT)
Received: from ?IPv6:2600:1700:b00:7980:316e:974b:1797:4fa9? ([2600:1700:b00:7980:316e:974b:1797:4fa9])
        by smtp.gmail.com with ESMTPSA id h29sm4400559ooe.33.2020.04.06.04.57.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 06 Apr 2020 04:57:38 -0700 (PDT)
Subject: Re: [PATCH v2 0/2] Restrict when prefetcing occurs
To:     Derrick Stolee <stolee@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        Jonathan Tan <jonathantanmy@google.com>
Cc:     git@vger.kernel.org, Garima Singh <garima.singh@microsoft.com>
References: <20200331020418.55640-1-jonathantanmy@google.com>
 <cover.1585854639.git.jonathantanmy@google.com>
 <xmqq369l3a4a.fsf@gitster.c.googlers.com>
 <7de2f54b-8704-a0e1-12aa-0ca9d3d70f6f@gmail.com>
From:   Garima Singh <garimasigit@gmail.com>
Message-ID: <7c877d3b-e6fb-c9b0-f403-09133270017d@gmail.com>
Date:   Mon, 6 Apr 2020 07:57:36 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <7de2f54b-8704-a0e1-12aa-0ca9d3d70f6f@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On 4/6/2020 7:44 AM, Derrick Stolee wrote:
> On 4/2/2020 4:28 PM, Junio C Hamano wrote:
>> I notice that a439b4ef (diff: skip batch object download when
>> possible, 2020-03-30) by Garima seems to aim for something similar.
>>
>> I'll for now keep both topics with conflict resolution, but it may
>> make sense for you two to compare notes.
> 
> I pointed this out in [1]. I think the right thing to do is for
> Garima's/my patch to rely on Jonathan's change. The commit needs
> to be modified, not simply ejected, but it could be separated from
> the rest of Garima's series. It is only a performance fix for
> normal clones, but is critical for partial clones.
> 
> Garima: do you think it would be easy to remove that patch if/when
> you do a v4 and I can make a new series based on yours and Jonathan's
> with the rename setting?
> 

Sure. I was thinking about rebasing my series on top of Jonathan's 
and adjusting as necessary, but it might be easier to just remove it 
and then have a new series based on mine and Jonathan's, like you
suggested. 

There hasn't been any feedback since I sent out v3. I will just re-roll
v4 without this patch, to make sure pu no longer requires conflict
resolution around the Bloom filter series. 

Cheers! 
Garima Singh
