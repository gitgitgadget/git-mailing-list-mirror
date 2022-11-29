Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 504B9C4332F
	for <git@archiver.kernel.org>; Tue, 29 Nov 2022 03:30:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235287AbiK2Dao (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 28 Nov 2022 22:30:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50752 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229932AbiK2Dan (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 28 Nov 2022 22:30:43 -0500
Received: from mail-pg1-x535.google.com (mail-pg1-x535.google.com [IPv6:2607:f8b0:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7FA5842F5F
        for <git@vger.kernel.org>; Mon, 28 Nov 2022 19:30:42 -0800 (PST)
Received: by mail-pg1-x535.google.com with SMTP id w37so6671689pga.5
        for <git@vger.kernel.org>; Mon, 28 Nov 2022 19:30:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=5xDy65sgxU3TnZmAQMPDWPDalNiHo+NbhwdMsDbKQBU=;
        b=UHHA/RlkEy8rfPS5sjuj63dckjhkSBNncWYIqTuBnJ/kBdI2PmxspbyK19XZfMi4kf
         ZutU0GORbM3piB9xlSHYuL6jS3LBzyjRvye5C6tGORXHcviNq9pobc+ddz8pIzDQZkz6
         CqtXusrhm+3/HQL400RkwTpxCOdx8+ysco2EGQxgWDttGCgvV7KXqEiBNibt6uRAl7dn
         VF9t9dOBmgVG1ubS1AVQTAxGcJbgPEiD0f7RO3VHydWkA4U4eUTuix9GU9OidioPXsYh
         qxGXPbs++bvZMlIgk+Fqx/TJZ92bOnoNKSFC+zCknkHtmFpEGaAOTUBsGPqSOaX1WydF
         /Cvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=5xDy65sgxU3TnZmAQMPDWPDalNiHo+NbhwdMsDbKQBU=;
        b=0SauypRIHpNHdee9XQDTvdfSasB27glqAzaBwzKsbfFh82M8TPfS+gTTgaVTRrl8m0
         lzdu2yGrtFJp5uFt7LowNQnlsugOC+hs7Qvz49OP5lr/PK0xjKZj/GZtbLwbcV95sZu0
         vmsu1qh+eAD3wQkhamX8nc3jEslVLQEFNeLRiw2kLCxQT0pevjevAyaSxVyQIyDn2nRI
         Xcr5q2yjVGl0e8aDzzHdGD1ZP1S0tdotUa5UIQHFb7VprTGw5ImbmnhNpF8lZaX3HLYd
         Rlzx1JlNTBgMyZ44938KnKa06JpmyoJQnj1157pQx99t9Z+rsTWwKO+Y0dRrJ0DiZXMC
         pHaA==
X-Gm-Message-State: ANoB5pn96LmM8eQaQC0v8bYA3R/h4Yu3/s6BJI82rgpMniz/TgCHbBqx
        X5XNFuWAMWtwJJvLODj/fT4=
X-Google-Smtp-Source: AA0mqf680KC8f80uPCbAnySKWvXx4n5Xi0w7hXvxrqLAs/PTofFVKf3M7Wk52XyZp8h5Fz1mRKX3fA==
X-Received: by 2002:a63:dd13:0:b0:46e:ccbd:b136 with SMTP id t19-20020a63dd13000000b0046eccbdb136mr34509850pgg.515.1669692642048;
        Mon, 28 Nov 2022 19:30:42 -0800 (PST)
Received: from [192.168.43.80] (subs28-116-206-12-33.three.co.id. [116.206.12.33])
        by smtp.gmail.com with ESMTPSA id 19-20020a621913000000b005748029bab8sm8717936pfz.156.2022.11.28.19.30.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 28 Nov 2022 19:30:41 -0800 (PST)
Message-ID: <a1e9449c-80b4-782d-faed-f2ae45420015@gmail.com>
Date:   Tue, 29 Nov 2022 10:30:38 +0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
Subject: Re: [PATCH] git-compat-util.h: Fix build without threads
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Cc:     git@vger.kernel.org, Fabrice Fontaine <fontaine.fabrice@gmail.com>,
        Jeff King <peff@peff.net>
References: <20221125092339.29433-1-bagasdotme@gmail.com>
 <221126.86lenymw7p.gmgdl@evledraar.gmail.com>
Content-Language: en-US
From:   Bagas Sanjaya <bagasdotme@gmail.com>
In-Reply-To: <221126.86lenymw7p.gmgdl@evledraar.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 11/26/22 06:47, Ævar Arnfjörð Bjarmason wrote:
> Per f43cce23add (git-compat-util: add fallbacks for unlocked stdio,
> 2015-04-16) wouldn't it make more sense to do something like:
> 
> #ifdef NO_FLOCKFILE
> #undef _POSIX_THREAD_SAFE_FUNCTIONS
> #endif
> 
> Or the other way around here? I.e. have _POSIX_THREAD_SAFE_FUNCTIONS
> define/undefine NO_FLOCKFILE?

From the commit you mentioned, I think that above is OK. However,
because I'm no C expert, I'm unsure whether I should go with #undef
suggestion alone or #undef following by no-op declaration below #endif.

Thanks.

-- 
An old man doll... just what I always wanted! - Clara

