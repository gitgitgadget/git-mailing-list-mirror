Return-Path: <SRS0=PlGQ=4G=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58FA9C34031
	for <git@archiver.kernel.org>; Tue, 18 Feb 2020 21:11:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 15DAF2176D
	for <git@archiver.kernel.org>; Tue, 18 Feb 2020 21:11:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="aDDM+S5v"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727125AbgBRVLc (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 18 Feb 2020 16:11:32 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:51875 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726444AbgBRVLb (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 18 Feb 2020 16:11:31 -0500
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 90C193FFE6;
        Tue, 18 Feb 2020 16:11:30 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=8T4C+9Yja2ira5CTz7xUIJXF0GU=; b=aDDM+S
        5vomAMGZ/PpactE84LvcDmkThW9sf30nxYdrq11klEyQ2cGc7sVqo0+R/hapQmlT
        c1D72eHyFNkM6deGmpAdUZXIpvK8NyDrkiUYAVVaxalcpTfyjqGDG86/47gnCTts
        D8ZMz7Cuf0dWTMZW6ko8DEy9RBXxbN9hralyE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=DbCZdsH7y6QJIEQ1pChGTNxCk2ukZpx0
        g0BrJCzqbCI9//7Fb8YXHhvOfZRMsHbpN3HVtSRaYSf7gy9AX36sbMSGsgbW+L4u
        QbkRqdHkZ44sgZ1mY67PyCoSqKrbZhJeM7Ks3GsnHUAwoXJYoLRIsXxQUSddG9d5
        XkyqQ7VifU8=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 894553FFE4;
        Tue, 18 Feb 2020 16:11:30 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id EC4813FFE3;
        Tue, 18 Feb 2020 16:11:29 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Han-Wen Nienhuys via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Han-Wen Nienhuys <hanwenn@gmail.com>,
        Han-Wen Nienhuys <hanwen@google.com>
Subject: Re: [PATCH v6 4/5] Add reftable library
References: <pull.539.v5.git.1581344060.gitgitgadget@gmail.com>
        <pull.539.v6.git.1582015420.gitgitgadget@gmail.com>
        <fe29a9db39922e42929e47a12c816dcb92ba2204.1582015420.git.gitgitgadget@gmail.com>
Date:   Tue, 18 Feb 2020 13:11:28 -0800
In-Reply-To: <fe29a9db39922e42929e47a12c816dcb92ba2204.1582015420.git.gitgitgadget@gmail.com>
        (Han-Wen Nienhuys via GitGitGadget's message of "Tue, 18 Feb 2020
        08:43:39 +0000")
Message-ID: <xmqqtv3niosf.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 3B7B6C9C-5293-11EA-8626-C28CBED8090B-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Han-Wen Nienhuys via GitGitGadget" <gitgitgadget@gmail.com> writes:

> +void put_u64(byte *out, uint64_t v)
> +{
> +	int i = 0;
> +	for (i = sizeof(uint64_t); i--;) {
> +		out[i] = (byte)(v & 0xff);
> +		v >>= 8;
> +	}
> +}

This looks OK, but ...

> +int names_length(char **names)
> +{
> +	int len = 0;
> +	for (char **p = names; *p; p++) {
> +		len++;
> +	}

... this will break the build with some compiler options (see for
example https://travis-ci.org/git/git/jobs/651322628#L679).  You
may also want to lose {braces} around a single-statement block.

The incremental change between v5 and v6, especially the reflog
expiration bit, looked sensible.

Thanks.
