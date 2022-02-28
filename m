Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4BB4C433EF
	for <git@archiver.kernel.org>; Mon, 28 Feb 2022 23:13:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229516AbiB1XOB (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 28 Feb 2022 18:14:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57596 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229457AbiB1XOA (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 28 Feb 2022 18:14:00 -0500
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B499C17ABD
        for <git@vger.kernel.org>; Mon, 28 Feb 2022 15:13:18 -0800 (PST)
Received: by mail-ed1-x52d.google.com with SMTP id bq11so19746942edb.2
        for <git@vger.kernel.org>; Mon, 28 Feb 2022 15:13:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version;
        bh=LDHXzt8UtkRO1++CNIDqUitVzb/BriI2SDhAzwa1JtA=;
        b=cp3gZ2m3hbmU0NxMNw8mhLh7fdWxL1V0thWPnrmw1/Vfu/dctdAdE872HIv1+1EkB8
         WLt0/JgkfVEUgIX8QjnnOq0iiI9NHqgsOXNTQ9Cvs7vldtIFMOEpWwmP4sXk7RJkT9zu
         aoYbMqrxdYNefdNqYM31jtQoQiLC+aE9n4sSKxRGhFFhYI7vIkRkNzNAKXKuHIiNYO1j
         ZFEHElI7XJm+uCrr6qp2G685b5MALRd3bIpVMhOjKs2oQpyrRb88tBJa7N1u8kZ9GbMB
         SF7E9gOupvmQMf79M6snrQnXEkYF+6vmOLy8+5OpgdjToj0o5ZZMSMVWIYfpCjShVyTo
         FQJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version;
        bh=LDHXzt8UtkRO1++CNIDqUitVzb/BriI2SDhAzwa1JtA=;
        b=F3yrlAOrs3x58NBbSzxqcxlHHF2p3UArdKpLf+AR0ZD+T/y+4dMAIE6FIx2LWmmP+b
         O5mAoP+kpvr7MKxa3ltxZzXEp4bHTs3AejgNRmFD+LY+mQSlXd1hQzoEMfEqRmuC/+Da
         JVjWADFNQiqqj4bcorTPj89xy2TCJj8WmECXjZRPeWw8yZkctaYk1wFEpmOv/fTGKJdI
         YgFHAwsA3hYfHCvoLpjGo9DRP4s57RVvOHS30TyFYvqcACLcEYhs5Kr5tDars2+wuiqr
         C06Lhs970w6qV1bR1wwR+/c+Z4DXH8VNTVTVw3FsDuVs99Dbbdw8SY3QAdOguNEY8L48
         Eo+A==
X-Gm-Message-State: AOAM532F+XveqZZW0yTq8rjf+YJLoI3mYI5QRMtOxpo8o7sgA0X9JF8b
        0oNShHP0OXZ0WeEpI6qw4XMEyclREYo=
X-Google-Smtp-Source: ABdhPJw0UihV0AE1Goa1JvDDGLQm4DkVjTJk2/EblwjdGZgGorqMNP/yMy5XqvOZKE5IEk7upukloA==
X-Received: by 2002:a05:6402:27cb:b0:412:124:e0db with SMTP id c11-20020a05640227cb00b004120124e0dbmr21932204ede.72.1646089995615;
        Mon, 28 Feb 2022 15:13:15 -0800 (PST)
Received: from gmgdl (j120189.upc-j.chello.nl. [24.132.120.189])
        by smtp.gmail.com with ESMTPSA id pg27-20020a170907205b00b006d6e5102ca2sm67384ejb.97.2022.02.28.15.13.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Feb 2022 15:13:15 -0800 (PST)
Received: from avar by gmgdl with local (Exim 4.95)
        (envelope-from <avarab@gmail.com>)
        id 1nOpCc-001eIQ-GM;
        Tue, 01 Mar 2022 00:13:14 +0100
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Victoria Dye via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, newren@gmail.com, gitster@pobox.com,
        Derrick Stolee <derrickstolee@github.com>,
        Victoria Dye <vdye@github.com>
Subject: Re: [PATCH v2 3/7] read-tree: expand sparse checkout test coverage
Date:   Tue, 01 Mar 2022 00:09:40 +0100
References: <pull.1157.git.1645640717.gitgitgadget@gmail.com>
 <pull.1157.v2.git.1645742073.gitgitgadget@gmail.com>
 <ffe0b6aff2baee238f77ae57561a62ea5473321f.1645742073.git.gitgitgadget@gmail.com>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.6.10
In-reply-to: <ffe0b6aff2baee238f77ae57561a62ea5473321f.1645742073.git.gitgitgadget@gmail.com>
Message-ID: <220301.861qzm37qt.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Thu, Feb 24 2022, Victoria Dye via GitGitGadget wrote:

> From: Victoria Dye <vdye@github.com>
>
> Add tests focused on how 'git read-tree' behaves in sparse checkouts. Extra
> emphasis is placed on interactions with files outside the sparse cone, e.g.
> merges with out-of-cone conflicts.
>
> Signed-off-by: Victoria Dye <vdye@github.com>
> ---
>  t/perf/p2000-sparse-operations.sh        |  1 +
>  t/t1092-sparse-checkout-compatibility.sh | 85 ++++++++++++++++++++++++
>  2 files changed, 86 insertions(+)
>
> diff --git a/t/perf/p2000-sparse-operations.sh b/t/perf/p2000-sparse-operations.sh
> index 2a7106b9495..382716cfca9 100755
> --- a/t/perf/p2000-sparse-operations.sh
> +++ b/t/perf/p2000-sparse-operations.sh
> @@ -117,6 +117,7 @@ test_perf_on_all git diff
>  test_perf_on_all git diff --cached
>  test_perf_on_all git blame $SPARSE_CONE/a
>  test_perf_on_all git blame $SPARSE_CONE/f3/a
> +test_perf_on_all git read-tree -mu HEAD
>  test_perf_on_all git checkout-index -f --all
>  test_perf_on_all git update-index --add --remove $SPARSE_CONE/a
>  
> diff --git a/t/t1092-sparse-checkout-compatibility.sh b/t/t1092-sparse-checkout-compatibility.sh
> index b1dcaa0e642..9d58da4e925 100755
> --- a/t/t1092-sparse-checkout-compatibility.sh
> +++ b/t/t1092-sparse-checkout-compatibility.sh
> @@ -819,6 +819,91 @@ test_expect_success 'update-index --cacheinfo' '
>  	test_cmp expect sparse-checkout-out
>  '
>  
> +test_expect_success 'read-tree --merge with files outside sparse definition' '
> +	init_repos &&
> +
> +	test_all_match git checkout -b test-branch update-folder1 &&
> +	for MERGE_TREES in "base HEAD update-folder2" \
> +			   "update-folder1 update-folder2" \
> +			   "update-folder2"
> +	do
> +		# Clean up and remove on-disk files
> +		test_all_match git reset --hard HEAD &&
> +		test_sparse_match git sparse-checkout reapply &&
> +
> +		# Although the index matches, without --no-sparse-checkout, outside-of-
> +		# definition files will not exist on disk for sparse checkouts
> +		test_all_match git read-tree -mu $MERGE_TREES &&
> +		test_all_match git status --porcelain=v2 &&
> +		test_path_is_missing sparse-checkout/folder2 &&
> +		test_path_is_missing sparse-index/folder2 &&
> +
> +		test_all_match git read-tree --reset -u HEAD &&
> +		test_all_match git status --porcelain=v2 &&
> +
> +		test_all_match git read-tree -mu --no-sparse-checkout $MERGE_TREES &&
> +		test_all_match git status --porcelain=v2 &&
> +		test_cmp sparse-checkout/folder2/a sparse-index/folder2/a &&
> +		test_cmp sparse-checkout/folder2/a full-checkout/folder2/a || return 1
> +	done
> +'

Nit: Isn't this nicer/easier by unrolling the for-loop to the top-level, i.e.:

for MERGE_TREES in "base HEAD update-folder2" [...]
do
	test_expect_success "'read-tree -mu $MERGE_TREES' with files outside sparse definition" '
		init_repos &&
		test_when_finished "test_all_match git reset --hard HEAD" &&
                ...
	'
done

It makes failures easier to reason about since you see which for-loop
iteration you're in right away, and can e.g. pick one with --run.

And we can do the cleanup in test_when_finished instead of at the start
of every loop.
