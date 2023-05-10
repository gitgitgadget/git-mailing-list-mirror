Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA534C77B7C
	for <git@archiver.kernel.org>; Wed, 10 May 2023 23:39:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229895AbjEJXjE (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 10 May 2023 19:39:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47590 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232410AbjEJXjC (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 10 May 2023 19:39:02 -0400
Received: from mail-pg1-x530.google.com (mail-pg1-x530.google.com [IPv6:2607:f8b0:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 61AB8272C
        for <git@vger.kernel.org>; Wed, 10 May 2023 16:39:01 -0700 (PDT)
Received: by mail-pg1-x530.google.com with SMTP id 41be03b00d2f7-52c30fbccd4so7124150a12.0
        for <git@vger.kernel.org>; Wed, 10 May 2023 16:39:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1683761941; x=1686353941;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=51Jd3KMmJYPrYYsRF+Fn5pmR1WKzkwHMjfn5ksTTf3c=;
        b=BJVzkXyRafq1Tv/NZ4B16oYRqriB7B/6LZ4QSrIUXfHK/CMVfyeDOD4Y0VgOekDiz/
         AtLywgEhI1Q3kJIhV13QenEP+nUOr+amYdjoKqX86V77s+vZQomj0Uyu1r2a336HFvof
         PiZj7rsOLigbGswl7QCKF0guLA+BPicykpD3vKN/7d51v2ACdQTOf+06zR0sUmjEC/mf
         rnNLqr35jRq5qi1BHerCoG782Z2QmFfGKcfy0L810kBmV1Bmbn+lu6n79qHn5YQfHjSc
         3PNY0TEra1P1Lz5DtGbd7gRsNsx5GDYdV6vXI18nfAnbRLUD+PRMbRr7fOoFb3Sxw7l0
         6iVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683761941; x=1686353941;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=51Jd3KMmJYPrYYsRF+Fn5pmR1WKzkwHMjfn5ksTTf3c=;
        b=IEHc/KGJa0kjEzKQn1ftpsA+uYIhDtxJ21tmXrEpuvbnXmhL7i6xJG3TWke+hPSuU6
         gjiZYl1tUweCe1EJXAkPz+oUEhkNam7IpX+DvTONRoeVMIGfTNwqTiwujg995RK5HT6A
         CBNdBZYxwMe1+OjknFPSLvBF09bRT+M7DW0PRwJEWCrMq41jrhpYyps2qwVCTqpEzJq9
         rTgaCwkPoqISAbP7fRIBE00IZKeXeZAwUaw4pTDPXpCdVhm7Ixf1YMbdyZoXo1DYs/4f
         UQtzedI9VjF5CLp26/8JQy28nRUZEcD+dEmDo3rzjpiRDxU3R84NvxeRarhnh2gIiWkx
         mUww==
X-Gm-Message-State: AC+VfDwg7T3JAVsdLrFF8GlVMXbTk9/URo9vvOLOK7oLGnpPd6HHWy6Z
        kZw5veVslX2jMDqdXIkycNa7wGjQhXg=
X-Google-Smtp-Source: ACHHUZ6ar3BGVtuawxuopB2rjp0+w4JmwJMbM946m4SzRW502B9LAxBFO/NoV3d0L8UboXWx+UYCcQ==
X-Received: by 2002:a17:90a:390f:b0:252:79f3:dece with SMTP id y15-20020a17090a390f00b0025279f3decemr1878472pjb.41.1683761940780;
        Wed, 10 May 2023 16:39:00 -0700 (PDT)
Received: from localhost (187.137.203.35.bc.googleusercontent.com. [35.203.137.187])
        by smtp.gmail.com with ESMTPSA id b17-20020a170903229100b001ab39cd885esm4348446plh.212.2023.05.10.16.39.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 May 2023 16:39:00 -0700 (PDT)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Derrick Stolee <derrickstolee@github.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH 2/2] rebase -r: fix the total number shown in the progress
References: <pull.1531.git.1683759338.gitgitgadget@gmail.com>
        <d12d5469f8cbc21ce1efbffc8e7569c534b5a305.1683759339.git.gitgitgadget@gmail.com>
Date:   Wed, 10 May 2023 16:39:00 -0700
In-Reply-To: <d12d5469f8cbc21ce1efbffc8e7569c534b5a305.1683759339.git.gitgitgadget@gmail.com>
        (Johannes Schindelin via GitGitGadget's message of "Wed, 10 May 2023
        22:55:38 +0000")
Message-ID: <xmqq8rdv21uz.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
writes:

> diff --git a/t/t3430-rebase-merges.sh b/t/t3430-rebase-merges.sh
> index f351701fec2..8da99a075dc 100755
> --- a/t/t3430-rebase-merges.sh
> +++ b/t/t3430-rebase-merges.sh
> @@ -517,4 +517,11 @@ test_expect_success '--rebase-merges with message matched with onto label' '
>  	EOF
>  '
>  
> +test_expect_success 'progress shows the correct total' '
> +	git checkout -b progress H &&
> +	git rebase --rebase-merges --force-rebase --verbose A 2> err &&
> +	grep "^Rebasing.*14.$" err >progress &&
> +	test_line_count = 14 progress
> +'

This is trying to find output lines that say "Rebasing (NN/14)";
Clarifying that we mean the denominator by matching

    "^Rebasing.*/14)$"

or even

    "^Rebasing ([0-9]*/14)$"

would have made it easier to grok (even though I know we do not have
114 steps to rebase in this one ;-).

Looks good.  Will queue.  Thanks.
