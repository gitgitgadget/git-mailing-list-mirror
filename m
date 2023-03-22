Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91E15C6FD1C
	for <git@archiver.kernel.org>; Wed, 22 Mar 2023 21:59:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229904AbjCVV67 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 22 Mar 2023 17:58:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40630 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229870AbjCVV66 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 22 Mar 2023 17:58:58 -0400
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com [IPv6:2607:f8b0:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06941EC52
        for <git@vger.kernel.org>; Wed, 22 Mar 2023 14:58:56 -0700 (PDT)
Received: by mail-pl1-x62c.google.com with SMTP id o11so20570288ple.1
        for <git@vger.kernel.org>; Wed, 22 Mar 2023 14:58:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679522335;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=OynVA2Bqn//WrA76/STogEQd3n1A5fY7aYD0c3AaBsQ=;
        b=G6OuH1FYo93MYQPPZRgiAXckwuKtCQzHqtBDOXCFLU4T+GO/4QOMey3GRDZKU2M8jx
         XoCm/k9IeZGH0cFe6VdWzyVJ34lTf2ZY/Li9/6dKqVcXjjLqkXrV7ao1W0lS7sQdDxTV
         5JpBzdSy0Iwt8Dv3hRF8n+s20gSGneMLJeWRfjiMWG2GdVZuG1/pJF2neeoTogruilfe
         2n4wnSiU1tctXwyL2JVZ1Pj87Qr7BcdNO6mke+MN2MPoIIIUeZ3ZrU+F3e3bFzTS4XTW
         mTaHqO30pZMlUCcnyhywk/u7a9tfyan3c/JYseIjEIHh9rNmHtFtS6plQ+kILI5XvxP6
         n0iA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679522335;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=OynVA2Bqn//WrA76/STogEQd3n1A5fY7aYD0c3AaBsQ=;
        b=SGcsMjoDi29AoDCcumNRL6N544njhv7g79b5wh0wnJm9iQ2+br5KwpMjGbyEOEJRTR
         nNGElO2BtZnpFbWpKYar1wPIo8COkmMNcoI92WC64RpZhnrVSI8io8qko+mxP5jSG41i
         QqFRSpi4e6LiNemVY2yqld0uxy/A6LwMGFYGwG0eTJ4qFaDlHLPbKzRyABYVTwpuhky4
         Sr7taVjmUQHcciPvlssi7wXZhDlLF6ejEd/uhgUUssj4jYfeLDMYxG4JwQXHJ3jmvYQ3
         n1/MTA37i3udYRYkfrkQBlIeZ0BPcM6bqj/xZk7YowpcZz1iuyllfxydqd+D8N0p8buG
         vqaA==
X-Gm-Message-State: AO0yUKWsPpocB/ufVgP2+23zSqVKL48Ude0VX5DO9y4nf3XZKD2vUbhr
        TrXVWycTvmEFtpxaYwL1hG+PmRzi03M=
X-Google-Smtp-Source: AK7set9P0TtA6wtFxJpjNgug2IZzr1b2xiwvxEencJxJX+DHgFtQ6RLOdvQAUtaU0pLRa3V4qZJ8bg==
X-Received: by 2002:a17:902:ca83:b0:1a1:ae8d:1379 with SMTP id v3-20020a170902ca8300b001a1ae8d1379mr3204396pld.7.1679522335392;
        Wed, 22 Mar 2023 14:58:55 -0700 (PDT)
Received: from localhost (83.92.168.34.bc.googleusercontent.com. [34.168.92.83])
        by smtp.gmail.com with ESMTPSA id s5-20020a656445000000b004fb3e5681cesm10441222pgv.20.2023.03.22.14.58.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Mar 2023 14:58:55 -0700 (PDT)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     Chris Torek <chris.torek@gmail.com>
Cc:     Jan =?utf-8?Q?R=C3=BCegg?= <rggjan@gmail.com>, git@vger.kernel.org
Subject: Re: Destructive pre-commit behaviour and "--all"
References: <CAMbUV8F8y62n5ud3AoWQak8J==Zrn7kzwTE7jCveVJEpfcqncg@mail.gmail.com>
        <CAPx1GvftGM2kpVL9JWWXrjyTRWs+6OxteoJDq9dgeOjuidUGwg@mail.gmail.com>
        <CAPx1GvfFrUQBDnJ9QYue91ScZb9ctB+tWv2S+pcprVC7dTgdxg@mail.gmail.com>
Date:   Wed, 22 Mar 2023 14:58:54 -0700
In-Reply-To: <CAPx1GvfFrUQBDnJ9QYue91ScZb9ctB+tWv2S+pcprVC7dTgdxg@mail.gmail.com>
        (Chris Torek's message of "Wed, 22 Mar 2023 14:26:12 -0700")
Message-ID: <xmqqfs9wcush.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Chris Torek <chris.torek@gmail.com> writes:

> It would in theory be possible for Git to load *the* index twice,
> once before and once after the hook, and compare them to see what
> changed, then perhaps try to use that change to update the
> additional indices.  That would be a pretty big change, but if it
> were done right, it might get what you want.

FYI, we tried not to do the extra re-reading, because pre-commit
hook was designed to be a mechanism to allow users to validate, but
not correct, what gets committed.  As the system originally was
designed, users who correctly use Git would *not* be modifying the
index.  Because it is an error to modify the index in the hook, (1)
re-reading the index just in case the user commits such a mistake is
waste of resources, and (2) checking the index to make sure it did
not change before and after invoking the hook, again, is also waste
of resources.

It may have been a mistake that we re-read the index in some case,
which adds to the confusion, but not others.
