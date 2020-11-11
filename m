Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0308C388F9
	for <git@archiver.kernel.org>; Wed, 11 Nov 2020 21:04:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2037920825
	for <git@archiver.kernel.org>; Wed, 11 Nov 2020 21:04:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="V4r7vdh0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726150AbgKKVEl (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 11 Nov 2020 16:04:41 -0500
Received: from pb-smtp21.pobox.com ([173.228.157.53]:59066 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725933AbgKKVEl (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 11 Nov 2020 16:04:41 -0500
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 395EAF0EA9;
        Wed, 11 Nov 2020 16:04:39 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=dl1wuRJtSa0YRvj0ZSF+2MtnOd8=; b=V4r7vd
        h0EZaIxOw85ZwKkLQT3kGwxEo8FoHBkCipiw3LeSKs3uTZNEoARbmkp+7wxNSgVc
        d+b3HmZDVx06rGqiHV0tFkdJp4UwD+OVBb8xVOjUYP4/zNpHCMQ1Bs8ZQnSla3RH
        Q3tF/YiBIn1lcAYRYJfjbUmktVcZ8gfIs2RaM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=Be27WpFBabd6O7DIdioyADSeqVKMWZ9D
        baTxmxkmE0ntLEaePHoPwiiT09FHuVXV2N2Eu4Orgf1k+IFqGMS8tD1lZeg1Bn3U
        tJyYIS7JX9cF0KfT+f1p4z8PzDdwM+fI5y41kb5OMJ0of3zRgfTy38xufHXzsCrj
        s6RG74Tkjks=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 31FDEF0EA8;
        Wed, 11 Nov 2020 16:04:39 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.75.7.245])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 7D5E5F0EA7;
        Wed, 11 Nov 2020 16:04:36 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Derrick Stolee <stolee@gmail.com>
Cc:     Taylor Blau <me@ttaylorr.com>, git@vger.kernel.org,
        dstolee@microsoft.com, peff@peff.net,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH 15/23] t5310: add branch-based checks
References: <cover.1605123652.git.me@ttaylorr.com>
        <9ab4b94b3573346b31e710486799ab3d95bade8e.1605123653.git.me@ttaylorr.com>
        <abf9273f-4795-5a48-c28b-15e68d40b910@gmail.com>
Date:   Wed, 11 Nov 2020 13:04:34 -0800
In-Reply-To: <abf9273f-4795-5a48-c28b-15e68d40b910@gmail.com> (Derrick
        Stolee's message of "Wed, 11 Nov 2020 15:58:52 -0500")
Message-ID: <xmqqwnyr38rh.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 8156A66E-2461-11EB-B3A3-D609E328BF65-77302942!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Derrick Stolee <stolee@gmail.com> writes:

> On 11/11/2020 2:43 PM, Taylor Blau wrote:
>> From: Derrick Stolee <dstolee@microsoft.com>
>> 
>> The current rev-list tests that check the bitmap data only work on HEAD
>> instead of multiple branches. Expand the test cases to handle both
>> 'master' and 'other' branches.
>
> Adding Johannes to CC since this likely will start colliding with his
> default branch rename efforts.
>
>> +rev_list_tests () {
>> +	state=$1
>> +
>> +	for branch in "master" "other"
>> +	do
>> +		rev_list_tests_head
>> +	done
>> +}
>
> Specifically, this is a _new_ instance of "master", but all the
> other instances of "master" are likely being converted to "main"
> in parallel. It would certainly be easier to convert this test
> _after_ these changes are applied, but that's unlikely to happen
> with the current schedule of things.

In some tests, it may make sense to configure init.defaultbranchname
in $HOME/.gitconfig upfront and either (1) leave instances of
'master' as they are (we may want to avoid 'slave', but 'master' is
not all that wrong), or (2) rewrite instances of 'master' to 'main'
(or 'primary' or whatever init.defaultbranchname gets configured).



