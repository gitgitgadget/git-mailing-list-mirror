Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	NICE_REPLY_C,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D0A5C4338F
	for <git@archiver.kernel.org>; Fri,  6 Aug 2021 22:13:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DA40361181
	for <git@archiver.kernel.org>; Fri,  6 Aug 2021 22:13:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242275AbhHFWNy (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 6 Aug 2021 18:13:54 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:51145 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231577AbhHFWNx (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 6 Aug 2021 18:13:53 -0400
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 28EB3EFD16;
        Fri,  6 Aug 2021 18:13:37 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:message-id:mime-version:content-type;
         s=sasl; bh=en4cBaQnAI0aMUM1BvpejTQOe9JKdCNIrV0orKcIXhw=; b=O4JD
        Qu+vfLcGEZNEyK6NeZKHZO68WAUqrb/IXadq4sEnGEaawmCBX2onu09XQsd0VOtw
        aQyjml7K0SQtHkHmndF+afORFCbfdt2/ArB2bIpmCT+y9XxoBwanzvVQcfGxBhvI
        yoyKtf+mbj3lxxvSQzVJe3T7JBJZGUlfORoBuwo=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 1EAE7EFD15;
        Fri,  6 Aug 2021 18:13:37 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.196.71.182])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 94418EFD14;
        Fri,  6 Aug 2021 18:13:36 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Roman Neuhauser <rn+git@sigpipe.cz>
Cc:     =?utf-8?Q?=C3=98ystein?= Walle <oystwa@gmail.com>,
        git@vger.kernel.org
Subject: Re: [PATCH v2] clone: Allow combining --bare and --origin
References: <xmqqv94mtdyj.fsf@gitster.g>
        <20210804133010.25855-1-oystwa@gmail.com> <xmqqbl6dqgvc.fsf@gitster.g>
        <YQ2aXpfzyOOUFhQk@isis.sigpipe.cz>
Date:   Fri, 06 Aug 2021 15:13:35 -0700
Message-ID: <xmqqh7g2gr1s.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 8BBBB2AA-F703-11EB-BFBC-8B3BC6D8090B-77302942!pb-smtp1.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Roman Neuhauser <rn+git@sigpipe.cz> writes:

>> But we'd end up treating them the same.  And something like
>> remote.originName would help that.  Otherwise, we'd end up sending
>> this message:
>> 
>>     Even if we give "--bare --origin yourfavouritename" to you now,
>>     unlike how 'origin' is treated in the default case, in the
>>     resulting repository, 'yourfavouritename' is not special at all.
>
> Isn't that the case in non-bare repositories as well?

You have branches that are checked out.  The first branch that you'd
presumably be using as the primary (traditionally called 'master')
knows that the nickname used to call the remote it integrates with
as the value of branch.master.remote

In a bare repository, there is no such clue.

> Can't they just continue doing what they've been doing so far,
> that is leave it at "origin"?  I'm not sure this would be my concern
> as a user of this feature.

That answer can be thrown back at you.  You can leave it at "origin"
when using "--bare" ;-).

The posted patch is a good first step to allow both options to be
used at the same time.  Without the first step, these two options
cannot coexist.

But I am also saying that the first step alone is an inadequate
solution that goes only halfway.  If you can get yourfavouritename,
while others cannot use their favourite names, that is not a
satisfying solution.
