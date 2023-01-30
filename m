Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68531C54EED
	for <git@archiver.kernel.org>; Mon, 30 Jan 2023 15:40:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236566AbjA3Pko (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 30 Jan 2023 10:40:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52052 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236218AbjA3Pkj (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 30 Jan 2023 10:40:39 -0500
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3266C3E0B6
        for <git@vger.kernel.org>; Mon, 30 Jan 2023 07:40:35 -0800 (PST)
Received: by mail-pj1-x102d.google.com with SMTP id t12-20020a17090aae0c00b00229f4cff534so13515380pjq.1
        for <git@vger.kernel.org>; Mon, 30 Jan 2023 07:40:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=KOvs0GFSu0wXpf3H0PcRQ7fWO0xIVoNmz7/bEp5YWXU=;
        b=YNggIPbKf6T7UeNwGzJHp/15QST+FhPtltwkyLPbWqDbqsaBbNe0ChMH8t3K55j+MI
         Yk/YyjnUMdzo3g2j1g5fCeOqNPOL3x9w5teNHWC9wYVvZMwYv+Vd6CplTnN6y5Hv5Xr1
         75j68pmbyzzG82j91hPV2Ps5gSCcFXuYl0o8cmCRnuAYXGV0Nu6PF2MoXPRCeYBjTNlq
         dNykU9/oSiQ3DHrkyH96TVHae1/S7gLGsO/d4EEoe6gN3JlQmp3x8PiT/W8Tz+hEVbor
         ETKf+6FHPdELSbGibr+AYoKdVJ8wCI72ULcLOWJACI8gZiLEUcdDRFrZkZJRCemyRTyi
         aCDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=KOvs0GFSu0wXpf3H0PcRQ7fWO0xIVoNmz7/bEp5YWXU=;
        b=ULzWkC4+8chUVTWnPUqpe3tD2xRGqP9wv2syXZ6u5C2tv8vFIZq+vYk66A7EhUEgHV
         bXlCQ0lAHzv83SDwd55q6B9qy2YJynVuvqcWcTR/uOQE8mirImt6K2zWv4EDNe6lpEyU
         3Hepe/pRO9msAEFQk55AibTkEv6CXIg0tKtZHF+TMClYoejI7OzTLWrNltw/p38yXx0R
         q0LcGC4Hz5IE/edrbY55JEk6P9Qu9H9UWXABSBBEWe330r+9OJQH9QvKGb4MbnJj8XLX
         s/jZ3tX6vZ/1RJVhvzZBXTOWlbLsAGAp9ziStok1fdmHd3Fy8vT+tr5Rz8RyMozxCoPd
         mP3g==
X-Gm-Message-State: AO0yUKXkYrCgnCTyX6kQ2lxNdjhXrgdtS0WSW+h/g0i5qeKMFNg69elb
        dLbl4jW3/w19ipohddoK/jY=
X-Google-Smtp-Source: AK7set+5ea5+pTWx8PoRD/Sq2+co4xfpfkySX9fz2U7w8NVondk11OJY8iBxNBIbDFwdUkSSKRsOnw==
X-Received: by 2002:a17:902:ec82:b0:196:125a:e4b8 with SMTP id x2-20020a170902ec8200b00196125ae4b8mr32180785plg.12.1675093234571;
        Mon, 30 Jan 2023 07:40:34 -0800 (PST)
Received: from localhost (137.22.168.34.bc.googleusercontent.com. [34.168.22.137])
        by smtp.gmail.com with ESMTPSA id r20-20020a170902be1400b00192a8b35fa3sm7966249pls.122.2023.01.30.07.40.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Jan 2023 07:40:34 -0800 (PST)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     Derrick Stolee <derrickstolee@github.com>
Cc:     Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, vdye@github.com
Subject: Re: [PATCH 3/3] scalar: only warn when background maintenance fails
References: <pull.1473.git.1674849963.gitgitgadget@gmail.com>
        <d75780e0567b5f765816ab7522afe550ebaa3521.1674849963.git.gitgitgadget@gmail.com>
        <xmqqleln90ka.fsf@gitster.g>
        <4913381a-769f-aba0-c04d-559d103e8396@github.com>
        <xmqq357v8poc.fsf@gitster.g>
        <b63611dc-a889-8900-403a-ec7c42a89705@github.com>
Date:   Mon, 30 Jan 2023 07:40:33 -0800
In-Reply-To: <b63611dc-a889-8900-403a-ec7c42a89705@github.com> (Derrick
        Stolee's message of "Mon, 30 Jan 2023 08:44:23 -0500")
Message-ID: <xmqqk01458um.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Derrick Stolee <derrickstolee@github.com> writes:

>>> Here, we are in an environment where background maintenance is
>>> unavailable in an unexpected way. If that feature is not available
>>> to the user, should they not get the benefits of the others?
>> 
>> That is not what I was saying.  I just have expected to see a way
>> for the user to give scalar an explicit "I understand that periodic
>> maintenance does not happen in this repository" consent, instead of
>> demoting an error detection for everybody to a warning that users
>> will just ignore.
>
> Ah, so you'd prefer a --no-maintenance option for users who have
> this problem instead of just a warning. I'll do that in v2.

Or a repository-local configuration to declare "no need to do the
maintenance stuff here", probably?  The expected use case you gave
does not match per-invocation command line option very well, right?

> This could be a good time for me to upstream the --no-src option
> while I'm messing with arguments in 'scalar clone'.

OK.  Thanks.

