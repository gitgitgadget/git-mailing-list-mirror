Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0CA82C433F5
	for <git@archiver.kernel.org>; Sat, 30 Oct 2021 20:12:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CD8FA60F55
	for <git@archiver.kernel.org>; Sat, 30 Oct 2021 20:12:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230512AbhJ3UOn (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 30 Oct 2021 16:14:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40632 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229782AbhJ3UOm (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 30 Oct 2021 16:14:42 -0400
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED7D6C061570
        for <git@vger.kernel.org>; Sat, 30 Oct 2021 13:12:11 -0700 (PDT)
Received: by mail-ed1-x530.google.com with SMTP id ee16so37290924edb.10
        for <git@vger.kernel.org>; Sat, 30 Oct 2021 13:12:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version:content-transfer-encoding;
        bh=NFeBIlFun+u0T4zyT720PHIthk4ApZCiu1vYqPyg/3Y=;
        b=NqPaJfqjse5hO0GjA2E0d5ZxexcF4dk+rygy4eRcUrYn6SVyfjDS1C/faI7UXJfP9B
         K6yK0m3Se1ZicRIkdbOkh7Vd25gARXu4NdU4dM0DuZiMg3IU8y9pV7v9BZ7kpkp4bLbq
         Va4WFcfADxSNH89AX5kVFAOlM97DDBEAapNQSXUfrvD8RkC/eaTNajBeNY1nWXc+5RlK
         rbDDDknl05QqOoKvxknqbKoXU+1PBt5CY77tbyGZck6gKLIvfqA92dWEbASoGpzQLmLF
         ijjKsG1eRP7lfZwllji7fvfK2l2DxSPOpkJ4x63TtcBCoQKgbRWi3XTH0inTo9P/b1vj
         fR4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version:content-transfer-encoding;
        bh=NFeBIlFun+u0T4zyT720PHIthk4ApZCiu1vYqPyg/3Y=;
        b=ycBIkptTMRnJ85wpNGMjWdYCwWcIVIc5tJmsl97pGppicEedNGA6y8WqFxpRE62pAC
         FLz5ywHmPfcY3RWW4uubxeAEDR0v6crgj9+QnYUXanh8XOOQ4pA/xrp+x2o6G5J/O9tr
         ow1jFon8WVJSp3TxbYyXoq1hQB5YobWf/tcwzpDU+XOSjRYsoZ9phN3EC2ULBrnt95qt
         7y6HVYOJ1095zsfxfEQ7z5UUqDXgZXh1+JX/xVRs20gmXU0QHevwmsXHtDkZMQM7bwXL
         5uZCcIUihut453UN7Yvi2xCQMGBB+vV+k/lTx26zvTXIV1C5fZAn8+vivVQwjOwHfLYg
         RUig==
X-Gm-Message-State: AOAM530rvsByT7QdiDXwdw+uLYKgvUKsaGaE2wkI2X2cOkYWMbLIDc2c
        qZj7y7QjdgGj9s6AqYYLBq1qt/ZziSE=
X-Google-Smtp-Source: ABdhPJxO241eOUqko64kjUZBMwy6KK8U0nxUW8sjkzM8I5/WMWTicptq5+F/kCjS2nHc3YV3Qm975A==
X-Received: by 2002:a17:906:5811:: with SMTP id m17mr23890180ejq.289.1635624730320;
        Sat, 30 Oct 2021 13:12:10 -0700 (PDT)
Received: from gmgdl (j120189.upc-j.chello.nl. [24.132.120.189])
        by smtp.gmail.com with ESMTPSA id h20sm1550708eds.88.2021.10.30.13.12.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 30 Oct 2021 13:12:09 -0700 (PDT)
Received: from avar by gmgdl with local (Exim 4.95)
        (envelope-from <avarab@gmail.com>)
        id 1mgui1-0027fr-4U;
        Sat, 30 Oct 2021 22:12:09 +0200
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Eric Wong <e@80x24.org>
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        git@vger.kernel.org
Subject: Re: scripting speedups [was: [Summit topic] Crazy (and not so
 crazy) ideas]
Date:   Sat, 30 Oct 2021 21:58:36 +0200
References: <nycvar.QRO.7.76.6.2110211129130.56@tvgsbejvaqbjf.bet>
 <nycvar.QRO.7.76.6.2110211144490.56@tvgsbejvaqbjf.bet>
 <20211026201448.GA29480@dcvr>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.6.6
In-reply-to: <20211026201448.GA29480@dcvr>
Message-ID: <211030.86ee8246hy.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Tue, Oct 26 2021, Eric Wong wrote:

> Johannes Schindelin <Johannes.Schindelin@gmx.de> wrote:
>> * Test suite is slow. Shell scripts and process forking.
>>=20
>>    * What if we had a special shell that interpreted the commands in a
>>      single process?
>>=20
>>    * Even Git commands like rev-parse and hash-object, as long as that=
=E2=80=99s
>>      not the command you=E2=80=99re trying to test
>
> This is something I've wanted in a very long time as a scripter.
> fast-import has been great over the years, as is
> "cat-file --batch(-check)", but there's gaps should be filled
> (preferably without fragile linkage of shared libraries into a
> script process)
>
>>    * Dscho wants to slip in a C-based solution
>>=20
>>    * Jonathan tan commented: going back to your custom shell for tests
>>      idea, one thing we could do is have a custom command that generates
>>      the repo commits that we want (and that saves process spawns and
>>      might make the tests simpler too)
>
> Perhaps a not-seriously-proposed patch from 2006 could be
> modernized for our now-libified internals:

I think something very short of a "C-based solution" could give us most
of the wins here. Johannes was probably thinking of the scripting being
slow on Windows aspect of it.

But the main benefit of hypothetical C-based testing is that you can
connect it to the dependency tree we have in the Makefile, and only
re-run tests for code you needed to re-compile.

So e.g. we don't need to run tests that invoke "git tag" if the
dependency graph of builtin/tag.c didn't change.

With COMPUTE_HEADER_DEPENDENCIES we've got access to that dependency
information for our C code.

With trace2 we could record an initial test run, and know which built-in
commands are executed by which tests (even down to the sub-test level).

Connecting these two means that we can find all tests that say run "git
fsck", and if builtin/fsck.c is the only thing that changed in an
interactive rebase, that's the only tests we need to run.

Of course changes to things like cache.h or t/test-lib.sh would spoil
that cache entirely, but pretty much the same is true for re-compiling
things now, so would changing say builtin/init-db.c, as almost every
test does a "git init" somewhere.

But I think that approch is viable, and should take us from a huge
hypothetical project like "rewrite all the tests in C" to something
that's a viable weekend hacking project for someone who's interested.
