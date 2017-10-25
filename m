Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D2E3C1FAED
	for <e@80x24.org>; Wed, 25 Oct 2017 05:11:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751173AbdJYFLY (ORCPT <rfc822;e@80x24.org>);
        Wed, 25 Oct 2017 01:11:24 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:55863 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1750921AbdJYFLX (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 25 Oct 2017 01:11:23 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 759DCACEF6;
        Wed, 25 Oct 2017 01:11:23 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=yuSk66i/iMOrWeZ040v0M+WKYOk=; b=w6ChW2
        XAi9qOM6u2KT/i1sRxlTTgHuTJLlCZtQAign4jcxo7nXRReYetvwIcRqoU1/70qn
        0KzYoBxvv6dodl8y/weP6hjpXQsT/GpdT8fixHkH1L6GKXBJMmfZqHvshBnxMTj/
        GExic8DmcBOWCXM+H0mlSz5CSkZvmp1B8K6kc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=M5L4HXQSzjKjHrhbt55SPD4adWUm2oSX
        OBRCJnAG4e6SRdDQK8xV3lrdCuCGjBK/ZoFizs9m0ygXRLab6eq2C01CsTWbYO15
        +0Lm4YWTbS3WJPIIYbG2ytbU9TqegzKUg4jm3ncVKf42LzDZs9OxPvQahjVkvYs8
        lnHmvOz36FM=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 6CE2AACEF5;
        Wed, 25 Oct 2017 01:11:23 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id CF52FACEF4;
        Wed, 25 Oct 2017 01:11:22 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Stefan Beller <sbeller@google.com>
Cc:     git@vger.kernel.org, peff@peff.net, jrnieder@gmail.com,
        l.s.r@web.de
Subject: Re: [PATCHv2 0/2] (x)diff cleanup: remove duplicate code
References: <CAGZ79kZftQoP-Ht+VRakCZsQxh1tjfu=4DFJn_R6fiKD2MmzMA@mail.gmail.com>
        <20171024234234.10944-1-sbeller@google.com>
Date:   Wed, 25 Oct 2017 14:11:21 +0900
In-Reply-To: <20171024234234.10944-1-sbeller@google.com> (Stefan Beller's
        message of "Tue, 24 Oct 2017 16:42:32 -0700")
Message-ID: <xmqqinf3izgm.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: F1881A2C-B942-11E7-AE08-575F0C78B957-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Stefan Beller <sbeller@google.com> writes:

> v2:
> * I realized that we don't have to change the hashing function of xdiff;
>   we can rather change the hashing function for the move detection,
>   which is less fundamental.
>   (That way I can shrink the series down to 2 patches)
> * commented and renamed function parameters in the exposed xdiff functions.
> * applies on top of jk/diff-color-moved-fix.

Yes, by reusing the line hashing and comparison from xdiff/ we can
ensure that we will use consistent comparison function, and the
thing we need to focus on will become how correctly the caller uses
the xdiff interface.  This looks much better than the previous one.

Eric's comment on the function parameters is right.  We keep them in
sync with the naming convention of xdiff/ as long as they are still
part of xdiff layer, and the convention there is that the lines
being compared are l1[] and l2[] whose lengths are s1 and s2, if I
am not mistaken (well, I am not, as I just touched the function
there during my lunch break ;-).


