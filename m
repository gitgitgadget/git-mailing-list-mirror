Return-Path: <SRS0=BZy3=CN=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D93EC43461
	for <git@archiver.kernel.org>; Fri,  4 Sep 2020 14:40:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BE077206F2
	for <git@archiver.kernel.org>; Fri,  4 Sep 2020 14:40:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NxbV+kPq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730460AbgIDOkF (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 4 Sep 2020 10:40:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33516 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730429AbgIDOkA (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 4 Sep 2020 10:40:00 -0400
Received: from mail-ot1-x335.google.com (mail-ot1-x335.google.com [IPv6:2607:f8b0:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10583C061244
        for <git@vger.kernel.org>; Fri,  4 Sep 2020 07:39:55 -0700 (PDT)
Received: by mail-ot1-x335.google.com with SMTP id i4so6077351ota.2
        for <git@vger.kernel.org>; Fri, 04 Sep 2020 07:39:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=hW7SaMMLEOn9jtPA/DhxmhNUgG+EdbiDFaDb9dttnW8=;
        b=NxbV+kPqtbutygbIBkvyAGXABzb63w2WY0osEfJfg7Bf2YMd4E3PurIwCwPw2+Iw3b
         6fpYddjW6kUvUeD4K+YW/3A8mHIPKUO8Gw4Nd4ZwhsxLEkCxyEU33STw2UCWJ39lzof0
         a7wWPSkSs0nK7AWfRiUa4Vud/agnVacQ05Gg36Rj9GGa7P2mB1ByuQy+CjY3WYi4LYQb
         XpmfI3fD4B8imXR03qSS5L7iYAOk4dmZJb/fPvNz2Ni93Vons4kuqrp2pTZ1Hw2pOTl8
         YrNovxlfTLtjXPAIMLjE1NS5+iifDlveioPr1yDcrSCcSTSECD+RdgmYUK8jJz8CNtU2
         UY0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=hW7SaMMLEOn9jtPA/DhxmhNUgG+EdbiDFaDb9dttnW8=;
        b=qaMGoLxFZwcHa4+MK6fvLNCpstOGqoW6nsQ4k8CBvL5z5lGAGXTTrs8/7h/K4mclu9
         F1ZqtA5zdbMVltbCVWTqWtnlH364WBORS0LSdLLcnkWZByIIIZFERdpjt5UwXde9Bi3H
         1fVCiPWm1c6b2oJwq5zjmi0PLnPusbnu+Sg36gvFKAN+UaZ7miE6/83ZkF9fZFrigLFL
         IXs3vWAtq8AEk8cNLYIrgiqohgW9fgACqUOVv9tFNaRKudskDsv4UPloRzM9EIlxdJL1
         urlVE3yzglzB7lUevTc8sUbQpO2SC3o+l2m/M3kiJjURvZVjwZVczbl1Fj6b5pkECi3b
         ig2g==
X-Gm-Message-State: AOAM533FDoFyLIMlKVpGZSuncyNr+4fsonKv+mEh8LBgSCUEUoA2bnjK
        KBFW+dsz7Gh4gN39edU93Ak=
X-Google-Smtp-Source: ABdhPJyehF+NztYRTZjJCexIOmWTX5Lsli8mbGQCUKkcyBoZZ3h727qTlehVVX6mHs7kLDG3oHroVA==
X-Received: by 2002:a9d:345:: with SMTP id 63mr5725990otv.370.1599230392313;
        Fri, 04 Sep 2020 07:39:52 -0700 (PDT)
Received: from ?IPv6:2600:1700:e72:80a0:9d24:4e0e:f042:c574? ([2600:1700:e72:80a0:9d24:4e0e:f042:c574])
        by smtp.gmail.com with ESMTPSA id c15sm1163587oiy.13.2020.09.04.07.39.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 04 Sep 2020 07:39:51 -0700 (PDT)
Subject: Re: [PATCH v4 00/14] more miscellaneous Bloom filter improvements
To:     Taylor Blau <me@ttaylorr.com>, git@vger.kernel.org
Cc:     dstolee@microsoft.com, gitster@pobox.com, peff@peff.net,
        szeder.dev@gmail.com
References: <cover.1596480582.git.me@ttaylorr.com>
 <cover.1599172907.git.me@ttaylorr.com>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <30fbea4f-651e-11c9-c782-ab5fe645ec1c@gmail.com>
Date:   Fri, 4 Sep 2020 10:39:50 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:81.0) Gecko/20100101
 Thunderbird/81.0
MIME-Version: 1.0
In-Reply-To: <cover.1599172907.git.me@ttaylorr.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 9/3/2020 6:45 PM, Taylor Blau wrote:
> Things seem to have settled down since the review in v3, so I'm hoping
> that this is what will end up being queued.
I haven't paid close attention to this topic, but I took a close
look at v4 and found nothing to improve. I'm happy with this
version.

Thanks,
-Stolee
