Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80995C636C8
	for <git@archiver.kernel.org>; Sun, 18 Jul 2021 12:55:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 60E3461026
	for <git@archiver.kernel.org>; Sun, 18 Jul 2021 12:55:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233752AbhGRM6N (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 18 Jul 2021 08:58:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59102 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233552AbhGRM6N (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 18 Jul 2021 08:58:13 -0400
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com [IPv6:2a00:1450:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 59140C061762
        for <git@vger.kernel.org>; Sun, 18 Jul 2021 05:55:14 -0700 (PDT)
Received: by mail-ej1-x634.google.com with SMTP id gb6so23345003ejc.5
        for <git@vger.kernel.org>; Sun, 18 Jul 2021 05:55:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=Hkbx2/n3gDIzrR0Q3lDg1LhtwgPFDuxCVGQStx1Toc8=;
        b=I2GCYed2ETs6O/tj8v0vWtSuqCSQ3uaGCDOhGXK3QPBmn7Tr+SyDO7zbJpuX2A5Esn
         F5kMYlqVx5PS52V1jjz3WPHgELMoaJJ+ifdNZ0DJYkJ/yPKkRcRtQ4BCbSpDpJfM8b+6
         X2IFsGIUCTe5jjabdg005QVGmSHO+3GNMQLoh2Q5Wcc4YyAH0XYYVLC1nvKyUy5ldbKI
         tF8TPIQGUB9bJOMwGMrdSA5XSAEHLMrOHvYUH5SWPL8JCr38r54L5AsN1bQ1AO1mWnfi
         +06nqfcuEu+2bTEPVEZ8G8ql4YWF0W56mtMeqjUDMXnIP+xF8jiYhcm39inTt7cPcgng
         rlSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Hkbx2/n3gDIzrR0Q3lDg1LhtwgPFDuxCVGQStx1Toc8=;
        b=sgUtvzIYAxr+AHeznUHJa80MXUzvQfs04ez4t7xf3Lkb2NVxVX0zNJJIHzyHv3Hafw
         0zvMnFUN41pSP1Bm1XBwU6jbaBbb513f14E0TVWIeM/LT/QNFnyPT3z5aF96EXDi9srw
         ScVrTgczIGKgMCXmO+wKwfrV4Sr+EThNqfcL9xwtu9whzZhCvVlYw9ku+en+GxCFtHHb
         0o0YKum3oe6x3JQabmqI6lIRcFADyY2EomkVlFtGam2ngz4TwLuOIh4XDNOp2EDyrwdK
         LMnmhTMaqsXUr+KTZc9WfwaF1agjp8JVeerQziAXqyQqtC8vT+gGC1ferl5nmhnTCtD8
         TnYQ==
X-Gm-Message-State: AOAM532+DguQb0O240MhjaTPzI+uanB6IuqlCLrIksYRPDZQUiR+Zj2a
        MABxhwzFcTroKwcCztmsX7RVNIEmYPG7Ig==
X-Google-Smtp-Source: ABdhPJz6e95LX83aCazZoaHtQwDgsaK6VdJPRntY/ekd/ofiXxcY2SJuundeIDH7cLOHWrWwKZVe+Q==
X-Received: by 2002:a17:906:c08e:: with SMTP id f14mr22062062ejz.380.1626612912789;
        Sun, 18 Jul 2021 05:55:12 -0700 (PDT)
Received: from [10.28.18.7] ([181.214.206.239])
        by smtp.gmail.com with ESMTPSA id m8sm6314314eds.10.2021.07.18.05.55.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 18 Jul 2021 05:55:11 -0700 (PDT)
Subject: Re: [PATCH v2 2/5] commit-graph: remove redundant handling of -h
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <stolee@gmail.com>,
        Taylor Blau <me@ttaylorr.com>
References: <cover-0.5-00000000000-20210718T074936Z-avarab@gmail.com>
 <patch-2.5-6f386fc32c8-20210718T074936Z-avarab@gmail.com>
From:   Andrei Rybak <rybak.a.v@gmail.com>
Message-ID: <25b24cc9-a7fc-1286-6bcf-1fdd21ee8c49@gmail.com>
Date:   Sun, 18 Jul 2021 14:55:09 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <patch-2.5-6f386fc32c8-20210718T074936Z-avarab@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 18/07/2021 09:58, Ævar Arnfjörð Bjarmason wrote:
> If we don't handle the -h option here like most parse_options() users
> we'll fall through and it'll do the right thing for us.
> 
> I think this code added in 4ce58ee38d (commit-graph: create
> git-commit-graph builtin, 2018-04-02) was always redundant,
> parse_options() did this at the time, and the commit-graph code never
> used PARSE_OPT_NO_INTERNAL_HELP.
> 
> Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
> ---
>   builtin/commit-graph.c  | 4 ----
>   t/t5318-commit-graph.sh | 5 +++++
>   2 files changed, 5 insertions(+), 4 deletions(-)
> 
> diff --git a/builtin/commit-graph.c b/builtin/commit-graph.c
> index c3fa4fde3e4..baead04a03b 100644
> --- a/builtin/commit-graph.c
> +++ b/builtin/commit-graph.c
> @@ -319,10 +319,6 @@ int cmd_commit_graph(int argc, const char **argv, const char *prefix)
>   		OPT_END(),
>   	};
>   
> -	if (argc == 2 && !strcmp(argv[1], "-h"))
> -		usage_with_options(builtin_commit_graph_usage,
> -				   builtin_commit_graph_options);
> -
>   	git_config(git_default_config, NULL);
>   	argc = parse_options(argc, argv, prefix,
>   			     builtin_commit_graph_options,
> diff --git a/t/t5318-commit-graph.sh b/t/t5318-commit-graph.sh
> index af88f805aa2..5fccce95724 100755
> --- a/t/t5318-commit-graph.sh
> +++ b/t/t5318-commit-graph.sh
> @@ -5,6 +5,11 @@ test_description='commit graph'
>   
>   GIT_TEST_COMMIT_GRAPH_CHANGED_PATHS=0
>   
> +test_expect_success 'usage' '
> +	test_expect_code 129 git commit-graph -h 2>err &&
> +	! grep error: err

New test is partially redundant to the test in the loop at the bottom of
't0012-help.sh'.

> +'
> +
>   test_expect_success 'setup full repo' '
>   	mkdir full &&
>   	cd "$TRASH_DIRECTORY/full" &&
> 

