Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A172FC63797
	for <git@archiver.kernel.org>; Tue, 17 Jan 2023 15:14:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232108AbjAQPOG (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 17 Jan 2023 10:14:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51282 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233959AbjAQPNr (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 17 Jan 2023 10:13:47 -0500
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 26FD8305D5
        for <git@vger.kernel.org>; Tue, 17 Jan 2023 07:13:47 -0800 (PST)
Received: by mail-pj1-x1029.google.com with SMTP id dw9so31266663pjb.5
        for <git@vger.kernel.org>; Tue, 17 Jan 2023 07:13:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:user-agent:message-id
         :in-reply-to:date:references:subject:cc:to:from:sender:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bnedNo7vK7hN2m1Q/k3HWbeGVF67BcIrFghM/v5AHqs=;
        b=RXbDd57Z/B2oLM5ZGkr6ouiqWHKsSbo07dPIjtmThrOhYBOAaDOVhm1f5AlqfrXOkp
         7dFUR8ab8qXl/IuV8TssvYR6viFMw8XSzKREDO3w+kYKwNOS95h0uSjwZX2Lj9WAzWiO
         wNia9rzdG972Z4v/TLmFXgTKoeJN9KQ0+4CpMSOfMtQdGKoyKlAt142IbzuYhvkN08t9
         Oc46dGKUkpV5NJ2CPaSje1Nv7qt62zj5SOcDaPq0SE/yRPRNa2l27J02Of/ve6SLpuBI
         Mfbpzv0QvoWVdFSg3hUtdC9wnGtEGJzwmIkdbBSOICFAyD05dP0Vch6ElBSIWtQA4c+X
         fRaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:user-agent:message-id
         :in-reply-to:date:references:subject:cc:to:from:sender
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=bnedNo7vK7hN2m1Q/k3HWbeGVF67BcIrFghM/v5AHqs=;
        b=N8eVovbB85RAGTwzz1BvemICrXB4XBsCE26isv4SwTEi5wjcqjJ6Es8ltJKLqf2ywK
         ksgswqwrFz8MfS1ySSdkHKdtdiyb4pnk5oUeLEjVdlQzVuEMy4bp3r9DR9GICjrT9jFy
         vvORCiG+gCUcGn6/oJDTbUvVQt1lTR3EpVhCOHSNvegQlcMpKfESGhP2hR6Z+krgFw1v
         WPwcXHhAeaW6/ky3AQp0zk/esjl4oJZjBA+gBq1bmQ4wPch7p9vjkrE2O2TSs1WNNu1A
         SogN2ud5s8ZQTC5p1zrD4LjZXkSNjfZ61rdgsNJ66G07TsIMwTyqhGaC3eaClLX01nry
         a5rg==
X-Gm-Message-State: AFqh2korlR4uDnrQbMnILniqeWrkYrHootC2SWMN+8ilUzF5aZ4O9ZsC
        oO2IA3Ctn8N+zXB2t6AVQXM=
X-Google-Smtp-Source: AMrXdXtD6YupOHfaWOPhmvP09KtrRDWLueB0H6q7FK1wshqMzeE0Fw8J9lNcihhus/FU/LLsnlI/Xg==
X-Received: by 2002:a17:902:d506:b0:193:2fdb:db07 with SMTP id b6-20020a170902d50600b001932fdbdb07mr5314123plg.43.1673968426486;
        Tue, 17 Jan 2023 07:13:46 -0800 (PST)
Received: from localhost (33.5.83.34.bc.googleusercontent.com. [34.83.5.33])
        by smtp.gmail.com with ESMTPSA id o8-20020a170902d4c800b001948af092d0sm5098619plg.152.2023.01.17.07.13.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Jan 2023 07:13:46 -0800 (PST)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     "Strawbridge, Michael" <Michael.Strawbridge@amd.com>,
        "git@vger.kernel.org" <git@vger.kernel.org>,
        "Tuikov, Luben" <Luben.Tuikov@amd.com>
Subject: Re: [PATCH v5 1/2] send-email: refactor header generation functions
References: <20230110211452.2568535-1-michael.strawbridge@amd.com>
        <20230110211452.2568535-2-michael.strawbridge@amd.com>
        <230117.86wn5lxpl0.gmgdl@evledraar.gmail.com>
Date:   Tue, 17 Jan 2023 07:13:45 -0800
In-Reply-To: <230117.86wn5lxpl0.gmgdl@evledraar.gmail.com> (=?utf-8?B?IsOG?=
 =?utf-8?B?dmFyIEFybmZqw7Zyw7A=?=
        Bjarmason"'s message of "Tue, 17 Jan 2023 14:20:58 +0100")
Message-ID: <xmqqv8l59ot2.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Ævar Arnfjörð Bjarmason <avarab@gmail.com> writes:

>> +sub send_message {
>> +	my ($recipients_ref, $to, $date, $gitversion, $cc, $ccline, $header) = gen_header();
>
> This makes the diff smaller, but if we're refactoring these functions to
> return arguments it's probably better to return a hash reference rather
> than remembering all the parameter names.
>
> But in this case it's probably fine...
> ...
>> +sub pre_process_file {
>> +	my ($t, $quiet) = @_;
>
> This, I think, is an anti-pattern in this file. We can just read the
> "$quiet" and other things that we set up when we parse the parameters as
> globals, we don't need to pass them as named parameters.
>
> It doesn't help readability to shadow that variable with another lexical
> here below:
> ...

Thanks as usual for a careful review, with concrete suggestions for
improvements.

