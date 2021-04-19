Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BEB08C433ED
	for <git@archiver.kernel.org>; Mon, 19 Apr 2021 11:10:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 942EB60E0C
	for <git@archiver.kernel.org>; Mon, 19 Apr 2021 11:10:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230070AbhDSLLL (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 19 Apr 2021 07:11:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57994 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230013AbhDSLLI (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 19 Apr 2021 07:11:08 -0400
Received: from mail-pf1-x434.google.com (mail-pf1-x434.google.com [IPv6:2607:f8b0:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E57F6C06174A
        for <git@vger.kernel.org>; Mon, 19 Apr 2021 04:10:27 -0700 (PDT)
Received: by mail-pf1-x434.google.com with SMTP id h15so5261620pfv.2
        for <git@vger.kernel.org>; Mon, 19 Apr 2021 04:10:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:references:cc:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=G0BcvqOTaHEp9GTpt5kIWCMVzaK6n258DprvP8qR3zE=;
        b=tPK+HT2hPWNIMNv1TW2PoCokJ8p/sXLmfFl2P22mggeYmeSTtnXx/wdukAjoVUnh0u
         mTr7eR7kvYYlXDHolzFLgdC02oHcMmciS5l39XdF3BmXrEgGXCHpcn+YJM1lxXfGpw4e
         +9judXkb4iZeF67HnatqmQ4+lsQfARNDiibjeERuntexsrYfTP/xMotRLo0ptyCuXAR7
         Q0FpYVzemK5ltdP1rM8bmjmNv/k9DoVPbyND6L+0/H1Fql2nXHG0baPX7BdqYiZHdLNU
         wqhp/Gm027CaDfbf0+mXbJhcSdJr0cr+hEi+eWpFS5PeKo63uXQ0QrJQr5YF4HBKDTQ8
         X+Rg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:cc:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=G0BcvqOTaHEp9GTpt5kIWCMVzaK6n258DprvP8qR3zE=;
        b=AK9H2/AXevfqJurxV98LthLS28fYHu3GM7BLrZUT55yHgZ1DPFHD0VN8Mb+b+06Emw
         69zHwMWhcYJEMWywtZcCTvQUW5oLH5Sql5MkwviA3uIATl/9sMhJuj8rLeSUpZ/bZ09D
         o1x6OGfKHnTd4uVjD10TZkCAg+8up7gfVIGDhVWtfQAZhs6pCcc5lnOvKDakkSV6UEI7
         sj0OHqwqHUDLgBRLabGm2JnxBZa5MfsmcjDmKPuowZ5UcOispxs+hRtq38t3SgaEgQg4
         EG4hQLnnBS7imlGK8ZD6hreb8S5akEqu1RPjUaHZJrtLZPmt4bO8rzDkwzHuVogw3rwE
         cowA==
X-Gm-Message-State: AOAM533flUYpYHAyhxsvoN56eWXzYznAYgBxei8mvFN9B5NlZnGLCSoP
        27+CLe4oYaq+HG4i5SSSfgZ6MXqeKiN9hw==
X-Google-Smtp-Source: ABdhPJx4dRWtEfuCn2b5pl+X6vdMUC6LHjlHYGlEeShO0y2k3AkXe0vtnl7S6a0MVmZIgbJsgv4tvg==
X-Received: by 2002:aa7:97ab:0:b029:25e:792a:dc59 with SMTP id d11-20020aa797ab0000b029025e792adc59mr6364671pfq.53.1618830626994;
        Mon, 19 Apr 2021 04:10:26 -0700 (PDT)
Received: from [192.168.43.80] (subs03-180-214-233-11.three.co.id. [180.214.233.11])
        by smtp.gmail.com with ESMTPSA id w1sm13622512pgh.26.2021.04.19.04.10.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 19 Apr 2021 04:10:26 -0700 (PDT)
Subject: Re: git checkout behaviour when only ctime of file changes
To:     Cristian Morales Vega <christian.morales.vega@gmail.com>
References: <CAOWQn3Qesh0+CkaD95q78Rq_vN5tjWKDe7HTk0Ynk-NY8XUKzg@mail.gmail.com>
Cc:     Git Users <git@vger.kernel.org>
From:   Bagas Sanjaya <bagasdotme@gmail.com>
Message-ID: <a6a5bb81-9a86-8901-31dd-dc9c09da0a23@gmail.com>
Date:   Mon, 19 Apr 2021 18:10:23 +0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.9.1
MIME-Version: 1.0
In-Reply-To: <CAOWQn3Qesh0+CkaD95q78Rq_vN5tjWKDe7HTk0Ynk-NY8XUKzg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 19/04/21 16.11, Cristian Morales Vega wrote:
> Basically after something updates the ctime of a file, a
> "git checkout" can behave differently depending on whether a
> "git update-index --refresh" has been run before or not.
> _Maybe_ it could make sense for "git checkout" to always behave as if
> "git update-index --refresh" had been run before? No idea really.
I know that setting SELinux label can alter file ctime, but when
I need to write the test that simulate file ctime update, do you
know which Unix command can trigger that, beside SELinux tools?

-- 
An old man doll... just what I always wanted! - Clara
