Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42327C432BE
	for <git@archiver.kernel.org>; Mon, 30 Aug 2021 17:40:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2C59560F3A
	for <git@archiver.kernel.org>; Mon, 30 Aug 2021 17:40:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238225AbhH3Rl2 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 30 Aug 2021 13:41:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37560 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238247AbhH3RlZ (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 30 Aug 2021 13:41:25 -0400
Received: from mail-lj1-x22e.google.com (mail-lj1-x22e.google.com [IPv6:2a00:1450:4864:20::22e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 29119C061575
        for <git@vger.kernel.org>; Mon, 30 Aug 2021 10:40:31 -0700 (PDT)
Received: by mail-lj1-x22e.google.com with SMTP id i28so27267642ljm.7
        for <git@vger.kernel.org>; Mon, 30 Aug 2021 10:40:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=9gjJw/Zg4ujw6Qn8IGacr9Y86b61V440vxiFr3aBxMo=;
        b=o3STPM0XXFYXh6c+mUB0Wy+KMLd5yL4g/NqlYbdMYDagJiSnRFazpXF5+v98vYWu8t
         qUCLs+a+Ky6v/ltSIL+CfY5h2kbMjrSa8bguPDnlPxw0+fVKZvV8I4RXSWsA9j1X/9bU
         ZMSjOdzWuB5tW3Y4VwxN2shj6Vo3cyk4yY2n948+I57UShbIhGYPWw3W6FriEAcyqaTa
         YMq2R23hvHn5LDTLyEhm53PbzqlhWsL4dvqTsVcQCrCTvuogOzSHu+WtHxxYlLPgWXdv
         kGl+/p0Q3T3lx+3XbSQnMTvo9eseJCFm8OWWG+CzYlZYEYbv9vFhWUmonbR0OP5RKeJH
         iBlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:date:in-reply-to
         :message-id:user-agent:mime-version;
        bh=9gjJw/Zg4ujw6Qn8IGacr9Y86b61V440vxiFr3aBxMo=;
        b=AVeqaj+agPO/YtB1P7HYCLdXGvW8wDATu6MTWrKwuEhYb/mUuuI0IBqD7jkVKLW7jn
         qAFScI7x0eKGLgayPrx8ab7ZS/WQgmr0RRUerFnpRUqK/+tqEKwoRKAu2UQfd2dP9r6Z
         xAoApVHws/kTiXH/lU05MVFcYu4A14b/hkdvYsgR+KtGEEtZ0+yMzLERR8s+KOxWnS72
         A2lI5VWpNlI+XwNU2dI3gjhH+QhqFTsyt61xcWgQS0BBqdSRR0TYhgFLA/VtUBxsmssj
         7Y47COb5FrKua17M8DvwwF3kXTK/Ozc8FfXN2ea8ciH7c+7mm21Y7BCo4QL21j6IMp10
         z4Ww==
X-Gm-Message-State: AOAM532Bm8RXXngrSw0IT9NTQBB+MJxWzg51ThEyp0g2to60YsmSyRBs
        Lm7PtJNXWZLehmZuw9h0tL8=
X-Google-Smtp-Source: ABdhPJzuRI6QGuRz3OjMYoAYl9pDLdZsrKURxuGqv9yslkOPiNGxt44v1II/cX7gIa28aN6/oZNNAQ==
X-Received: by 2002:a2e:b7c8:: with SMTP id p8mr20786793ljo.32.1630345229123;
        Mon, 30 Aug 2021 10:40:29 -0700 (PDT)
Received: from osv.localdomain ([89.175.180.246])
        by smtp.gmail.com with ESMTPSA id j22sm874751lfh.101.2021.08.30.10.40.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Aug 2021 10:40:28 -0700 (PDT)
From:   Sergey Organov <sorganov@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Johannes Sixt <j6t@kdbg.org>,
        Git Mailing List <git@vger.kernel.org>,
        Paul Mackerras <paulus@ozlabs.org>
Subject: Re: diff-index --cc no longer permitted, gitk is now broken (slightly)
References: <e6bd4cf7-ec8b-5d22-70f6-07089794df0c@kdbg.org>
        <xmqqsfyq501v.fsf@gitster.g>
Date:   Mon, 30 Aug 2021 20:40:27 +0300
In-Reply-To: <xmqqsfyq501v.fsf@gitster.g> (Junio C. Hamano's message of "Mon,
        30 Aug 2021 10:12:28 -0700")
Message-ID: <87o89e3k6s.fsf@osv.gnss.ru>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.0.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

> Johannes Sixt <j6t@kdbg.org> writes:
>
>> Since 19b2517f95a0 (diff-merges: move specific diff-index "-m" handling
>> to diff-index, 2021-05-21) git diff-index no longer accepts --cc. This
>> breaks gitk: it invokes
>>
>>    git diff-index --cached -p -C --cc --no-commit-id -U3 HEAD
>>
>> to show the staged changes (when the line "Local changes checked in to
>> index but not committed" is selected).
>>
>> The man page of git diff-index does not mention --cc as an option. I
>> haven't fully grokked the meaning of --cc, so I cannot tell whether this
>> absence has any significance (is deliberate or an omission).
>>
>> Is gitk wrong to add --cc unconditionally? Should it do so only when
>> there are conflicts? Or not at all?
>
> I think --cc is designed to naturally fall back to -p when there is
> only one parent.  Use of both -p and --cc has also long been an
> acceptable combination, and even if we say the later --cc overrides
> -p, there is no reason not to show single parent patch here with
> --cc.

I'm pretty sure I've checked diff-index doesn't use the flag that --cc
sets when I wrote the patch, so the only incompatibility this patch
introduced is denying the command when --cc is given, i.e., it now
behaves as if diff-index doesn't support --cc *option*, that makes sense
to me and matches diff-index documentation.

Irrespective to chosen solution, it still looks to me like gitk
shouldn't had --cc in that command in the first place. I that correct,
or do I miss something essential?

That said, if you think that diff-index should silently accept --cc (and
-c ?), for whatever reason, it's fine with me, provided it's properly
documented and there are proper test-cases in place.

Thanks,
-- Sergey Organov
