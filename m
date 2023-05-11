Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E163C77B7C
	for <git@archiver.kernel.org>; Thu, 11 May 2023 19:35:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239216AbjEKTfA (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 11 May 2023 15:35:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53416 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232629AbjEKTe6 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 11 May 2023 15:34:58 -0400
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com [IPv6:2607:f8b0:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 616477ED6
        for <git@vger.kernel.org>; Thu, 11 May 2023 12:34:54 -0700 (PDT)
Received: by mail-pl1-x62b.google.com with SMTP id d9443c01a7336-1ab01bf474aso69398455ad.1
        for <git@vger.kernel.org>; Thu, 11 May 2023 12:34:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1683833694; x=1686425694;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=HuvKv5kBFTPDGsyzXXgZ0/Eozrn9iPl98eabMPIXw+k=;
        b=Qf0iKyZyDEYtaBzJhUvMeiR9/C7TK0um2HENZczmCqPi43xIwGzB9tMUJxLxmgJLJ9
         b6pj/bwVKO61Nj3THDWKCWuvDF8ufRSUg3TlA14qWkZAMzKqEAN7e5J+C+IGYJMBf4mZ
         OqBGGt+zTpR20sfcNAfH03K6AbkEBe5TYy5zvVL6YYel98H94qdb1MxbFyx+yQ7qzSsP
         MnEMBDiq0dSvQVzK3a+8FMqsJc/DwMxhAmV3m/l2DqFBq9QLAzBbO6cX1qxKIxjCTYZZ
         Ama1ITBYAmh9gQpn+OI34s49KDf23QsdwXB+6x4+6LBWdeNltd3MAHxluLczzvtQa5rS
         Vynw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683833694; x=1686425694;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=HuvKv5kBFTPDGsyzXXgZ0/Eozrn9iPl98eabMPIXw+k=;
        b=GK6IRuGxxjfGKd7Z7Jgv8nyYqWb0SJnAPC93iMBmtrS7N+y+WHe0+VJ43RS/n+U6GC
         FVreQTIWW4nV/uHPJRfwsiWI0frYcbkzpfWLdKVC0R+oet5Fl0LlHBuIRT0hOlR/fGrv
         r0pwJKECBAlrBSGgHvPnsZiD6TasTCIahHTI6xBGzeS4clqx8LipwzdTMT4qGLbI9qmh
         IFZH8cUo65gvyI1OQ52jezJTYKlgrup/kZKXgiUJh2ZVXo2DjamV/lxur9BTRwTkQMof
         Qw7zZSneXsYvCCcZRgHxU6tyxRvLjzM+P3HtAeJU/bsCSELrnASP5Atd3duiNKbquA3D
         8vSQ==
X-Gm-Message-State: AC+VfDw+J48fKmL8PZnftsaHA46qdxdqanP8LTif9zqETwxnct0wM34E
        uvNZPr18f9hHPDENehbf1ig=
X-Google-Smtp-Source: ACHHUZ7TqMoAyZntjvul8ty40ZV35omgNlvd91+6S2tRskkBSaX+Q6jMQzvVEnIPZ8urKRtxZr5UHg==
X-Received: by 2002:a17:902:f543:b0:1ac:6084:1f4 with SMTP id h3-20020a170902f54300b001ac608401f4mr26734009plf.27.1683833693776;
        Thu, 11 May 2023 12:34:53 -0700 (PDT)
Received: from localhost (187.137.203.35.bc.googleusercontent.com. [35.203.137.187])
        by smtp.gmail.com with ESMTPSA id d7-20020a170903230700b001a661000398sm6312858plh.103.2023.05.11.12.34.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 May 2023 12:34:53 -0700 (PDT)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     "John Cai via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Christian Couder <christian.couder@gmail.com>,
        John Cai <johncai86@gmail.com>
Subject: Re: [PATCH v3 2/4] pack-refs: teach --exclude option to exclude
 refs from being packed
References: <pull.1501.v2.git.git.1683659931.gitgitgadget@gmail.com>
        <pull.1501.v3.git.git.1683828635.gitgitgadget@gmail.com>
        <8c5c66a3050ee1c0ce8a48a088f5ecc2df7d1e3a.1683828635.git.gitgitgadget@gmail.com>
Date:   Thu, 11 May 2023 12:34:53 -0700
In-Reply-To: <8c5c66a3050ee1c0ce8a48a088f5ecc2df7d1e3a.1683828635.git.gitgitgadget@gmail.com>
        (John Cai via GitGitGadget's message of "Thu, 11 May 2023 18:10:32
        +0000")
Message-ID: <xmqqzg6avezm.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"John Cai via GitGitGadget" <gitgitgadget@gmail.com> writes:

> From: John Cai <johncai86@gmail.com>
>
> At GitLab, we have a system that creates ephemeral internal refs that
> don't live long before getting deleted. Having an option to exclude
> certain refs from a packed-refs file allows these internal references to
> be deleted much more efficiently.
>
> Add an --exclude option to the pack-refs builtin, and use the ref
> exclusions API to exclude certain refs from being packed into the final
> packed-refs file
>
> Signed-off-by: John Cai <johncai86@gmail.com>
> ---
>  Documentation/git-pack-refs.txt | 12 +++++++++++-
>  builtin/pack-refs.c             | 20 ++++++++++++++++----
>  refs.c                          |  4 ++--
>  refs.h                          |  7 ++++++-
>  refs/debug.c                    |  4 ++--
>  refs/files-backend.c            | 16 ++++++++++------
>  refs/packed-backend.c           |  2 +-
>  refs/refs-internal.h            |  3 ++-
>  revision.h                      |  2 +-
>  t/helper/test-ref-store.c       |  3 ++-
>  t/t3210-pack-refs.sh            | 16 ++++++++++++++++
>  11 files changed, 69 insertions(+), 20 deletions(-)

Nice.

> diff --git a/Documentation/git-pack-refs.txt b/Documentation/git-pack-refs.txt
> index e011e5fead3..c0f7426e519 100644
> --- a/Documentation/git-pack-refs.txt
> +++ b/Documentation/git-pack-refs.txt
> @@ -8,7 +8,7 @@ git-pack-refs - Pack heads and tags for efficient repository access
>  SYNOPSIS
>  --------
>  [verse]
> -'git pack-refs' [--all] [--no-prune]
> +'git pack-refs' [--all] [--no-prune] [--exclude <pattern>]
>  
>  DESCRIPTION
>  -----------
> @@ -60,6 +60,16 @@ interests.
>  The command usually removes loose refs under `$GIT_DIR/refs`
>  hierarchy after packing them.  This option tells it not to.
>  
> +--exclude <pattern>::
> +
> +Do not pack refs matching the given `glob(7)` pattern. Repetitions of this option
> +accumulate exclusion patterns. Use `--no-exclude` to clear and reset the list of
> +patterns. If a ref is already packed, including it with `--exclude` will not
> +unpack it.
> +
> +When used with `--all`, it will use the difference between the set of all refs,
> +and what is provided to `--exclude`.
> +

Just one question.  Does the above get formatted correctly, or does
the lack of a line with a sole '+' on it between the paragraphs make
the second paragraph look as if it is unrelated to the description
of the "--exclude" option?

Other than that I saw nothing surprising or unexpected in the
patch.  Looking good.

Thanks.
