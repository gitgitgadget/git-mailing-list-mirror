Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE549C49EA6
	for <git@archiver.kernel.org>; Sat, 26 Jun 2021 11:50:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 881BC6161C
	for <git@archiver.kernel.org>; Sat, 26 Jun 2021 11:50:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229952AbhFZLwi (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 26 Jun 2021 07:52:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55414 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229518AbhFZLwi (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 26 Jun 2021 07:52:38 -0400
Received: from mail-pl1-x633.google.com (mail-pl1-x633.google.com [IPv6:2607:f8b0:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C44CEC061574
        for <git@vger.kernel.org>; Sat, 26 Jun 2021 04:50:13 -0700 (PDT)
Received: by mail-pl1-x633.google.com with SMTP id i4so6102676plt.12
        for <git@vger.kernel.org>; Sat, 26 Jun 2021 04:50:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=tB50x+xvnMLL72cspqrp7gYlzJgm8AAD3G/0FobWmS8=;
        b=W+eSasOcDcubRGKZ6HPnDWNJFKdFUvL93ed8uegBbHob0shikdWCwuHO0MqtOGhBOZ
         iStXwAY/Hh1D46ZzslFMDI6uiYXlTrce1WpZ0n3vYRUCxh042S5SI0Kmn2J+HYPjI1EC
         RStFIrlw/oBjLNeG9yL4E9xwQn67MOymeVuq5qteKJyaSMztpOqj0KKHm3GCkSjsCASH
         G6AFtPGKevxGXkszLylaxccdyTjixsR7ow9kPx+357OwY//ZD7KzE2rNUEUxoH6Gg4TF
         J3MkZ66pd8gJBQlfy0r46ACQTruRrGkHfy7nRIhdHviNh5b0Ee8KWbCSnq7rm3qye24h
         JBNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=tB50x+xvnMLL72cspqrp7gYlzJgm8AAD3G/0FobWmS8=;
        b=MajrH25AV+oIs7ilj8MQWwlopCPOhEEj7EPqz48GKhGGwK4zUz3hvo8eCnvMyCC5w7
         Fmd+e4kfMVfoPgyBtefPgy1hr1izM9dfxSlpOj0jXsDyY2HgRYY6vxE4IuIbfX6e6mjo
         6BqwVy6YzFIUbHmaXkJHPYbkfdVFgFxlDSofIMa5eH04qjanJsBQPOyp4G8QbiL11gvb
         LNqZU5Z4thYcYEtLqolsMpqWFfXlVlbcWKhz8p+UqHav890Ln8fkog9E8nCc2su9Avyw
         pcCrQscE0Qy/Lxkw/UhueMNiKqHJu7dHXZOMS25PCqtr51cBWsdFbIUOrATZ49rFOCIV
         HCQA==
X-Gm-Message-State: AOAM532pChqr4D4u7hRvhjQJY4NqbL0Y6x85BNIUSEqya1pjDmwsXx+H
        62wFCZ8QrB83/Psvh47dxiQ=
X-Google-Smtp-Source: ABdhPJx6CJvxUf+l3H0UbVnnzsfkw6VGPY/qVvQeKSBpJXNEjY/prIff/oqcl4wSVbMrfLmdzx7oaQ==
X-Received: by 2002:a17:902:988f:b029:114:12d2:d548 with SMTP id s15-20020a170902988fb029011412d2d548mr13376020plp.73.1624708213228;
        Sat, 26 Jun 2021 04:50:13 -0700 (PDT)
Received: from [192.168.43.80] (subs02-180-214-232-80.three.co.id. [180.214.232.80])
        by smtp.gmail.com with ESMTPSA id j3sm8634367pfe.98.2021.06.26.04.50.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 26 Jun 2021 04:50:12 -0700 (PDT)
Subject: Re: [PATCH v3 0/3] Config option names typofixes
To:     Andrei Rybak <rybak.a.v@gmail.com>, git@vger.kernel.org,
        Barret Rhoden <brho@google.com>,
        =?UTF-8?B?xJBvw6BuIFRy4bqnbiBDw7RuZyBEYW5o?= <congdanhqx@gmail.com>,
        Rafael Silva <rafaeloliveira.cs@gmail.com>
References: <20210619112912.76136-1-rybak.a.v@gmail.com>
 <20210625193851.2233114-1-rybak.a.v@gmail.com>
From:   Bagas Sanjaya <bagasdotme@gmail.com>
Message-ID: <94a4dc6e-a8e7-d6d1-33c1-5a0dcfa9a4ca@gmail.com>
Date:   Sat, 26 Jun 2021 18:50:06 +0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210625193851.2233114-1-rybak.a.v@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 26/06/21 02.38, Andrei Rybak wrote:
> First patch in this series is the same as the v2 patch.  Second patch fixes
> similar typos in mentions of config options in test messages.  Third patch is
> just a fix for an unrelated typo I've stumbled upon.
> 
> Andrei Rybak (3):
>    blame: correct name of config option in docs
>    t: fix typos in test messages
>    git-worktree.txt: fix typo in example path

I suggest that the third patch should be on separate single patch, as it 
is unrelated to two other patches that correct config option names.

Thanks.

-- 
An old man doll... just what I always wanted! - Clara
