Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF6FCE81E1C
	for <git@archiver.kernel.org>; Fri,  6 Oct 2023 17:03:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232198AbjJFRDG (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 6 Oct 2023 13:03:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58702 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232927AbjJFRDD (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 6 Oct 2023 13:03:03 -0400
Received: from mail-lj1-x234.google.com (mail-lj1-x234.google.com [IPv6:2a00:1450:4864:20::234])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5FA2DE4
        for <git@vger.kernel.org>; Fri,  6 Oct 2023 10:03:01 -0700 (PDT)
Received: by mail-lj1-x234.google.com with SMTP id 38308e7fff4ca-2c1854bebf5so28555471fa.1
        for <git@vger.kernel.org>; Fri, 06 Oct 2023 10:03:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696611779; x=1697216579; darn=vger.kernel.org;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=GRfnMVhMrg5JVXgmBtRgMoIR+s6czZMfVm6plKWJ5n4=;
        b=SsVK2zylfzSUzoDIqiYTmbClmb4K7QKBTlm2Mx/StAT9+bWjXXHPi/+sACtpt4BCgT
         asyhHCQL2flO+d1zkTQZLaHlkHrewhJ09rMIJ1Wj7+ZYe+gROKxNYmPP1hASdXCoZC2Y
         PNRdhEAYllDPJ0x1GvYVJUwrIfTw5cQpYo5uZxx5YJ13olE6ZpWtcFzgWsm3qcx3nZSF
         URGuXYpOy8JmCLcCf7HOBoGnsSyj/FFwaInpOh4b6oDInJQNlnybO3kHiOYcpDYJ+r6s
         1KsZAKBnwwhc19VF/8vtiPIgAVQ1WH2ly9FCjYWzt4GS32Usho1XqGuZm4cZKj8+3IEO
         xBGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696611779; x=1697216579;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GRfnMVhMrg5JVXgmBtRgMoIR+s6czZMfVm6plKWJ5n4=;
        b=o0Q6/pqlgYFmRdpPRQJNO0RJwwg6lb+e23sQR6AnAJF4Z3qyB2cjNi8W3HyH5dNYpA
         iBw+3gbg5Y/dp/cK7nDyZx1r8Oc+KndOcJ8+zrj1UEUEwm9w7uy/SyM/K+Q4RR4oVeC6
         QbBXxbLLK/S/IJO6Re7sF0gAnX8iAdOtFHUGme3OsBMSAX1Edb5WwuFWxyiQOXzKpxGR
         w0wg44coLhSCdXHSD0v81UgU3dubGJ95K48AYoUb47Gybj/JLvyIlo0IryGUnDlVfU8I
         1nSkQz5D5nQPoPC1RW/PUySjOdTqJFHbdyh2X44FdaTyJBUTYyzbOMsbIER2sacjcz18
         /03A==
X-Gm-Message-State: AOJu0YywbIFnj9GEF/uxaqoZnpUyDnuyVVeAAAzuaad0l+oUlLTOYW1N
        WHKl12FrrZZL5newEdvVEuxkahTXPfA=
X-Google-Smtp-Source: AGHT+IErZolTM+O6xqzTR/WVUsA2nbmXAah/D0ru19hTAH7E/lN8A9MAsqr/IWUy4pT1Z/318b5XNg==
X-Received: by 2002:a2e:b78b:0:b0:2bb:985f:8479 with SMTP id n11-20020a2eb78b000000b002bb985f8479mr7282118ljo.48.1696611778971;
        Fri, 06 Oct 2023 10:02:58 -0700 (PDT)
Received: from osv.localdomain ([89.175.180.246])
        by smtp.gmail.com with ESMTPSA id h15-20020a2eb0ef000000b002bce8404157sm850409ljl.12.2023.10.06.10.02.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Oct 2023 10:02:58 -0700 (PDT)
From:   Sergey Organov <sorganov@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Eric Sunshine <sunshine@sunshineco.com>, git@vger.kernel.org
Subject: Re: [PATCH v3 1/3] diff-merges: improve --diff-merges documentation
References: <20230909125446.142715-1-sorganov@gmail.com>
        <20231004214558.210339-1-sorganov@gmail.com>
        <20231004214558.210339-2-sorganov@gmail.com>
        <CAPig+cT63L2+XmDRKw4Pc+iDmUL+UFcyummOcOtS+3wYaNbFvg@mail.gmail.com>
        <xmqqcyxshizq.fsf@gitster.g>
Date:   Fri, 06 Oct 2023 20:02:57 +0300
In-Reply-To: <xmqqcyxshizq.fsf@gitster.g> (Junio C. Hamano's message of "Thu,
        05 Oct 2023 14:11:53 -0700")
Message-ID: <874jj3smym.fsf@osv.gnss.ru>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

> Eric Sunshine <sunshine@sunshineco.com> writes:
>
>>> diff --git a/Documentation/diff-options.txt b/Documentation/diff-options.txt
>>> @@ -43,66 +43,74 @@ endif::git-diff[]
>>> +-m::
>>> +       Show diffs for merge commits in the default format. This is
>>> +       similar to '--diff-merges=on' (which see) except `-m` will
>>> +       produce no output unless `-p` is given as well.
>>
>> I'm having difficulty grasping the parenthetical "(which see)" comment.
>
> I am, too.  I know what it means when written in the more common
> Latin abbreviation (q.v.), but I suspect it may be rare to spell it
> in English like this.  I found

Well, I didn't invent it, and didn't lookup it until asked, it just
popped-up out of my head somehow.

I'll remove it as causes confusion.

Thanks,
-- Sergey Organov
