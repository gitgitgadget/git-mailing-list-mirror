Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3FCDE81E1E
	for <git@archiver.kernel.org>; Fri,  6 Oct 2023 18:36:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233013AbjJFSg3 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 6 Oct 2023 14:36:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33846 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230415AbjJFSg1 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 6 Oct 2023 14:36:27 -0400
Received: from mail-lf1-x135.google.com (mail-lf1-x135.google.com [IPv6:2a00:1450:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8369B6
        for <git@vger.kernel.org>; Fri,  6 Oct 2023 11:36:25 -0700 (PDT)
Received: by mail-lf1-x135.google.com with SMTP id 2adb3069b0e04-5046bf37daeso3171903e87.1
        for <git@vger.kernel.org>; Fri, 06 Oct 2023 11:36:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696617384; x=1697222184; darn=vger.kernel.org;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=82Ln48Xd/Bwgi6C/t28Ow+nrYtg6QVPvQM6wTwZB0aQ=;
        b=MoOAwb8P4MDi4CidlQ9DkvsY2nNhoWSE4w85q4dclJc/EtUQewUDBG1IFd/TnNJlDp
         q/0mCbQ+lfjCRsnL49CW3bNkmNbYL+FoyUU/lnBimhNgDUr5sEIw67+r6n0jFcbnH9Sx
         pgh/Z2N9sJ3SW1C7QBgtQSC7f2zu2kHjYzL6TcgTKSASjE//zLrSWFfSGyAIUPGTJwI9
         id9lQXoej1kW8Sf+AUn++PAqkC6JDuFkeiW9b96k4uEMGmsMPYAqx8u5loN7FKZli44z
         26XZWARgVb8erwfuZzLEtqM6CxdSONMjPqNsyQdkoCpPMlvzqzkL+dfzrmQAO1SFYCXA
         Iinw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696617384; x=1697222184;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=82Ln48Xd/Bwgi6C/t28Ow+nrYtg6QVPvQM6wTwZB0aQ=;
        b=d0w2wSvMt6YE1NpLJQuTFSlrCC6yxc9uBp34chaXb/MD3U+NPMLhRU4XrnpVgNkLFC
         c3TV54bFWn7grWhW5GmTMAP9f1Vf//XM42axfbWF3V0Ipvt/t2g7O0Fes5uIQr4UapiM
         kt57F3D/CHnHCXKr1a+rG/HN2Do6lqP5icQXXS1ARiOQzNVcfN30yCfQKU4X7v/xhfyc
         h94LOgMoW0Vw8PsnrHyJdd16lKqjrXk0ECecfeajA6Hn5xrVkH31qnmSO7n6380w129N
         U1vTYk0h1a24yxpb7MYZjoblxH51dgZjbsl2eaVk6HdKPYfczBO9c6ONMpoPqsu4o2Es
         eKxg==
X-Gm-Message-State: AOJu0YyV1pseJA9zCeFYkgepS7lx7jkK+b0EsbF1ZJnKLmSYNoEteNx4
        TnZR5DZN4TrX2jHvYmWMz2/N0fAhk8k=
X-Google-Smtp-Source: AGHT+IGHG9hFN0sUDn6j8X/34MuEFVxQUTEsQGdUGhUxEZ5G60M6+dpXUHGG6GuPvV7jMdYyJ2oPLw==
X-Received: by 2002:a19:5e06:0:b0:504:4165:54c1 with SMTP id s6-20020a195e06000000b00504416554c1mr6702362lfb.7.1696617383722;
        Fri, 06 Oct 2023 11:36:23 -0700 (PDT)
Received: from osv.localdomain ([89.175.180.246])
        by smtp.gmail.com with ESMTPSA id w5-20020ac25985000000b0050579c4d0d5sm394361lfn.133.2023.10.06.11.36.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Oct 2023 11:36:23 -0700 (PDT)
From:   Sergey Organov <sorganov@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Elijah Newren <newren@gmail.com>, git@vger.kernel.org
Subject: Re: [PATCH v3 1/3] diff-merges: improve --diff-merges documentation
References: <20230909125446.142715-1-sorganov@gmail.com>
        <20231004214558.210339-1-sorganov@gmail.com>
        <20231004214558.210339-2-sorganov@gmail.com>
        <xmqq34yog3ux.fsf@gitster.g>
        <CABPp-BFsrt0zS3NHsVAyOSW6vGioe8Z-iN2M3_JNBpP2fWVq9g@mail.gmail.com>
        <xmqq7cnzaav0.fsf@gitster.g>
Date:   Fri, 06 Oct 2023 21:36:22 +0300
In-Reply-To: <xmqq7cnzaav0.fsf@gitster.g> (Junio C. Hamano's message of "Fri,
        06 Oct 2023 11:01:39 -0700")
Message-ID: <875y3jr42h.fsf@osv.gnss.ru>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

> Elijah Newren <newren@gmail.com> writes:
>
>>> > +--cc::
>>> > +     Produce dense combined diff output for merge commits.
>>> > +     Shortcut for '--diff-merges=dense-combined -p'.
>>>
>>> Good.
>>>
>>> > +--remerge-diff::
>>> > +     Produce diff against re-merge.
>>> > +     Shortcut for '--diff-merges=remerge -p'.
>>> ...
>> Perhaps:
>>
>> Produce remerge-diff output for merge commits, in order to show how
>> conflicts were resolved.
>
> I do not mind it, but then I'd prefer to see ", in order to show
> how" also in the description of "--cc" and "-c" for consistency.
>
> A succinct way to say what they do may be hard to come by, but I
> think of them showing places that did not have obvious natural
> resolution.

So, is it OK with both of you if I leave it as:

"Produce remerge-diff output for merge commits."

for now, and let you tweak the descriptions later on, if needed?

Thanks,
-- Sergey Organov
