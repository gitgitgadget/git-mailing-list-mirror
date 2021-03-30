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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97037C433C1
	for <git@archiver.kernel.org>; Tue, 30 Mar 2021 19:33:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5F060619AB
	for <git@archiver.kernel.org>; Tue, 30 Mar 2021 19:33:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233173AbhC3Tcv (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 30 Mar 2021 15:32:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55096 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233113AbhC3Tco (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 30 Mar 2021 15:32:44 -0400
Received: from mail-qk1-x72a.google.com (mail-qk1-x72a.google.com [IPv6:2607:f8b0:4864:20::72a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46467C061574
        for <git@vger.kernel.org>; Tue, 30 Mar 2021 12:32:44 -0700 (PDT)
Received: by mail-qk1-x72a.google.com with SMTP id g20so17059931qkk.1
        for <git@vger.kernel.org>; Tue, 30 Mar 2021 12:32:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=gPau7APIOA6JYTm4H9HfR+WB/inhBTSieSQURY26s3A=;
        b=i/SupsN+KnoSvZk8MLLwVdccJplCdu68N2t1FzmJo+NhVUty6L5ZBxcVVQE37Xv9MU
         E6fmypaL4YE08oZblR1WpcZtZXQGrQY3goMZZSN3IqHRYhEtySUEqV2GeM3rpVb3QYZE
         W699yclDnAj8zpRI0sUP6b01FriyNGVjXvM0/6RohDMlKroMz4QkC0oSNxrxiA+GTH0V
         xLJlbI3AAmcE3J1h+K0NLtxSOIQIuz/HicyKG2fVkSrfDb3WV7wp3GB9IJUL9hnTzRlO
         m8owXZgvJguSdXY0yb53m+DxTgts3yTqKil5Z0MXXOZBVPrKRlUh1eksVYHx1dQMW6pS
         xGzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=gPau7APIOA6JYTm4H9HfR+WB/inhBTSieSQURY26s3A=;
        b=eOaRnU3Al/7+phZiGeYudxoNqNNN2JW4Mm5spPu9XwfEl/7y99TBuadMtLe5r4U/4i
         t8yDwKgN6PUCS2Z1WU0cxLenGE9K+enCrX/AuHDzXOhC4GRdUXNdsyTZG3U7+x8JA8kS
         yLWLl3+2sMhsDx2t0PaC2BeCmKjXlGtmjc8houpVd9HW5MYvH8MawQM7w2kMZIy4XUUQ
         Ge9o/LHGoSZbAOgOKBHrWogckgUTZMttFmBZY3t9ybNmXPpZPIzeycHfPfGDk0hkoa72
         Fmj6Qu5bsAduu6mi7p2gGp8eCtx7D9ct1rZu2OVyT7zJ5OQR7flb84xY2tN9p7NpeRLm
         J+1w==
X-Gm-Message-State: AOAM532kMML/lrGG+YwUJoOQjXsEO2oo7vUdCtc47O2HRjNFIJt+bLwO
        QB7P6eT87axZz/F2d1baTpNC4fWXvlp7pA==
X-Google-Smtp-Source: ABdhPJwPaHnHkNy+V+rWiPo434v5RmTpsDPSjormewa8HI2nuQTF8gmsF4uabzaECs2HaUDpbYlhfA==
X-Received: by 2002:a37:9a8f:: with SMTP id c137mr32351528qke.495.1617132762637;
        Tue, 30 Mar 2021 12:32:42 -0700 (PDT)
Received: from ?IPv6:2600:1700:e72:80a0:51d7:1436:793b:b3c9? ([2600:1700:e72:80a0:51d7:1436:793b:b3c9])
        by smtp.gmail.com with ESMTPSA id v7sm16501063qkv.86.2021.03.30.12.32.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 30 Mar 2021 12:32:42 -0700 (PDT)
Subject: Re: [PATCH] maintenance: specify explicit stdin for crontab
To:     Kevin Daudt <me@ikke.info>,
        =?UTF-8?Q?Martin_=c3=85gren?= <martin.agren@gmail.com>,
        Git Mailing List <git@vger.kernel.org>
References: <20210329210928.561586-1-me@ikke.info>
 <CAN0heSrSNJhy33Wi9Yq8kfnkJEyvQoadyj8joLqHtV+SYPs1sw@mail.gmail.com>
 <25ea6f26-c829-f63f-77a1-11a28bbe7fc0@gmail.com> <YGNcA3paBeZ8mYVP@alpha>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <bc4d77cd-5b2a-bdda-d447-8bf9d44c313f@gmail.com>
Date:   Tue, 30 Mar 2021 15:32:39 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.9.0
MIME-Version: 1.0
In-Reply-To: <YGNcA3paBeZ8mYVP@alpha>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 3/30/2021 1:12 PM, Kevin Daudt wrote:
> On Tue, Mar 30, 2021 at 08:02:22AM -0400, Derrick Stolee wrote:
>> On 3/30/2021 1:41 AM, Martin Ågren wrote:
>>> On Mon, 29 Mar 2021 at 23:23, Kevin Daudt <me@ikke.info> wrote:
>>>>
>>>> There are multiple crontab implementations that require stdin for
>>>> editing a crontab to be explicitly specified as '-'.
>>
>> Thank you for reporting this, especially with a patch!
>>
>> However, I'm not sure about this adding of '-' being something that
>> crontab ignores so commonly. My Ubuntu machine reports this:
>>
>> $ crontab -e -
>> crontab: usage error: no arguments permitted after this option
>> usage:  crontab [-u user] file
>>         crontab [ -u user ] [ -i ] { -e | -l | -r }
>>                 (default operation is replace, per 1003.2)
>>         -e      (edit user's crontab)
>>         -l      (list user's crontab)
>>         -r      (delete user's crontab)
>>         -i      (prompt before deleting user's crontab)
>>
>> Is there a way we could attempt writing over stdin, notice the
>> failure, then retry with the '-' option?
> 
> We do not use -e to edit, we run `crontab` and provide the contents to
> stdin. `crontab -e` just opens the crontab in the users editor, which
> would work with busybox as well, but that's not what's being done here.

Thank you. Of course. Muscle memory from testing crontab manually.

Thanks,
-Stolee

