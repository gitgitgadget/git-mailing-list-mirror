Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD948C77B7C
	for <git@archiver.kernel.org>; Fri, 12 May 2023 23:24:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239957AbjELXYm (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 12 May 2023 19:24:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39018 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238380AbjELXYi (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 12 May 2023 19:24:38 -0400
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 92E991FEA
        for <git@vger.kernel.org>; Fri, 12 May 2023 16:24:37 -0700 (PDT)
Received: by mail-pj1-x1035.google.com with SMTP id 98e67ed59e1d1-24e09b4153eso7344225a91.2
        for <git@vger.kernel.org>; Fri, 12 May 2023 16:24:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1683933877; x=1686525877;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=KmAQ4Ee+JSrp5JQg7PLSOCoXXJO9x+ADz/zoRylUMOQ=;
        b=WiAYl6jlLD6sMqmLUodpSUPGMjZtp2/dwaDl0zWjJ/SjXlMJmZmz0dGIlhhltfgMUz
         ymApQZJcsKsgN3VynBEjnSDqjGYi5Db6JRP7wQf5m7NMdN3+d6rrelzgWXO7UVNeX9Jf
         dws/f/zLeO/N9yN07qKtRqcfjaA+FW1pJEYSHmnI7VyQ9Ufum+Zp6abXSX3Wg82MlQGz
         I95dT0P+Y0oV6KMm/XA6I9jL1PcJEIFdKpba9HDBqiqxPK0uJP8PC9TlYWXFgTXMpu81
         +j+RE/AnzhwuEnHEmrW63T0CEpUYkLV20adbRRTMuZPjT4YnAxYbTvlQDfpgvkO2dFOg
         UyIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683933877; x=1686525877;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=KmAQ4Ee+JSrp5JQg7PLSOCoXXJO9x+ADz/zoRylUMOQ=;
        b=SG95ccetNgb3Svi6/Rx1EjzhmPkEwpwraW0LhrSMIY+2on96cVxdQzh7mzv3wTlSK3
         ocFoIaHDXhTnohrSlB1qFuo2ABD07K8gMFpxBd9cqh2Rvwp+SljvL3caHaXxMYkvreSz
         UZ0uPc8S/PlyDJQubCl1rU8qVLU4W/PwQ9o4TQ8fgK5UBgNPooCfmwurTFw06leXHk0a
         okyKDOmO+ltl0JbJskNYfxpN3LPy8csYADMyHImfRdcKH5ydgngqu/R24ErWcnfqC0vw
         nsmYnFJtgJYUlwv717P/+jSiCsyczknSyAfxLe5xRsi2QgX/a1vObMK/5pJgwhu3bfmt
         nJoA==
X-Gm-Message-State: AC+VfDxcMki+XJ6zH9eVmTnGgcFb7pJaxN27XNPiDmi6PjgC5PoUHyDl
        P+8O3vNToOv/fbO9rR857zo=
X-Google-Smtp-Source: ACHHUZ5LNdcXrm2Sd6oFdEXxN8JccqUdjj3m5sZQf57p65ViwD+ZSig9oyiylK8hCNX1M66LoZztqg==
X-Received: by 2002:a17:90b:2305:b0:247:6022:9595 with SMTP id mt5-20020a17090b230500b0024760229595mr26605402pjb.45.1683933876927;
        Fri, 12 May 2023 16:24:36 -0700 (PDT)
Received: from localhost (187.137.203.35.bc.googleusercontent.com. [35.203.137.187])
        by smtp.gmail.com with ESMTPSA id fs9-20020a17090af28900b002470f179b92sm17515915pjb.43.2023.05.12.16.24.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 May 2023 16:24:36 -0700 (PDT)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     "Linus Arver via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Christian Couder <christian.couder@gmail.com>,
        Linus Arver <linusa@google.com>
Subject: Re: [PATCH v2 0/9] docs: interpret-trailers: reword and add examples
References: <pull.1506.git.git.1683566870.gitgitgadget@gmail.com>
        <pull.1506.v2.git.git.1683839975.gitgitgadget@gmail.com>
Date:   Fri, 12 May 2023 16:24:36 -0700
In-Reply-To: <pull.1506.v2.git.git.1683839975.gitgitgadget@gmail.com> (Linus
        Arver via GitGitGadget's message of "Thu, 11 May 2023 21:19:26 +0000")
Message-ID: <xmqqv8gxm8uj.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Linus Arver via GitGitGadget" <gitgitgadget@gmail.com> writes:

> This series makes some small improvements to the docs for
> git-interpret-trailers. The intent is to make it easier to read for
> beginners who have never used this command before.
>
>
> Changes from v1
> ===============
>
> In order of significance:
>
>  * The phrase "commit message part" has been removed.
>  * The word "message" is always used as part of the bigger phrase "commit
>    message".
>  * Deprecation language for trailer.<token>.command has been updated to
>    minimize whitespace churn, while also tweaking the 2nd paragraph to
>    reduce duplication.
>  * The phrase "Lorem ipsum..." is always only used to stand in for the body
>    paragraph(s) of a commit message.
>  * Grammar fixes have been squashed together (01+06 previously).

Looking very good.

Unfortunately some of the updates to examples overlap moderately
with what the kh/doc-interpret-trailers-updates topic wanted to do.
I think I resolved them correctly, but please double check what
appears in 'seen'.

As the other topic is slated to graduate in a day or two (topics
usually cook for a week in 'next' before merged to 'master'), it
may be a good idea to wait for more review comments and then rebase
these patches on top of 'master' when that happens.

Thanks.
