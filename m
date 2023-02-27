Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CCCA9C64ED6
	for <git@archiver.kernel.org>; Mon, 27 Feb 2023 15:58:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229896AbjB0P6L (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 27 Feb 2023 10:58:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43824 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229627AbjB0P6K (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 27 Feb 2023 10:58:10 -0500
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5FB15B75A
        for <git@vger.kernel.org>; Mon, 27 Feb 2023 07:58:09 -0800 (PST)
Received: by mail-pj1-x1029.google.com with SMTP id x34so6657251pjj.0
        for <git@vger.kernel.org>; Mon, 27 Feb 2023 07:58:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=6FCK3uYzS/p1TQ3pcTOTpOJAU0LMiF0OZ31VNKOl25M=;
        b=VikZE6XbveIOHGuR5YxD1KZGPWRjzy+11WlQGy1SwSqFv+RnGnH9hjlJUKnWf1C/6i
         4Xwh+uVmPx9UhFld/0fQFwa6cE0jdeKjGUgHxwIzgmL14qaUQUC3v761CSk4vEz7JhIx
         hjozHxm577pFQjUpoWPKtO51xeQGeSeo8H1uDvxyW7djYPY8EZ5axhgSrZf30/mXtmcU
         x4a4xXEZtQRRr555SyIgcImSDC26gyzhBvppEKVszQ0a4mtJw/gS/d7aL220xIMC93oh
         OUyNF0NoETXuFh4TWr3a8pNYDdqmwgj1BmiUhamAaCBigZBLnGfAU7V9As3lzrI+Qzq6
         FwyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=6FCK3uYzS/p1TQ3pcTOTpOJAU0LMiF0OZ31VNKOl25M=;
        b=Upq/DtsmruTzPwmF02DFzBwmTFOJ6W0Jodf7h3//U+ZmTAOTP66LVzTiv5S8+Rrk5D
         dDslP8KuFkGgjFHGBFCmJuoKkcWJkP1U012HhiFVMqnKvN6vVWE5LfuLcCWJem67HdlW
         KMc4/hshAG33OwxRsCjpC2ifzplEov/fCmuUryjwg5EuGgjj8UUKNkHwIK+gvqY77Eo6
         ZpeMUXV8bhp5HMO6QmO50EXXvOMrroZS7ERwj+EYQmOq9Mfagj4C916kvUxpZNTtuO7D
         KIK3PoXpAB6NqSE21sEyZQFg4DmL80LGRk2bhahhgk51IueqLP/wSzPvGma5n5KRYeEI
         y94g==
X-Gm-Message-State: AO0yUKXZhZNm8LlmUUU5XuoGUsTT10eHC9DyviewNxXoC9H857N0l82F
        0xunf4Aa+CTILwv1hY5gGNjDZo6aEC8=
X-Google-Smtp-Source: AK7set/bpMBbYCSmmeuLu7W9mo1YQGOHiDs9kiPKzQ/8ec8t7TcnMRb03EgdlPrHxQ5a3T8c4ExHiQ==
X-Received: by 2002:a05:6a20:42a7:b0:cc:120c:b259 with SMTP id o39-20020a056a2042a700b000cc120cb259mr19538623pzj.39.1677513488740;
        Mon, 27 Feb 2023 07:58:08 -0800 (PST)
Received: from localhost (252.157.168.34.bc.googleusercontent.com. [34.168.157.252])
        by smtp.gmail.com with ESMTPSA id z19-20020aa785d3000000b005a8a9950363sm4413353pfn.105.2023.02.27.07.58.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Feb 2023 07:58:07 -0800 (PST)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     Johannes Sixt <j6t@kdbg.org>,
        Git Mailing List <git@vger.kernel.org>
Subject: Re: [PATCH 4/3] fsck: check even zero-entry index files
References: <c6246ed5-bffc-7af9-1540-4e2071eff5dc@kdbg.org>
        <Y/hv0MXAyBY3HEo9@coredump.intra.peff.net>
        <xmqqr0uf0y4b.fsf@gitster.g>
        <Y/vdV4bjorvRYoaR@coredump.intra.peff.net>
Date:   Mon, 27 Feb 2023 07:58:07 -0800
In-Reply-To: <Y/vdV4bjorvRYoaR@coredump.intra.peff.net> (Jeff King's message
        of "Sun, 26 Feb 2023 17:29:43 -0500")
Message-ID: <xmqqv8jnt81c.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> The return value here is actually the number of entries read. So it
> makes sense for add_index_objects_to_pending() to ignore a zero-entry
> index (there is nothing to add). But for fsck, we would still want to
> check any extensions, etc (though presumably it is unlikely to have them
> in an empty index, I don't think it's impossible).

Good thinking.

Not all extensions record what needs to be fed to the reachability
machinery for fsck, but resolve-undo wants to record object names
that used to be in the directory (at higher stages) when they are
removed, so I think it is entirely possible for an index with no
entries to have index extensions that fsck needs to pay attention
to.

> So we should ignore the return value from read_index_from() entirely.
> This matches the behavior before fb64ca526a, when we ignored the return
> value from repo_read_index().

Good.  Thanks.

>
> Signed-off-by: Jeff King <peff@peff.net>
> ---
> On top of jk/fsck-indices-in-worktrees.
>
>  builtin/fsck.c | 5 ++---
>  1 file changed, 2 insertions(+), 3 deletions(-)
>
> diff --git a/builtin/fsck.c b/builtin/fsck.c
> index 1b032eebb1..64614b43b2 100644
> --- a/builtin/fsck.c
> +++ b/builtin/fsck.c
> @@ -1007,9 +1007,8 @@ int cmd_fsck(int argc, const char **argv, const char *prefix)
>  			 * while we're examining the index.
>  			 */
>  			path = xstrdup(worktree_git_path(wt, "index"));
> -			if (read_index_from(&istate, path,
> -					    get_worktree_git_dir(wt)) > 0)
> -				fsck_index(&istate, path, wt->is_current);
> +			read_index_from(&istate, path, get_worktree_git_dir(wt));
> +			fsck_index(&istate, path, wt->is_current);
>  			discard_index(&istate);
>  			free(path);
>  		}
