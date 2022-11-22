Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11A0BC4332F
	for <git@archiver.kernel.org>; Tue, 22 Nov 2022 04:28:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230139AbiKVE2X (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 21 Nov 2022 23:28:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50534 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229553AbiKVE2V (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 21 Nov 2022 23:28:21 -0500
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com [IPv6:2607:f8b0:4864:20::1034])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE21BB1E
        for <git@vger.kernel.org>; Mon, 21 Nov 2022 20:28:18 -0800 (PST)
Received: by mail-pj1-x1034.google.com with SMTP id v3-20020a17090ac90300b00218441ac0f6so698948pjt.0
        for <git@vger.kernel.org>; Mon, 21 Nov 2022 20:28:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:user-agent:message-id
         :in-reply-to:date:references:subject:cc:to:from:sender:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DnsAztif9bmgx6itHybSFgyAqIBvD6QCSzb/C8pkYOs=;
        b=qiwfEgliGNKzJx5UybswsRARtL3b9fCdv27S4UY/wg0vBcpaPaTOrRQVaLbbWzWVJu
         kTvYJkGMx1FIP40N68iBZLYZY8KT5JAZ6X817zkpxDrdeJUAyNo759nKVE+SOs+P875l
         u1rgdBl5X7q5UbEvwsKhGWc6dlr4AAAC558VyToBnqL5QxawantX1bXXNA+cKRvORRrf
         TiytgL74sLRZJdNAuxoehOp4SJ5c3cXCH3vHxcpXm9oBNdGSDAyC0zLGJCWmxQFy8NWF
         9LU3qCitzlpAR2QgdxCXetQywFsR4AYGaxnjghAzLX2IAYdzekiAkzTaFHYlXOz+NlHV
         uyow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:user-agent:message-id
         :in-reply-to:date:references:subject:cc:to:from:sender
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=DnsAztif9bmgx6itHybSFgyAqIBvD6QCSzb/C8pkYOs=;
        b=XnWQz4nbMVZHVsf59xTscwpHEs2XiXTBzqzCJXHeJkX3YRLKBLnh/VIJ3yVfi/Dd0Y
         G0ALcw7qzYVATlQeambeOJFQHkA6d8bf+L9tp90KpjWpBC35h5YBxlRWot9Kb/gmOQbs
         M1kNq0x5iApdvNfJiX/CR1CNbhmYiYKbkuoEBGDIgjyQlDfJ3Au6RL/KXF8vp967+KUM
         1gcb6KhkAnprHM2eNyz48zwAbuO21UR9p0Ho7J3R152/DEQtsJlu4nSBh+wcXa19qGhJ
         TwCEMr+a+OhrnG83xBBSR60FlkfRSd4L/e2QHfnN4Z9TbSDHfZx+7RJa0cqfDtYQUWbp
         0e1w==
X-Gm-Message-State: ANoB5pmarpT9P/JVeCu6ikHPjslfnKwDas3wHSHtImcokQgLxaNwXfPQ
        9nOfHhTGReqwx21HHXYCQghw4ugyUol30w==
X-Google-Smtp-Source: AA0mqf4kglOZgfF762Wrzy8J7dhNaaW4WrngeUhmL9x8k4rWhA0foMmMEFka2Egc05Z1H7k0+89pOQ==
X-Received: by 2002:a17:90b:4382:b0:20b:c375:575 with SMTP id in2-20020a17090b438200b0020bc3750575mr23203015pjb.174.1669091298105;
        Mon, 21 Nov 2022 20:28:18 -0800 (PST)
Received: from localhost (33.5.83.34.bc.googleusercontent.com. [34.83.5.33])
        by smtp.gmail.com with ESMTPSA id q27-20020a63505b000000b00476799699e4sm8300103pgl.30.2022.11.21.20.28.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Nov 2022 20:28:17 -0800 (PST)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?a3lsZXpoYW8o6LW15p+v5a6HKQ==?= <kylezhao@tencent.com>
Cc:     Kyle Zhao via GitGitGadget <gitgitgadget@gmail.com>,
        "git@vger.kernel.org" <git@vger.kernel.org>,
        Elijah Newren <newren@gmail.com>,
        Taylor Blau <me@ttaylorr.com>,
        =?utf-8?B?w4Z2YXIg?= =?utf-8?B?QXJuZmrDtnLDsA==?= Bjarmason 
        <avarab@gmail.com>
Subject: Re: [Internet]Re: [PATCH v7 1/2] merge-tree.c: add
 --merge-base=<commit> option
References: <pull.1397.v6.git.1667472621.gitgitgadget@gmail.com>
        <pull.1397.v7.git.1668210314.gitgitgadget@gmail.com>
        <1cf1c69b8e8e8e81eccc42b5d8efc605a36ab7eb.1668210314.git.gitgitgadget@gmail.com>
        <xmqqsfibsn9o.fsf@gitster.g>
        <3e5cdd224d76499bbddf55b0b649439b@tencent.com>
Date:   Tue, 22 Nov 2022 13:28:16 +0900
In-Reply-To: <3e5cdd224d76499bbddf55b0b649439b@tencent.com> (=?utf-8?Q?=22?=
 =?utf-8?Q?kylezhao=28=E8=B5=B5=E6=9F=AF=09=E5=AE=87=29=22's?= message of
 "Tue, 22 Nov 2022 03:52:21 +0000")
Message-ID: <xmqqcz9fsjdr.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"kylezhao(赵柯宇)" <kylezhao@tencent.com> writes:

> I went to check the api-parse-option.txt, but I didn't found an
> elegant solution to stop when the users uses the second
> "--merge-base".

That's not even a fix, as it does not allow specifying more than one
merge bases, is it?

Just like how builtin/merge-tree.c::real_merge() is prepared to
handle parent1 and parent2 that have multiple merge bases and pass
all of them to the underlying merge machinery, you can accumulate
multiple strings using OPT_STRING_LIST() and use all of them as
merge_bases, no?
