Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BAA20C43460
	for <git@archiver.kernel.org>; Mon, 17 May 2021 05:58:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 957BF610E9
	for <git@archiver.kernel.org>; Mon, 17 May 2021 05:58:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233099AbhEQF73 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 17 May 2021 01:59:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37452 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233034AbhEQF72 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 17 May 2021 01:59:28 -0400
Received: from mail-pf1-x436.google.com (mail-pf1-x436.google.com [IPv6:2607:f8b0:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A296AC06174A
        for <git@vger.kernel.org>; Sun, 16 May 2021 22:58:08 -0700 (PDT)
Received: by mail-pf1-x436.google.com with SMTP id x188so4202144pfd.7
        for <git@vger.kernel.org>; Sun, 16 May 2021 22:58:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=u/VBYog8Df8wa4IQbF/Nf8HCU0dKe30rfWd64633xR8=;
        b=XD+yDXPnqA32aYAbxgWttzUcpi4raGIBwMHaE+a0sCNmeXmjJJuh2XuAJ5WP6HEh3w
         JMrsp560VqQjp9DCMBKk6/2PSfEjh7k1ST3kueoJT6iiLKW62/BIemc7wli4eKj+T8gS
         WQe2D705shGTVhRIGQ73S2+ve6J+GC0UmiviW2cjGQXBj7DWseEBiuYVdXefGoj0BF7o
         5fmzyc9iw4HkOheCwlJuY1MMMAdaGU9/0NUf8nZvz6uLOWjBeWO4Fi+5G/hRufZZ2k1k
         qcEqY0qMKruqHxDvcRXLytE7W3Rl0pBjkozacYuQiqIuMa/agFFG4xI28cMWIS+yru/2
         buEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=u/VBYog8Df8wa4IQbF/Nf8HCU0dKe30rfWd64633xR8=;
        b=G8M6dfwdUwMea/g//sZlBTOQX9HggTU3di17EKWQWWiwgnttr9nEuZ6sI1XJH0p5Hh
         +PLJcN9JwZHMlvCsJCJ/qNjwmnhhMnkLW7vImiBBlbNwnwD624afbAJqhvd6LYYz7VFf
         +sT0Za/9JpTcmUKOzjjA9ARE9RrbQfI+3/vGXPFW11M5ZIuVf9WIbXE+AI6YcewUra3U
         0BWtjUJF8jJjHi9RP/kozrLTqk5QxiF+dkp712Xpq246A8BR9gcMOQGvTPJ1Rav7SkEX
         kzuPCyHOCOvUtldBREKSHlDHZCR9ljePMkAEC8hkmEETUMnkFngkYZ9MieNrcEMKhuDg
         F/CQ==
X-Gm-Message-State: AOAM530ZWiyjRv6yXqHdS+qqxPOkYAxAstC8G7/qaQfI3FAberSrsOIW
        WE6EcXT9U9gtUk2LH8NhDCI=
X-Google-Smtp-Source: ABdhPJwHZwMkc+N+9EZXC5Pj4LDs7C2DDTv11RAXbOspi55roHUtQ5zxSioOJPBqPCl6pitb1ruR7w==
X-Received: by 2002:a62:b403:0:b029:20c:cbd5:5be1 with SMTP id h3-20020a62b4030000b029020ccbd55be1mr58724443pfn.53.1621231088291;
        Sun, 16 May 2021 22:58:08 -0700 (PDT)
Received: from [192.168.43.80] (subs28-116-206-12-39.three.co.id. [116.206.12.39])
        by smtp.gmail.com with ESMTPSA id m6sm6059093pfc.133.2021.05.16.22.58.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 16 May 2021 22:58:07 -0700 (PDT)
Subject: Re: [PATCH] submodule: use the imperative mood to describe the
 --files option
To:     Alex Henrie <alexhenrie24@gmail.com>, git@vger.kernel.org,
        pc44800@gmail.com, chriscool@tuxfamily.org, stefanbeller@gmail.com,
        kaartic.sivaraam@gmail.com, Johannes.Schindelin@gmx.de,
        shouryashukla.oo@gmail.com, gitster@pobox.com
References: <20210516215957.33341-1-alexhenrie24@gmail.com>
From:   Bagas Sanjaya <bagasdotme@gmail.com>
Message-ID: <1cfb25fd-1ef9-864c-bbb3-bab0a5676728@gmail.com>
Date:   Mon, 17 May 2021 12:58:03 +0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <20210516215957.33341-1-alexhenrie24@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Alex,

On 17/05/21 04.59, Alex Henrie wrote:
> -			 N_("to compare the commit in the index with that in the submodule HEAD")),
> +			 N_("compare the commit in the index with that in the submodule HEAD")),

Seems correct.

FYI, on my native language (Indonesian), we say "Review yourself" as
"Tinjau dirimu" for imperative mood. Unfortunately many imperative
sentences on software l10n instead prefix the verb with "me-", such as
"meninjau dirimu". That is not imperative mood; that is descriptive
mood with infinitive verb form.

Anyway, thanks.

Reviewed-by: Bagas Sanjaya <bagasdotme@gmail.com>

-- 
An old man doll... just what I always wanted! - Clara
