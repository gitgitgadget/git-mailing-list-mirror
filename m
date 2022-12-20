Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46403C4332F
	for <git@archiver.kernel.org>; Tue, 20 Dec 2022 04:19:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232809AbiLTETy (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 19 Dec 2022 23:19:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39960 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229540AbiLTETv (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 19 Dec 2022 23:19:51 -0500
Received: from mail-pg1-x52c.google.com (mail-pg1-x52c.google.com [IPv6:2607:f8b0:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C125614F
        for <git@vger.kernel.org>; Mon, 19 Dec 2022 20:19:50 -0800 (PST)
Received: by mail-pg1-x52c.google.com with SMTP id f9so7558070pgf.7
        for <git@vger.kernel.org>; Mon, 19 Dec 2022 20:19:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:user-agent:message-id
         :in-reply-to:date:references:subject:cc:to:from:sender:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uYU2qilkJpui0Gddnqpxe3BAXfKzaBjYJCNeUvbB0kI=;
        b=TscOssS063KBZsuf8hn+JT3Z4/6CKvjyO8ZOZAHgDhwnGT0Kkj5lmDCS1aXio/kPPD
         SZYlzng954uuvihspZqFI3ha2/T22jJmAKYoh4zJiOdKk+W45a4zHE4G9FYsbMXxC6f9
         hYZyXQz/iy5Qwl/SsS7yY3RVder/X7wDN7j2Z6BKH648ZSIzaASOkqUjeRACAXSg98tk
         nVzsMIQYbiF3SXqOHnb2IvT4TIviNnF6/4Md5KevGBCXNC0zyBzHZJ1VdRw7ei7/MoWV
         G4y9hOT/+VxKjczH1SkCW91ctZYscCAAO6/7+PMeNQuUyJBI2UMNDN4F1OyNB8GHfQCQ
         9xIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:user-agent:message-id
         :in-reply-to:date:references:subject:cc:to:from:sender
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=uYU2qilkJpui0Gddnqpxe3BAXfKzaBjYJCNeUvbB0kI=;
        b=Z0kkX25fGaPD5n9W8yTJ6Evpd6UVSwg8zSc0HyBFHrxOdPMFyiMElmpHkkvAn+WJYf
         a0AJtmhtprKtJcMdqDpRZHAmocX2U02pXGHxV4c00ua8fvJYcVcQMcOyPU+CgYvbk3kV
         k6RWFHrIWiXvU9bsTdtFHSYGNGMIgZJRApZGA/cJYDIbAxdFO12RaxP1fb6C/mFBE/8j
         JJzUj45oNvDTj4wwSSLmEl6nRStIeLE9Qbmgn/nkDyo4vPihhNID7UkPScqvDLaIVLlQ
         nqpffTWdAx7/aXoIvN/aoujnqLFYNJEcZiX2l5FnEe1Jjq3lbjhJngUPGA1c6yXN7F5y
         A83g==
X-Gm-Message-State: AFqh2kqAhtvOkfmHI/W1opXJt8EwkLWAoiJufYeL0BDPhJ/Y0uuW/7LD
        fZGIantHSezCXBYJ3GYMvJ4=
X-Google-Smtp-Source: AMrXdXtkZc9lI8CSvi7egrTOxE3xkb8dPWuBgRhPNoLxdIJTVaPT4wHtOM/AHlKrFgHUiIKAbBnsdQ==
X-Received: by 2002:a05:6a00:bcb:b0:57f:94e4:5a61 with SMTP id x11-20020a056a000bcb00b0057f94e45a61mr10112638pfu.16.1671509989474;
        Mon, 19 Dec 2022 20:19:49 -0800 (PST)
Received: from localhost (33.5.83.34.bc.googleusercontent.com. [34.83.5.33])
        by smtp.gmail.com with ESMTPSA id s7-20020a625e07000000b0057691fb0d37sm7434152pfb.193.2022.12.19.20.19.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Dec 2022 20:19:48 -0800 (PST)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     Jacob Abel <jacobabel@nullpo.dev>
Cc:     git@vger.kernel.org,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Phillip Wood <phillip.wood123@gmail.com>,
        =?utf-8?Q?Rub=C3=A9n?= Justo <rjusto@gmail.com>,
        Taylor Blau <me@ttaylorr.com>, rsbecker@nexbridge.com
Subject: Re: [PATCH v5 3/4] worktree add: add --orphan flag
References: <20221104010242.11555-1-jacobabel@nullpo.dev>
        <20221104213401.17393-1-jacobabel@nullpo.dev>
        <20221110233137.10414-1-jacobabel@nullpo.dev>
        <20221212014003.20290-1-jacobabel@nullpo.dev>
        <20221220023637.29042-1-jacobabel@nullpo.dev>
        <20221220023637.29042-4-jacobabel@nullpo.dev>
Date:   Tue, 20 Dec 2022 13:19:48 +0900
In-Reply-To: <20221220023637.29042-4-jacobabel@nullpo.dev> (Jacob Abel's
        message of "Tue, 20 Dec 2022 02:38:02 +0000")
Message-ID: <xmqqlen2wvtn.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jacob Abel <jacobabel@nullpo.dev> writes:

> Adds support for creating an orphan branch when adding a new worktree.
> This functionality is equivalent to git switch's --orphan flag.
>
> The original reason this feature was implemented was to allow a user
> to initialise a new repository using solely the worktree oriented
> workflow.
>
> Current Behavior:
>
> % git init --bare foo.git
> Initialized empty Git repository in /path/to/foo.git/
> % git -C foo.git worktree add main/
> Preparing worktree (new branch 'main')
> fatal: not a valid object name: 'HEAD'
> %
>
> New Behavior:
>
> % git init --bare foo.git
> Initialized empty Git repository in /path/to/foo.git/
> % git -C foo.git worktree add --orphan main main/
> Preparing worktree (new branch 'main')
> %

Hmph, I suspect that in reviews for the previous rounds someboddy
must have brought this up, but I wonder if we can detect the case
automatically and behave as if "--orphan" were given.  In other
words, shouldn't the desired outcome (i.e. "worktree add" can be run
to create an orphan branch even when the original were on an unborn
branch) become the new behaviour WITHOUT having the user learn new
option?

If the point of "--orphan" is to create a worktree that checks out a
yet-to-be-bork branch, whether the original is an empty repository
or a populated one, then the user may need "--orphan" option, but
the above illustration is very misleading if that is the intention.

Rather, you should start from a populated repository and explain
that "worktree add" without "--orphan" (i.e. the current behaviour)
does not give you an empty tree with empty history, so run an extra
"switch --orphan" after that.  Then illustrate that you can lose the
last step with the new option "--orphan".

Or something like that.

> Signed-off-by: Jacob Abel <jacobabel@nullpo.dev>
> Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>

This e-mail coming from you and not from Ævar, with you apparently
being the author of the patch, makes these two S-o-b lines
questionable.  What's the chain of custody of the change?  If Ævar
showed some code changes, and you swallowed that into a larger piece
of work (i.e. this patch), then the above two lines are swapped.

