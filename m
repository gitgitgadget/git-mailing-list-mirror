Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 170A2C77B75
	for <git@archiver.kernel.org>; Fri, 19 May 2023 17:09:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229681AbjESRI4 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 19 May 2023 13:08:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51040 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231615AbjESRIo (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 19 May 2023 13:08:44 -0400
Received: from mail-pf1-x42d.google.com (mail-pf1-x42d.google.com [IPv6:2607:f8b0:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4410F10F0
        for <git@vger.kernel.org>; Fri, 19 May 2023 10:08:10 -0700 (PDT)
Received: by mail-pf1-x42d.google.com with SMTP id d2e1a72fcca58-64d2b42a8f9so1226750b3a.3
        for <git@vger.kernel.org>; Fri, 19 May 2023 10:08:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1684516058; x=1687108058;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=DOVU+xKzHa5AXYExh8BvN1jegmNDXfMMQrM00yMU7Ho=;
        b=Clvo6repIt8UAdcvqAYRNT9UTMwAQYdP1XC5882Tces05o1qG/gpPzbRAt4t7SRqAq
         7PsEvekqtLJdueSbh6LDFaxTMxmKWxAGGscENog/EryI1NTv0pGQjll66ZsuMtbcxJ0J
         qIQypeOt00IjkY0Jm+VVMR9rz5/hOPLgIFfBfjeWRfwQkZkSV9PsRcnpZkjvZXMuUkeh
         OVazgM57zq4boa6aJ7wbedXxnjF5A7lDqaf4A3DImiIOcvOQ5jld7TN9HoARHjd4/wdH
         CM6hTW6LULijoNmtZQGJyEW2/nUR/u3XUxKANZ7k9bna+jSAGj6ajYNPuTK1qJ6Ty5P6
         m91A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684516058; x=1687108058;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=DOVU+xKzHa5AXYExh8BvN1jegmNDXfMMQrM00yMU7Ho=;
        b=HVXRH7JwjC+dgVc6ItNx7lx7J07Vk5lPkJM2wNwmyN2fUw6mTD8yxrerbr841WpRJz
         smY8ZGMZsHiKQuE8Rn/+TAmGLpuiNaLUocTZHF8GetnTAQagkaEx1F5o+4Wj8GMLZ1Yd
         /FOt2MGTTKWGdE9RrGI60NuJzs8uFSd9TU7AA/CfzBADj/Iesl2R96TYxV3vjt3PdNZI
         tjklU79PUaZiXDDdJ6EqWtHeestJUQRGedP8FHaKxKAeO8Yye+vcoL84OarmIA57QFd9
         Yz+lohpstEPlLahS+FF4B+gG6afMZiMixwnydGwXqKan3MOimQ5aN+WW56at3abpqHB5
         9/SA==
X-Gm-Message-State: AC+VfDxJxCMY6cb6y/hgbU6sLsBhc4CrocXjW5WiHpJ1jWe2LvhL/HpS
        uIkxUhugxmwNOzskO7f9reg=
X-Google-Smtp-Source: ACHHUZ5IzXEv0T5fwgdxrMaH95+KqzqrDltOIRz/FL04nxRsXJVLwQmvB3dJzaB2Vfx1rasajTiEWw==
X-Received: by 2002:a05:6a00:8c1:b0:64c:ae1c:337f with SMTP id s1-20020a056a0008c100b0064cae1c337fmr3350836pfu.12.1684516058511;
        Fri, 19 May 2023 10:07:38 -0700 (PDT)
Received: from localhost (187.137.203.35.bc.googleusercontent.com. [35.203.137.187])
        by smtp.gmail.com with ESMTPSA id j26-20020aa78dda000000b0064305676b61sm3211523pfr.203.2023.05.19.10.07.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 May 2023 10:07:37 -0700 (PDT)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     "John Cai via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, John Cai <johncai86@gmail.com>
Subject: Re: [PATCH 03/20] t3210-pack-refs: modernize test format
References: <pull.1513.git.git.1684440205.gitgitgadget@gmail.com>
        <4fe5e5cf9e068d20bbec3580df3030cd74ca4122.1684440205.git.gitgitgadget@gmail.com>
Date:   Fri, 19 May 2023 10:07:37 -0700
In-Reply-To: <4fe5e5cf9e068d20bbec3580df3030cd74ca4122.1684440205.git.gitgitgadget@gmail.com>
        (John Cai via GitGitGadget's message of "Thu, 18 May 2023 20:03:08
        +0000")
Message-ID: <xmqqlehkqmg6.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"John Cai via GitGitGadget" <gitgitgadget@gmail.com> writes:

> +test_expect_success A'see if up-to-date packed refs are preserved' '

Huh?

> +	git branch q &&
> +	git pack-refs --all --prune &&
> +	git update-ref refs/heads/q refs/heads/q &&
> +	! test -f .git/refs/heads/q
> +'
