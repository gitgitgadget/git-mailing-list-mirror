Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C236CE79D4
	for <git@archiver.kernel.org>; Wed, 20 Sep 2023 12:25:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235767AbjITMZW (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 20 Sep 2023 08:25:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51486 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235890AbjITMY7 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 20 Sep 2023 08:24:59 -0400
Received: from mail-il1-x12e.google.com (mail-il1-x12e.google.com [IPv6:2607:f8b0:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A8A19B4
        for <git@vger.kernel.org>; Wed, 20 Sep 2023 05:24:52 -0700 (PDT)
Received: by mail-il1-x12e.google.com with SMTP id e9e14a558f8ab-34fdc6209c6so12265025ab.3
        for <git@vger.kernel.org>; Wed, 20 Sep 2023 05:24:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695212692; x=1695817492; darn=vger.kernel.org;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=+DZB5n414KqGwhvIyFHwLF93GDzNAfyb6fAVD/l3KXY=;
        b=Lix8EniU6qkeuz7LaBekgUdZxN/MaBYXJBYcfevG9v0+Y/Iruwc5xHlXqU6Ids1bLP
         qP/9QBx/vmo2hSH4FV0gmhyKmb+hG+XpzlORU9NEvUXy+3v1IwNWUeLo0CZ0jldt2FAe
         9cP6dWn6Hup9SBy4pJAOWVlEW11Z7SYMMRVAlj/u+V6csA5k0gMZIUDgd7UzBNoo1xn/
         zFZGTcYgIqys4B+HbrTL22/8M53+4st/E7KH5NuW2WFJe0YQ/YHnhl/hOUzgCK/dF1NJ
         eNw8/ujKVR8i1FxQaiHSPw8gpVIfvhe1bSKmRBGo62ZQSZMgQfMGh7KdbZZC3+rHqU35
         Txeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695212692; x=1695817492;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+DZB5n414KqGwhvIyFHwLF93GDzNAfyb6fAVD/l3KXY=;
        b=BNix7phfm6nI0VFZ1jA7ZWdYml66Jh7VSumFKzAjriXB+htdqGEo5zFGQ5TPOv3YT0
         LlQcTVrqHOR4mrcW3ZI6PnPvZg3xbqkTs6TwrwQ17VodRPUE+6XJv+OTPOJrw0Uwi1kz
         OVz+nzVweP64dv6r6udP2qRmZWn/F9afnIBQtikC+3c4NqMOIzic1PY0ZwBQaVWUmA1c
         jZqG0sU1DiQaHP59KU2r5DXuvREV8gLBYQVJ+X4248bl2sCOMSdLEZmerx5F6lN9RARk
         /xslST39B7jVAcWWCBR4nTwIhSAqD/62s86daBHPYFTNIuLTG+szp3MyS0c90Sg0zVM+
         4kZw==
X-Gm-Message-State: AOJu0YzoiO1kbRXl63QdBOFcOIasTvb6bXnOymczXLRv8igKn5C8dwkF
        rYRgvWeUvfGCT74gXKyhEWQddOJnXv0=
X-Google-Smtp-Source: AGHT+IGoKwxTuVeEdKKChd0IR16B+CGL0K1ZXWIgeVRtJ/vWw0a6Ns7d60o5y+VveEfLuebmKtdCzA==
X-Received: by 2002:a92:c267:0:b0:34f:9f1b:554c with SMTP id h7-20020a92c267000000b0034f9f1b554cmr3487345ild.5.1695212691715;
        Wed, 20 Sep 2023 05:24:51 -0700 (PDT)
Received: from gmail.froward.int.ebiederm.org.gmail.com (ip68-227-168-167.om.om.cox.net. [68.227.168.167])
        by smtp.gmail.com with ESMTPSA id o3-20020a056e02068300b0034fda29890asm2613727ils.10.2023.09.20.05.24.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Sep 2023 05:24:51 -0700 (PDT)
From:   "Eric W. Biederman" <ebiederm@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     "brian m. carlson" <sandals@crustytoothpaste.net>,
        <git@vger.kernel.org>
Subject: Re: [PATCH v2] bulk-checkin: only support blobs in index_bulk_checkin
References: <878r918ps3.fsf@gmail.froward.int.ebiederm.org>
        <xmqqr0mtcosy.fsf@gitster.g>
Date:   Wed, 20 Sep 2023 07:24:49 -0500
In-Reply-To: <xmqqr0mtcosy.fsf@gitster.g> (Junio C. Hamano's message of "Tue,
        19 Sep 2023 23:59:57 -0700")
Message-ID: <87zg1h58xa.fsf@gmail.froward.int.ebiederm.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

> "Eric W. Biederman" <ebiederm@gmail.com> writes:
>
>> As far as I can tell this extra pass defeats most of the purpose of
>> streaming, and it is much easier to implement with in memory buffers.
>
> The purpose of streaming being the ability to hash and compute the
> object name without having to hold the entirety of the object, I am
> not sure the above is a good argument.  You can run multiple passes
> by streaming the same data twice if you needed to, and how much
> easier the implementation may become if you can assume that you can
> hold everything in-core, what you cannot fit in-core would not fit
> in-core, so ...

Yes this wording needs to be clarified.

If streaming to handle objects that don't fit in memory is the purpose,
I agree there are slow multi-pass ways to deal with trees, commits and
tags.

If writing directly to the pack is the purpose, using an in-core
buffer for trees, commits, and tags is better.

I will put on the wording on the back burner and see what I come up
with.

>> So if it is needed to write commits, trees, and tags directly to pack
>> files writing a separate function to do the would be needed.
>
> But I am OK with this conclusion.  As the way to compute the
> fallback hashes for different types of objects are very different,
> compared to a single-hash world where as long as you come up with a
> serialization you have only a single way to hash and name the
> object.  We would end up having separate helper functions per target
> type anyway, even if we kept a single entry point function like
> index_stream().  The single entry point function will only be used
> to just dispatch to type specific ones, so renaming what we have today
> and making it clear they are for "blobs" does make sense.

Good.  I am glad I am able to step back and successfully explain the
whys of things.

Eric

