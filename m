Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D09BCC433FE
	for <git@archiver.kernel.org>; Wed,  8 Sep 2021 10:57:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BC24861167
	for <git@archiver.kernel.org>; Wed,  8 Sep 2021 10:57:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351416AbhIHK6j (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 8 Sep 2021 06:58:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39416 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349357AbhIHK6f (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 8 Sep 2021 06:58:35 -0400
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E2D5C061757
        for <git@vger.kernel.org>; Wed,  8 Sep 2021 03:57:28 -0700 (PDT)
Received: by mail-ej1-x62c.google.com with SMTP id x11so3397224ejv.0
        for <git@vger.kernel.org>; Wed, 08 Sep 2021 03:57:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version;
        bh=X6qSMBktIKUCDYL8orIxp6xmcJEIz3Qhf9YFGLpAfJY=;
        b=Ae27jOsTDRP6+IXP7szspumXz0NnM/AHDQhbtn45ndV/QDZoP/oiRzmG4+4tT23qex
         5cMOSqMxYxNIvHNBCwzor8jgaVvz5XEQVq+RM6cZORxWerbDFUxnxTWD2OSeO8RD60Hy
         4UeESk9JL4sDcclNimQQyUJ+3pTm0YOzcQmWxKkqv5o3mShQKQz87B1SquRHbN4pDoIQ
         Olk07EpAkCJT24gsAFpbgTbW4kT/hQNykNFsUOI3L5QwkDJwYBLUVbUfd8hwnt9jel+L
         pTrTt0tf06PCDCXo/kXeIyNg8wNQGbfKMx0tALnqBmbtg70pyCu2bQb5RvWZM5VOZsjr
         M23A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version;
        bh=X6qSMBktIKUCDYL8orIxp6xmcJEIz3Qhf9YFGLpAfJY=;
        b=TmkUDUMilmngoWIxe5psO2N2eUb6GWR7G/Apn9l84HAsofzS2gfRwu30sag3Mm1K4F
         TOJjIvhOnE6gKi8QWctN1sTK43Bf26GEMyIoBuACfsMJ3GSH/GzEUIF8OaDbHJeZr/Pa
         P8TQzCWpndvtIhomJ1I0dCR/x8grVjydLdiu9mDgFDH94ooq9/y8Ywytn57ieHvstGFb
         1EcHsqWNl6yYUuGDK8/O97bNz4eM2sgi9ux9MZSBalT7HALqmIebGJrjjauU+Az3j8AO
         P1xLNiQHBZX9MEsEHKNtGSyUKFxk33kczky2ZrgsTTu3QwWyzQfUPXgW8NMJ42NK23lG
         9TxQ==
X-Gm-Message-State: AOAM532hxtvVEYYtiLOKSpRQ95j/V+rvBiZExBDSNb9rROgVVgyttFFv
        OTJTNhaDiAMB8BpXeztV1q8Kb+lleSevxQ==
X-Google-Smtp-Source: ABdhPJwO5SjnoUkFhf1pQmTxLIAce97CS8YBKxmBmkrp+llC5d8pB67AZdICQtuhLUNDWSDeXyz5Qg==
X-Received: by 2002:a17:907:2a51:: with SMTP id fe17mr3327609ejc.179.1631098646711;
        Wed, 08 Sep 2021 03:57:26 -0700 (PDT)
Received: from evledraar (j120189.upc-j.chello.nl. [24.132.120.189])
        by smtp.gmail.com with ESMTPSA id f22sm844303ejz.122.2021.09.08.03.57.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Sep 2021 03:57:26 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Colin Curtis <colinpcurtis@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH 0/2] Add cmd_gud and detect libiconv path for Mac OS
Date:   Wed, 08 Sep 2021 12:50:48 +0200
References: <20210908051340.13332-1-colinpcurtis826@ucla.edu>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.7.0
In-reply-to: <20210908051340.13332-1-colinpcurtis826@ucla.edu>
Message-ID: <871r5zibca.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Tue, Sep 07 2021, Colin Curtis wrote:

> From: Colin Curtis <colinpcurtis@gmail.com>
>
> The gud command opens the Pro Git book webpage in the default
> web browser.  The reason to add this command is due to the
> play on words when saying 'git gud', which sounds like 'get good'.
> Hence this command when invoked will open up the Pro Git 
> webpage to allow the user to 'get good' at git.

Purely in terms of implementation if we had this sort of thing it really
would belong in "git help", not in an overly cleverly named new
built-in.

More generally we don't link to git-scm.org now for anything
significant, AFAICT the only things we do link to are to our own
generated documentation.

[Not with my Git PLC hat on, in case anyone's wondering]

I don't think we should be further endorsing proprietary documentation
in liue of improving the free docs in git.git itself.

If this command (whether via "git help" or not) linked to anything it
should be to our own https://git-scm.com/docs/user-manual; if there's
things lacking there let's try to improve the freely available docs.

And purely in terms of UX once we had such freely available docs we
should not be opening a webpage to display them, but linking to a
manpage etc. Perhaps we should be opening a webpage, and indeed "git
help" can do that for you, but that should be to docs we have built
locally & are guaranteed to apply to the git version you're working
with.
