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
	by smtp.lore.kernel.org (Postfix) with ESMTP id D040BC2D0C8
	for <git@archiver.kernel.org>; Tue, 10 Dec 2019 10:07:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 94E4F20828
	for <git@archiver.kernel.org>; Tue, 10 Dec 2019 10:07:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JUaD5tK6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727359AbfLJKHi (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 10 Dec 2019 05:07:38 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:42257 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727334AbfLJKHh (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 10 Dec 2019 05:07:37 -0500
Received: by mail-wr1-f68.google.com with SMTP id a15so19276175wrf.9
        for <git@vger.kernel.org>; Tue, 10 Dec 2019 02:07:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=idQvBZoLfPJA2Qu2M+TaoA+ANJJoMnus1c4jEKSDSHg=;
        b=JUaD5tK6pIsb4TGPmhQFFMTh8oxPXTk1k9VOABNHkhsuoxJ/3HfDCl4JgSzKXweUs2
         eQBaYz5Yxji0ezLLy4wrS8n3fGpqVW3XjuaU6xDhnfz6xiAApFGqJcUrinAU3FE0pTNy
         EZREWc/adHLp52xdDHCdp4gew/uLoRkoTwEv9CaBBrvxtwsT4+PrMND0OBtCOkeUSQsb
         ylqaODfrW0YT1W8W0sVScj9ZLywBCrPoLGj74OOf3vviiZSNzzNUZ8ftAKanmfbx4IFk
         rdSUZEpuI16Grbv9LEvb6w9mdZKCvnER203Isv4RlRb+Dob1F0VFBeXDPQ1s6BGy7kUd
         UYfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=idQvBZoLfPJA2Qu2M+TaoA+ANJJoMnus1c4jEKSDSHg=;
        b=FzWD+GASEcfw4sDaDrf/W9FGPvm2Xfq73ITS5L2GXzIEW4x893PuuBjraz8m9VnfZ/
         OzFTDOsXbie4RbgR8af9HerdA34PBL8DdJHyz9IKqqfGH/WPN0yxGqN6cIDCda4inTF+
         EjAtcAu7SY1Pt7Cc/AeuCjulZVD3rBjeN/aA77ztti7yh9GrlnzyXolW3NWQlD6jBph1
         cdTYVJgyji8uOcU5GKhWFPD1Z5WAM7ICxDdJhJOHyQqL22x+N/x0asyVxYi6tymB2dj/
         SQ21daxAzbFZdWHNpWOT9QPFHgTDeYLtowEsjOxUYB3BBNq6UWQ/VBZWFUijAJ4G3ZS+
         yhSw==
X-Gm-Message-State: APjAAAV5Fxg0o5yWgZ+88Ifs4SljR0UBhWAqmEb9qHk21+4Z34G764zY
        HRbF6W8/gsmrFXRtLffvwZU=
X-Google-Smtp-Source: APXvYqx9x46QEU1ODWyfv08W4iCRMjEstt6UrMDpkSeVzCDyu1myCxL4/DExIOMIaDZOH1Be8Ou2uw==
X-Received: by 2002:adf:9104:: with SMTP id j4mr2216241wrj.221.1575972455684;
        Tue, 10 Dec 2019 02:07:35 -0800 (PST)
Received: from szeder.dev (x4db55d5d.dyn.telefonica.de. [77.181.93.93])
        by smtp.gmail.com with ESMTPSA id a3sm2670333wmh.5.2019.12.10.02.07.33
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 10 Dec 2019 02:07:34 -0800 (PST)
Date:   Tue, 10 Dec 2019 11:07:32 +0100
From:   SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
To:     Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, ukshah2@illinois.edu,
        Kevin.Willford@microsoft.com,
        Derrick Stolee <dstolee@microsoft.com>,
        Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 4/8] t3030-merge-recursive.sh: disable fsmonitor when
 tweaking GIT_WORK_TREE
Message-ID: <20191210100732.GD6527@szeder.dev>
References: <pull.466.git.1574374826.gitgitgadget@gmail.com>
 <pull.466.v2.git.1575907804.gitgitgadget@gmail.com>
 <efc16962ee2595db50bf051fc84632b8c70036b3.1575907804.git.gitgitgadget@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <efc16962ee2595db50bf051fc84632b8c70036b3.1575907804.git.gitgitgadget@gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Dec 09, 2019 at 04:10:00PM +0000, Derrick Stolee via GitGitGadget wrote:
> From: Derrick Stolee <dstolee@microsoft.com>
> 
> The fsmonitor feature allows an external tool such as watchman to
> monitor the working directory. The direct test
> t7619-status-fsmonitor.sh provides some coverage, but it would be
> better to run the entire test suite with watchman enabled. This
> would provide more confidence that the feature is working as
> intended.
> 
> Worktrees use a ".git" _file_ instead of a folder to point to
> the base repo's .git directory and the proper worktree HEAD. The
> fsmonitor hook tries to create a JSON file inside the ".git" folder
> which violates the expectation here.

Yeah, there are a couple hardcoded paths in there, e.g.:

  open ($fh, ">", ".git/watchman-response.json");

and, worse, not only in the test helper hook in
't/t7519/fsmonitor-watchman' but in the sample hook template
'templates/hooks--fsmonitor-watchman.sample' as well.

> It would be better to properly
> find a safe folder for storing this JSON file.

  git rev-parse --git-path ''

gives us the right directory prefix to use and we could then append
the various filenames that must be accessed in there.

> This is also a problem when a test script uses GIT_WORK_TREE.
> 
> Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
> ---
>  t/t1510-repo-setup.sh      | 1 +
>  t/t2400-worktree-add.sh    | 2 ++
>  t/t3030-merge-recursive.sh | 2 ++
>  3 files changed, 5 insertions(+)
> 
> diff --git a/t/t1510-repo-setup.sh b/t/t1510-repo-setup.sh
> index 9974457f56..28dce0c26f 100755
> --- a/t/t1510-repo-setup.sh
> +++ b/t/t1510-repo-setup.sh
> @@ -775,6 +775,7 @@ test_expect_success '#29: setup' '
>  	setup_repo 29 non-existent gitfile true &&
>  	mkdir -p 29/sub/sub 29/wt/sub &&
>  	(
> +		GIT_TEST_FSMONITOR="" &&
>  		cd 29 &&
>  		GIT_WORK_TREE="$here/29" &&
>  		export GIT_WORK_TREE &&
> diff --git a/t/t2400-worktree-add.sh b/t/t2400-worktree-add.sh
> index e819ba741e..d4d3cbae0f 100755
> --- a/t/t2400-worktree-add.sh
> +++ b/t/t2400-worktree-add.sh
> @@ -1,5 +1,7 @@
>  #!/bin/sh
>  
> +GIT_TEST_FSMONITOR=""
> +
>  test_description='test git worktree add'
>  
>  . ./test-lib.sh
> diff --git a/t/t3030-merge-recursive.sh b/t/t3030-merge-recursive.sh
> index ff641b348a..62f645d639 100755
> --- a/t/t3030-merge-recursive.sh
> +++ b/t/t3030-merge-recursive.sh
> @@ -520,6 +520,7 @@ test_expect_success 'reset and bind merge' '
>  
>  test_expect_success 'merge-recursive w/ empty work tree - ours has rename' '
>  	(
> +		GIT_TEST_FSMONITOR="" &&
>  		GIT_WORK_TREE="$PWD/ours-has-rename-work" &&
>  		export GIT_WORK_TREE &&
>  		GIT_INDEX_FILE="$PWD/ours-has-rename-index" &&
> @@ -545,6 +546,7 @@ test_expect_success 'merge-recursive w/ empty work tree - ours has rename' '
>  
>  test_expect_success 'merge-recursive w/ empty work tree - theirs has rename' '
>  	(
> +		GIT_TEST_FSMONITOR="" &&
>  		GIT_WORK_TREE="$PWD/theirs-has-rename-work" &&
>  		export GIT_WORK_TREE &&
>  		GIT_INDEX_FILE="$PWD/theirs-has-rename-index" &&
> -- 
> gitgitgadget
> 
