Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36E86C433EF
	for <git@archiver.kernel.org>; Mon, 21 Mar 2022 20:49:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233847AbiCUUvK (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 21 Mar 2022 16:51:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46924 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229475AbiCUUvJ (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 21 Mar 2022 16:51:09 -0400
Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A45B260CF5
        for <git@vger.kernel.org>; Mon, 21 Mar 2022 13:49:43 -0700 (PDT)
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 0B191179D10;
        Mon, 21 Mar 2022 16:49:43 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=aEFJmV9JeJoPTOz+j8CR4DOhyNIfSnVGfMa4Gp
        51IhM=; b=T24shCOMBWmPIvfhvb8pxql4iIGUSjEiCcByMOeuWubeSArnI8C5Nx
        btKudxbUGJGZtF8FBwZD32tPqPS+b/IiNuZVkvK9Cf89kzgF5NZO0gaGfScKlKpT
        PXiP+D2v5rxqJlWOO+fJddP1zcK14Md341NBo8RntUXGUbj8+YUaM=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id E4F6E179D0F;
        Mon, 21 Mar 2022 16:49:42 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.227.145.180])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 320C6179D0E;
        Mon, 21 Mar 2022 16:49:40 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Neeraj Singh <nksingh85@gmail.com>
Cc:     "Neeraj K. Singh via GitGitGadget" <gitgitgadget@gmail.com>,
        Git List <git@vger.kernel.org>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Patrick Steinhardt <ps@pks.im>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        "Neeraj K. Singh" <neerajsi@microsoft.com>
Subject: Re: [PATCH v2 0/7] core.fsyncmethod: add 'batch' mode for faster
 fsyncing of multiple objects
References: <pull.1134.git.1647379859.gitgitgadget@gmail.com>
        <pull.1134.v2.git.1647760560.gitgitgadget@gmail.com>
        <xmqqpmmf1bm5.fsf@gitster.g>
        <CANQDOdfCJy68z0bNrhSmwo_uEVa6=y4V1dY0kZDq7JOTUD+6iQ@mail.gmail.com>
Date:   Mon, 21 Mar 2022 13:49:39 -0700
In-Reply-To: <CANQDOdfCJy68z0bNrhSmwo_uEVa6=y4V1dY0kZDq7JOTUD+6iQ@mail.gmail.com>
        (Neeraj Singh's message of "Mon, 21 Mar 2022 11:14:53 -0700")
Message-ID: <xmqqv8w7vxng.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 6D92E390-A958-11EC-AA17-CBA7845BAAA9-77302942!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Neeraj Singh <nksingh85@gmail.com> writes:

>> In any case, I've applied them on 0cac37f38f9 and then re-applied
>> the result on top of fd008b1442 (i.e. the same base as the previous
>> round was queued), which, with the magic of "am -3", applied
>> cleanly.  Double checking the result was also simple (i.e. the tip of
>> such an application on top of fd008b1442 can be merged with
>> 0cac37f38f9 and the result should be identical to the result of
>> applying them directly on top of 0cac37f38f9) and seems to have
>> produced the right result.
>>
>> \Thanks.
>
> Thanks Junio.  I was worried about how to properly represent the dependency
> between these two in-flight branches without waiting for ns/core-fsyncmethod to
> get into next.   Now ns/core-fsyncmethod appears to be there, so I'm assuming
> that branch should have a stable OID until the end of the cycle.
>
> Should I base future versions of this series on the tip of
> ns/core-fsyncmethod, or
> on the merge point between that branch and 'next'?

Please base it on fd008b1442 (i.e. the same base as this and the
previous round was queued on), unless there is a strong reason to
rebase elsewhere.

Thanks.
