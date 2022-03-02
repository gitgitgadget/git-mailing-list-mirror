Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7839C433EF
	for <git@archiver.kernel.org>; Wed,  2 Mar 2022 20:36:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238125AbiCBUhY (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 2 Mar 2022 15:37:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51284 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231263AbiCBUhX (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 2 Mar 2022 15:37:23 -0500
Received: from mail-oi1-x236.google.com (mail-oi1-x236.google.com [IPv6:2607:f8b0:4864:20::236])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1B5AB65DB
        for <git@vger.kernel.org>; Wed,  2 Mar 2022 12:36:38 -0800 (PST)
Received: by mail-oi1-x236.google.com with SMTP id a6so2859290oid.9
        for <git@vger.kernel.org>; Wed, 02 Mar 2022 12:36:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=github.com; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=AZvl9IxzRrLNRAXxteesuk1RjgYTQU/IZeN7uXOmiKw=;
        b=VRapVmN+QGJ94/a9FYPYlCfPaI0+oDqj6ftaaROlTQCCctjRAe6Cxkm3QiOGGSR8pV
         tpIze7CRjALsdsf1hRxTj6D5pE0QTBGMhF+zthet18md7NVgY9DhwOF8bazrWZ30XHZg
         1SO5QG5j/NFMbzY78Fs0yK3u5ebQZdFoevgSrMMqoTfLccoQKk0t0oUaH1/nFhGuGzeA
         ZPpERNNHqGTbaJDWXfONENgMBY09UBhDYcd6/uZ/zFWgWRooWrKLhB2jLdyqlHf5JhsU
         k3A3Wz16NxcZak2zUw7UYqBv7PN9XBLXaqMtddbAeO9+Z8zLsfjyzfBPuNH4dOtXK61o
         LpDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=AZvl9IxzRrLNRAXxteesuk1RjgYTQU/IZeN7uXOmiKw=;
        b=hNx8x1JhjldXGaf/Ho1lvwJSsPUt0g2j/C1NL6zqJBpitePUe/7Gcz3VsAZwi+k5Cm
         4KYtyBJCVXfjTCC+M+q8CcXe0ktfCpY/bQqyxVNwxB2Qvh/rvvo36V7KQnzZqV6bjZCJ
         kqH+hi6gOX+V7T0pGWGTKdrjNEehYZtMkDXJOV6gxXLvLeFYBXNvkzNegLVmuEEwybVt
         CdU/bNkNTL/74SGaJfYYD6y48AlIFozXmQChCZHxOZv3JHJhWbHGN2wSWwkcHPtUbg42
         y4K3Z/n8n7V2A9O8LesnQZQBToMkY566ficFsThMKkchXBn611+Y+ZR3Vzbq1mvKWwlG
         K/qQ==
X-Gm-Message-State: AOAM5334uKdTHYTAtKPuZsmkwS08UQbqKBHovKPxL/6nJVn1BY/U42OU
        KBuzGQSuwLfRGc87/6LGtveCNDERlVMT
X-Google-Smtp-Source: ABdhPJy1gU//T8cuiat+ZCDJxUQDVdxV3q2LgWeIlWGFjtPY6aLvCpaN3S4RDRWexZA7Z8hdqmDr3w==
X-Received: by 2002:a05:6808:1a18:b0:2d3:a839:9a63 with SMTP id bk24-20020a0568081a1800b002d3a8399a63mr1539132oib.49.1646253398226;
        Wed, 02 Mar 2022 12:36:38 -0800 (PST)
Received: from [192.168.1.110] ([99.85.27.166])
        by smtp.gmail.com with ESMTPSA id en9-20020a056870078900b000d0f290ec95sm56047oab.42.2022.03.02.12.36.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 02 Mar 2022 12:36:37 -0800 (PST)
Message-ID: <e3ad8853-a33d-a70b-4ace-92873c9d1401@github.com>
Date:   Wed, 2 Mar 2022 15:36:36 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.1
Subject: Re: [PATCH 01/14] index-pack: fix memory leaks
Content-Language: en-US
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>
References: <cover-00.14-00000000000-20220302T170718Z-avarab@gmail.com>
 <patch-01.14-bcba06e1d28-20220302T170718Z-avarab@gmail.com>
From:   Derrick Stolee <derrickstolee@github.com>
In-Reply-To: <patch-01.14-bcba06e1d28-20220302T170718Z-avarab@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 3/2/2022 12:10 PM, Ævar Arnfjörð Bjarmason wrote:
> Fix various memory leaks in "git index-pack", due to how tightly
> coupled this command is with the revision walking this doesn't make
> any new tests pass, but e.g. this now passes, and had several failures before:
> 
>     ./t5300-pack-object.sh --run=1-2,4,6-27,30-42

Do you mean that these tests now pass under leak check?
 
> it is a bit odd that we'll free "opts.anomaly", since the "opts" is a

s/it/It/

> "struct pack_idx_option" declared in pack.h. In pack-write.c there's a
> reset_pack_idx_option(), but it only wipes the contents, but doesn't
> free() anything.
> 
> Doing this here in cmd_index_pack() is correct because while the
> struct is declared in pack.h, this code in builtin/index-pack.c (in
> read_v2_anomalous_offsets()) is what allocates the "opts.anomaly", so
> we should also free it here.

Makes sense. Code diff looks good.

Thanks,
-Stolee
