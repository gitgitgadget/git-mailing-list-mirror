Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0BD3AC2BA4C
	for <git@archiver.kernel.org>; Wed, 26 Jan 2022 17:59:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232655AbiAZR7b (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 26 Jan 2022 12:59:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52228 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230002AbiAZR7a (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 26 Jan 2022 12:59:30 -0500
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E467C06161C
        for <git@vger.kernel.org>; Wed, 26 Jan 2022 09:59:30 -0800 (PST)
Received: by mail-ej1-x62d.google.com with SMTP id p15so214364ejc.7
        for <git@vger.kernel.org>; Wed, 26 Jan 2022 09:59:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version;
        bh=wC+2kut984UDiOGyFbaf6g0OnfLGImLnZH5LpHtIphw=;
        b=cVqfArVTHQ3Vu3dSTpw4WvJwbMCH0wSBztwZMVRA35IQrMVWeJq4PQ5J5h9epkja+r
         eLLWvjuHMffWrhqIx/qeR1QqCVD69mB6DQCxDQXPJgUJZDPWyVwvZDoKZ9m8EmdD1Z+S
         AiCYWtUAVa7r8YIk5+ArXuGbeSdm3osgerBuRSAxqrCJKPlnMdvqss6CYgZK7dMFltsC
         rV9VuKUAaaZD2izGVmlCKMloNFlzX7vujQHLSKeQdSTRJTFJRtNJj3xfOteIfaVJY2Pm
         HespqxC8alooptc2RzyR2fXrVaO1QgyNvRZV/RLIaGpkGCILMyNjKBogjqH0y6vOOBrm
         dRrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version;
        bh=wC+2kut984UDiOGyFbaf6g0OnfLGImLnZH5LpHtIphw=;
        b=5Wv7ZG03NbHyTBnV6O1WGaphjVm14vpZk3AR9N06T9Sozfye+uhR5YwIowZfUloL8H
         jCf8CG8UxW2r3uQsFPAiSrbrLeCgzaCVEbHKKAv2+YXdo96O3na4A1n7tkuSj80L5Itg
         23YSAVKqZaKH0JTS+Ga4pVu9Lj7g8cxg8nBSs2cP3sV85rjYlByEaue/kg2KHGKj8Jdn
         8Hm49qNn8xRwxWXIiPQ809ykrqqm3rA8btM/6IstByrmhmudpChb/dQjPjaC9+FbGm+i
         6R4VIo2uTMPWnaAEciH2fPutE+k8o52KU6w+6+2a8S7fMGqRujsDNs6wdTIPiVzxf5C+
         POGA==
X-Gm-Message-State: AOAM531kidx1qSx007Dao8lC8nLPmc1cBSSeV5invtwMXGAjbwpiYcgA
        jdscK4f/3lLyOzzW+p1hXEI=
X-Google-Smtp-Source: ABdhPJwItMXOH0vOvbsngwB9otcvZ3x6GCkviZVpgShdriuo4UMhgzdrDWKidB+d/W9eze1/5Z1FyQ==
X-Received: by 2002:a17:907:c1e:: with SMTP id ga30mr13455118ejc.676.1643219968821;
        Wed, 26 Jan 2022 09:59:28 -0800 (PST)
Received: from gmgdl (j120189.upc-j.chello.nl. [24.132.120.189])
        by smtp.gmail.com with ESMTPSA id by22sm7740522ejb.5.2022.01.26.09.59.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Jan 2022 09:59:28 -0800 (PST)
Received: from avar by gmgdl with local (Exim 4.95)
        (envelope-from <avarab@gmail.com>)
        id 1nCmZr-003CZB-Tg;
        Wed, 26 Jan 2022 18:59:27 +0100
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH 2/2] diff-filter: be more careful when looking for
 negative bits
Date:   Wed, 26 Jan 2022 18:57:51 +0100
References: <pull.1127.git.1643149759.gitgitgadget@gmail.com>
 <e8006493a9ed4da9b9125865e004ba7ace20e7a4.1643149759.git.gitgitgadget@gmail.com>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.6.10
In-reply-to: <e8006493a9ed4da9b9125865e004ba7ace20e7a4.1643149759.git.gitgitgadget@gmail.com>
Message-ID: <220126.868rv2e5ts.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Tue, Jan 25 2022, Johannes Schindelin via GitGitGadget wrote:

> From: Johannes Schindelin <johannes.schindelin@gmx.de>
>
> The `--diff-filter=<bits>` option allows to filter the diff by certain
> criteria, for example `R` to only show renamed files. It also supports
> negating a filter via a down-cased letter, i.e. `r` to show _everything
> but_ renamed files.
>
> However, the code is a bit overzealous when trying to figure out whether
> `git diff` should start with all diff-filters turned on because the user
> provided a lower-case letter: if the `--diff-filter` argument starts
> with an upper-case letter, we must not start with all bits turned on.
>
> Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
> ---
>  diff.c         | 8 +++-----
>  t/t4202-log.sh | 8 ++++++++
>  2 files changed, 11 insertions(+), 5 deletions(-)
>
> diff --git a/diff.c b/diff.c
> index c862771a589..fc1151b9c73 100644
> --- a/diff.c
> +++ b/diff.c
> @@ -4821,17 +4821,15 @@ static int diff_opt_diff_filter(const struct option *option,
>  	prepare_filter_bits();
>  
>  	/*
> -	 * If there is a negation e.g. 'd' in the input, and we haven't
> +	 * If the input starts with a negation e.g. 'd', and we haven't
>  	 * initialized the filter field with another --diff-filter, start
>  	 * from full set of bits, except for AON.
>  	 */
>  	if (!opt->filter) {
> -		for (i = 0; (optch = optarg[i]) != '\0'; i++) {
> -			if (optch < 'a' || 'z' < optch)
> -				continue;
> +		optch = optarg[0];
> +		if (optch >= 'a' && 'z' >= optch) {

We'll probably never have to deal with non-ASCII, so maybe this is being
overzelous, but perhaps changing this to islower(optch) is worth it?

This relies on non-standard C both in the pre- and post-image, but in
reality it works everywhere, until someone attempts to port git to an
EBCDIC system...

>  			opt->filter = (1 << (ARRAY_SIZE(diff_status_letters) - 1)) - 1;
>  			opt->filter &= ~filter_bit[DIFF_STATUS_FILTER_AON];
> -			break;
>  		}
>  	}
>  
> diff --git a/t/t4202-log.sh b/t/t4202-log.sh
> index 50495598619..28f727937dd 100755
> --- a/t/t4202-log.sh
> +++ b/t/t4202-log.sh
> @@ -142,6 +142,14 @@ test_expect_success 'diff-filter=R' '
>  
>  '
>  
> +test_expect_success 'diff-filter=Ra' '
> +

nit: extra \n

> +	git log -M --pretty="format:%s" --diff-filter=R HEAD >expect &&
> +	git log -M --pretty="format:%s" --diff-filter=Ra HEAD >actual &&
> +	test_cmp expect actual
> +
> +'
> +
>  test_expect_success 'diff-filter=C' '
>  
>  	git log -C -C --pretty="format:%s" --diff-filter=C HEAD >actual &&

