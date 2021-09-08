Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10A80C433FE
	for <git@archiver.kernel.org>; Wed,  8 Sep 2021 10:44:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E6B2C61108
	for <git@archiver.kernel.org>; Wed,  8 Sep 2021 10:44:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245337AbhIHKpx (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 8 Sep 2021 06:45:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36464 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231440AbhIHKpw (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 8 Sep 2021 06:45:52 -0400
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D058CC061575
        for <git@vger.kernel.org>; Wed,  8 Sep 2021 03:44:44 -0700 (PDT)
Received: by mail-ed1-x52c.google.com with SMTP id s25so2315824edw.0
        for <git@vger.kernel.org>; Wed, 08 Sep 2021 03:44:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version;
        bh=YOE/6IpkxPygusQAWR4QbWwtDK0KaTdxn9dbOPe4GVQ=;
        b=gFljuCsvAcXpdRt6/FDiQ4Pu7yOj1XcqrNmVVpPhB8Z7r6P2n1dP9cjivHUBj+vCJ/
         obC9viY8zpOmiyR3R/kU3z9x9K8YqkU/9o9ph36d3x3JsN6raaVnM9npANmB3kDi738u
         Pcj3dUu4sRFQmRs1UjR5Xp1q0wkSzw3k5+FxSGSi7oLA4ceGyxbDHshK/cTV+WSCwuFn
         ofOcput0TnkG+MfhlR6iMibMGUXiLD+tAFdXrQUE+8Gzpz9+dbAHwI55qmFAcmNH+tnW
         Na/yw3prk9QUTH1raDsXvRyrI7JJ92UnSurA1uh3kPHZFOnjKR80P7z29hwUzOjCQMqo
         1lRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version;
        bh=YOE/6IpkxPygusQAWR4QbWwtDK0KaTdxn9dbOPe4GVQ=;
        b=txsbs9t9x2Y2SWEp0p8pl3d8dGjPRs8sfTcYLsOhKNGD/qKxzGxq3P/O9/g9GGIEAg
         3qlHuyW47QK2o+ELUNhU0CrA7pZ3934NZrGkaAOmaAi1CZgyWLbzzUd06sqXgMJb19Yj
         Uk3dqN0Fwd2irJONTUuoD3XB4QKX24BQKxn13qO8a/zs76hzcc9ddvzccKS6CVSaoega
         pc3aNDUPEow0Ng/jf1U7MFa4AgcLIe8OAD9RPvOT6e6eE6yt89StPwUALBdMUV6M2a4w
         GO8EwIlKeA90leRlaNbtSiPhK7nPyU9dxoLf+QFCoV/rhhXM1uJF5y1QRHyENVaXI5/a
         XrOQ==
X-Gm-Message-State: AOAM5325Zk5nIxrxMceAqjmhk6dUivuwTB2pRCBXdQd22J2epdowsuyM
        mVytJYYt8zhZCmKbCLpKE5ieO24zuxmY/g==
X-Google-Smtp-Source: ABdhPJx0UL7+IJij2cHf+Ga2un+dRQxdFvSIpbotokhlOhmrqFQLxxB6czmYwsyAP3p794+35Y7cmw==
X-Received: by 2002:aa7:c6c8:: with SMTP id b8mr3122988eds.295.1631097883274;
        Wed, 08 Sep 2021 03:44:43 -0700 (PDT)
Received: from evledraar (j120189.upc-j.chello.nl. [24.132.120.189])
        by smtp.gmail.com with ESMTPSA id t20sm795871ejc.105.2021.09.08.03.44.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Sep 2021 03:44:42 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Phillip Wood via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Phillip Wood <phillip.wood@dunelm.org.uk>
Subject: Re: [PATCH 06/11] t3407: strengthen rebase --abort tests
Date:   Wed, 08 Sep 2021 12:42:04 +0200
References: <pull.1033.git.1631094563.gitgitgadget@gmail.com>
 <87d7e9bf2d4537ddbdec8c8fa67190e81a426312.1631094563.git.gitgitgadget@gmail.com>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.7.0
In-reply-to: <87d7e9bf2d4537ddbdec8c8fa67190e81a426312.1631094563.git.gitgitgadget@gmail.com>
Message-ID: <87a6knibxh.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Wed, Sep 08 2021, Phillip Wood via GitGitGadget wrote:

> The existing tests only check that HEAD points to the correct
> commit after aborting, they do not check that the original branch
> is checked out.
> [...]
> +# Check that HEAD is equal to "pre-rebase" and the current branch is
> +# "to-rebase"
> +check_head() {
> +	test_cmp_rev HEAD pre-rebase &&
> +	test "$(git symbolic-ref HEAD)" = refs/heads/to-rebase
> +}

I reflexively thought "use test_cmp here!", but in this case that's
pointless as any difference is noted by test_cmp_rev, we're really
seeing what HEAD is checked out to here. I see we use the same pattern
in various other tests...
