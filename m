Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5905C11F64
	for <git@archiver.kernel.org>; Mon, 28 Jun 2021 23:12:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B996861D03
	for <git@archiver.kernel.org>; Mon, 28 Jun 2021 23:12:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235725AbhF1XPJ (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 28 Jun 2021 19:15:09 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:57813 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235349AbhF1XPH (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 28 Jun 2021 19:15:07 -0400
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id EAD8BC44CC;
        Mon, 28 Jun 2021 19:12:38 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:message-id:mime-version:content-type;
         s=sasl; bh=MRjMb1mHCnH7t1alA5zJRSDdEQKKPrTJXY8vPk+CVew=; b=vUlM
        KY8JReDcotHceL3OaFfdSrS1FtJXv04bQzY2FDNVN3PO3/53iTHnxwyuZelehhkX
        YdnvCTqtAOtRrKrAwshQi+jDVwtq7HjOecZQuSIVNNZK/lJTI93wjuIaUNqXroYi
        F4OXuLKT+eZQMQOLhGvbMZpoMXrMb5n+J3YateQ=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id E1A9CC44CB;
        Mon, 28 Jun 2021 19:12:38 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.3.135])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 60B4CC44C8;
        Mon, 28 Jun 2021 19:12:38 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "brian m. carlson" <sandals@crustytoothpaste.net>
Cc:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Jonathan Tan <jonathantanmy@google.com>, git@vger.kernel.org,
        Emily Shaffer <emilyshaffer@google.com>
Subject: Re: [RFC PATCH 0/2] MVP implementation of remote-suggested hooks
References: <cover.1623881977.git.jonathantanmy@google.com>
        <87fsxc47le.fsf@evledraar.gmail.com>
        <YNExhalSLWvmky55@camp.crustytoothpaste.net>
Date:   Mon, 28 Jun 2021 16:12:37 -0700
Message-ID: <xmqqa6n960t6.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 54B1EC22-D866-11EB-A303-8B3BC6D8090B-77302942!pb-smtp1.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"brian m. carlson" <sandals@crustytoothpaste.net> writes:

> If we do add this feature (which, as I said, I'm opposed to) and we
> decide to store it in a ref, that ref should not be a normal branch by
> default (it should be a special one-level ref, like refs/stash or such),
> and the ref name should be configurable.  Not all developers use English
> as their working language and we should respect that.

Just this part.

I am not sure what you are trying to achieve by requiring it to be
configurable.  After all, even for names of branches that are used
to store the code, which is of more significance than this "unusual"
ref, we've lived with a hardcoded 'master' and with the server-end
advertisability of the configured values (i.e. "git clone" was
designed to figure out if the origin used a custom name for the
primary line of history and use the same name from the beginning),
the end-user sitting on the receiving end did not have to do
anything special even when the project wanted to use a custom name.

But this "unusual" ref would not have a natural equivalent of "the
origin side can point the primary branch with its HEAD", so by
allowing it to be configurable, you are pretty much closing the door
for those who blindly honor whatever the origin tells them to use
when running "git clone" from doing so.  I agree that it is a good
security measure (and I am not sold to the "remote suggested hooks"
idea in the first place), but is that the real reason why you
suggested configurability?

