Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE253C433EF
	for <git@archiver.kernel.org>; Wed, 13 Apr 2022 20:10:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238691AbiDMUMq (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 13 Apr 2022 16:12:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57670 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237193AbiDMUMf (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 13 Apr 2022 16:12:35 -0400
Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 05C2138D9A
        for <git@vger.kernel.org>; Wed, 13 Apr 2022 13:10:12 -0700 (PDT)
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 078DF127163;
        Wed, 13 Apr 2022 16:10:12 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=F/+7jmMoUPuFROjV80BD3f5D/g8uPIIz967qNH
        VzJA8=; b=xIGZduVhsQCZhjWf9MCp+HSthNZOnSJwvgiffiBmSy7PdJBXEWcLlj
        qeitvIEqpklHdE9uI/7stXkpt+FjZV0WWtkU9i6pgIXR8f0j5ryS88CRxXrG+msL
        Ex2R2eiV5odeqkPURhoddzuOC9Gshpqh0KehGBv9jydDzbMyvLKlA=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id E57D5127162;
        Wed, 13 Apr 2022 16:10:11 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.185.214.157])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id C9333127161;
        Wed, 13 Apr 2022 16:10:10 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "brian m. carlson" <sandals@crustytoothpaste.net>
Cc:     Jonathan Tan <jonathantanmy@google.com>, git@vger.kernel.org,
        Phillip Wood <phillip.wood123@gmail.com>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Subject: Re: [PATCH v4 4/4] builtin/stash: provide a way to import stashes
 from a ref
References: <20220407215352.3491567-5-sandals@crustytoothpaste.net>
        <20220412201435.803424-1-jonathantanmy@google.com>
        <YlYjgLcnNH8V1yj0@camp.crustytoothpaste.net>
Date:   Wed, 13 Apr 2022 13:10:07 -0700
In-Reply-To: <YlYjgLcnNH8V1yj0@camp.crustytoothpaste.net> (brian m. carlson's
        message of "Wed, 13 Apr 2022 01:12:32 +0000")
Message-ID: <xmqqzgko7nj4.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: B8D42D2C-BB65-11EC-8564-CB998F0A682E-77302942!pb-smtp2.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"brian m. carlson" <sandals@crustytoothpaste.net> writes:

> On 2022-04-12 at 20:14:34, Jonathan Tan wrote:
>> This seems like you're using the commit message as the reflog message -
>> is this necessary? For what it's worth, all tests still pass if I
>> replace "msg" with "NULL".
>
> I think that's what the existing stash code does, and so I did the same
> here.  It's not strictly necessary, but it's a nice to have.
>
> I didn't think it worth testing, because I don't think we test it
> elsewhere, either.
>
>> It might be worth adding tests that check that the exported stashes are
>> in the expected format (to ensure that we can read stashes exported from
>> another Git version) but I don't think that has to block the submission
>> of this patch set.
>
> There's a tiny patch for that for the base commit, but you're right that
> some more tests wouldn't hurt.  I can send a followup patch or two as
> part of a new series.

Is this about the log messages recorded in the throw-away commits
that are only used to form a single backbone chain, to which the
commits used to represent stash entries are linked to?

Are these messages meant to be used in any way?  I do not think
these messages contribute anything to the end result (they are just
discarded once they serve their purpose of transferring the
underlying stash entries, if I recall the design discussion
correctly), so I am not sure if we would even want to cast in stone
what they would say.

If on the other hand they are meant to be read by something (either
programs or end-user humans), it does make sense to ensure that we
are recording what we think we are recording.

Thanks.
