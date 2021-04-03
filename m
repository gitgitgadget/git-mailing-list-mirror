Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD757C433B4
	for <git@archiver.kernel.org>; Sat,  3 Apr 2021 08:05:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6CDC56115C
	for <git@archiver.kernel.org>; Sat,  3 Apr 2021 08:05:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234908AbhDCIFp (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 3 Apr 2021 04:05:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47168 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231575AbhDCIFp (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 3 Apr 2021 04:05:45 -0400
Received: from mail-pl1-x634.google.com (mail-pl1-x634.google.com [IPv6:2607:f8b0:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 972BEC0613E6
        for <git@vger.kernel.org>; Sat,  3 Apr 2021 01:05:41 -0700 (PDT)
Received: by mail-pl1-x634.google.com with SMTP id d8so3439037plh.11
        for <git@vger.kernel.org>; Sat, 03 Apr 2021 01:05:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=98AbixOichqGUYuNCHmDwrGVNgHOh2CgDyutSgTOOjk=;
        b=l+Qi33x8+0R1NXHTf3wd2puhJJebNWagImj4Vu4nozyUjDhjF9+7uSR16eMnqWoed5
         7zjsPjHSPF7Heua5tkgwgxpkryRx4XXmm6ZzPz6o8c7RkfxVj6YlanBQMgjsJrjTOEar
         Ef5AmssTnChkdq4Djm7ZnqPY7IlOdcnUWLEHIqItQZhARNSsNdVsTR2mHoOy85MD3Umr
         U212R3AwCtghIPiQQRVnPVBHjfT5SJGTNPRE250up0g9xwszSEcgBpMAjyOc2X25oFej
         apwiO/uBOr9tQrCdqK5nti1qgLJ6c5AN6P+k0wH+KnLHPX1c3ZCI5yrnKrGyJDB5Wl4F
         NzeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=98AbixOichqGUYuNCHmDwrGVNgHOh2CgDyutSgTOOjk=;
        b=oVPVphDWPfDH3HHVmtwssay7flwQVlpbq0fhDw7r9Hh0GIbdVJnYGB3/18zKWsEu+P
         MOxaE9yQwWNW1cDfWlMK5mHqI0NYwMQhiKPnLxyJVlWtwJxxASW+X8XFO05X0T8WriHD
         GBLWYDX1oqDqvz3DzKXGpbsbx6+21Spb3EvFle9/1hGE4nGz2UQqjtvXZu93EUdDVzLY
         ywpcwVzifxG3MA7YyfO45eyNHjBSh6yVzYtzzQKNow/CS+uOuvtl6EX5nHS7F09cC4ci
         dciJvwjz67UxlRJDTkXjTenN+dKE6S6IOHKPvVZ5dt+GQbkl9eIuIiURaI0R6lRYtB6x
         so2A==
X-Gm-Message-State: AOAM5334YuN0PgIEKBAYzqKH8ZiXuxaaNSdfqRx1veauaD6KFLl1zoaA
        FR2dqUshbEJapcxU6CTLwL9aLFFVlT6Ygg==
X-Google-Smtp-Source: ABdhPJxXRA3r1Fsm9mPSQikogQOye60fwDNwadPbqmraAyFFgyb2JiK/opIWMUFUEXjUYsi5RTy50A==
X-Received: by 2002:a17:90b:3615:: with SMTP id ml21mr17229902pjb.72.1617437140846;
        Sat, 03 Apr 2021 01:05:40 -0700 (PDT)
Received: from [192.168.43.80] (subs28-116-206-12-32.three.co.id. [116.206.12.32])
        by smtp.gmail.com with ESMTPSA id b10sm10114923pgm.76.2021.04.03.01.05.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 03 Apr 2021 01:05:40 -0700 (PDT)
Subject: Re: [PATCH 0/1] git-apply: Allow simultaneous --cached and --3way
 options
To:     Jerry Zhang <jerry@skydio.com>
Cc:     Ross Yeager <ross@skydio.com>, Abraham Bachrach <abe@skydio.com>,
        brian.kubisiask@skydio.com, git@vger.kernel.org
References: <20210403013410.32064-1-jerry@skydio.com>
 <0803a702-ae9c-da9a-c168-d534fe2aab58@gmail.com>
 <CAMKO5CtiW84E4XjnPRf-yOPp+ua_u07LsAu=BB0YhmP3+3kYiw@mail.gmail.com>
From:   Bagas Sanjaya <bagasdotme@gmail.com>
Message-ID: <dea7dd84-0763-cd1b-7996-541a5cde3a06@gmail.com>
Date:   Sat, 3 Apr 2021 15:05:36 +0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.9.0
MIME-Version: 1.0
In-Reply-To: <CAMKO5CtiW84E4XjnPRf-yOPp+ua_u07LsAu=BB0YhmP3+3kYiw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 03/04/21 13.57, Jerry Zhang wrote:
> I wanted to provide extra context to explain the background of what I'm
> trying to accomplish,
> but didn't want it all merged as commit text in the tree ;-)
> 
But you can add these contexts to your patch, just put them between
--- and `diff` line. (after patch message and before actual diff).

-- 
An old man doll... just what I always wanted! - Clara
