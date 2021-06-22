Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7832BC48BE5
	for <git@archiver.kernel.org>; Tue, 22 Jun 2021 17:25:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6196A60FF1
	for <git@archiver.kernel.org>; Tue, 22 Jun 2021 17:25:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231572AbhFVR2M (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 22 Jun 2021 13:28:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58428 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230338AbhFVR2M (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 22 Jun 2021 13:28:12 -0400
Received: from mail-oi1-x234.google.com (mail-oi1-x234.google.com [IPv6:2607:f8b0:4864:20::234])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A1A9C061574
        for <git@vger.kernel.org>; Tue, 22 Jun 2021 10:25:55 -0700 (PDT)
Received: by mail-oi1-x234.google.com with SMTP id 84so201225oie.2
        for <git@vger.kernel.org>; Tue, 22 Jun 2021 10:25:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=F1KPr8yuVzDiQkjNo1dsVT8/h6YXWfV6gSVuWPaIl4o=;
        b=quluUBJD6wTU6MrAgQfNeiu3DvLo5AAJUohC7NO7D12fp7xx7VyVqBsk2j64GZHBPO
         z1kPQGTiID2raNM9DkDY98dexibW5FEbnJbVj3L2vGjEfqwpTu1IHcsmBCn5T2+Epuel
         qWaspS3PyVyHTpmDqak0KBU/J66KzK1BxW5jfQ9WeiXfmHU0HbRD4KgPXIZGhUFOYO8w
         5kMaLUMbdtBkm3ou2siQoPn+LHNtT4XBd+sdOygGbotNBrkot5KDGCUZ3745v4YW49gW
         /YKBGTz+TSyn0sBXWJu7yMmZ2Njo12zZih9V6aWombdo7mmYiwCpAcwlnhjUFoYnr9g1
         S74A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=F1KPr8yuVzDiQkjNo1dsVT8/h6YXWfV6gSVuWPaIl4o=;
        b=cZ3rx8me+6+ORZZZjNhm95SMFTV1lIFCwLqrlYhf/ddYaylXUngK6qQ5BLh1dVySPZ
         FzinSvXbBU95RhBJUdWVl/OcJrWTcZ5ZwgRfmcB+Q2clxL/gKcxugq9D82ZgcCg7ZLaQ
         gNC6BKCUDOhChJ2kqeNhNNItnlI3Wm4s4iORpXYVu+cce5RCvj+mZEiBPRwc5LBnnbtE
         bycWnYLUqXvQa2/13hja6kOG4hBF/jXdK5c/yXbAWQ7eKPWv+54V668II/tF3boBnUXl
         Ilw3T/g2Pa4NFjT10zk/IoZgIutbgIqqtz37ykSrsNgT8dAn6F1/ViGOS38UJeXfF96h
         EcCA==
X-Gm-Message-State: AOAM532JWk3CcQMf4+9Z/+zuwirtP8lnADDIpQF6NAmQJX7XSq7BvUvO
        /f5ZmzQV97RilgCA2YS3GUE=
X-Google-Smtp-Source: ABdhPJymyp6HFwyUX1MXSMJheyIODu405R2POAMS9PBHm+G4BCSZwzijf6KEIFxOOFcz13va2f/aAg==
X-Received: by 2002:a05:6808:259:: with SMTP id m25mr1629210oie.37.1624382754654;
        Tue, 22 Jun 2021 10:25:54 -0700 (PDT)
Received: from ?IPv6:2600:1700:e72:80a0:2110:dbed:f0f7:d6e3? ([2600:1700:e72:80a0:2110:dbed:f0f7:d6e3])
        by smtp.gmail.com with ESMTPSA id b22sm621981oov.31.2021.06.22.10.25.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 22 Jun 2021 10:25:54 -0700 (PDT)
Subject: Re: [PATCH 5/5] load_ref_decorations(): avoid parsing non-tag objects
To:     Jeff King <peff@peff.net>
Cc:     git@vger.kernel.org, Taylor Blau <me@ttaylorr.com>
References: <YNIJw/8p0F3cPfzd@coredump.intra.peff.net>
 <YNILCDz3LpHX7OX0@coredump.intra.peff.net>
 <a93690bc-1d33-0fe0-5ca8-0e8baa9c66e6@gmail.com>
 <YNIYqFFFti73UT5+@coredump.intra.peff.net>
 <YNIZRlTic6K+6rvf@coredump.intra.peff.net>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <c4c27819-157c-d694-d758-8dbb46499ab3@gmail.com>
Date:   Tue, 22 Jun 2021 13:25:53 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <YNIZRlTic6K+6rvf@coredump.intra.peff.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 6/22/2021 1:09 PM, Jeff King wrote:
> On Tue, Jun 22, 2021 at 01:06:48PM -0400, Jeff King wrote:
> 
>>> Do you mean "if (objtype < 0)" here? There is a 'type' variable,
>>> but it is an enum decoration_type and I can't find a reason why
>>> it would be negative. oid_object_info() _does_ return -1 if there
>>> is a problem loading the object, so that would make sense.
>>
>> Whoops, thanks for catching that. I originally called it "enum
>> object_type type", but then of course the compiler informed that there
>> was already a "type" variable in the function. So I renamed it to
>> "objtype" but missed updating that line. But it still compiled. Yikes. :)
>>
>> It doesn't trigger in the test suite because it only happens if the
>> repository is corrupted.
> 
> I'm tempted by this as a cleanup on top (I don't want to do it inline,
> since the diff is so noisy). But I'm also content to leave it.

Naming is hard. This change seems worth it.

Thanks,
-Stolee
