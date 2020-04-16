Return-Path: <SRS0=FNL0=6A=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72F40C2BB55
	for <git@archiver.kernel.org>; Thu, 16 Apr 2020 18:03:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4801221924
	for <git@archiver.kernel.org>; Thu, 16 Apr 2020 18:03:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="s8hjVSA4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730828AbgDPSDx (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 16 Apr 2020 14:03:53 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:56616 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727794AbgDPSDw (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 16 Apr 2020 14:03:52 -0400
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 4F2FA436D1;
        Thu, 16 Apr 2020 14:03:50 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=51sTvLjExOlBYtuAfUr2GWCyCe4=; b=s8hjVS
        A47NYceHIMin0UBvzWypj9bgBM0q6UqMYBAdsZPKkA1fie4fFykf3oY3PuFhV1JW
        ec2cuAXVb5EGBn0kl2FT92d5v5YZk0TTOJy8R5vMl11NNMRCdy61ltKe5guomBPy
        crZD33oyENeoGjRvjvq2mQoMMI0TeRjUQ7TcY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=pXhgdE9DYuiqyDRsKQuqCcvfmvVZIBv3
        MfqRFXVz5cxXH5WCDdFApxkmBkqTQeFGE9ZW637AQQQma0fYu4LHrVcZOQMgFloS
        Oxdy/Q7NxAV8G7jdW0oQqUg+xL6R98KL9Z51wmlJgU1FvEYAHl59fLfd3xdDfWAW
        FzhlC4NwQk4=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 45082436D0;
        Thu, 16 Apr 2020 14:03:50 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id BE519436CD;
        Thu, 16 Apr 2020 14:03:49 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, sluongng@gmail.com, me@ttaylorr.com,
        Derrick Stolee <dstolee@microsoft.com>
Subject: Re: [PATCH v3 2/2] log: add log.excludeDecoration config option
References: <pull.610.v2.git.1586965463222.gitgitgadget@gmail.com>
        <pull.610.v3.git.1587046549.gitgitgadget@gmail.com>
        <96c865e9214802021f8e991d2194b7aea6cd6bba.1587046549.git.gitgitgadget@gmail.com>
        <xmqqo8rrz5gn.fsf@gitster.c.googlers.com>
Date:   Thu, 16 Apr 2020 11:03:49 -0700
In-Reply-To: <xmqqo8rrz5gn.fsf@gitster.c.googlers.com> (Junio C. Hamano's
        message of "Thu, 16 Apr 2020 10:49:12 -0700")
Message-ID: <xmqqftd3z4sa.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 9FD8803E-800C-11EA-8FA6-D1361DBA3BAF-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

>>  	if (include_patterns && include_patterns->nr) {
>> -		int found = 0;
>>  		for_each_string_list_item(item, include_patterns) {
>>  			if (match_ref_pattern(refname, item)) {
>> -				found = 1;
>> -				break;
>> +				return 1;
>>  			}
>
> Micronit.  
>
> Let's mimick the early return in the loop above (for command line
> excludes) and below (for configured excludes), each of which is just
> a single "return" statement in a block without {braces} around.

... heh, it seems that the nit is mine in the suggested alternative
upthread.  Let me amend while queuing.

Thanks.
