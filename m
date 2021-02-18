Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D1F4C433E6
	for <git@archiver.kernel.org>; Thu, 18 Feb 2021 20:41:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2CF5064DF0
	for <git@archiver.kernel.org>; Thu, 18 Feb 2021 20:41:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231133AbhBRUlc (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 18 Feb 2021 15:41:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40926 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230267AbhBRUj5 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 18 Feb 2021 15:39:57 -0500
Received: from mail-qt1-x832.google.com (mail-qt1-x832.google.com [IPv6:2607:f8b0:4864:20::832])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2745C0613D6
        for <git@vger.kernel.org>; Thu, 18 Feb 2021 12:39:15 -0800 (PST)
Received: by mail-qt1-x832.google.com with SMTP id x3so2420197qti.5
        for <git@vger.kernel.org>; Thu, 18 Feb 2021 12:39:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:from:to:cc:references:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=znodbhcfxhJe3kbbqQm2/cA8rMggCH4OQMRklXazOLA=;
        b=q5KODLJraeww/gm//zGTb9nT/fx3HIUIetpHuv814iwDqzr4CcPm+Ig7YBGED+Us4K
         vtD9LvqwDJB8+6jf+opCLVvQf7YohJELg6ipF2XeTXwLW6xauzB/Wcd6TUPaOVXHWNAv
         IEZfukC9yOSbbL4vkyReC2XzXR/JPTHEU9WeCwkxNVfoDbd2w7lrTE15fvoYrBlDUktN
         Ix1a/skACoqjMcjH37qE7y3zRaUO8Re6hst6A3g+qw3fNHEqs/SMJj+VBx666TkMDp1a
         u/h5txxo3SENQY64YXbASvrVmr6Z2fiNt4blqUFLYoTJoqrBhQDbLUpKdrzrPa4gA4Q9
         ShIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:from:to:cc:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=znodbhcfxhJe3kbbqQm2/cA8rMggCH4OQMRklXazOLA=;
        b=a0KCKFWrDSyVwbBFJvzrO0BGVdbp8ej1c91g1tCBjS6e77zEBMunjtgcKObPMPcnuV
         DAHBKiU/tkUaUoSbw0uiPR41AxjdkWYNL8w/qvKZ8vcz5XV2MEkv+yETyU9cpXkRWUmq
         Gekhaa2ADFQ2E0ewVOqutkCUhnT2hI4u23fuhcky4ro1TYiHFXHgFhli5xQPDEyzmVXy
         zJQN3XRkYX2e/W1Fh7ytg09TdbMXgHlWCw/K3Mb+tY4Ip/rxs5zQm5b/LCvyuY3mqbIZ
         Cc+MgTcNDJDhbfsGO+MKTTvMjUx3hOUAAB4Ug+NvoCNGVLi3mfNG+d8UwvtHGFYMdLxP
         tPDg==
X-Gm-Message-State: AOAM531u0a81SmkLl5JfyTDqQayqdRs0J7hfI64eCkiD3sVKLQGtA90F
        UNfNxtbGbNO+HeAwwE2xas0=
X-Google-Smtp-Source: ABdhPJwklZpfHgg7ND4DkVvWWS7SS1OFHjQ5RNGpUJLFuiF5dVH9EsCOWEljPssTUVfES/yZ/v6t3w==
X-Received: by 2002:a05:622a:143:: with SMTP id v3mr5979962qtw.363.1613680754985;
        Thu, 18 Feb 2021 12:39:14 -0800 (PST)
Received: from [192.168.1.127] ([192.222.216.4])
        by smtp.gmail.com with ESMTPSA id x12sm4580854qkj.20.2021.02.18.12.39.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 18 Feb 2021 12:39:14 -0800 (PST)
Subject: Re: [PATCH 1/2] rm: changes in the '.gitmodules' are staged after
 using '--cached'
From:   Philippe Blain <levraiphilippeblain@gmail.com>
To:     Shourya Shukla <periperidip@gmail.com>, git@vger.kernel.org
Cc:     gitster@pobox.com, christian.couder@gmail.com,
        cousteaulecommandant@gmail.com
References: <20210218184931.83613-1-periperidip@gmail.com>
 <20210218184931.83613-2-periperidip@gmail.com>
 <0577f84b-f594-6b8a-76a2-29fb9453ee25@gmail.com>
Message-ID: <0c0b455b-ec00-7d78-03ea-fba166edf342@gmail.com>
Date:   Thu, 18 Feb 2021 15:39:13 -0500
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.11; rv:78.0)
 Gecko/20100101 Thunderbird/78.7.1
MIME-Version: 1.0
In-Reply-To: <0577f84b-f594-6b8a-76a2-29fb9453ee25@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: fr
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Le 2021-02-18 à 15:14, Philippe Blain a écrit :
> 
> And we would want it to be staged for deletion (and only deleting the config
> entry and keeping an empty ".gitmodules' file in the index)
> if the user is removing the only submodule in the superproject.

Sorry for the typo, a "not" is missing:

And we would want it to be staged for deletion (and *not* only deleting the config
entry and keeping an empty ".gitmodules' file in the index)
if the user is removing the only submodule in the superproject.

P.S. I CC'ed "cousteaulecommandant" who was CC'ed on the original bug report
since Javier's @rtx.com address now bounces.
