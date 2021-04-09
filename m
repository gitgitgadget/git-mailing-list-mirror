Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B28FC433B4
	for <git@archiver.kernel.org>; Fri,  9 Apr 2021 09:49:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3423C61181
	for <git@archiver.kernel.org>; Fri,  9 Apr 2021 09:49:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232752AbhDIJtw (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 9 Apr 2021 05:49:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51530 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232651AbhDIJtv (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 9 Apr 2021 05:49:51 -0400
Received: from mail-pf1-x436.google.com (mail-pf1-x436.google.com [IPv6:2607:f8b0:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 73612C061760
        for <git@vger.kernel.org>; Fri,  9 Apr 2021 02:49:38 -0700 (PDT)
Received: by mail-pf1-x436.google.com with SMTP id q5so3869047pfh.10
        for <git@vger.kernel.org>; Fri, 09 Apr 2021 02:49:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:references:cc:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=iAts8uuMW1fTzdfr/9MogfPY/7wCzpYoGrf6dRXBk0Q=;
        b=kqqMbC3IT/UPbXA4NXFTLncR27nffstk2wJjF2DJMIabVg5UJ6i4IVKOFJf+Bp0O4l
         PA8rpABsN9tRsC68iYsJC608Ilc3Tb+Sh5Dm5gK0PL98Zpf+wVeBI9GEsHO/07TP4HH/
         35htLtGzgXpO/dVqNw1sRB40h4XBWTjyJVhJ3S6w916xmaHhpMYkUsfQuVW/Z+rd0lKE
         qQTv0EBbKBMmT7ojgWrtvKT80Q0z48ImonIuwttURH/Lh6gohdVKSXd2XHdiRLSbTgnb
         H1uTKbJ9voU2ay28w8d9kzcoupD5DOs1xL+uKRE+xOvTSid8XRgzqOIrA/9JYISxqSZz
         tAwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:cc:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=iAts8uuMW1fTzdfr/9MogfPY/7wCzpYoGrf6dRXBk0Q=;
        b=Oln63Mo+3cFFJ6FcbGHhYfQusDzRgKZlLxSn7M847GivDjHgLk0H0w49jH+49o34gn
         zO0gvErRKXxb++PGTEBmFtER7BCRd3kD8AdQTtkC34lLf8vDBxarveUujq4YGdhEsmFa
         Du8SYcTVHrbbWpmcDPvnUeIs9KTc0OWaNEJIFYtqSBK7z2R9N22IDbWHtSTEXBkOkcz3
         KyIwwdQirh8V1bRLre0MPdrmTJzsad9/xkaZl8GC1rQHTLfcT6BWXNw6szxzFUR4kS6C
         HyVRbivvOItKxhVdoHGVAuUiWcYitTl94A0n26uLuoHJVYmmE6F5tCw1h1KPROcFDjt1
         cTsA==
X-Gm-Message-State: AOAM530MLTaqTg4sX4n3A1hn8x3hdhfvMCgQAlWWhFw5TjK20dsVniF/
        mcG1hZ28deQmsI59rRXzIDdpm4xu4T+pOg==
X-Google-Smtp-Source: ABdhPJzA8zjHarknhGAShfT9XOSRezrN8dA4fF7rSF4cYq85FUNAvbUpZnSb8M/5SUXl7NmwYEKwTA==
X-Received: by 2002:a63:d704:: with SMTP id d4mr12084802pgg.221.1617961777846;
        Fri, 09 Apr 2021 02:49:37 -0700 (PDT)
Received: from [192.168.43.80] (subs02-180-214-232-9.three.co.id. [180.214.232.9])
        by smtp.gmail.com with ESMTPSA id d17sm1894728pfo.117.2021.04.09.02.49.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 09 Apr 2021 02:49:37 -0700 (PDT)
Subject: Re: [RFC PATCH v1 01/13] doc: typeset command-line options in
 monospace
To:     Firmin Martin <firminmartin24@gmail.com>
References: <20210409040301.3260358-1-firminmartin24@gmail.com>
 <20210409040301.3260358-2-firminmartin24@gmail.com>
Cc:     Git Users <git@vger.kernel.org>
From:   Bagas Sanjaya <bagasdotme@gmail.com>
Message-ID: <8a44cb3d-d1ce-a3dc-82da-69a65d5baac2@gmail.com>
Date:   Fri, 9 Apr 2021 16:49:34 +0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.9.0
MIME-Version: 1.0
In-Reply-To: <20210409040301.3260358-2-firminmartin24@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 09/04/21 11.02, Firmin Martin wrote:
>   help.browser, web.browser and browser.<tool>.path
>   ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>   
>   The `help.browser`, `web.browser` and `browser.<tool>.path` will also
>   be checked if the 'web' format is chosen (either by command-line
> -option or configuration variable). See '-w|--web' in the OPTIONS
> +option or configuration variable). See `-w`|`--web` in the OPTIONS

Why not `-w | --web`?

-- 
An old man doll... just what I always wanted! - Clara
