Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.4 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 142EBC4338F
	for <git@archiver.kernel.org>; Thu, 29 Jul 2021 08:19:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E58AD60EBB
	for <git@archiver.kernel.org>; Thu, 29 Jul 2021 08:19:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234949AbhG2ITi (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 29 Jul 2021 04:19:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56804 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234256AbhG2ITc (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 29 Jul 2021 04:19:32 -0400
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com [IPv6:2607:f8b0:4864:20::1032])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85EF2C061757
        for <git@vger.kernel.org>; Thu, 29 Jul 2021 01:19:28 -0700 (PDT)
Received: by mail-pj1-x1032.google.com with SMTP id ca5so9154040pjb.5
        for <git@vger.kernel.org>; Thu, 29 Jul 2021 01:19:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=objYvkeOGXA4tC1XXw9szhVnDFF2JF6pDV81oCG8308=;
        b=TkY5kMNNiDco8HJ3DQ0UpSXtw+BKpGKjsAamLQz8XEA4UuDZsDtwNN1FrPJgzJZGuA
         JP/qkmS2Est+Oww79YKqIh+I2KQFyHPsYMypPfzdXUQoPwcoN8aYROFqQAOsD0BmElKN
         pcijBbVgo7d4gDh+t5gtBLOr3yYCUZaj1Xf4rz0XkZBuFQTPpUqYdD9KyjURF7IRMG8Y
         1Ua0LR7dcpXBGgbMEN9UxxCMD2vALYGf/ONo87gf9yxaY0cDEzihG7X+1atUjXnCMd2u
         r1RFFXyVpFbFUJ8q3eagPwYZVPN33cUnT2VWQSQfsDCRGOLFYWUkdVcEuwRB+Kd3waYe
         RDyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=objYvkeOGXA4tC1XXw9szhVnDFF2JF6pDV81oCG8308=;
        b=BpwtV8EJTa++LcKi/V5RD11ZQICwOgIPOeIj/IBs+jWWl+eZL27cjaE/rxIBqNSFKF
         /DGmfKFTTYxmf03ksRFo9MvM+nycYmHUZ/1vu95GEkQI0xJxTqYE2jn6Yz5vcfIfl2HQ
         UCqwd9eaO4c7g6GFM4dn+Pps3HCHY6e0RXxcJe62v5K+L1OVc8ovLy/0wZt6WAJc3Q7Z
         JddZyuavPQLBddu4inikg3My5zmme0s/dAAREOaoTPiM6BqehSo5djzwAKbsi4NBTSEC
         xMkUIdLBOMNZJ0xIJrXJaX5zsBGRVqLe0iElNAIyzqk9cU9+Nyq9uH9tAF+o5caFYs3m
         n0zw==
X-Gm-Message-State: AOAM532E0flH+jC0uwmgdVqpgvN/vuRbvr7iFRgVWLPl6nxBO6P2cRvi
        4L6vo6w3FOBOJ260j9UeX8kBv0Lzfsg=
X-Google-Smtp-Source: ABdhPJxrpLhs1KuSkNbHlHCOWgA0fnFRKCgB5TNmsYh813EZ8Fa4LNkK61NwaK7xtIznLneMKalP9g==
X-Received: by 2002:a17:90a:bb89:: with SMTP id v9mr14111934pjr.54.1627546768016;
        Thu, 29 Jul 2021 01:19:28 -0700 (PDT)
Received: from [192.168.43.80] (subs32-116-206-28-59.three.co.id. [116.206.28.59])
        by smtp.gmail.com with ESMTPSA id p11sm2291610pju.20.2021.07.29.01.19.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 29 Jul 2021 01:19:27 -0700 (PDT)
Subject: Re: [PATCH v6 0/9] ssh signing: Add commit & tag signing/verification
 via SSH keys using ssh-keygen
To:     Fabian Stelzer via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Cc:     Han-Wen Nienhuys <hanwen@google.com>,
        Fabian Stelzer <fs@gigacodes.de>,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        "Randall S. Becker" <rsbecker@nexbridge.com>,
        Hans Jerry Illikainen <hji@dyntopia.com>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Felipe Contreras <felipe.contreras@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Gwyneth Morgan <gwymor@tilde.club>
References: <pull.1041.v5.git.git.1627391744.gitgitgadget@gmail.com>
 <pull.1041.v6.git.git.1627501009.gitgitgadget@gmail.com>
From:   Bagas Sanjaya <bagasdotme@gmail.com>
Message-ID: <6b244afb-e4bb-c613-142a-4baba1149de3@gmail.com>
Date:   Thu, 29 Jul 2021 15:19:22 +0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <pull.1041.v6.git.git.1627501009.gitgitgadget@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 29/07/21 02.36, Fabian Stelzer via GitGitGadget wrote:
> openssh 8.7 will add valid-after, valid-before options to the allowed keys
> keyring. This allows us to pass the commit timestamp to the verification
> call and make key rollover possible and still be able to verify older
> commits. Set valid-after=NOW when adding your key to the keyring and set
> valid-before to make it fail if used after a certain date. Software like
> gitolite/github or corporate automation can do this automatically when ssh
> push keys are addded / removed I will add this feature in a follow up patch
> afterwards.
> 

I read above as "set valid-before=<some date> and valid-after=<now> to 
limit key validity for several days from now". Is it right?

-- 
An old man doll... just what I always wanted! - Clara
