Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4DCCBC433E9
	for <git@archiver.kernel.org>; Wed, 17 Mar 2021 13:48:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0457064F69
	for <git@archiver.kernel.org>; Wed, 17 Mar 2021 13:48:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231423AbhCQNr4 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 17 Mar 2021 09:47:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45970 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231411AbhCQNrp (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 17 Mar 2021 09:47:45 -0400
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com [IPv6:2a00:1450:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA40BC06174A
        for <git@vger.kernel.org>; Wed, 17 Mar 2021 06:47:44 -0700 (PDT)
Received: by mail-ej1-x62b.google.com with SMTP id lr13so2697039ejb.8
        for <git@vger.kernel.org>; Wed, 17 Mar 2021 06:47:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version:content-transfer-encoding;
        bh=Hs2Fm0mgCwXAoZBLp3FZ99t9RZY6nVH8o1ABK1SDf9E=;
        b=HjRav6MkQz/JILlQnjqD4eXPsPF0mM4fi6pp8+M1aPlPL4/oizLfQKa+ucIJAtCOSI
         b+enVIjayeKVdcpOpvROzXTrY7aIoqBqgOgN/K9WjQbqO5hYEGcWJPy6omF7lZKMUocM
         Wch9goE2K/0JbPa/VGYmCUfxj56zHlKjVakdwkH1QAuEYeAmftpjNu06Oy/lBPQGB1L4
         gb83xvskw4BfSjLvhrWQBhcnw4YQK8ait18ADq81cahagJG9UMxvbFge7QZpiO/AWZdM
         POWR7//q21jqywMY4CxyH3Ufh/7nIwcV1Nc4NietbikmnOY7OsOSudGFiVB0dEmF6MZr
         Ky0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
        bh=Hs2Fm0mgCwXAoZBLp3FZ99t9RZY6nVH8o1ABK1SDf9E=;
        b=LYzD//5WPG2XJtmctPQbsrUmFq1Ror+M82O9LkQTt2a/TwKigmI/UBgmeDJhEep7Po
         F6/hifgRU+V0K166J1LIu4N9HRc/6LSv97ZTkeSFbjX2WqCzWfoiyKvaz2qq3joNUC7M
         Fzx+h5/ncA9O3ITFyngeojEukSpBaHBkmC+ITBpHsQ3Jvq6mmLRSOrPdkt1C0/1pgP60
         NLJWnUXFaINwKUqfpasIWVw3X4l3RO0IIieYx1VMLRJQFs2wVGrPqz3g8FLj1mFp8Enj
         HqiSj3ewtHy+81hXTlB+HK/WMlXSXuqtbyJCQyivW43pgWDcfZdSdzyPBUfiVEIC6T3m
         L8ZA==
X-Gm-Message-State: AOAM5316J0KTPU8QnZrj6pEftJCkbYvUJDWe5hAxis73uFeuZ3d/waS5
        HTcvbfUIpJvYd//dZFnHiH4=
X-Google-Smtp-Source: ABdhPJxNm+zN6NW0iP3hyi7cFV5A6+MlmRdVcohycClfbh2Dju+SZ+YUWlZgCUNKwIQUU64AaqSV6A==
X-Received: by 2002:a17:906:dbd0:: with SMTP id yc16mr35527121ejb.71.1615988863602;
        Wed, 17 Mar 2021 06:47:43 -0700 (PDT)
Received: from evledraar (j57224.upc-j.chello.nl. [24.132.57.224])
        by smtp.gmail.com with ESMTPSA id lk12sm11482326ejb.14.2021.03.17.06.47.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Mar 2021 06:47:43 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Derrick Stolee <stolee@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Jeff King <peff@peff.net>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Jonathan Tan <jonathantanmy@google.com>
Subject: Re: [PATCH v4 22/22] fetch-pack: use new fsck API to printing
 dangling submodules
References: <20210306110439.27694-1-avarab@gmail.com>
 <20210316161738.30254-23-avarab@gmail.com>
 <72b6e263-1e53-cc00-9545-cddd11820fe4@gmail.com>
User-agent: Debian GNU/Linux bullseye/sid; Emacs 27.1; mu4e 1.4.15
In-reply-to: <72b6e263-1e53-cc00-9545-cddd11820fe4@gmail.com>
Date:   Wed, 17 Mar 2021 14:47:42 +0100
Message-ID: <87tup9zybl.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Tue, Mar 16 2021, Derrick Stolee wrote:

> On 3/16/2021 12:17 PM, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason wrote:
>> Refactor the check added in 5476e1efde (fetch-pack: print and use
>> dangling .gitmodules, 2021-02-22) to make use of us now passing the
>> "msg_id" to the user defined "error_func". We can now compare against
>> the FSCK_MSG_GITMODULES_MISSING instead of parsing the generated
>> message.
>>=20
>> Let's also replace register_found_gitmodules() with directly
>> manipulating the "gitmodules_found" member. A recent commit moved it
>> into "fsck_options" so we could do this here.
>>=20
>> Add a fsck-cb.c file similar to parse-options-cb.c, the alternative
>> would be to either define this directly in fsck.c as a public API, or
>> to create some library shared by fetch-pack.c ad builtin/index-pack.
>>=20
>> I expect that there won't be many of these fsck utility functions in
>> the future, so just having a single fsck-cb.c makes sense.
>
> I'm not convinced that having a single cb function merits its
> own file. But, if you expect this pattern to be expanded a
> couple more times, then I would say it is worth it. Do you have
> such plans?

Not really, well. Vague ones, but nothing I have even local patches for.

It just seemed odd to stick random callback functions shared by related
programs into fsck.h's interface, but I guess with
FSCK_OPTIONS_MISSING_GITMODULES I already did that.

Do you suggest just putting it into fsck.c?
