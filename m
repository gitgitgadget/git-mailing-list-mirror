Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1336C48BCD
	for <git@archiver.kernel.org>; Wed,  9 Jun 2021 15:51:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B1C0C60FEB
	for <git@archiver.kernel.org>; Wed,  9 Jun 2021 15:51:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237368AbhFIPxu (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 9 Jun 2021 11:53:50 -0400
Received: from mail-ot1-f43.google.com ([209.85.210.43]:41965 "EHLO
        mail-ot1-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237311AbhFIPxt (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 9 Jun 2021 11:53:49 -0400
Received: by mail-ot1-f43.google.com with SMTP id 36-20020a9d0ba70000b02902e0a0a8fe36so24381182oth.8
        for <git@vger.kernel.org>; Wed, 09 Jun 2021 08:51:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:message-id:in-reply-to:references:subject
         :mime-version:content-transfer-encoding;
        bh=zIA3vGOTOORuk47wHvXbbgxpTEcpFqdShgju8D7etTU=;
        b=eg7Hzbmawx0938lc2Ig63vpKNxLfgWqRzfVcsgEX3ji0KBleZ5OmPSPLuz+LwPZ0VB
         FQQaYK+RrGDmtttFfbTM12XPxLcykgFLvHvUNSk+H57Dt2gJmAcNk124ypgdf0GA6nqi
         P2uh+MYnapgg1glfsrCLV8fqhgCyQ9JjnG8ffxbvWf3ATGeCWmygaXkzNwCbnZLRJuvA
         x7QtYIIdPdYG0PFNS47STe/qggN6FuU71XDCeqeSdekh0SVh+6VSZjFgbTjXcxb2Pc1N
         Mv/3TRn+psk49rNxfGYmlQpIGQi13s+BMxxIjv/jje1E9eRWhpxpq+C1hEHGvOT2NXmp
         /wfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:message-id:in-reply-to
         :references:subject:mime-version:content-transfer-encoding;
        bh=zIA3vGOTOORuk47wHvXbbgxpTEcpFqdShgju8D7etTU=;
        b=J6xBRwqqG8P1ttE1uKDybj2eWEfahr55SH7WbP2E73uRcU74zz7fjXd4CElAho2iSz
         MpIVSfPbwTeTdep7bNgxCik2H45Y4dA4Kge1E0kox+a3gbggZ/NoX61FeaCF1ch9iw9m
         HqCwV6muc9XmaVJoJCFEH/BpFtP5IMu/2AG+7MIJmkM6DOTmNjS+Bm8NFaj3K6+G9K/Z
         USpqZCUnuE48o2UaCclzNa66ORKF7W8SNMmDXbRgBKaNaxd+RyO4tfwxQ2Nv5GwiCdIb
         TfMztfWVkr65eBFeKQH0XA4y5hRh+OzLK5E9qUUHX7u6LdG3je/nQDXKlz3RfsVgeqNn
         jing==
X-Gm-Message-State: AOAM533Kra3WwwrkGHr0mJbMEcwrw5vj4d6TbwQB4ryYZrPlF69xk24B
        +eSIwWlIRv1PHYNHsk52SCo=
X-Google-Smtp-Source: ABdhPJyqvkE/tWvFhTvkFgopU0QNx1bUIyEHz3Z9Pu/vG3iLmTfod21PqNchHtJ1pEYfB+FuxKvZ3Q==
X-Received: by 2002:a9d:2c9:: with SMTP id 67mr99381otl.56.1623253839220;
        Wed, 09 Jun 2021 08:50:39 -0700 (PDT)
Received: from localhost (fixed-187-188-155-231.totalplay.net. [187.188.155.231])
        by smtp.gmail.com with ESMTPSA id a78sm40157oii.42.2021.06.09.08.50.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Jun 2021 08:50:38 -0700 (PDT)
Date:   Wed, 09 Jun 2021 10:50:37 -0500
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Cc:     gitster@pobox.com, sandals@crustytoothpaste.net, stolee@gmail.com,
        jrnieder@gmail.com, emilyshaffer@google.com,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Andrei Rybak <rybak.a.v@gmail.com>,
        Felipe Contreras <felipe.contreras@gmail.com>,
        Robert Karszniewicz <avoidr@posteo.de>,
        Jeff King <peff@peff.net>,
        "Kerry, Richard" <richard.kerry@atos.net>,
        Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee <dstolee@microsoft.com>
Message-ID: <60c0e34da7120_efb20836@natae.notmuch>
In-Reply-To: <065e2fdeb151b1672954a1133795b0e7744c465e.1623246879.git.gitgitgadget@gmail.com>
References: <pull.975.git.1623085069.gitgitgadget@gmail.com>
 <pull.975.v2.git.1623246878.gitgitgadget@gmail.com>
 <065e2fdeb151b1672954a1133795b0e7744c465e.1623246879.git.gitgitgadget@gmail.com>
Subject: RE: [PATCH v2 4/4] CodingGuidelines: recommend singular they
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Derrick Stolee via GitGitGadget wrote:
> From: Derrick Stolee <dstolee@microsoft.com>
> --- a/Documentation/CodingGuidelines
> +++ b/Documentation/CodingGuidelines
> @@ -648,3 +648,10 @@ Writing Documentation:
>   inline substituted text+ instead of `monospaced literal text`, and with
>   the former, the part that should not get substituted must be
>   quoted/escaped.
> +
> + Refer to an anonymous user in a gender neutral way. Singular "they/them"
> + pronouns are preferred over "he/him" and "she/her". Do not use more
> + complicated constructs such as "he or she" or "s/he". When in doubt about
> + how to use this pronoun, then change your sentence to use singular "you"
> + (e.g. "When you want to do X, do Y") or plural "they" (e.g. "When users
> + want to do X, they can do Y.").

You are prescribing what language to use, this is prescriptivism.

Earlier you said:

>   Linguists fit roughly into two camps: prescriptive and descriptive.
>   The former specify rules for people to use, and the latter document
>   language as it is actually used without forming a judgment.
> 
>   Some prescriptivists think it is acceptable, and some do not. But
>   descriptivists will rightly note that it is and has been commonly
>   used in English across countries, cultures, and contexts for an
>   extended period of time and is therefore generally accepted by most
>   English speakers as a normal part of the language.

Descriptivist linguists indeed have noted that the singular "they" has
been used in the past, but not in the way you are proposing.

Singular "they" has been used on semantically plural antecedents, not
singular antecedents [1]. This detail easily escapes non-linguists.


Moreover, descriptivists would also note that "she" and "he" have been
commonly used as well, and there's nothing wrong with using them.

A descriptivist linguist would not dare to prescribe how language
should be used in a community, like you are doing.

[1] https://ahdictionary.tumblr.com/post/147597257733/updated-usage-note-they

-- 
Felipe Contreras
