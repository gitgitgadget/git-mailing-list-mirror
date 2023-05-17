Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5012AC77B75
	for <git@archiver.kernel.org>; Wed, 17 May 2023 21:48:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229635AbjEQVsu (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 17 May 2023 17:48:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48438 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229647AbjEQVsr (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 17 May 2023 17:48:47 -0400
Received: from mail-pl1-x634.google.com (mail-pl1-x634.google.com [IPv6:2607:f8b0:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD8F16EA7
        for <git@vger.kernel.org>; Wed, 17 May 2023 14:48:40 -0700 (PDT)
Received: by mail-pl1-x634.google.com with SMTP id d9443c01a7336-1ae452c2777so4032065ad.0
        for <git@vger.kernel.org>; Wed, 17 May 2023 14:48:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1684360120; x=1686952120;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Ny9fIA+ta0vWAlX/sj8/Obdc0ZBZBI8LR2NxAK8HA0Q=;
        b=FY2Afm3JwciPcdDc6bhMYRXoQCr2ehJGoO/9MpkvcdryODna2Ak+tsApAHRNhA0uaB
         xjl+51xDY37PsyMs57uoZmxl/KDNTodBA+xkAWmd+ZRQ9KPzBDwfhQTI/E11FQ0e+UQU
         k1Se6YuWixMwhxmZF/NWstyYJDzGyqt0E82iaIivvqJ4q1cFeVBHHgDzHGhugXq61bXP
         GvPBvni/IUqGIZ3DrOLPQ4r21H+bSwYw1UfnitG+StKOafHyvMrgW7JCb2FeFfvUlNTM
         jHnQgarbwxUuA+nTIwX8YjvPWoksdJrg1/mxTKLU2sk8so9ZMeurTMGNpVgI0c2J3CqP
         qz3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684360120; x=1686952120;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=Ny9fIA+ta0vWAlX/sj8/Obdc0ZBZBI8LR2NxAK8HA0Q=;
        b=BA5Y/GyP1TIQGLdtA40KZtWkdPlSOtDV2xFdlr7a7k3o9IPRVlsLowg4rJ4iNrVfdu
         m7E+tHwCupBayCSHn47lCc3I1ngJQBfkHtlRkmmIuamnkYRQSyqhEMIybG5YRHOLdd0p
         8c4LIvW55f+hxOrVXcJFrQmfUnRUybiqIYInwObDBNyLSejABy2qkk0JUULQdlkC4yX9
         3y+XD3PpJYMgQiCRcEOE8axANvapNt+JznmUjCA5vgtA16kPUEHWwgrNYQykXxxBFRiJ
         0bZLv7pZROaIBdPMGqklf+N2YwlWbyPDzP32lvXy5fa8wZg+ZR8eAnpP+l0cIE2avEmQ
         ID+w==
X-Gm-Message-State: AC+VfDw6PFstZNttxBW2T2y4eZNBZyEwphDK9zv1XZGiAj4+5vLktjWU
        kmGn4r2lkUGuDCPfPzexgpAUAx82Xw8=
X-Google-Smtp-Source: ACHHUZ6sva6EvX4k6dnupfHLjwzDJaHW+78bbjvZPwVxg4n7yTtT4ORQW9dRM7Ppu1rejDyx35hf8Q==
X-Received: by 2002:a17:903:2287:b0:1ad:ea13:1914 with SMTP id b7-20020a170903228700b001adea131914mr24262plh.30.1684360120107;
        Wed, 17 May 2023 14:48:40 -0700 (PDT)
Received: from localhost (187.137.203.35.bc.googleusercontent.com. [35.203.137.187])
        by smtp.gmail.com with ESMTPSA id d12-20020a170902cecc00b001a6f7744a27sm18104999plg.87.2023.05.17.14.48.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 May 2023 14:48:39 -0700 (PDT)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     "brian m. carlson" <sandals@crustytoothpaste.net>
Cc:     <git@vger.kernel.org>, Jeff King <peff@peff.net>,
        Adam Majer <adamm@zombino.com>
Subject: Re: [PATCH v3 0/1] Fix empty SHA-256 clones with v0 and v1
References: <ZEmMUFR7AJn+v7jV@tapette.crustytoothpaste.net>
        <20230517192443.1149190-1-sandals@crustytoothpaste.net>
Date:   Wed, 17 May 2023 14:48:39 -0700
In-Reply-To: <20230517192443.1149190-1-sandals@crustytoothpaste.net> (brian
        m. carlson's message of "Wed, 17 May 2023 19:24:42 +0000")
Message-ID: <xmqqv8gqoci0.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"brian m. carlson" <sandals@crustytoothpaste.net> writes:

> We recently fixed empty clones with SHA-256 over protocol v2 by
> honouring the hash algorithm specified even when no refs are present.
> However, in doing so, we made it impossible to set up a v0 or v1
> repository by cloning from an empty SHA-256 repository.  In doing so, we
> also broke the Git LFS testsuite for SHA-256 repositories.
>
> This series introduces the dummy `capabilities^{}` entry for fetches and
> clones from an empty repository for v0 and v1, just as we do for clones.
> This is already supported by older versions of Git, as well as libgit2,
> dulwich, and JGit.
>
> Changes since v2:
> * Move advertisement of fake capabilities ref to a separate function to
>   avoid an extra strcmp.

We want this in -rc2 if not -rc1 for the upcoming release, right?
I've read the patch again and it all looked sensible.

Thanks.


> Changes since v1:
> * Drop patch to honour GIT_DEFAULT_HASH
> * Support all requests, not just HTTP.
> * Add more tests.
> * Fix NULL pointer dereference.
>
> brian m. carlson (1):
>   upload-pack: advertise capabilities when cloning empty repos
>
>  t/t5551-http-fetch-smart.sh | 27 +++++++++++++++++++++++++++
>  t/t5700-protocol-v1.sh      | 31 +++++++++++++++++++++++++++++--
>  upload-pack.c               | 22 +++++++++++++++++-----
>  3 files changed, 73 insertions(+), 7 deletions(-)
