Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 395BBC77B7C
	for <git@archiver.kernel.org>; Fri, 12 May 2023 00:01:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239709AbjELABi (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 11 May 2023 20:01:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52892 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239720AbjELABZ (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 11 May 2023 20:01:25 -0400
Received: from mail-yw1-x1130.google.com (mail-yw1-x1130.google.com [IPv6:2607:f8b0:4864:20::1130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 60CF07298
        for <git@vger.kernel.org>; Thu, 11 May 2023 17:00:56 -0700 (PDT)
Received: by mail-yw1-x1130.google.com with SMTP id 00721157ae682-55a10577911so135044547b3.0
        for <git@vger.kernel.org>; Thu, 11 May 2023 17:00:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20221208.gappssmtp.com; s=20221208; t=1683849625; x=1686441625;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ODzvNdWFY1cWPde5K0Z3NTNKGGleaxtNzlSy/H5m5b8=;
        b=s/btNhrt/G+iCgANt9akzWAzooWW6WIOT/P/y1YZ87ZmJmGq03fOcBrkRWzfq6PFs/
         iOgBoEoGTFaSFdyVsXbKTTH04zwLqnMv+KcEeRGuy+jC+oULeMaaT+i/Bxq+RC7Gv/Qd
         ldt87sz1gerxIK8kxzWEYxLf+qx8VKBHqS4lAZU3xdXYWx8M6hAODvKiMy31SZObwzz3
         om38t1w7G6hPBdCKmm8xsG8w+f3ISLLCh2wmwa2TlLEE/wC0cukGBnNhlr7YDNS5BbMD
         hYuJmIFxw0pwbLJklnBjdDvRxKUXrOQUfUlMJf1rDw43+aDaSCQMx5AAqDIzpqpFBmlm
         473w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683849625; x=1686441625;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ODzvNdWFY1cWPde5K0Z3NTNKGGleaxtNzlSy/H5m5b8=;
        b=h0Kn7vkKOYW65oxlvEy5SI/u2AwYNaeE3XN8NntOGVWJfGuj9auxXH5Io7oyPnmlld
         gs8rWZYJVUlW8XkBNkYxNwUHIviocsn9lZPKz4H6Ovnkr3rfU83USim1NCXVUmsoJX1b
         Lo371mv4rzJbfSWgcX4ymcZ05Yk6090rvkXBWqrsco90K2KrlSkCshwaTKKewTOwuBmT
         ku15jYWx7OB6JEe9pZdKLgosmbRE9vzASYYX2rloNpwLtIgbavqGy+TcLDtlRchyeTX8
         rxZDvSAVmNjv+aOoTOObf6S6EnIrl3zT2fDaxA10ghXNr5U2JTgSW6j7mIxB/0hC/sec
         3NSA==
X-Gm-Message-State: AC+VfDz5pQrQ76SVPBc4oyuTXxvCmgzXutb3q3CZQOdC+jJnzOecGXj6
        fus1+L37Kc/iS5Het9X4X4lekw==
X-Google-Smtp-Source: ACHHUZ6b77F48v4fBNjPBWgUNnTUuftSR/2gNX1rNqYyjXxA2AiF8bXE1Qz22XadS+MhqQDaKPEEnQ==
X-Received: by 2002:a81:4f08:0:b0:55a:8037:84ca with SMTP id d8-20020a814f08000000b0055a803784camr25152990ywb.46.1683849625599;
        Thu, 11 May 2023 17:00:25 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id t126-20020a814684000000b0055a21492192sm5323050ywa.115.2023.05.11.17.00.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 May 2023 17:00:25 -0700 (PDT)
Date:   Thu, 11 May 2023 20:00:24 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     John Cai via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Christian Couder <christian.couder@gmail.com>,
        John Cai <johncai86@gmail.com>
Subject: Re: [PATCH v3 2/4] pack-refs: teach --exclude option to exclude refs
 from being packed
Message-ID: <ZF2BmI/SnhfEDB2K@nand.local>
References: <pull.1501.v2.git.git.1683659931.gitgitgadget@gmail.com>
 <pull.1501.v3.git.git.1683828635.gitgitgadget@gmail.com>
 <8c5c66a3050ee1c0ce8a48a088f5ecc2df7d1e3a.1683828635.git.gitgitgadget@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <8c5c66a3050ee1c0ce8a48a088f5ecc2df7d1e3a.1683828635.git.gitgitgadget@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, May 11, 2023 at 06:10:32PM +0000, John Cai via GitGitGadget wrote:
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
>
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

I think this last paragraph could be simplified, though feel free to
discard my suggestion if you think it makes things less clear.

  When used with `--all`, pack only loose refs which do not match any of
  the provided `--exclude` patterns.

>  int cmd_pack_refs(int argc, const char **argv, const char *prefix)
>  {
>  	unsigned int flags = PACK_REFS_PRUNE;
> +	static struct ref_exclusions excludes = REF_EXCLUSIONS_INIT;
> +	struct pack_refs_opts pack_refs_opts = {.exclusions = &excludes, .flags = flags};
> +	static struct string_list option_excluded_refs = STRING_LIST_INIT_NODUP;
> +	struct string_list_item *item;

Since this list does not appear to be sensitive to its order, have you
considered using the strvec API instead of the string_list one?

> diff --git a/refs.c b/refs.c
> index d2a98e1c21f..881a0da65cf 100644
> --- a/refs.c
> +++ b/refs.c
> @@ -2132,9 +2132,9 @@ void base_ref_store_init(struct ref_store *refs, struct repository *repo,
>  }
>
>  /* backend functions */
> -int refs_pack_refs(struct ref_store *refs, unsigned int flags)
> +int refs_pack_refs(struct ref_store *refs, struct pack_refs_opts *opts)
>  {
> -	return refs->be->pack_refs(refs, flags);
> +	return refs->be->pack_refs(refs, opts);
>  }
>
>  int peel_iterated_oid(const struct object_id *base, struct object_id *peeled)
> diff --git a/refs.h b/refs.h
> index 123cfa44244..46020bd335c 100644
> --- a/refs.h
> +++ b/refs.h
> @@ -63,6 +63,11 @@ struct worktree;
>  #define RESOLVE_REF_NO_RECURSE 0x02
>  #define RESOLVE_REF_ALLOW_BAD_NAME 0x04
>
> +struct pack_refs_opts {
> +	unsigned int flags;
> +	struct ref_exclusions *exclusions;

I think this would be OK to include directly in the struct instead of
via a pointer, but either is fine.

> @@ -1175,15 +1176,18 @@ static void prune_refs(struct files_ref_store *refs, struct ref_to_prune **refs_
>   */
>  static int should_pack_ref(const char *refname,
>  			   const struct object_id *oid, unsigned int ref_flags,
> -			   unsigned int pack_flags)
> +			   struct pack_refs_opts *opts)
>  {
>  	/* Do not pack per-worktree refs: */
>  	if (parse_worktree_ref(refname, NULL, NULL, NULL) !=
>  	    REF_WORKTREE_SHARED)
>  		return 0;
>
> +	if (opts->exclusions && ref_excluded(opts->exclusions, refname))
> +		return 0;

Looks good, here is where we throw out refs that we don't want. I wonder
if ref_excluded() does the right thing with a zero-initialized argument
(i.e. that it behaves as if nothing matches).

I wonder if it's possible to skip over certain loose references by
avoiding traversal into the sub-directories for simple prefixes. That
may be a premature optimization, though, so I don't think you
necessarily need to worry about it in this round.

> +test_expect_success 'test excluded refs are not packed' '
> +	git branch dont_pack1 &&
> +	git branch dont_pack2 &&
> +	git branch pack_this &&
> +	git pack-refs --all --exclude "refs/heads/dont_pack*" &&
> +	test -f .git/refs/heads/dont_pack1 &&
> +	test -f .git/refs/heads/dont_pack2 &&
> +	! test -f ./git/refs/heads/pack_this'
> +
> +test_expect_success 'test --no-exclude refs clears excluded refs' '
> +	git branch dont_pack3 &&
> +	git branch dont_pack4 &&
> +	git pack-refs --all --exclude "refs/heads/dont_pack*" --no-exclude &&
> +	! test -f .git/refs/heads/dont_pack3 &&
> +	! test -f .git/refs/heads/dont_pack4'

Tests look good. The trailing quote is a little odd to be placed on the
last line of the test instead of off on its own, but I suppose that is
imitating existing style, which is OK.

Thanks,
Taylor
