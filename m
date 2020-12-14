Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 187B0C4361B
	for <git@archiver.kernel.org>; Mon, 14 Dec 2020 13:13:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C278F20659
	for <git@archiver.kernel.org>; Mon, 14 Dec 2020 13:13:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2407770AbgLNNN4 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 14 Dec 2020 08:13:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33352 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731286AbgLNNNz (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 14 Dec 2020 08:13:55 -0500
Received: from mail-ot1-x344.google.com (mail-ot1-x344.google.com [IPv6:2607:f8b0:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7FD3DC0613CF
        for <git@vger.kernel.org>; Mon, 14 Dec 2020 05:13:15 -0800 (PST)
Received: by mail-ot1-x344.google.com with SMTP id x13so15623844oto.8
        for <git@vger.kernel.org>; Mon, 14 Dec 2020 05:13:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=7O+HSFb6dQWMdNl7MQEmnFsaQ9lVBStQJgCqGwLD0G0=;
        b=RXWcKdZvUPqXdNmYz9Fe6HXArQY0cvOFTM0uEMSkOOOk+iGAdgyRV3cYdHXO2SXl89
         7+WoqYbgPJHwtbx7BT5YZzJDOP61bjphMZ8Bfc4SxsMb0C3e/pW7vaDeNtRmq2w8pBCD
         oNNhSeLaGpAq1oi8wq+gFmGdbWR2Xp2D9k2KNg3oj7eu8QKP0Hzp2JrPp4F0B+jPPU5M
         m0293WqfHcvp1smlfZzIiJexSZWPnUkTqAYLRZZaL8ZUGbxNlQY+6tqnjUb41VhjxTfG
         gMichUCdn0YS0UB9gGEIfWkAtVd2YrBzaMPW17sK9t4Nz8Ss/V5EbSLfJVPFA8CszZFo
         4opg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=7O+HSFb6dQWMdNl7MQEmnFsaQ9lVBStQJgCqGwLD0G0=;
        b=pIadbEqaTdMIWd0otK05dWQpyRvDCTffaGrT7T/PPW0g5YcDcE9gcjzTPukdbljLEV
         i5TT4uIowTa30+ceCRUIAaZxAThTD2uBo+sHFFhUcLeyTo2400tQ58yO8HRcrWV6E9Hq
         sZqw2dHvh6mzMUG9Cc76HdorW4Icrq8s+3oyqhr0Kg6SbT4UKvEFxffuVXygfTbWx/cd
         KWJ6gWmmWd+vjA9v6tBU+9YmlHFtVswnjt8+znuWTXEPYKeqR79pHWyAYRwODakGI9JP
         OdJXMRN9KDAGcOPvQLan0Td4IlWW0etyoQpa+zBaG4TWPoh63xppOiqG4EiBhMSkSMbo
         A/iQ==
X-Gm-Message-State: AOAM532YlIijIi2LGwydrGR+Id3ahCqAUYL3wb6Ksel/zNRr652v9hu9
        VnINHwJQNdudB3E9m+zP6R0=
X-Google-Smtp-Source: ABdhPJxf/PaSN5BuI/3PhwpLXAJu/jsp8dGA7WpXKLUZ1cViFD87RXhvosIdTnSl0yn3kgoWziNO5Q==
X-Received: by 2002:a05:6830:13d2:: with SMTP id e18mr15414714otq.366.1607951593474;
        Mon, 14 Dec 2020 05:13:13 -0800 (PST)
Received: from ?IPv6:2600:1700:e72:80a0:605d:243e:92dd:9289? ([2600:1700:e72:80a0:605d:243e:92dd:9289])
        by smtp.gmail.com with UTF8SMTPSA id w21sm3854612ooj.32.2020.12.14.05.13.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 14 Dec 2020 05:13:12 -0800 (PST)
Subject: Re: [PATCH] docs: multi-pack-index: remove note about future 'verify'
 work
To:     Johannes Berg <johannes@sipsolutions.net>, git@vger.kernel.org
Cc:     Derrick Stolee <dstolee@microsoft.com>
References: <20201213101340.7360-1-johannes@sipsolutions.net>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <f63b4810-7bfb-3daa-f1bf-2540edbc9cdf@gmail.com>
Date:   Mon, 14 Dec 2020 08:13:11 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:84.0) Gecko/20100101
 Thunderbird/84.0
MIME-Version: 1.0
In-Reply-To: <20201213101340.7360-1-johannes@sipsolutions.net>
Content-Type: text/plain; charset=UTF-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 12/13/2020 5:13 AM, Johannes Berg wrote:
> This was implemented in the 'git multi-pack-index' command
> (and there's no 'git midx' command)

Thanks for finding and fixing this outdated doc.

-Stolee
