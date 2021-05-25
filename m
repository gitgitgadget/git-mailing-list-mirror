Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BAEBEC2B9F8
	for <git@archiver.kernel.org>; Tue, 25 May 2021 06:11:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9E64B6140F
	for <git@archiver.kernel.org>; Tue, 25 May 2021 06:11:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231161AbhEYGNH (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 25 May 2021 02:13:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47044 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231240AbhEYGNE (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 25 May 2021 02:13:04 -0400
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9BE94C06138B
        for <git@vger.kernel.org>; Mon, 24 May 2021 23:11:32 -0700 (PDT)
Received: by mail-ed1-x534.google.com with SMTP id r11so34638286edt.13
        for <git@vger.kernel.org>; Mon, 24 May 2021 23:11:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version:content-transfer-encoding;
        bh=0dyWixV04+KD7YG4yd7d/8UyLE19mdYu4K9D0eJRqdI=;
        b=pmKZpd9Z7EB/XHmrcH3FdHpwM36LHdS9Pf7BH6rSR3Ow/jadWkqNmpvoZYjSo584QE
         wYGePNgpU0XDXZE09o78+cWDb4pv0O65kzV3dEqCNpjKL6F8phj8BhEAQwxvD7E4jOc1
         rl2mO3sSipTTdk1DG04TkjRwY/OI57KAHWFeT/B0YjKzyIvUGSx9yLRdO0WIkTYjcPr9
         UTc1fp/CBzBt05ufEyXNNJ5OXC1dvrtAVXocPZ+v6myTXYXOe8MoQNUTFcQsw459Wa+5
         rL9SM/lU8PCE/Ln2pVFR5zjQ2Czb8SmYvKUhVF9s7ehpUlOexSzXKbEPovMaPjKjv+8N
         lldQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version:content-transfer-encoding;
        bh=0dyWixV04+KD7YG4yd7d/8UyLE19mdYu4K9D0eJRqdI=;
        b=P+VQhQb4sfGsBw5dZHyW2do+mlxIXydhIV2vnyIheMWL/2978h+ljufNKc+pRO5gxg
         7HQAWLVZA2JZfxFYazSBoWrzJG5JL6dNgiW8cNXzYAi06sKDGpLRsCipp7qvKy9YQLDW
         l3uuio6QAiWwnbYf7OsDmjRMTj3P6jbI7Hq/bNeMtRbRiY2oc4mghp2KQ/RIpu4ly9oL
         wkYp4nvQsTD0Vg5XFd76VLTHAj3AXQbkzKKHQvbgq0DpnnV5OOhYt1z2GPb2E/EspgkX
         im2oDSVq8ZE6y+enKpv7oruV+vdysuWxa6HKQyTyFZMoJjJFvi9xQl5GGWJTCZEixBKp
         wBzQ==
X-Gm-Message-State: AOAM5330Jq5z1JRqkkTcjxPES7sBoA2sVWp19nklzC3g/f5HpgqZHxR6
        cfAg7fRExkZdlNnepz7C1EY=
X-Google-Smtp-Source: ABdhPJw/9E4EpR12iOZVW9L9wyvNxOlkJ+bu1vNkws9Jpd7Ih0HRGxOby851RoJftd8haYTrTsrAOQ==
X-Received: by 2002:aa7:cd03:: with SMTP id b3mr29907235edw.206.1621923091187;
        Mon, 24 May 2021 23:11:31 -0700 (PDT)
Received: from evledraar (j57224.upc-j.chello.nl. [24.132.57.224])
        by smtp.gmail.com with ESMTPSA id x13sm8762445ejs.93.2021.05.24.23.11.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 May 2021 23:11:30 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, Johannes Sixt <j6t@kdbg.org>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Robert Foss <robert.foss@linaro.org>
Subject: Re: [PATCH 2/2] send-email: don't needlessly abs_path() the
 core.hooksPath
Date:   Tue, 25 May 2021 07:57:37 +0200
References: <bb30fe2b-cd75-4782-24a6-08bb002a0367@kdbg.org>
 <cover-0.2-00000000000-20210524T231047Z-avarab@gmail.com>
 <patch-2.2-d097e7b0b81-20210524T231047Z-avarab@gmail.com>
 <xmqqh7iripzg.fsf@gitster.g>
User-agent: Debian GNU/Linux bullseye/sid; Emacs 27.1; mu4e 1.5.12
In-reply-to: <xmqqh7iripzg.fsf@gitster.g>
Message-ID: <874kerny0e.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Tue, May 25 2021, Junio C Hamano wrote:

> =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason  <avarab@gmail.com> writes:
>
>> In c8243933c74 (git-send-email: Respect core.hooksPath setting,
>> 2021-03-23) we started supporting core.hooksPath in "send-email". It's
>> been reported that on Windows[1] doing this by calling abs_path()
>> results in different canonicalizations of the absolute path.
>
> I see the author of that patch CC'ed; the change in question
> explains why we switched from "the hooks directory immediately under
> $repo->repo_path()" to "ask 'rev-parse --git-path hooks'", but it
> does not say why we call abs_path() on the result.  I guess that is
> because $repo->repo_path() has always been a result of applying the
> abs_path() function to something, so it was to safeguard the callers
> that expect an absolute path coming back from hooks_path?
>
> And that makes this change dubious, especially as a band-aid for a
> breakage immediately before the final release, doesn't it?  Are we
> convinced that the callers are OK with seeing sometimes relative
> paths?  Certainly the cases the tests J6t fixed are not negatively
> affected, but is that sufficient?  To what directory is the
> configuration variable supposed to be relative to, and are we sure
> that the user will always invoke "git send-email" from that
> directory?

The one caller is git-send-email.perl is fine with it, at least on *nix,
this fix still needs testing on Windows.

The repo_path() function was introduced in c8243933c74, so it's never
been in a release, thus I think it's fine to alter its behavior.

The code here doesn't need to concern itself with what needs to be
relative to what, you run send-email in some working tree directory (or
top-level), and depending on core.hooksPath we'll either return a
relative path to the .git/hooks or an absolute one, the system()
invocation will accept either.
