Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4B4121F453
	for <e@80x24.org>; Fri, 18 Jan 2019 20:13:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729410AbfARUNY (ORCPT <rfc822;e@80x24.org>);
        Fri, 18 Jan 2019 15:13:24 -0500
Received: from mail-wm1-f67.google.com ([209.85.128.67]:35712 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729356AbfARUNX (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 18 Jan 2019 15:13:23 -0500
Received: by mail-wm1-f67.google.com with SMTP id t200so5699387wmt.0
        for <git@vger.kernel.org>; Fri, 18 Jan 2019 12:13:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=zWBv6STVitLwmafXTlkwBHobeiKruQIGt5mhMUg77II=;
        b=IDt3AIN4hb3p6G6lUZY2Q0EtdPEvfPDMGBiX/CU+SzHVlSllb3414Gzk6GltC1075d
         G63oXUhf73ergvgvyIl3Ij5zMeIlsHS4Ls8/Em70DW6xiYjbdeJUveVq//VKd4/iMROZ
         8xSsvCYtnXfNpcFByd5DbqcGesdIn8/sj2VS+nmRJr3mxrp1Sk8yeCb3fOjiXyFNYaRY
         RHWgPT5bFK1rtBstnP/czTHpDw8Ewv2Z70aNlj0FQ7jU7f8SWPTD5OIyXaJB2e07qdyA
         tWJo5xN1n9bWLgmBkKlHKMblDALjtWIpBsOAg1SpO/pW3qWJo6LMwqeegPNdlimjbGGl
         07qQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=zWBv6STVitLwmafXTlkwBHobeiKruQIGt5mhMUg77II=;
        b=Fq0w1QvkwRwHkHqdvVWRIbtjCZx7ubOaUjowF30NkXmPrp3gsExLDyCrGXeDRGrFZu
         6iUzEEyUQ9pvBOXv9WEPHJS0B+naeGNCu4jLRe41ZwGy43/MHqK+Zm9s0KzzxhI9zGnm
         yYnak57eGxpcrmxrqrqQW/ab4M6TdgXG0uv6Vwp5qKDlg99HGkozdlYf88BCqQ5/+0if
         e+Dg7398OlLBbWvsFTRA5KQaRrp6OrqHxe/O1r5knmfNWDp9G7yCwPlWFN8usr5INkbI
         UnH37hYVMxWaV1gJ2u2gKkTkYITTEpIKIjHyfCwbLer8NQrXU39H7mIZwjkuisn63jeZ
         rweg==
X-Gm-Message-State: AJcUukf/5wswmhoRh32G3o/nsBi9NXbou+Lbu/GWS73kg+U2sRmMxeRT
        HoLAqv2bNcUf0per0k9DQpo=
X-Google-Smtp-Source: ALg8bN4V6lCSMBUiapxpERzdIEMI3f6NIv6L2U0QtbRbP3wtZsl60g5AMe0O4mebhhCH6KnXfSuk6A==
X-Received: by 2002:a1c:180a:: with SMTP id 10mr16711202wmy.92.1547842401027;
        Fri, 18 Jan 2019 12:13:21 -0800 (PST)
Received: from localhost (112.68.155.104.bc.googleusercontent.com. [104.155.68.112])
        by smtp.gmail.com with ESMTPSA id k19sm130946219wre.5.2019.01.18.12.13.20
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 18 Jan 2019 12:13:20 -0800 (PST)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH v2 0/4] Let the builtin rebase call the git am command directly
References: <pull.24.git.gitgitgadget@gmail.com>
        <pull.24.v2.git.gitgitgadget@gmail.com>
        <xmqqef99lu2c.fsf@gitster-ct.c.googlers.com>
Date:   Fri, 18 Jan 2019 12:13:19 -0800
In-Reply-To: <xmqqef99lu2c.fsf@gitster-ct.c.googlers.com> (Junio C. Hamano's
        message of "Fri, 18 Jan 2019 10:06:03 -0800")
Message-ID: <xmqqa7jxk9ls.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

> "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
> writes:
>
>> Especially on Windows, where Unix shell scripting is a foreign endeavor, and
>> an expensive one at that, we really want to avoid running through the Bash.
>>
>> This not only makes everything faster, but also more robust, as the Bash we
>> use on Windows relies on a derivative of the Cygwin runtime, which in turn
>> has to jump through a couple of hoops that are sometimes a little too tricky
>> to make things work. Read: the less we rely on Unix shell scripting, the
>> more likely Windows users will be able to enjoy our software.
>>
>> Changes since v1:
>>
>>  * Rebased on top of master to avoid merge conflicts.
>
> I do not appreciate this very much.  
>
> We already have a good resolution prepared when merging this to
> either 'next' or 'master', which also resolves conflict with the
> other topic that requires this topic to add "--topo-order" in its
> call.  Rebasing series means invalidating the previous work recorded
> in rerere.
>
> 	side note. The rerere database entry can be recovered from
> 	master..pu with contrib/rerere-train.sh).

I prepared a set of patches rebased back on top of the previous base
and applied them on top of the previous base (call the result X).

Applying the posted patches directly on top of master, and merging X
into master, produces the same tree.

So I'll keep the X (i.e. these patches backward-rebased to the
previous base) and replace js/rebase-am with it.  That is safer when
recreating 'pu' and merging it to 'next', which I hope we can do
soonish.

> Will take a look.  Thanks.

They were pleasant and smooth read.  Crafted nicely.

Thanks.


