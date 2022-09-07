Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E50E0C38145
	for <git@archiver.kernel.org>; Wed,  7 Sep 2022 19:31:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229686AbiIGTbe (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 7 Sep 2022 15:31:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50294 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229569AbiIGTbc (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 7 Sep 2022 15:31:32 -0400
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7BAEFBD2A1
        for <git@vger.kernel.org>; Wed,  7 Sep 2022 12:31:31 -0700 (PDT)
Received: by mail-pj1-x1035.google.com with SMTP id fv3so9402310pjb.0
        for <git@vger.kernel.org>; Wed, 07 Sep 2022 12:31:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:from:to:cc:subject:date;
        bh=Rvx0J42ItWLpykR8fnITC52FQQs2Hsp+9mN5xs952y8=;
        b=FlzX8sWr7UPmgTIKk/GP8vECoxobRaB7avM0+GCIDGjAHHcwMNPwf0UpxsR8w9hfC7
         zZIumHhjFsy9+SpTmsLv9b/yDBstMmpv/MM5/1NEP14D2F5ygbA+rIxTT+HKwjhjRv2p
         zvHbomBTa9r7NbxZCDqW5GAb8oRX/zMoRBO7pyNWaTP/jUtWVg32E0hjsDK3fuaomFkG
         ESwl0MC2WeeWm7IxUCQ6W19VccKy4hQUL7+AVFgjr96excKRqKINQczbztCNguabCJtQ
         O3+DkqcN/Xanudr5k9vmGd4IlDvI7WD312sug8GpM9ERoAhLHu1QVMXvhJ4XNAppZB73
         EL+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:x-gm-message-state:from:to:cc:subject
         :date;
        bh=Rvx0J42ItWLpykR8fnITC52FQQs2Hsp+9mN5xs952y8=;
        b=OoC2JN4BaLzlrzr8ELM2d30eOr9eu08Fi30l73vWt8sYUVFNtG4da1FdpnWbuFUCLG
         8eoUtJDO9jrxzr0vYXJ1jW7iHFEPD/DKHEEeY0TD/a/aUEEWXutfkq0cNvzwhAdRMWFp
         QQOu0TEjcF9oHUzmPpPIMJJVh86wcY4OL2LZg4ypAhvNF8FGjRqh3B2pP0x+tFsWUMRg
         EPeRaSG57nlRVpfTANKohke7zIJvMkYSHtnxbIdGzWHNnQgrIAlbAqjhys9NeLWw8Qre
         gjmbKnvS1u6PlnNqzJP2zIsHhk7Q8adjTQ6IWgPZQgVfGR4WgO5Nl36+4R3vjVSx6QLR
         c4WA==
X-Gm-Message-State: ACgBeo1FOUv1uBr8f7osIHD4DOFOIUXXiRtqsrfucokfKvTcf2ofYIMk
        BG7je8khH9qoW33ZU44oidE=
X-Google-Smtp-Source: AA6agR5baHc3Bm25TmBqVr64+gQ1GjZ3wYFpnFwPwLW8pyCoK2Bja9NpK0FW6ZYA0amUPzpi74+KrQ==
X-Received: by 2002:a17:902:e742:b0:176:dc6b:eecc with SMTP id p2-20020a170902e74200b00176dc6beeccmr5431093plf.104.1662579090955;
        Wed, 07 Sep 2022 12:31:30 -0700 (PDT)
Received: from localhost (33.5.83.34.bc.googleusercontent.com. [34.83.5.33])
        by smtp.gmail.com with ESMTPSA id v126-20020a626184000000b00528c066678csm13039945pfb.72.2022.09.07.12.31.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Sep 2022 12:31:30 -0700 (PDT)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     =?utf-8?B?56iL5rSL?= <chengyang@xiaomi.com>,
        Derrick Stolee <derrickstolee@github.com>,
        "git@vger.kernel.org" <git@vger.kernel.org>,
        =?utf-8?B?5L2V5rWp?= <hehao@xiaomi.com>,
        Xin7 Ma =?utf-8?B?6ams6ZGr?= <maxin7@xiaomi.com>,
        =?utf-8?B?55+z5aWJ?= =?utf-8?B?5YW1?= <shifengbing@xiaomi.com>,
        =?utf-8?B?5Yeh5Yab6L6J?= <fanjunhui@xiaomi.com>,
        =?utf-8?B?546L5rGJ5Z+6?= <wanghanji@xiaomi.com>
Subject: Re: [PATCH 3/3] parse_object(): check commit-graph when skip_hash set
References: <YxfQi4qg8uJHs7Gp@coredump.intra.peff.net>
        <YxfScUATMQw9cB6m@coredump.intra.peff.net>
Date:   Wed, 07 Sep 2022 12:31:30 -0700
In-Reply-To: <YxfScUATMQw9cB6m@coredump.intra.peff.net> (Jeff King's message
        of "Tue, 6 Sep 2022 19:06:25 -0400")
Message-ID: <xmqqv8pzt20d.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> If the caller told us that they don't care about us checking the object
> hash, then we're free to implement any optimizations that get us the
> parsed value more quickly. An obvious one is to check the commit graph
> before loading an object from disk. And in fact, both of the callers who
> pass in this flag are already doing so before they call parse_object()!
>
> So we can simplify those callers, as well as any possible future ones,
> by moving the logic into parse_object().

Nicely done.
