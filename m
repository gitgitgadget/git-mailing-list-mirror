Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF1AEC77B6E
	for <git@archiver.kernel.org>; Fri, 14 Apr 2023 12:59:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229778AbjDNM7g (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 14 Apr 2023 08:59:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44186 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229564AbjDNM7f (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 14 Apr 2023 08:59:35 -0400
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B4E4BB95
        for <git@vger.kernel.org>; Fri, 14 Apr 2023 05:59:00 -0700 (PDT)
Received: by mail-wr1-x429.google.com with SMTP id r20so1606459wra.5
        for <git@vger.kernel.org>; Fri, 14 Apr 2023 05:59:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1681477136; x=1684069136;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:reply-to:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=sozoW0zfS8g1LsVWQI1/370SeEJiprjQHANww68LjE4=;
        b=i4KgpuXMsQGMaOqa9tGSOx3iiuvGeF4l36aTijP3xMT5sCR9wmcSBzSgB0cYnssmQO
         X84QQ7OPyIgD/xIDgFbmB2uMEb9h+/oryMfHmcI0PN52bqk2mRVql5BEJmiVMQQagdA6
         j4DFjreKbv8KG5NQvOs5iar/x189Cdx37LQrQ6mXhBdMxHLdRSRqamQzve/FPm7LrhtP
         VRGTWoEBIfCj9rvRsjBCR9DuLLedmxCfaFVSAYtxkqtKtIqcu7xYJ1nLtzy1gahaagzW
         l5wNqdAm4Jyt/zs/2qluXpq1Mq3v6FYg65FlOowcWz/yYyGy2FcgIkMiVlrJz352gw6X
         sAIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681477136; x=1684069136;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:reply-to:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=sozoW0zfS8g1LsVWQI1/370SeEJiprjQHANww68LjE4=;
        b=W58TjK5Kxc6MaN6v87UbvhTJMXpj1Sqs5w6mGW/lvwnMjnmaTZ3Eo1v0OiEdSZDl/U
         dR+ZQeDBhoCrcWhx/jSiW+mJjf1R2p/7BHDov1wD0TzwS5lKVIhQmWqQ5JkR+TWiyRV3
         Gl5aO5mOLg0Id9pdwI+XksbSNR1iB8sD1wgOj0iqef+61Abu2t2gQsKJu1yXeWo8bnMo
         FgaDKMwjIr59zHy1hqG1HXbnh+VQ2wIwHtYBCfrC7qQLm24YH/OE+tOlxQkTdcvzHwL7
         Cxo0K3gcUx76pTl2PL21kBMpcsKuhC3Rm+osgJqsSIJkabRRYgwFl20Ggj5eNk4J2Gbx
         l+aw==
X-Gm-Message-State: AAQBX9eke+tg101ZE5dkQwU8uT+46mCXQio8uFAxEkiiuaiiF62yBxbb
        4txvpdl6DKcCLXQdzOegEMM=
X-Google-Smtp-Source: AKy350ZTw6MiELu0xlalaQFilCr1TvtZiREqrvYgcCImWLia8UZr7k2VEgnnnuqnVVmT5yoPL9x23g==
X-Received: by 2002:adf:f692:0:b0:2de:a953:6b05 with SMTP id v18-20020adff692000000b002dea9536b05mr4399105wrp.67.1681477136327;
        Fri, 14 Apr 2023 05:58:56 -0700 (PDT)
Received: from [192.168.1.195] ([90.253.53.152])
        by smtp.googlemail.com with ESMTPSA id e6-20020adff346000000b002efac42ff35sm3538205wrp.37.2023.04.14.05.58.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 14 Apr 2023 05:58:55 -0700 (PDT)
Message-ID: <d40ad39a-7598-02f3-7a5c-46f0d75f34fc@gmail.com>
Date:   Fri, 14 Apr 2023 13:58:49 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.1
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH v3] send-email: export patch counters in validate
 environment
Content-Language: en-US
To:     Robin Jarry <robin@jarry.cc>, phillip.wood@dunelm.org.uk,
        git@vger.kernel.org
Cc:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Tim Culverhouse <tim@timculverhouse.com>,
        Nicolas Dichtel <nicolas.dichtel@6wind.com>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Michael Strawbridge <michael.strawbridge@amd.com>
References: <20230412095434.140754-1-robin@jarry.cc>
 <20230412214502.90174-1-robin@jarry.cc>
 <240577d5-3412-5a80-c7d9-e3d277869add@gmail.com>
 <CRVOLVOVSVO4.UJJ8JLP8Y69T@ringo>
From:   Phillip Wood <phillip.wood123@gmail.com>
In-Reply-To: <CRVOLVOVSVO4.UJJ8JLP8Y69T@ringo>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Robin

On 13/04/2023 15:01, Robin Jarry wrote:
> Hi Phillip,
> 
> Phillip Wood, Apr 13, 2023 at 15:52:
>> I think the documentation and implementation look good, I've left a
>> comment about the example hook below. As Junio has previously mentioned,
>> it would be nice to have a test with this patch.
> 
> Yes, I only got Junio's email after sending v3 :)
> 
> The test case is ready. I was waiting for more comments before sending
> a v4.

That's great, thank you for doing that.

>>> +	git worktree remove -f "$worktree" 2>/dev/null || :
>>
>> Now that you've got rid of "set -e" I don't think we need "|| :".
> 
> Right.
> 
>> I had expected that we'd always create a new worktree on the first
>> patch in a series and remove it after processing the the last patch in
>> the series, but this seems to leave it in place until the next time
>> send-email is run or /tmp gets cleaned up. Also if I've understood it
>> correctly the name is set the first time this hook is run, rather than
>> generating a new name for each set of files that is validated.
> 
> I had thought that it would be useful to keep it in case the user wants
> to inspect and resolve issues. I you think it is a problem to leave it,
> I can deleted it after the last patch. In any case, if the user
> interrupts send-email before it has time to validate all patches, the
> worktree will be left in place.

I think leaving it in place if there is an error is fine, but it ought 
to clean up after itself if there isn't an error. More serious is that 
we use mktemp to create the worktree path the first time the hook is run 
and then just keep using that same path forever. It should be creating a 
new temporary directory with mktemp for each series to avoid clashes 
with existing entries in /tmp.

Best Wishes

Phillip

> Thanks for the review!

