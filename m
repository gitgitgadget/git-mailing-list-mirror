Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0E0AE2047F
	for <e@80x24.org>; Thu, 28 Sep 2017 04:14:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750826AbdI1EO0 (ORCPT <rfc822;e@80x24.org>);
        Thu, 28 Sep 2017 00:14:26 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:62274 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1750731AbdI1EOZ (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 28 Sep 2017 00:14:25 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id D17279CDF9;
        Thu, 28 Sep 2017 00:14:24 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=VVpgaSmTHIWIj9eA4N2qHEIHob8=; b=Tu39xV
        yOH/OAqh+l7+iEz8oQOddABBFTOMEpe66NlAMYsglR3JpzIpxtFa2FM/CQ1YzSWa
        ephGSDnMVa/yWCAEyaurWzZl3GFck38g9FJKujgmu+tczhph/UGslNc8hEAUaFRS
        S5xJ7NHJ8QNVSY4y+wQpjbO26xPwcJ7CtDcq8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=o1Mn7QLnFvmCmsAauWeK5QTdo/MbWx28
        mdG+n6dpS2ofEXlJr5b96kAXn1nx0citfCGxGo6PbfgFWPnI3ar38QophXAJ3vDv
        eBqgzHw74UbVlTXrx1bOwnUfpFs0Iy9IgyNllN43KN9YcwXZuY5RQwrjgDRolnwF
        CTi8VetiW8o=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id C93639CDF8;
        Thu, 28 Sep 2017 00:14:24 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 1D1679CDF7;
        Thu, 28 Sep 2017 00:14:24 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Ramsay Jones <ramsay@ramsayjones.plus.com>
Cc:     Stefan Beller <sbeller@google.com>, peff@peff.net,
        git@vger.kernel.org, torvalds@linux-foundation.org
Subject: Re: [PATCH] diff: correct newline in summary for renamed files
References: <20170927224909.25dfojhx6wzaqwt7@sigill.intra.peff.net>
        <20170927225126.4836-1-sbeller@google.com>
        <094ebbd4-1bc6-8360-222f-55a4a16a6ca3@ramsayjones.plus.com>
Date:   Thu, 28 Sep 2017 13:14:23 +0900
In-Reply-To: <094ebbd4-1bc6-8360-222f-55a4a16a6ca3@ramsayjones.plus.com>
        (Ramsay Jones's message of "Thu, 28 Sep 2017 00:49:36 +0100")
Message-ID: <xmqq8tgz31eo.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 82A823C6-A403-11E7-9F88-FE4B1A68708C-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Ramsay Jones <ramsay@ramsayjones.plus.com> writes:

>> +	git checkout -b mode initial &&
>> +	git update-index --chmod=+x file0 &&
>
> would 'test_chmod +x file0 &&' work here?

This one wants to set +x only in the index, leaving the working tree
version without the executable bit.  test_chmod is about setting
both, so it would do something different from what we want to do
here.
