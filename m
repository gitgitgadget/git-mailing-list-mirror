Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D0E9C433EF
	for <git@archiver.kernel.org>; Mon,  6 Sep 2021 22:41:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 04D0360EFD
	for <git@archiver.kernel.org>; Mon,  6 Sep 2021 22:41:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231998AbhIFWmL (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 6 Sep 2021 18:42:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57388 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243908AbhIFWkj (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 6 Sep 2021 18:40:39 -0400
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C55FC061575
        for <git@vger.kernel.org>; Mon,  6 Sep 2021 15:39:33 -0700 (PDT)
Received: by mail-ed1-x536.google.com with SMTP id i6so11227999edu.1
        for <git@vger.kernel.org>; Mon, 06 Sep 2021 15:39:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version;
        bh=UHFTyT3NqQluQFoB6oXodGCX2QU7AnyCgpAENI44YV0=;
        b=cRjv9G5eI4dEPf+fC4g3Wg2GMetyreqdDEa3+9yZ94gl1mXLH5l+NTt/ds63t6g+8o
         /n7kjLpDyM8iPMs4EPi64w/nNsX6kpf4pSCHSc9dTS8h1XliMlAdhRwFOJx9ZLV1QY7Y
         L8ApY7PR+9MNhsmMFApvVUJSI+Bdqr0tKLfZjdPG+T499cGJS/tJVnXf1PTt7c2vhWXR
         mmm6HL+qvUSC6YRHRPij+z+kaBw+tVSilQEKfRIduaRlZiQlyuts1tjxk8wR/wDMhqMd
         GGJrngAFOQLy5GMl2UG5sIg9+GaPXvlRXX7dOcscxPk3ECVW4fmsJ0+kAuuIb+YI/reC
         quVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version;
        bh=UHFTyT3NqQluQFoB6oXodGCX2QU7AnyCgpAENI44YV0=;
        b=CFtk4YA5wzB00bFltJRLzryqW8am4Mx6SYZVpxtDqZ3wO27W/ibsmBlqfDxJKwCE9W
         AnZXOYX0ieEIDbQUfZUxEM7CCTXqmTYW7RVf1zjZ2XVaw+8jaJKMVME9uogL5pbsO/8L
         /ADkN0moqqi6EJ5cPSMPhJnvbbuby4n5pW6rCSKXJh8q+KJd/RJWv1Mpe8byjr2qqqsd
         ma1ntkRaaYDrIy+PjnOkJ6N+KW09Q2e9TECq1NeKA2i5Mbp6DvBqzNtI+zimrhko2qMd
         n09oxBYN5fyNbl3k4wa54NNViHaYOksjlDX/h2cU4MEntnaY5Y5QasIhQo0Rw0dviV86
         e2dA==
X-Gm-Message-State: AOAM533+ql+71/5aS3nkqxSLYxjJG11aSGdW+G53HLGlqZeHJXDDxBNP
        Y9+/O6cyp1yGqXTRQxU+lWGEGA+LA7dPJA==
X-Google-Smtp-Source: ABdhPJywv/noiZZXlQjfHsGrrfOUB/SW85KArAtGoezHfXcdcOse4Zkrrt2c0RwRwv0pPftEVgJUBg==
X-Received: by 2002:a05:6402:518e:: with SMTP id q14mr15410241edd.268.1630967971988;
        Mon, 06 Sep 2021 15:39:31 -0700 (PDT)
Received: from evledraar (j120189.upc-j.chello.nl. [24.132.120.189])
        by smtp.gmail.com with ESMTPSA id p2sm5331029edi.82.2021.09.06.15.39.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Sep 2021 15:39:31 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Han-Wen Nienhuys via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Taylor Blau <me@ttaylorr.com>,
        Han-Wen Nienhuys <hanwenn@gmail.com>,
        Han-Wen Nienhuys <hanwen@google.com>
Subject: Re: [PATCH v2 1/5] refs: trim newline from reflog message
Date:   Tue, 07 Sep 2021 00:38:05 +0200
References: <pull.1067.git.git.1630334929.gitgitgadget@gmail.com>
 <pull.1067.v2.git.git.1630947142.gitgitgadget@gmail.com>
 <995d450da42f35b4cecdd699fa1b1a74518f481e.1630947142.git.gitgitgadget@gmail.com>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.7.0
In-reply-to: <995d450da42f35b4cecdd699fa1b1a74518f481e.1630947142.git.gitgitgadget@gmail.com>
Message-ID: <874kaxnxb0.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Mon, Sep 06 2021, Han-Wen Nienhuys via GitGitGadget wrote:

> From: Han-Wen Nienhuys <hanwen@google.com>
> [...]
> -				puts(reflog_msg[i]);
> +				puts(reflog_msg[i]); /* XXX - this puts a
> +							newline. Did we put two
> +							newlines beforehand? */

I recently added some tests for show-branch, see the tip of
ab/show-branch-tests. This seems like it would be clearer to both you &
reviewers if we first checked & test_cmp'd the reflog behavior of "git
show-branch" in some "here's how it works now test", then made whatever
non-changes to the format done here.

Presumably this newline mystery would become clear once we'd have
coverage of its reflog codepaths.

