Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C7E2C2B9F4
	for <git@archiver.kernel.org>; Mon, 28 Jun 2021 06:49:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 71D5F6145C
	for <git@archiver.kernel.org>; Mon, 28 Jun 2021 06:49:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231754AbhF1Gv5 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 28 Jun 2021 02:51:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46336 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230134AbhF1Gv5 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 28 Jun 2021 02:51:57 -0400
Received: from mail-pg1-x52f.google.com (mail-pg1-x52f.google.com [IPv6:2607:f8b0:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 53E42C061574
        for <git@vger.kernel.org>; Sun, 27 Jun 2021 23:49:31 -0700 (PDT)
Received: by mail-pg1-x52f.google.com with SMTP id m2so14625238pgk.7
        for <git@vger.kernel.org>; Sun, 27 Jun 2021 23:49:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=HY45+Kz1GgGUUFX13cW8r5gqhejcf8w9rjsARjW92Hk=;
        b=K+0aEEGoWuWdmQmL8WDMu1VGWdkrIaPPOb2cUmWiUiBknrFesWvUwFnxfkJN9Vt/32
         ZsBdBBDOdl2BT89H2ckYvM1531gdVwni7NgKkH8b7VVKkbGPnFOMaWXhh/VCC2vTp4C2
         N38Wv1Atwjpi6dxxVBTVI6r5hILu3r5re9rF95JpAZTYV31SFC2bfAsQK4hqG9TPC6HH
         hjspeNclY6DRvttfPBbh/6Szm3fBkLG8BZ5d0gXYcahoYyBNjhICtdVw7FkFABMOPqFP
         G4wFkveV9YMku7QlvgWEwW+NB068gHQBQvR6v3FhVNajfYpk9yk56uWl3ek3igQpLvSl
         EuNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=HY45+Kz1GgGUUFX13cW8r5gqhejcf8w9rjsARjW92Hk=;
        b=CdKyBktnujZuBcxnH/8EhYDNWbqA1tFE8qTPaPrLVN2BVST7ZaBf0hdUGGo/RBscqp
         fRsv6XJRSa+il7fOh3sLMVb28ac4/KfOTqUQWDMb17hLGS+LfG/lqkeRj9DWFjwJsdHL
         rIIDyDgnSR0jkkXS4WUA+a3ckam6ccuqLLI2GtqfGR04IwJeD/Dlu8nnA/xUIzMyE6mn
         5U1MdSxf9N29IXcLXR7qWTy93JXoplqh4TGfPX6ydxF/snvyMeZd+w5MH+OZjJx36IYu
         g/kk0Xz3vrRt5Ii1fcdBIwtrDyIoopQkID0RqH8W+BIE1N8N5z35U6C2IzhU0fkR6VvY
         0W5Q==
X-Gm-Message-State: AOAM530NldtIhctekr0HeeHzJsUe97LYwoCDVydB6NfIJCXgvKo9qv0e
        3UzsiMrAYqG2cRv4UP0dwgk=
X-Google-Smtp-Source: ABdhPJyQzT6S+FU7PrpYB9ynoxok9JBF5SqoIFCgbPlGdhSg7Re+gdx1VpMNPd24RIv8pALaq7GC/w==
X-Received: by 2002:a65:668e:: with SMTP id b14mr8818237pgw.164.1624862970663;
        Sun, 27 Jun 2021 23:49:30 -0700 (PDT)
Received: from [192.168.43.80] (subs02-180-214-232-79.three.co.id. [180.214.232.79])
        by smtp.gmail.com with ESMTPSA id e4sm12828230pfa.29.2021.06.27.23.49.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 27 Jun 2021 23:49:30 -0700 (PDT)
Subject: Re: [PATCH v6 02/15] [GSOC] ref-filter: add %(raw) atom
To:     ZheNing Hu via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Christian Couder <christian.couder@gmail.com>,
        Hariom Verma <hariom18599@gmail.com>,
        Jeff King <peff@peff.net>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        ZheNing Hu <adlternative@gmail.com>
References: <pull.980.v5.git.1624636945.gitgitgadget@gmail.com>
 <pull.980.v6.git.1624797350.gitgitgadget@gmail.com>
 <d9bc50c4ae699d0516581ac67a2d7b602d2e61a4.1624797351.git.gitgitgadget@gmail.com>
From:   Bagas Sanjaya <bagasdotme@gmail.com>
Message-ID: <a1c8f663-ebe5-1145-960d-aad9dc07d86c@gmail.com>
Date:   Mon, 28 Jun 2021 13:49:10 +0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <d9bc50c4ae699d0516581ac67a2d7b602d2e61a4.1624797351.git.gitgitgadget@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 27/06/21 19.35, ZheNing Hu via GitGitGadget wrote:
> +Note that `--format=%(raw)` can not be used with `--python`, `--shell`, `--tcl`,
> +`--perl` because the such language may not support arbitrary binary data in their
> +string variable type.
> +

s/the such language/such languages/

Thanks.

-- 
An old man doll... just what I always wanted! - Clara
