Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6C67C433EF
	for <git@archiver.kernel.org>; Tue,  5 Oct 2021 16:02:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B30A961215
	for <git@archiver.kernel.org>; Tue,  5 Oct 2021 16:02:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234282AbhJEQEi (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 5 Oct 2021 12:04:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39718 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231513AbhJEQEh (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 5 Oct 2021 12:04:37 -0400
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8677C061749
        for <git@vger.kernel.org>; Tue,  5 Oct 2021 09:02:46 -0700 (PDT)
Received: by mail-ed1-x52f.google.com with SMTP id p13so764758edw.0
        for <git@vger.kernel.org>; Tue, 05 Oct 2021 09:02:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version;
        bh=FWhAB44Vcz3ckqtXEIbHN5hvj+CTheRY/QW/kadTXeQ=;
        b=TyFxpUtLEU1iE4ihz5L7j89wWzkUbPWIElgkqVbdZBGDYnsR9D7zpC3rVubCZ+ZHoj
         pcejwQ2HSrVmAb542ihVhoZLML9JCFyg2lW2nXJ12YKQk1GvSaQ7pKRfM0fo4RXNwNWV
         SXbwVxzsRZjvFKEYTv+yZ6YZU1seaet+dCBN/f1sJayTVhC6xTLXgJ6uVE3ea0UzLs2v
         RIX299pPjyqFgeWGIR9RPal9G4rVVsd9gB3lfgU+pvMAWuFYcLXdNO1bcYOf/H9rYXAZ
         42dYLU0c2uIhPh3+8ZmPiqK/Y9wRxFrQ0t1zWeOAf4N7T9owz69b2lvgYhsp77tiT++F
         OYwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version;
        bh=FWhAB44Vcz3ckqtXEIbHN5hvj+CTheRY/QW/kadTXeQ=;
        b=rM/JqlpfOQxS9RyJCDbpG29nT5iT/u8du1NTqMt43xgZ5ZbghdVq0hVV0FV4BTpLCO
         MQ3OmcVieW3nnzDSWfUqPqU4jH1ngeEpgdD/R8ih09/4PdLlv5JBRfp7BZ+xTrrxInSp
         lU5pYH7kjeGbsDWzlwZCvhADfSc3Dh/hWRk8HZcuay6JbrqVe70u/bYEP6SO/eXPSJ1R
         MWsUytu2uH3374yLbp9rdkGYIEqM8hs/ZjLClFNFT96vUPbw7uXUpL70FRlWZ7BNX+Jr
         wnz8saihB7B/4yOEDCgDcCLz4tpPuQ7wwweOeQHtgMIItPckoBRRLo3ZAB5eH57MlAhV
         DNGw==
X-Gm-Message-State: AOAM5321l1MWtaZYPg2b+V8h+ChsR8AwSNG0r6tztMfgcIQUuswwsJ/U
        2cMC1TppyP8WG8LZapkI2FenpTBL0A0=
X-Google-Smtp-Source: ABdhPJwFnhi5ilYBGgrdwI4fx5vSWLVi9aM1MK85qSp70wYRan+S2RSXTbmNZy/XPmIw3tU4dg8wXw==
X-Received: by 2002:a17:906:4cc1:: with SMTP id q1mr24648388ejt.415.1633449765409;
        Tue, 05 Oct 2021 09:02:45 -0700 (PDT)
Received: from evledraar (j120189.upc-j.chello.nl. [24.132.120.189])
        by smtp.gmail.com with ESMTPSA id h8sm8174379ejj.22.2021.10.05.09.02.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Oct 2021 09:02:45 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org
Subject: ab/refs-errno-cleanup
Date:   Tue, 05 Oct 2021 18:01:47 +0200
References: <xmqqo884tkxd.fsf@gitster.g>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.7.0
In-reply-to: <xmqqo884tkxd.fsf@gitster.g>
Message-ID: <87zgrnjw7v.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Mon, Oct 04 2021, Junio C Hamano wrote:

> * ab/refs-errno-cleanup (2021-08-25) 4 commits
>  - refs: make errno output explicit for refs_resolve_ref_unsafe
>  - refs: explicitly return failure_errno from parse_loose_ref_contents
>  - branch tests: test for errno propagating on failing read
>  - refs: add failure_errno to refs_read_raw_ref() signature
>
>  The "remainder" of hn/refs-errno-cleanup topic.
>
>  What's the status of this one?  Meh?

Still-current commentary at "B" here:
<87ee94rdq7.fsf@evledraar.gmail.com>
(https://lore.kernel.org/git/87ee94rdq7.fsf@evledraar.gmail.com).
