Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-21.5 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,FSL_HELO_FAKE,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10D04C4361B
	for <git@archiver.kernel.org>; Wed,  9 Dec 2020 18:52:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CE4DA2228A
	for <git@archiver.kernel.org>; Wed,  9 Dec 2020 18:52:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387515AbgLISwQ (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 9 Dec 2020 13:52:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48750 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387443AbgLISwB (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 9 Dec 2020 13:52:01 -0500
Received: from mail-pg1-x543.google.com (mail-pg1-x543.google.com [IPv6:2607:f8b0:4864:20::543])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5BBFDC06179C
        for <git@vger.kernel.org>; Wed,  9 Dec 2020 10:51:21 -0800 (PST)
Received: by mail-pg1-x543.google.com with SMTP id o4so1784164pgj.0
        for <git@vger.kernel.org>; Wed, 09 Dec 2020 10:51:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mail-followup-to:references
         :mime-version:content-disposition:in-reply-to;
        bh=weO2wH5xAecYOKrr5B4/nfLpfHPcvaYu7gYDB8R+QDY=;
        b=GQWR5+ynQEH06fqpV3FEIqzM+DNCkx4fN7UGpMneQZTGbadQkSx8Nv+fAB1FlorgZY
         uP2ELN03xFf2V7RbwnefcMnjq1EdcF50Spx2dj9ssbxm1hYmQ66DQFCCnfnxeVT+sFrb
         ZhT19oq9qLt16QF6DJxjDEVT2s3NdVUFnceVm/XWCs5s4nHO+AHhy+2l9AmpE7GXtucB
         J3XIz3uoKD/UUaGbiJoLPvsap0QZ2xGNzb2JJmd5IpH7ywKY57UctQNfaST/dFUyEP7U
         RA0pLqSsF5Chl72VvUoPnpkGEEhj7M9rwfmPb1WtO25sZjwnOabPERLnoe635JN9Csq6
         df6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to;
        bh=weO2wH5xAecYOKrr5B4/nfLpfHPcvaYu7gYDB8R+QDY=;
        b=RdHsm1523zJ5F/Siz2KjKE/v6nMB4PdXwr2ylSbgtjqvhLB0tz6QbePRxjqR/m4ChT
         5L3z5PaEvsqUXMTtszbjVdU6y/0Igp5vd5RNw2RpClGvKo3hMdU7pOHLpTMSS36NCDDO
         aqXYjimtUoFt6xshUqQtBWZorSqOYpfas8GdQHPr/dOq7Q0nzccLEwCaLlgIWDB6x/4b
         SulmdDFjQAdPhDwXib1EaZBRNA/ICRRcFH+xOCSwkFsxwVTdZNvh0Mtv1EkGfhD9xMfO
         nEj8pP4h287dgqaH6itfoNya8FQ1SnIjPlOq6Nb8XR/FetfCPbvMx0HAhNxm39kPU7M5
         Oopg==
X-Gm-Message-State: AOAM533E9r8bor1jW3kAPrxfCsYyYlgGXAVQrAc2UcHtnQMtFvAjvFZP
        6XeQDmcg96Hdmo6ztuzGvV07gg==
X-Google-Smtp-Source: ABdhPJxPo4S/Wl3xYhH0Tu4G38KCuE3cOwa/bwIH2IFTzKYZkH2i0BrpbPcu1FutairQagIHeamGNw==
X-Received: by 2002:a63:48f:: with SMTP id 137mr3192151pge.172.1607539880829;
        Wed, 09 Dec 2020 10:51:20 -0800 (PST)
Received: from google.com ([2620:15c:2ce:200:1ea0:b8ff:fe74:b4c1])
        by smtp.gmail.com with ESMTPSA id g85sm3339033pfb.4.2020.12.09.10.51.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Dec 2020 10:51:19 -0800 (PST)
Date:   Wed, 9 Dec 2020 10:51:14 -0800
From:   Josh Steadmon <steadmon@google.com>
To:     Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, jrnieder@gmail.com, jonathantanmy@google.com,
        sluongng@gmail.com, congdanhqx@gmail.com,
        SZEDER =?iso-8859-1?Q?G=E1bor?= <szeder.dev@gmail.com>,
        Derrick Stolee <stolee@gmail.com>,
        Martin =?iso-8859-1?Q?=C5gren?= <martin.agren@gmail.com>,
        Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee <dstolee@microsoft.com>
Subject: Re: [PATCH v4 5/8] maintenance: add start/stop subcommands
Message-ID: <20201209185114.GN36751@google.com>
Mail-Followup-To: Josh Steadmon <steadmon@google.com>,
        Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, jrnieder@gmail.com, jonathantanmy@google.com,
        sluongng@gmail.com, congdanhqx@gmail.com,
        SZEDER =?iso-8859-1?Q?G=E1bor?= <szeder.dev@gmail.com>,
        Derrick Stolee <stolee@gmail.com>,
        Martin =?iso-8859-1?Q?=C5gren?= <martin.agren@gmail.com>,
        Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee <dstolee@microsoft.com>
References: <pull.724.v3.git.1601902635.gitgitgadget@gmail.com>
 <pull.724.v4.git.1602782524.gitgitgadget@gmail.com>
 <5194f6b1facbd14cc17eea0337c0cc397a2a51fc.1602782524.git.gitgitgadget@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5194f6b1facbd14cc17eea0337c0cc397a2a51fc.1602782524.git.gitgitgadget@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 2020.10.15 17:22, Derrick Stolee via GitGitGadget wrote:
> diff --git a/t/t7900-maintenance.sh b/t/t7900-maintenance.sh
> index 8f383d01d9..7715e40391 100755
> --- a/t/t7900-maintenance.sh
> +++ b/t/t7900-maintenance.sh
> @@ -315,4 +315,32 @@ test_expect_success 'register and unregister' '
>  	test_cmp before actual
>  '
>  
> +test_expect_success 'start from empty cron table' '
> +	GIT_TEST_CRONTAB="test-tool crontab cron.txt" git maintenance start &&
> +
> +	# start registers the repo
> +	git config --get --global maintenance.repo "$(pwd)" &&
> +
> +	grep "for-each-repo --config=maintenance.repo maintenance run --schedule=daily" cron.txt &&
> +	grep "for-each-repo --config=maintenance.repo maintenance run --schedule=hourly" cron.txt &&
> +	grep "for-each-repo --config=maintenance.repo maintenance run --schedule=weekly" cron.txt
> +'
> +
> +test_expect_success 'stop from existing schedule' '
> +	GIT_TEST_CRONTAB="test-tool crontab cron.txt" git maintenance stop &&
> +
> +	# stop does not unregister the repo
> +	git config --get --global maintenance.repo "$(pwd)" &&
> +
> +	# Operation is idempotent
> +	GIT_TEST_CRONTAB="test-tool crontab cron.txt" git maintenance stop &&
> +	test_must_be_empty cron.txt
> +'
> +
> +test_expect_success 'start preserves existing schedule' '
> +	echo "Important information!" >cron.txt &&
> +	GIT_TEST_CRONTAB="test-tool crontab cron.txt" git maintenance start &&
> +	grep "Important information!" cron.txt
> +'
> +
>  test_done

These two test cases fail when the paths passed to git-config contain
ERE metacharacters [similar to the issue addressed in 483a6d9b5da
(maintenance: use 'git config --fixed-value', 2020-11-25)]. Since these
are already in next, I'm providing a patch to add '--fixed-value' to the
git-config calls here as well.

-- >8 --
Subject: [PATCH] t7900: use --fixed-value in git-maintenance tests

Use --fixed-value in git-config calls in the git-maintenance tests, so
that the tests will continue to work even if the repo path contains
shell metacharacters.

Signed-off-by: Josh Steadmon <steadmon@google.com>
---
 t/t7900-maintenance.sh | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/t/t7900-maintenance.sh b/t/t7900-maintenance.sh
index fab0e01c39..41bf523953 100755
--- a/t/t7900-maintenance.sh
+++ b/t/t7900-maintenance.sh
@@ -422,7 +422,7 @@ test_expect_success 'start from empty cron table' '
 	GIT_TEST_CRONTAB="test-tool crontab cron.txt" git maintenance start &&
 
 	# start registers the repo
-	git config --get --global maintenance.repo "$(pwd)" &&
+	git config --get --global --fixed-value maintenance.repo "$(pwd)" &&
 
 	grep "for-each-repo --config=maintenance.repo maintenance run --schedule=daily" cron.txt &&
 	grep "for-each-repo --config=maintenance.repo maintenance run --schedule=hourly" cron.txt &&
@@ -433,7 +433,7 @@ test_expect_success 'stop from existing schedule' '
 	GIT_TEST_CRONTAB="test-tool crontab cron.txt" git maintenance stop &&
 
 	# stop does not unregister the repo
-	git config --get --global maintenance.repo "$(pwd)" &&
+	git config --get --global --fixed-value maintenance.repo "$(pwd)" &&
 
 	# Operation is idempotent
 	GIT_TEST_CRONTAB="test-tool crontab cron.txt" git maintenance stop &&
-- 
2.29.2.576.ga3fc446d84-goog

