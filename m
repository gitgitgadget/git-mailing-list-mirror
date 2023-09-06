Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7845FEE14B0
	for <git@archiver.kernel.org>; Wed,  6 Sep 2023 16:39:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243290AbjIFQjg (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 6 Sep 2023 12:39:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57310 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231196AbjIFQjf (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 6 Sep 2023 12:39:35 -0400
Received: from mail-lf1-x12b.google.com (mail-lf1-x12b.google.com [IPv6:2a00:1450:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BBB2F10F7
        for <git@vger.kernel.org>; Wed,  6 Sep 2023 09:39:31 -0700 (PDT)
Received: by mail-lf1-x12b.google.com with SMTP id 2adb3069b0e04-500760b296aso1444176e87.0
        for <git@vger.kernel.org>; Wed, 06 Sep 2023 09:39:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1694018370; x=1694623170; darn=vger.kernel.org;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=XO71e8AESFzFYsz+blN3ez7xRBNxKwrPQ8qWHUvniic=;
        b=lKoG8NTtZRSMRWPtUkEmNxLI1hUDWuy64GzBr/kooYYRGWhx9PmJ3+PFlS7Q+HKxeT
         gB5V9LHnRh9vP/OmmhG/vVaGiO9YJ6D3T2JC11aEP4B0vW9MevZMz37NCo22SIOQI3EW
         P5yedKOyWW9t1FZS0JcnvKdrmiiOP3bF9/4MUjOU9Hy1TFtMRwoIpeCXVIBUhE3CRejP
         aSJ7HBZ2uE8uUlM3ez23qzROlSYZXC9CMJ7e9svIwAmE1QIlmImVuLO2ixr8ZpZsL9nB
         ZO1PQTI76Jhc202fFudsqcFVAcG290kn7MEq83KMBEBkNiGdEcyCTFVNHtpvaeCpNgKA
         w3EA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1694018370; x=1694623170;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XO71e8AESFzFYsz+blN3ez7xRBNxKwrPQ8qWHUvniic=;
        b=TaOoUCuxby5+9ipiw6RK1kNR1zHBSutsYuzJnbRg5soC6gFennWJtiJ83IcWtpyrZY
         XV+2tFIXUnahbbS+UBYK61i8FQ1/8Nopzo5dZsQBaz8YvvkCtFYwvyjvg+tILzpG/viD
         RLLzdyQinWCSmGKmY5XpaeDLXk/nFnKG1TrkREiADZ/9s1yOk30h9VhMG2Z1/OXJvmrX
         M7JPGdfRQJZiMUUPACx+nmCOWu7PhJ3pVcxcSLNepcBCPV1RQDuQ1JwQj0T9SqY270uT
         WuMmOuG+eLUpg2TI/CAFMiw7h8E/iaVT2lteAv2e9A6g8FFP9DC0yUAXo63arLSn8dcI
         X2YQ==
X-Gm-Message-State: AOJu0YzoI8vhOPDL2ZMfuKtZftCk0f3UiFWy+Qe53pVo6v+GQxhOxog9
        IxddQ0w9Ajp+YUQeBW7uDx7OjF/uYVQ=
X-Google-Smtp-Source: AGHT+IF6s8dGossEcDRY1uJvVhxY784pCOmS/1gr03T6OePUrdPu4N5V5Ck8mxLgc71dThAmBSCYmQ==
X-Received: by 2002:a05:6512:3b10:b0:500:af82:7ddc with SMTP id f16-20020a0565123b1000b00500af827ddcmr36739lfv.28.1694018369444;
        Wed, 06 Sep 2023 09:39:29 -0700 (PDT)
Received: from osv.localdomain ([89.175.180.246])
        by smtp.gmail.com with ESMTPSA id r1-20020ac25a41000000b004fcdf8b8ab4sm2811431lfn.23.2023.09.06.09.39.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Sep 2023 09:39:28 -0700 (PDT)
From:   Sergey Organov <sorganov@gmail.com>
To:     "Kristoffer Haugsbakk" <code@khaugsbakk.name>
Cc:     "Eric Sunshine" <sunshine@sunshineco.com>,
        "Tao Klerks" <tao@klerks.biz>,
        "Johannes Schindelin" <Johannes.Schindelin@gmx.de>,
        "Taylor Blau" <me@ttaylorr.com>, "Patrick Steinhardt" <ps@pks.im>,
        git <git@vger.kernel.org>
Subject: Re: Is "bare"ness in the context of multiple worktrees weird?
 Bitmap error in git gc.
References: <CAPMMpoixKnr4BkKd8jeU+79Edhqtu4R7m8=BX4ZSYKdBHDzK=w@mail.gmail.com>
        <b5833396-7e04-465f-96f6-69d5280fa023@app.fastmail.com>
        <CAPig+cQoiqeZF52Jr45an+cZF+ZQbHPXtLVn+VmyegjMQaJqCg@mail.gmail.com>
        <2ba66542-9ae2-4b13-ae6b-f37dec6b72c7@app.fastmail.com>
Date:   Wed, 06 Sep 2023 19:39:27 +0300
In-Reply-To: <2ba66542-9ae2-4b13-ae6b-f37dec6b72c7@app.fastmail.com>
        (Kristoffer Haugsbakk's message of "Wed, 06 Sep 2023 18:00:26 +0200")
Message-ID: <87edjbuugw.fsf@osv.gnss.ru>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Kristoffer Haugsbakk" <code@khaugsbakk.name> writes:


[...]

> -- >8 --
> Subject: [PATCH] Try to reword what a worktree is
>
> ---
>  Documentation/glossary-content.txt | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
>
> diff --git a/Documentation/glossary-content.txt b/Documentation/glossary-content.txt
> index 5a537268e2..5e192fb5dc 100644
> --- a/Documentation/glossary-content.txt
> +++ b/Documentation/glossary-content.txt
> @@ -694,10 +694,14 @@ The most notable example is `HEAD`.
>  	plus any local changes that you have made but not yet committed.
>
>  [[def_worktree]]worktree::
> -	A repository can have zero (i.e. bare repository) or one or
> +	A repository can have zero or one or
>  	more worktrees attached to it. One "worktree" consists of a
>  	"working tree" and repository metadata, most of which are
>  	shared among other worktrees of a single repository, and
>  	some of which are maintained separately per worktree
>  	(e.g. the index, HEAD and pseudorefs like MERGE_HEAD,
>  	per-worktree refs and per-worktree configuration file).
> ++
> +Note that the directory tree of a <<def_bare_repository,bare_repository>>
> +may have linked worktrees, but cannot itself be a worktree since it has no
> +working tree.

Reading this with a fresh eye, I wonder if we'd better distinguish
between "inline" worktree and "attached" worktrees?

As I see it, in fact a repository can have zero (i.e. bare repository)
or one inline worktree, as well as zero or more attached worktrees.

-- 
Sergey Organov
