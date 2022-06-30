Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0CCC3CCA47E
	for <git@archiver.kernel.org>; Thu, 30 Jun 2022 10:27:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234639AbiF3K1J (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 30 Jun 2022 06:27:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36384 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234133AbiF3K0x (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 30 Jun 2022 06:26:53 -0400
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43D4D4F1A1
        for <git@vger.kernel.org>; Thu, 30 Jun 2022 03:26:39 -0700 (PDT)
Received: by mail-ed1-x534.google.com with SMTP id fd6so25893169edb.5
        for <git@vger.kernel.org>; Thu, 30 Jun 2022 03:26:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version;
        bh=fcRAX5/QTk+cTepjTu+RsgNRwkSrJQC61kHNPimIgUY=;
        b=lHzDfiZNmtOc5POcZXDoRgNLOm2IPqIcGSKOZ9aVmDW6GYIJq6EYdR6Dm+S365RvWN
         IzMcpmvlEUfVLgvYWHTegrIZQZmq3AhdZAylCHn00sf/IHjpXQ6vLUU41iVEAnlriuCv
         ESZN02GRC87ZItwXOKGDBbd7tYF/a5Poo3+1bBJGDHNIRmHjPRWanqua6BTr/pkMI+gC
         V9yAGWzY0W7vNW0/+0OZUfd3D2gZQLDLb5JMYz3A5Ow7YZighW+9knnQqENt7RIWBZVX
         sYBWTdiYQME278bW7ztR2/ETRqqkN927khdZOFeCIHfQM0By1Dtop+mpAvJlFDhEGWOX
         FgKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version;
        bh=fcRAX5/QTk+cTepjTu+RsgNRwkSrJQC61kHNPimIgUY=;
        b=ReGazuI97kvGCWI8KUIM84zDezbia/9QqjKtp5FQszeqyVFWQHD6mU8Aqvt37asTbb
         zHl+2CsdV9Pq0qiJYMLhthan5YsZuhfIQ4ImNvZVUbGL371eQMtVaqd5xOc6Eob92e3g
         cTX2ujLqE6vsyQE0MGp9su2tbfvkCNiNwxkQesoAee9VqBcPpT3W4XZH18nZR3NJ0Z9K
         eW1jlsyVUTg4foM8OW9c7Tqgin85r0e291/BLV/u/uR+nBxc1tWjYoZdij+8lacri/mf
         Wb/ZZ63SKu5evLuCUmrI2aYf6Yk6Ys/2W/JxGoZKmuNxHhnCOKv/s31gL/KPPhc2VEMj
         4yeQ==
X-Gm-Message-State: AJIora8TR1SP8tiLL6/qj8NoL0UJpUnQ3uQSr7BmEQJFZIdrk5n41BPE
        i3DnYLgdAJW4522LD6B77M4epcKoArUzfg==
X-Google-Smtp-Source: AGRyM1u5pfpN8V/o97ZmK6O4XNrOoqB7Uw0H1st/TvYJSJE3LlpKkQQVhtYKng2Ahq2Yc6mXsABc6Q==
X-Received: by 2002:a05:6402:26d5:b0:435:aba2:9495 with SMTP id x21-20020a05640226d500b00435aba29495mr10613423edd.133.1656584797487;
        Thu, 30 Jun 2022 03:26:37 -0700 (PDT)
Received: from gmgdl (dhcp-077-248-183-071.chello.nl. [77.248.183.71])
        by smtp.gmail.com with ESMTPSA id c11-20020aa7c98b000000b00435a912358dsm12902511edt.30.2022.06.30.03.26.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Jun 2022 03:26:36 -0700 (PDT)
Received: from avar by gmgdl with local (Exim 4.95)
        (envelope-from <avarab@gmail.com>)
        id 1o6rNb-002EvA-NV;
        Thu, 30 Jun 2022 12:26:35 +0200
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Jonathan Tan <jonathantanmy@google.com>,
        Calvin Wan <calvinwan@google.com>,
        Elijah Newren <newren@gmail.com>
Subject: Re: [PATCH v2 1/3] t6423: add tests of dual directory rename plus
 add/add conflict
Date:   Thu, 30 Jun 2022 12:21:29 +0200
References: <pull.1268.git.1655871651.gitgitgadget@gmail.com>
 <pull.1268.v2.git.1656572225.gitgitgadget@gmail.com>
 <bf4c03d01d5730503eb710e92a80136d5caa981a.1656572225.git.gitgitgadget@gmail.com>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.7.12
In-reply-to: <bf4c03d01d5730503eb710e92a80136d5caa981a.1656572225.git.gitgitgadget@gmail.com>
Message-ID: <220630.86tu82e9b8.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Thu, Jun 30 2022, Elijah Newren via GitGitGadget wrote:

> From: Elijah Newren <newren@gmail.com>

> +test_setup_12l () {
> +	test_create_repo 12l_$1 &&

Can & should just be "git init", see f0d4d398e28 (test-lib: split up and
deprecate test_create_repo(), 2021-05-10).


> +	(
> +		cd 12l_$1 &&
> +
> +		mkdir -p sub1 sub2

The "-p" here isn't needed, you're not creating recursive directories. 

> +		git ls-files -s >out &&
> +		test_line_count = 5 out &&

Can't this just use test_stdout_line_count? Except...

> +
> +		git rev-parse >actual \
> +			:0:sub3/file :0:sub3/newfile :0:sub3/sub2/other \
> +			:2:sub1/sub2/new_add_add_file \
> +			:3:sub1/sub2/new_add_add_file &&
> +		git rev-parse >expect \
> +			O:sub1/file  B:sub1/newfile O:sub2/other \
> +			A:sub2/new_add_add_file \
> +			B:sub1/sub2/new_add_add_file &&
> +		test_cmp expect actual &&
> +
> +		git ls-files -o >actual &&
> +		test_write_lines actual expect out >expect &&
> +		test_cmp expect actual

This test seems a bit odd, here we're just checking that we've created
scratch files for the internal use of our test, why is it important that
we have an "out" file, when the only reason we have it is because we
needed it for checking the "ls-files" line count above?

> +	)
> +'
> +
> +test_expect_merge_algorithm failure failure '12l (A into B): Rename into each other + add/add conflict' '
> +	test_setup_12l AintoB &&
> +	(
> +		cd 12l_AintoB &&
> +
> +		git checkout -q B^0 &&
> +
> +		test_must_fail git -c merge.directoryRenames=true merge -s recursive A^0 &&
> +
> +		git ls-files -s >out &&
> +		test_line_count = 5 out &&

ditto.

> +		git rev-parse >actual \
> +			:0:sub3/file :0:sub3/newfile :0:sub3/sub2/other \
> +			:2:sub1/sub2/new_add_add_file \
> +			:3:sub1/sub2/new_add_add_file &&
> +		git rev-parse >expect \
> +			O:sub1/file  B:sub1/newfile O:sub2/other \
> +			B:sub1/sub2/new_add_add_file \
> +			A:sub2/new_add_add_file &&
> +		test_cmp expect actual &&
> +
> +		git ls-files -o >actual &&
> +		test_write_lines actual expect out >expect &&

ditto
