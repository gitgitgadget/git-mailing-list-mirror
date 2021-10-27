Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1DA5CC433EF
	for <git@archiver.kernel.org>; Wed, 27 Oct 2021 17:36:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F34B860F02
	for <git@archiver.kernel.org>; Wed, 27 Oct 2021 17:36:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239815AbhJ0Riq (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 27 Oct 2021 13:38:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59156 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236251AbhJ0Rip (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 27 Oct 2021 13:38:45 -0400
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D1CBC061570
        for <git@vger.kernel.org>; Wed, 27 Oct 2021 10:36:20 -0700 (PDT)
Received: by mail-pj1-x1031.google.com with SMTP id na16-20020a17090b4c1000b0019f5bb661f9so2665674pjb.0
        for <git@vger.kernel.org>; Wed, 27 Oct 2021 10:36:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=Fln/H3wZ8tp9diV+v97TuThIySJSZEQrwBXL+We4eZ0=;
        b=H9xvjgA+h4JpDJteFQRATzJ1EBu96Ub3DbDA1KfbLf6rXvSy9E26VQvSm4kyfIZS4n
         jYRIwJ6S9XTPU4sagPOfeRyIyWwZdSDXEd9xXJYp3IvYV18J+QRY8AJCS3z/s1VNSlK4
         iXg1Noyg8kCXLNNl+5fS8lSAUXrlZ2GmPKqVLVPpaelB6Xp9HTtid7dIsr0PudX1Xmlq
         yJutAVryrBYWSfWfdG1+uU+vAEQUHJsmqFYlNQOdzCz2PNJi0gyprfbG2unrUmuvY6nJ
         n8fuZUuZVMTjLh0hPR06yRZn+RvRxSuBXzLz/F8QLZJw79HQcEq7byGtj5n4ktOZDZoU
         /GNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Fln/H3wZ8tp9diV+v97TuThIySJSZEQrwBXL+We4eZ0=;
        b=pnQiST5o2is3eC5SWxhXXBSh20+OOof/mNbf99pcYJr5iiFcV/q7IzJ0EX8sUWniJ/
         O7J57wcpaE9+fbXX4e3aul06lqjaohtefDmyTlQ2bdQDmXFHy86PupWlzZ/0p4y8aygE
         LdtNXV1emP5gHJ//6R8TKBmbUpLlJUerIwq/9BoiaWb63zf3aFteKYYoYlTXuy9k5D+r
         MJk7CjChWyGO2c6qi9gS7/ZT27opwFcT9rz6lsHRpr3AyjO0ypS4T2ITvvJZ09O/0SJh
         7kQayYMs9ORqiFGqFNWMq8K0AxD9uEnVH16Yu59iempiOn3jqgrM5VMHpZww1eWMd4Uc
         CB/Q==
X-Gm-Message-State: AOAM5315/jKPakCULKIMCrlAFxTaRnAbmjNfmhUjNYQepclc06T9ZrR4
        EdIDWl0QlC3tOTeFcklJtYjhcQ==
X-Google-Smtp-Source: ABdhPJwMdeL0Pr2M07HxpnoUjtLyTnzpjOm40UvcGQk7a9kmJF4t1DHeWeiEp2jBNuHk/Q/1Rki52w==
X-Received: by 2002:a17:902:e844:b0:141:72c0:c5e2 with SMTP id t4-20020a170902e84400b0014172c0c5e2mr2708526plg.10.1635356179405;
        Wed, 27 Oct 2021 10:36:19 -0700 (PDT)
Received: from google.com (157.214.185.35.bc.googleusercontent.com. [35.185.214.157])
        by smtp.gmail.com with ESMTPSA id g22sm530518pfc.202.2021.10.27.10.36.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Oct 2021 10:36:18 -0700 (PDT)
Date:   Wed, 27 Oct 2021 17:36:15 +0000
From:   Sean Christopherson <seanjc@google.com>
To:     Matheus Tavares <matheus.bernardino@usp.br>
Cc:     git@vger.kernel.org, newren@gmail.com, gitster@pobox.com,
        stolee@gmail.com, vdye@github.com, derrickstolee@github.com,
        Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>
Subject: Re: [PATCH v2] add, rm, mv: fix bug that prevents the update of
 non-sparse dirs
Message-ID: <YXmOD9fl+K0RSOpt@google.com>
References: <5e99c039db0b9644fb21f2ea72a464c67a74ff64.1635191000.git.matheus.bernardino@usp.br>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5e99c039db0b9644fb21f2ea72a464c67a74ff64.1635191000.git.matheus.bernardino@usp.br>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Oct 25, 2021, Matheus Tavares wrote:
> - Changed the tests to use trailing slash to make sure they cover the corner
>   case described above.

...

> diff --git a/t/t3705-add-sparse-checkout.sh b/t/t3705-add-sparse-checkout.sh
> index 5b904988d4..54f3db4304 100755
> --- a/t/t3705-add-sparse-checkout.sh
> +++ b/t/t3705-add-sparse-checkout.sh
> @@ -214,4 +214,22 @@ test_expect_success 'add allows sparse entries with --sparse' '
>  	test_must_be_empty stderr
>  '
>  
> +test_expect_success 'can add files from non-sparse dir' '
> +	git sparse-checkout set w !/x y/ &&

Aha!  I re-discovered out the original problematic pattern that led me to omitting
the trailing slash.

Sparse checkout doesn't play nice with "/", e.g. "git sparse-checkout set /"
results in an empty working directory.  Using "/*/" omits top-level files, which
is expected, thus the only pattern that works for "include everything relative to
the top-level directory" is "/*".  And to workaround the bug being fixed here, it
requires adding both "/*" and "/*/" to sparse-checkout.

The docs clearly state that "/*" is the full pattern set, but on the other hand
I don't see anything that states that "/" isn't supported.  Part of the confusion
is that the asterisk is not needed for sub-directories, and a trailing slash for
sub-directories even results in different matching behavior per gitignore docs.
The omission of a trailing slash is also reinforced by the git-sparse-checkout
docs' examples.

If "/" can't be handled for some reason, it would helpful to explictly call that
out in the docs, e.g. git-sparse-checkout and/or the gitignore pattern docs.

Thanks!

> +	mkdir -p w x/y &&
> +	touch w/f x/y/f &&
> +	git add w/f x/y/f 2>stderr &&
> +	test_must_be_empty stderr
> +'
> +
> +test_expect_success 'refuse to add non-skip-worktree file from sparse dir' '
> +	git sparse-checkout set !/x y/ !x/y/z &&
> +	mkdir -p x/y/z &&
> +	touch x/y/z/f &&
> +	test_must_fail git add x/y/z/f 2>stderr &&
> +	echo x/y/z/f | cat sparse_error_header - sparse_hint >expect &&
> +	test_cmp expect stderr
> +
