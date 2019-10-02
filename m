Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 12BCD1F4BD
	for <e@80x24.org>; Wed,  2 Oct 2019 20:06:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726478AbfJBUGe (ORCPT <rfc822;e@80x24.org>);
        Wed, 2 Oct 2019 16:06:34 -0400
Received: from pb-smtp20.pobox.com ([173.228.157.52]:52777 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726069AbfJBUGd (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 2 Oct 2019 16:06:33 -0400
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id CFC66892CF;
        Wed,  2 Oct 2019 16:06:31 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=vNPzR3Psy+M2JYAnAAkFfmJW2QE=; b=QJPY/K
        2s+rdEVgyi/MtY/XsxWMuRT15P4I3HE56X51joEOKCdM3iUrJGfIXdrZS79+Eo0n
        1Vmui6m0YhGPDPRA/M/FcO2i7Em0P55wSySxmgP6yho0wXXG8ymPLYvjYKmu/qoA
        uF8cz1E+ZfHbiP/mnGcAL8eQniMmeL+K9uMdY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=M/ijQ70KAeVNf0/CSm3EJzRtYyVvAwkV
        UYFBJa+hDsTIT/8AJXAMRqHuJ5ci7zJLV+CqgwDpTc72luJDesTxWA6+oJ1FWcGM
        RAUk5Zi4gsyjWBLX41M+TTPFi+hArpKAeTBH3l3dl/rinWHj0yO/cPIJog/23OeP
        iC2qZ5cW/E4=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id C812D892CE;
        Wed,  2 Oct 2019 16:06:31 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 01568892CB;
        Wed,  2 Oct 2019 16:06:28 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH 1/1] range-diff: internally force `diff.noprefix=false`
References: <pull.373.git.gitgitgadget@gmail.com>
        <1f84f92846bc14d21aa7339c8baa0f9bb710b17d.1570039511.git.gitgitgadget@gmail.com>
Date:   Thu, 03 Oct 2019 05:06:26 +0900
In-Reply-To: <1f84f92846bc14d21aa7339c8baa0f9bb710b17d.1570039511.git.gitgitgadget@gmail.com>
        (Johannes Schindelin via GitGitGadget's message of "Wed, 02 Oct 2019
        11:05:13 -0700 (PDT)")
Message-ID: <xmqq4l0qewu5.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 1EE89754-E550-11E9-8711-B0405B776F7B-77302942!pb-smtp20.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
writes:

> From: Johannes Schindelin <johannes.schindelin@gmx.de>
>
> When parsing the diffs, `range-diff` expects to see the prefixes `a/`
> and `b/` in the diff headers.

If so, passing src/dst prefix as command line option is a much
better solution, I think.  diff.noprefix may not stay to be (or it
may already not to be) the only thing how the prefix gets chosen.

> -	argv_array_pushl(&cp.args, "log", "--no-color", "-p", "--no-merges",
> +	argv_array_pushl(&cp.args, "-c", "diff.noprefix=false",
> +			"log", "--no-color", "-p", "--no-merges",
>  			"--reverse", "--date-order", "--decorate=no",
>  			/*
>  			 * Choose indicators that are not used anywhere
> diff --git a/t/t3206-range-diff.sh b/t/t3206-range-diff.sh
> index 0120f769f1..64b66f2094 100755
> --- a/t/t3206-range-diff.sh
> +++ b/t/t3206-range-diff.sh
> @@ -461,4 +461,8 @@ test_expect_success 'format-patch --range-diff as commentary' '
>  	grep "> 1: .* new message" 0001-*
>  '
>  
> +test_expect_success 'range-diff overrides diff.noprefix internally' '
> +	git -c diff.noprefix=true range-diff HEAD^...
> +'
> +
>  test_done
