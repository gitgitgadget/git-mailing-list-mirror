Return-Path: <SRS0=uwne=C7=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1053C2D0E2
	for <git@archiver.kernel.org>; Tue, 22 Sep 2020 23:53:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7673220724
	for <git@archiver.kernel.org>; Tue, 22 Sep 2020 23:53:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="CroDAvsZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726920AbgIVXxB (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 22 Sep 2020 19:53:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39766 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726641AbgIVXxB (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 22 Sep 2020 19:53:01 -0400
Received: from mail-qv1-xf49.google.com (mail-qv1-xf49.google.com [IPv6:2607:f8b0:4864:20::f49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB071C061755
        for <git@vger.kernel.org>; Tue, 22 Sep 2020 16:53:00 -0700 (PDT)
Received: by mail-qv1-xf49.google.com with SMTP id f21so13094584qve.9
        for <git@vger.kernel.org>; Tue, 22 Sep 2020 16:53:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=jCNRcPARdQ0Yn3xQYryFTkyDvzNdlajrWCljhSFLzH8=;
        b=CroDAvsZ2hYmfhUlXxxANBfyxLR56ekvi/GCVqUUG5O2xM48afhwi+DAuUHnpkeEX0
         UnXF/2y+6NdQYNX4W7N/TK8WIc5bM+LzcW90fXPayIuj4lLWGDq3t7iVCOgWBHnS26Sx
         F9t/XuBmgprxdwJ1gwAWV9vWTlOfYoEZFfDNymA9DV86J4QZEctnD67NiWoItNkaiZ++
         Qcp8jt7HsvTfVfxuy2uiaXWpMiqRPxga7p5ah526eVywjSeGvHT/8wGQjyjnHfWBl2he
         7Ikl1PfcsTHbkfv75S1tDemf+qvZt0hxqA3+++xQCP85wk+a9HpfYceaDJWgKUYA9YPs
         /Fng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=jCNRcPARdQ0Yn3xQYryFTkyDvzNdlajrWCljhSFLzH8=;
        b=h/dbRgkhQBbUVYGqeBvFYL+LROm59w82SCOGDAwyuBgLHQW2o7H+p6J4VLRRpbj68a
         k4nNR6Rq/TdWdF/gmNkVp3PBbx+Wr0Ukq7nD8xPZWC4aU2Mjk8NjAd1Gdej+6uU0JJhh
         SsyI6EykTNkzG5GsCdl2aR9J0OYgtbnpZRpc2btjPyTe5Yd3Bqldx2y96DmObnNc55Cb
         M8Oie+3nTtzC3n8q8bCfivO2c1PP6GCJpDXbhnERUnH3Y2jvUgr7jLjS0qMPwSVjMVny
         qIxzpxYUo0BHcc+YZjl+u3JL/XZLAjM1NTmJoTdZQipPFzhm+Zu8UhGmfi24fc0gdR8S
         e5xg==
X-Gm-Message-State: AOAM532bWtIk84NinOYGpboqDlQ0o1FRZAnPFhDh89Srv8SfTp2eKkSJ
        Ua5nLkhIRXQC3RlQuxI7ZxzAUSkQuxSNC5Dv8b9P
X-Google-Smtp-Source: ABdhPJxXmtXxqnfrKnU7DG1NFT6mn8OUMRaQ1QdV1wr+iepXOgNKN+u51L99V1wTeq6Jd11Zx8xKYfG5Jqc2faemo3NE
Sender: "jonathantanmy via sendgmr" <jonathantanmy@twelve4.c.googlers.com>
X-Received: from twelve4.c.googlers.com ([fda3:e722:ac3:10:24:72f4:c0a8:18d])
 (user=jonathantanmy job=sendgmr) by 2002:ad4:58e7:: with SMTP id
 di7mr8578318qvb.36.1600818780062; Tue, 22 Sep 2020 16:53:00 -0700 (PDT)
Date:   Tue, 22 Sep 2020 16:52:58 -0700
In-Reply-To: <e9bb32f53ade2067f773bfe6e5c13ed1a5d694a6.1598380599.git.gitgitgadget@gmail.com>
Message-Id: <20200922235258.920928-1-jonathantanmy@google.com>
Mime-Version: 1.0
References: <e9bb32f53ade2067f773bfe6e5c13ed1a5d694a6.1598380599.git.gitgitgadget@gmail.com>
X-Mailer: git-send-email 2.28.0.681.g6f77f65b4e-goog
Subject: Re: [PATCH v3 8/8] maintenance: add incremental-repack auto condition
From:   Jonathan Tan <jonathantanmy@google.com>
To:     gitgitgadget@gmail.com
Cc:     git@vger.kernel.org, sandals@crustytoothpaste.net,
        steadmon@google.com, jrnieder@gmail.com, peff@peff.net,
        congdanhqx@gmail.com, phillip.wood123@gmail.com,
        emilyshaffer@google.com, sluongng@gmail.com,
        jonathantanmy@google.com, derrickstolee@github.com,
        dstolee@microsoft.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

> diff --git a/t/t7900-maintenance.sh b/t/t7900-maintenance.sh
> index 5c08afc19a..6f878b0141 100755
> --- a/t/t7900-maintenance.sh
> +++ b/t/t7900-maintenance.sh
> @@ -220,4 +220,35 @@ test_expect_success EXPENSIVE 'incremental-repack 2g limit' '
>  		 --no-progress --batch-size=2147483647 <run-2g.txt
>  '
>  
> +test_expect_success 'maintenance.incremental-repack.auto' '
> +	git repack -adk &&
> +	git config core.multiPackIndex true &&
> +	git multi-pack-index write &&

After this, there is exactly one pack, and it is in the MIDX.

> +	GIT_TRACE2_EVENT="$(pwd)/midx-init.txt" git \
> +		-c maintenance.incremental-repack.auto=1 \
> +		maintenance run --auto --task=incremental-repack 2>/dev/null &&
> +	test_subcommand ! git multi-pack-index write --no-progress <midx-init.txt &&
> +	for i in 1 2

Same comment as in the earlier patch - why 2 iterations?

> +	do
> +		test_commit A-$i &&
> +		git pack-objects --revs .git/objects/pack/pack <<-\EOF &&
> +		HEAD
> +		^HEAD~1
> +		EOF
> +		GIT_TRACE2_EVENT=$(pwd)/trace-A-$i git \
> +			-c maintenance.incremental-repack.auto=2 \
> +			maintenance run --auto --task=incremental-repack 2>/dev/null &&
> +		test_subcommand ! git multi-pack-index write --no-progress <trace-A-$i &&

OK - one pack not in the MIDX, so this does not get run.

> +		test_commit B-$i &&
> +		git pack-objects --revs .git/objects/pack/pack <<-\EOF &&
> +		HEAD
> +		^HEAD~1
> +		EOF
> +		GIT_TRACE2_EVENT=$(pwd)/trace-B-$i git \
> +			-c maintenance.incremental-repack.auto=2 \
> +			maintenance run --auto --task=incremental-repack 2>/dev/null &&
> +		test_subcommand git multi-pack-index write --no-progress <trace-B-$i || return 1

OK - 2 packs not in the MIDX, so this gets run.

As I said in my review of patch 1, apart from my minor comments in this
and the preceding patches, these patches look good to me.
