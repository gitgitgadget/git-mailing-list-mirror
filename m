Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C989AC7EE23
	for <git@archiver.kernel.org>; Thu, 18 May 2023 17:17:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229557AbjERRRg (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 18 May 2023 13:17:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229457AbjERRRf (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 18 May 2023 13:17:35 -0400
Received: from mail-pf1-x434.google.com (mail-pf1-x434.google.com [IPv6:2607:f8b0:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6AB6A1BD
        for <git@vger.kernel.org>; Thu, 18 May 2023 10:17:34 -0700 (PDT)
Received: by mail-pf1-x434.google.com with SMTP id d2e1a72fcca58-64d1e96c082so640648b3a.1
        for <git@vger.kernel.org>; Thu, 18 May 2023 10:17:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1684430254; x=1687022254;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=YKEuidKJZQCmoHIzqBEyIstseiLcl0Mpbj5Q+S5XZXc=;
        b=F9bDPXTaU9dRgV1Ej0GdW0ke7wTNxnDAfDSfxQ+ebPwCSPQwssQxMC6FHg5qMw117N
         XEE/E/2qrdvh82AwNhQiWfuxAo7tQq049WRxzlUMhDZv2XQZNcguJySv8HoPN75vQ904
         Gll+tQaM77F77nE/B7Fx24Z+8xakX/fEFhCCb1Qh1zCinG27CNtUYVX5vblI5MXxAh6i
         s6TI9FasqzJ3TDWxv7Gnqy7H0DJROwTZUbWpJ187t8cASrHc6iQZopNQgdwc5J6KPOfa
         kJffLdBsnCB8f2806uXjYS55qmDkbVhjxofkfcmMWkMMMi1RjELK4r461AsQonRrojWr
         oKMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684430254; x=1687022254;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=YKEuidKJZQCmoHIzqBEyIstseiLcl0Mpbj5Q+S5XZXc=;
        b=FMLM1ZIcXH6FlpZ/h402lXgLyBQyKuwOJNXP7w1UkjZqu3MutzkgC+MylG5dwiHTZP
         Z7ThZjbG/PZ3u/Ohp/j8AEYN4UNb7a2kayjM6GEL54As3xXMOSP+BdNzSrEiZAycwm5m
         7rygK3NQKT0xVRj8R0MqLf4aZMyi3pLXDO1o1p+staCXQ1XRAupV1k0I3xbzTackNQZe
         u2yVj/ay4HXmiW1YS8wFrXeshmE8jLJnwLl5TP3wVABsyb9SUVKL7Lo0f+hhM0wmCGfg
         429irMXY2L+bAn+ppSabgFEXi15AMTI9JRFiYJ6kGTuNZXTxwS8yKVfjkjyYsE83QvyM
         KDTA==
X-Gm-Message-State: AC+VfDwBLqBupDax5HoQXx8PDMRXFWQzeOkW9aTmitgTscqNBKNNm7e1
        rw+MR2jEjjuaLg/R1s1ZWXRZs278F4k=
X-Google-Smtp-Source: ACHHUZ7L3KhcJEFk3ZRE0yYBxBDlNbKBhcfT9tM/J+ZUCGy6GDxh/3G6S9qCfsVFSRJHh2a5DbMUhw==
X-Received: by 2002:a05:6a00:ac9:b0:63b:1708:10aa with SMTP id c9-20020a056a000ac900b0063b170810aamr5742592pfl.34.1684430253741;
        Thu, 18 May 2023 10:17:33 -0700 (PDT)
Received: from localhost (187.137.203.35.bc.googleusercontent.com. [35.203.137.187])
        by smtp.gmail.com with ESMTPSA id s11-20020a62e70b000000b0063f3aac78b9sm1589904pfh.79.2023.05.18.10.17.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 May 2023 10:17:33 -0700 (PDT)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     steadmon@google.com
Cc:     git@vger.kernel.org, calvinwan@gmail.com, szeder.dev@gmail.com,
        phillip.wood123@gmail.com, chooglen@google.com, avarab@gmail.com,
        sandals@crustytoothpaste.net
Subject: Re: [PATCH RFC v2 1/4] common-main: split common_exit() into a new
 file
References: <20230517-unit-tests-v2-v2-0-21b5b60f4b32@google.com>
        <20230517-unit-tests-v2-v2-1-21b5b60f4b32@google.com>
Date:   Thu, 18 May 2023 10:17:32 -0700
In-Reply-To: <20230517-unit-tests-v2-v2-1-21b5b60f4b32@google.com>
        (steadmon@google.com's message of "Wed, 17 May 2023 16:56:31 -0700")
Message-ID: <xmqqcz2xtv83.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

steadmon@google.com writes:

> It is convenient to have common_exit() in its own object file so that
> standalone programs may link to it (and any other object files that
> depend on it) while still having their own independent main() function.

I am not so sure if this is a good direction to go in, though.  The
common_exit() function does two things that are very specific to and
dependent on what Git runtime has supposed to have done, like
initializing trace2 subsystem and linking with usage.c to make
bug_called_must_BUG exist.

I understand that a third-party or standalone non-Git programs may
want to do _more_ than what our main() does when starting up, but it
should be doable if make our main() call out to a hook function,
whose definition in Git is a no-op, that can be replaced by their
own implementation to do whatever they want to happen in main(), no?

The reason why I am not comfortable with this patch is because I
cannot say why this split is better than other possible split.  For
example, we could instead split only our 'main' out to a separate
file, say "main.c", and put main.o together with common-main.o to
libgit.a to be found by the linker, and that arrangement will also
help your "standalone programs" having their own main() function.
Now with these two possible ways to split (and there may be other
split that may be even more convenient; I simply do not know), which
one is better, and what's the argument for each approach?

> So let's move it to a new common-exit.c file and update the Makefile
> accordingly.
>
> Change-Id: I41b90059eb9031f40c9f65374b4b047e7ba3aac0
> ---
>  Makefile      |  1 +
>  common-exit.c | 26 ++++++++++++++++++++++++++
>  common-main.c | 24 ------------------------
>  3 files changed, 27 insertions(+), 24 deletions(-)
