Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 252D3CA0EC1
	for <git@archiver.kernel.org>; Mon, 11 Sep 2023 21:39:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349327AbjIKVdK (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 11 Sep 2023 17:33:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236315AbjIKKOi (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 11 Sep 2023 06:14:38 -0400
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 634CEE68
        for <git@vger.kernel.org>; Mon, 11 Sep 2023 03:14:34 -0700 (PDT)
Received: by mail-wm1-x334.google.com with SMTP id 5b1f17b1804b1-401d24f1f27so48513445e9.1
        for <git@vger.kernel.org>; Mon, 11 Sep 2023 03:14:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1694427273; x=1695032073; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:reply-to:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=Q3IVl9FyKPsGvn9qcwPY5rMtm3HPbCqoyw4u9g8/3Os=;
        b=XW2pozYri2+6U4myQFT/nV/0RCEcchHBSfrYOPjsnWXNurdrenrTTt+OaMtq/RzZwE
         ZhOAL/vDxtOGwIstgXLn/MEvu5eJH2hbJiqjm8Gbh6QXpVHGQ+YxkXxZWL8DEcQh838T
         LKrVSg2LmD/Lv4/z86VdhgZ5ZIc/BnPHzbdY03PBCgeF4mZCQ6ybiMCehw2m+yY1cfBw
         oEkyDmktBdqcUTfvNhRUfczETb/o16HgPFTJ4Olpxukcw+vBeowJy3ZnXeXTQ16qWI7c
         Jm2iI5zwK6Rs3RDMfZZCUhBghBb1Q9YWBX07RxA5WMJXgvRiZZII8UgKA/mPqMwA9Q4i
         NvDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694427273; x=1695032073;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:reply-to:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Q3IVl9FyKPsGvn9qcwPY5rMtm3HPbCqoyw4u9g8/3Os=;
        b=vhmB4cHZ/18uIjKP3gKnp1JmUT/im1VDVEZW6l4HRJoFrxBIO55P7mx2FI9kCsLaZL
         S1MRL+0H5tKihhvKw0g3WqJgfpAgrs7PviXlwcp1dE4S5tc010im6VwOOyEpiPQJRUZM
         KiOK6CPeKbzV6aCuFox093pHpQaCd4q6YXqgRB9im5Z59QytsHevmQa21GQN6w70kWrR
         QFXak1q+EE4YvhNAu2zJSUSCXygKCVW7eA+5nDn8CfZ6p90FyHt6f9Six/hbrIaxm0G/
         9fEMgBIPOR5yEgBYjn7PdUYDIW38mTa3SwbQPV6sATp2bJiOwk/xiYVTxVg1WFMIy2qZ
         wcEg==
X-Gm-Message-State: AOJu0YyHAnlMCYAPxhgGHn4BXt1Lbs+6n+2xT/DRcW/iDi13P4UI4Ya+
        4fbSPQ5V7O4/kyOV6qtd36q8d1T4xNjMAg==
X-Google-Smtp-Source: AGHT+IEosJt1KRT++xto6nwze9f7b1dY5b9aYrWZvJYlbJRXBeslHKrWz/GhIFfmYKG12xoHPNRznQ==
X-Received: by 2002:a5d:68ca:0:b0:314:1230:29b0 with SMTP id p10-20020a5d68ca000000b00314123029b0mr6984213wrw.52.1694427272451;
        Mon, 11 Sep 2023 03:14:32 -0700 (PDT)
Received: from [192.168.1.101] ([90.242.223.1])
        by smtp.googlemail.com with ESMTPSA id a5-20020a056000100500b00317e77106dbsm9577915wrx.48.2023.09.11.03.14.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 11 Sep 2023 03:14:32 -0700 (PDT)
Message-ID: <a37a0f11-0723-4964-a187-54d960615d79@gmail.com>
Date:   Mon, 11 Sep 2023 11:14:31 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH] rebase -i: ignore signals when forking subprocesses
Content-Language: en-US
To:     phillip.wood@dunelm.org.uk,
        Oswald Buddenhagen <oswald.buddenhagen@gmx.de>
Cc:     Jeff King <peff@peff.net>,
        Phillip Wood via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Junio C Hamano <gitster@pobox.com>
References: <ZP2U8TBNjKs5ebky@ugly>
 <80eb7631-e5c0-497e-b2a9-b1f8c8a4a306@gmail.com>
From:   Phillip Wood <phillip.wood123@gmail.com>
In-Reply-To: <80eb7631-e5c0-497e-b2a9-b1f8c8a4a306@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 11/09/2023 11:00, Phillip Wood wrote:
> There is an inevitable race between wait() returning and calling 
> signal() to restore the handlers for SIGINT and SIGQUIT,

In principle if we installed a signal handler to set a flag if a signal 
is received while calling wait() and then once wait() returns 
successfully see if the child was killed we can tell if the signal was 
received while the child was alive. In practice if the child is catching 
SIGINT or SIGQUIT we cannot rely on it re-raising the signal so that 
wont work.

Best Wishes

Phillip

