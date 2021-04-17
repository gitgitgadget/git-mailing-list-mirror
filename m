Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7A81C433B4
	for <git@archiver.kernel.org>; Sat, 17 Apr 2021 12:17:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8F376610E8
	for <git@archiver.kernel.org>; Sat, 17 Apr 2021 12:17:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236187AbhDQMSD (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 17 Apr 2021 08:18:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47056 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235901AbhDQMSD (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 17 Apr 2021 08:18:03 -0400
Received: from mail-pg1-x536.google.com (mail-pg1-x536.google.com [IPv6:2607:f8b0:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 37BBFC061574
        for <git@vger.kernel.org>; Sat, 17 Apr 2021 05:17:37 -0700 (PDT)
Received: by mail-pg1-x536.google.com with SMTP id t22so21015326pgu.0
        for <git@vger.kernel.org>; Sat, 17 Apr 2021 05:17:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=tjwNpIUzFwqy6RC1sGBElZdCJBgqh8JP8zvPh3CLmCw=;
        b=UwsKQM/xqqNUsQ6E6Oyz6c/qZaBBh2FQe3yWZd41FJDIku4BkhjIz5vbV8v4OhAENp
         Cnctru/Swx+kCxlaOMucpReDzjb/3/ntVW3yb9bxkuad8xV8JMvFJNOKXtMMEBEQXRUx
         RlIkXcYFQHV3cS9+fvw+oMLx0iz+ztkw40tGKQ+lCOrNYqiPAJg7lC5tRrlH6/5aKXfJ
         ZOtu2TO8M+CnyQ3+M5yRltQTUo5yNRf5ljbcU2QDg1fP3KVYLcEcpYtLV60kTC1wSKRH
         /3BuV3hGRMlbh3Ok+RzvY7KLFPM0/2gDIKZ1x/8P+Mzk9rtYo19qfqOq+QfzjDV43ZXO
         5G8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=tjwNpIUzFwqy6RC1sGBElZdCJBgqh8JP8zvPh3CLmCw=;
        b=KaVDGy+8inRZug2PGEM9kEdWR8/Xvd5LN5SXx3jiR0afij6uoc1TChZzG7yU8hHgUa
         mjmQLLoVpukEf8yxzW8exLEGBnRvziQt510IftwYsvMqizL3goqOuhCx3gk9CW6NgcfJ
         LDLnSTI7L8Tvmn8e8wEpmeg3ky6zaR6o3+IFqtGKeXBmxvuHqw3I8F3VFDdFH7gmlxKl
         3b4sGnkvU5PWd+OyLr0fkcvz4qkC4nVm04dsK6wQxhieMu7WoL2boqm05cAFVoSb7TeE
         yUs4ZILau0LXEvqhoM9Vit1hgkFwbRIsWh6/CM9VcHkcgNGqGnywCmlGPEDo+yxC906f
         LUfg==
X-Gm-Message-State: AOAM533feUn6w7Pp15Ir44e9nKKDT4yST4PwmYe/LhYUTMxC4sNKqS5E
        VHnX4eIE+x8eI/Pm11eGNYbuUeGUc5IgQw==
X-Google-Smtp-Source: ABdhPJzOxnwLbnte/Uz5rhHJQ4qXcHVsiVgAfEZ5UPnVJ0wQn2jr2xmT/Ykg5C56dbhOmGftApatVA==
X-Received: by 2002:a63:e044:: with SMTP id n4mr3302815pgj.47.1618661856378;
        Sat, 17 Apr 2021 05:17:36 -0700 (PDT)
Received: from [192.168.43.80] (subs02-180-214-232-1.three.co.id. [180.214.232.1])
        by smtp.gmail.com with ESMTPSA id m3sm3112289pfh.155.2021.04.17.05.17.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 17 Apr 2021 05:17:35 -0700 (PDT)
Subject: Re: [PATCH] CodingGuidelines: remove suggestion to write commands in
 Perl/SH
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>, Git Users <git@vger.kernel.org>
References: <patch-1.1-83266f30b67-20210417T084346Z-avarab@gmail.com>
From:   Bagas Sanjaya <bagasdotme@gmail.com>
Message-ID: <bcc64c2d-3469-38ab-3234-fa8984a3d0f9@gmail.com>
Date:   Sat, 17 Apr 2021 19:17:32 +0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.9.1
MIME-Version: 1.0
In-Reply-To: <patch-1.1-83266f30b67-20210417T084346Z-avarab@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 17/04/21 15.43, Ævar Arnfjörð Bjarmason wrote:
> Since then the consensus changed to having no new such commands unless
> necessary, and existing ones have been actively migrated to C.

What I implied that when we need to implement new commands, it must
be directly written in C (steeper learning curve and more tedious
than implemented in shell script), so I'm against this proposal.

-- 
An old man doll... just what I always wanted! - Clara
