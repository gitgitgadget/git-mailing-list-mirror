Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D16EFA3748
	for <git@archiver.kernel.org>; Tue,  1 Nov 2022 03:20:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229882AbiKADUS (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 31 Oct 2022 23:20:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60176 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229823AbiKADUO (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 31 Oct 2022 23:20:14 -0400
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com [IPv6:2a00:1450:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5228464FA
        for <git@vger.kernel.org>; Mon, 31 Oct 2022 20:20:13 -0700 (PDT)
Received: by mail-ej1-x634.google.com with SMTP id k2so34155989ejr.2
        for <git@vger.kernel.org>; Mon, 31 Oct 2022 20:20:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:message-id:in-reply-to:user-agent:references:date
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=0/RqEfRQaRaR8L/Q430clIUo50AUsb3dbv7Yt9VpuwA=;
        b=MwhUBHnVMMGgq4TIGCjtQlVup1fTap76Rh1sR2/jmdbXNzjHmz4Ba2Cd4D0A0w5bQ+
         2+cPROlGUPezIL2q/sUDNqBtyPgX51nzpmJ5daYWdvj35BrgUryEff22M/mZ9GtKDYOM
         8+lCLOQYL4rXWpYOviWYYiWCFZ8DB+lsv9iFiUMzSqd6c8ePHl1d/6JIdcE9I8qQenlY
         XuBWhTQGez5SHqL0XSDGO79iE5Xk+4kR/+YaUfzP9HPc29x9qnhNWaEn3iaIfLJhoVI8
         U2fDBZqE0qNrI4Fea5wzqSngyTqZxqX0EHxpvK8wJcKw5xANv2guoYloSbl9ftZ0HMl9
         P7OA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:message-id:in-reply-to:user-agent:references:date
         :subject:cc:to:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0/RqEfRQaRaR8L/Q430clIUo50AUsb3dbv7Yt9VpuwA=;
        b=toPZ+3kHIbIKLTFbV0IEArQN6qqxPu+HMXYLtgGLOy2PF23xkQy5x56IzRdOOpRwDY
         BeYI97vuDbqeCz6saOfY7ndWqDE1kDtaYiZTgWp5yYc7yfBIgiQcA74W9d7+I5MAvZNs
         0eUqbHAWQQeCGCRPgbHQlCSIc09TWBmd9Z3d4CSK2KhXBatANWKeKgaUiod9UqJhzmVs
         V4i8STLdDtXsrCL6CFoGKq3CQ1Sh8KAn0dUlpUT5WAK4X3Ve2/82YcN6QKfsUsSoP2C8
         AoBxJWSfkWJb8oma7QnCPCKdz3lZ+2/zzI7i7WK94CLpvjt1muk8bTCFzs+o+PmYxXZm
         H+MA==
X-Gm-Message-State: ACrzQf1SpMq5rUe6NhuknYFJ2NhKZj4svbp/TRL4xqGM15ZwNQGVwgGo
        9s2N4hfUParoElF/zPaEU50=
X-Google-Smtp-Source: AMsMyM7X229H/EpgkIuYW1NdNfoMxf7XJCzpfVyQmyC4owCIjWtKb8uXqwZXxNblByJw/V69+bPgCw==
X-Received: by 2002:a17:907:e87:b0:78e:2b3c:f672 with SMTP id ho7-20020a1709070e8700b0078e2b3cf672mr16151503ejc.74.1667272811501;
        Mon, 31 Oct 2022 20:20:11 -0700 (PDT)
Received: from gmgdl (dhcp-077-248-183-071.chello.nl. [77.248.183.71])
        by smtp.gmail.com with ESMTPSA id b28-20020a170906729c00b00770812e2394sm3655090ejl.160.2022.10.31.20.20.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 31 Oct 2022 20:20:11 -0700 (PDT)
Received: from avar by gmgdl with local (Exim 4.96)
        (envelope-from <avarab@gmail.com>)
        id 1ophow-00B1WZ-1l;
        Tue, 01 Nov 2022 04:20:10 +0100
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Jeff King <peff@peff.net>
Cc:     Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Derrick Stolee <derrickstolee@github.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH 1/2] t5516: move plaintext-password tests from t5601 and
 t5516
Date:   Tue, 01 Nov 2022 04:18:32 +0100
References: <Y2CDrZNgNZ+flJBK@coredump.intra.peff.net>
 <Y2CD4g9z2yVFA06l@coredump.intra.peff.net>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.9.0
In-reply-to: <Y2CD4g9z2yVFA06l@coredump.intra.peff.net>
Message-ID: <221101.865yfz5pjp.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Mon, Oct 31 2022, Jeff King wrote:

> Commit 6dcbdc0d66 (remote: create fetch.credentialsInUrl config,
> 2022-06-06) added tests for our handling of passwords in URLs. Since the
> obvious URL to be affected is git-over-http, the tests use http. However
> they don't set up a test server; they just try to access
> https://localhost, assuming it will fail (because the nothing is
> listening there).
>
> This causes some possible problems:
>
>   - There might be a web server running on localhost, and we do not
>     actually want to connect to that.
>
>   - The DNS resolver, or the local firewall, might take a substantial
>     amount of time (or forever, whichever comes first) to fail to
>     connect, slowing down the tests cases unnecessarily.
>
>   - Since there's no server, our tests for "allow" and "warn" still
>     expect the clone/fetch/push operations to fail, even though in the
>     real world we'd expect these to succeed. We scrape stderr to see
>     what happened, but it's not as robust as a more realistic test.
>
> Let's instead move these to t5551, which is all about testing http and
> where we have a real server. That eliminates any issues with contacting
> a strange URL, and lets the "allow" and "warn" tests confirm that the
> operation actually succeeds.
>
> It's not quite a verbatim move for a few reasons:
>
>   - we can drop the LIBCURL dependency; it's already part of
>     lib-httpd.sh
>
>   - we'll use HTTPD_URL_USER_PASS, etc, instead of our fake URL. To
>     avoid repetition, we'll add a few extra variables.
>
>   - the "https://username:@localhost" test uses a funny URL that
>     lib-httpd.sh doesn't provide. We'll similarly construct it in a
>     variable. Note that we're hard-coding the lib-httpd username here,
>     but t5551 already does that everywhere.
>
>   - for the "domain:port" test, the URL provided by lib-httpd is fine,
>     since our test server will always be on an exotic port. But we'll
>     confirm in the test that this is so.
>
>   - since our message-matching is done via grep, I simplified it to use
>     a regex, rather than trying to massage lib-httpd's variables.
>     Arguably this makes it more readable, too, while retaining the bits
>     we care about: the fatal/warning distinction, the "uses plaintext"
>     message, and the fact that the password was redacted.
>
>   - we'll use the /auth/ path for the repo, which shows that we are
>     indeed making use of the auth information when needed.
>
>   - we'll also use /smart/; most of these tests could be done via /dumb/
>     in t5550, but setting up pushes there requires extra effort and
>     dependencies. The smart protocol is what most everyone is using
>     these days anyway.
>
> This patch is my own, but I stole the analysis and a few bits of the
> commit message from a patch by Johannes Schindelin.

Did you consider just using git://; on the WIP branch I linked to where
I fixed these tests quite a bit already I left them in their own file in
anticipation of having to test that (but didn't finish that yet). I.e.:

	+ git -C /home/avar/g/git/t/trash directory.t5700-protocol-v1/repo/parent/ tag two
	+ GIT_TRACE_PACKET=1 git -C daemon_child -c protocol.version=1 -c transfer.credentialsInUrl=die fetch git://foo:bar@127.0.0.1:5700/parent
	fatal: URL 'git://foo:<redacted>@127.0.0.1:5700/parent' uses plaintext credentials

I can't remember if anything can do anything sensible with
user:passwords over non-http(s), but at the point where we emit this
error in remote.c we don't care, so perhaps we could just test it that
way.
