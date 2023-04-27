Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB371C77B73
	for <git@archiver.kernel.org>; Thu, 27 Apr 2023 05:50:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242880AbjD0FuQ (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 27 Apr 2023 01:50:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53094 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229455AbjD0FuO (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 27 Apr 2023 01:50:14 -0400
Received: from mail-pf1-x429.google.com (mail-pf1-x429.google.com [IPv6:2607:f8b0:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83CBF3585
        for <git@vger.kernel.org>; Wed, 26 Apr 2023 22:50:13 -0700 (PDT)
Received: by mail-pf1-x429.google.com with SMTP id d2e1a72fcca58-63b5c4c769aso10122862b3a.3
        for <git@vger.kernel.org>; Wed, 26 Apr 2023 22:50:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1682574613; x=1685166613;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Pie2gKBBccNSO98hbU1nOWl+2fW4EEIbUy7Xxqy9SkE=;
        b=UTpLGrPpytLcoDRwLCWiMZq9/l/nZk+GRQPU6rWX/RBXXpSNKyE98yKle91s4k0Nk8
         9sTQAEeW30cE1y8ax15g3m3DlMFSlfQQScs5Yrq87r5FZOKFO3cNosWppRSYiA/VA4wx
         fepNfzH9Vw1ATycCW5eeGU8oYRNcQGFJnRSB8D/koLFl2NPZ+uMS2QyxzIzPruDZZ/RX
         Z6MQws1PjYXdFHyhBmm/KuiBFZOd60cOJODCuKjRVmWL+JCR2ZiVgOOkdISC0qXdwX9x
         m4n2/GACRK055P4IzNJHC3ECegghQj1dWWvz8JLPliV3kVx18HMeFa6guJDMyJOV0iIG
         yYBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682574613; x=1685166613;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=Pie2gKBBccNSO98hbU1nOWl+2fW4EEIbUy7Xxqy9SkE=;
        b=JKW1f6GVPKkKCDooq7SJkIznsuMGwhhDQ7D8loQjcVkK1VKVrEvPLWHkiKb1GkRdJX
         6pWT5vUdFmlMz37zCBdEMZp/7KGagVPGkuWN40r4pRC3g5zMtgYZsAHiUKyyffo26oZg
         spJf5BLH7FJbNKnGId/rVhnPSVmW4Ko0QK/6a9aeP9qUtp7PCXGIV9NY0cjs3bt0oddx
         +j1SJ0o+6uC5H+2hJjzVrcg3p+PV0mOWhEs3b+XgqztVFvZn+MYx6b6ka7LOZdSEbUPc
         Eukn7zDBgHdtsMSBGbHWQyNlmLr5mfh1BJA43wlOkA4rI4hpeh+qQ5ixMlRpsn74jMuD
         0jLQ==
X-Gm-Message-State: AC+VfDz9EBnj4Tjq+5TJ+urebxdI5CWr2B32ldIWq2GzMk3cuij62r1S
        73x270nbB/ODPxx/hf1JhJ0=
X-Google-Smtp-Source: ACHHUZ4ChwekGtiIHGuln7wuGtD6KwyQyESEbgFJrRrSigBEbuSOt1kr16HKQVc+SyW3CzgUuwy9NA==
X-Received: by 2002:a05:6a00:2d1b:b0:63b:854c:e0f6 with SMTP id fa27-20020a056a002d1b00b0063b854ce0f6mr802040pfb.21.1682574612799;
        Wed, 26 Apr 2023 22:50:12 -0700 (PDT)
Received: from localhost (187.137.203.35.bc.googleusercontent.com. [35.203.137.187])
        by smtp.gmail.com with ESMTPSA id w66-20020a628245000000b0063f16daf7dbsm10696630pfd.55.2023.04.26.22.50.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Apr 2023 22:50:12 -0700 (PDT)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     ZheNing Hu <adlternative@gmail.com>
Cc:     ZheNing Hu via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Zeger-Jan van de Weg <zegerjan@gitlab.com>
Subject: Re: [PATCH] [RFC] transport: add --show-service option
References: <pull.1523.git.1682342241825.gitgitgadget@gmail.com>
        <xmqq354o8v8u.fsf@gitster.g>
        <CAOLTT8Qmo31YExXUOPk2sx73b734wuxiD3AUX0UAnPo9WSqpfQ@mail.gmail.com>
Date:   Wed, 26 Apr 2023 22:50:12 -0700
In-Reply-To: <CAOLTT8Qmo31YExXUOPk2sx73b734wuxiD3AUX0UAnPo9WSqpfQ@mail.gmail.com>
        (ZheNing Hu's message of "Thu, 27 Apr 2023 12:35:23 +0800")
Message-ID: <xmqqsfclnaaz.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

ZheNing Hu <adlternative@gmail.com> writes:

>> The above is a very well written description of why we _can_ do
>> this, but it is unclear why we would _want_ to do this.  What do we
>> gain by letting the individual services to declare "we are serving
>> this!"?  Do we lose an extra fork & process (it does not seem to be
>> the case)?
>
> When I was implementing a small git http server, I wanted to delegate
> everything to upload-pack and receive-pack. Everything else was fine,
> the only thing I was not satisfied with was the need to send an additional
> "#service=$servername" message when the protocol is v1.

I think you had a brief mention on that after the three-dash separator;
it *is* a relevant piece of information that needs to be in the
proposed log message.

Thanks.
