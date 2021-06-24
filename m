Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A59CEC49EA6
	for <git@archiver.kernel.org>; Thu, 24 Jun 2021 04:03:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8E1DD613CE
	for <git@archiver.kernel.org>; Thu, 24 Jun 2021 04:03:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229932AbhFXEFw (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 24 Jun 2021 00:05:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43958 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230046AbhFXEFp (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 24 Jun 2021 00:05:45 -0400
Received: from mail-pg1-x52c.google.com (mail-pg1-x52c.google.com [IPv6:2607:f8b0:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F31BC061756
        for <git@vger.kernel.org>; Wed, 23 Jun 2021 21:02:44 -0700 (PDT)
Received: by mail-pg1-x52c.google.com with SMTP id m2so3611222pgk.7
        for <git@vger.kernel.org>; Wed, 23 Jun 2021 21:02:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=Ln3/WFM/dVBa1VjG86PcSddukAseRWpUyltzOoKwvwc=;
        b=BBsmTmsdF1H0DB2YzMpDeU91lQ2JhdKCgrOAyzsgZ8THJWN17k1qwU5UddM3ABVoQt
         K79B5mmR2A1n7YYyQ3gMVhozXnESt7gTX16F6raTcO/+vJlVTWEMzcpQLPpW8O/6/Lwh
         SYGe/EjB5SFFcCOkrRH1CLOKZWN/s3oC6hzvOUdGDzXJUGko7iCOSXw7WOlMmnxXMfgn
         j87bpMmjhgLF1AXO408Nj6ZqueFzVu1hdkV+2SGYB63CpkUH98BOgPocLyLeY8nf9wPl
         yC7zyx5y8xuuW+Ze8bGJSNUah/k8pZmhtfpj3KZJScbHSjRhIuDYw3ZH7ZtasKcRdYys
         HqMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Ln3/WFM/dVBa1VjG86PcSddukAseRWpUyltzOoKwvwc=;
        b=KYH7xzf0tKy46QY9zwmeApDnkfXr4MyDSMjqKEKGsySPo4vVo2drADOy4fJNQCKAmQ
         9/eFPHGzhRMO/2DgdWTlyCpHVGYB/pqDcBEfV72zSH8GxWrx/EHtTOYYpWggpjot1O5C
         rd8sMR2w3gyCl+P3GR5e/1kAG0zAhL4XnOE7VvDXXznhZcGSIOjphQDUjdXJw4tFEwvg
         vXBkFOQlVBws8jNJW8cvMymyEVICUey3d9Ps5gTzmq8UG39w+Ba/HF0s1ILpHou6C29b
         dR/cmi8BTwd/8T1ZpADYWPqaF+aLM0rxeOuI8PUcdinfw/hF35519s+LeyIpMbj61nOC
         0XpQ==
X-Gm-Message-State: AOAM533ACx1DgD4em+7crGvntbBzks0t/gKx1MZRU5EOnuGI8Y/Y0lSc
        qNNF+7+KXQ/NOfqEkqcSgKo=
X-Google-Smtp-Source: ABdhPJw0fD/dC+M/KFKjmGmUIOCgPv3EB3FgTIxv68bzt77OlKzeU5opwUZH0pHBpfJlOFHPBTQ0qQ==
X-Received: by 2002:a63:2cc4:: with SMTP id s187mr2810961pgs.233.1624507363714;
        Wed, 23 Jun 2021 21:02:43 -0700 (PDT)
Received: from [192.168.43.80] (subs09a-223-255-225-70.three.co.id. [223.255.225.70])
        by smtp.gmail.com with ESMTPSA id b21sm622033pgj.74.2021.06.23.21.02.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 23 Jun 2021 21:02:43 -0700 (PDT)
Subject: Re: [PATCH v4 06/14] [GSOC] ref-filter: pass get_object() return
 value to their callers
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
 <05682bccf9f947ce77ad035c02038286d0661c35.1624332055.git.gitgitgadget@gmail.com>
From:   Bagas Sanjaya <bagasdotme@gmail.com>
Message-ID: <4bce3cc5-e027-fa85-f400-df529e370a2b@gmail.com>
Date:   Thu, 24 Jun 2021 11:02:36 +0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <05682bccf9f947ce77ad035c02038286d0661c35.1624332055.git.gitgitgadget@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 22/06/21 10.20, ZheNing Hu via GitGitGadget wrote:
> From: ZheNing Hu <adlternative@gmail.com>
> 
> Since in the refactor of `git cat-file --batch` later,
> oid_object_info_extended() in get_object() will be used to obtain
> the info of an object with it's oid. When the object cannot be
> obtained in the git repository, `cat-file --batch` expects to output
> "<oid> missing" and continue the next oid query instead of letting
> Git exit. In other error conditions, Git should exit normally. So we
> can achieve this function by passing the return value of get_object().
> 

s/Since/Because/

-- 
An old man doll... just what I always wanted! - Clara
