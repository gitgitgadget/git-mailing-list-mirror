Return-Path: <SRS0=ZiOn=25=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8A75C282DD
	for <git@archiver.kernel.org>; Wed,  8 Jan 2020 18:55:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8D86020643
	for <git@archiver.kernel.org>; Wed,  8 Jan 2020 18:55:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aIMmc2cu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729362AbgAHSzy (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 8 Jan 2020 13:55:54 -0500
Received: from mail-wm1-f68.google.com ([209.85.128.68]:36560 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726401AbgAHSzx (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 8 Jan 2020 13:55:53 -0500
Received: by mail-wm1-f68.google.com with SMTP id p17so38316wma.1
        for <git@vger.kernel.org>; Wed, 08 Jan 2020 10:55:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=wCAWmGpNN2glEp5EzxwdslBy79QgX6pTtEI6qxUcu5E=;
        b=aIMmc2cuHLur51F+HUw6arXEWWbJ1Bw3/lTE7yUEl8wzNRdn0t3zyaJbyWHraNCVOZ
         lN95hkoP6QoxgqVx95rESA+bweoByUoq4jNWWw6yxGULvSsqENEpwa7eFG4SKs8bpTlv
         B46rJ1uLUU6Hs1QTiTog8p5Mob0tHUKiKFW/VfapBxXZHMwIh452ofvUBoA5aaVNCrc+
         nqIPMRrQb+Y6UP5Z/Cm0Spi4TySIk7RctNvEeb77UFKNtoxZd5hh7nZk0FoDRCpuFh35
         oxgPkZIFluwe5Ub39LzQw2mv1+uA5u84YZgIftTYD4y7WXLzooH2h9QRW+ulUCuoyQ1W
         +ueg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=wCAWmGpNN2glEp5EzxwdslBy79QgX6pTtEI6qxUcu5E=;
        b=JhNw0PaGbLv2D9mMCyuxYuOuwo/kdml/kHLW5LEwHuA3Js1gTQrk5LgobQplbB6n9/
         kfW4qntq9vaigXSWHSLLw323a+LHM/aiFssk5GFRvsyHwZIYlel00gjEEttFQwmvaySV
         ry400ExRRcj7rQ7obo0cuHseWJ/ukYIiNeAaGRJ3Z6xpWcmwxzS/LtlG8d94iBSTF+R1
         UdzxeQcZ3Koi9sgDalPYaK7Kdc/fjEHBcIzr8i9naPAnhClocQssW5XRE00m+8XG1aZh
         ZmMFehAsINmWoIw7er42UKAbqISGc8VoOftrfjqXZcl3xf04szig+7U/rm/C+/qiVVGy
         VwOQ==
X-Gm-Message-State: APjAAAUpgQOifiX9PBD5f5LpMVXKw3NV+rlFaDPOZ3fquG6zIHKBXrze
        CzZwpNCavnWwtWI/u48zPZA=
X-Google-Smtp-Source: APXvYqw4Kv98lio6TLckG9UW22TMhnJticfhBRokcTDTn5ei3WP984Dj50DXnJyXrQ1085TmTpjP2g==
X-Received: by 2002:a1c:498a:: with SMTP id w132mr77945wma.10.1578509752523;
        Wed, 08 Jan 2020 10:55:52 -0800 (PST)
Received: from [192.168.2.201] (host-92-22-7-145.as13285.net. [92.22.7.145])
        by smtp.googlemail.com with ESMTPSA id p5sm5328729wrt.79.2020.01.08.10.55.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 08 Jan 2020 10:55:51 -0800 (PST)
Subject: Re: [PATCH v3 10/15] rebase: add an --am option
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Elijah Newren <newren@gmail.com>,
        Phillip Wood <phillip.wood@dunelm.org.uk>,
        Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Denton Liu <liu.denton@gmail.com>,
        Pavel Roskin <plroskin@gmail.com>,
        Alban Gruin <alban.gruin@gmail.com>,
        =?UTF-8?Q?SZEDER_G=c3=a1bor?= <szeder.dev@gmail.com>
References: <pull.679.v2.git.git.1577126999.gitgitgadget@gmail.com>
 <pull.679.v3.git.git.1577217299.gitgitgadget@gmail.com>
 <1df11f0b5105b1f602fdd723e0f74565e436faba.1577217299.git.gitgitgadget@gmail.com>
 <8f2fa083-114a-011f-1480-ae0ebd67d814@gmail.com>
 <CABPp-BEoTb6LVXThEM4zoKxVOnzBNs7y-Mk+oFbb6BUzCo3RHg@mail.gmail.com>
 <xmqqy2uj3u3q.fsf@gitster-ct.c.googlers.com>
 <9ac52ef1-c1cb-45aa-178a-ec5a282bd761@gmail.com>
 <xmqqmuax3lzv.fsf@gitster-ct.c.googlers.com>
From:   Phillip Wood <phillip.wood123@gmail.com>
Message-ID: <fabb4048-41fa-0b24-1716-e63237478956@gmail.com>
Date:   Wed, 8 Jan 2020 18:55:53 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.3.1
MIME-Version: 1.0
In-Reply-To: <xmqqmuax3lzv.fsf@gitster-ct.c.googlers.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 08/01/2020 17:18, Junio C Hamano wrote:
> Phillip Wood <phillip.wood123@gmail.com> writes:
> 
>> I view this change in the default backend as similar to the rewrite in
>> C in that it is an implementation detail we're changing that should be
>> transparent (and beneficial in terms of performance) to the
>> user. There we provided a configuration variable but not a command
>> line option to control if it was used or not.
> 
> Do you mean things like GIT_TEST_ADD_I_USE_BUILTIN?  I think it is
> OK to have such an escape mechanism to allow people to opt out of
> a new reimplementation until it matures, but I do not offhand recall
> doing so with config.

I was thinking of rebase.usebuiltin

Best Wishes

Phillip
