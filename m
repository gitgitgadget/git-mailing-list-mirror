Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C184C4332F
	for <git@archiver.kernel.org>; Wed,  4 Jan 2023 06:07:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233111AbjADGHX (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 4 Jan 2023 01:07:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36786 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233290AbjADGHU (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 4 Jan 2023 01:07:20 -0500
Received: from mail-pf1-x42b.google.com (mail-pf1-x42b.google.com [IPv6:2607:f8b0:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D2C5DF90
        for <git@vger.kernel.org>; Tue,  3 Jan 2023 22:07:19 -0800 (PST)
Received: by mail-pf1-x42b.google.com with SMTP id k137so17334679pfd.8
        for <git@vger.kernel.org>; Tue, 03 Jan 2023 22:07:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=bTvx7L+Qlwikg2IYxmhoE6n6dGuSvzrf5n+zqDUe9Io=;
        b=A2Av9vArcNMlAO3/dJPGhdiTUKtUF/QphfQcoyehhFaWwnfV2Y8/EywYRxDqqg3T7V
         MqEnL9WlCuZuSc0O9jdUmB0RCfjBSrDn6N+qO3nf7VgjGXCVYQTPYs9yYAF5apLSOt1V
         a9hU8kqw8N87pzk3QqzS/3oRDlzZkbkDl9A4OK7jGusDBQ/QKuDTcg4b/gbSvRgYHt65
         tasOGHD4wr05rA+KAVcFj+I3UdnmuKVUD5zRGCCRyDF8B2xdYvrxW2YQBtmE+susNdLX
         sHszfXf3mG138G3xSgDFfKo5/el6hq/4cFLOxNCJSN27q20JaxzNJcb7Wlz5W7gwml4+
         Aqiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=bTvx7L+Qlwikg2IYxmhoE6n6dGuSvzrf5n+zqDUe9Io=;
        b=ROAFdTqz6D9Pyb15c3PQG+1bhLDpDz3ZWMcD0KKrmcek+yGbDQsS7iIbGScDcmUvZI
         538tkmLshIN+QgSEPXcN2TCnmisNN9zqH6nE16512Al6BkLRuT5TqWxb9M0sO6qenqqu
         lpC/ugxG9H8Q/U+jgaLvMzouTAGL4ufRFdxOjq0/fIlM5WnUirK0qDQb9X1IMQS/F1Sa
         piUE6FIGfJfxhQJZ4AAXyRt1IYrkxAX13/XRbtQK8bEUw+Oxuv2+xDHDV+DB8/o+o6a8
         O1AjoREs7bIca5OG281jUWbK9bQKtQhLp+oxnsxjjB3FKETt9eZ74yeEeqaUcfKDHgav
         MgTg==
X-Gm-Message-State: AFqh2koOy13Q1ULW8c8/dlS4YFM8TCR0Hxp03pqkyGkbXBbfL1M6imUm
        BnE4RfbMwJLxt2vVpwhAjkQ=
X-Google-Smtp-Source: AMrXdXuoSoeYai0i0qOmqtsjWO73jebUq7RdKnANtIJDpnt/5Pd4+RIxbBwWmgwHOInMgCX+BmkRNw==
X-Received: by 2002:a05:6a00:7ca:b0:582:fba:319f with SMTP id n10-20020a056a0007ca00b005820fba319fmr15195926pfu.27.1672812438812;
        Tue, 03 Jan 2023 22:07:18 -0800 (PST)
Received: from localhost (33.5.83.34.bc.googleusercontent.com. [34.83.5.33])
        by smtp.gmail.com with ESMTPSA id d12-20020aa797ac000000b0056bb36c047asm11558383pfq.105.2023.01.03.22.07.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Jan 2023 22:07:18 -0800 (PST)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     Derrick Stolee <derrickstolee@github.com>,
        Elijah Newren <newren@gmail.com>,
        Victoria Dye <vdye@github.com>
Cc:     git@vger.kernel.org,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        William Sprent <williams@unity3d.com>,
        "William Sprent via GitGitGadget" <gitgitgadget@gmail.com>
Subject: Re: [PATCH v2] dir: check for single file cone patterns
References: <pull.1446.git.1671546459151.gitgitgadget@gmail.com>
        <pull.1446.v2.git.1672734059938.gitgitgadget@gmail.com>
Date:   Wed, 04 Jan 2023 15:07:17 +0900
In-Reply-To: <pull.1446.v2.git.1672734059938.gitgitgadget@gmail.com> (William
        Sprent via GitGitGadget's message of "Tue, 03 Jan 2023 08:20:59
        +0000")
Message-ID: <xmqqfscqvnmy.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"William Sprent via GitGitGadget" <gitgitgadget@gmail.com> writes:

> From: William Sprent <williams@unity3d.com>
>
> The sparse checkout documentation states that the cone mode pattern set
> is limited to patterns that either recursively include directories or
> patterns that match all files in a directory. In the sparse checkout
> file, the former manifest in the form:
>
>     /A/B/C/
>
> while the latter become a pair of patterns either in the form:
>
>     /A/B/
>     !/A/B/*/
>
> or in the special case of matching the toplevel files:
>
>     /*
>     !/*/
>
> The 'add_pattern_to_hashsets()' function contains checks which serve to
> disable cone-mode when non-cone patterns are encountered. However, these
> do not catch when the pattern list attempts to match a single file or
> directory, e.g. a pattern in the form:
>
>     /A/B/C
>
> This causes sparse-checkout to exhibit unexpected behaviour when such a
> pattern is in the sparse-checkout file and cone mode is enabled.
> Concretely, with the pattern like the above, sparse-checkout, in
> non-cone mode, will only include the directory or file located at
> '/A/B/C'. However, with cone mode enabled, sparse-checkout will instead
> just manifest the toplevel files but not any file located at '/A/B/C'.
>
> Relatedly, issues occur when supplying the same kind of filter when
> partial cloning with '--filter=sparse:oid=<oid>'. 'upload-pack' will
> correctly just include the objects that match the non-cone pattern
> matching. Which means that checking out the newly cloned repo with the
> same filter, but with cone mode enabled, fails due to missing objects.
>
> To fix these issues, add a cone mode pattern check that asserts that
> every pattern is either a directory match or the pattern '/*'. Add a
> test to verify the new pattern check and modify another to reflect that
> non-directory patterns are caught earlier.
>
> Signed-off-by: William Sprent <williams@unity3d.com>
> ---

Summoning those who worked in the area, which includes area experts,
for further comments, picked out of output from

    $ git shortlog --no-merges --grep=cone --since=2.years -s -n -e


> diff --git a/dir.c b/dir.c
> index fbdb24fc819..4e99f0c868f 100644
> --- a/dir.c
> +++ b/dir.c
> @@ -732,6 +732,13 @@ static void add_pattern_to_hashsets(struct pattern_list *pl, struct path_pattern
>  		goto clear_hashmaps;
>  	}
>  
> +	if (!(given->flags & PATTERN_FLAG_MUSTBEDIR) &&
> +	    strcmp(given->pattern, "/*")) {
> +		/* Not a cone pattern. */
> +		warning(_("unrecognized pattern: '%s'"), given->pattern);
> +		goto clear_hashmaps;
> +	}
> +
>  	prev = given->pattern;
>  	cur = given->pattern + 1;
>  	next = given->pattern + 2;
> diff --git a/t/t1091-sparse-checkout-builtin.sh b/t/t1091-sparse-checkout-builtin.sh
> index b563d6c263e..627267be153 100755
> --- a/t/t1091-sparse-checkout-builtin.sh
> +++ b/t/t1091-sparse-checkout-builtin.sh
> @@ -238,7 +238,7 @@ test_expect_success 'cone mode: match patterns' '
>  test_expect_success 'cone mode: warn on bad pattern' '
>  	test_when_finished mv sparse-checkout repo/.git/info/ &&
>  	cp repo/.git/info/sparse-checkout . &&
> -	echo "!/deep/deeper/*" >>repo/.git/info/sparse-checkout &&
> +	echo "!/deep/deeper/*/" >>repo/.git/info/sparse-checkout &&
>  	git -C repo read-tree -mu HEAD 2>err &&
>  	test_i18ngrep "unrecognized negative pattern" err
>  '
> @@ -667,6 +667,15 @@ test_expect_success 'pattern-checks: starting "*"' '
>  	check_read_tree_errors repo "a deep" "disabling cone pattern matching"
>  '
>  
> +test_expect_success 'pattern-checks: non directory pattern' '
> +	cat >repo/.git/info/sparse-checkout <<-\EOF &&
> +	/deep/deeper1/a
> +	EOF
> +	check_read_tree_errors repo deep "disabling cone pattern matching" &&
> +	check_files repo/deep deeper1 &&
> +	check_files repo/deep/deeper1 a
> +'
> +
>  test_expect_success 'pattern-checks: contained glob characters' '
>  	for c in "[a]" "\\" "?" "*"
>  	do
>
> base-commit: 7c2ef319c52c4997256f5807564523dfd4acdfc7
