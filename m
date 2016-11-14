Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4519D1F858
	for <e@80x24.org>; Mon, 14 Nov 2016 18:56:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933973AbcKNS4S (ORCPT <rfc822;e@80x24.org>);
        Mon, 14 Nov 2016 13:56:18 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:59419 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S932899AbcKNS4R (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 14 Nov 2016 13:56:17 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id D4DAB4FF26;
        Mon, 14 Nov 2016 13:56:15 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=cjC69hPzenM/mGmcmCG0Xk7K9F8=; b=e9e9yj
        PcOv7VVn2zLb/G0fk4vA70vEpOaQQqRXFJZpHkIblKIukNpowlUQTLn1j7p+wbmA
        PISkX4ntYz7Kalw0XWKR5NlpE/+7Zd+kQfl9XiAvJx1xMbxJJlmiGbWlYbmxc6tC
        IzLSZwMxar0Z5mad4RJKmm1IkcFx7Su+7HQ/U=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=sZxzxN01veRWWk5uNg6ujR6LPpxojY3N
        E6fJ/IXI5XJPinzJ55kYEfGeXzUofWlupMK5oPeaiF3kET14B/tNNN0dDEsrfhax
        NXrXJrj4nO7zaiLB6nc0ZQGsnA5uX+qbu9gt3elDmQ/Lf/GRuR3DPAvH3MmekgE6
        ckaGBUB3UgM=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id CD1EE4FF25;
        Mon, 14 Nov 2016 13:56:15 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 5400F4FF24;
        Mon, 14 Nov 2016 13:56:15 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jonathan Tan <jonathantanmy@google.com>
Cc:     git@vger.kernel.org, sbeller@google.com,
        Brandon Williams <bmwill@google.com>
Subject: Re: [PATCH v3 5/6] grep: enable recurse-submodules to work on <tree> objects
References: <1477953496-103596-1-git-send-email-bmwill@google.com>
        <1478908273-190166-1-git-send-email-bmwill@google.com>
        <1478908273-190166-6-git-send-email-bmwill@google.com>
        <xmqqk2c6x79c.fsf@gitster.mtv.corp.google.com>
        <c83066bc-5b2b-998c-7e22-c4fccbaba5de@google.com>
Date:   Mon, 14 Nov 2016 10:56:13 -0800
In-Reply-To: <c83066bc-5b2b-998c-7e22-c4fccbaba5de@google.com> (Jonathan Tan's
        message of "Mon, 14 Nov 2016 10:44:25 -0800")
Message-ID: <xmqqfumtyjoy.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 04CDFD2E-AA9C-11E6-B617-987C12518317-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jonathan Tan <jonathantanmy@google.com> writes:

>>> to:
>>> HEAD:file
>>> HEAD:sub/file
>>>
>>> Signed-off-by: Brandon Williams <bmwill@google.com>
>>> ---
>>
>> Unrelated tangent, but this makes readers wonder what the updated
>> trailer code would do to the last paragraph ;-).  Does it behave
>> sensibly (with some sane definition of sensibleness)?
>>
>> I am guessing that it would, because neither To: or HEAD: is what we
>> normally recognize as a known trailer block element.
>
> Yes, it behaves sensibly :-) because "Signed-off-by:" is preceded by a
> blank line, so the trailer block consists only of that line.

Oh, that was not what I was wondering.  Imagine Brandon writing his
message that ends in these three questionable lines and then running
"commit -s --amend" to add his sign-off---that was the case I was
wondering.

