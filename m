Return-Path: <SRS0=cPh9=BE=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3BF27C433E1
	for <git@archiver.kernel.org>; Sat, 25 Jul 2020 01:47:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 13A742070E
	for <git@archiver.kernel.org>; Sat, 25 Jul 2020 01:47:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AeeXOA5a"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727772AbgGYBrN (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 24 Jul 2020 21:47:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40052 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726701AbgGYBrM (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 24 Jul 2020 21:47:12 -0400
Received: from mail-pj1-x1041.google.com (mail-pj1-x1041.google.com [IPv6:2607:f8b0:4864:20::1041])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB828C0619D3
        for <git@vger.kernel.org>; Fri, 24 Jul 2020 18:47:12 -0700 (PDT)
Received: by mail-pj1-x1041.google.com with SMTP id t15so6469389pjq.5
        for <git@vger.kernel.org>; Fri, 24 Jul 2020 18:47:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=3fKPQpa2k0dp9dn5LjfJ4hDyncUYGjqMkFCDW6DTlro=;
        b=AeeXOA5arLgm+WoaunicNTRN+orvp5frfedFylMkvGBDOHSFziw4cYku/+05secMce
         TvsfakZOiYvSSAdjzCpKlMYpA27EgGXbWlZcLHkWBsDrehoHPhZmbxXdPt5DW0AD2cZL
         5w7hOysLMwCPFBdAjyE3y/vUpl7tPLkmp772k+90FaMU/XDlMiHAk1p+TCxXO45kT3/e
         kUXLOcGZUMiAqAzXHfoBm7dJQcQSdrrKQPKC2FmjuPY6yLW4Yw4c1CfQv6k1XTl1F6BM
         Yynx5iywZq7SmCuzHntfgKzSfnQJSNjSP0dPTNEGqWXGfKzdx5ThcSq4sq8WOgVP1wOU
         dH0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=3fKPQpa2k0dp9dn5LjfJ4hDyncUYGjqMkFCDW6DTlro=;
        b=RfHFjBjB7bsBxO3orGs6u0BuW7Rd2d0GM6lhjXHgO+oeo5nGO/EB3A2taF55g2Et86
         DQ1AlNRAYH0Bd5zFEWluB3R4iZDRZj97BNFnZbfppJ1vm4Uk3IP7Dq+F9u1jpDvspbOV
         roejQy7KRn6z7Qc7TTdj4Mf+ZVrh+sWVrCzxjwRSsyDsr+eryaFFA8hdcHW59q9gLOFZ
         ow22m/8gFwkL5aOrfLOYK9a3iQt6QQ80QWUqBe5d3PP5M+3ELKId/bQ96c534GcvkoQz
         2LcX0SZ9H+gw3x6h9Xtwzo+U0/2IfG1+qJhD08MrcPBnypPCCFxzfFFHtL77zykFDW9g
         JSiw==
X-Gm-Message-State: AOAM532LznhEXxcgqKI+G84AuAVvfAib5W5JyS/DSHLaUJJgQ6sVZ8eF
        fZg0+vVZkGCLkITVwYLHS88=
X-Google-Smtp-Source: ABdhPJyUvy1RZ6LlqWLE3d/8WZchgEuyx1M6/sP4cTRZj1ux74APvap3Dz8DG6QQo/NPgCMUH6+nSA==
X-Received: by 2002:a17:90a:1342:: with SMTP id y2mr7996587pjf.98.1595641632410;
        Fri, 24 Jul 2020 18:47:12 -0700 (PDT)
Received: from localhost ([2402:800:6375:ea17:7ad5:df16:a252:473b])
        by smtp.gmail.com with ESMTPSA id o2sm7620001pfh.160.2020.07.24.18.47.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Jul 2020 18:47:11 -0700 (PDT)
Date:   Sat, 25 Jul 2020 08:47:09 +0700
From:   =?utf-8?B?xJBvw6BuIFRy4bqnbiBDw7RuZw==?= Danh 
        <congdanhqx@gmail.com>
To:     Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Johannes.Schindelin@gmx.de,
        sandals@crustytoothpaste.net, steadmon@google.com,
        jrnieder@gmail.com, peff@peff.net, phillip.wood123@gmail.com,
        emilyshaffer@google.com, sluongng@gmail.com,
        jonathantanmy@google.com,
        Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee <dstolee@microsoft.com>
Subject: Re: [PATCH v2 01/18] maintenance: create basic maintenance runner
Message-ID: <20200725014709.GB2436@danh.dev>
References: <pull.671.git.1594131695.gitgitgadget@gmail.com>
 <pull.671.v2.git.1595527000.gitgitgadget@gmail.com>
 <63ec602a07756a41f8ccddd745562c567a4b3ed7.1595527000.git.gitgitgadget@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <63ec602a07756a41f8ccddd745562c567a4b3ed7.1595527000.git.gitgitgadget@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 2020-07-23 17:56:23+0000, Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com> wrote:
> From: Derrick Stolee <dstolee@microsoft.com>
> diff --git a/t/t7900-maintenance.sh b/t/t7900-maintenance.sh
> new file mode 100755
> index 0000000000..d00641c4dd
> --- /dev/null
> +++ b/t/t7900-maintenance.sh
> @@ -0,0 +1,22 @@
> +#!/bin/sh
> +
> +test_description='git maintenance builtin'
> +
> +GIT_TEST_COMMIT_GRAPH=0
> +GIT_TEST_MULTI_PACK_INDEX=0
> +
> +. ./test-lib.sh
> +
> +test_expect_success 'help text' '
> +	test_must_fail git maintenance -h 2>err &&
> +	test_i18ngrep "usage: git maintenance run" err
> +'

I think this test has been tested better already in t0012,
Anyway, if we would like to check the word "git maintenance run"
explicitly here, it would be clearer to

s/test_must_fail/test_expect_code 129/

> +
> +test_expect_success 'gc [--auto]' '
> +	GIT_TRACE2_EVENT="$(pwd)/run-no-auto.txt" git maintenance run &&
> +	GIT_TRACE2_EVENT="$(pwd)/run-auto.txt" git maintenance run --auto &&
> +	grep ",\"gc\"]" run-no-auto.txt  &&
> +	grep ",\"gc\",\"--auto\"]" run-auto.txt
> +'
> +
> +test_done
> -- 
> gitgitgadget
> 

-- 
Danh
