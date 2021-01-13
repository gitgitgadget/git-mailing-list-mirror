Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6F7CC433DB
	for <git@archiver.kernel.org>; Wed, 13 Jan 2021 15:49:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 56F78233FD
	for <git@archiver.kernel.org>; Wed, 13 Jan 2021 15:49:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727225AbhAMPtn (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 13 Jan 2021 10:49:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54240 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726110AbhAMPtn (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 13 Jan 2021 10:49:43 -0500
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6422C061575
        for <git@vger.kernel.org>; Wed, 13 Jan 2021 07:49:02 -0800 (PST)
Received: by mail-ej1-x62d.google.com with SMTP id n26so3731564eju.6
        for <git@vger.kernel.org>; Wed, 13 Jan 2021 07:49:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version;
        bh=MQ8sthC19q4D8meOuqYAXVydT05yimW5BDMMT8xyAaY=;
        b=Z0NXXOpwZ5b0qhhdoo+xxkgRnjdiciG/r+rDQMqmGoZxMJ8kz5ZgFqY6RrpFR/0j8F
         zqfCqMWs1Wm+7pDWy1I4rAqYzYPPtOQNYRZD23V+Av9XGDklcEbOi7M9Irzn+EdrSiJL
         +ghps8jlynf0icYGzr+Xe3PiTAVmq547ebikT80fjsICzH8FLHEmkTo5DuQluTklCHQN
         /EhmRKyuCb/HafNpY/Wp51QtEydpxXUsAA1H/LyhdpIt8TSB6/VPjgCilV4JMnIv3kRf
         v+JACiSIM9f78iBMXRXO6YDcIEqcfmm3OBU1ERg+vH0aD+i56F0J8jZZpCjO0AD+FBLO
         fSzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version;
        bh=MQ8sthC19q4D8meOuqYAXVydT05yimW5BDMMT8xyAaY=;
        b=salTW8+qhbRIcFhnaXbJsmklAe2vOPunbqcAaIywCbXhTHHc8BBaa/s8tQC4K/c93M
         ukyoJb+JuRXw2Ls9z0KEQPP7nGKmI3MqbBe7jBFZ10S1Kp6RSHiqxBjxq2BbXOAFDSSZ
         bWG3e1qal3p02jXrHjE/+bpHDs9dpTrrXAZ/z3LPPRZdhfA2sFFFu4DczSNo8ASR/u+6
         RGQ/8TsQn6BcV6E2lZuonNA38lvrqtpWdMTLchNcpn0g7WfelFnZ+MlP/bRfK5TUCHEW
         cdSoZL9V1WpbNeY6IhM2HjdTEofZTZBdaEjNSC44C0W8GnZBeqgZyQ9c1EkqtV1TN8al
         P4pQ==
X-Gm-Message-State: AOAM531XabLb9f/UOJg1TFjG5v+ShQpAY1oFGuxQNwedCZR88YcbvI8j
        WCIexMj+vIdoneJ7K4XfKgk=
X-Google-Smtp-Source: ABdhPJzfAjE3p8CFCtslbewFqgcimGBvNiNrW+On9qXnZcccexlgxDlPZoKa5t6sh4GhgunabpuHlw==
X-Received: by 2002:a17:906:5495:: with SMTP id r21mr2018877ejo.59.1610552941402;
        Wed, 13 Jan 2021 07:49:01 -0800 (PST)
Received: from evledraar (i116144.upc-i.chello.nl. [62.195.116.144])
        by smtp.gmail.com with ESMTPSA id w10sm853885ejq.121.2021.01.13.07.49.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Jan 2021 07:49:00 -0800 (PST)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Jeff King <peff@peff.net>
Cc:     Jeff Hostetler <git@jeffhostetler.com>,
        Junio C Hamano <gitster@pobox.com>,
        Jeff Hostetler via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Jeff Hostetler <jeffhost@microsoft.com>
Subject: Re: [PATCH 00/10] [RFC] Simple IPC Mechanism
References: <pull.766.git.1610465492.gitgitgadget@gmail.com>
 <xmqq5z4153gq.fsf@gitster.c.googlers.com>
 <cee527cb-7962-1528-0c70-583ad805e624@jeffhostetler.com>
 <X/75mip8tYO/mmSW@coredump.intra.peff.net>
User-agent: Debian GNU/Linux bullseye/sid; Emacs 27.1; mu4e 1.4.13
In-reply-to: <X/75mip8tYO/mmSW@coredump.intra.peff.net>
Date:   Wed, 13 Jan 2021 16:48:59 +0100
Message-ID: <8735z46dn8.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Wed, Jan 13 2021, Jeff King wrote:

> On Tue, Jan 12, 2021 at 06:25:20PM -0500, Jeff Hostetler wrote:
>
>> On the Unix side, the socket is created inside the .git directory
>> by the daemon.  Potential clients would have to have access to the
>> working directory and the .git directory to connect to the socket,
>> so in normal circumstances they would be able to read everything in
>> the WD anyway.  So again, I don't think it is a problem.
>
> Just thinking out loud, here are two potential issues with putting it in
> .git that we may have to deal with later:
>
>   - fsmonitor is conceptually a read-only thing (i.e., it would speed up
>     "git status", etc). And not knowing much about how it will work, I'd
>     guess that is carried through (i.e., even though you may open the
>     socket R/W so that you can write requests and read them back, there
>     is no operation you can request that will overwrite data). But the
>     running user may not have write access to .git.
>
>     As long as we cleanly bail to the non-fsmonitor code paths, I don't
>     think it's the end of the world. Those read-only users just won't
>     get to use the speedup (and it may even be desirable). They may
>     complain, but it is open source so the onus is on them to improve
>     it. You will not have made anything worse. :)
>
>   - repositories may be on network filesystems that do not support unix
>     sockets.
>
> So it would be nice if there was some way to specify an alternate path
> to be used for the socket. Possibly one or both of:
>
>   - a config option to give a root path for sockets, where Git would
>     then canonicalize the $GIT_DIR name and use $root/$GIT_DIR for the
>     socket. That solves the problem for a given user once for all repos.
>
>   - a config option to say "use this path for the socket". This would be
>     per-repo, but is more flexible and possibly less confusing.
>
> One final note: on some systems[1] the permissions on the socket file
> itself are ignored. The safe way to protect it is to make sure the
> permissions on the surrounding directory are what you want. See
> credential-cache's init_socket_directory() for an example.
>
> -Peff
>
> [1] Sorry, I don't remember which systems. This is one of those random
>     bits of Unix lore I've carried around for 20 years, and it's
>     entirely possible it is simply obsolete at this point.

According to StackExchange lore this seems to have been the case with
4.2 BSD & maybe something obscure like HP/UX:
https://unix.stackexchange.com/questions/83032/which-systems-do-not-honor-socket-read-write-permissions

I'd say it's probably safe to ignore this as a concern for new features
in git in general, and certainly for something like a thing intended for
a watchman-like program which users are likely to only run on modern
OS's.
