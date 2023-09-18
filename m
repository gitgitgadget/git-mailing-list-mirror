Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6755CD37B0
	for <git@archiver.kernel.org>; Mon, 18 Sep 2023 16:27:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229883AbjIRQ1s (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 18 Sep 2023 12:27:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52596 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229843AbjIRQ1c (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 18 Sep 2023 12:27:32 -0400
Received: from mail-ot1-x331.google.com (mail-ot1-x331.google.com [IPv6:2607:f8b0:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E2322F2E9
        for <git@vger.kernel.org>; Mon, 18 Sep 2023 09:25:04 -0700 (PDT)
Received: by mail-ot1-x331.google.com with SMTP id 46e09a7af769-6bf04263dc8so3179357a34.3
        for <git@vger.kernel.org>; Mon, 18 Sep 2023 09:25:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695054304; x=1695659104; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=VOYdsVcMHa7jltPlZ5G7o2ZY5HwBViuzR61s2uZ0+1g=;
        b=eTQwZ6a8Gpw2KUBNuonUuw3K2YJmjtQgDBzRlHBpXmMm+bau9pr60EOVEShmzz12/H
         eDbn+fhdl/F2uJZm9kh/pSzGa1mHiBsKfZP/r6YjAlJtAPDJP4XeG85TkIOJDOwHO+/d
         Eg2Xr8PzmYHfX9HiLaqXIwriWGaiHPpCPrriAYjKvICmUM00+vwwMCI2uvGis8Ujmcgk
         ITdEUWoIDwpwDmmKYTD33XIYLS6lpVblZKAh77iNbmLUBGmnqtAzGjBXb9TFG1Dn1qls
         2Q2yy6xtCYENp7SwCYjMxfqYjNT/vKQY6w4cbZAEbNlydshmwnz4WCMlFok9tGG73GYZ
         mY7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695054304; x=1695659104;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=VOYdsVcMHa7jltPlZ5G7o2ZY5HwBViuzR61s2uZ0+1g=;
        b=S1tqiy3FcFe4+zH5ngFOxd7StqStikw4KUWG/1YXhfnNAM5Lhr2xz9UjpSnyfNaDZ1
         1d5u0FScwh/n6MlV4siKQ7/pJYXwxinJ6PBllHdYEg54slF0r31+m/dfJpllcDfNbevt
         16i+KYIk4O/SkukgEVzrrvcGotXbYGhCM4mXqHdn+53pc+U5U8ut0cTiAPvNTjBm3W94
         V/XDgVkQzlyA37MEVfepZTuIwhdCdOqT5yCGSvnnYVnrwycoqPUrocqr6XVBhfKX5928
         lchoKvD+kzCAFDM1e45Fx1d2V5QLexZUG9S+AiDmWoGwwMY9QtfofXdJvLbUlDZLFBZz
         ObCw==
X-Gm-Message-State: AOJu0Yz4VTHyLHSForGJerYVEKDBVVSfGqbX9ySyGD/ZCSLeS+ySnD4U
        QAja+OAVYzyeyaIuGv54xSKwEyaGxLoZ4g==
X-Google-Smtp-Source: AGHT+IFcRe2Z6FCBbxqw+c6EXOOAaKsS+pjYdmlfldMfJ5g0Fo78EdLFTdc/lVbri2/vCyTBEMeWKg==
X-Received: by 2002:a05:6358:7244:b0:143:61d:ffd3 with SMTP id i4-20020a056358724400b00143061dffd3mr11125994rwa.4.1695054303611;
        Mon, 18 Sep 2023 09:25:03 -0700 (PDT)
Received: from ?IPV6:2600:4040:266f:b900::387? ([2600:4040:266f:b900::387])
        by smtp.gmail.com with ESMTPSA id y11-20020a0cf14b000000b0064c1b27bf2dsm1012665qvl.140.2023.09.18.09.25.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 18 Sep 2023 09:25:03 -0700 (PDT)
Message-ID: <a4765b59-1953-695b-4f5e-686bef0a3a50@gmail.com>
Date:   Mon, 18 Sep 2023 12:25:02 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH] git-gui - use git-hook, honor core.hooksPath
To:     Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     me@yadavpratyush.com, git@vger.kernel.org
References: <fa876f80-02dc-2c04-0db3-bf3f6269b427@gmail.com>
 <20230917192431.101775-1-mlevedahl@gmail.com>
 <a6998d64-32a7-80b6-f75c-d983ac6130dd@gmx.de> <xmqqpm2fmq2d.fsf@gitster.g>
Content-Language: en-US
From:   Mark Levedahl <mlevedahl@gmail.com>
In-Reply-To: <xmqqpm2fmq2d.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On 9/18/23 11:58, Junio C Hamano wrote:
> Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
>
>>> +	set cmd [concat git hook run --ignore-missing $hook_name -- $args 2>@1]
>>> +	return [_open_stdout_stderr $cmd]
>> This looks so much nicer than the original code.
>>
>> Thank you,
>> Johannes
> Yup, looking good.

Thanks. BTW, my commit message at "Furthermore, since v2.36 git exposes 
its hook exection machinery via" needs

     s/exection/execution/

Should I resend?

Mark

