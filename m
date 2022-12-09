Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47049C4332F
	for <git@archiver.kernel.org>; Fri,  9 Dec 2022 13:52:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229783AbiLINwv (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 9 Dec 2022 08:52:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53490 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229777AbiLINwu (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 9 Dec 2022 08:52:50 -0500
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com [IPv6:2a00:1450:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3087CAE63
        for <git@vger.kernel.org>; Fri,  9 Dec 2022 05:52:49 -0800 (PST)
Received: by mail-ej1-x634.google.com with SMTP id vp12so11626321ejc.8
        for <git@vger.kernel.org>; Fri, 09 Dec 2022 05:52:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:in-reply-to
         :user-agent:references:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to;
        bh=KbYFk2rhIbIXn4ruJgaj00aBuLhWwPtlkpTtF8PpeeU=;
        b=MdFv08r51/WZ5ZEJWZTVib+ze7n1eoUEKE5713+WqpVU5fkuH9XYu1azBIcJwERT7P
         suAYfbv5YDHM9EVLhgtSBf8etogj8l/1a6P74j4ETBHBEOvaKh17zkiMT3k4ddy2CWgx
         WOzN0dP3zF4Z+8kYWgzqji4JvyXiMOCV4X0V4GszxVaNZe7l2wygqj0pgnbAdsw1RQtT
         P1Ru0tc4LcXt0VkddvIlbKSMIFvYh6Zf9p95m1UhPnNH09qFl1N/NObv7cjfFuqYUK8q
         gX/Wsr5Ze+yoGFXGzMieKdYw9aBkXZPlPR9T59flJCgNcz+Wlm0vo3bAMZBpJiuc9d4s
         03ig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:in-reply-to
         :user-agent:references:date:subject:cc:to:from:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=KbYFk2rhIbIXn4ruJgaj00aBuLhWwPtlkpTtF8PpeeU=;
        b=v7DjoNxhyX6ct55R8J+Ibhd/4hYx6ePhXcvdTzEhvBJtGyUuAX3Iu+4AgnGyHjTF9P
         iuT5/atEM0a0jPqtE+nUnIHEfN/OQ05wfZb1qAbO7Smjm1k3MSxw87Ey6Bx356Nimm5d
         09tp4Ym36KoLgfv+nwm/GbRQkq4pPJ3NWGQbs+82wysNolmXz3Z2wjN6GTkz4HMFyTyw
         LZWTcCQuBPK1eHfqcBz3LzcUHgPy8HkGryCsu8EmVMCwiICb1aoBDxeIbSKnZtCU3CCA
         r9Bxn3qttjT42Qw9AQRSNkazeqxAP/Id8kJErPjpsU3+TZMa9c5S4gaUg/olPC/HuuuK
         dHCA==
X-Gm-Message-State: ANoB5pnpUnuI1VGoJn7qZK4RxTV8/919NCtIXClAMSbgNdmAbs0QEi+L
        F16sDErAZm4Uw0CdqU+CAk8=
X-Google-Smtp-Source: AA0mqf6xAaYuJLidZe5GOkGsr0MWd/oNIt1dk2QYxvLxPat9gVyPOfHK+lUr2eH79bTCRSRt7Ki5ow==
X-Received: by 2002:a17:906:298c:b0:7c1:9eb:845b with SMTP id x12-20020a170906298c00b007c109eb845bmr5084686eje.16.1670593967513;
        Fri, 09 Dec 2022 05:52:47 -0800 (PST)
Received: from gmgdl (j84076.upc-j.chello.nl. [24.132.84.76])
        by smtp.gmail.com with ESMTPSA id v9-20020a170906292900b007c0aefd9339sm588845ejd.175.2022.12.09.05.52.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Dec 2022 05:52:46 -0800 (PST)
Received: from avar by gmgdl with local (Exim 4.96)
        (envelope-from <avarab@gmail.com>)
        id 1p3dnx-0057Fs-1V;
        Fri, 09 Dec 2022 14:52:45 +0100
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     ZheNing Hu <adlternative@gmail.com>
Cc:     Jeff King <peff@peff.net>,
        Michal =?utf-8?Q?Such=C3=A1nek?= <msuchanek@suse.de>,
        Git List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Christian Couder <christian.couder@gmail.com>,
        johncai86@gmail.com, Taylor Blau <me@ttaylorr.com>
Subject: Re: Question: How to execute git-gc correctly on the git server
Date:   Fri, 09 Dec 2022 14:48:14 +0100
References: <CAOLTT8Tt3jW2yvm6BRU3yG+EvW1WG9wWFq6PuOcaHNNLQAaGjg@mail.gmail.com>
 <221208.86a63y9309.gmgdl@evledraar.gmail.com>
 <20221208011631.GH28810@kitsune.suse.cz>
 <Y5GLsZgmrxbBtLqo@coredump.intra.peff.net>
 <20221209004918.GI28810@kitsune.suse.cz>
 <Y5KRQMcUlepwNlor@coredump.intra.peff.net>
 <CAOLTT8SR6JWX6mRLbyq4keb4JCfJP6Vq07LzHpb_f+e1jMnsZQ@mail.gmail.com>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.9.0
In-reply-to: <CAOLTT8SR6JWX6mRLbyq4keb4JCfJP6Vq07LzHpb_f+e1jMnsZQ@mail.gmail.com>
Message-ID: <221209.86bkoc7kgi.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Fri, Dec 09 2022, ZheNing Hu wrote:

> Jeff King <peff@peff.net> =E4=BA=8E2022=E5=B9=B412=E6=9C=889=E6=97=A5=E5=
=91=A8=E4=BA=94 09:37=E5=86=99=E9=81=93=EF=BC=9A
>>
>> On Fri, Dec 09, 2022 at 01:49:18AM +0100, Michal Such=C3=A1nek wrote:
>>
>> > > In this case it's the mtime on the object file (or the pack containi=
ng
>> > > it). But yes, it is far from a complete race-free solution.
>> >
>> > So if you are pushing a branch that happens to reuse commits or other
>> > objects from an earlier branh that might have been collected =C3=ADn t=
he
>> > meantime you are basically doomed.
>>
>> Basically yes. We do "freshen" the mtimes on object files when we omit
>> an object write (e.g., your index state ends up at the same tree as an
>> old one). But for a push, there is no freshening. We check the graph at
>> the time of the push and decide if we have everything we need (either
>> newly pushed, or from what we already had in the repo). And that is
>> what's racy; somebody might be deleting as that check is happening.
>>
>> > People deleting a branch and then pushing another variant in which many
>> > objects are the same is a risk.
>> >
>> > People exporting files from somewhere and adding them to the repo which
>> > are bit-identical when independently exported by multiple people and
>> > sometimes deleting branches is a risk.
>>
>> Yes, both of those are risky (along with many other variants).
>>
>
> I'm wondering if there's an easy and poor performance way to do
> gc safely? For example, add a file lock to the repository during
> git push and git gc?

We don't have any "easy" way to do it, but we probably should. The root
cause of the race is tricky to fix, and we don't have any "global ref
lock".

But in the context of a client<->server and wanting to do gc on the
server a good enough and easy solution would be e.g.:

 1. Have a {pre,post}-receive hook logging attempted/finished pushes
 2. Have the pre-receive hook able to reject (or better yet, hang with
    sleep()) incoming deletions
 3. Do a gc with a small wrapper script, which:
    - Flips the "no deletion ops now" (or "delay deletion ops") switch
    - Polls until it's sure there's no relevant in-progress operations
    - Do a full gc
    - Unlock

You'd need to be certain that all relevant repo operations are going
through git-receive-pack etc., i.e. a local "git branch -d" or the like
won't run {pre,post}-receive.
