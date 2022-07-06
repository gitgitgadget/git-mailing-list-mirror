Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E92FEC433EF
	for <git@archiver.kernel.org>; Wed,  6 Jul 2022 09:13:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233069AbiGFJNa (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 6 Jul 2022 05:13:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54518 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233291AbiGFJMc (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 6 Jul 2022 05:12:32 -0400
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 058FE26545
        for <git@vger.kernel.org>; Wed,  6 Jul 2022 02:09:34 -0700 (PDT)
Received: by mail-ej1-x629.google.com with SMTP id o25so25959566ejm.3
        for <git@vger.kernel.org>; Wed, 06 Jul 2022 02:09:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version;
        bh=1ig5NhcGU/qMd2ZcwcR9v8aAwQtUcjq1MLKsAChfcwI=;
        b=NJ5Wegzqla/UKO08yFroIPsLlV/jObvYmupgtWoxScjHSRc/IbrZj+SmYNi6exX0RS
         IMgpXE2o0tYBu8gHgD/KYERVwt2rfPYrCVB/BC3oCJa2yUDoBDJKh9d3djdtwJ8s6j2L
         Wyd2s32cqBgBVV4FjmNmN46J58rXzsYlZfHibXRGh3pc7m2HmNys6tBjQ3p6z/hPgU68
         LYNp/Ze340ris5nLmmENfN7NmAnQfY81NYSChc4kYIdE9wwleJZlDbwkpWx9lBt+cHpd
         2aAKS46784eKUBWPc6yKhulxurFLHc0aqcA7Yw8iAdv6SgbHcDNi4MSAanHHM4h4/RDW
         Ya7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version;
        bh=1ig5NhcGU/qMd2ZcwcR9v8aAwQtUcjq1MLKsAChfcwI=;
        b=HuWf+PkcU59IzeWvjzy0ZKCwhnDEYjCcNfdDBYsdluemhxnBLVMncXYuqXgS79ZwaI
         wSoy9747pq2OVTagw9OrzexZ8SGyVWuCBUbh5gYFgNoxjlKYhVDXiYQvTyVbZ/T31Bc4
         L4SWK0xw1LL/9ue+MFTmFH1EmMQD5gjSBBanVvuC4FEsmqNsIiWZEzN8oYNSNVMhzfdt
         3qnfALmSfmpnH4cRqwjniOjhKmjAIUTSOxlwI+dV5iQOQv1Fh/jdvDPdHpMmzNNz1uL5
         e+GvwcyLLWVqDuPvkq5NkYJwKjriWvKD6QrB7X7Ev+ESpJHXjfyEYUFzyWDbj28w/DBU
         4nCA==
X-Gm-Message-State: AJIora9oQc8SAY7aswU7RkT1pJQcByw+OWGtpVK3piZClI01zEiX1eYu
        VBoCmvUg+M7RZH/qIeBRXdU=
X-Google-Smtp-Source: AGRyM1uDJ4P49dQXamFVG/y8v1o9tykS/N2ARmlxdnkCiY7CyNw6OJV6osw2FxFuzKHCnmRtBb8aIg==
X-Received: by 2002:a17:907:28d6:b0:72a:f121:b71 with SMTP id en22-20020a17090728d600b0072af1210b71mr4192347ejc.732.1657098572257;
        Wed, 06 Jul 2022 02:09:32 -0700 (PDT)
Received: from gmgdl (dhcp-077-248-183-071.chello.nl. [77.248.183.71])
        by smtp.gmail.com with ESMTPSA id bq15-20020a056402214f00b00435a742e350sm25371975edb.75.2022.07.06.02.09.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Jul 2022 02:09:31 -0700 (PDT)
Received: from avar by gmgdl with local (Exim 4.95)
        (envelope-from <avarab@gmail.com>)
        id 1o912I-004Dyq-6j;
        Wed, 06 Jul 2022 11:09:30 +0200
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Gregory Szorc <gregory.szorc@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>, Taylor Blau <me@ttaylorr.com>,
        git@vger.kernel.org, stolee@gmail.com
Subject: Re: Race condition between repack and loose-objects maintenance task
Date:   Wed, 06 Jul 2022 10:50:56 +0200
References: <CAKQoGamCrRMqtzziuzi8mL6E7uA3SC1WXiMGT_4rpbk1jcu_OQ@mail.gmail.com>
 <YryF+vkosJOXf+mQ@nand.local>
 <CAKQoGakSFaNm10ZeTKc8XtTcD0JW19CZP1OwA4j7W__iBQaJfg@mail.gmail.com>
 <YryKCl5J1Em89d3e@nand.local>
 <CAKQoGanPBec6wRO6uWrETaoJXdszpjRWytXaJwx6jw0mrrj-gQ@mail.gmail.com>
 <Yr0WLebMfBXZ1K7D@nand.local> <Yr0XMWWyD5C9uhlb@nand.local>
 <xmqqletdewrf.fsf@gitster.g>
 <CAKQoGakLzF+bvSnU7JD7yBibmYe0-8j3eo+CgN7EchUiNc2NkA@mail.gmail.com>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.7.12
In-reply-to: <CAKQoGakLzF+bvSnU7JD7yBibmYe0-8j3eo+CgN7EchUiNc2NkA@mail.gmail.com>
Message-ID: <220706.86bku2a9px.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Tue, Jul 05 2022, Gregory Szorc wrote:

> Thinking about this some more, it is clear that running `git gc` /
> `git repack` *and* `git maintenance` simultaneously is prone to
> badness since their locking mechanisms aren't aware of the other.

Yes, there are outstanding issues with the "maintenance" and "gc" locks,
they should be unified, and the gc.lock has bugs & race conditions that
need to be fixed. See these past threads:

    https://lore.kernel.org/git/87d02fi75p.fsf@evledraar.gmail.com/
    https://lore.kernel.org/git/87ef3o7ws1.fsf@evledraar.gmail.com/

I also have some old WIP patches to add a "gc testing" mode to our test
suite, similar to the "commit graph" instrumentation if you're
interested in working on this.

I.e. almost every command will fork off a "gi gc --auto", and we'll see
based on the errors whether our locking is still buggy/racy.

> I think it makes sense to consolidate onto `git maintenace` going
> forward as this seems to be where the inertia is. However, a barrier
> to that for me is the objects/maintenance.lock file has no acquisition
> timeout and will wait indefinitely. So in scenarios like mine where
> you have multiple processes looping over repos invoking `git
> maintenance run`, you can have extended execution stalls during
> long-running operations like `gc`.
> [...]
> There should probably be a configurable timeout for the maintenance
> lock like there is for other locks. This shouldn't be too much work
> and I may throw up a patch if others feel this is a good idea.

...but while I think this is all worthwhile I think you're on the wrong
path if you think this will help much or at all with the issue being
reported here.

Fixing the gc.lock (and maintenance lock...) would be nice because we'd
have "gc" be less dumb, and it wouldn't get itself into lock races etc.

But you cannot hope to fix the underlying "object expiry as things
become reachable" race condition that way, because that's those tasks
racing with *other* object/ref creation.

Such a fix would either need some repository-global lock (which would
entail all sorts of nastyness), or other workarounds around the inherent
race between different object store & ref operations, see Taylor's
recent "cruft pack write-out" series & my links to some past discussions
of the race here:

    https://lore.kernel.org/git/220630.86y1xeeeik.gmgdl@evledraar.gmail.com/
