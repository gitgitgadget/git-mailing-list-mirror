Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BAD03C07E95
	for <git@archiver.kernel.org>; Wed, 14 Jul 2021 00:09:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 99A7661288
	for <git@archiver.kernel.org>; Wed, 14 Jul 2021 00:09:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237047AbhGNAMi (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 13 Jul 2021 20:12:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35322 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236998AbhGNAMi (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 13 Jul 2021 20:12:38 -0400
Received: from mail-pl1-x634.google.com (mail-pl1-x634.google.com [IPv6:2607:f8b0:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1336C0613DD
        for <git@vger.kernel.org>; Tue, 13 Jul 2021 17:09:47 -0700 (PDT)
Received: by mail-pl1-x634.google.com with SMTP id o8so323814plg.11
        for <git@vger.kernel.org>; Tue, 13 Jul 2021 17:09:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=i39nr/mySbjuiSdl1cqo5R2Kd9l/h5EXT8QoQmzlsSo=;
        b=I5hBSoXGz57bKpvFUANlo1IQBS/WO/rxYoNSv4e2ALJBZrHvEUqsjaSPNHh/mqIIDu
         1BVMK08xAWISqVxPzxr8UnpRIfsTfx7VDyMIe2x8pXYeX+9rfDDH1qNpMLBdrLVqnYRL
         lmMMagNUT5e89Po0HRpWG180yf+iP7RPLresGTvtLSVQSQVJzn0twAuy9BoFryZ1BV2h
         AY/3zSJA0B/kuNS1zI5LrnNJZ49P+nRIM5+bhskOeCFYBPJ/OZxGPWGvnfk5SEjShNOg
         awnZBjTtXwydg5DVFCdO8JXcWSESN0VNp7OOr8tgfhnlQIHs/Dvipbv+IgEf0HNt29qc
         DoJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=i39nr/mySbjuiSdl1cqo5R2Kd9l/h5EXT8QoQmzlsSo=;
        b=t4RHuihYs4AFzQeB4+/L/mmSMMhv7+eMDw8f4l90D3/W4Om0DZakNE59NuZIAK4ry7
         dMY8L0cP8Dm1hjTTos0mKzU7R14EREeIOgIgCHnr5mpNB7mskEPKrTb/2SJCPD2tGv8o
         PzbYSIs0mrN2VZVe4XhXrDGXbiIXmatRsq88kQvvJQUPoziI8R9Lc3ueVgdI2qKw8YOg
         ImOLBHJ9a6WFVaMbhlgox0NVwFGeimKxc/iIrLtTTLH5d1ftottr1bJaNulS2HGnNUXx
         Cw9B5vREfRKpAtAEIU2XJAJDYl+7DrofoowSUJsMq5ry8Z3lzHcPH/YVXVZTud9PU+iF
         e03A==
X-Gm-Message-State: AOAM532WWV8a76+sJcI3WbWC8emYqRM/K7V366gPs4J49ty+rhXWin5b
        NxL+pP8UVsJZm5bX4pon0eQw6setia2iOg==
X-Google-Smtp-Source: ABdhPJzJaCGPJFWmbLeYd0vZR8riVQVlZvYELTYorGQHYWDKVodN0x1c+K07ikqnnwWKBtb+lCKZpQ==
X-Received: by 2002:a17:90a:8042:: with SMTP id e2mr870591pjw.142.1626221387102;
        Tue, 13 Jul 2021 17:09:47 -0700 (PDT)
Received: from [192.168.43.80] (subs03-180-214-233-66.three.co.id. [180.214.233.66])
        by smtp.gmail.com with ESMTPSA id p25sm292826pff.120.2021.07.13.17.09.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 13 Jul 2021 17:09:46 -0700 (PDT)
Subject: Re: [PATCH] l10n: allows to translate diff messages
To:     Junio C Hamano <gitster@pobox.com>,
        Jordi Mas via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Jordi Mas <jmas@softcatala.org>
References: <pull.1045.git.git.1626177676801.gitgitgadget@gmail.com>
 <xmqq4kcx24j7.fsf@gitster.g>
From:   Bagas Sanjaya <bagasdotme@gmail.com>
Message-ID: <934273c6-b112-892b-f746-4647b5db3317@gmail.com>
Date:   Wed, 14 Jul 2021 07:09:43 +0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <xmqq4kcx24j7.fsf@gitster.g>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 14/07/21 06.11, Junio C Hamano wrote:
> Also, when showing "git diff --stat" for a binary file, we'd say
> 
> 	$path | Bin 1234 -> 1236 bytes
> 
> I wonder if that should also be translated.
> 

I think that above should also be translated, for consistency with diff 
for regular text file.

-- 
An old man doll... just what I always wanted! - Clara
