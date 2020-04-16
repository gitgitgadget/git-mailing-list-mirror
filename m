Return-Path: <SRS0=FNL0=6A=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A8B4C2BB55
	for <git@archiver.kernel.org>; Thu, 16 Apr 2020 18:02:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0FD8421924
	for <git@archiver.kernel.org>; Thu, 16 Apr 2020 18:02:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="XDJmKSgV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732494AbgDPSCf (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 16 Apr 2020 14:02:35 -0400
Received: from pb-smtp21.pobox.com ([173.228.157.53]:55076 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727794AbgDPSCd (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 16 Apr 2020 14:02:33 -0400
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 196D4B3630;
        Thu, 16 Apr 2020 14:02:32 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=zeEEa7NNcE9pS3ya5flVqfQWzZg=; b=XDJmKS
        gVzBo2y/7a798in5f3k1GTOs/iDnh6rCcv2IvW3XFE0l5gD0lu6Arp0IIU6JLcJi
        Of1oPdbv+0tIs19BABcpymer83P7gmVk1woAuyKf5IKmukLMdz4XeYfI7WimU5zY
        CCvVwJxT8Bbk5X1GkmjIdZvamuf2Lt/vkdLo0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=UQXhv3/A4uv+XzqdwwdVYvmOwOHfA2eC
        Ru1qjEuhxhyCDCkOEIaC2gb6q80RZo2azW0YzRQXaeaOcFqA+LGO3XjRHetScVBX
        4+NxkMuTbkPtyoTPeBXfdKqBdc6AYBDIQg6bEnxsf13xQHZLybXq32+z4a8QKzmd
        RvJytNvZSxg=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 0F739B362F;
        Thu, 16 Apr 2020 14:02:32 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 48BDAB362E;
        Thu, 16 Apr 2020 14:02:29 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Taylor Blau <me@ttaylorr.com>
Cc:     Derrick Stolee <stolee@gmail.com>,
        Jakub =?utf-8?Q?Nar=C4=99bski?= <jnareb@gmail.com>,
        Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>,
        git <git@vger.kernel.org>, Garima Singh <garimasigit@gmail.com>,
        Derrick Stolee <dstolee@microsoft.com>
Subject: Re: [PATCH 1/3] revision: complicated pathspecs disable filters
References: <pull.609.git.1586566981.gitgitgadget@gmail.com>
        <9cc31c289aa785f026eec84452ed68e80505d95e.1586566981.git.gitgitgadget@gmail.com>
        <xmqqeesthfbf.fsf@gitster.c.googlers.com>
        <44ce43e2-6cf0-0e48-18eb-f02543d81bf4@gmail.com>
        <xmqqmu7d9b6j.fsf@gitster.c.googlers.com>
        <f57c7908-55ae-deae-e9ea-1909549e628c@gmail.com>
        <99e0ae2c-6b65-24e4-3d2b-1dff619a5daa@gmail.com>
        <CANQwDwdcM-hc+Nyc0nBnp79W0BuH2PfdgM6WLqET3sPn1GYc-A@mail.gmail.com>
        <20200416005241.GB36156@syl.local>
        <67350f6c-d558-8b9b-4d57-5830f7a74fab@gmail.com>
        <20200416163330.GB78342@syl.local>
Date:   Thu, 16 Apr 2020 11:02:27 -0700
In-Reply-To: <20200416163330.GB78342@syl.local> (Taylor Blau's message of
        "Thu, 16 Apr 2020 10:33:30 -0600")
Message-ID: <xmqqk12fz4uk.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 6FDFFFD8-800C-11EA-9C43-8D86F504CC47-77302942!pb-smtp21.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Taylor Blau <me@ttaylorr.com> writes:

>> It is good that we have the capability to extend the filter data in
>> the future if we really need to.
>>
>> I'll make a TODO item for myself to try writing that detailed Bloom
>> filter format documentation as a follow-up. In the meantime, I'll try
>> to close this out by responding to the feedback we have so far.
>
> Sounds good, and thanks for investigating.

Yeah, thanks, all.

