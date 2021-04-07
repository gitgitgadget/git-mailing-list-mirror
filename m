Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-23.3 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF797C433ED
	for <git@archiver.kernel.org>; Wed,  7 Apr 2021 23:08:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A75CC61181
	for <git@archiver.kernel.org>; Wed,  7 Apr 2021 23:08:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229606AbhDGXIg (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 7 Apr 2021 19:08:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49366 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229460AbhDGXIf (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 7 Apr 2021 19:08:35 -0400
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A13E1C061760
        for <git@vger.kernel.org>; Wed,  7 Apr 2021 16:08:25 -0700 (PDT)
Received: by mail-pj1-x102e.google.com with SMTP id k23-20020a17090a5917b02901043e35ad4aso2106415pji.3
        for <git@vger.kernel.org>; Wed, 07 Apr 2021 16:08:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mail-followup-to:references
         :mime-version:content-disposition:in-reply-to;
        bh=u7QDcmZQT+KKDFkoL6gSLuXb6WngnSFoyS/xtURu5LQ=;
        b=VAtIA1vGYKDJHhsyNaii/oemjNr2ja2/UAMX+SGzI2eOIfBB7D+7klXLoNmwHiu3uZ
         k4x4AvpTF11T48mq8ZS1LWhsZIPSg4rlEtwSxfIrEh//xIbhxC0YxTMaa4Me4jCvL6Id
         LlUKCHPKalrUmL2AoiDcm0yxC1+lLWRPEAPxO7DWMWDzaR05ZL+5pBGRT9zuaFakYoSq
         3HwQyE+F9eH5JHIYNdIAosExlE6bMpIVLDy38GHKeGD2uzGXbRf/DYK5Nmj1k9eETNOR
         aDFlkKS21cEtqa5eOoCzoAiXeaaxvJT0Cc9cAd18QHjzt95i6Iv06ommYqwTxTT871YJ
         DV4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to;
        bh=u7QDcmZQT+KKDFkoL6gSLuXb6WngnSFoyS/xtURu5LQ=;
        b=oXMxxsvUuxgCnhXuOLVMIvzxiGOxg9EM90JvizJb1b6ewcjrEZphRI0ruZZJd72z86
         RbzL1HdpRvLrWZKBmOKOqOwgNHd+6tbuH3WCNCZCHOuaa8hB9G/uGwH17sWqWQOa1yFC
         45N0PnAKomPylqdf2f09yoa1JBeD1issrJjA2Vca4DP35glxie4KnrONJ7dtzsMKxI0K
         drKxQq2XqMKDG1HpIjh7x9s05EDEsxMrxP13QaqFr+9j9c2kao9vFUMQfD08NX2t0BcT
         U/eAwv6bjUFV6W05p3IMl4pLnZ02SHGDU2P/n2/0iYtZCYEQMsvWtUaIXOsKl3raWBJZ
         3fuA==
X-Gm-Message-State: AOAM531oTjDYjX0hUFXSmxq87+YY7JWr0Lhfg3e3dIwD7zF28oX0CSTX
        YoH4mBzibctFPNNAE/Ke2SUynVnUW736lw==
X-Google-Smtp-Source: ABdhPJwefAP7VXD/RckZ8X2nV+HZNxyY150Uq+twXz+tsg0hizQR8zdWNYCl40c7gjJ9KL0hsRwznw==
X-Received: by 2002:a17:90b:b08:: with SMTP id bf8mr5512563pjb.116.1617836904929;
        Wed, 07 Apr 2021 16:08:24 -0700 (PDT)
Received: from google.com ([2620:15c:2ce:200:11e7:4d1:298c:c7bd])
        by smtp.gmail.com with ESMTPSA id y8sm22643594pfp.140.2021.04.07.16.08.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Apr 2021 16:08:23 -0700 (PDT)
Date:   Wed, 7 Apr 2021 16:08:18 -0700
From:   Josh Steadmon <steadmon@google.com>
To:     Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, tom.saeger@oracle.com, gitster@pobox.com,
        sunshine@sunshineco.com, Derrick Stolee <stolee@gmail.com>,
        Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee <dstolee@microsoft.com>
Subject: Re: [PATCH v2 4/5] test-tool: test refspec input/output
Message-ID: <YG47Yu8VPiRuUBsM@google.com>
Mail-Followup-To: Josh Steadmon <steadmon@google.com>,
        Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, tom.saeger@oracle.com, gitster@pobox.com,
        sunshine@sunshineco.com, Derrick Stolee <stolee@gmail.com>,
        Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee <dstolee@microsoft.com>
References: <pull.924.git.1617627856.gitgitgadget@gmail.com>
 <pull.924.v2.git.1617734870.gitgitgadget@gmail.com>
 <bf296282323aa74f7c5b1a49c74d5aaa4b6f37ae.1617734870.git.gitgitgadget@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <bf296282323aa74f7c5b1a49c74d5aaa4b6f37ae.1617734870.git.gitgitgadget@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 2021.04.06 18:47, Derrick Stolee via GitGitGadget wrote:
> From: Derrick Stolee <dstolee@microsoft.com>
> 
> Add a new test-helper, 'test-tool refspec', that currently reads stdin
> line-by-line and translates the refspecs using the parsing logic of
> refspec_item_init() and writes them to output.
> 
> Create a test in t5511-refspec.sh that uses this helper to test several
> known special cases. This includes all of the special properties of the
> 'struct refspec_item', including:
> 
>  * force: The refspec starts with '+'.
>  * pattern: Each side of the refspec has a glob character ('*')
>  * matching: The refspec is simply the string ":".
>  * exact_sha1: The 'src' string is a 40-character hex string.
>  * negative: The refspec starts with '^' and 'dst' is NULL.
> 
> While the exact_sha1 property doesn't require special logic in
> refspec_item_format, it is still tested here for completeness.
> 
> There is also the special-case refspec "@" which translates to "HEAD".
> 
> Note that if a refspec does not start with "refs/", then that is not
> incorporated as part of the 'struct refspec_item'. This behavior is
> confirmed by these tests. These refspecs still work in the wild because
> the refs layer interprets them appropriately as branches, prepending
> "refs/" or "refs/heads/" as necessary. I spent some time attempting to
> insert these prefixes explicitly in parse_refspec(), but these are
> several subtleties I was unable to overcome. If such a change were to be
> made, then this new test in t5511-refspec.sh will need to be updated
> with new output. For example, the input lines ending with "translated"
> are designed to demonstrate these subtleties.
> 
> Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
> ---
>  Makefile                |  1 +
>  t/helper/test-refspec.c | 44 +++++++++++++++++++++++++++++++++++++++++
>  t/helper/test-tool.c    |  1 +
>  t/helper/test-tool.h    |  1 +
>  t/t5511-refspec.sh      | 41 ++++++++++++++++++++++++++++++++++++++
>  5 files changed, 88 insertions(+)
>  create mode 100644 t/helper/test-refspec.c
> 
> diff --git a/Makefile b/Makefile
> index a6a73c574191..f858c9f25976 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -734,6 +734,7 @@ TEST_BUILTINS_OBJS += test-reach.o
>  TEST_BUILTINS_OBJS += test-read-cache.o
>  TEST_BUILTINS_OBJS += test-read-graph.o
>  TEST_BUILTINS_OBJS += test-read-midx.o
> +TEST_BUILTINS_OBJS += test-refspec.o
>  TEST_BUILTINS_OBJS += test-ref-store.o
>  TEST_BUILTINS_OBJS += test-regex.o
>  TEST_BUILTINS_OBJS += test-repository.o
> diff --git a/t/helper/test-refspec.c b/t/helper/test-refspec.c
> new file mode 100644
> index 000000000000..b06735ded208
> --- /dev/null
> +++ b/t/helper/test-refspec.c
> @@ -0,0 +1,44 @@
> +#include "cache.h"
> +#include "parse-options.h"
> +#include "refspec.h"
> +#include "strbuf.h"
> +#include "test-tool.h"
> +
> +static const char * const refspec_usage[] = {
> +	N_("test-tool refspec [--fetch]"),
> +	NULL
> +};
> +
> +int cmd__refspec(int argc, const char **argv)
> +{
> +	struct strbuf line = STRBUF_INIT;
> +	int fetch = 0;
> +
> +	struct option refspec_options [] = {
> +		OPT_BOOL(0, "fetch", &fetch,
> +			 N_("enable the 'fetch' option for parsing refpecs")),

Typo here: s/refpecs/refspecs/


> +		OPT_END()
> +	};
> +
> +	argc = parse_options(argc, argv, NULL, refspec_options,
> +			     refspec_usage, 0);
> +
> +	while (strbuf_getline(&line, stdin) != EOF) {
> +		struct refspec_item rsi;
> +		char *buf;
> +
> +		if (!refspec_item_init(&rsi, line.buf, fetch)) {
> +			printf("failed to parse %s\n", line.buf);
> +			continue;
> +		}
> +
> +		buf = refspec_item_format(&rsi);
> +		printf("%s\n", buf);
> +		free(buf);
> +
> +		refspec_item_clear(&rsi);
> +	}
> +
> +	strbuf_release(&line);
> +	return 0;
> +}
> diff --git a/t/helper/test-tool.c b/t/helper/test-tool.c
> index 287aa6002307..f534ad1731a9 100644
> --- a/t/helper/test-tool.c
> +++ b/t/helper/test-tool.c
> @@ -55,6 +55,7 @@ static struct test_cmd cmds[] = {
>  	{ "read-cache", cmd__read_cache },
>  	{ "read-graph", cmd__read_graph },
>  	{ "read-midx", cmd__read_midx },
> +	{ "refspec", cmd__refspec },
>  	{ "ref-store", cmd__ref_store },
>  	{ "regex", cmd__regex },
>  	{ "repository", cmd__repository },
> diff --git a/t/helper/test-tool.h b/t/helper/test-tool.h
> index 9ea4b31011dd..46a0b8850f17 100644
> --- a/t/helper/test-tool.h
> +++ b/t/helper/test-tool.h
> @@ -44,6 +44,7 @@ int cmd__reach(int argc, const char **argv);
>  int cmd__read_cache(int argc, const char **argv);
>  int cmd__read_graph(int argc, const char **argv);
>  int cmd__read_midx(int argc, const char **argv);
> +int cmd__refspec(int argc, const char **argv);
>  int cmd__ref_store(int argc, const char **argv);
>  int cmd__regex(int argc, const char **argv);
>  int cmd__repository(int argc, const char **argv);
> diff --git a/t/t5511-refspec.sh b/t/t5511-refspec.sh
> index be025b90f989..489bec08d570 100755
> --- a/t/t5511-refspec.sh
> +++ b/t/t5511-refspec.sh
> @@ -93,4 +93,45 @@ test_refspec fetch "refs/heads/${good}"
>  bad=$(printf '\011tab')
>  test_refspec fetch "refs/heads/${bad}"				invalid
>  
> +test_expect_success 'test input/output round trip' '
> +	cat >input <<-\EOF &&
> +	+refs/heads/*:refs/remotes/origin/*
> +	refs/heads/*:refs/remotes/origin/*
> +	refs/heads/main:refs/remotes/frotz/xyzzy
> +	:refs/remotes/frotz/deleteme
> +	^refs/heads/secrets
> +	refs/heads/secret:refs/heads/translated
> +	refs/heads/secret:heads/translated
> +	refs/heads/secret:remotes/translated
> +	secret:translated
> +	refs/heads/*:remotes/xxy/*
> +	refs/heads*/for-linus:refs/remotes/mine/*
> +	2e36527f23b7f6ae15e6f21ac3b08bf3fed6ee48:refs/heads/fixed
> +	HEAD
> +	@
> +	:
> +	EOF
> +	cat >expect <<-\EOF &&
> +	+refs/heads/*:refs/remotes/origin/*
> +	refs/heads/*:refs/remotes/origin/*
> +	refs/heads/main:refs/remotes/frotz/xyzzy
> +	:refs/remotes/frotz/deleteme
> +	^refs/heads/secrets
> +	refs/heads/secret:refs/heads/translated
> +	refs/heads/secret:heads/translated
> +	refs/heads/secret:remotes/translated
> +	secret:translated
> +	refs/heads/*:remotes/xxy/*
> +	refs/heads*/for-linus:refs/remotes/mine/*
> +	2e36527f23b7f6ae15e6f21ac3b08bf3fed6ee48:refs/heads/fixed
> +	HEAD
> +	HEAD
> +	:
> +	EOF
> +	test-tool refspec <input >output &&
> +	test_cmp expect output &&
> +	test-tool refspec --fetch <input >output &&
> +	test_cmp expect output
> +'
> +
>  test_done
> -- 
> gitgitgadget
> 
