Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9182AEDEC79
	for <git@archiver.kernel.org>; Wed, 13 Sep 2023 15:33:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229563AbjIMPdO (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 13 Sep 2023 11:33:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60780 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229456AbjIMPdN (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 13 Sep 2023 11:33:13 -0400
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C02ACE
        for <git@vger.kernel.org>; Wed, 13 Sep 2023 08:33:09 -0700 (PDT)
Received: by mail-wm1-x32c.google.com with SMTP id 5b1f17b1804b1-40037db2fe7so74575165e9.0
        for <git@vger.kernel.org>; Wed, 13 Sep 2023 08:33:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1694619187; x=1695223987; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:reply-to:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=Ry8ttwD/mNdErM7RYMZWaluGymnGUMtTookynS5ILp8=;
        b=TGpUPg9wncgyS7QlyK6L4i+Edq0prb6R1NUNoVIfr/wizvwVuf5E2kMIP9dyDP2IFo
         wDMnXXWN8C9iL426/wqHvlkbREnV2tn3jYk/fHdmCD88AGyGo4mEU+8soIrfvv7nl3t0
         kOCLFPL4Q7/0sinWvKh31+3H9qukePDGIvmRggFZLSAFi9xbWgsdFPe97ftVc+zcZwiy
         +3uQUTSyVRE8i1Mk7HFcwVBORmbxXN2dtc4CSmBqD5c2/9+G/IRqlVynhYCntekUCcF3
         IItJxIqKvqMFuvXRLb/Wctnw7BZXWy02nlYNFkOu4UveLYZmmWmWoz8h1RF9hYxaHZ2Z
         D5Jw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694619187; x=1695223987;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:reply-to:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Ry8ttwD/mNdErM7RYMZWaluGymnGUMtTookynS5ILp8=;
        b=o5Em9rMEmUeJyuRtmkA0SGlaB0THvLAjEybG3kxWe6aR8O+8iCoG4zN+J5G3M3Ey06
         ZG4fktQ/zQB3WKilPZbnOVYEEWQWPlRGBANokOHJfNXA/rqNbkRylf3WzzdpHvgxLia8
         Xj4fjLr/Ex/UdsY8UPhJUEn5sDMik+WfYUl1cT230z6+RLg4YSINBE2oRxcyP9Py5YPr
         8p22NsdoogBFhSvlo1LGlDyjmWfww+EMevW0ZKs5VNblSNehLKuJD0gg2i6jQL7ga/uI
         kaZMlSk83WqHTocgcsOLTiaL5TGAQXYaWtvyJdyxFYCcqy1l1Izfg05RSLlZsIFzUn3N
         SY2g==
X-Gm-Message-State: AOJu0YzB/CKTA6s4FjFFvxFIfJ31O+3sM+kPARzboNqs26NiCu7CZI5l
        /meQ6PcT/7PXHAj04tpeozk=
X-Google-Smtp-Source: AGHT+IFuyMYrGPlLc95S+eSTbGRE0dSTWMN4gBb9oLigWHC4DDnj2416gOQACY6Qu/5n+uK4DXkW6g==
X-Received: by 2002:a1c:ed17:0:b0:3fe:22a9:910 with SMTP id l23-20020a1ced17000000b003fe22a90910mr2515595wmh.14.1694619187264;
        Wed, 13 Sep 2023 08:33:07 -0700 (PDT)
Received: from [192.168.1.212] ([90.242.223.1])
        by smtp.gmail.com with ESMTPSA id k23-20020a05600c0b5700b00402fa98abe3sm2324858wmr.46.2023.09.13.08.33.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 13 Sep 2023 08:33:06 -0700 (PDT)
Message-ID: <51ad269b-d8df-4424-8127-293b2971d65d@gmail.com>
Date:   Wed, 13 Sep 2023 16:33:06 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH] rebase -i: ignore signals when forking subprocesses
Content-Language: en-US
To:     Oswald Buddenhagen <oswald.buddenhagen@gmx.de>,
        phillip.wood@dunelm.org.uk
Cc:     Jeff King <peff@peff.net>,
        Phillip Wood via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Junio C Hamano <gitster@pobox.com>
References: <ZP2U8TBNjKs5ebky@ugly>
 <80eb7631-e5c0-497e-b2a9-b1f8c8a4a306@gmail.com>
 <a37a0f11-0723-4964-a187-54d960615d79@gmail.com> <ZP7st70/G3kLujHG@ugly>
From:   Phillip Wood <phillip.wood123@gmail.com>
In-Reply-To: <ZP7st70/G3kLujHG@ugly>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 11/09/2023 11:32, Oswald Buddenhagen wrote:
> On Mon, Sep 11, 2023 at 11:14:31AM +0100, Phillip Wood wrote:
>> On 11/09/2023 11:00, Phillip Wood wrote:
>>> There is an inevitable race between wait() returning and calling 
>>> signal() to restore the handlers for SIGINT and SIGQUIT,
>>
>> In principle if we installed a signal handler to set a flag if a 
>> signal is received while calling wait() and then once wait() returns 
>> successfully see if the child was killed we can tell if the signal was 
>> received while the child was alive.
>>
> yes, this is what i was already writing:

I'm afraid that was not clear to me from your message.

> my point is that you shouldn't be doing that in the first place.
> install the handlers when the sequencer is entered and leave them there.
> the handlers need to set (volatile) flag variables, which are checked by
> the sequencer on a regular basis.

I did consider doing that before I submitted this patch but it is a much 
more invasive and substantial change. The patch here makes it safe for 
the user to interrupt a subprocess started by the sequencer. If I 
understand correctly your suggestion implies that the user could 
interrupt the sequencer at any point and we'd need to exit and ensure 
that they could safely continue the rebase afterwards. That is not the 
case at the moment and I'm concerned making that promise could turn into 
a maintenance burden in the future.

Best Wishes

Phillip
