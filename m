Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3084EC4332F
	for <git@archiver.kernel.org>; Wed, 23 Nov 2022 01:22:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233984AbiKWBWO (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 22 Nov 2022 20:22:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60560 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234403AbiKWBVr (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 22 Nov 2022 20:21:47 -0500
Received: from mail-pf1-x433.google.com (mail-pf1-x433.google.com [IPv6:2607:f8b0:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E38DD23B
        for <git@vger.kernel.org>; Tue, 22 Nov 2022 17:21:46 -0800 (PST)
Received: by mail-pf1-x433.google.com with SMTP id v28so15960124pfi.12
        for <git@vger.kernel.org>; Tue, 22 Nov 2022 17:21:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=7PhLoJGhQtVA4Fle4Z7o7FmcDWtx34+Y9mvFcHzcgUQ=;
        b=mNQ/GX/4UR8WkW1Ln459905jdAQ/l1JtmgP5bHNwaXxlO86CheOAKnpy/tmQcFvMU9
         +vOkQfoyWfK0dfHXLF/u1kViMeqcZf3ZkXUOc2IlesEgA13y7WDVpSxMyW1EpRSRkbHh
         klNxWQjNg+gwQ/ejjdHjWT6YPI80FSXr1tQD9xV0/2aG0LOiU1aEqqPYXKBwJqGnOU59
         WPt6A6or4YEmilTluOISnCrMXrn5XIkunLcwv4suTUwz7bbcEidSIF047J2Iv8Qe8fms
         ie2fnu1zMeTM+DjU6Bxg33iOOZm6EFt0uRZu45rQaaN2nkGc80Me1szYvzl5rFOqYFCr
         o54A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=7PhLoJGhQtVA4Fle4Z7o7FmcDWtx34+Y9mvFcHzcgUQ=;
        b=JqXrgFxnVZAaQvRPssA9wk67E9NLAdhWvUBtOaGMftL69zuvFFN5Mibykg6WB2sjD6
         70cGeD7ceGuMl///5Yr8vXCGO3UK8biL20JgwZJcykMYf9q3x9LNBH3y5T09FzGYyHhL
         acp3pUFBNheuz9/Ng/VbKKnmKN7r5zt/0rb9/ITRunvpMH7bM9SZqXg/gri8TeYQ3qcX
         FxMevDXP5/bk9a6vQ66LNUVu7etHAnoLU7JUUbwu/o/pPMn7q/y4luMmqFMopAmczlJa
         WBxNf1H3hMvz6mns/0BC+N6FWOV1Atoei8v6ePoP1hQb3LdxcrWltpagmRlFGEcF1yVf
         0m3w==
X-Gm-Message-State: ANoB5pkWQfqbRQyCLgLGkhC7CcTuzVTu9vXNJCRYigidkxMaWytFtXTo
        AyW04ATeHg7Bmr0lXSJFKlQ=
X-Google-Smtp-Source: AA0mqf6n6N+UG7lAeW2ASIqnr1tFiEw6VpXY0jk1+F0kOXDPfonF+4/TGNOnZ1Nb1NGVDqnqgFQuPg==
X-Received: by 2002:a63:4944:0:b0:46f:ec9f:dcb0 with SMTP id y4-20020a634944000000b0046fec9fdcb0mr8276801pgk.202.1669166506398;
        Tue, 22 Nov 2022 17:21:46 -0800 (PST)
Received: from localhost (33.5.83.34.bc.googleusercontent.com. [34.83.5.33])
        by smtp.gmail.com with ESMTPSA id c9-20020a170902c1c900b00177f4ef7970sm12667213plc.11.2022.11.22.17.21.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Nov 2022 17:21:46 -0800 (PST)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     Eric Sunshine <sunshine@sunshineco.com>
Cc:     Andreas Hasenack via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org,
        Andreas Hasenack <andreas.hasenack@canonical.com>
Subject: Re: [PATCH] chainlint.pl: fix /proc/cpuinfo regexp
References: <pull.1385.git.git.1669148861635.gitgitgadget@gmail.com>
        <CAPig+cQ6_7wf6C280Rqi7mcTCiQp-n5GiLWTPazfcUcGFeZi0g@mail.gmail.com>
Date:   Wed, 23 Nov 2022 10:21:45 +0900
In-Reply-To: <CAPig+cQ6_7wf6C280Rqi7mcTCiQp-n5GiLWTPazfcUcGFeZi0g@mail.gmail.com>
        (Eric Sunshine's message of "Tue, 22 Nov 2022 15:57:55 -0500")
Message-ID: <xmqqsfiao47q.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Eric Sunshine <sunshine@sunshineco.com> writes:

> Makes sense. Well explained.
>
> A separate problem is that chainlint.pl doesn't fall back to a
> sensible non-zero value if ncores() returns 0 (or some other nonsense
> value). That is, of course, outside the scope of the well-focused
> problem fix which this standalone patch addresses. I may end up
> submitting a fix separately to make it fall back sensibly.
> ...
> As mentioned elsewhere[1], this code may eventually be dropped
> altogether, but this fix is good to have in the meantime. Thanks.

Thanks, both.  Will apply.
