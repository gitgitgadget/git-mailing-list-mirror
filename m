Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 46BF920248
	for <e@80x24.org>; Mon, 11 Mar 2019 07:28:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726820AbfCKH2x (ORCPT <rfc822;e@80x24.org>);
        Mon, 11 Mar 2019 03:28:53 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:54707 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726623AbfCKH2x (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 11 Mar 2019 03:28:53 -0400
Received: by mail-wm1-f67.google.com with SMTP id f3so3236852wmj.4
        for <git@vger.kernel.org>; Mon, 11 Mar 2019 00:28:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=kyTtak6a+fj0Rafem4xmMPoSsJI+SyBAXuExtf0bhQc=;
        b=NcNRNgpzIQ3csi82wrjA596rl8x7HDbhJdFdlC0MWmFh5cxSa6XtHGk0vhRs5MLNCs
         rvWs8jvC/bfW3PpEaCqPYHAvqPoweaDhQHoaoJomXaZluV04j16qp+aGjfCvlPEvCj6s
         wcWhhqjep5T7CagVyu+nHmWWQga/7ATautOIKwSc7fNkTRKM+GBIDY7M7V+XIP4EPPFq
         QL7gKENftsnEMttBNK3AQuC3ifQ+5snvIoisdLLxSCYaKj7xi34AtSPb8y2eUE6VaHIi
         QnwvzEBxxpqevnrz2Zhp3ZN9DjjSg3ckmTOPJnq8oJC2EMN8UEBSkgajtk29X2yvg/X5
         HjNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=kyTtak6a+fj0Rafem4xmMPoSsJI+SyBAXuExtf0bhQc=;
        b=MSUzJgM+mE15bvXzQ+bOIeB7WzPD93U92VrcVljLJQOzwo4J/XV1MJ+GHuL8GWcpAp
         ePCYbsMuiUvFPGOFELvc77guKSXebwrZUkO1NjcxE0xPhA6el4jN8LNcH4mwWsJsQIxD
         JbSi1B0RTl6wDyq2EJMQMS3eDrVpwrmVKoXv7GFS8t3+StW7IVHZI/hd9gPwSAET0tM6
         ag5uMVcuz4Bup3Ds6moQZRdSNRxYFica1MMNsYEPMUtsVR4HEf8O4OrgsqWpWcimmOs5
         5YUP+dnRVrR2LxYoUKfcCjRbea6WHsG7DHd9kjAc3FovKjjLkdja9jg9oX1fnISdMgZw
         93pg==
X-Gm-Message-State: APjAAAXOJj5/SpaCUfaRdY8nx7YrAKoI0gTRq5cA/EVr93nEq8naFG4+
        3pwn+C5k3w6Uo+KvJoaZytk=
X-Google-Smtp-Source: APXvYqxBq4mzlosiZTQb/EygdYseueDynrSB5MN8oEacXdT5ZL74cKS43jKIDLofAXuTtuqukepvXA==
X-Received: by 2002:a1c:1b8a:: with SMTP id b132mr16067536wmb.138.1552289330477;
        Mon, 11 Mar 2019 00:28:50 -0700 (PDT)
Received: from localhost (141.255.76.34.bc.googleusercontent.com. [34.76.255.141])
        by smtp.gmail.com with ESMTPSA id h10sm7407697wrs.12.2019.03.11.00.28.49
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 11 Mar 2019 00:28:49 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH 2/2] built-in stash: handle :(glob) pathspecs again
References: <pull.159.git.gitgitgadget@gmail.com>
        <7b5cca61dea4f01f9bcdcb6d5d2a913d58a341d3.1551972571.git.gitgitgadget@gmail.com>
Date:   Mon, 11 Mar 2019 16:28:49 +0900
In-Reply-To: <7b5cca61dea4f01f9bcdcb6d5d2a913d58a341d3.1551972571.git.gitgitgadget@gmail.com>
        (Johannes Schindelin via GitGitGadget's message of "Thu, 07 Mar 2019
        07:29:33 -0800 (PST)")
Message-ID: <xmqqh8c9kgy6.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
writes:

> From: Johannes Schindelin <johannes.schindelin@gmx.de>
>
> When passing a list of pathspecs to, say, `git add`, we need to be
> careful to use the original form, not the parsed form of the pathspecs.
>
> This makes a difference e.g. when calling
>
> 	git stash -- ':(glob)**/*.txt'
>
> where the original form includes the `:(glob)` prefix while the parsed
> form does not.
>
> However, in the built-in `git stash`, we passed the parsed (i.e.
> incorrect) form, and `git add` would fail with the error message:
>
> 	fatal: pathspec '**/*.txt' did not match any files
>
> at the stage where `git stash` drops the changes from the worktree, even
> if `refs/stash` has been actually updated successfully.
>
> This fixes https://github.com/git-for-windows/git/issues/2037
>
> Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
> ---
>  builtin/stash.c                    | 5 +++--
>  t/t3905-stash-include-untracked.sh | 6 ++++++
>  2 files changed, 9 insertions(+), 2 deletions(-)
>
> diff --git a/builtin/stash.c b/builtin/stash.c
> index 1bfa24030c..2f29d037c8 100644
> --- a/builtin/stash.c
> +++ b/builtin/stash.c
> @@ -830,7 +830,7 @@ static void add_pathspecs(struct argv_array *args,
>  	int i;
>  
>  	for (i = 0; i < ps.nr; i++)
> -		argv_array_push(args, ps.items[i].match);
> +		argv_array_push(args, ps.items[i].original);
>  }

Yup.  I think Thomas and Peff were also looking at the vicinity of
this code wrt the pass-by-value-ness of ps parameter.  Their fix
need to also come on top of this (or combined together).
