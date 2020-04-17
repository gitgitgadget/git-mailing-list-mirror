Return-Path: <SRS0=xqrk=6B=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8466CC2BA2B
	for <git@archiver.kernel.org>; Fri, 17 Apr 2020 02:01:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 509EB21D93
	for <git@archiver.kernel.org>; Fri, 17 Apr 2020 02:01:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="IZ3pNwFT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728977AbgDQCBt (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 16 Apr 2020 22:01:49 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:59719 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725800AbgDQCBt (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 16 Apr 2020 22:01:49 -0400
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 0110A46E49;
        Thu, 16 Apr 2020 22:01:47 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=OD5uPXOilLXpJChzchpZj5grQ5Q=; b=IZ3pNw
        FT77GvGtBl6RIGH+o+r+PAHnd+6pHO4pYnhqpdxQk9zEchYIQPa2C0qvb2oi9lcS
        9OI2+nh5+0aXT1n1vze2qb37glm/rR370056VQweRWwNeixAFslun8dXg0H/bvgG
        Ms5SuK5xo+IKyE7urMcuw9YumDqcZQGqQSzyo=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=oTwDThEnjdaQl7S3U7txj5AEtBvodY1Q
        yI8TmHjuhhduNSFC5hXGfA4iIc2/KBOaaWroPX0vVkZYNnsdy8Y4pbA0ZxO7mxIA
        UKrPP2AD2TOcmqnwAGt2nJzE9hLurx3jtneHWenBVvTnHWt4RjrhLbOPM3yqKl8T
        F8IB8tyUnYk=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id EC9BD46E48;
        Thu, 16 Apr 2020 22:01:46 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 7308846E47;
        Thu, 16 Apr 2020 22:01:46 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Derrick Stolee <stolee@gmail.com>
Cc:     Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, sluongng@gmail.com, me@ttaylorr.com,
        Derrick Stolee <dstolee@microsoft.com>
Subject: Re: [PATCH v3 2/2] log: add log.excludeDecoration config option
References: <pull.610.v2.git.1586965463222.gitgitgadget@gmail.com>
        <pull.610.v3.git.1587046549.gitgitgadget@gmail.com>
        <96c865e9214802021f8e991d2194b7aea6cd6bba.1587046549.git.gitgitgadget@gmail.com>
        <xmqqo8rrz5gn.fsf@gitster.c.googlers.com>
        <xmqqftd3z4sa.fsf@gitster.c.googlers.com>
        <481d4e05-c6f8-0554-e8f6-04562d316c4c@gmail.com>
Date:   Thu, 16 Apr 2020 19:01:45 -0700
In-Reply-To: <481d4e05-c6f8-0554-e8f6-04562d316c4c@gmail.com> (Derrick
        Stolee's message of "Thu, 16 Apr 2020 21:53:51 -0400")
Message-ID: <xmqqv9lyx43a.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 647C6D0A-804F-11EA-9A31-D1361DBA3BAF-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Derrick Stolee <stolee@gmail.com> writes:

> On 4/16/2020 2:03 PM, Junio C Hamano wrote:
>> Junio C Hamano <gitster@pobox.com> writes:
>> 
>>>>  	if (include_patterns && include_patterns->nr) {
>>>> -		int found = 0;
>>>>  		for_each_string_list_item(item, include_patterns) {
>>>>  			if (match_ref_pattern(refname, item)) {
>>>> -				found = 1;
>>>> -				break;
>>>> +				return 1;
>>>>  			}
>>>
>>> Micronit.  
>>>
>>> Let's mimick the early return in the loop above (for command line
>>> excludes) and below (for configured excludes), each of which is just
>>> a single "return" statement in a block without {braces} around.
>> 
>> ... heh, it seems that the nit is mine in the suggested alternative
>> upthread.  Let me amend while queuing.
>
> Shame on me for not noticing. Thanks for the close look!

Heh, shame is mine, too ;-)

Thanks.
