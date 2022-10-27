Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0456ECAAA1
	for <git@archiver.kernel.org>; Thu, 27 Oct 2022 18:09:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235779AbiJ0SJq (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 27 Oct 2022 14:09:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40268 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235332AbiJ0SJp (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 27 Oct 2022 14:09:45 -0400
Received: from mail-pg1-x534.google.com (mail-pg1-x534.google.com [IPv6:2607:f8b0:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0534E14037
        for <git@vger.kernel.org>; Thu, 27 Oct 2022 11:09:42 -0700 (PDT)
Received: by mail-pg1-x534.google.com with SMTP id s196so2303321pgs.3
        for <git@vger.kernel.org>; Thu, 27 Oct 2022 11:09:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=akMGvTk6+MfRfK21lt+9X8CjrJASZ8o2geYT0pjo4TQ=;
        b=g3y7WcsJN4jvu35FTZzzJGL7Iq04VLmfyAKTD9XsdmLqGRYBupjGYmDcst0jJ9kLwl
         U+zlvc6eIt8yUepsbZnlRAIu3qJLifPAy/RQYSQ0/zQqGQpmvKzeaW0UpVTPle6nDvP0
         1+hwsHGgnXmLhiSGjJaGYMZDS49pEH/jXJqqskAane/BG1rdmgf8AKxcxKi0odkPwZ9t
         OBoC4YdEZjBZE1LYeUujKA+WHT/f7X2lbcSG7BXxhNONY/GC0YIhyIfJFeT2RzVmTH6B
         osA1ImyZyj7/Dri/C1mMpcSyD+Tm01IfxKcx7cfGbOSxzth6JMrTYvnO1z8lUmSyYCaH
         9mRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=akMGvTk6+MfRfK21lt+9X8CjrJASZ8o2geYT0pjo4TQ=;
        b=oj3JFsKcAtNoOa2q7qntus7tJ0D/mdb7/2Pj2MWlYXP0eMaa7XcSqp1q4QJVS3eVtB
         8mR8VJ81DtyQ5kJc/NIBPR1P5F3jEhmynwp8J63bVvJFMcf6r+KWw/Z+NK24aR/yRAgJ
         IEC6sbhZqDcj20peU4lfF6nS5dXt1Pkfd4VfqxPQ24jNudAKs6kIA6o2pcslSt9el4Sp
         fXuhQfZDcvr8aaYFVxnu2YyzHiFgJoaanC3vzJ5SUKYAp4g0NBBaD7eqkHHfETwC4yjW
         JYHkeVSUa8EB199mchjfDpTDjYukQqcGy4cV2Ie8qagNAaNACRHEPM4AfR92mdyL3dv8
         UNtA==
X-Gm-Message-State: ACrzQf1JoCbh17dzYelthjFf4F3AffvCcoY1w9zZWbfyfiHCT4Kn+J+0
        lAJp3TiG9gTvd9Us8sNkers=
X-Google-Smtp-Source: AMsMyM7TQsbE+rpqOVHU857mBfRaY3NrC36xh7/Jy2ai11SYd7zv8YFGAiqjuAgwMJAtOnM5JtZvvg==
X-Received: by 2002:a05:6a00:e1b:b0:537:7c74:c405 with SMTP id bq27-20020a056a000e1b00b005377c74c405mr50512078pfb.43.1666894181354;
        Thu, 27 Oct 2022 11:09:41 -0700 (PDT)
Received: from localhost (33.5.83.34.bc.googleusercontent.com. [34.83.5.33])
        by smtp.gmail.com with ESMTPSA id c4-20020a170902d48400b00186acb14c4asm1517893plg.67.2022.10.27.11.09.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Oct 2022 11:09:40 -0700 (PDT)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     "Kyle Zhao via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Elijah Newren <newren@gmail.com>,
        Kyle Zhao <kylezhao@tencent.com>
Subject: Re: [PATCH] merge-tree.c: add --merge-base=<commit> option
References: <pull.1397.git.1666872761355.gitgitgadget@gmail.com>
Date:   Thu, 27 Oct 2022 11:09:39 -0700
In-Reply-To: <pull.1397.git.1666872761355.gitgitgadget@gmail.com> (Kyle Zhao
        via GitGitGadget's message of "Thu, 27 Oct 2022 12:12:41 +0000")
Message-ID: <xmqqczadm93w.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Kyle Zhao via GitGitGadget" <gitgitgadget@gmail.com> writes:

> diff --git a/Documentation/git-merge-tree.txt b/Documentation/git-merge-tree.txt
> index d6c356740ef..e762209b76d 100644
> --- a/Documentation/git-merge-tree.txt
> +++ b/Documentation/git-merge-tree.txt
> @@ -64,6 +64,10 @@ OPTIONS
>  	share no common history.  This flag can be given to override that
>  	check and make the merge proceed anyway.
>  
> +--merge-base=<commit>::
> +	Instead of finding the merge-bases for <branch1> and <branch2>,
> +	specify a merge-base for the merge.

I like adding and exposing this feature to allow the end-user
specify which commit to use as the base (instead of allowing the
tool compute it from the two branches), but I wonder if a new option
is even needed.

In the original "trivial merge" mode, the command takes three trees
without having to have this new option.  In the new "write-tree"
mode, currently it is incapable of taking the base, but it does not
have to stay that way.  Wouldn't it be sufficient to update the UI
to

    git merge-tree [--write-tree] [<options>] [<base-commit>] <branch1> <branch2>
    git merge-tree [--trivial-merge] <base-commit> <branch1> <branch2>

IOW, when you want to supply the base, you'd be explicit and ask for
the new "write-tree" mode, i.e.

    $ git merge-tree --write-tree $(git merge-base branch^ branch) HEAD branch 

would be how you would use merge-tree to cherry-pick the commit at
the tip of the branch on top of the current commit.

> @@ -402,6 +403,7 @@ struct merge_tree_options {
>  	int allow_unrelated_histories;
>  	int show_messages;
>  	int name_only;
> +	char* merge_base;

Style.  We write in C, not in C++, and our asterisks stick to
variables and members of structs, not types.

> -	/*
> -	 * Get the merge bases, in reverse order; see comment above
> -	 * merge_incore_recursive in merge-ort.h
> -	 */
> -	merge_bases = get_merge_bases(parent1, parent2);
> +	if (o->merge_base) {
> +		struct commit *c = lookup_commit_reference_by_name(o->merge_base);
> +		if (!c)
> +			die(_("could not lookup commit %s"), o->merge_base);
> +		commit_list_insert(c, &merge_bases);

Curious.  The original code unconditionally assigned merge_bases, so
there wasn't a good reason to initialize the variable before this point,
but this new code assumes that merge_bases to be initialized to NULL.

Luckily, it is initialized in the original code, even though it
wasn't necessary at all.  So this new code can work correctly.
Good.

> +	} else {
> +		/*
> +		 * Get the merge bases, in reverse order; see comment above
> +		 * merge_incore_recursive in merge-ort.h
> +		 */
> +		merge_bases = get_merge_bases(parent1, parent2);
> +	}

Yes, this feature was very much lacking and is a welcome addition.

I also have to wonder how this should interact with a topic that is
in-flight to feed multiple merge-tree requests from the standard
input to have a single process perform multiple (not necessarily
related) merges.  Elijah knows much better, but my gut feeling is
that it shouldn't be hard to allow feeding an extra commit on the
same line to be used as the base.

Thanks.
