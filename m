Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DEBF3C4338F
	for <git@archiver.kernel.org>; Tue, 17 Aug 2021 17:12:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B507260FD9
	for <git@archiver.kernel.org>; Tue, 17 Aug 2021 17:12:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230431AbhHQRNc (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 17 Aug 2021 13:13:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37336 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229716AbhHQRNb (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 17 Aug 2021 13:13:31 -0400
Received: from mail-oi1-x22d.google.com (mail-oi1-x22d.google.com [IPv6:2607:f8b0:4864:20::22d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 32E07C061764
        for <git@vger.kernel.org>; Tue, 17 Aug 2021 10:12:58 -0700 (PDT)
Received: by mail-oi1-x22d.google.com with SMTP id t128so160116oig.1
        for <git@vger.kernel.org>; Tue, 17 Aug 2021 10:12:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=/MURkOlIGV8Y0YJdfvfyGQzda9rfv+5QFgBRb3VhD2k=;
        b=g/vE2slV4NwnxkdBKdo0m1s78GcB+I8mHRTnfurLW697Fyeshvkx3z/L77SKX/YfZN
         rU1Q3NbGv4lR3/U4igNXpxZ6cwprlkZu8jX9/pb8G3q4oyG+0cYaFtqK+dBBUoH8Dxxy
         caKPa/jE6goqamlLkwUzrJbV6JlYMJ9FzMrvHS2H55FbkLAMVctrOhHdmL0ch5OlrKvD
         H0DvcXzxnrPDFtfMe4kLajZcBYC6kB8QomwgJEWyvh9bR9zOCNWC8cicXvExaEMSWp3O
         2G9mwSDbBUVUuX5x28LmGq98BzTDU6VqwCvM5QpHuw9RAoJolgrHshe3oN8RpHs3JqkG
         5Jow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=/MURkOlIGV8Y0YJdfvfyGQzda9rfv+5QFgBRb3VhD2k=;
        b=K03vXrj4Gu1du06QvC91maNlCUGPluYhLMLxuIjqgMqOqKYFCwxsxfyhDbh3uwE5di
         hmU35gZOGxhOS78VdRwr2Z0J3FdaaV3l6FtgKvLb17xs2CCaJUOayjpmpe+8XnAzcZo/
         lHwnaaoibo+swYvrumBwQzCDtELk+iG1wmf/q+RzC00blCKhw2oZ/SQWMdzL0wWCnuud
         gWLJNnad9TH1AoTRMjt8Svg7VxOLGiVVaRjZ1EInuYj9RY/0nFk4ml5hN2J+H4Ausoo2
         6SVtOCOrCg4zEyNAMG4NzbZADLPviXT+LEeFZnawvr52l7ej/2qk7HPFRVzGNqO1H49k
         iukg==
X-Gm-Message-State: AOAM530SoDJ67TGek9rK7BmTonbDBKPpRA2i1vbM68gJHFj0flVr0W+T
        HookLn0DHCDjT5/9zvCafeA=
X-Google-Smtp-Source: ABdhPJxp769XtZIR/Jwer7UgNnho5mpvyhLl5dPF1ikacXQL1MPk3FcymZBc1ljTWQubQRjjopd3+A==
X-Received: by 2002:aca:3051:: with SMTP id w78mr3284585oiw.159.1629220377532;
        Tue, 17 Aug 2021 10:12:57 -0700 (PDT)
Received: from ?IPv6:2600:1700:e72:80a0:dc75:b61d:e533:9004? ([2600:1700:e72:80a0:dc75:b61d:e533:9004])
        by smtp.gmail.com with ESMTPSA id bd3sm595787oib.37.2021.08.17.10.12.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 17 Aug 2021 10:12:56 -0700 (PDT)
Subject: Re: What's cooking in git.git (Aug 2021, #06; Mon, 16)
To:     Junio C Hamano <gitster@pobox.com>,
        Phillip Wood <phillip.wood123@gmail.com>
Cc:     git@vger.kernel.org,
        =?UTF-8?B?TMOpbmHDr2MgSHVhcmQ=?= <lenaic@lhuard.fr>
References: <xmqqv945ng61.fsf@gitster.g>
 <92511bbe-5ef3-cfef-0a0b-30fbda2df201@gmail.com> <xmqqh7fonhlo.fsf@gitster.g>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <7a4b1238-5c3b-4c08-0e9d-511f857f9c38@gmail.com>
Date:   Tue, 17 Aug 2021 13:12:56 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <xmqqh7fonhlo.fsf@gitster.g>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 8/17/2021 12:47 PM, Junio C Hamano wrote:
> Phillip Wood <phillip.wood123@gmail.com> writes:
...
>>> * lh/systemd-timers (2021-07-02) 3 commits
>>>   - maintenance: add support for systemd timers on Linux
>>>   - maintenance: `git maintenance run` learned `--scheduler=<scheduler>`
>>>   - cache.h: Introduce a generic "xdg_config_home_for(…)" function
>>>   "git maintenance" scheduler learned to use systemd timers as a
>>>   possible backend.
>>>   Waiting for reviews.
>>
>> I'd really like to see this merged, there was some discussion a couple
>> of weeks ago (cf <4aed0293-6a48-d370-3b72-496b7c631cb5@gmail.com>), it 
>> petered out but no one seemed to be objecting to merging it.
> 
> Thanks for paying attention to this item.
> 
> My impression was that everybody likes the ability to use systemd
> timers as an alternative to cron, but as Derrick summarised in the
> message you pointed at, I think the implementation is not quite
> there.
> 
> So "Waiting for reviews" is a mislabel; we are waiting for a reroll.
I think a lot of our comments were "We would hold an established
contributor to a higher standard, but this is sufficient for a new
contributor. The rest can be forward-fixed." We also have not heard
from the original contributor since that discussion.

Perhaps enough time has passed that we can expect Lénaïc will not
get back to us, I could give an attempt to forward-fix the comments
with a patch series on top of these. We could then hold
lh/systemd-timers in 'next' (or even 'seen') until it can be joined
with those fixes.

If preferred, I could restart the series by inserting some patches
and editing some of the ones in the list currently.

Thanks,
-Stolee
