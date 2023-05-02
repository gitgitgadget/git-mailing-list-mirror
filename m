Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28D42C77B7C
	for <git@archiver.kernel.org>; Tue,  2 May 2023 01:49:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233195AbjEBBtW (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 1 May 2023 21:49:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37488 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232991AbjEBBtU (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 1 May 2023 21:49:20 -0400
Received: from mail-yw1-x112e.google.com (mail-yw1-x112e.google.com [IPv6:2607:f8b0:4864:20::112e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4FF353AB4
        for <git@vger.kernel.org>; Mon,  1 May 2023 18:49:17 -0700 (PDT)
Received: by mail-yw1-x112e.google.com with SMTP id 00721157ae682-5529f3b8623so29738947b3.2
        for <git@vger.kernel.org>; Mon, 01 May 2023 18:49:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=github.com; s=google; t=1682992156; x=1685584156;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=NZmAL11R/dQh/FliSg75dkeLb1ccc4pWMaUb7WHnJZM=;
        b=NSs38PPQSYp/22DSN3EfdK/fwj/K05bjydGxp0qbdQjiQ3yw9yjPbivkdmJokEkRdM
         av7kl26uMRfnzeX+R42jbhmsXtFwmqonhOys6xoI4qcHf+SRgHMlgYixZyoi4dt4Taf5
         58vUXva8MVpS+keGwhF307Jd5Gmlme9ti1INZ8FUa8kizGfYyAR3U58XuG1Yrl2oqT8H
         S7/vYpsshSfsxZERZuM9dcGTZPV4E5x9iuJWlCBrLKtRUMyM4JLr+Z35Zw/SfZJaGFlB
         UEaKaU58VWqZZRo1X++ZVkU476E3Fswm7HtD34rWM6Vb7jfFUlh4jPFkUS0YKnaa5KDM
         e2rA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682992156; x=1685584156;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=NZmAL11R/dQh/FliSg75dkeLb1ccc4pWMaUb7WHnJZM=;
        b=HxCEu/1xziXG/5FHAj775TYRQYJMGvsAZcmHibDq7/gknL20jBoeGBDikM7sdHgJ0j
         WvX1jzsbEUgtrbe+dhGD0n7C1Pdcx+NcIyFBgQDNnN2wPkKAXo1pUAAknC9PXOQGoYN/
         tvTiM/I7+5r3PQ8QtHquDu625B68YwH7DiSRM9ovYgImGSvf6sIYm9aMPoXJPLI3yvMV
         crfKM/1Hp+Hnk9zsalAA5xLYjJ+4qRuHAyw69yMsMb7Tu85XD/uesq1ARDNcPKG5k1eo
         cKk3WIiYz/0CeLp38F5stTBssbkwqmOT5Cp2AK9zyYhsJhBM1KWpc7BgGaSaWfPcxX0D
         nX2w==
X-Gm-Message-State: AC+VfDwyfjDhIvV6NmOe+2aEqeuf2kldi2g8/UmZ6DXpTVqjH7haeLRF
        CrkJOkeuIjU0bY8OYBK1LCsY
X-Google-Smtp-Source: ACHHUZ4bTphnG07LAf0DNtwWofLLlgStk7JiUXmKn1rbjd8suzKoBd+Vlj4mjvYZzRl+4G+A1obgRg==
X-Received: by 2002:a0d:e201:0:b0:55a:6efe:8e2f with SMTP id l1-20020a0de201000000b0055a6efe8e2fmr3485158ywe.45.1682992156364;
        Mon, 01 May 2023 18:49:16 -0700 (PDT)
Received: from ?IPV6:2600:1700:e72:80a0:cc0f:b830:7250:64ca? ([2600:1700:e72:80a0:cc0f:b830:7250:64ca])
        by smtp.gmail.com with ESMTPSA id p6-20020a815b06000000b00545a081847fsm7686035ywb.15.2023.05.01.18.49.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 01 May 2023 18:49:15 -0700 (PDT)
Message-ID: <9ad5f246-e21f-0a13-1a53-1ae3307c3f0e@github.com>
Date:   Mon, 1 May 2023 21:49:14 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.1
Subject: Re: [PATCH v2 0/2] negotiator/default: avoid stack overflow
To:     Junio C Hamano <gitster@pobox.com>,
        Han Xin <hanxin.hx@bytedance.com>
Cc:     git@vger.kernel.org, xingxin.xx@bytedance.com,
        jonathantanmy@google.com
References: <cover.1682473718.git.hanxin.hx@bytedance.com>
 <cover.1682513384.git.hanxin.hx@bytedance.com> <xmqqildb3dnn.fsf@gitster.g>
Content-Language: en-US
From:   Derrick Stolee <derrickstolee@github.com>
In-Reply-To: <xmqqildb3dnn.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 5/1/2023 6:11 PM, Junio C Hamano wrote:
> Han Xin <hanxin.hx@bytedance.com> writes:
> 
>> This series avoid stack overflow in negotiator/default.c and memory leak
>> in negotiator/skipping.c.
>>
>> Changes since v2:
>> * Rewrite the commit link in the typical format.
>> * Fix the incorrect check for the COMMON bit introduced in v2.
> 
> I see Derrick pointed out a logic error during the review of v2 and
> this round corrects it.  Is everybody happy with this iteration and
> considers it safe to merge it to 'next'?

Sorry for the lack of confirmation on that. I do think the v3
patches are good (the cover letter says v2).

Thanks,
-Stolee
