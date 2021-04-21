Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42162C433ED
	for <git@archiver.kernel.org>; Wed, 21 Apr 2021 06:11:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1D43461426
	for <git@archiver.kernel.org>; Wed, 21 Apr 2021 06:11:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235061AbhDUGMJ (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 21 Apr 2021 02:12:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60080 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231821AbhDUGMH (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 21 Apr 2021 02:12:07 -0400
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 255EEC06174A
        for <git@vger.kernel.org>; Tue, 20 Apr 2021 23:11:34 -0700 (PDT)
Received: by mail-ed1-x52e.google.com with SMTP id h10so47854590edt.13
        for <git@vger.kernel.org>; Tue, 20 Apr 2021 23:11:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version;
        bh=6yKFzz14kKuZBLsLspe/N6fS60v2ASGN8KfdHwg6DvM=;
        b=Bvfb3G6IiVBhIKppM21Cs/sAt8eefxfYUL4Y8GO1eXGfom9TCPjPRukkDtWegu6rvR
         W+RPTjH6mTjiVDsIc80d2xnlaU03UaPQnbT4fVjAOg6+kX+CHlpVvDJKbSnbZBBl45AF
         xOtSDFN2b/v16utKfqEbWfg6V3OCVbMj+Cn4kGq9yuObeoX9sPR9wvNQj1JoqjOYOSSU
         Lqj6p4HFm6TyemyWWpwQxFS5BI1tdEoPb73kWOMDdIIaZpwivHtw4QOwftBA9zeWYYzH
         r8OV8rXlZhxsQyZZYeween+Ddlzm6fqeGs8ihk6hhwjuIMKp8qXZxWTMEtqze4fxqORG
         b5Hg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version;
        bh=6yKFzz14kKuZBLsLspe/N6fS60v2ASGN8KfdHwg6DvM=;
        b=QwNk61caOtSHeQGrYX0WU2eG4htWuflg2DB9x+Y2PStsh41LiZ7UUZ5zekGC5h6X8T
         VohPyiEdZHr6pXO4LiLOmDRCw6my7LZ6sFXN66rrrbLmcpeqb2sVtjV4R3jVvu7LE83I
         HYkk8wpBCbw4OZrPEkT9lEoWAFzLW/q7TYdN0SEjp94oiv6IYI3rSKBwOabx8aw9mlPI
         IYhceGlfTQeRMso0BadJnR3zmp2eDNKwjO6RpfrbuaDVKwTZyxdQ1xBcrFjYZ1/ff0RJ
         dZfKDhYdkwftlsdvxBm65VwaIq5Tb8x8wLOBaLXa2h5Du5kApLtCfubRp5RyinnaBbgL
         Ykfw==
X-Gm-Message-State: AOAM532kuX2H+yYChn15e8DKcM6gNhafYNt3X/Pc4McX6l7s60hahMgQ
        /EbezVygNitlYAzZu2r7QWdNrlace6t49w==
X-Google-Smtp-Source: ABdhPJy0EuUVS6ktYPwd9V182k38N9VtQsissLt2owqGY5ZJtYrOxeVoqhDAWiNfE39TfxZg6k24QQ==
X-Received: by 2002:a05:6402:204e:: with SMTP id bc14mr36876557edb.312.1618985492650;
        Tue, 20 Apr 2021 23:11:32 -0700 (PDT)
Received: from evledraar (j57224.upc-j.chello.nl. [24.132.57.224])
        by smtp.gmail.com with ESMTPSA id jl8sm1223264ejc.122.2021.04.20.23.11.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Apr 2021 23:11:32 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Han-Wen Nienhuys via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Han-Wen Nienhuys <hanwenn@gmail.com>,
        Han-Wen Nienhuys <hanwen@google.com>
Subject: Re: [PATCH 07/18] t5000: inspect HEAD using git-rev-parse
References: <pull.1008.git.git.1618829583.gitgitgadget@gmail.com>
 <79843c0d572765a3004968235391b5ae17365d56.1618829583.git.gitgitgadget@gmail.com>
User-agent: Debian GNU/Linux bullseye/sid; Emacs 27.1; mu4e 1.4.15
In-reply-to: <79843c0d572765a3004968235391b5ae17365d56.1618829583.git.gitgitgadget@gmail.com>
Date:   Wed, 21 Apr 2021 08:11:31 +0200
Message-ID: <87y2dc4164.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Mon, Apr 19 2021, Han-Wen Nienhuys via GitGitGadget wrote:

> From: Han-Wen Nienhuys <hanwen@google.com>
>
> Signed-off-by: Han-Wen Nienhuys <hanwen@google.com>
> ---
>  t/t5000-tar-tree.sh | 7 ++++---
>  1 file changed, 4 insertions(+), 3 deletions(-)
>
> diff --git a/t/t5000-tar-tree.sh b/t/t5000-tar-tree.sh
> index 7204799a0b52..472fec4ee64a 100755
> --- a/t/t5000-tar-tree.sh
> +++ b/t/t5000-tar-tree.sh
> @@ -233,9 +233,10 @@ test_expect_success \
>       test_cmp expected.mtime b.mtime'
>  
>  test_expect_success \
> -    'git get-tar-commit-id' \
> -    'git get-tar-commit-id <b.tar >b.commitid &&
> -     test_cmp .git/$(git symbolic-ref HEAD) b.commitid'
> +	'git get-tar-commit-id' \
> +	'git get-tar-commit-id <b.tar >actual &&
> +	git rev-parse HEAD > expect &&
> +	test_cmp expect actual'

If we're doing a "re-style while we're at it" s/<spaces>/<tabs>/ let's
just go all the way and convert it to a more modern style of:

test_expect_success 'git get-tar-commit-id' '
	...
'

But maybe such re-styling would be best left alone, and just a narrow
change of the needed code. There's various surrounding tests in the file
that use the same style, unless we're going to re-style all of them....
