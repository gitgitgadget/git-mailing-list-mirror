Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84B8AC433EF
	for <git@archiver.kernel.org>; Fri, 17 Dec 2021 13:12:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236586AbhLQNM0 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 17 Dec 2021 08:12:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236582AbhLQNMY (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 17 Dec 2021 08:12:24 -0500
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4ACEAC061574
        for <git@vger.kernel.org>; Fri, 17 Dec 2021 05:12:24 -0800 (PST)
Received: by mail-ed1-x532.google.com with SMTP id t5so7853618edd.0
        for <git@vger.kernel.org>; Fri, 17 Dec 2021 05:12:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version;
        bh=axMfw3hhzER9r81QG7o3KFwML/zx7WU7xtWNzvolj/M=;
        b=pL2xoNo802i9Azss6qztWW1oOWxrqLfBxs4bEaWHG/SNJK+0uLVuFx+HLy+eAEQXG7
         9uYaD/pvNXmkYETMlkAeXbbQo2Ef2SsR7zyDNY386PMXZWy3vZ2yWqLM3Gkydhq2D5vU
         m0ZbMsDrzNpCdcDwSWhotWEWguDtcACB/nSwt2046V35mGKrUIm+w9XSdNXRzzRKTKyW
         vPZkMVcVRDz78Iiz+wH/mYg56NHKo+4/j7q/jqMG1TjxMk5O5B94yya9hV//3QtxaY86
         Qk/uPSDzFVgChapItfLZ12OvDUCtm8AxqZzfSIzRS1PQkHTMUQjLhJPJki1VTy6cDkN3
         d4dg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version;
        bh=axMfw3hhzER9r81QG7o3KFwML/zx7WU7xtWNzvolj/M=;
        b=nUWKztkA5PrjiCOb+nCTsQl6KJk/L8NV2J8+VDVKWtyhUzyuy8114xpE2SitaPYYom
         lPqdaw+wghkxQXQaUs+SairaICBYc90S0XVwAyJKoF63H2RhArFoKxRI+ZtUbiJrwN+8
         /L+OepHex/RDHy2Xy7zrSuBhi6Y+xHG2jLGD6mKBColMkxEWi9oWzFjw6X1CJc1qCUOV
         BhyMR8ya2e8LyyTHf+sHwj6zD3vECosn++J5NgwAYyORGQcuZ1ZNMUxleQ1tKPD/Yjqk
         FSkGFMHZTYp4rlbtCW0LfA8T9JTqOQUbMhPVoMlEEB789VZMwmiIadAjKB7aDRjCiGmD
         SW9g==
X-Gm-Message-State: AOAM530gk2Ak3A936GhhM2/L6y3gArq1oQiqLDzNhG6aNB62Kx1majCo
        EmHKFqn1HXcUpL0rYlQRctk=
X-Google-Smtp-Source: ABdhPJxVwm65JTNdOSWVHitenei8VRrgvmLawDXBiIMe1w17fMp1mANAEkIrp6XsomRXcyNc0KFZSg==
X-Received: by 2002:a17:907:20a4:: with SMTP id pw4mr2529826ejb.162.1639746742704;
        Fri, 17 Dec 2021 05:12:22 -0800 (PST)
Received: from gmgdl (j120189.upc-j.chello.nl. [24.132.120.189])
        by smtp.gmail.com with ESMTPSA id x7sm3786384edd.28.2021.12.17.05.12.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Dec 2021 05:12:22 -0800 (PST)
Received: from avar by gmgdl with local (Exim 4.95)
        (envelope-from <avarab@gmail.com>)
        id 1myD25-000qBI-DY;
        Fri, 17 Dec 2021 14:12:21 +0100
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Teng Long <dyroneteng@gmail.com>
Cc:     congdanhqx@gmail.com, git@vger.kernel.org, gitster@pobox.com,
        peff@peff.net
Subject: Re: [PATCH v6 1/1] ls-tree.c: support `--object-only` option for
 "git-ls-tree"
Date:   Fri, 17 Dec 2021 14:09:48 +0100
References: <cover.1639721750.git.dyroneteng@gmail.com>
 <2e449d1c792ff81da5f22c8bf65ed33c393d62f8.1639721750.git.dyroneteng@gmail.com>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.6.10
In-reply-to: <2e449d1c792ff81da5f22c8bf65ed33c393d62f8.1639721750.git.dyroneteng@gmail.com>
Message-ID: <211217.86o85f8jey.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Fri, Dec 17 2021, Teng Long wrote:

> [...]
>  int cmd_ls_tree(int argc, const char **argv, const char *prefix)
>  {
>  	struct object_id oid;
> @@ -133,12 +189,14 @@ int cmd_ls_tree(int argc, const char **argv, const char *prefix)
>  			LS_SHOW_TREES),
>  		OPT_SET_INT('z', NULL, &line_termination,
>  			    N_("terminate entries with NUL byte"), 0),
> -		OPT_BIT('l', "long", &ls_options, N_("include object size"),
> -			LS_SHOW_SIZE),
> -		OPT_BIT(0, "name-only", &ls_options, N_("list only filenames"),
> -			LS_NAME_ONLY),
> -		OPT_BIT(0, "name-status", &ls_options, N_("list only filenames"),
> -			LS_NAME_ONLY),
> +		OPT_CMDMODE('l', "long", &cmdmode, N_("include object size"),
> +			    MODE_LONG),
> +		OPT_CMDMODE(0, "name-only", &cmdmode, N_("list only filenames"),
> +			    MODE_NAME_ONLY),
> +		OPT_CMDMODE(0, "name-status", &cmdmode, N_("list only filenames"),
> +			    MODE_NAME_ONLY),
> +		OPT_CMDMODE(0, "object-only", &cmdmode, N_("list only objects"),
> +			    MODE_OBJECT_ONLY),
>  		OPT_SET_INT(0, "full-name", &chomp_prefix,
>  			    N_("use full path names"), 0),
>  		OPT_BOOL(0, "full-tree", &full_tree,

Very nice to have the OPT_CMDMODE for asserting the usage, but this
would be even better if it were done as a separate commit. I.e. let's
first do prep cleanups, then the new --object-name mode.

> +test_expect_success 'usage: incompatible options: --name-status with --long' '
> +	test_expect_code 129 git ls-tree --long --name-status
> +'
> +
> +test_expect_success 'usage: incompatible options: --name-only with --long' '
> +	test_expect_code 129 git ls-tree --long --name-only
> +'
> +
>  test_done
> [...]
> +test_expect_success 'usage: incompatible options: --name-only with --object-only' '
> +	test_expect_code 129 git ls-tree --object-only --name-only
> +'
> +
> +test_expect_success 'usage: incompatible options: --name-status with --object-only' '
> +	test_expect_code 129 git ls-tree --object-only --name-status
> +'
> +
> +test_expect_success 'usage: incompatible options: --long with --object-only' '
> +	test_expect_code 129 git ls-tree --object-only --long
> +'

These tests don't check for what you think they check, because you don't
supply a <tree-ish>. So they're really just dying for the same reason a:

    git ls-tree

Would.
