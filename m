Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0CAFC433E0
	for <git@archiver.kernel.org>; Wed, 20 Jan 2021 11:35:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7633223159
	for <git@archiver.kernel.org>; Wed, 20 Jan 2021 11:35:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729326AbhATLfF (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 20 Jan 2021 06:35:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37316 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388840AbhATLFc (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 20 Jan 2021 06:05:32 -0500
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B01A6C061575
        for <git@vger.kernel.org>; Wed, 20 Jan 2021 03:04:51 -0800 (PST)
Received: by mail-wm1-x334.google.com with SMTP id c124so2450336wma.5
        for <git@vger.kernel.org>; Wed, 20 Jan 2021 03:04:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=reply-to:subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=GFuWUmcVxKYYkekvQY6zh4jPal/UWIoM5PJKDazoVi8=;
        b=TfQgWx5+lMLwcaYnhCDjWhox/Tvwgi8mElBG0E1DOZKVA0JAUhoP/0eyDtpL2WJwgl
         yyiQn4uhf4Jlrk3EmO1ZAdRfrt646pUq2ixxwLWlH8kuxP5ofFNMPgXBeIiKQ+NLeZ8g
         nTwq2Bkwb5/EwNJ+NRW4uqv51knZo17tbq3HK5/jUjgl7JP7X90UZbUwYUMgUJpa0bTB
         iFC1LZqGA6LypGu2RP4W4ixWcVJrLnp2DgEjLa8oZdEbH6GE/pGSbodDBD8W3vLnc1zc
         Xja9x9qAvJgLQXv1HxSgL+Q5h5jvVLG7usgZEAyDk8JVpScNrDARNQcMBT786jBhuCoZ
         yrWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:reply-to:subject:to:cc:references:from
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=GFuWUmcVxKYYkekvQY6zh4jPal/UWIoM5PJKDazoVi8=;
        b=hPXom+hDnq7HNl7Viy3MMetS+1OmyMuNYEManADRMpR/KiioCBnIe+S5VMU+ubBcb4
         M0lDOnw1LEfUQ3VFYnmN8TVxqLq264HhwLxx6XkPrlu2rkIb2Ko3OvSrmAailzsvBwRl
         4BRzcqHS3P+heGxngTWD+R15EqIk0HT5qZtC2mn0XADuI5B9XXu0FcgHssag9UMfysCA
         sHxOcXg/kXo8v8ND5iR0+geYxqZDWfFzJAH7tS+aju7H325FWcfFNbUL7msemRuAoTAu
         iB4AIhQ4WsfmwEoSX9OazJkW40NDAaihq7eA45SHyj+QBB+CRmg+RbYGN6KNhEfmqhPl
         K9yw==
X-Gm-Message-State: AOAM531pkay5quStKc/+YVbnyrUzhEMsKcfMwCDalLhZrHpiVqKKWw6q
        +fo9Zl4aOSAXjb9LPgwMLbw=
X-Google-Smtp-Source: ABdhPJzqU5zFVihRjwBTgrPHE3jVP3onGyx+9e4bjH8OEc+Bck1p8wIYPeAMpPpV25JcGuA4rpOZZg==
X-Received: by 2002:a7b:ca4c:: with SMTP id m12mr2233987wml.115.1611140690369;
        Wed, 20 Jan 2021 03:04:50 -0800 (PST)
Received: from [192.168.1.240] (112.16.7.51.dyn.plus.net. [51.7.16.112])
        by smtp.gmail.com with ESMTPSA id n11sm3907917wra.9.2021.01.20.03.04.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 20 Jan 2021 03:04:49 -0800 (PST)
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH v2 9/9] doc/git-rebase: add documentation for fixup
 [-C|-c] options
To:     Charvi Mendiratta <charvi077@gmail.com>,
        Marc Branchaud <marcnarc@xiplink.com>
Cc:     git <git@vger.kernel.org>,
        Christian Couder <chriscool@tuxfamily.org>,
        Phillip Wood <phillip.wood@dunelm.org.uk>,
        Taylor Blau <me@ttaylorr.com>,
        Junio C Hamano <gitster@pobox.com>
References: <20210108092345.2178-1-charvi077@gmail.com>
 <20210119074102.21598-10-charvi077@gmail.com>
 <8fd2b72c-d1d0-98be-e6a5-fb7dc699d5d5@xiplink.com>
 <CAPSFM5euGE_bUDPgdzx4-q5zYtkDymHdJP9rw-YkVVVzpOKWkw@mail.gmail.com>
From:   Phillip Wood <phillip.wood123@gmail.com>
Message-ID: <7c11da69-d2f1-0aab-80bc-d8ae8735f8ca@gmail.com>
Date:   Wed, 20 Jan 2021 11:04:48 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.1
MIME-Version: 1.0
In-Reply-To: <CAPSFM5euGE_bUDPgdzx4-q5zYtkDymHdJP9rw-YkVVVzpOKWkw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB-large
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Charvi

On 19/01/2021 17:13, Charvi Mendiratta wrote:
> Hi Marc,
> 
> On Tue, 19 Jan 2021 at 20:07, Marc Branchaud <marcnarc@xiplink.com> wrote:
> [...]
>>>    "pick" for the second and subsequent commits with "squash" or "fixup".
>>>    If the commits had different authors, the folded commit will be
>>>    attributed to the author of the first commit.  The suggested commit
>>> -message for the folded commit is the concatenation of the commit
>>> -messages of the first commit and of those with the "squash" command,
>>> -but omits the commit messages of commits with the "fixup" command.
>>> +message for the folded commit is created as follows:
>>> +
>>> + - It is made using the commit message of a commit with the "fixup -C"
>>> +   or "fixup -c" command. In the later case an editor is opened to edit
>>> +   the commit message.
>>
>> s/later/latter/
>>
> 
> Thanks, will fix it.
> 
>> What happens if there is more than one "fixup -C/-c" command?
>>
> 
> Upon running interactive rebase, in todo list if we use for example sequence of
> commands like `fixup -C`, `fixup -C` , `fixup -C` then it will fixup
> content of all and
> for commit message it will replace with the commit message of end `fixup -C`
> 
> Similarly, if we have sequence like `fixup -c`, `fixup -c`, `fixup -c`
> then also it will fixup
> up all the content and here it allow user to edit the message, so
> opens the editor once

It is good that we only open the editor once in this case - I'd not 
thought about chains of `fixup -c` before reading this. Do we have a 
test to verify that the editor is only opened once?

Best Wishes

Phillip

> in this case and shows the commit msg of end `fixup -c` to edit and
> also contains
> commented commit messages of complete fixup chain. So, for any sequence of fixup
> chains `fixup -c` works as similar to the `squash` command.
> 
> Hope it explains the working.
> 
> Thanks and Regards,
> Charvi
> 
