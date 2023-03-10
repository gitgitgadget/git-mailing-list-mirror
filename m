Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA343C6FA99
	for <git@archiver.kernel.org>; Fri, 10 Mar 2023 18:08:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230407AbjCJSIz (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 10 Mar 2023 13:08:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54404 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230161AbjCJSIx (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 10 Mar 2023 13:08:53 -0500
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com [IPv6:2607:f8b0:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7989F62324
        for <git@vger.kernel.org>; Fri, 10 Mar 2023 10:08:46 -0800 (PST)
Received: by mail-pl1-x636.google.com with SMTP id i10so6466942plr.9
        for <git@vger.kernel.org>; Fri, 10 Mar 2023 10:08:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678471726;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3KqtW559Qfcgg0srtfbnzjkYAlM0KV3i7PB3qqJddmk=;
        b=RpDc93k9sFxlNl301vtw5Xcd59MOSVmhtVXqP/p3yIHAyYumx3xXl4q0/zfdrCoCV4
         SRoYwQyt0J0aoXdPp3jqL7omCdl+qZY81euIUo1FiQFGOgWSsy7fP4BSF2KJuwWgd9Bm
         AFkJWFb+65qIyOgy6cYJo3QlpM/nIGaRrI9k7zwRFNDX7CSHkjzUGAKt7nIKEBh/8Rw+
         ru7bPMQkEwARtOws127s4jKBsw+BL1rIjwm/3RcFfqFd/I5Ygr3vwkgZxFE7nOUbUdJf
         yfGSlDKLIryehJRi8CHOVv/no0R/F7/nrp8nMIbzYa8bXodeSzw2A2dum73tztoT7Zeh
         CwqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678471726;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=3KqtW559Qfcgg0srtfbnzjkYAlM0KV3i7PB3qqJddmk=;
        b=kl4VlEbZ1tInaHHbMr3YikO/OH+F4WCL5xCjC5PW0niVChp5RAX0tVVs/BY0QRNI0d
         AntNhaNEKu6dDBQld6PFlxynJdOB38rcZ/LC9buOL+zfSRj0SoZnccKKsPUCz7d+61Sy
         Kt7dJkD2s+aTUN6G+flUGrhGC2mnXb3Xo6Cm5tBjNHKD5VZtTYX2QNF2UXkxyzUjPDee
         IMWdarCxCRbdtt36h5+/TWhE9KEfIwXRR4KzzA4f1Qf4HuK6VXgkcL8IA4LwIsidOagu
         XT3wOdWu1ibDFljqVpKP8oIiGpdO0Te2lVCSI9mfiLEsfUxs6hs5NqP1Ai9MRHHwNvx3
         npOg==
X-Gm-Message-State: AO0yUKV+WZomdBfrCP6Sw0x4AM7fagEMJkPi2iNgNpU2x6mngcrtU/EO
        fHMZQhb+0HtNXw+PWGThB3M=
X-Google-Smtp-Source: AK7set8i/G+5TKG+z7iIqvmAbDFxkQQOgVH4CDwi+GlF2mvYpQGoAKcUTdmjIjsNddwBlNx+K6Uplw==
X-Received: by 2002:a17:902:be13:b0:19f:1871:3dcd with SMTP id r19-20020a170902be1300b0019f18713dcdmr683970pls.5.1678471725863;
        Fri, 10 Mar 2023 10:08:45 -0800 (PST)
Received: from localhost (83.92.168.34.bc.googleusercontent.com. [34.168.92.83])
        by smtp.gmail.com with ESMTPSA id q6-20020a170902788600b0019c2cf1554csm341914pll.13.2023.03.10.10.08.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Mar 2023 10:08:45 -0800 (PST)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, me@ttaylorr.com, vdye@github.com,
        Jeff King <peff@peff.net>,
        Derrick Stolee <derrickstolee@github.com>
Subject: Re: [PATCH v2 1/8] for-each-ref: add --stdin option
References: <pull.1489.git.1678111598.gitgitgadget@gmail.com>
        <pull.1489.v2.git.1678468863.gitgitgadget@gmail.com>
        <a1d9e0f6ff6660c9264673be18bc24956f74eb9c.1678468864.git.gitgitgadget@gmail.com>
Date:   Fri, 10 Mar 2023 10:08:45 -0800
In-Reply-To: <a1d9e0f6ff6660c9264673be18bc24956f74eb9c.1678468864.git.gitgitgadget@gmail.com>
        (Derrick Stolee via GitGitGadget's message of "Fri, 10 Mar 2023
        17:20:56 +0000")
Message-ID: <xmqqsfec5viq.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com> writes:

> When reading from stdin, we populate the filter.name_patterns array
> dynamically as opposed to pointing to the 'argv' array directly. This
> requires a careful cast while freeing the individual strings,
> conditioned on the --stdin option.

Indeed.  Thanks for carefully describing the concerns you had.

Looking good.  I'll read on.
