Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77943C43334
	for <git@archiver.kernel.org>; Wed,  8 Jun 2022 15:35:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244280AbiFHPfb (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 8 Jun 2022 11:35:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40452 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244300AbiFHPf1 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 8 Jun 2022 11:35:27 -0400
Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB1FD1053EB
        for <git@vger.kernel.org>; Wed,  8 Jun 2022 08:35:03 -0700 (PDT)
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 1960012D0EF;
        Wed,  8 Jun 2022 11:34:57 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=f9ZY5nmxWjotM9gxe2TrQK9cjBh0bVsxaOFT0K
        olx5Y=; b=eGixJUUTOnvU46RY/4eeIrWRkM5Bdgkgm89+PnHMMzHjY695KfxkDJ
        UbNS4ca1bGOjG0Zv/zGn6OFHRgkxB8ZluJU1WmvJnugcBSY4meASw01r24Na1BmV
        oS/KpSF1lKlqBbV1wLVT6ZyZozq8IHi0gjbXekDU2zfnxUvXi4bkY=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 0E69F12D0ED;
        Wed,  8 Jun 2022 11:34:57 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.83.92.57])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 6292112D0EB;
        Wed,  8 Jun 2022 11:34:56 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Neeraj Singh <nksingh85@gmail.com>
Cc:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        git@vger.kernel.org, Han Xin <chiyutianyi@gmail.com>,
        Jiang Xin <worldhello.net@gmail.com>,
        =?utf-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>,
        Derrick Stolee <stolee@gmail.com>,
        Philip Oakley <philipoakley@iee.email>,
        Neeraj Singh <neerajsi@microsoft.com>,
        Elijah Newren <newren@gmail.com>,
        Han Xin <hanxin.hx@alibaba-inc.com>,
        Jiang Xin <zhiyou.jx@alibaba-inc.com>
Subject: Re: [PATCH v13 5/7] object-file.c: add "stream_loose_object()" to
 handle large object
References: <cover-v12-0.8-00000000000-20220329T135446Z-avarab@gmail.com>
        <cover-v13-0.7-00000000000-20220604T095113Z-avarab@gmail.com>
        <patch-v13-5.7-0b07b29836b-20220604T095113Z-avarab@gmail.com>
        <7ba4858a-d1cc-a4eb-b6d6-4c04a5dd6ce7@gmail.com>
Date:   Wed, 08 Jun 2022 08:34:55 -0700
In-Reply-To: <7ba4858a-d1cc-a4eb-b6d6-4c04a5dd6ce7@gmail.com> (Neeraj Singh's
        message of "Tue, 7 Jun 2022 12:53:31 -0700")
Message-ID: <xmqqh74vrwww.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 8C964A90-E740-11EC-8929-CB998F0A682E-77302942!pb-smtp2.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Neeraj Singh <nksingh85@gmail.com> writes:

>> Still, we need to save the temporary file we're preparing
>> somewhere. We'll do that in the top-level ".git/objects/"
>> directory (or whatever "GIT_OBJECT_DIRECTORY" is set to). Once we've
>> streamed it we'll know the OID, and will move it to its canonical
>> path.
>> 
>
> I think this new logic doesn't play well with batched-fsync. Even
> through we don't know the final OID, we should still call 
> prepare_loose_object_bulk_checkin to potentially create the bulk
> checkin objdir.

Good point.  Careful sanity checks like this are very much
appreciated.

> Thanks for including me on the review!

Yes, indeed.

Thanks, both.
