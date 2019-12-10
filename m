Return-Path: <SRS0=g4/7=2A=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2393BC2D0C6
	for <git@archiver.kernel.org>; Tue, 10 Dec 2019 10:13:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DF5DE2077B
	for <git@archiver.kernel.org>; Tue, 10 Dec 2019 10:13:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bF3NzZcu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727305AbfLJKN4 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 10 Dec 2019 05:13:56 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:39021 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726574AbfLJKN4 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 10 Dec 2019 05:13:56 -0500
Received: by mail-wr1-f68.google.com with SMTP id y11so19309150wrt.6
        for <git@vger.kernel.org>; Tue, 10 Dec 2019 02:13:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=VQDOjwfVb5og7WVxDX8mM1vLoxrT+tj0wyWC02MlNR0=;
        b=bF3NzZcuNHzg6Xu6rfLRDaAeUApHG9dFXc11H1Jp/shvDOMGZDfHUFdsqGGjBQmXBi
         z3XTSt2W9DhSvvc1xNWogg7UGnpbveEKxs8qNWKd4VxoGrGdL8FA3EzofslW3HrE8mhZ
         j4swi4MuTntIwFXzk5ERmjJWzsrpFtCyy8wkZl2CCrOF/P10S4rzvHgX10C3FPDsGpIH
         NK+VF7T8pRKxl8UzP8R9rUHfXXldJS2/2V6YFTasWmdbfLw7E5QqmbwduVuJb624/elN
         +hav+7MbtnAmwfxcCiUy9+ptz5CwVXGKhbUYgepQGe3cUPk+YOGbc1ADpz3L5cebIlCy
         BT0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=VQDOjwfVb5og7WVxDX8mM1vLoxrT+tj0wyWC02MlNR0=;
        b=NcOmwV8qyRMWTtfFedmDQloUJed5mYVdagCtexChQfA/GjqQhpoqrczU1uRVTuozUR
         WNU8r1hADcckn0nH7SWs359XX7sRau0t5GDD5XnqNaRAo6g+bxfmh3K0fXw1xaSJaoS7
         ytL6554vq7u2NrN5bjpp+U9pZmJtsdmFwGqil+TeLCRsZ0wrK1w3SQTnuaCEeaJC2n1M
         1R74BLXppo0vsGPyiPo1OmWC5J5fquX10iyGbodbTmd/jhLwtKZ9qW953d7dRcP/Ss2d
         /2OSSZdi2q8H3MFY7TBkpG1dHcFrqWi1wuZS0Box3eGOGdlZlFwgCg+z0fHPp3HQZZMZ
         clfQ==
X-Gm-Message-State: APjAAAX4GZ9tWyvmvQFcWRwOvDoVjDqMYOkhpNcrEJhLd6qMfGxGddnh
        Nr7tb6bvv/bC5NZJgluaoLc=
X-Google-Smtp-Source: APXvYqw6MlH+7MN35oZi4nVwlSNBkZgP1Dg+Y34fO+eDAxkH5DLhVEiO/HxcVD9yMqTdfvzvWeGbxA==
X-Received: by 2002:adf:ee82:: with SMTP id b2mr2394426wro.194.1575972833877;
        Tue, 10 Dec 2019 02:13:53 -0800 (PST)
Received: from szeder.dev (x4db55d5d.dyn.telefonica.de. [77.181.93.93])
        by smtp.gmail.com with ESMTPSA id b63sm2486316wmb.40.2019.12.10.02.13.52
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 10 Dec 2019 02:13:53 -0800 (PST)
Date:   Tue, 10 Dec 2019 11:13:51 +0100
From:   SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
To:     Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, ukshah2@illinois.edu,
        Kevin.Willford@microsoft.com,
        Derrick Stolee <dstolee@microsoft.com>,
        Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 5/8] tests: disable fsmonitor in submodule tests
Message-ID: <20191210101351.GE6527@szeder.dev>
References: <pull.466.git.1574374826.gitgitgadget@gmail.com>
 <pull.466.v2.git.1575907804.gitgitgadget@gmail.com>
 <a5b0bf6ac7cd28fa47e26ab481f781d74c656f6a.1575907804.git.gitgitgadget@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <a5b0bf6ac7cd28fa47e26ab481f781d74c656f6a.1575907804.git.gitgitgadget@gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Dec 09, 2019 at 04:10:01PM +0000, Derrick Stolee via GitGitGadget wrote:
> From: Derrick Stolee <dstolee@microsoft.com>
> 
> The fsmonitor feature allows an external tool such as watchman to
> monitor the working directory. The direct test
> t7619-status-fsmonitor.sh provides some coverage, but it would be
> better to run the entire test suite with watchman enabled. This
> would provide more confidence that the feature is working as
> intended.
> 
> The fsmonitor feature struggles with submodules. Disable the
> GIT_TEST_FSMONITOR environment variable before running tests with
> a lot of submodule interactions.
> 
> Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
> ---
>  t/t3404-rebase-interactive.sh                | 1 +
>  t/t3600-rm.sh                                | 1 +
>  t/t4060-diff-submodule-option-diff-format.sh | 3 +++
>  t/t5526-fetch-submodules.sh                  | 2 ++
>  t/t7402-submodule-rebase.sh                  | 3 +++
>  t/t7406-submodule-update.sh                  | 2 ++
>  t/t7506-status-submodule.sh                  | 3 +++
>  t/t7508-status.sh                            | 3 +++
>  8 files changed, 18 insertions(+)
> 
> diff --git a/t/t3404-rebase-interactive.sh b/t/t3404-rebase-interactive.sh
> index 461dd539ff..9dc7d1aefb 100755
> --- a/t/t3404-rebase-interactive.sh
> +++ b/t/t3404-rebase-interactive.sh
> @@ -697,6 +697,7 @@ test_expect_success 'do "noop" when there is nothing to cherry-pick' '
>  '
>  
>  test_expect_success 'submodule rebase setup' '
> +	GIT_TEST_FSMONITOR="" &&

