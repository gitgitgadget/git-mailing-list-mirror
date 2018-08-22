Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C93C91F954
	for <e@80x24.org>; Wed, 22 Aug 2018 15:55:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729307AbeHVTU2 (ORCPT <rfc822;e@80x24.org>);
        Wed, 22 Aug 2018 15:20:28 -0400
Received: from mail-wm0-f65.google.com ([74.125.82.65]:54711 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729288AbeHVTU2 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 22 Aug 2018 15:20:28 -0400
Received: by mail-wm0-f65.google.com with SMTP id c14-v6so2470198wmb.4
        for <git@vger.kernel.org>; Wed, 22 Aug 2018 08:55:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=CYofQD9KoYOfpaDf5uNj7JxBCjipIkGITZxjgeEp9Gg=;
        b=iDV1xK5qPvKZ7SkQMWHcaR2ORArns5UPYRl8shyG7Tv3t4a4zlK/J31GXNcYzBQCPA
         P0cubEinO9prpE9iZDK+gLGBzdgaii5AKbLcWRmOw2rWk2/p3YPM1FXd/dAZb05DXAvd
         ea0OLquXXzpUpSmkWU+Vx2hXIGAGQCWFXGUstloGsXhx31IfkQyHPsDcc/rwm3CSdX9B
         H8kHBzrJPwd3/AaQihhNN7/59QH/R+/ZlTbtq4zT+sEjb56JpdSnAx4uEM8jqPwLUtXT
         Mtdolt9bpQuD7fG0EXJUNk7bATgvsqUdzi6NYtMPgYUXLvym2wMXwyi5iqkXVQs1jzqF
         xKBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=CYofQD9KoYOfpaDf5uNj7JxBCjipIkGITZxjgeEp9Gg=;
        b=kG56HGKiZIGnt1yHW0hWfOiYlee8F2kYWnSeaEZJ/oY79yHgGda1TF4X9fwSfcRmZp
         9PdT8MSjpq1ohiNIvArWDGoUXc1u3BwJMUR0pmqzWqKtQvf1S9RVxkZbgPCTl2CUxvsd
         H2JnQWrCwkA7AilMLfTQBE6H6vPUBtIkSJz3VE81MRGDTSiZWEe6ZtEoT7MMVcJxhlYT
         wMMYiwKUHJtYhmnMhWQOP+KUHURseimgizvOpuwtfpyBkQ4TioLer4gpO2y8ZxLxNkFT
         75vLwZER8FO8lRvPDVcs1EcP5edok2R2CrbqDpXShnL+c2aAuwHLWJSKVl59jfRQzjAK
         nnIw==
X-Gm-Message-State: APzg51Ak6RlsqTNPVcKHX1BJpi82P/6Lt88l0ge4QHJxVPOiqGQ+u/xV
        bkGtOV1zcDgyD8XP1cY1Z38=
X-Google-Smtp-Source: ANB0VdaTIOYHaxKjZJZEQqh6xCZZurRgEV5vbYxD56TmkV53UB6QwNoBSAte98ZI3CmQmfk/8z/Ewg==
X-Received: by 2002:a1c:8016:: with SMTP id b22-v6mr2842569wmd.9.1534953300434;
        Wed, 22 Aug 2018 08:55:00 -0700 (PDT)
Received: from localhost (168.50.187.35.bc.googleusercontent.com. [35.187.50.168])
        by smtp.gmail.com with ESMTPSA id v1-v6sm1034715wrt.34.2018.08.22.08.54.59
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 22 Aug 2018 08:54:59 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Stephen Smith <ischis2@cox.net>
Cc:     Git Mailing List <git@vger.kernel.org>
Subject: Re: [PATCH] wt-status.c: set commitable bit if there is a meaningful merge.
References: <72756249.nAoBccgOj7@thunderbird>
        <1455590305-30923-1-git-send-email-ischis2@cox.net>
        <28440975.G22uFktzHy@thunderbird>
Date:   Wed, 22 Aug 2018 08:54:59 -0700
In-Reply-To: <28440975.G22uFktzHy@thunderbird> (Stephen Smith's message of
        "Tue, 21 Aug 2018 22:33:09 -0700")
Message-ID: <xmqqzhxe5rcc.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Stephen Smith <ischis2@cox.net> writes:

> On Tuesday, February 16, 2016 8:33:54 PM MST Junio C Hamano wrote:

Wow, that's quite an old discussion ;-)

>> So if you do this:
>> 
>>     $ git reset --hard HEAD
>>     $ >a-new-file && git add a-new-file
>>     $ git commit --dry-run --short; echo $?
>> 
>> you'd get "No, there is nothing interesting to commit", which is
>> clearly bogus.
>
> I was about to start working on working on this and ran the test you suggested 
> back in 2016.   I don't get the error message from that time period.  I 
> believe that this was fixed.   

After these:

    $ git reset --hard HEAD
    $ >a-new-file && git add a-new-file

running 

    $ git commit --dry-run; echo $?
    $ git commit --dry-run --short; echo $?

tells me that "--short" still does not notice that there _is_
something to be committed, either with an ancient version like
v2.10.5 or more modern versions of Git.  The "long" version exits
with 0, while "--short" one exists with 1.

So...?
