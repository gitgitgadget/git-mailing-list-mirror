Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1278C433FE
	for <git@archiver.kernel.org>; Fri, 18 Nov 2022 23:27:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235706AbiKRX11 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 18 Nov 2022 18:27:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39626 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235796AbiKRX1A (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 18 Nov 2022 18:27:00 -0500
Received: from mail-pf1-x429.google.com (mail-pf1-x429.google.com [IPv6:2607:f8b0:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 837C9BCE5D
        for <git@vger.kernel.org>; Fri, 18 Nov 2022 15:15:10 -0800 (PST)
Received: by mail-pf1-x429.google.com with SMTP id y13so6255702pfp.7
        for <git@vger.kernel.org>; Fri, 18 Nov 2022 15:15:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Ji1MUhodpA0iKLTCWtKITRY/GUHPy39MZ9U745RVJpE=;
        b=ciGJm/emrkEGmDUqqrHBe8pa+9rXV7T0Bdb0QGzsIGuPxTe1xpA8cLLK5MaC77vldv
         2VYJaU3jA6YKnZ3RqWX+eEydEFN9hGteTNFnfOm3k55rfKP7MVTdy2NEELqbiidw70fI
         rIzUaQEWUTV28allyp8VJtPlBt7EXXFTEmwdZNHKZ7JnrL80dT79CBPhDqzPrAQTlK15
         aKdVoLJJTgh5MllnrLi8/POfUYse4S7eK5hj3CWOPKOTp/rRoDxgcGn7PFUvt4P2ULvm
         DGpR586DHb7gS46ArIfRU9AgFMDnpYP9hZKL7AhFReUKeyAH/UZGD6V1Ad62PxDel0EO
         44YQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=Ji1MUhodpA0iKLTCWtKITRY/GUHPy39MZ9U745RVJpE=;
        b=kALOQ4e3I5W+Y8qKOSqvTM+b2NUl/gePFkCso8D7JBPLhQm0jN/scZ0qYvk3b+UiMN
         VhctDX7FAa0NOU+QHR9rO1NFl3WFBhERShydF2B9mPqfoOW/+EjcFFK3mhXahJo8OMdH
         Le0xfk7dKqhf8ZOwXW8oga9uIuYkmSlFRX6LGIN8sAexSJ9ZLgqkHQ0sMiSaaPTm18Mw
         nw7LATo73QGlzn5cd38P764cabrZdL8OKAAmlLU5LkBAqTqbcd16CKSwX7rbKnMMaTbL
         TqsKeKyaVFnPwgM3IFWO5IWIl/zTv3HgDdaTdUk/bw6uFD3v3nDIPKPobl7VV8CAZzIi
         0sUA==
X-Gm-Message-State: ANoB5pljWxoFMcVMxXjIr0yS5WtPbh2SXPiOw5KAY9lEHpp4qI01WaMA
        vxcF9Tg6FKM/HjQ+IphWWLY=
X-Google-Smtp-Source: AA0mqf7x1/Fmex++joj1Y6g9e7/lssC2Tm+CnV/0q5+kQsfhMyqw5F/Ekf5edH4AXXjaw4mGUQ/Y+w==
X-Received: by 2002:aa7:8092:0:b0:561:ada0:69d7 with SMTP id v18-20020aa78092000000b00561ada069d7mr10121792pff.9.1668813309662;
        Fri, 18 Nov 2022 15:15:09 -0800 (PST)
Received: from localhost (33.5.83.34.bc.googleusercontent.com. [34.83.5.33])
        by smtp.gmail.com with ESMTPSA id q9-20020a170902bd8900b00176d347e9a7sm4230609pls.233.2022.11.18.15.15.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Nov 2022 15:15:09 -0800 (PST)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     Taylor Blau <me@ttaylorr.com>
Cc:     Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, =?utf-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH v3 2/2] tests(mingw): avoid very slow `mingw_test_cmp`
References: <pull.1309.v2.git.1662469859.gitgitgadget@gmail.com>
        <pull.1309.v3.git.1668290855.gitgitgadget@gmail.com>
        <a7f4265ceb26c6dd9d347ef4cbef2aac7d60bf13.1668290855.git.gitgitgadget@gmail.com>
        <Y3B36HjDJhIY5jNz@nand.local>
Date:   Fri, 18 Nov 2022 15:15:08 -0800
In-Reply-To: <Y3B36HjDJhIY5jNz@nand.local> (Taylor Blau's message of "Sat, 12
        Nov 2022 23:51:52 -0500")
Message-ID: <xmqqv8nbkg77.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Taylor Blau <me@ttaylorr.com> writes:

> One thing that the commit message doesn't allude to (that is covered in
> the earlier discussion) is why it is important to pass
> `--ignore-cr-at-eol`. I think that is worth mentioning here.

Isn't it because Git on the platform is expected to use CRLF in
certain places, unlike on other platforms where LF is used, but the
platform port hasn't adjusted tests to match that expectation?  And
vice versa, where Git is expected to produce LF terminated text
everywhere but the expected output is not "ported" to force LF
termination and instead produces CRLF terminated text on platforms
whose native line ending is CRLF?

Use of "ignore-cr-at-eol" may allow such tests that are not ported
correctly to prepare expected output with a "wrong" line ending and
still pass, and I do think it may be an expedite way to make tests
appear to pass.

But I worry that it may not be a good thing for the health of the
Windows port in the longer term.

When Git is expected to produce platform-native line endings, if a
test is not adjusted to expect platform-native output and instead
uses the ignore-cr-at-eol workaround, a future breakage that makes
Git to produce LF terminated lines everywhere would not be caught,
would it?
