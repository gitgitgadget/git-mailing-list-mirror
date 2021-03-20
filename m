Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3CF3AC433DB
	for <git@archiver.kernel.org>; Sat, 20 Mar 2021 01:53:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 008866197F
	for <git@archiver.kernel.org>; Sat, 20 Mar 2021 01:53:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229637AbhCTBws (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 19 Mar 2021 21:52:48 -0400
Received: from pb-smtp20.pobox.com ([173.228.157.52]:62304 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229564AbhCTBwY (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 19 Mar 2021 21:52:24 -0400
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id E9DAB11A1C0;
        Fri, 19 Mar 2021 21:52:23 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=8crPBjNCeej/RXj0sqzF+JJ2Qak=; b=MZlvNw
        y++7ph00l9Q8VDwn02FgYk2WSeuXzB3btWwsf0rX7XJnYENYii+TL+9+Advlyjlb
        O8qeRBjhZHp/rfbz4k2A+V4t7mZEb7MZVt+8UqkMxbB2mNrTg0jEj9dIIRRU5AKO
        J9+j7UC1b8B/KdpFKgU+YCqBs8qVC5NUXoGMM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=uW/g+I9AsPWmZNHOv4cB2GmyReCcajyF
        fJNTC1ozscm2tO7nxIoLogFMhHXqpBN7Y20Dkmxc9aNBGAVzqiUDnHZMAxgENRfr
        Ue+8Yq67/3EV/2PHKA1wZ4H5upVunQGAD6As2am4+yzFDqBTos8HbtUk1/neFQhG
        An03Yh7Id9I=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id E15FC11A1BF;
        Fri, 19 Mar 2021 21:52:23 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 37E7E11A1BD;
        Fri, 19 Mar 2021 21:52:21 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, newren@gmail.com,
        Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee <dstolee@microsoft.com>
Subject: Re: [PATCH 01/27] *: remove 'const' qualifier for struct index_state
References: <pull.906.git.1615929435.gitgitgadget@gmail.com>
        <628e16dd3fc7be96d40a7b3201573a71ae7fbbd6.1615929436.git.gitgitgadget@gmail.com>
        <xmqqwnu2lux2.fsf@gitster.g>
Date:   Fri, 19 Mar 2021 18:52:19 -0700
In-Reply-To: <xmqqwnu2lux2.fsf@gitster.g> (Junio C. Hamano's message of "Fri,
        19 Mar 2021 14:01:45 -0700")
Message-ID: <xmqq8s6ilhgs.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1.90 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: E8C8C44A-891E-11EB-B2B3-E43E2BB96649-77302942!pb-smtp20.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

> "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com> writes:
>
>> From: Derrick Stolee <dstolee@microsoft.com>
>>
>> Several methods specify that they take a 'struct index_state' pointer
>> with the 'const' qualifier because they intend to only query the data,
>> not change it. However, we will be introducing a step very low in the
>> method stack that might modify a sparse-index to become a full index in
>> the case that our queries venture inside a sparse-directory entry.
>>
>> This change only removes the 'const' qualifiers that are necessary for
>> the following change which will actually modify the implementation of
>> index_name_stage_pos().
>
> This step has a bit of interaction with Matheus's "git add/rm" work
> in sparse checkout (mt/add-rm-in-sparse-checkout), which I believe
> is still in a bit of flux.  I didn't check potential conflicts the
> remainder of the series may have with other in-flight topics.
>
> So, I may throw review comments at the patches in this topic as if
> they are standalone, but please do not be upset if it didn't appear
> in the 'seen' topic.

Tonight's pushout will have this topic in 'seen', but I consider the
branch a series of trial merges (there are other first-time topics).
The result seems to compile for me, but other than that, I have not
much confidence in conflict resolution.  Please give them an extra
set of eyeballs.

Thanks.
