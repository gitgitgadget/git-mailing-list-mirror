Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6116C43334
	for <git@archiver.kernel.org>; Thu, 30 Jun 2022 09:54:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233249AbiF3JyE (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 30 Jun 2022 05:54:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56798 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230350AbiF3JyD (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 30 Jun 2022 05:54:03 -0400
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 894711EADF
        for <git@vger.kernel.org>; Thu, 30 Jun 2022 02:54:01 -0700 (PDT)
Received: by mail-ej1-x62f.google.com with SMTP id mf9so38018422ejb.0
        for <git@vger.kernel.org>; Thu, 30 Jun 2022 02:54:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=K+vFEERKab7F6RhNZE5nHwYr5h7Q1XZ61sjWkNYkUj0=;
        b=bftWs3uMyipYgJCQgVrEH5FteCMVwY2HAJIA501znodSnF/HkVYqivwLJ+0aDcc4nv
         pQPU9lUNYdMUdCFjOoXSHFG8MyjQMcb1ORd/Ykq3B6FPxzbJKGU/ccDREqFTBAtpbP30
         +kjWGtTlFHj638k9cFoMUFb03QpBFb5C2jMVgwJ/V4TdC7eCSyb7ZF9CbR4g3MNwEIFR
         ImU8k0qWztuLVNs08PypK9jhL/ys0UKwTrb4g1FjfyDBJ4y/mdDXfgCVnT7bLIlclgW1
         VS/3TZGLDhE1oH3X89FH3vjZV/wL2VDYF9wTJZYCwrSRinx4aO41pgqTVlRC20nNYG3F
         G9rw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=K+vFEERKab7F6RhNZE5nHwYr5h7Q1XZ61sjWkNYkUj0=;
        b=onZX4jAn6/R2z8LznjMaU7bp22aSUnqY3umOhrZuCfFjXB9UPhHcrDmsEEp9G8mF1I
         bsnVDXhVoM3a18WKVCjB27itmHcDbO6tSZVcAyR10nvPYO2CbLhHBSlszf7GsW3Co8Wx
         h5fauU7bkDHG+izmjKZmb0DTsQazyMpKvZtnXdO/xbpVR2FvqlHsKJjRXOphVkkBQE8s
         GLSP/5kNJWlmFbrEmfbsob32b2JE+Wmzs/m54qBBqldAVtvYPgk2cmVH3qSk88TnGxy4
         DH8f82Hh8XxXb5ShfI5pHU0uDfzndOVT4mMnz/ZUQrPTPAW/jFN6v7v1jU0U3uIAr1Ea
         HSaQ==
X-Gm-Message-State: AJIora8906BWwmxPfw94Mw8cmkP3VIAVgK6U1Y3EqX7CNOFgVETcdfOD
        vX1lxZEdg/3pPlmAtLSjagyKgF3EcoJZWw==
X-Google-Smtp-Source: AGRyM1vQL8wGEb1wYZim8YBpLN8tASrD6HsCINgI9Ny9/LBN+Fi529ccRLyxVfmv0S/e1fRAikVsig==
X-Received: by 2002:a17:906:d54f:b0:726:4424:9d31 with SMTP id cr15-20020a170906d54f00b0072644249d31mr8088459ejc.227.1656582840094;
        Thu, 30 Jun 2022 02:54:00 -0700 (PDT)
Received: from localhost (78-131-14-143.pool.digikabel.hu. [78.131.14.143])
        by smtp.gmail.com with ESMTPSA id fx24-20020a170906b75800b006fec63e564bsm8813758ejb.30.2022.06.30.02.53.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Jun 2022 02:53:59 -0700 (PDT)
Date:   Thu, 30 Jun 2022 11:53:57 +0200
From:   SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
To:     Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Taylor Blau <me@ttaylorr.com>,
        Elijah Newren <newren@gmail.com>
Subject: Re: [PATCH v2] merge-ort: avoid assuming all renames detected
Message-ID: <20220630095357.GA2123@szeder.dev>
References: <pull.1194.git.git.1642212566346.gitgitgadget@gmail.com>
 <pull.1194.v2.git.git.1642443955836.gitgitgadget@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <pull.1194.v2.git.git.1642443955836.gitgitgadget@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Jan 17, 2022 at 06:25:55PM +0000, Elijah Newren via GitGitGadget wrote:
> diff --git a/t/t6429-merge-sequence-rename-caching.sh b/t/t6429-merge-sequence-rename-caching.sh
> index 035edc40b1e..f2bc8a7d2a2 100755
> --- a/t/t6429-merge-sequence-rename-caching.sh
> +++ b/t/t6429-merge-sequence-rename-caching.sh
> @@ -697,4 +697,71 @@ test_expect_success 'caching renames only on upstream side, part 2' '
>  	)
>  '
>  
> +#
> +# The following testcase just creates two simple renames (slightly modified
> +# on both sides but without conflicting changes), and a directory full of
> +# files that are otherwise uninteresting.  The setup is as follows:
> +#
> +#   base:     unrelated/<BUNCH OF FILES>
> +#             numbers
> +#             values
> +#   upstream: modify: numbers
> +#             modify: values
> +#   topic:    add: unrelated/foo
> +#             modify: numbers
> +#             modify: values
> +#             rename: numbers -> sequence
> +#             rename: values -> progression
> +#
> +# This is a trivial rename case, but we're curious what happens with a very
> +# low renameLimit interacting with the restart optimization trying to notice
> +# that unrelated/ looks like a trivial merge candidate.
> +#
> +test_expect_success 'avoid assuming we detected renames' '
> +	git init redo-weirdness &&
> +	(
> +		cd redo-weirdness &&
> +
> +		mkdir unrelated &&
> +		for i in $(test_seq 1 10)
> +		do
> +			>unrelated/$i
> +		done &&
> +		test_seq  2 10 >numbers &&
> +		test_seq 12 20 >values &&
> +		git add numbers values unrelated/ &&
> +		git commit -m orig &&
> +
> +		git branch upstream &&
> +		git branch topic &&
> +
> +		git switch upstream &&
> +		test_seq  1 10 >numbers &&
> +		test_seq 11 20 >values &&
> +		git add numbers &&
> +		git commit -m "Some tweaks" &&
> +
> +		git switch topic &&
> +
> +		>unrelated/foo &&
> +		test_seq  2 12 >numbers &&
> +		test_seq 12 22 >values &&
> +		git add numbers values unrelated/ &&
> +		git mv numbers sequence &&
> +		git mv values progression &&
> +		git commit -m A &&
> +
> +		#
> +		# Actual testing
> +		#
> +
> +		git switch --detach topic^0 &&
> +
> +		test_must_fail git -c merge.renameLimit=1 rebase upstream &&
> +
> +		git ls-files -u >actual &&
> +		! test_file_is_empty actual

There is no 'test_file_is_empty' function, but because of the ! at the
beginning of the line it didn't fail the test.

The minimal fix would be to use 'test_file_not_empty' instead, but I
wonder whether we should use 'test_line_count = 2' instead for a tad
tighter check.

> +	)
> +'
> +
>  test_done
> 
> base-commit: 1ffcbaa1a5f10c9f706314d77f88de20a4a498c2
> -- 
> gitgitgadget
