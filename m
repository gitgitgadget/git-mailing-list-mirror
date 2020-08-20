Return-Path: <SRS0=wu5b=B6=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5E0BC433E1
	for <git@archiver.kernel.org>; Thu, 20 Aug 2020 15:16:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9E7AC206DA
	for <git@archiver.kernel.org>; Thu, 20 Aug 2020 15:16:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PH3ChT3r"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728251AbgHTPQd (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 20 Aug 2020 11:16:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54180 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726950AbgHTPQ3 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 20 Aug 2020 11:16:29 -0400
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com [IPv6:2a00:1450:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80FCFC061385
        for <git@vger.kernel.org>; Thu, 20 Aug 2020 08:16:29 -0700 (PDT)
Received: by mail-wr1-x444.google.com with SMTP id r4so2367159wrx.9
        for <git@vger.kernel.org>; Thu, 20 Aug 2020 08:16:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=reply-to:subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=8rDteqW9uZ1ZioQeMA8I3Kuk3UsHyZGSrDhqIKF578I=;
        b=PH3ChT3rjdYSNE+y6EU9drRkwlablA43M6dnkfZY45Oi6Yd15yQk5XHDrSYc5IytAV
         Gg3jsoDKrdEs/Cs5ZRN6XFuH5iilxTAC7PyCHsGSMddEFkm49NY8lsxJPgtpgU3oaCTh
         jXZGSKjSdrPn75A//xLAeeu+2CQ+kksOeZ13wau0tu7OGPjLSrUU47OweKN6mgteR5TA
         I84JUj8q39W6nu9UNVo/0RJL0FldQHDdFDOLNpBeA75rok1nsl/bTVnY4Ew1v4xftOhS
         HYF/Binvf9mZPJy8mQzPugN6+NinYZaRRLAWQJSOZp9MSTOZ2g0Br27DNoldmMWch9MJ
         EblQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:reply-to:subject:to:cc:references:from
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=8rDteqW9uZ1ZioQeMA8I3Kuk3UsHyZGSrDhqIKF578I=;
        b=GAdeWcl6OPoJskzz3RA8Kz7UhwILNfmAfE0c5aYl+uUtTDcxtvz4NHwevjsHBUIRxE
         8VLxHH4TNbK3Vp9Tauo6cx/IJa5g1vted0Es4HZFU2pDaO68nfQh+z50G+AcSsKZPqZD
         JYTkHDXLgtujcpJEv7Ey4uI6ma400MKxqF7U0cMQrOTw8yxiJdTHa+VU8gMjPUO0nO+Z
         u36BVE/5oNJQNJUEGtPb+nvUNAn+5XYw2po3PPj3F+gbTsIxJ0QAX1G76T4q6dnqqNNF
         r6Y8xL6kNApqDjojk/qN36CMkhehIxu49YViat3Sz/tDWoFq42ZHknV2cBjWggaech+r
         C2eQ==
X-Gm-Message-State: AOAM533oIypPQXWesorGW6sfDAl6VsK4sFJy5Ae3uAGBUhF+rpqify6q
        vkKHhPwVmfPCQlPw7F9qIdxFPGudDRE=
X-Google-Smtp-Source: ABdhPJyK9rtidmRUDLhg6FBqmiN+XdxQPpiVvUYHQ/eCTFTGEOUdXrmBVZaDAWWM1SZ1d1FqEEl13A==
X-Received: by 2002:adf:dfcf:: with SMTP id q15mr3822192wrn.345.1597936587887;
        Thu, 20 Aug 2020 08:16:27 -0700 (PDT)
Received: from [192.168.1.240] (192.252.189.80.dyn.plus.net. [80.189.252.192])
        by smtp.gmail.com with ESMTPSA id v15sm4732661wrm.23.2020.08.20.08.16.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 20 Aug 2020 08:16:27 -0700 (PDT)
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH v8 4/5] rebase -i: support --ignore-date
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Phillip Wood <phillip.wood@dunelm.org.uk>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Elijah Newren <newren@gmail.com>,
        Rohit Ashiwal <rohit.ashiwal265@gmail.com>,
        =?UTF-8?B?xJBvw6BuIFRy4bqnbiBDw7RuZyBEYW5o?= <congdanhqx@gmail.com>,
        Alban Gruin <alban.gruin@gmail.com>,
        Git Mailing List <git@vger.kernel.org>
References: <20200407141125.30872-1-phillip.wood123@gmail.com>
 <20200817174004.92455-1-phillip.wood123@gmail.com>
 <20200817174004.92455-5-phillip.wood123@gmail.com>
 <88535175-0540-c96d-24b5-c4d407422a8c@gmail.com>
 <xmqqo8n6s2fu.fsf@gitster.c.googlers.com>
From:   Phillip Wood <phillip.wood123@gmail.com>
Message-ID: <975d49a0-de4c-c38f-7928-454c00c90ca2@gmail.com>
Date:   Thu, 20 Aug 2020 16:16:26 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <xmqqo8n6s2fu.fsf@gitster.c.googlers.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB-large
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 19/08/2020 23:20, Junio C Hamano wrote:
> Phillip Wood <phillip.wood123@gmail.com> writes:
> 
>>> +# Checking for +0000 in the author date is sufficient since the
>>> +# default timezone is UTC but the timezone used while committing is
>>> +# +0530. The inverted logic in the grep is necessary to check all the
>>> +# author dates in the file.
>>> +test_ctime_is_ignored () {
>>> +	git log $1 --format=%ai >authortime &&
>>> +	! grep -v +0000 authortime
>>> +}
>>
>>
>> I don't know what I was thinking when I wrote that - it should be called
>> test_atime_is_ignored() as it's testing the author date
> 
> Will tweak locally.  No need to resend.

Thanks for doing that

Best wishes

Phillip

> Thanks.
> 
