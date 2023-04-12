Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A557C7619A
	for <git@archiver.kernel.org>; Wed, 12 Apr 2023 21:33:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229503AbjDLVdq (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 12 Apr 2023 17:33:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34158 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229492AbjDLVdp (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 12 Apr 2023 17:33:45 -0400
Received: from mail-yw1-x112c.google.com (mail-yw1-x112c.google.com [IPv6:2607:f8b0:4864:20::112c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A51F9E
        for <git@vger.kernel.org>; Wed, 12 Apr 2023 14:33:41 -0700 (PDT)
Received: by mail-yw1-x112c.google.com with SMTP id 00721157ae682-54f21cdfadbso194063277b3.7
        for <git@vger.kernel.org>; Wed, 12 Apr 2023 14:33:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20221208.gappssmtp.com; s=20221208; t=1681335220; x=1683927220;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Ios/QaPzaXLp+dqcyVm1kwYiy154lEbrdc5zq2CQU58=;
        b=k8b/wyoY4xkQNAcn9/DD4Tom0kpgZEMkQLk/5ubFPY+e5vtWWgN8H0h8xQLbBilJ5j
         OnpLq2HgHJEYmT536+Vz6fftGen7k5undl8RLkJWUSfFxvp+OQnrKuvbu0n6WPxI7ZW4
         S/8My8xA/fkR3Wjqfj19Gpg4AG2zuT2E1EPq+acsO0kIQWOJu18bZMSZcX4WcOCn/vp9
         nlxpFuv1ie4UXMANmM4o6OCWuNDUVRZVz7P91yHvVeg+5/OlvwZJJ+w6MKTpuJDo7873
         N7K0UVE0lIgOY4hwFKGv38qQieT8eAFYbJ7Gtfg48LU8qFeDJ+8PnaGrm7kttXQpFDnF
         MbPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681335220; x=1683927220;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ios/QaPzaXLp+dqcyVm1kwYiy154lEbrdc5zq2CQU58=;
        b=V+gx/QjXaQ3sQsFMViWS7kuhP0hNTXIGA4jFmznMjscoNAjD4QoBjfpZ5TCE692IqU
         n7/OkHhFTXmtBaT85olGIwlENP2LMcpSTAE37JntiMRLxE4yuVRWv8UtQX5b52kPiTCX
         fGG3rItjD0aIWkVMpr/BapFw5pC/bszNZ15rpWSxR9VlbXVQo5auoV7iftL9RgRmLt3J
         hMJub1ij4kxRVg+QQkiww9oXhEpYDDzDx9NQHhXHIeS4vQ8RTh3qTGESv9AUv07sG6eQ
         Cuj4M5kpVAjEsBapF2NLOSLxfnfRtyCCwbZH3SPQLxX+kqubOrDeQIxnbyYlnO8J8VWE
         Yatw==
X-Gm-Message-State: AAQBX9cm6xPmR3QoF8yXmTXBOpXzHmh0C0dFwpQGsLYg1OJkl4Eji55b
        +9ZOnZCjdWyQrojDRykPAAwYz1E3qwoPokkJ1jITDQ==
X-Google-Smtp-Source: AKy350bS1KplLvkSIcagCt7xslRGSAwvUhvfrbrKRV83thvC5s3aW9TZDIY/j7PtTJK97YEDZibXSA==
X-Received: by 2002:a0d:dc04:0:b0:54e:e9f9:83f with SMTP id f4-20020a0ddc04000000b0054ee9f9083fmr3237158ywe.38.1681335220233;
        Wed, 12 Apr 2023 14:33:40 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id bp7-20020a05690c068700b00545a08184b0sm4425240ywb.64.2023.04.12.14.33.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Apr 2023 14:33:39 -0700 (PDT)
Date:   Wed, 12 Apr 2023 17:33:38 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     Patrick Steinhardt <ps@pks.im>
Cc:     git@vger.kernel.org, peff@peff.net, dstolee@microsoft.com
Subject: Re: [PATCH v2 4/8] pack-objects: fix error when packing same pack
 twice
Message-ID: <ZDcjshQeoQ7e8TbB@nand.local>
References: <a07ed50feeec4bfc3e9736bf493b9876896bcdd2.1680606445.git.ps@pks.im>
 <cover.1681294715.git.ps@pks.im>
 <e7d30fd22c65b33defb944bd043a56d0c525f875.1681294715.git.ps@pks.im>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <e7d30fd22c65b33defb944bd043a56d0c525f875.1681294715.git.ps@pks.im>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Apr 12, 2023 at 12:22:44PM +0200, Patrick Steinhardt wrote:
> When passed the same packfile twice via `--stdin-packs` we return an
> error that the packfile supposedly was not found. This is because when
> reading packs into the list of included or excluded packfiles, we will
> happily re-add packfiles even if they are part of the lists already. And
> while the list can now contain duplicates, we will only set the `util`
> pointer of the first list entry to the `packed_git` structure. We notice
> that at a later point when checking that all list entries have their
> `util` pointer set and die with an error.

Well explained.

> Signed-off-by: Patrick Steinhardt <ps@pks.im>
> ---
>  builtin/pack-objects.c        |  2 ++
>  t/t5331-pack-objects-stdin.sh | 29 +++++++++++++++++++++++++++++
>  t/t7703-repack-geometric.sh   | 25 +++++++++++++++++++++++++
>  3 files changed, 56 insertions(+)
>  create mode 100755 t/t5331-pack-objects-stdin.sh
>
> diff --git a/builtin/pack-objects.c b/builtin/pack-objects.c
> index 77d88f85b0..fdf3f440be 100644
> --- a/builtin/pack-objects.c
> +++ b/builtin/pack-objects.c
> @@ -3359,7 +3359,9 @@ static void read_packs_list_from_stdin(void)
>  	}
>
>  	string_list_sort(&include_packs);
> +	string_list_remove_duplicates(&include_packs, 0);
>  	string_list_sort(&exclude_packs);
> +	string_list_remove_duplicates(&exclude_packs, 0);

I for some reason thought that string_list_remove_duplicates() sorted
its first argument as a side-effect, but double checking on it, that
isn't the case. So I agree that calling string_list_remove_duplicates()
is the right thing to do here.

> diff --git a/t/t5331-pack-objects-stdin.sh b/t/t5331-pack-objects-stdin.sh
> new file mode 100755
> index 0000000000..ab34cfc729
> --- /dev/null
> +++ b/t/t5331-pack-objects-stdin.sh

Cool, I am glad that we are moving some of these tests out of t5300. We
could probably go a little bit further, since there are a handful of
purely `--stdin-packs`-related tests towards the bottom of that script
that could or should also be moved out.

We could also always do it later, but I wouldn't be sad to see an extra
commit before this one that introduces t5331 and moves the last six or
so `--stdin-packs` tests out of t5300. If nothing else, it would be
nice to be able to run the tests for just that feature without having to
skip a bunch of other unrelated tests.

Luckily, those tests don't depend on any of the earlier ones or setup
tests, so they should be able to move with a pure cut and paste.

> @@ -0,0 +1,29 @@
> +#!/bin/sh
> +
> +test_description='pack-objects --stdin'
> +GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
> +export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
> +
> +TEST_PASSES_SANITIZE_LEAK=true
> +. ./test-lib.sh
> +
> +test_expect_success 'pack-objects --stdin with duplicate packfile' '
> +	test_when_finished "rm -fr repo" &&
> +
> +	git init repo &&
> +	(
> +		cd repo &&
> +		test_commit "commit" &&
> +		git repack -ad &&
> +
> +		(
> +			basename .git/objects/pack/pack-*.pack &&
> +			basename .git/objects/pack/pack-*.pack
> +		) >packfiles &&
> +
> +		git pack-objects --stdin-packs generated-pack <packfiles &&
> +		test_cmp generated-pack-*.pack .git/objects/pack/pack-*.pack

I think that in practice that test_cmp'ing these two together will be
just fine, but if you wanted to be extra careful, you could grab their
object lists and compare those two together. That would allow you to
continue passing this test without needing to worry about if you
generated the same logical content with slightly different on-disk
content.

Thanks,
Taylor
