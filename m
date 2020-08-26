Return-Path: <SRS0=bNai=CE=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E22CC433DF
	for <git@archiver.kernel.org>; Wed, 26 Aug 2020 21:41:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 131342087D
	for <git@archiver.kernel.org>; Wed, 26 Aug 2020 21:41:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="H+GWM6Bt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726784AbgHZVl2 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 26 Aug 2020 17:41:28 -0400
Received: from pb-smtp21.pobox.com ([173.228.157.53]:56251 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726753AbgHZVl0 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 26 Aug 2020 17:41:26 -0400
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 803F3EE661;
        Wed, 26 Aug 2020 17:41:24 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=6McVIHseaiAXCxDJAp1NwEz4wA8=; b=H+GWM6
        BtKU/eLNiwMPMVb+yg2P+32V2Wq0xSEAfqtvC9B2XujJaEcIGvEQ+Q3PYpuWHpm3
        yt2bcekEgLKf6uQr/Ay1F9gJ2nJdRiiOmiNkwFXrnEGQFwK6xU7Wx2yLVFcfrTGI
        QY0NTi5R+tcFPDcQE8Xfj5ZEslBn02n+GsZeA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=EO/cxtv6ylK6+QTogWRMOcgx+aTfqB85
        2Xaw1+TrfKBoWnpfJMuz7kuyd6tjysZfEEIJ43jp0Lj2u6BKI+8JVIhiZJ/ibbTw
        PRe3eLSu00cxx14uCvG1uoIRSLWOcpL6UIiU4abwW1PetNWPiaZpt84S3vH70j0+
        fDjiT3Qsz5o=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 7A86CEE65E;
        Wed, 26 Aug 2020 17:41:24 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.75.7.245])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 6303EEE61A;
        Wed, 26 Aug 2020 17:41:21 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Phillip Wood <phillip.wood123@gmail.com>
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Elijah Newren <newren@gmail.com>,
        Rohit Ashiwal <rohit.ashiwal265@gmail.com>,
        =?utf-8?B?xJBvw6BuIFRy4bqnbiBDw7RuZw==?= Danh 
        <congdanhqx@gmail.com>, Alban Gruin <alban.gruin@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Phillip Wood <phillip.wood@dunelm.org.uk>
Subject: Re: [PATCH v8 3/5] rebase -i: support --committer-date-is-author-date
References: <20200407141125.30872-1-phillip.wood123@gmail.com>
        <20200817174004.92455-1-phillip.wood123@gmail.com>
        <20200817174004.92455-4-phillip.wood123@gmail.com>
Date:   Wed, 26 Aug 2020 14:41:19 -0700
In-Reply-To: <20200817174004.92455-4-phillip.wood123@gmail.com> (Phillip
        Wood's message of "Mon, 17 Aug 2020 18:40:02 +0100")
Message-ID: <xmqqv9h5t79c.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: E1BFC2EC-E7E4-11EA-B2D3-843F439F7C89-77302942!pb-smtp21.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Phillip Wood <phillip.wood123@gmail.com> writes:

> diff --git a/t/t3436-rebase-more-options.sh b/t/t3436-rebase-more-options.sh
> index 4f8a6e51c9..50a63d8ebe 100755
> --- a/t/t3436-rebase-more-options.sh
> +++ b/t/t3436-rebase-more-options.sh
> @@ -9,6 +9,9 @@ test_description='tests to ensure compatibility between am and interactive backe
>  
>  . "$TEST_DIRECTORY"/lib-rebase.sh
>  
> +GIT_AUTHOR_DATE="1999-04-02T08:03:20+05:30"
> +export GIT_AUTHOR_DATE
> +
>  # This is a special case in which both am and interactive backends
>  # provide the same output. It was done intentionally because
>  # both the backends fall short of optimal behaviour.
> @@ -21,11 +24,20 @@ test_expect_success 'setup' '
>  	test_write_lines "line 1" "new line 2" "line 3" >file &&
>  	git commit -am "update file" &&
> + ...
> +	mkdir test-bin &&
> +	write_script test-bin/git-merge-test <<-\EOF
> +	exec git-merge-recursive "$@"

This should be

	exec git merge-recursive "$@"

> +	EOF
>  '
