Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6AAB3C77B7C
	for <git@archiver.kernel.org>; Tue,  9 May 2023 21:34:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235875AbjEIVeD (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 9 May 2023 17:34:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55394 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236148AbjEIVd7 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 9 May 2023 17:33:59 -0400
Received: from mail-pf1-x42d.google.com (mail-pf1-x42d.google.com [IPv6:2607:f8b0:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 990835B97
        for <git@vger.kernel.org>; Tue,  9 May 2023 14:33:33 -0700 (PDT)
Received: by mail-pf1-x42d.google.com with SMTP id d2e1a72fcca58-6434e65d808so6791550b3a.3
        for <git@vger.kernel.org>; Tue, 09 May 2023 14:33:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1683667983; x=1686259983;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=fLRgJeNXe9fKQ5xyjW5sovbSn4cZv98a6bCV4aBg6A8=;
        b=iQ5j+dAZVsoIDvsZuOR+DWK7t5X1IYW1jH9nj+S3bjc11bgI18zGwn8KgXX5vzx1dQ
         1938mhXQ4Whq0ZokXAv29ColsnuUzvC+NhtLd2EaX6QKwWoNAw9M+B6glFrNGlMOu8Z3
         FPAqo6lkPYrcxCN5yPCHE6Ed7eNBSk2hyzF4ogIMw7jwFzus17U7kOa2H8NJojR09KVE
         V8Zt8axQpuTCtLVjWXovI3lto3UtDYwPSPHKVdaKvUjrBWSHYmjubHDyz0WcmCLQmQDH
         rEvR4awt9waO77zMbG27sPtuyJfJs3o7tFJLEPjcctPFs3XTQEsS2dzUAntSEPmZLkqb
         cJXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683667983; x=1686259983;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=fLRgJeNXe9fKQ5xyjW5sovbSn4cZv98a6bCV4aBg6A8=;
        b=LiSFEXIP/9DP8slv2cCPnZD58LZidGWgt4O6iP3nWTIc+9NIlA2dILmJEdPW3EArPt
         +7C8lJ7l+QXCb7SrH+wMI/q2anuLw8HAlD4mLIOzpJZP34rC/bnfysPwcj4nFm+xSMS9
         WFawv9AzmRELNBWxTtGiFMBnhajfRxkHPS8fd77LUvsI0OSaRdn8HdkFGzEP2PG4qtR+
         /70XwEn5P1rjWWOgEnOVYT7hnYV97bLWDsdtbfsv96Ltc99sOctdowpU4lCsaqaa0CPB
         efedZ0inmoVSk8V8dqAFJ5XCEmXVQk1Ll0BO9a2xiSfYgH6KvmJR4lMreKBDDPR5lPtq
         pKxg==
X-Gm-Message-State: AC+VfDwpxCbHCl0Qpo3/CskcKiOhfz5yv91nXbCoALhXUSUdvWq8wmMz
        EM/22y5vf9j2muSMiMRk98RMaXrImtw=
X-Google-Smtp-Source: ACHHUZ5l03wo0LcWK/kegHe65fiYBCf0yEk4kDiVmLnA1AwDozOaFiMR8cqs8rdomiUdNfFADlqOfw==
X-Received: by 2002:a17:902:e549:b0:1ab:d6f:51b0 with SMTP id n9-20020a170902e54900b001ab0d6f51b0mr19003448plf.18.1683667526965;
        Tue, 09 May 2023 14:25:26 -0700 (PDT)
Received: from localhost (187.137.203.35.bc.googleusercontent.com. [35.203.137.187])
        by smtp.gmail.com with ESMTPSA id jj18-20020a170903049200b001ac2f98e953sm2064187plb.216.2023.05.09.14.25.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 May 2023 14:25:26 -0700 (PDT)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     "John Cai via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Christian Couder <christian.couder@gmail.com>,
        John Cai <johncai86@gmail.com>
Subject: Re: [PATCH v2 3/3] pack-refs: teach pack-refs --include option
References: <pull.1501.git.git.1683215331910.gitgitgadget@gmail.com>
        <pull.1501.v2.git.git.1683659931.gitgitgadget@gmail.com>
        <03950e8f120e48b7df68f3273bbb2f7bb1e9073d.1683659931.git.gitgitgadget@gmail.com>
Date:   Tue, 09 May 2023 14:25:26 -0700
In-Reply-To: <03950e8f120e48b7df68f3273bbb2f7bb1e9073d.1683659931.git.gitgitgadget@gmail.com>
        (John Cai via GitGitGadget's message of "Tue, 09 May 2023 19:18:51
        +0000")
Message-ID: <xmqqo7mturi1.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"John Cai via GitGitGadget" <gitgitgadget@gmail.com> writes:

> +--include <pattern>::
> +
> +Pack refs based on a `glob(7)` pattern. Repetitions of this option
> +accumulate inclusion patterns. If a ref is both included in `--include` and
> +`--exclude`, `--exclude` takes precedence. Using `--include` does not preclude
> +all tags from being included by default. Symbolic refs and broken refs will never
> +be packed. When used with `--all`, it will be a noop. Use `--no-include` to clear
> +and reset the list of patterns.

Hmph, that was a bit unexpected.  exclude taking precedence over
include is very much in line with how negative pathspec works and
the end-users should be familiar with it, but when the user bothers
to specify with --include what to include, I would have expected
that the "pack tags by default" would be defeated.

In other words, I would have expected that the program acts as if
the machinery works this way (iow, the code does not have to exactly
implement it this way---it just has to behave as if it did):

 - it maintains two pattern list, positive and negative,
   both start empty.
 - "--exclude" are accumulated to the negative list.
 - "--include" are accumulated to the positive list.
 - "--all" adds "*" to the positive list.
 - after parsing command line options, if the positive list is
   empty, then "refs/tags/*" is added to the positive list.
 - refs that match positive list but does not match negative list
   are shown.

> +When used with `--include`, it will use what is provided to `--include` as well
> +as the the default of all tags and already packed refs, minus refs that are
> +provided to `--exclude`.

IOW, I would expect that the use of "--include" alone is enough to
defeat the default; the end user does not have to figure out that
they have to pass "--exclude=refs/tags/*" to do so when they are
specifying a specific hierarchy to include.

> @@ -66,6 +66,7 @@ struct worktree;
>  struct pack_refs_opts {
>  	unsigned int flags;
>  	struct ref_exclusions *exclusions;
> +	struct string_list *included_refs;

It is unfortunate that the struct is called ref_exclusions to imply
as if it is only usable for excluding refs from listing.  It has
other members for handling hidden refs, and it would have been very
natural to extend it to also add included_refs pattern next to
excluded_refs string list.  After all, the struct is used to tweak
which refs are included and which refs are excluded, and
historically everything was included unless listed on the excluded
pattern.  We are now allowing the "everything is included" part to
be customizable with this step.  If the struct were named with a
more neutral term, like ref_visibility to hint that it is about
setting visibility, then this patch wouldn't have added a separate
string list to this structure---instead it would have extended the
ref_exclusions (with a better name) struct and placed included_refs
string list there.

>  };
>  
>  const char *refs_resolve_ref_unsafe(struct ref_store *refs,
> diff --git a/refs/files-backend.c b/refs/files-backend.c
> index 6a51267f379..3f8974a4a32 100644
> --- a/refs/files-backend.c
> +++ b/refs/files-backend.c
> @@ -1181,6 +1181,17 @@ static int should_pack_ref(const char *refname,
>  	    REF_WORKTREE_SHARED)
>  		return 0;
>  
> +	if (opts->exclusions && ref_excluded(opts->exclusions, refname))
> +		return 0;
> +
> +	if (opts->included_refs && opts->included_refs->nr) {
> +		struct string_list_item *item;
> +
> +		for_each_string_list_item(item, opts->included_refs)
> +			if (!wildmatch(item->string, refname, 0))
> +				return 1;
> +	}

We can see why the initial placement of exclusion logic in the
earlier step was suboptimal here.

>  	/* Do not pack non-tags unless PACK_REFS_ALL is set: */
>  	if (!(opts->flags & PACK_REFS_ALL) && !starts_with(refname, "refs/tags/"))
>  		return 0;
> @@ -1193,9 +1204,6 @@ static int should_pack_ref(const char *refname,
>  	if (!ref_resolves_to_object(refname, the_repository, oid, ref_flags))
>  		return 0;
>  
> -	if (opts->exclusions && ref_excluded(opts->exclusions, refname))
> -		return 0;
> -
>  	return 1;
>  }


Other than that, the changes look mostly expected and no surprises.

Thanks.
