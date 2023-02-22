Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A2E5C636D7
	for <git@archiver.kernel.org>; Wed, 22 Feb 2023 00:22:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230301AbjBVAWY (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 21 Feb 2023 19:22:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60538 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229448AbjBVAWX (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 21 Feb 2023 19:22:23 -0500
Received: from mail-pl1-x630.google.com (mail-pl1-x630.google.com [IPv6:2607:f8b0:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7AEBF303D4
        for <git@vger.kernel.org>; Tue, 21 Feb 2023 16:22:22 -0800 (PST)
Received: by mail-pl1-x630.google.com with SMTP id z2so7102199plf.12
        for <git@vger.kernel.org>; Tue, 21 Feb 2023 16:22:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:user-agent:message-id:date:references:subject:cc:to
         :from:sender:from:to:cc:subject:date:message-id:reply-to;
        bh=N2Ybdu/ipZc/Xpv+jIzY5se4a6GftEnNc0fZyY7JIJI=;
        b=ZTyakMxiLJHIQPo5Bv0dKZqKU7/U2+5GsVnKkuXZUCWMU0GqAhtl67QiY8+zIC4s78
         IxtlBPzDdMNwPPPKqXSndNjY6fEXop8iiUq7SufcZ2Goke6QKdQtaNcbL+L3SUUYqvQp
         LLMo4pq9NcNdIEVXKNJUHmzKbRghQPhv9xsMUOXeZ9KVX9gqe8quoZl0MS6hban1MHVM
         5KBUwjrx0Fj8VnRDfXFeGlIN1cy3m4ff5sbUZGcOZoGGCKOhbTFrUJtrkkwiQon/pcct
         K1A9WPw6BtdwQLqxM2pIMIoN6hmuU2tPh9n/d432yErzRpWN89mq8NlLVegvONAeSHia
         /PYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:user-agent:message-id:date:references:subject:cc:to
         :from:sender:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=N2Ybdu/ipZc/Xpv+jIzY5se4a6GftEnNc0fZyY7JIJI=;
        b=Odm3mN00IbK7h/eksGxnFhAFF/b41hGx0w5FUDM33pH7sf0uKLBIXhWz3UCyn2ugkz
         3fqh8jtYl1iDG9MJpFjh1NzypyfnIvocKJXvJf4N21R1VJxkQ9hn227mIB0K91vRLlMA
         dWazIh270IA+IYgv1PziWDCM7NnsYWqvVQuUGKU+qSXEzFL8YPIV89UZHoFytw2SQh0n
         4VKDNsTgHdwoC60hpskV3K66grAm4LxP+ohG2slqF0OhkK3LuKttETMMmUU4OLTzBVVL
         5iHn+iredzSfWMcVBK1lGlNWhkiZfBCO/rzka+v66baqeSYhlwZ2x+uG65E1sJebVeD0
         mWZA==
X-Gm-Message-State: AO0yUKW7w9STzUOBUjLUm+3e7zkdfL2SFZRlw4LYknjKtKv8Mit2tQ5R
        xRD/Ivg4jnBvVA5EOK9X7H1+4vTqnRQ=
X-Google-Smtp-Source: AK7set+PbrUU4sRk8jwdvL1kmwfVqVkVrGKXP/Y8sWXCNd3SHlezd20EQlwzXeHpZOViBUb+F2GHjw==
X-Received: by 2002:a17:903:124c:b0:19c:a5dd:fadb with SMTP id u12-20020a170903124c00b0019ca5ddfadbmr1429295plh.54.1677025341807;
        Tue, 21 Feb 2023 16:22:21 -0800 (PST)
Received: from localhost (252.157.168.34.bc.googleusercontent.com. [34.168.157.252])
        by smtp.gmail.com with ESMTPSA id y9-20020a170902ed4900b0019c91d3bdb4sm2100630plb.304.2023.02.21.16.22.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Feb 2023 16:22:21 -0800 (PST)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     Emily Shaffer <nasamuffin@google.com>
Cc:     Git List <git@vger.kernel.org>, Jonathan Nieder <jrn@google.com>,
        Jose Lopes <jabolopes@google.com>,
        Aleksandr Mikhailov <avmikhailov@google.com>
Subject: Re: Proposal/Discussion: Turning parts of Git into libraries
References: <CAJoAoZ=Cig_kLocxKGax31sU7Xe4==BGzC__Bg2_pr7krNq6MA@mail.gmail.com>
        <xmqq3573lx2d.fsf@gitster.g>
        <CAJoAoZn7Nt37Eh17dpLDK+YX2BaEaAaii2rJPXO3L0BmQQkcgQ@mail.gmail.com>
Date:   Tue, 21 Feb 2023 16:22:20 -0800
Message-ID: <xmqqk00aczwj.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Emily Shaffer <nasamuffin@google.com> writes:

>> For example, "die() is inconvenient to callers, let's propagate
>> errors up the callchain" is an easy thing to say, but it would take
>> much more than "let's propagate errors up" to libify something like
>> check_connected() to do the same thing without spawning a separate
>> process that is expected to exit with failure.
>
> Because the error propagation path is complicated, you mean? Or
> because the cleanup is painful?

Both.

The amount of data the caller may want to learn about an error may
not be uneven, depending on the caller even for a single function.
And yes, cleaning up of shared resources like object flag bits after
a traversal, especially a failed one, would be very painful unless
the processing is designed from day one to allow it (and the
revision traversal codepath is not).

> ... is it reasonable to consider, for example, further
> cleanup of cache.h as part of this effort? Is it reasonable to rework
> an ugly circular dependency between two headers as a prerequisite to
> doing library work around one of them?

I am not sure about which two headers you are talking about, but if
there is circular dependency that can be untangled, it would be a
reasonable preliminary clean-up work.  I am not sure if that is
"prerequisite"---it is up to folks who want to design how the
"libification" work goes.
