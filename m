Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.3 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93466C433B4
	for <git@archiver.kernel.org>; Thu,  8 Apr 2021 00:23:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 446F661182
	for <git@archiver.kernel.org>; Thu,  8 Apr 2021 00:23:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229505AbhDHAYH (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 7 Apr 2021 20:24:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37352 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229480AbhDHAYG (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 7 Apr 2021 20:24:06 -0400
Received: from mail-qv1-xf49.google.com (mail-qv1-xf49.google.com [IPv6:2607:f8b0:4864:20::f49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A3E6C061760
        for <git@vger.kernel.org>; Wed,  7 Apr 2021 17:23:56 -0700 (PDT)
Received: by mail-qv1-xf49.google.com with SMTP id s13so92010qvn.22
        for <git@vger.kernel.org>; Wed, 07 Apr 2021 17:23:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=SQGHv2YjM7epy7wF2gzm5t1ZGOws2IHxGfBSmrWra4o=;
        b=GTiOZurKL4ULCzXrTGXFAwbPZ3NGYKcecO31Dcbt+Ta8sf0Ee4MIXS5RiZqn6WBHJZ
         ZRBBOmE+92H9X5P9/pla57RQd87GYKHZJVAas/XKoJQobkHwiNAos1Z/eI4Y0rEr9jCY
         H+NTIyjlClgK/Y6QYmJ0o9WPcy3u49ryn6VL4rRops6BQgGqa3U2GOkGHbWwcaDL9jem
         NIt1/tInv5ESmHUfonlNiXjr7Ku6VU1ItA153x1hXu4rbYwE9WFsy8uqVg1DkJvLGyNh
         SPjyn/cmUAVAcLQ1ORsfeI2WqpoES231q6rAjSoq0R8VSM3k/UdNLtl/DrpusmM4iwav
         mCLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=SQGHv2YjM7epy7wF2gzm5t1ZGOws2IHxGfBSmrWra4o=;
        b=pOTmmnJnlwcwiHE8T2pEaRfLOzBbwSrLho6x4yDnX+aX2IGR6bpvJ+EBUbKgPnA2g5
         yZ3gKS1MLSGNTdRDXF7kZsHx6EOS4fKvs+Gn+rL3lHeQQ+GfEOFfOngJPzbg2i/yKd1e
         9Kwg5imMGPvYL9wlslK/mevYCFSMSSbAY9sHoc5uxbHIAOrnkoIDCTEC/yMTYA332lVa
         hh92KP824PmdjsLLCHImmYNHaXgdEqKhD2h2Cvs3kAuVQ51Kne6WbfUVi8EAfeTdEfnn
         Jfmc2cs2BG2AMrNyio7tKqR+N2GUuRflPqVzTusEKH0Jn7glvoi8MVaWj3tFMSXKeJvj
         2KRA==
X-Gm-Message-State: AOAM5305KVHe4Y1MOyCbTDBtb8eRgQUWdjYsWv25tbBtzyC3OoDDJkqn
        gvhraGJqFxVI/MXkdMLu2UYbw7aySdtKBiY35JLF
X-Google-Smtp-Source: ABdhPJxQRK2ANApX465u+vuFZZNYpm5jOFDSbdD2Yb0uWIh2v4RBjmAfiUCGG9O8Wi/zDT1SHo+qUWcZyDyQNBqAwKJt
X-Received: from twelve4.c.googlers.com ([fda3:e722:ac3:10:24:72f4:c0a8:437a])
 (user=jonathantanmy job=sendgmr) by 2002:ad4:5a14:: with SMTP id
 ei20mr6195028qvb.1.1617841435444; Wed, 07 Apr 2021 17:23:55 -0700 (PDT)
Date:   Wed,  7 Apr 2021 17:23:53 -0700
In-Reply-To: <9592224e3d428762c6f9b38a0bcc2cee5c3dff6c.1617734871.git.gitgitgadget@gmail.com>
Message-Id: <20210408002353.2467818-1-jonathantanmy@google.com>
Mime-Version: 1.0
References: <9592224e3d428762c6f9b38a0bcc2cee5c3dff6c.1617734871.git.gitgitgadget@gmail.com>
X-Mailer: git-send-email 2.31.0.208.g409f899ff0-goog
Subject: Re: [PATCH v2 5/5] maintenance: allow custom refspecs during prefetch
From:   Jonathan Tan <jonathantanmy@google.com>
To:     gitgitgadget@gmail.com
Cc:     git@vger.kernel.org, tom.saeger@oracle.com, gitster@pobox.com,
        sunshine@sunshineco.com, stolee@gmail.com,
        derrickstolee@github.com, dstolee@microsoft.com,
        Jonathan Tan <jonathantanmy@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

> +test_expect_success 'prefetch custom refspecs' '
> +	git -C clone1 branch -f special/fetched HEAD &&
> +	git -C clone1 branch -f special/secret/not-fetched HEAD &&
> +
> +	# create multiple refspecs for remote1
> +	git config --add remote.remote1.fetch "+refs/heads/special/fetched:refs/heads/fetched" &&
> +	git config --add remote.remote1.fetch "^refs/heads/special/secret/not-fetched" &&
> +
> +	GIT_TRACE2_EVENT="$(pwd)/prefetch-refspec.txt" git maintenance run --task=prefetch 2>/dev/null &&
> +
> +	fetchargs="--prune --no-tags --no-write-fetch-head --recurse-submodules=no --refmap= --quiet" &&
> +
> +	# skips second refspec because it is not a pattern type

What second refspec is being skipped?

> +	rs1="+refs/heads/*:refs/prefetch/remotes/remote1/*" &&
> +	rs2="+refs/heads/special/fetched:refs/prefetch/heads/fetched" &&
> +	rs3="^refs/heads/special/secret/not-fetched" &&
> +
> +	test_subcommand git fetch remote1 $fetchargs "$rs1" "$rs2" "$rs3" <prefetch-refspec.txt &&
> +	test_subcommand git fetch remote2 $fetchargs "+refs/heads/*:refs/prefetch/remotes/remote2/*" <prefetch-refspec.txt &&

How is this command generated? I don't see any mention of remote2 in
this test. (If it's because this repo was configured in a previous test
and some of the configuration carried over, I think it's best to start
in a new repo or at least have the previous config be cleared.)

> +
> +	# first refspec is overridden by second
> +	test_must_fail git rev-parse refs/prefetch/special/fetched &&
> +	git rev-parse refs/prefetch/heads/fetched &&
> +
> +	# possible incorrect places for the non-fetched ref
> +	test_must_fail git rev-parse refs/prefetch/remotes/remote1/secret/not-fetched &&
> +	test_must_fail git rev-parse refs/prefetch/remotes/remote1/not-fetched &&
> +	test_must_fail git rev-parse refs/heads/secret/not-fetched &&
> +	test_must_fail git rev-parse refs/heads/not-fetched
> +'

Other than this and the other comments that others have brought up, this
series looks good.
