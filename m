Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EBCCBC00145
	for <git@archiver.kernel.org>; Mon, 12 Dec 2022 18:35:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233568AbiLLSfX convert rfc822-to-8bit (ORCPT
        <rfc822;git@archiver.kernel.org>); Mon, 12 Dec 2022 13:35:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56520 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233278AbiLLSfR (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 12 Dec 2022 13:35:17 -0500
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C75831113
        for <git@vger.kernel.org>; Mon, 12 Dec 2022 10:35:15 -0800 (PST)
Received: by mail-pl1-f180.google.com with SMTP id d3so12956232plr.10
        for <git@vger.kernel.org>; Mon, 12 Dec 2022 10:35:15 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NChnqIMUF9gifZBnJq7vZpDBtxX8DdQmfgHf3QIWHPY=;
        b=bGNGPnN1BMf4EKfuW/9DZV07g1RtanehL20+kcOZrkIDSrgY/qhI2ZpG2ID7WTXSfa
         DmqvFk0Rxw7advfSMkBG6oHQYmaGgGt4Od8GDkqcKLFPviTg+K+WSUOLZ/zH/mUFR5nf
         07XnUNjsNLz3phF9mF83Ims2qPXTXuhNtCc+ybadZeh5dDMyQ7lMPESI/Uq45wDtL3xs
         bN7lNTKnWO9lcK/i1U94S2eWyFec550rEtQdJl/R8ikeeaV9Ol5xu9dSKbG1sB5gO89p
         VSgQVvKSuXaAUiiKvwxKewN7FPI5mpMyrGExgSLcb4lTe/xekcAHCXnOZO5GWdQ/lOsq
         g2Qw==
X-Gm-Message-State: ANoB5pm0UT1uE8UN6zx5KBpAGuvl7aNcrIChzXQux4JZr5U9N5mlNokV
        +YJ+CsH00ZDQUkYCT3Id7hunvw5y8fZFYXQTPJU=
X-Google-Smtp-Source: AA0mqf7AxxGyfQ6/Gn9aez5ak/1VtpBaOkQBqdKcfONCKVhWKfIFVenjIeoWRBHpoKNMYydL6QA4yapC3nzIwheescc=
X-Received: by 2002:a17:902:aa07:b0:188:eee6:e1a6 with SMTP id
 be7-20020a170902aa0700b00188eee6e1a6mr80782941plb.120.1670870115149; Mon, 12
 Dec 2022 10:35:15 -0800 (PST)
MIME-Version: 1.0
References: <20221104010242.11555-1-jacobabel@nullpo.dev> <20221104213401.17393-1-jacobabel@nullpo.dev>
 <20221110233137.10414-1-jacobabel@nullpo.dev> <20221212014003.20290-1-jacobabel@nullpo.dev>
 <20221212014003.20290-4-jacobabel@nullpo.dev> <221212.86pmcp57w4.gmgdl@evledraar.gmail.com>
 <20221212145913.aftjeq6kn55zbkai@phi> <221212.86zgbs4h9f.gmgdl@evledraar.gmail.com>
In-Reply-To: <221212.86zgbs4h9f.gmgdl@evledraar.gmail.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Mon, 12 Dec 2022 13:35:04 -0500
Message-ID: <CAPig+cQP4mBFaLX+DtAWHR59WM3vQM+ZHrLkLeZrsxosVwkdTQ@mail.gmail.com>
Subject: Re: [PATCH v4 3/3] worktree add: Add hint to use --orphan when bad ref
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Cc:     Jacob Abel <jacobabel@nullpo.dev>, git@vger.kernel.org,
        Phillip Wood <phillip.wood123@gmail.com>,
        =?UTF-8?B?UnViw6luIEp1c3Rv?= <rjusto@gmail.com>,
        Taylor Blau <me@ttaylorr.com>, rsbecker@nexbridge.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Dec 12, 2022 at 1:19 PM Ævar Arnfjörð Bjarmason
<avarab@gmail.com> wrote:
> On Mon, Dec 12 2022, Jacob Abel wrote:
> > Also, Is there an easier way to debug the `test_expect_success` statements? I
> > tried enabling tracing mode but it doesn't seem to trace into those statements.
>
> Not really, other than just enabling "-x" for the test-lib.sh itself, i.e.:
>
>         sh -x ./t0001-init.sh
>
> I *think* that should work, but I didn't test it...

Isn't the question here how to debug the body of a
test_expect_success? If that's the case, then running the test with -x
and -i should help:

    ./t001-init.sh -x -i

The -x makes it print all the output as it's executing the body of the
test_expect_success rather than suppressing it, and -i makes it stop
as soon as it encounters a failing test, which makes it easier to
examine the state of that test. After the script aborts (via -i), look
inside the "trash*" directory. Also, you can insert calls to
test_pause in the body of a test, which will make it drop into an
interactive shell session in the trash directory at the point of the
test_pause, so you can examine the state of the test directly as it
exists at that point (as opposed to examining it after the test
failed, as with -i).
