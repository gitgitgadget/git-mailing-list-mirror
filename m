Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D58CC48BDF
	for <git@archiver.kernel.org>; Thu, 24 Jun 2021 04:16:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 34E00613CF
	for <git@archiver.kernel.org>; Thu, 24 Jun 2021 04:16:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230159AbhFXES4 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 24 Jun 2021 00:18:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46696 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230156AbhFXESS (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 24 Jun 2021 00:18:18 -0400
Received: from mail-pg1-x52b.google.com (mail-pg1-x52b.google.com [IPv6:2607:f8b0:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B18F5C0617A8
        for <git@vger.kernel.org>; Wed, 23 Jun 2021 21:14:13 -0700 (PDT)
Received: by mail-pg1-x52b.google.com with SMTP id u190so3634433pgd.8
        for <git@vger.kernel.org>; Wed, 23 Jun 2021 21:14:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=Ao+IdF7MKU5VKBwayf7uMFcBp5mgRBEQG0PgC9l3G4E=;
        b=jZgb2QdclsvD2CIhTSnPweMT3NhpIayogfG+bNLA6a0TImqYqEfOL6L5fY/lN4ujt+
         ZltNZYUdYO1jqrjhEu7zLLXN25iDJ/jkf20MZLtsC1vz52LnLlf5O50RU46lJpWt71Sy
         ZKbsMdkkx4CjtYUbb0OBxeNVyPLmly/71shwoY5dOaR6kWJBe121yfZ5IFCeLXoRiZjR
         cC0Wn6sEpKL/+JQT63eghRAVFFTzvmXG362XR3zy+lFCDRuaVScc2Osq79ZZwkHr2nk4
         mcgWXZayT5lRkuGRvub0jiKHXKfyzk43l/s5Or9DnVhNdHAR/8XkkZG/rV2avfpi5VAL
         dMbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Ao+IdF7MKU5VKBwayf7uMFcBp5mgRBEQG0PgC9l3G4E=;
        b=NU43v8KK/NvguhaD4nokGGI1gAVD8DgIr7Khvu7Jt8bjRzzMCuyk5oganZfc+10W7o
         3EjPK+dJRrg5uPfDihT86AnrvNBblKdbvpFwkDHMfqo09Q8Nr6JXdT3V7BWehehFSvty
         sEyzREz7tvmp8xx8hz2rjAxgsKbPXAz6X77Ta7rz+PaMoKZau19o144f484ImOC95o8m
         7TveIltzEPyC5ZNz6TotMCzNxmVIKjMTzhzpWh8DPN1jyDXd3YKpeQyzb9aHG2hX1dXz
         OS+v1rb1g+tdzCBlubRdPpbwnYAPM/uSQvXzCuHRli89Nt4gFB3pLUTfzNhuqNiLMTyy
         aXgw==
X-Gm-Message-State: AOAM530AZkGcdDT8QkNKf2r48xIUgVXp5uB2NexbiTC/VcOxoVk/OGSU
        +WwawA90muxUodaZuMbODKk=
X-Google-Smtp-Source: ABdhPJwmvnAxaO2G3S8jsINCuuusL+KwUqJmEMFnJviUTdzGQoaz+PxBktp30hy18iSqqzXoW+eX6g==
X-Received: by 2002:a62:8647:0:b029:302:4642:ae52 with SMTP id x68-20020a6286470000b02903024642ae52mr2868487pfd.7.1624508053123;
        Wed, 23 Jun 2021 21:14:13 -0700 (PDT)
Received: from [192.168.43.80] (subs09a-223-255-225-70.three.co.id. [223.255.225.70])
        by smtp.gmail.com with ESMTPSA id o1sm1225490pfk.152.2021.06.23.21.14.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 23 Jun 2021 21:14:12 -0700 (PDT)
Subject: Re: [PATCH v4 02/14] [GSOC] ref-filter: add %(raw) atom
To:     ZheNing Hu via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Christian Couder <christian.couder@gmail.com>,
        Hariom Verma <hariom18599@gmail.com>,
        Jeff King <peff@peff.net>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        ZheNing Hu <adlternative@gmail.com>
References: <pull.980.v3.git.1624086181.gitgitgadget@gmail.com>
 <pull.980.v4.git.1624332054.gitgitgadget@gmail.com>
 <ab497d66c1167981181173f19cfe7d8857c348a3.1624332054.git.gitgitgadget@gmail.com>
From:   Bagas Sanjaya <bagasdotme@gmail.com>
Message-ID: <7c43f6d4-7940-de5e-f424-a2ea50739b66@gmail.com>
Date:   Thu, 24 Jun 2021 11:14:07 +0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <ab497d66c1167981181173f19cfe7d8857c348a3.1624332054.git.gitgitgadget@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 22/06/21 10.20, ZheNing Hu via GitGitGadget wrote:
> Beyond, `--format=%(raw)` cannot be used with `--python`, `--shell`,
> `--tcl`, `--perl` because if our binary raw data is passed to a
> variable in the host language, the host language may not support
> arbitrary binary data in the variables of its string type.

Better say:

"Note that `--format=%(raw)` cannot be used with `--python`, `--shell`, 
`--tcl`, and `--perl` because if the binary raw data is passed to a 
variable in such languages, these may not support arbitrary binary data 
in their string variable type."

-- 
An old man doll... just what I always wanted! - Clara
