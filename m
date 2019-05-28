Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B2B281F462
	for <e@80x24.org>; Tue, 28 May 2019 18:25:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728070AbfE1SZ0 (ORCPT <rfc822;e@80x24.org>);
        Tue, 28 May 2019 14:25:26 -0400
Received: from pb-smtp20.pobox.com ([173.228.157.52]:63702 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726576AbfE1SZ0 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 28 May 2019 14:25:26 -0400
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 8316D6F0C7;
        Tue, 28 May 2019 14:25:24 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:message-id:mime-version:content-type;
         s=sasl; bh=gHVmYi+Mfvl/BiNvo3jRw7xBW8s=; b=WzPku/g23njiBFKuBkqd
        ALDDczaOW1A3/GPY5NHOX4wCULkp3/PV2wlRolMzq3wl20w30IhqEmfSrtTOhKAq
        TZ8xki+GBvppeBe/BPKRHzfMY8tj0NEp27j1fLIThFH2/2S8zFqaatJsBJ3ycMs6
        rpdSbbNvE3FqcLU/GdfQebw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:message-id:mime-version:content-type;
         q=dns; s=sasl; b=x47Z4tz5P1KB3VOH5zBhUD6NVZlE52oGfvqrqsPb55ktvU
        QLDRXzV9N1/zifkoMhqaskSR8pDRXBo0tzHCp4hYeBSH/1RnCv+wULeVLG1B2bLj
        JdXCL0dS++HggUtiuKRUL8Kz5pTH7NXSZ1Ity3Rf3NEzH3XEYIYfOeZWNfKig=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 7B85E6F0C6;
        Tue, 28 May 2019 14:25:24 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id A64326F0C5;
        Tue, 28 May 2019 14:25:21 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH 1/2] rebase: replace incorrect logical negation by correct bitwise one
References: <pull.221.git.gitgitgadget@gmail.com>
        <aa0acf4c5ff843a480afdb5715fa03186d82a6d1.1558461018.git.gitgitgadget@gmail.com>
Date:   Tue, 28 May 2019 11:25:19 -0700
Message-ID: <xmqq5zpu308g.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: F40A009C-8175-11E9-A680-B0405B776F7B-77302942!pb-smtp20.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
writes:

> From: Johannes Schindelin <johannes.schindelin@gmx.de>
>
> In bff014dac7d9 (builtin rebase: support the `verbose` and `diffstat`
> options, 2018-09-04), we added a line that wanted to remove the
> `REBASE_DIFFSTAT` bit from the flags, but it used an incorrect negation.
>
> Found by Coverity.
>
> Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
> ---
>  builtin/rebase.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/builtin/rebase.c b/builtin/rebase.c
> index ba3a574e40..db6ca9bd7d 100644
> --- a/builtin/rebase.c
> +++ b/builtin/rebase.c
> @@ -1203,7 +1203,7 @@ static int rebase_config(const char *var, const char *value, void *data)
>  		if (git_config_bool(var, value))
>  			opts->flags |= REBASE_DIFFSTAT;
>  		else
> -			opts->flags &= !REBASE_DIFFSTAT;
> +			opts->flags &= ~REBASE_DIFFSTAT;
>  		return 0;
>  	}

Obviously correct.  Thanks.

At this point in the codeflow, the .flags field is not touched by
parse_options() yet, the configuration codepath only touches that
field for REBASE_DIFFSTAT, and because REBASE_DIFFSTAT is not 0,
"[rebase] stat = no", which would want only the REBASE_DIFFSTAT bit
cleared in the word, can afford to instead assign 0 to the whole
word without causing any damage, which is funny way for this bug to
be hidden for a long time...


