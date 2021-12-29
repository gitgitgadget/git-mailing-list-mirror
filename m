Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CFEC4C4332F
	for <git@archiver.kernel.org>; Wed, 29 Dec 2021 02:13:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238339AbhL2CNa (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 28 Dec 2021 21:13:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42958 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238317AbhL2CNa (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 28 Dec 2021 21:13:30 -0500
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D8385C061574
        for <git@vger.kernel.org>; Tue, 28 Dec 2021 18:13:29 -0800 (PST)
Received: by mail-ed1-x535.google.com with SMTP id z9so10666273edm.10
        for <git@vger.kernel.org>; Tue, 28 Dec 2021 18:13:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version:content-transfer-encoding;
        bh=Ax+UOXaNl3Ouy5Azl10qIadwdiyg51ZdX6mha2fUFk8=;
        b=SWN4EQwDotfFbjuHLTfuyFLedFYF5y8GiuR1VQ5YU+4hGzAx2bAtJbyX8sVXO2q32T
         eYVwEGdnMmwYzsrJEpJHs61Mbq62IdByD6sYnpuBOi/qrDCf9LQ5cfpi03rN1FgrN2Bz
         u4N94h39VVfbU0TsQFze1jEi2rY/XhA1YKQceKqePsi4g/4G9pBifdfL5i+poV0siJh4
         xG3h83PLd1B6b4dR1njK9lkerw6seI1CXeR/Rpa7G1xmUXS7XGjDF4wyUW7/QVXoc90k
         BdD92R8lf6HMbg6snKLVhraGlNHo++BAUp9Vsrz2yLR/WKoRUhDffPpO0GtcCM4QKAzM
         sNhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version:content-transfer-encoding;
        bh=Ax+UOXaNl3Ouy5Azl10qIadwdiyg51ZdX6mha2fUFk8=;
        b=8QAa/kuaREyfaHhGyrD0k5AmuIxr9KpEwAo6vGuFHWefl6TRmT3BrBJL+6RlTuscHi
         od52+M/347SU9smAwq/Ct8wOQfkVbu0S7UG4GvJ6utxsyZEhRcbKexLJeAaIu/NPkEQj
         kerdcfSVULKG0+oGzCSANrGGspIMvIsyM9JaPHZGdIwQZURLYmuFXceqbgJOPW5PQiT5
         9MSo6MH19G4nIBPble2JExcaCpymHcnMMSs7Tt44UxQP+QgS4nUWrBmMQJN+cE2erT7w
         64ewB+CnXtOMIw8lKy/sUdQ9nu7BzDy3IsqwiFfeCRGQ1WVMiNI744qpppfY6l/6J7sM
         KfhQ==
X-Gm-Message-State: AOAM531GMcGwPdQx6++8Ls0FSObHrSNllI/H+3hWcp/OrxQSe0Jme/N1
        pfvsulSYu+W4IMUaZnuaPIzBkfKgTdwNUF9r
X-Google-Smtp-Source: ABdhPJyqdV7nRAEzkxMOftNMf1Ut9nOClRs2C3e4sTOR9zX29HEHR8k5F+4kX+44UZRQCGbTnr6WjQ==
X-Received: by 2002:a17:907:6da2:: with SMTP id sb34mr19302493ejc.309.1640744008069;
        Tue, 28 Dec 2021 18:13:28 -0800 (PST)
Received: from gmgdl (157-157-127-103.dsl.dynamic.simnet.is. [157.157.127.103])
        by smtp.gmail.com with ESMTPSA id hq17sm6519835ejc.10.2021.12.28.18.13.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Dec 2021 18:13:27 -0800 (PST)
Received: from avar by gmgdl with local (Exim 4.95)
        (envelope-from <avarab@gmail.com>)
        id 1n2OT1-000Iea-30;
        Wed, 29 Dec 2021 03:13:27 +0100
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Jeff Hostetler via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Jeff Hostetler <git@jeffhostetler.com>,
        Derrick Stolee <stolee@gmail.com>,
        Matheus Tavares <matheus.bernardino@usp.br>,
        Johannes Sixt <j6t@kdbg.org>,
        Jeff Hostetler <jeffhost@microsoft.com>
Subject: Re: [PATCH v2 0/9] Trace2 stopwatch timers and global counters
Date:   Wed, 29 Dec 2021 02:54:29 +0100
References: <pull.1099.git.1640012469.gitgitgadget@gmail.com>
 <pull.1099.v2.git.1640720202.gitgitgadget@gmail.com>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.6.10
In-reply-to: <pull.1099.v2.git.1640720202.gitgitgadget@gmail.com>
Message-ID: <211229.86ee5wgnug.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Tue, Dec 28 2021, Jeff Hostetler via GitGitGadget wrote:

I left some other comments on the series inline, just on the notes in
the CL:

>  * =C3=86var proposed a large refactor of the "_perf" target to have a "f=
mt()"
>    varargs function to reduce the amount of copy-n-pasted code in many of
>    the "fn" event handlers. This looks like a good change based on the
>    mockup but is a large refactor.

FWIW what I meant with [1] was not that this series needed to take the
detour of refactoring trace2/tr2_tgt_perf.c to use such a helper, but
that for the function additions in this series it might make sense to
introduce one and use it for the new functions.

For this series I think it's probably not worth it, so I'm fine with
leaving this for some other time. Just pointing out that rather than
your reading of:

 1. We have some refactorable verbosity
 2. Refactor all callers
 3. Change existing code to use that refactoring
 4. Add new code to use the refactoring

It's also perfectly fine to do just:

 1. We have some refactorable verbosity
 2. Introduce a less verbose
 3. Add new code to use the helper

And leave the "refactor all callers" for some other time.

Anyway, I think for the two callers just leaving it entirely for this
series is the right thing to do. It was more of a "hrm, that's some odd
and avoidable verbosity..." comment on me read-through of v1.

1. https://lore.kernel.org/git/211220.86czlrurm6.gmgdl@evledraar.gmail.com/

>  * =C3=86var proposed a new rationale for when/why we change the "_event"=
 version
>    number. That text can be added to the design document independently.

Hrm, no. In [1] I linked to some earlier musings of mine about what we
should do about the TR2_EVENT_VERSION (mainly as an FYI since you added
it, but hadn't commented on that post).

But my main comment there was that the series wasn't progressing as
atomic changes. I.e. we promise to change the TR2_EVENT_VERSION version
every time we change the event format, but v1 first changed the format
and bumped the version, then made some more changes.

I think that's probably fine per-se within a git release cycle, but it
might be a symtom of commits that could be split up to be more atomic (I
don't know, didn't look in detail).

However, in this v2 of the series the TR2_EVENT_VERSION bump is entirely
gone.

Maybe that means that you so vehemently agree with my proposal in [1] it
that you'd like to start taking that view for trace2 changes right away
:-)

For me it's fine either way, I think TR2_EVENT_VERSION probably isn't
that important.

But if that's the case it should probably be called out more explictly
in the CL/commit. I.e. even if our "policy" (such as it is) about
TR2_EVENT_VERSION currently says X we're going to start doing Y here
intentionally.

And in that case I should probably turn that suggestion in [1] into a an
actual PATCH sooner than later...

1. https://lore.kernel.org/git/211220.86czlrurm6.gmgdl@evledraar.gmail.com/
