Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD848C433B4
	for <git@archiver.kernel.org>; Tue, 11 May 2021 16:30:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6EBE16186A
	for <git@archiver.kernel.org>; Tue, 11 May 2021 16:30:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231299AbhEKQb3 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 11 May 2021 12:31:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48228 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230435AbhEKQb0 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 11 May 2021 12:31:26 -0400
Received: from mail-lj1-x234.google.com (mail-lj1-x234.google.com [IPv6:2a00:1450:4864:20::234])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D299EC061574
        for <git@vger.kernel.org>; Tue, 11 May 2021 09:30:18 -0700 (PDT)
Received: by mail-lj1-x234.google.com with SMTP id v6so25882441ljj.5
        for <git@vger.kernel.org>; Tue, 11 May 2021 09:30:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=+toTIN/Gmnv3C52krGM0Xj8faoS8DspIJh0PbrY0xE0=;
        b=uErnrmw8TzNi0W7KBzv1NG2lmKiXoeAw/s8tgVvYX9ZAYD1r0wGFvbMnO00v1eelCe
         2s7fj901uXxyBHFmuqNiBIALPVJSSfMq0pO2Yxk+6XbbChUM/AYEjBSTvCyEvWFP77mK
         wKOlyikcsPn2s4Qg0RbXDZzs9RDm4nSgoQmJwgU5XNkX/NVJcFAOMGBIh2d9ykYIjolY
         2PonLAdhlhxRcG10o4xQ08KE7LDlk8wQhhh7CdcuwmtRIoiVghRUzJ9YCtSkw0ZJpTN+
         hYtw/EXvgoWu3yaI5TCxAVfr4Q1ZEvah+x9Hq2QoF5MIdksUfYPc7FIRu/IzTObkElRB
         MWoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:date:in-reply-to
         :message-id:user-agent:mime-version;
        bh=+toTIN/Gmnv3C52krGM0Xj8faoS8DspIJh0PbrY0xE0=;
        b=J1Nf9tr4sjjT+gKI70q4a9a/4iE/zlZQ9K14qSdw0g179aB6nOjWqGVEVkrm9KRFMC
         iyYiUVAfanY/2f/DB0Errg+zkrz40Tg4lPywF4tt5AsXaQTcckzNr9Y6tpowijsw1xB2
         /a+KJEOxUkj8DC0eOPy/0OBiwleOF36VwqrjROYRs5TI90BQ9go0ttQMy2EpgbS0ojl1
         cEEYBmYUAid1JTkwowWVhw2USmiEMZUdhMFHMB+1VJjh2gvnmdZUqqvaLO5F9Gz+sDjH
         /is1nF0Wk9jkd16sVL3J8SU9lppZAGzQnzx6ZhMQOM45WjmHvQTOu55XfQGZQGUSdu7D
         N6tQ==
X-Gm-Message-State: AOAM531WyFzXM0iiLLQICjkjar2uUJj2jLfIofwSzC2OMN/FYCJmI5DZ
        J15EZYh5mAL0OJGzy+fGdbGTScSdiSM=
X-Google-Smtp-Source: ABdhPJyCpoH3nZQKL2YGuxUgjNoNOG90q5399wnVEsx7ya2lCOCdNPo3wgSdt1mcZ2fOd2y0/CN2rw==
X-Received: by 2002:a2e:9a8b:: with SMTP id p11mr13404306lji.285.1620750617198;
        Tue, 11 May 2021 09:30:17 -0700 (PDT)
Received: from osv.localdomain ([89.175.180.246])
        by smtp.gmail.com with ESMTPSA id 26sm3629174ljv.140.2021.05.11.09.30.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 May 2021 09:30:16 -0700 (PDT)
From:   Sergey Organov <sorganov@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Jeff King <peff@peff.net>, Philip Oakley <philipoakley@iee.email>,
        Elijah Newren <newren@gmail.com>,
        Felipe Contreras <felipe.contreras@gmail.com>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Alex Henrie <alexhenrie24@gmail.com>, git@vger.kernel.org
Subject: Re: [PATCH 6/6] diff-merges: let -m imply -p
References: <CAMMLpeR-W35Qq6a343ifrxJ=mwBc_VcXZtVrBYDpJTySNBroFw@mail.gmail.com>
        <20210510153451.15090-1-sorganov@gmail.com>
        <20210510153451.15090-7-sorganov@gmail.com>
        <xmqqsg2toqik.fsf@gitster.g>
Date:   Tue, 11 May 2021 19:30:15 +0300
In-Reply-To: <xmqqsg2toqik.fsf@gitster.g> (Junio C. Hamano's message of "Tue,
        11 May 2021 13:14:59 +0900")
Message-ID: <87o8dhqlm0.fsf@osv.gnss.ru>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.0.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

> Sergey Organov <sorganov@gmail.com> writes:
>
>> Fix long standing inconsistency between -c/--cc that do imply -p, on
>> one side, and -m that did not imply -p, on the other side.
>>
>> After this patch
>>
>>   git log -m
>>
>> will start to produce diffs without need to provide -p as well, that
>> improves both consistency and usability. It gets even more useful if
>> one sets "log.diffMerges" configuration variable to "first-parent" to
>> force -m produce usual diff with respect to first parent only.
>
> Please make sure that you clearly state that you do not blindly
> force --patch output in the proposed log message.  Explicitly
> mentioning that "git log --stat -m" would not give a patch but just
> diffstat would be assuring.
>
> Also this needs a test to ensure that is what happens.  Having a
> test for "log -m" and another for "log -m --stat" would be
> sufficient.

OK, will do, thanks!

-- Sergey Organov