This disables GIT_TEST_FSMONITOR for the remainder of the test script,
but there are still a lot of non-submodule-specific tests to run.

>  	git checkout A &&
>  	mkdir sub &&
>  	(
> diff --git a/t/t3600-rm.sh b/t/t3600-rm.sh
> index 66282a720e..64269bd89d 100755
> --- a/t/t3600-rm.sh
> +++ b/t/t3600-rm.sh
> @@ -355,6 +355,7 @@ test_expect_success 'rm succeeds when given a directory with a trailing /' '
>  '
>  
>  test_expect_success 'rm of a populated submodule with different HEAD fails unless forced' '
> +	GIT_TEST_FSMONITOR="" &&

Likewise.

>  	git reset --hard &&
>  	git submodule update &&
>  	git -C submod checkout HEAD^ &&
> diff --git a/t/t4060-diff-submodule-option-diff-format.sh b/t/t4060-diff-submodule-option-diff-format.sh
> index 9dcb69df5c..017417790e 100755
> --- a/t/t4060-diff-submodule-option-diff-format.sh
> +++ b/t/t4060-diff-submodule-option-diff-format.sh
> @@ -15,6 +15,9 @@ This test tries to verify the sanity of --submodule=diff option of git diff.
>  # Tested non-UTF-8 encoding
>  test_encoding="ISO8859-1"
>  
> +# fsmonitor does not work well with submodules
> +GIT_TEST_FSMONITOR=""
> +
>  # String "added" in German (translated with Google Translate), encoded in UTF-8,
>  # used in sample commit log messages in add_file() function below.
>  added=$(printf "hinzugef\303\274gt")
> diff --git a/t/t5526-fetch-submodules.sh b/t/t5526-fetch-submodules.sh
> index 63205dfdf9..fb346bff05 100755
> --- a/t/t5526-fetch-submodules.sh
> +++ b/t/t5526-fetch-submodules.sh
> @@ -1,6 +1,8 @@
>  #!/bin/sh
>  # Copyright (c) 2010, Jens Lehmann
>  
> +GIT_TEST_FSMONITOR=""
> +
>  test_description='Recursive "git fetch" for submodules'
>  
>  . ./test-lib.sh
> diff --git a/t/t7402-submodule-rebase.sh b/t/t7402-submodule-rebase.sh
> index 8e32f19007..c78e9009cf 100755
> --- a/t/t7402-submodule-rebase.sh
> +++ b/t/t7402-submodule-rebase.sh
> @@ -7,6 +7,9 @@ test_description='Test rebasing, stashing, etc. with submodules'
>  
>  . ./test-lib.sh
>  
> +# fsmonitor does not work well with submodules
> +GIT_TEST_FSMONITOR=""
> +
>  test_expect_success setup '
>  
>  	echo file > file &&
> diff --git a/t/t7406-submodule-update.sh b/t/t7406-submodule-update.sh
> index c973278300..8d93aaef5f 100755
> --- a/t/t7406-submodule-update.sh
> +++ b/t/t7406-submodule-update.sh
> @@ -11,6 +11,8 @@ submodule and "git submodule update --rebase/--merge" does not detach the HEAD.
>  
>  . ./test-lib.sh
>  
> +# fsmonitor does not work well with submodules
> +GIT_TEST_FSMONITOR=""
>  
>  compare_head()
>  {
> diff --git a/t/t7506-status-submodule.sh b/t/t7506-status-submodule.sh
> index 08629a6e70..1a716f2c2a 100755
> --- a/t/t7506-status-submodule.sh
> +++ b/t/t7506-status-submodule.sh
> @@ -4,6 +4,9 @@ test_description='git status for submodule'
>  
>  . ./test-lib.sh
>  
> +# fsmonitor does not work well with submodules
> +GIT_TEST_FSMONITOR=""
> +
>  test_create_repo_with_commit () {
>  	test_create_repo "$1" &&
>  	(
> diff --git a/t/t7508-status.sh b/t/t7508-status.sh
> index 4e676cdce8..bf0487632d 100755
> --- a/t/t7508-status.sh
> +++ b/t/t7508-status.sh
> @@ -846,6 +846,9 @@ test_expect_success 'status refreshes the index' '
>  	test_cmp expect output
>  '
>  
> +# fsmonitor does not work well with submodules
> +GIT_TEST_FSMONITOR=""
> +

Likewise.

>  test_expect_success 'setup status submodule summary' '
>  	test_create_repo sm && (
>  		cd sm &&
> -- 
> gitgitgadget
> 
