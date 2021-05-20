Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B2A9C433ED
	for <git@archiver.kernel.org>; Thu, 20 May 2021 15:05:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 45B8B60FE8
	for <git@archiver.kernel.org>; Thu, 20 May 2021 15:05:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232438AbhETPHI (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 20 May 2021 11:07:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35834 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231464AbhETPHI (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 20 May 2021 11:07:08 -0400
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com [IPv6:2a00:1450:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9433EC061574
        for <git@vger.kernel.org>; Thu, 20 May 2021 08:05:45 -0700 (PDT)
Received: by mail-ej1-x62b.google.com with SMTP id u21so25765302ejo.13
        for <git@vger.kernel.org>; Thu, 20 May 2021 08:05:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version;
        bh=o0fzVCS0RDcXw4lPeCEnee5I9Dw0Bwe3OK30N8tlCQI=;
        b=LZfS3EYpCj0xU6jEXoSOsM8TzG8/uys392gpHTaIiFc3e/V+vLBYDcJx8zOV00vrTQ
         /XnWkAfrL+JQ0DQhfJOW++yfCBjvbauhsiHHx4zcT7LX7sr7n0A/b1KfY3zXX48kedhR
         47W8UxjNlaH09LihKzSh0xSm3LbMwc7ujel+d00yqmzSsGyw2xYbVWpVOie8Kb8HJ9st
         eWv62pVSsLhXqEJInVih9J7blhJhXQYYJ13k3l3iSlPPEpGScyikt/8q7SvU7MY7YosM
         JCbhbzEmKyF356U5zpKRjbh2299MUemVkmbRG2snAOGVN6kA4+N2oqaQsI3UqqkimJ1d
         bgEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version;
        bh=o0fzVCS0RDcXw4lPeCEnee5I9Dw0Bwe3OK30N8tlCQI=;
        b=m7Lveyc8TuSeadeWcA0sh3goGYiWmfLF/38tYSc7BossO4XBvrHDneG562uPh+I5pp
         oA+zTEo7FRpPJIHpb4Tf8UTWgWRVm7g1vqekyeUz6yLdu8JyTBOBZGEX1jWxLSQz1Qoj
         BkT7ktGONpSMEeLqaIH6NfwevARK8oI6hsmVtxx8AFllFKq76Wt5BhAhejw5om6Mo455
         poWfJuO+rPWC8l4bt2HsmcOx4Ljy/K+QOUxwYCQF+Ix+VuLHWDU6xq4JkuEp859fiMQi
         HM1ekmQMYf9kgBWNOQU1bWiuZUwsFjHdvjSJQSha83/CJTuL4Y16R+aFM7c/i8BNXZME
         GgtQ==
X-Gm-Message-State: AOAM5307ckdlEleIO0zzX0nE9Htye00EU94s1xDOn04VqYrEt69nWwQ8
        sHE/GvpwnHozZ2W6qBAsLfVOoiR6eswUxA==
X-Google-Smtp-Source: ABdhPJyBYVL28v+d1H95c9MhHtX0ckqhKivOx/9hTIvLYKPdNuuLOUtbzR+UVkNw1dv6bcS2s0qkOg==
X-Received: by 2002:a17:906:d1d2:: with SMTP id bs18mr5229066ejb.56.1621523143877;
        Thu, 20 May 2021 08:05:43 -0700 (PDT)
Received: from evledraar (j57224.upc-j.chello.nl. [24.132.57.224])
        by smtp.gmail.com with ESMTPSA id v12sm1747688edb.81.2021.05.20.08.05.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 May 2021 08:05:43 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Han-Wen Nienhuys via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Han-Wen Nienhuys <hanwenn@gmail.com>,
        Han-Wen Nienhuys <hanwen@google.com>
Subject: Re: [PATCH v2 01/21] t4202: split testcase for invalid HEAD symref
 and HEAD hash
Date:   Thu, 20 May 2021 17:03:20 +0200
References: <pull.1008.git.git.1618829583.gitgitgadget@gmail.com>
 <pull.1008.v2.git.git.1619519903.gitgitgadget@gmail.com>
 <8ad4a35cda706b1bfcd8ddcf1b1c2e1d8f692c70.1619519903.git.gitgitgadget@gmail.com>
User-agent: Debian GNU/Linux bullseye/sid; Emacs 27.1; mu4e 1.5.12
In-reply-to: <8ad4a35cda706b1bfcd8ddcf1b1c2e1d8f692c70.1619519903.git.gitgitgadget@gmail.com>
Message-ID: <87a6opqwc9.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Tue, Apr 27 2021, Han-Wen Nienhuys via GitGitGadget wrote:

> From: Han-Wen Nienhuys <hanwen@google.com>
>
> Reftable will prohibit invalid hashes at the storage level, but
> git-symbolic-ref can still create branches ending in ".lock".
>
> Signed-off-by: Han-Wen Nienhuys <hanwen@google.com>
> ---
>  t/t4202-log.sh | 10 +++++++---
>  1 file changed, 7 insertions(+), 3 deletions(-)
>
> diff --git a/t/t4202-log.sh b/t/t4202-log.sh
> index 350cfa35936a..a8c5a00d012d 100755
> --- a/t/t4202-log.sh
> +++ b/t/t4202-log.sh
> @@ -1834,14 +1834,18 @@ test_expect_success 'log --graph --no-walk is forbidden' '
>  	test_must_fail git log --graph --no-walk
>  '
>  
> -test_expect_success 'log diagnoses bogus HEAD' '
> +test_expect_success 'log diagnoses bogus HEAD hash' '
>  	git init empty &&
>  	test_must_fail git -C empty log 2>stderr &&
>  	test_i18ngrep does.not.have.any.commits stderr &&
>  	echo 1234abcd >empty/.git/refs/heads/main &&
>  	test_must_fail git -C empty log 2>stderr &&
> -	test_i18ngrep broken stderr &&
> -	echo "ref: refs/heads/invalid.lock" >empty/.git/HEAD &&
> +	test_i18ngrep broken stderr'
> +
> +test_expect_success 'log diagnoses bogus HEAD symref' '
> +	rm -rf empty &&
> +	git init empty &&
> +	git --git-dir empty/.git symbolic-ref HEAD refs/heads/invalid.lock &&
>  	test_must_fail git -C empty log 2>stderr &&
>  	test_i18ngrep broken stderr &&
>  	test_must_fail git -C empty log --default totally-bogus 2>stderr &&

When splitting up tests like:

    git init xyz &&
    [do with xyz]

Let's do:

    # test 1
    test_when_finished "rm -rf xyz" &&
    git init xyz &&
    [do with xyz]

    # test 2
    test_when_finished "rm -rf xyz" &&
    git init xyz &&
    [do with xyz]

Instead of, as here:

    # test 1
    git init xyz &&
    [do with xyz]

    # test 2
    rm -rf xyz &&
    git init xyz &&
    [do with xyz]

This isn't a logic error, but just a better idiom. Better to have the
thing creating stuff clean it up, than other tests being aware of their
order and (possibly redundantly, if we skip tests), clean up after
earlier tests.
