Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0FCBC77B73
	for <git@archiver.kernel.org>; Thu, 27 Apr 2023 18:48:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244617AbjD0SsD (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 27 Apr 2023 14:48:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57502 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244640AbjD0Sr7 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 27 Apr 2023 14:47:59 -0400
Received: from mail-pf1-x432.google.com (mail-pf1-x432.google.com [IPv6:2607:f8b0:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A35B1359D
        for <git@vger.kernel.org>; Thu, 27 Apr 2023 11:47:42 -0700 (PDT)
Received: by mail-pf1-x432.google.com with SMTP id d2e1a72fcca58-63b7096e2e4so7339461b3a.2
        for <git@vger.kernel.org>; Thu, 27 Apr 2023 11:47:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1682621262; x=1685213262;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=n1/i+ZonqPDRBrBsnOyyVzwCZGbEpWN6RH2A91TExJU=;
        b=W9eAa4JcWLdT2zwNKBQkvjrc2yDUegdqH9V+EVvJsGEk7qUI8EIeaqEiVEeynaGLQO
         ZvZnpGKL3Re+qi+hPNReJyaOCbN36uSsJyRmCcbJQSDpgZkvhk+42nvuPNLsMtP6sZi2
         t8PgwgTX+j+TX3W41PxejPIOdrWiw3TrK5+rnORfM2V4ggo8GA8osIT89e4IpJoULZME
         7jPrZYz7jipknlzHmoLfMyleFM0cZqmBOTay7Wjf6yirXGhD/WpnNRmPJppN/TtPG8sq
         e4E0VPOUmJ1DwoCEdx/Pbr3hJtM5cS9mEfCQlvqttgQJMmhNOgP/ByVCXk0bOlfGf2CS
         l8jw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682621262; x=1685213262;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=n1/i+ZonqPDRBrBsnOyyVzwCZGbEpWN6RH2A91TExJU=;
        b=TPClqSacIRWnTZ6RG9ezhChGeAiQgpFmR7CGey7g19L88cyrMfKkWxYxGq+i1nfGix
         4ENXfhrk1kKMDw46/suFQ+ruqHTdG6+xXYqacYaYb3kq9uPy/78NFEjbZOL2M2SHzG7T
         y0xCGFQQW6/dI3fh3JpILU7Is7Z4HzniliEJJjUI/AUG716+ITYB8VKbFJJHm1FlfS0x
         HwnXZI8ZDmn0Oz+ke249VaMU7ig6V0WNIlk5xyAnfjrn2KHn/pn3B3H6U4crKhnwEulV
         /BBeAZsUfPsTJK5Az28bPxSAcl6S3Lp5qP6oZYzR9cmlZOGHKL9jnL8QQH2jg3aVNp61
         Xrdw==
X-Gm-Message-State: AC+VfDxtYeBB39nu3ppXHCt44jK3dILYBtCs0NfNFfFQAxnVqDTe51a6
        4LtZ2ouUBH3ogt4TcTUyKq4APe+Ql6M=
X-Google-Smtp-Source: ACHHUZ7RIm3JOms0YRy4x2nkdESA6Zg7V0YXIIeNWkG0/oOrFl4BckifAFVrvHDAM/YKr99MFUU9rw==
X-Received: by 2002:a05:6a20:d48f:b0:f0:f2a:ff4f with SMTP id im15-20020a056a20d48f00b000f00f2aff4fmr2667347pzb.8.1682621262008;
        Thu, 27 Apr 2023 11:47:42 -0700 (PDT)
Received: from localhost (187.137.203.35.bc.googleusercontent.com. [35.203.137.187])
        by smtp.gmail.com with ESMTPSA id i66-20020a62c145000000b0063d318699f9sm13505490pfg.48.2023.04.27.11.47.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Apr 2023 11:47:41 -0700 (PDT)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     Calvin Wan <calvinwan@google.com>
Cc:     git@vger.kernel.org
Subject: Re: [RFC PATCH 2/2] unit test: add basic example
References: <20230427175007.902278-1-calvinwan@google.com>
        <20230427175007.902278-3-calvinwan@google.com>
Date:   Thu, 27 Apr 2023 11:47:41 -0700
In-Reply-To: <20230427175007.902278-3-calvinwan@google.com> (Calvin Wan's
        message of "Thu, 27 Apr 2023 17:50:07 +0000")
Message-ID: <xmqqedo5jh6a.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Calvin Wan <calvinwan@google.com> writes:

> Although this commit doesn't showcase unit tests running against
> anything in Git, locally, I have a smaller set of Git files compiling
> into a library with unit tests running against it using this C TAP
> harness.
>
> However, you can run `make ctap` to get an idea of how the output looks
> and use it as a baseline to play around with the other features of the
> library.

My aging eyes first read it as "make crap" ;-).

Should we ove most of it to some other Makefile that lives in t/tap
and keep it outside the primary Makefile?  This is adding about half
a dozen lines to support a sample unit-test.c file to be tested, and
if we are going to have 200 of them would we add a thousand or more
lines?

As a technology demonstration, such a hello-world test may be fine,
but I would have liked to see a more realistic sample that links
with reasonably isolated part of Git codebase, perhaps testing say
functions from <quote.h>.

THanks.
