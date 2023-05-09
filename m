Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7EF82C7EE22
	for <git@archiver.kernel.org>; Tue,  9 May 2023 21:04:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235239AbjEIVEu (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 9 May 2023 17:04:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56262 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235628AbjEIVEs (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 9 May 2023 17:04:48 -0400
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17946268A
        for <git@vger.kernel.org>; Tue,  9 May 2023 14:04:33 -0700 (PDT)
Received: by mail-pj1-x1031.google.com with SMTP id 98e67ed59e1d1-24df758db1cso4444093a91.2
        for <git@vger.kernel.org>; Tue, 09 May 2023 14:04:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1683666273; x=1686258273;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=KxBF4Ot/gVdUuMqLgmdXTprMLqvj6D4g+yzUU+WBJBc=;
        b=ietKieUH/jk0BqRIp3qp3AnYKMjkPRpSH6EgaqBOP08bQkPbbd1K2IuRBoE96r8S7w
         ca3kY0klb5+cv8fwPQAsaWicwMAXI1przRPdaKLlHljP6aj8xRd+elWYpEnAfXiCIOdU
         rrVqhb4yJHODr5A3jigl7vwOXc42hE0B+H6LRQEN5cIW51jsgGSDhgg3pK+7785hczaP
         3quGPXXg6ooa5zm2bDfZHNY61Vm62rxG2Pl+GgIdhQUUKzbvi9aC2MuAnqdZS63sVayq
         5hV1m9u6IFRjyzSUOwfDwNuBux7zg2FbQLrvKRcfn5KOSad8tmwEikYoY0F1A6ovIfeZ
         ++bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683666273; x=1686258273;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=KxBF4Ot/gVdUuMqLgmdXTprMLqvj6D4g+yzUU+WBJBc=;
        b=Jly/IKWiWQSASXpTeMysxoPDCbix3c3nyH4hx7cRBsX/y4IiILnh7WdWFyStZehLZe
         Z9QuyN94fXpfXzfetxLXjeJgz1Hghkj3h7nxRkGXvzEf7+foCc1fTB4+yEQ23rNAfiFm
         lzmHaUmZ97uyFZexbrIQSNP68qX3HDo3G2MQy5uViJGhU2EV3+xS+PnnepTPlZljwY4F
         oXxSsCbysQtO7q/T8sJuhnh8BivoQ4b6T4Ke+oNoUCNj38pxma4B3wL43QDCITLAw4EF
         I9igyMRKyZBH6fRtIdTj6FCMVUfNRrlhnIVHYQAj+Be7Hv7dScz7avoNlfPbTj+xGB7m
         wr4w==
X-Gm-Message-State: AC+VfDxWvDestw4UA32ybry9T0tThmSfjGYDnrrpJcPnByxiS6U6y+dx
        mKJr8zp7qF53n4uDGwocAqQ=
X-Google-Smtp-Source: ACHHUZ46m4mxSiNJsBsjYrmGXM1m9SpkQJJ73/IM3I+aqThEegWJ2WeOfXp2vVqPo6XUHsJJmv4JQg==
X-Received: by 2002:a17:90b:85:b0:246:91d0:9e6f with SMTP id bb5-20020a17090b008500b0024691d09e6fmr15456914pjb.3.1683666273187;
        Tue, 09 May 2023 14:04:33 -0700 (PDT)
Received: from localhost (187.137.203.35.bc.googleusercontent.com. [35.203.137.187])
        by smtp.gmail.com with ESMTPSA id u20-20020a17090adb5400b0024e149fe03dsm12159342pjx.25.2023.05.09.14.04.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 May 2023 14:04:32 -0700 (PDT)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     "John Cai via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Christian Couder <christian.couder@gmail.com>,
        John Cai <johncai86@gmail.com>
Subject: Re: [PATCH v2 2/3] pack-refs: teach --exclude option to exclude
 refs from being packed
References: <pull.1501.git.git.1683215331910.gitgitgadget@gmail.com>
        <pull.1501.v2.git.git.1683659931.gitgitgadget@gmail.com>
        <027b3f85a0b9c33c5334d6dad84e99c325ebec10.1683659931.git.gitgitgadget@gmail.com>
Date:   Tue, 09 May 2023 14:04:32 -0700
In-Reply-To: <027b3f85a0b9c33c5334d6dad84e99c325ebec10.1683659931.git.gitgitgadget@gmail.com>
        (John Cai via GitGitGadget's message of "Tue, 09 May 2023 19:18:50
        +0000")
Message-ID: <xmqq8rdxw71b.fsf@gitster.g>
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
> don't live long before getting deleted. Having an option to not include

"to not include" -> "to exclude", perhaps.


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

Clearly written.

> diff --git a/refs/files-backend.c b/refs/files-backend.c
> index d0581ee41ac..6a51267f379 100644
> --- a/refs/files-backend.c
> +++ b/refs/files-backend.c
> @@ -19,6 +19,7 @@
>  #include "../worktree.h"
>  #include "../wrapper.h"
>  #include "../write-or-die.h"
> +#include "../revision.h"
>  
>  /*
>   * This backend uses the following flags in `ref_update::flags` for
> @@ -1173,7 +1174,7 @@ static void prune_refs(struct files_ref_store *refs, struct ref_to_prune **refs_
>   */
>  static int should_pack_ref(const char *refname,
>  			   const struct object_id *oid, unsigned int ref_flags,
> -			   unsigned int pack_flags)
> +			   struct pack_refs_opts *opts)
>  {
>  	/* Do not pack per-worktree refs: */
>  	if (parse_worktree_ref(refname, NULL, NULL, NULL) !=
> @@ -1181,7 +1182,7 @@ static int should_pack_ref(const char *refname,
>  		return 0;
>  
>  	/* Do not pack non-tags unless PACK_REFS_ALL is set: */
> -	if (!(pack_flags & PACK_REFS_ALL) && !starts_with(refname, "refs/tags/"))
> +	if (!(opts->flags & PACK_REFS_ALL) && !starts_with(refname, "refs/tags/"))
>  		return 0;
>  
>  	/* Do not pack symbolic refs: */
> @@ -1192,10 +1193,14 @@ static int should_pack_ref(const char *refname,
>  	if (!ref_resolves_to_object(refname, the_repository, oid, ref_flags))
>  		return 0;
>  
> +	if (opts->exclusions && ref_excluded(opts->exclusions, refname))
> +		return 0;

It is _not_ _wrong_ per-se, but I would have expected for this to go
between "what do we include" and "symrefs and broken ones are not
packed", given that we will tweak the "what to include" logic in the
next step.

Other changes to the code in this patch are all naturally expected
to pass the new information through the callchain and looked good.

> diff --git a/t/t3210-pack-refs.sh b/t/t3210-pack-refs.sh
> index 07a0ff93def..31b9f72e84a 100755
> --- a/t/t3210-pack-refs.sh
> +++ b/t/t3210-pack-refs.sh
> @@ -108,6 +108,24 @@ test_expect_success \
>       git branch -d n/o/p &&
>       git branch n'
>
> +test_expect_success \
> +    'test excluded refs are not packed' '
> +     git branch dont_pack1 &&
> +     git branch dont_pack2 &&
> +     git branch pack_this &&
> +     git pack-refs --all --exclude refs/heads/dont_pack* &&

Let's quote the value given to "--exclude" to make it clear that we
do not expect glob to affect the shell, i.e.

	git pack-refs --all --exclude "refs/heads/dont_pack*" &&

Some (early and ancient) parts, but not all parts, of this file use
4-space indentation and have the title of the test on a line that is
separate from test_expect_success, which is an ancient deprecated
style.

You do not want to imitate them in new tests you add.  After the
dust from this topic settles, somebody should go in and clean the
style of this file.  Let's not create more work for them.

Thanks.

> +     test -f .git/refs/heads/dont_pack1 &&
> +     test -f .git/refs/heads/dont_pack2 &&
> +     ! test -f ./git/refs/heads/pack_this'
> +
> +test_expect_success \
> +    'test --no-exclude refs clears excluded refs' '
> +     git branch dont_pack3 &&
> +     git branch dont_pack4 &&
> +     git pack-refs --all --exclude refs/heads/dont_pack* --no-exclude &&
> +     ! test -f .git/refs/heads/dont_pack3 &&
> +     ! test -f .git/refs/heads/dont_pack4'
> +
>  test_expect_success \
>  	'see if up-to-date packed refs are preserved' \
>  	'git branch q &&
