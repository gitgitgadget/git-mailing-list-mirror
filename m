Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 564D5C433B4
	for <git@archiver.kernel.org>; Tue, 18 May 2021 12:04:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 373DA610CD
	for <git@archiver.kernel.org>; Tue, 18 May 2021 12:04:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244863AbhERMF1 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 18 May 2021 08:05:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50050 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245222AbhERMFV (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 18 May 2021 08:05:21 -0400
Received: from mail-lf1-x129.google.com (mail-lf1-x129.google.com [IPv6:2a00:1450:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54511C061763
        for <git@vger.kernel.org>; Tue, 18 May 2021 05:04:03 -0700 (PDT)
Received: by mail-lf1-x129.google.com with SMTP id z13so13777316lft.1
        for <git@vger.kernel.org>; Tue, 18 May 2021 05:04:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=k3QRvyyHK7EHGZeeQIf1L6iJ+wrSpJJBUV129U1IER4=;
        b=hTh5Xhztgl6aEtft6J//WdqdNgNt65SzUFEua5kAemEsZfO3WTbQzFau3hwmQNX5Eo
         QB+OX487T4Js7zs5vbQV0+QRGpCawiTe7JRpzFPMx16kuxqddDkLM2wTakdCHCr0g86C
         H4WXuXYFMWgsqJP2/gvcTsvfIXN+kUr5byUNzqtmO1w+FBZd5a8oTjKvlD262gjwkUf4
         ZOphs42auoUgdL+GQo3dvX9VA2eHV1M6q1Bg9dbWKvRaeO9Rlkw/D7chd4SViqyxRWCI
         XVs0ybUzVjlGuFIVqe9vEy9iLCa4i+mJJyONoA8t1/UNW3agLjg7PNkFKleghhSOYfrp
         HqTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:date:in-reply-to
         :message-id:user-agent:mime-version;
        bh=k3QRvyyHK7EHGZeeQIf1L6iJ+wrSpJJBUV129U1IER4=;
        b=NDQBaBXlYE6wZEmJ9CbDPdEMrSRRQFYMQNLTHCajaxmBRLDDuaW982wTazzFm7Y19W
         RT/SndIWuYGg8pjF+VvKK0BtrBTY25jnGuznpTURsDEdLtB2bRzhdwS/bDxDy+RDe5EP
         QDXPtBdIuo1y1GCjHweAt17xsu7leZ1+ewYMs3QH8KqNqoS5xGHyrHM6cdC0JvISMk1K
         JD7CjfOFAMEyjX9lOBtsvjiOAPhSoaa2eOs54MQUUAc51rx48M9L6YqT3kEyfm7f8t+o
         vaxQSeq7EsPbOI6Gcsry8ZaAZ4hknkI+TBYEkt/CacyrEtvV2enqFaTdz1IxEutZG/aB
         LgCg==
X-Gm-Message-State: AOAM5323vQOgWH71xeFFiFwBpVOVp3U7/Ks5PolUSps6fL7Xg3pCViqo
        8hEGm6uNq68QgcdsN9vYy4F/ySvZlog=
X-Google-Smtp-Source: ABdhPJxskL0SOLEwxoqz95RPTqG/tQsRW5n1Qaitq4+2eVoDP0GE1LhxNglzv+mdJ9JOnC9RzWg9Fg==
X-Received: by 2002:a19:c209:: with SMTP id l9mr3910833lfc.137.1621339441349;
        Tue, 18 May 2021 05:04:01 -0700 (PDT)
Received: from osv.localdomain ([89.175.180.246])
        by smtp.gmail.com with ESMTPSA id i130sm2256976lfd.304.2021.05.18.05.03.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 May 2021 05:04:00 -0700 (PDT)
From:   Sergey Organov <sorganov@gmail.com>
To:     Bagas Sanjaya <bagasdotme@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Philip Oakley <philipoakley@iee.email>,
        Elijah Newren <newren@gmail.com>,
        Felipe Contreras <felipe.contreras@gmail.com>,
        =?utf-8?B?w4Z2YXIgQXJu?= =?utf-8?B?ZmrDtnLDsA==?= Bjarmason 
        <avarab@gmail.com>, Alex Henrie <alexhenrie24@gmail.com>,
        git@vger.kernel.org
Subject: Re: [PATCH v1 0/9] diff-merges: let -m imply -p
References: <CAMMLpeR-W35Qq6a343ifrxJ=mwBc_VcXZtVrBYDpJTySNBroFw@mail.gmail.com>
        <20210517155818.32224-1-sorganov@gmail.com>
        <321ca7e8-0ccb-20dd-e2de-2f3c2845e515@gmail.com>
Date:   Tue, 18 May 2021 15:03:59 +0300
In-Reply-To: <321ca7e8-0ccb-20dd-e2de-2f3c2845e515@gmail.com> (Bagas Sanjaya's
        message of "Tue, 18 May 2021 10:18:17 +0700")
Message-ID: <87eee4ckpc.fsf@osv.gnss.ru>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.0.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Bagas Sanjaya <bagasdotme@gmail.com> writes:

> On 17/05/21 22.58, Sergey Organov wrote:
>> Fix long standing inconsistency between -c/--cc that do imply -p, on
>> one side, and -m that did not imply -p, on the other side.
>> 
>
> The commas are unnecessary.
>
>> Only the last patch is the actual functional change. The reset of
>> patches are additional tests and refactorings that are not expected to
>> alter existing behaviors.
>> 
>
> Oops, s/reset/rest/.
>
>> After these patches
>>    git log -m
>> will start to produce diffs without need to provide -p as well, that
>> improves both consistency and usability. It gets even more useful if
>> one sets "log.diffMerges" configuration variable to "first-parent" to
>> force -m produce usual diff with respect to first parent only.
>> 
>
> Better say "After this patch series, git log -m produces diffs (implies
> -p)".
>
>> These patches don't change behavior when specific diff format is
>> explicitly provided on the command-line, so that commands like
>>    git log -m --raw
>>    git log -m --stat
>> are not affected.
>> 
>
> Better say "This series, however, don't change behavior...".
>
>> Exact historical semantics of -m is still provided by
>> --diff-merges=separate.
>> 
>
> Better say "Previously, the -m semantics is same as
> --diff-merges=separate".

Agreed, will fix, thanks!

-- Sergey Organov
