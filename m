Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 016E9C433E0
	for <git@archiver.kernel.org>; Sun, 27 Dec 2020 22:07:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BB362224DE
	for <git@archiver.kernel.org>; Sun, 27 Dec 2020 22:07:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726227AbgL0WHn (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 27 Dec 2020 17:07:43 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:54167 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726194AbgL0WHm (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 27 Dec 2020 17:07:42 -0500
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 01DEFA92AA;
        Sun, 27 Dec 2020 17:07:00 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=bueTQlDKsCJCZGefqmAet5ugJ3U=; b=Qhu+AJ
        l0yfbRUYbIjVU/pmdnFamnoPw4Hz37a1pe9Kx84u1CxzH6MS5MRtw9smOstwGRSn
        qwv/YkanipiiHRFcaGKRo1oNZMKXO7ao1Y3CShBNcrNG9wW/8Sv0uiuWIoz3HfQ+
        1Z0x/dgOCPJzqpXitvpr5Zk3zb6w4vvxjpvwk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=v3H1q14QDrkvQFcqV0x4r17fvioqIWA+
        WC9I9fSFprac27osf5qbupD/1oV5MZiUsoi8D7fS2/lSP86bJVDyrQHyUw1BflEV
        P042Wd8zBH33Mc+aG0TJ6kCmPPMDkdsTW4B+lcjS/tjWJNOrRPaDayldGJUnQIw4
        +xB8t2UlZ8A=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id EEC27A92A9;
        Sun, 27 Dec 2020 17:06:59 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.196.173.25])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 7BF34A92A7;
        Sun, 27 Dec 2020 17:06:59 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Seth House <seth@eseth.com>
Cc:     git@vger.kernel.org, Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [PATCH v6 1/2] mergetool: add automerge configuration
References: <20201223045358.100754-1-felipe.contreras@gmail.com>
        <20201227205835.502556-1-seth@eseth.com>
        <20201227205835.502556-2-seth@eseth.com>
Date:   Sun, 27 Dec 2020 14:06:58 -0800
In-Reply-To: <20201227205835.502556-2-seth@eseth.com> (Seth House's message of
        "Sun, 27 Dec 2020 13:58:34 -0700")
Message-ID: <xmqq1rfarji5.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: D756F288-488F-11EB-8823-D152C8D8090B-77302942!pb-smtp1.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Seth House <seth@eseth.com> writes:

> ...
> See Seth House's blog post [1] for the idea, and the rationale.
>
> [1] https://www.eseth.org/2020/mergetools.html
>
> Original-idea-by: Seth House <seth@eseth.com>
> Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
> ---

Missing Sign-off as a relayer.

> diff --git a/t/t7610-mergetool.sh b/t/t7610-mergetool.sh
> index 70afdd06fa..b75c91199b 100755
> --- a/t/t7610-mergetool.sh
> +++ b/t/t7610-mergetool.sh
> @@ -828,4 +828,22 @@ test_expect_success 'mergetool -Oorder-file is honored' '
>  	test_cmp expect actual
>  '
>  
> +test_expect_success 'mergetool automerge' '
> +	test_config mergetool.automerge true &&
> +	test_when_finished "git reset --hard" &&
> +	git checkout -b test${test_count}_b master &&
> +	echo -e "base\n\na" >file1 &&

These do not seem to be taken from the version that has been
improved by reviwer comments after v3.

> +	git commit -a -m "base" &&
> +	echo -e "base\n\nc" >file1 &&
> +	git commit -a -m "remote update" &&
> +	git checkout -b test${test_count}_a HEAD~ &&
> +	echo -e "local\n\nb" >file1 &&
> +	git commit -a -m "local update" &&
> +	test_must_fail git merge test${test_count}_b &&
> +	yes "" | git mergetool file1 &&
> +	echo -e "local\n\nc" >expect &&
> +	test_cmp expect file1 &&
> +	git commit -m "test resolved with mergetool"
> +'
> +
>  test_done
