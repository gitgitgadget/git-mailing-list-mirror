Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A12EB1F731
	for <e@80x24.org>; Fri,  9 Aug 2019 17:54:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2407143AbfHIRyZ (ORCPT <rfc822;e@80x24.org>);
        Fri, 9 Aug 2019 13:54:25 -0400
Received: from pb-smtp21.pobox.com ([173.228.157.53]:60812 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726574AbfHIRyZ (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 9 Aug 2019 13:54:25 -0400
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 5A39D8B3FB;
        Fri,  9 Aug 2019 13:54:23 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=l2YB+svOCIO4c/4g87wiTRYU3uM=; b=k+axSq
        aX2lwykM/EqF/QWBTUIHcl/mTn/XXOhIIgYs3MAjasBFXFs54Njyu5Rdok6QE8kx
        XdlqYD+D5inH0VkOiLanSukDeTaMCOj1LLBd2BS0Sv4VsmeK62Ylm588jhvSo6nN
        B8g/kIc2XKB2H5+Ys/I61Xw+uk1Fc0umoJrmw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=fae9gFtUGNTl17hoK12DeqVqJ7NYVa8m
        s/5QCZbAyOIQ9x13B8ehsryrDh5mArU2xlcI1o/ZZYIf3hBJmTCWP0POFmbh9sjl
        aXVov9759aYHnaeb3uWXonQ8kuzPnt/7VkI+G5EP4NoaKz7T540FjVo1z7/vB6Qg
        JX9zZfFIID0=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 527CE8B3FA;
        Fri,  9 Aug 2019 13:54:23 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 813008B3F9;
        Fri,  9 Aug 2019 13:54:20 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Jeff Hostetler via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Jeff Hostetler <jeffhost@microsoft.com>
Subject: Re: [PATCH v3 5/7] quote: add sq_append_quote_argv_pretty()
References: <pull.298.v2.git.gitgitgadget@gmail.com>
        <pull.298.v3.git.gitgitgadget@gmail.com>
        <2002108a30246824f8017da1dea344c1a96f7de2.1565362851.git.gitgitgadget@gmail.com>
Date:   Fri, 09 Aug 2019 10:54:18 -0700
In-Reply-To: <2002108a30246824f8017da1dea344c1a96f7de2.1565362851.git.gitgitgadget@gmail.com>
        (Jeff Hostetler via GitGitGadget's message of "Fri, 09 Aug 2019
        08:00:55 -0700 (PDT)")
Message-ID: <xmqqtvaqcjhx.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: B6DC099E-BACE-11E9-831F-8D86F504CC47-77302942!pb-smtp21.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Jeff Hostetler via GitGitGadget" <gitgitgadget@gmail.com> writes:

> +/*
> + * Legacy function to append each argv value, quoted as necessasry,
> + * with whitespace before each value.  This results in a leading
> + * space in the result.
> + */
>  void sq_quote_argv_pretty(struct strbuf *dst, const char **argv)
> +{
> +	if (argv[0])
> +		strbuf_addch(dst, ' ');
> +	sq_append_quote_argv_pretty(dst, argv);

Micronit (not worth a reroll): if !argv[0], there is no need to call
append, either.
