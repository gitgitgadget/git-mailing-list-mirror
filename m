Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B54D8C74A5B
	for <git@archiver.kernel.org>; Tue, 21 Mar 2023 17:43:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230107AbjCURnh (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 21 Mar 2023 13:43:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33556 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229913AbjCURng (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 21 Mar 2023 13:43:36 -0400
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C005C26C0D
        for <git@vger.kernel.org>; Tue, 21 Mar 2023 10:43:13 -0700 (PDT)
Received: by mail-pj1-x1030.google.com with SMTP id j3-20020a17090adc8300b0023d09aea4a6so21084270pjv.5
        for <git@vger.kernel.org>; Tue, 21 Mar 2023 10:43:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679420593;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=31Lwem97SPJQ8wCKBTo0CWXD61bAqdkrHY9fWMxvvTg=;
        b=cJcSQBBFfiyhu8UyNxE0Bksk+XM13QfzoMq9qXmqyG4+xVNr5ygRNg8bMZWZa6+656
         XQTswcHTlZD1gmrmwWBvhno4MgXGpmntPv+rHfeG2DaqH/vXFXPWna2nxYDVTlttVZms
         HQViIxwErEUkAbR9mfoHkatBpooQQzUo8W8pgPtTD/J6EriGZls0+byYxhKjmo4DBe+Q
         sji8F7yN9dixbhaG66jjFj5NPzkdL4nWnfgSf49JfohJ3PWwdcodxXOrJJORscXctlFG
         4XJmaMxR0LYRnkZrTeAgre9BKLxtLlO4AUN8BBxSkP+/w5lfdAyfYt0vtU4dKH5/FJEp
         Sl5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679420593;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=31Lwem97SPJQ8wCKBTo0CWXD61bAqdkrHY9fWMxvvTg=;
        b=XW73xW3HIllX+jfcfapg7b0K8EULS9pHrM7aNdOvj0HDxN1+qETe5AaSVHwwHayove
         s+C5FXfDgPQIT99Ri/tfvm4fnifvppUW2FclE5AGwbK6lAdTsRI7sLU/gSlOklEU6XxG
         qO66Gw1UKlZ4xKyMkfaC8LUAt4dXhFl3yvpRaQmlhJzGBf7P4a+Qm7O2b6mtLiX1ojCr
         9fAdCF0dBB+pq63vPvdSbajMPnIKtKkd6Q2obc2MdWZvi/axcnEW+2D7a/AVCD6+ioWt
         PaccWhe9AN+p4eonyyqqSBKqMilvbzX1y5uaWYkTcIaQ6TCoFCzMSJSemXm9cRvuZr8o
         wz5w==
X-Gm-Message-State: AO0yUKVHhTFLTvJ8kgNUc5N4/Cbd3XpZ7JYSANruB0IJ7yfKIeTzGfWN
        nkdf9+I7VlXj6XqF629dbOw=
X-Google-Smtp-Source: AK7set8zpSsPel3yHU12xc8BRpsAZwCYql2r/VRXjsoYw8vJux+3JVsuJTF6pVMffHaxfh52uGF3cA==
X-Received: by 2002:a17:90b:1a8a:b0:23e:aba9:d51d with SMTP id ng10-20020a17090b1a8a00b0023eaba9d51dmr598418pjb.7.1679420593107;
        Tue, 21 Mar 2023 10:43:13 -0700 (PDT)
Received: from localhost (83.92.168.34.bc.googleusercontent.com. [34.168.92.83])
        by smtp.gmail.com with ESMTPSA id d8-20020a17090a6a4800b0023f5c867f82sm7950001pjm.41.2023.03.21.10.43.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Mar 2023 10:43:12 -0700 (PDT)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     Stanislav Malishevskiy via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org,
        Stanislav Malishevskiy <stanislav.malishevskiy@gmail.com>,
        Stanislav Malishevskiy <s.malishevskiy@auriga.com>
Subject: Re: [PATCH v2] http: add support for different sslcert and sslkey
 types.
References: <pull.1474.git.git.1679233875803.gitgitgadget@gmail.com>
        <pull.1474.v2.git.git.1679327330032.gitgitgadget@gmail.com>
        <xmqqlejrmj4y.fsf@gitster.g>
        <20230321172223.GA3119834@coredump.intra.peff.net>
Date:   Tue, 21 Mar 2023 10:43:12 -0700
In-Reply-To: <20230321172223.GA3119834@coredump.intra.peff.net> (Jeff King's
        message of "Tue, 21 Mar 2023 13:22:23 -0400")
Message-ID: <xmqqjzzahufj.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

>   2. Add a specific "test with https" script that covers some basic
>      tests (possibly even just including t5551, in the same way t5559
>      does). If the platform apache doesn't support ssl, then it should
>      fail gracefully. And then we could add more SSL specific tests
>      to that script.

Both choices sound sensible.  This second one may be simpler to
arrange.

Thanks.
