Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39517C433FE
	for <git@archiver.kernel.org>; Sun, 19 Sep 2021 01:04:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0F6DE610E9
	for <git@archiver.kernel.org>; Sun, 19 Sep 2021 01:04:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235547AbhISBEX (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 18 Sep 2021 21:04:23 -0400
Received: from mail-ed1-f52.google.com ([209.85.208.52]:36526 "EHLO
        mail-ed1-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231209AbhISBEN (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 18 Sep 2021 21:04:13 -0400
Received: by mail-ed1-f52.google.com with SMTP id v24so45390940eda.3
        for <git@vger.kernel.org>; Sat, 18 Sep 2021 18:02:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=CsUZZNClN8HAS8NUuZ2XEqHpJJ9DDp/iPWpxfmsfsZg=;
        b=S5L1xo02IQveybjipX+z52Y9Ao438fCMq8Dxe7ZWJQ1Ao7tyRGTrW0iHkOE/PW0XHY
         T04SVQOVFSC3LJkoo7Rg1tssvyD7PLhgzrYYa2GbwT3aoIX9gUEd5cKSFf3KSZgHVCIl
         6sSYObbYa1aIFKqFYfdy6XMXcVQ/odXtPKTiZImm/FliF4RHsJSLUxGpTYPdQPT6a8wN
         mYg9ekfsXFuBn9mHyabAHgcpA46QSgpMme2vJC4Isux1EHWrqothm1HOd9iW8O0CfyMc
         vBcLVFV8xIy+Q9pF0efxmdRQ8YXOQ2q0x74XHhX6+Ri0/CWP10+aEQaXzXH+ADjDEWqG
         WfyA==
X-Gm-Message-State: AOAM533zS4Bom4hIrWooSjoB8CyU97M4qcWWFZgJbnUVpdvalE7FUZwJ
        gRi921rht+efRe19txDpUFAyTrfAQM0sIvCvR5dHkhIIxPY=
X-Google-Smtp-Source: ABdhPJxyDDEMEeH0auRzgDo41OVIxkyW7UjIiDdTFzlHv7Xh0PqqFJbmXNXTqz7ZeAKkrqnWNNSXLS/cC3XtiG/PXLk=
X-Received: by 2002:aa7:df92:: with SMTP id b18mr20693278edy.47.1632013367908;
 Sat, 18 Sep 2021 18:02:47 -0700 (PDT)
MIME-Version: 1.0
References: <pull.1091.git.git.1631970872884.gitgitgadget@gmail.com>
 <YUYLXKN8U9AMa5ke@nand.local> <YUZinXsGdL19l/tQ@coredump.intra.peff.net>
In-Reply-To: <YUZinXsGdL19l/tQ@coredump.intra.peff.net>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Sat, 18 Sep 2021 21:02:37 -0400
Message-ID: <CAPig+cSSxgVU47wCNpcW2HTwCA60e1oZ6Yzkb5i-W2HDijq+MQ@mail.gmail.com>
Subject: Re: [PATCH] connect: also update offset for features without values
To:     Jeff King <peff@peff.net>
Cc:     Taylor Blau <me@ttaylorr.com>,
        Andrzej Hunt via GitGitGadget <gitgitgadget@gmail.com>,
        Git List <git@vger.kernel.org>,
        "brian m . carlson" <sandals@crustytoothpaste.net>,
        Andrzej Hunt <andrzej@ahunt.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Sep 18, 2021 at 6:05 PM Jeff King <peff@peff.net> wrote:
> Swapping out the "printf >expect" for a here-doc might make it a bit
> more readable. I used printf because of the tab handling, but:
>
>   tab=$(printf "\t")
>   cat >expect <<-EOF
>   ref: ${dst}${tab}HEAD
>   ${oid}${tab}HEAD
>   EOF
>
> isn't too bad.

Or just use q_to_tab():

    q_to_tab >expect <<-EOF
    ref: ${dst}QHEAD
    ${oid}QHEAD
    EOF

However, the typical use-case for q_to_tab() is when we need a leading
or trailing TAB character. When TAB is embedded within the line, we
often just use a literal TAB character; indeed, many tests in the
suite do exactly that, so that would be an even simpler option.
