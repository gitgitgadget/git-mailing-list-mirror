Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D14C12095B
	for <e@80x24.org>; Tue, 21 Mar 2017 22:34:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1757916AbdCUWeM (ORCPT <rfc822;e@80x24.org>);
        Tue, 21 Mar 2017 18:34:12 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:50535 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S933729AbdCUWdQ (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 21 Mar 2017 18:33:16 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 6F87A71ACC;
        Tue, 21 Mar 2017 18:28:06 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=dyrDafZ1b+6FbYzXf3Yu3SN5U5Q=; b=o7Hi5Q
        K5rk8RzM5unBcEORtyP27B3XHjyIkhs3x0Ew0f3mHAXLBAkWJKEQJSeJY+wGepKp
        TeVKvWdm9ZW49zb4egZgHlHmuCF2M4PN30zjItINX/Hf5l1MGwxOL/NSwI+cw8nK
        oTGtpK8AFttIkfW4O3e+ljcLo9AX73dPL+jMY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=lJD1rWtLB0hvj8xs6Ihl3rU3GkZg49AI
        +pqgJAhCtw4sFtWepTus3ZUv1Sm3QWKQU1Wx1K5WJx7Lq4ThtYaYJUijqJX7yQK9
        FId0h5KQePDCQe+dHuH99KAbuKLtzvEKMcYrGDVk+LPjc4O8NjF6cWFgRDbZgRBb
        Lwh9Lf1iG7c=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 68E9571ACB;
        Tue, 21 Mar 2017 18:28:06 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id D439471AC9;
        Tue, 21 Mar 2017 18:28:05 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Alex Henrie <alexhenrie24@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH] log: if --decorate is not given, default to --decorate=auto
References: <20170321055203.26488-1-alexhenrie24@gmail.com>
        <xmqqinn2sfdw.fsf@gitster.mtv.corp.google.com>
Date:   Tue, 21 Mar 2017 15:28:04 -0700
In-Reply-To: <xmqqinn2sfdw.fsf@gitster.mtv.corp.google.com> (Junio C. Hamano's
        message of "Tue, 21 Mar 2017 10:34:19 -0700")
Message-ID: <xmqqzigemfij.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1.91 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: A753D882-0E85-11E7-98C3-97B1B46B9B0B-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

>>  test_expect_success 'log.decorate configuration' '
>> -	git log --oneline >expect.none &&
>> +	git log --oneline --no-decorate >expect.none &&
>>  	git log --oneline --decorate >expect.short &&
>>  	git log --oneline --decorate=full >expect.full &&
>
> This ensures that an explicit --no-decorate from the command line
> does give "none" output, which we failed to do so far, and is a good
> change.  Don't we also need a _new_ test to ensure that "auto" kicks
> in without any explicit request?  Knowing the implementation that
> pager-in-use triggers the "auto" behaviour, perhaps testing the
> output from "git -p log" would be sufficient?

BTW,

>  
> +static int auto_decoration_style()
> +{
> +	return (isatty(1) || pager_in_use()) ? DECORATE_SHORT_REFS : 0;
> +}

FYI, I fixed this to

	static int auto_decoration_style(void)

while queuing to make it compile.
