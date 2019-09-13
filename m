Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2ED4C1F463
	for <e@80x24.org>; Fri, 13 Sep 2019 18:54:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729758AbfIMSy5 (ORCPT <rfc822;e@80x24.org>);
        Fri, 13 Sep 2019 14:54:57 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:54887 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726822AbfIMSy5 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 13 Sep 2019 14:54:57 -0400
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id D80F92DEDD;
        Fri, 13 Sep 2019 14:54:54 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=FEkYu7s3WX7wzbamBBxf/5RMIUc=; b=tZ3Oou
        dOsnrdotsOEWpLkCjxqYm+SXQ4DJT8simNzPv18Q5m/bwGfn3zaAHoL1DlRI/ULt
        U6GgwbdaW1l4r1uvDeOohCU6YVw6x5CJE+jSzQBFzsI1yexUdyaPz1wzUvYZ+kKL
        xNBcn95U3o/9DZl2eany3KwYTr/EO49xlaSiE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=rBzErK2DQA649zzlzx77yBoZJCj1F2Yg
        r8SyM0LDAuwLYB2nt7JrnqjcAJ0dYkAHY8zEY5U1w6CY4YzqIaV2R6y2kJscAmY0
        CHwBXOytu4lzz2LWJHBweQIeNAFQdq9fjCL0gD8hY6L/hjmSf5pNRYyFQdofm+Ju
        u9d3/CyWR5s=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id CEE502DEDC;
        Fri, 13 Sep 2019 14:54:54 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 1FB012DEDB;
        Fri, 13 Sep 2019 14:54:54 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Elijah Newren <newren@gmail.com>
Cc:     git@vger.kernel.org, Jeff King <peff@peff.net>,
        Rafael =?utf-8?Q?Asc?= =?utf-8?Q?ens=C3=A3o?= 
        <rafa.almas@gmail.com>,
        SZEDER =?utf-8?Q?G=C3=A1b?= =?utf-8?Q?or?= 
        <szeder.dev@gmail.com>, Samuel Lijin <sxlijin@gmail.com>
Subject: Re: [PATCH v3 01/12] t7300: add testcases showing failure to clean specified pathspecs
References: <20190905154735.29784-1-newren@gmail.com>
        <20190912221240.18057-1-newren@gmail.com>
        <20190912221240.18057-2-newren@gmail.com>
Date:   Fri, 13 Sep 2019 11:54:52 -0700
In-Reply-To: <20190912221240.18057-2-newren@gmail.com> (Elijah Newren's
        message of "Thu, 12 Sep 2019 15:12:29 -0700")
Message-ID: <xmqqblvodo1v.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: F91DF976-D657-11E9-955B-D1361DBA3BAF-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Elijah Newren <newren@gmail.com> writes:

> +test_expect_failure 'git clean handles being told what to clean' '
> +	mkdir -p d1 d2 &&
> +	touch d1/ut d2/ut &&
> +	git clean -f */ut &&
> +	test_path_is_missing d1/ut &&
> +	test_path_is_missing d2/ut
> +'

Looks like d1 and d2 are new directories and the paths we see in the
test are the only ones that are involved (i.e. we do not rely on any
leftover cruft in d[12]/ from previous tests).  If so, perhaps it is
easier to follow by starting the tests with "rm -fr d1 d2 &&" or
something to assure the readers of the script (not this patch, but
the resulting file down the road) about the isolation?  The same
comment applies to the remainder.

Also, you talked about tracked paths in the proposed log message; do
they not participate in reproducing the issue(s)?

Thanks.


> +test_expect_failure 'git clean handles being told what to clean, with -d' '
> +	mkdir -p d1 d2 &&
> +	touch d1/ut d2/ut &&
> +	git clean -ffd */ut &&
> +	test_path_is_missing d1/ut &&
> +	test_path_is_missing d2/ut
> +'
> +
> +test_expect_failure 'git clean works if a glob is passed without -d' '
> +	mkdir -p d1 d2 &&
> +	touch d1/ut d2/ut &&
> +	git clean -f "*ut" &&
> +	test_path_is_missing d1/ut &&
> +	test_path_is_missing d2/ut
> +'
> +
> +test_expect_failure 'git clean works if a glob is passed with -d' '
> +	mkdir -p d1 d2 &&
> +	touch d1/ut d2/ut &&
> +	git clean -ffd "*ut" &&
> +	test_path_is_missing d1/ut &&
> +	test_path_is_missing d2/ut
> +'
> +
>  test_expect_success MINGW 'handle clean & core.longpaths = false nicely' '
>  	test_config core.longpaths false &&
>  	a50=aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa &&
