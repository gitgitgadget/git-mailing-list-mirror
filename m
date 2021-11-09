Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 908D8C433EF
	for <git@archiver.kernel.org>; Tue,  9 Nov 2021 02:12:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6F5ED6117A
	for <git@archiver.kernel.org>; Tue,  9 Nov 2021 02:12:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234786AbhKICO5 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 8 Nov 2021 21:14:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59808 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230190AbhKICO4 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 8 Nov 2021 21:14:56 -0500
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E9B5C061570
        for <git@vger.kernel.org>; Mon,  8 Nov 2021 18:12:11 -0800 (PST)
Received: by mail-ed1-x52e.google.com with SMTP id f8so70513440edy.4
        for <git@vger.kernel.org>; Mon, 08 Nov 2021 18:12:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version:content-transfer-encoding;
        bh=0Txfl3w3fyNWqxoQo0kheinkVsf2R4E3f1Pod9NIB+Q=;
        b=ct4/oYTjFuHKHYW01FNeI4o2oYc6qxzWXBDRqMZjjNTJFqzjBuudbH/NLvlft4SLFa
         tbqP1FNnws+2fAFFsnHtJRaDws0j0dVHSRf2pCeCmcAL2D9mCVW0rC7moH3/dbpmK6a8
         DJmsBiS0quIRLifY5PiO/MOfzIOOQGW/1qDDSGuH/Vj/5KX0d4PCGCIV6H0DPpT+Lm09
         Z1aF1lDZIjwu5Ab4om3PSJplDiJySvetPPGTq5kb069Nn6RQN6yYxar8VNuPjKtRDY/S
         zqjgrlFgAT5nCvUsOQWEiKaFo9P8AwC+Uk3vkJ1IclFkTNbty0qg2ngxM+TMqWoe+hvW
         d5Wg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version:content-transfer-encoding;
        bh=0Txfl3w3fyNWqxoQo0kheinkVsf2R4E3f1Pod9NIB+Q=;
        b=hHZnhQlcwdhLcmrsPIvBTL6fJNYsbhYCWvdLWGSNWE4Uk1x67TvaphDzjrq/iONQwj
         3jo79jliuxP0nQdl1VL7EMmdIVe58MyhHPEHRpCnBgcTJUj/U2mDsj6PtSmLK8zUMHga
         7xDBQ9EXHHhPuNiMtsuhFDuL5R+feMAyChHKsOE+am+q2NOQUXr2DYjLUc9SMo0mj+wf
         mov8LoIkipC3dye2dCYj7e26k01Odk01mHDwYyCT4s9AkXDL/SkmhlSLQDNF/jOIzEyp
         5QJBrlZp/ximj1tGp63+hNlpY/Lu3bj8I747kOIvFlhIo8hB5hFikpm3Xz8eU3R85vI/
         2Gyw==
X-Gm-Message-State: AOAM532Tnu73ha7jIREhRhyWGCNFSoR4lZY0v8ggb8YgBPq/h6MYmZpr
        3SMhsLuGAV7kJ6ADxRCN/JI=
X-Google-Smtp-Source: ABdhPJwvcB3PCveHPNDc0UV68tI7tL3E3UTQE3G50/l0tJ5gy/jeMtZ8OalDCwWBwwlVJqBb6rjzoQ==
X-Received: by 2002:a05:6402:2690:: with SMTP id w16mr5081227edd.220.1636423929657;
        Mon, 08 Nov 2021 18:12:09 -0800 (PST)
Received: from gmgdl (j120189.upc-j.chello.nl. [24.132.120.189])
        by smtp.gmail.com with ESMTPSA id cs15sm8962265ejc.31.2021.11.08.18.12.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Nov 2021 18:12:09 -0800 (PST)
Received: from avar by gmgdl with local (Exim 4.95)
        (envelope-from <avarab@gmail.com>)
        id 1mkGcK-001JSD-Rb;
        Tue, 09 Nov 2021 03:12:08 +0100
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Taylor Blau <me@ttaylorr.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        J Smith <dark.panda@gmail.com>
Subject: Re: [PATCH 4/8] grep.c: move "prefix" out of "struct grep_opt"
Date:   Tue, 09 Nov 2021 03:10:31 +0100
References: <cover-0.8-00000000000-20211106T210711Z-avarab@gmail.com>
 <patch-4.8-78298657d69-20211106T210711Z-avarab@gmail.com>
 <YYmO9xlgFGhQlFZg@nand.local>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.6.6
In-reply-to: <YYmO9xlgFGhQlFZg@nand.local>
Message-ID: <211109.865yt2dqmf.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Mon, Nov 08 2021, Taylor Blau wrote:

> On Sat, Nov 06, 2021 at 10:10:50PM +0100, =C3=86var Arnfj=C3=B6r=C3=B0 Bj=
armason wrote:
>> The "struct grep_opt" is a mixture of things that would be needed by
>> all callers of the grep.c API, and quite a few things that only the
>> builtin/grep.c needs.
>>
>> Since we got rid of "prefix_length" in the previous commit, let's move
>> the "prefix" variable over to "builtin/grep.c" where it's used. To do
>> this let's create a "struct grep_cmd_opt", which we'll have a pointer
>> to in a new "caller_priv" member in "struct grep_opt" (the existing
>> "priv" is used by the top-level "grep.c" itself).
>
> I'm definitely in favor of removing specialized, caller-specific bits
> from an internal API. But I'm not sure why grep.c needs to keep track o
> this new "caller_priv" field at all.
>
> Among the uses of `prefix` in builtin/grep.c, I see grep_source_name,
> and the call to run_pager(). Would it be more straightforward to pass
> down prefix from cmd_grep down to its use in grep_source_name?
>
> There are quite a few intermediary functions that we go through to get
> from cmd_grep() down to grep_source_name(). For instance, we could reach
> it through:
>
>     cmd_grep -> grep_tree -> grep_submodule -> grep_cache -> grep_oid ->
>     grep_source_name
>
> But passing prefix from cmd_grep down to grep_source_name without
> relying on the internals of grep.c seems like a good direction to me. I
> could even buy that (ab)using a static variable in builtin/grep.c to
> keep track of a constant prefix value would save you some plumbing
> (though I'd rather see the usage spelled out more explicitly).
>
> All of that is to say that I share your motivation for this patch and
> think that the direction is good, but I would have preferred to do it
> without the caller_priv variable (unless there is something that I am
> missing here).

Yes, that would make much more sense. I just had tunnel vision while
writing this, evidently. Yeah, just either passing it or using a static
variable in grep.c would make more sense.

Arguably we could even have it be read only (const char *const) and have
a global "the_prefix" or something, but it's probably not widely used
enough for that to make sense.




