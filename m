Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_DKIM_INVALID,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2007E1FAE3
	for <e@80x24.org>; Fri,  9 Mar 2018 18:00:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932216AbeCISAQ (ORCPT <rfc822;e@80x24.org>);
        Fri, 9 Mar 2018 13:00:16 -0500
Received: from mail-wr0-f177.google.com ([209.85.128.177]:45214 "EHLO
        mail-wr0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751193AbeCISAP (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 9 Mar 2018 13:00:15 -0500
Received: by mail-wr0-f177.google.com with SMTP id h2so2538254wre.12
        for <git@vger.kernel.org>; Fri, 09 Mar 2018 10:00:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=xYn9jrvy2tHjL+RsZU6Z3KIE3qNWWVTYs7R03kebV+0=;
        b=necssNNeIjuM6Re2SdBwbInKI9zk/VsH0RE3UjwR0va1Ze5a6x5OV61djzA/hUOcOM
         78IAthWQ0sg06hxAlUg1GKwR18N9/SSP3Y1kWI56zGDHNnq/SX0d8qtGkr4HjZIK+WJT
         Yd44/5YcAAeAuUtk4rXMDTlWtLfquqUJBy8fKQXV1EfHdKzqYf9X6WCJ8jbxroj4kEEN
         zW4S1evJFfpISs4/ZAEc6Gd5fhb0yeRkDiPVOw11YjU0gfGcpe38vQX8rHiUjPe7nD6m
         aJ6eT4oO+cw5V2Blhzi390HkdNRe1Ew4EfiO1X7sGRl9af+ZkPrkOiKqicKtKZEhs0TZ
         QEJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=xYn9jrvy2tHjL+RsZU6Z3KIE3qNWWVTYs7R03kebV+0=;
        b=GNM/qdVQr4cXo7LNLoZPnNauJIoNKF0jj/zRd6ITdHIZ2ZO5HYZsGQqF3DtkXkryX0
         h1LrQ63JmDo85VsA1QViyNlYAJR1OCiowhk+eeNXhsZUXlgZNcFHQLKKAqGov28jLG3O
         d5Bkk1K7vYyFnxWImOJaQVKCu82aAOM6CS/r/Ux1skmUuCPMwEOraaZ5ihAF6phd0OsG
         v7PREQBhM13ElCIqf//wQIxw6EIPBJWWXWb4X5yRopljVbPkh9waEJ8JW7MqPVMklnyq
         OglXULLnKn5eVYQH7keWmYwSuctHFJ5JW3SVHSpT9UEMfLpRiJ7vW0m8YCGpebiZqLLN
         e5HA==
X-Gm-Message-State: AElRT7GXfGaWjnaLuvpwE5Cc5MnapWULXGG3kf+KwpOS9pv4mf/tlxKq
        MhhQGKbmh1KflXPBLOE+H3Y=
X-Google-Smtp-Source: AG47ELuAX4kcvTOxgQmsozyEXljJhbu4FnkwHU4FZRZgb8veqFW99L2GY57pqMc58SyBMzaHyiC+ww==
X-Received: by 10.223.136.164 with SMTP id f33mr12974610wrf.77.1520618413805;
        Fri, 09 Mar 2018 10:00:13 -0800 (PST)
Received: from localhost (168.50.187.35.bc.googleusercontent.com. [35.187.50.168])
        by smtp.gmail.com with ESMTPSA id f23sm1676247wra.51.2018.03.09.10.00.12
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 09 Mar 2018 10:00:13 -0800 (PST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Takuto Ikuta <tikuta@chromium.org>
Cc:     git@vger.kernel.org, Jonathan Tan <jonathantanmy@google.com>
Subject: Re: [PATCH] fetch-pack.c: use oidset to check existence of loose object
References: <20180308120639.109438-1-tikuta@chromium.org>
        <xmqqr2ouwgsd.fsf@gitster-ct.c.googlers.com>
        <CALNjmMq9gvRzkoYCfXppTVTR5UtvmBZ_4hVuBLB0t7YzR36Wbg@mail.gmail.com>
Date:   Fri, 09 Mar 2018 10:00:12 -0800
In-Reply-To: <CALNjmMq9gvRzkoYCfXppTVTR5UtvmBZ_4hVuBLB0t7YzR36Wbg@mail.gmail.com>
        (Takuto Ikuta's message of "Fri, 9 Mar 2018 23:12:06 +0900")
Message-ID: <xmqqd10d6ser.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Takuto Ikuta <tikuta@chromium.org> writes:

> Yes, I just wanted to say 'git fetch' invokes fetch-pack.
> fetch-pack is skipped when running git fetch repeatedly while
> remote has no update by quickfetch. So I disabled it to see the
> performance of fetch-pack. In chromium repository, master branch
> is updated several times in an hour, so git fetch invokes fetch-pack
> in such frequency.

I do understand that if you run "git fetch" against the same place
in quick succession three times, the first one may cost a lot (not
just that it has to do the everything_local() computation that you
care about, it also has to actually do the network transfer), while
the second and third ones that are done before anything new happens
on the other end will not involve everything_local() overhead thanks
to quickfetch.

A "fetch" that is run against a remote that has nothing new, but
still triggers everything_local() only because quickfetch is
disabled, is an artificial case that has no relevance to the real
world, I suspect, because the quickfetch optimization is to solve
the "there is nothing to be done, still do_fetch_pack() spends so
much cycles only to realize that it does not have anything to do,
why?" issue.

Isn't running the "git fetch" command with the "--dry-run" option
many times in quick succession a lot closer to what you really want
to measure, I wonder?  That way, your first fetch won't be touching
the state of the local side to affect your second and subsequent
fetches.

>> In any case, do_fetch_pack() tries to see if all of the tip commits
>> we are going to fetch exist locally, so when you are trying a fetch
>> that grabs huge number of refs (by the way, it means that the first
>> sentence of the proposed log message is not quite true---it is "When
>> fetching a large number of refs", as it does not matter how many
>> refs _we_ have, no?), everything_local() ends up making repeated
>> calls to has_object_file_with_flags() to all of the refs.
>
> I fixed description by changing 'refs' to 'remote refs'. In my understanding,
> git tries to check existence of remote refs even if we won't fetch such refs.

During fetch, everything_local() tries to mark common part by
walking the refs the other side advertised upon the first contact,
so it is correct that the number of checks is not reduced in a fetch
that does not fetch many refs, but the number of remote-tracking refs
you have has no effect, so I doubt such a rephrasing would make the
description more understandable.  "When fetching from a repository
with large number of refs" is probably what you want to say, no?

> Yes. But I think the default limit for the number of loose objects, 7000,
> gives us small overhead when we do enumeration of all objects.

Hmph, I didn't see the code that does the estimation of loose object
count before starting to enumerate, though.

>> Hmm, OBJECT_INFO_QUICK optimization was added in dfdd4afc
>> ("sha1_file: teach sha1_object_info_extended more flags",
>> 2017-06-21), but since 8b4c0103 ("sha1_file: support lazily fetching
>> missing objects", 2017-12-08) it appears that passing
>> OBJECT_INFO_QUICK down the codepath does not do anything
>> interesting.  Jonathan (cc'ed), are all remaining hits from "git
>> grep OBJECT_INFO_QUICK" all dead no-ops these days?
>
> Yes the flag is no-op now, but let me untouched the flag in this patch.

Yeah, I do not want you to be touching that in this change.  It is
an independent/orthogonal clean-up.

Thanks.
