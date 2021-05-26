Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BFBADC2B9F7
	for <git@archiver.kernel.org>; Wed, 26 May 2021 11:55:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A35D5611C2
	for <git@archiver.kernel.org>; Wed, 26 May 2021 11:55:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234467AbhEZL5C (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 26 May 2021 07:57:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53948 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232454AbhEZL4W (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 26 May 2021 07:56:22 -0400
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 55D5CC06138F
        for <git@vger.kernel.org>; Wed, 26 May 2021 04:53:40 -0700 (PDT)
Received: by mail-ej1-x62a.google.com with SMTP id ss26so1732531ejb.5
        for <git@vger.kernel.org>; Wed, 26 May 2021 04:53:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version;
        bh=wwxaugC7WSamcZaKpTPbAtc5muGmMcfBonifKTgqeK8=;
        b=eXmTfTd/PewmZGCqQZiJHheLXPZYLPuXiL1GH09UZJQPfhPfgVcNRa6QqhJCCy8evJ
         A7BGjDh4Jid+1ww+UYVGKD/fRszd6bFizsYYpnC59HSoXdQhRO27aLx5MNVoloawbHN/
         zFToXvKV47CTQ3wGHQopflvvz8DRLvahQN17AJ3GrWwl+Pg6uaU2+F3DjQXOSnycfuId
         8diThrxu3ECf13NGnsI4ZhHdxZvcvqUTwt8q4rOLcqsKNCX7vbA4GqsRJw7SyvM7ygQh
         eChTgALfBNxXSJSxQ+Xn1bkIqmB0cey5Ukcqt3U9sWk9VJBXlbpiZJhk5gk1RKEctrTi
         IpZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version;
        bh=wwxaugC7WSamcZaKpTPbAtc5muGmMcfBonifKTgqeK8=;
        b=Gz/huOnhqtyLv8mw12oPO2h7Yz39M/kcEySVUVn/8NjJ0imYUgQl/We+R1xEZzQfPd
         ayEriOpHNjAKygxmi6e0TI4nK0m2KIWqvkGeL+dZNlC6yHtcM/0kmklznp9zxhVrqkjm
         9gxmFSpIY6SzohPSz+HTmECX5ACwW1vOOI/bsm+LTF2Zk635O3B/ccnywpP4nj2wJGyP
         ivIoK2C5orgbPLZm6Nae3Cab78La36Rkgj+S3oWZhaRIx+AJhVDimC/ktvYPMWJFwwoY
         /Id+osYrthBfkjXynx8EtWKibUEsha5TAkLLL9gOGdPzPUQOW4OxJhB4xGcSkFeo99kV
         RqHQ==
X-Gm-Message-State: AOAM532wR+BtAFFMvnxFPvSpTXbiM7cmAgfYOL1K3uNnXZ5YxrDhfBJW
        0T3M7D5L8N1kxa1bpj5b8ooP3iojoCjO+w==
X-Google-Smtp-Source: ABdhPJyG3GUfUlF2XL23wcQAbAgIM3KJVicFdqGxJ7ajBj/w1FrWP3N18lnCMj039Xbb6YCiyRj/NQ==
X-Received: by 2002:a17:906:1444:: with SMTP id q4mr33517351ejc.459.1622030018804;
        Wed, 26 May 2021 04:53:38 -0700 (PDT)
Received: from evledraar (j57224.upc-j.chello.nl. [24.132.57.224])
        by smtp.gmail.com with ESMTPSA id u4sm4329634eje.81.2021.05.26.04.53.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 May 2021 04:53:38 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org
Subject: Re: CI fail: "invalid object type" only on dockerized linux32 runs?
Date:   Wed, 26 May 2021 13:53:11 +0200
References: <xmqqsg2acxvo.fsf@gitster.g>
User-agent: Debian GNU/Linux bullseye/sid; Emacs 27.1; mu4e 1.5.12
In-reply-to: <xmqqsg2acxvo.fsf@gitster.g>
Message-ID: <87k0nln22m.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Wed, May 26 2021, Junio C Hamano wrote:

> https://github.com/git/git/runs/2669078911?check_suite_focus=true#step:6:3195
>
> shows a test that expects "git cat-file: could not get object_info"
> gets "invalid object type".  What is curious is that most of the
> other workflow runs do not get this error.  Only on the 32-bit run.
>
> Rings any bell?

That's clearly a bug in code I added, but I haven't been able to
reproduce it yet. There's a 32 bit Debian box on the GCC farm that I
tested this on, and there the tests works just fine, odd...
