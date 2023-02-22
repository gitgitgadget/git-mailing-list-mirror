Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0BB7CC61DA4
	for <git@archiver.kernel.org>; Wed, 22 Feb 2023 23:15:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232238AbjBVXP4 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 22 Feb 2023 18:15:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35622 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229922AbjBVXPy (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 22 Feb 2023 18:15:54 -0500
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com [IPv6:2607:f8b0:4864:20::1033])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0247F37F0D
        for <git@vger.kernel.org>; Wed, 22 Feb 2023 15:15:54 -0800 (PST)
Received: by mail-pj1-x1033.google.com with SMTP id qi12-20020a17090b274c00b002341621377cso10514390pjb.2
        for <git@vger.kernel.org>; Wed, 22 Feb 2023 15:15:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2HAs6RWjds1xnQnh/ujcnTASaKnQnCCrQxRl4I7VDBs=;
        b=XAS1d0KZBzc3lODUQrFkGmM6bq6nx/kJYG6UlB4Ld6aGuHXqyNvab/ge/WpQXhwXx0
         IqJJ1DDYgl4GGLPfwlo6Bf4241u6FEmQ/IQfV5y8PSfp6gKt9lA4vgFKcVMQq+IltTh8
         GZwGWdfkM0GY4N2nfb7N/4xxrxTxTlT9JtUfhLwQ7ccp6/XXmYa9bvcBm2AvLc2rSaH8
         AsaFQUsixbvDroEg1+eREmVBA47VLIzUcK8jiB8kjrjygfV5EMSj4a5AQ08XwvpuNPFV
         loROWPLMhX0pLuwpf/gJfGUBCulEnwoB3UultdjyXTJIFJKu7+yU6+j+vicpajVA6mNk
         rfXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=2HAs6RWjds1xnQnh/ujcnTASaKnQnCCrQxRl4I7VDBs=;
        b=EG32VL0UJBqap2ZRs2Jx7aQh24/ITtSFPWj91WHind5tSeqV3c1jI79vRIwvY2Fmz/
         yj1srPhkuOqPvUxf2JW43dSDNN/xLY9dDUHZhXfg0YC9uykrWe3JYoftss3nGhswMxCV
         qan90VOyPsye1RC0RcInDTWUtsNzr2INxtpdXsiYr/0aQl7ZrLzlKm4Ln283q/qGGyYX
         +mvHWR8H1OGtYxvGr2/CkvLdGYMIhqPUOmfzsXONncWE9UE0z1TjowepfZ1hNgn2RaD6
         /ZDpkOPJ4lovpmGXQx9uApDhO1BDzbdePrz+rjfJF1JklADfmG/UsTUuZ5hE07GqLvbo
         owxw==
X-Gm-Message-State: AO0yUKUsjapJNp2AoQDMPl8xXzqSYVrXDy4Da8jejqECYJ8O4W+ylhSV
        csI8mSTEG7kwHt6VYfRh864=
X-Google-Smtp-Source: AK7set8VL7z/SyapSfdTIICvwbZXqxLA8TBiO1ZbOe6mWQ4KK1ViUXH2TH4QErfH1BWXDSLKM+fTMA==
X-Received: by 2002:a17:90b:4a43:b0:234:10c:a0d0 with SMTP id lb3-20020a17090b4a4300b00234010ca0d0mr10924398pjb.6.1677107753398;
        Wed, 22 Feb 2023 15:15:53 -0800 (PST)
Received: from localhost (252.157.168.34.bc.googleusercontent.com. [34.168.157.252])
        by smtp.gmail.com with ESMTPSA id u1-20020a17090ae00100b00227223c58ecsm5313374pjy.42.2023.02.22.15.15.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Feb 2023 15:15:52 -0800 (PST)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     Teng Long <dyroneteng@gmail.com>
Cc:     avarab@gmail.com, git@vger.kernel.org, sunshine@sunshineco.com,
        tenglong.tl@alibaba-inc.com
Subject: Re: [PATCH v5 3/3] notes.c: introduce "--separator" option
References: <xmqq4jreemdn.fsf@gitster.g>
        <20230222081708.8010-1-tenglong.tl@alibaba-inc.com>
Date:   Wed, 22 Feb 2023 15:15:52 -0800
In-Reply-To: <20230222081708.8010-1-tenglong.tl@alibaba-inc.com> (Teng Long's
        message of "Wed, 22 Feb 2023 16:17:08 +0800")
Message-ID: <xmqqy1opb8bb.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Teng Long <dyroneteng@gmail.com> writes:

> Junio C Hamano <gitster@pobox.com> writes:
>
>> > We use "parse_msg_arg" as a callback when parsing "-m " by OPT_CALLBACK_F,
>> > so if we have to read the separator before we parse it, so we could insert
>> > it correctly between the messages, So I use OPT_STRING_LIST instead.
>>
>> That is an implementation detail of how you chose to implement the
>> feature, and not an inherent limitation, is it?  It makes a lame
>> excuse to give users a hard-to-use UI.
>
>> For example, we could parse all the command line parameters without
>> making any action other than recording the strings given to -m and
>> contents of files given via -F in the order they appeared on the
>> command line, all in a single string list, while remembering the
>> last value of --separator you got, and then at the end concatenate
>> these strings using the final value of the separator, no?
>
> Yes, please let'me clarify it, we shouldn't to give users a hard-to-use UI, so:
>
>      1. order of "-m" and "-F" matters, it determine the order of the paragraphs
>      (remain the same as before, which I need to fix in next patch).
>
>      2. order of "-m""-F" and "--separator" doesn't matter.
>
> Thanks.

Sounds good.
