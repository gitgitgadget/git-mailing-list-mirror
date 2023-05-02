Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7FDEDC77B7E
	for <git@archiver.kernel.org>; Tue,  2 May 2023 15:28:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233978AbjEBP2x (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 2 May 2023 11:28:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233981AbjEBP2v (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 2 May 2023 11:28:51 -0400
Received: from mail-oi1-x235.google.com (mail-oi1-x235.google.com [IPv6:2607:f8b0:4864:20::235])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07226421C
        for <git@vger.kernel.org>; Tue,  2 May 2023 08:28:18 -0700 (PDT)
Received: by mail-oi1-x235.google.com with SMTP id 5614622812f47-38e27409542so2849260b6e.0
        for <git@vger.kernel.org>; Tue, 02 May 2023 08:28:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1683041293; x=1685633293;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=68V/zO/l5fJooUoqowW+VsVAR+OaS1zFy1ec4Jl8YeQ=;
        b=PtoC8he4083kL1N2pqpkvcrR7g4o5pyXd9RXfK8U2Y4F6gcRkO1nnc1/5NzSmxy5ay
         FUQXiBkKEAVye3MoeUP18WtjYYWXbUvfj2g7pF9/NdVhkJeiCrpEr9BcMliR/EsRJzbo
         YY1rNXJKgH8fOrLnn1cobS4k8S+3wZxSpshr1VGUCDAxg9iIHbaJr5K6PoOiiu9SGbgL
         gsM54O7wN9SSEGlqg63Zyu4csudKeHCu5Cm9jZ4MvmesVR3nza+o/ZwBDOe0wi7cN5Qr
         6XpFS3mX//cMKTwcmjyzVYwTZcCc8zARodND4rK1ohWudND01yIN/rgQt3MSPBe5hfj2
         ZVRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683041293; x=1685633293;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=68V/zO/l5fJooUoqowW+VsVAR+OaS1zFy1ec4Jl8YeQ=;
        b=HYEPcGbt70cGxmyoY2CPHUXV6xBBeF1iGCJ7lqmiUMW6If0rXiMORf3qxdicantLTf
         QjuqZCGkRCUBGZ7H8dYQRaPUFHaUdWQKol+J2EBMtkO9JZ5T11atZBbXIQ74QaZ9s4OY
         23CT2bRIER9xoebjZxWSrRhIPgCd94+CyMphXL56/T1v7/ThXBe+mJy5Vv0g/+Nfhqne
         ebZs7O4VKwrXFJ3HbV5wESIMsMyFBrdRjC9jOIfG9jUFhxWJQMoM/lkkwGDz8PODGNDj
         Syw/dN7Mri+WWmVti3w2McemyqDD21N1PExbOf+nE9Q7dy7lJvvMf18lvMIyKrgT100D
         tZ4Q==
X-Gm-Message-State: AC+VfDyj3tCw2nnz48oly7ayF09qhTwahel3oshUsk6k/9E6g5znWFTS
        Q8UL2AazUdib6g7BZHF0XFBo3MVAr2k=
X-Google-Smtp-Source: ACHHUZ5lUt0cYc+GWzjU7/6vNpg7LEerYC5LnUr3i/ODKhax4GDV2CQ4PfdILSUrdPyTYQMgQ4jvkA==
X-Received: by 2002:a05:6808:2816:b0:390:8250:c87c with SMTP id et22-20020a056808281600b003908250c87cmr7851223oib.29.1683041292868;
        Tue, 02 May 2023 08:28:12 -0700 (PDT)
Received: from localhost ([2806:2f0:4060:fff1:4ae7:daff:fe31:3285])
        by smtp.gmail.com with ESMTPSA id ay13-20020a056808300d00b0038e086c764dsm12267557oib.43.2023.05.02.08.28.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 May 2023 08:28:11 -0700 (PDT)
Date:   Tue, 02 May 2023 09:28:11 -0600
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Calvin Wan <calvinwan@google.com>
Cc:     git@vger.kernel.org
Message-ID: <64512c0b1237b_1ba2d29426@chronos.notmuch>
In-Reply-To: <230502.861qjyj0cb.gmgdl@evledraar.gmail.com>
References: <20230427175007.902278-1-calvinwan@google.com>
 <230502.861qjyj0cb.gmgdl@evledraar.gmail.com>
Subject: Re: [RFC PATCH 0/2] add an external testing library for unit tests
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason wrote:

> We already have pure-C libraries that we add a really shim to unit test=
,
> the most extreme example of this is t0032-reftable-unittest.sh, whose
> body is simply (excluding comments):
> 	=

> 	#!/bin/sh
> 	test_description=3D'reftable unittests'
> 	=

> 	TEST_PASSES_SANITIZE_LEAK=3Dtrue
> 	. ./test-lib.sh
> 	=

> 	test_expect_success 'unittests' '
> 		TMPDIR=3D$(pwd) && export TMPDIR &&
> 		test-tool reftable
> 	'
> 	=

> 	test_done

Yeah, but an output of 'ok 1 - unittests' is not very useful, neither is =
an
output of 'not ok 1 - unittests'.

This completely misses the point of a TAP interface, which is to parse th=
e
status of individual test cases, or even individual assertions.

If all we are doing is check the exit code of some program, then we don't=
 need
TAP.

> Now, that goes into reftable/test_framework.h which basically implement=
s
> its own mini-test framework, so that's at least a *partial* argument fo=
r
> what you're suggesting here, but note that it doesn't emit TAP, it just=

> returns an exit code, the EXPECT() etc. is purely internal. I.e. "what
> should we return?".

You are just describing the status quo.

I think this is a naturaistic fallacy: confusing what is versus what ough=
t to
be.

Can we test C code with our current testing framework? Yes.

Should we? That's the actual question.

> None of those are perfect, but I think the current arrangement is rathe=
r
> ideal.

I think misuing TAP is far from ideal.

In my view an ideal framework would:

 1. Be able to test C code
 2. Report individual test cases success/failure
 3. Report relevant context in the case of failure (actual vs. expected)
 4. Don't create forks on every individual test case or assertion
 5. Properly handle crashes

Doing basically the following is not an ideal framework:

  echo '1..1'
  test-tool reftable > /dev/null 2>&1 && echo 'ok 1' || { echo 'not ok 1'=
; false; }

Yes, it works. But "it works" has never been a good enough reason to stay=
 on
the status quo.

> We can write most or all of the test in C, but we just do so by
> calling a function that returns an exit code.

Yes, we *can*, but should we?

---

If we can test C code in a way that individual test case failures are rep=
orted
(as is the intention with TAP), why would we reject that in favor of the =
status
quo which basically is just reporting the exit code of the whole test fil=
e?

-- =

Felipe Contreras=
