Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0F55C433EF
	for <git@archiver.kernel.org>; Wed, 23 Feb 2022 21:37:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237915AbiBWViQ (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 23 Feb 2022 16:38:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39560 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233597AbiBWViP (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 23 Feb 2022 16:38:15 -0500
Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C3E2F457B9
        for <git@vger.kernel.org>; Wed, 23 Feb 2022 13:37:47 -0800 (PST)
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 2CF3818B51F;
        Wed, 23 Feb 2022 16:37:47 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=moXlxYPgB67QkIbSAeBDLlZ5cYUa6Q5XONMxRl
        kgo4Q=; b=jXN1Dvt9vD/UBmBey6mN8dI6fZlFy08uDb9+dHoHdhbZdr2YhDVkXy
        HRqyU0jhN8e6Fb3pVwaXbCislrTwyvFRa0m3bNi1qOBopZ30F+9BEIbWdoTyDc6K
        EJ5LBOpRkAF55AiqxZQUXNSl0DK5kEL0EnM75eGHoaweLEq7qb2Dw=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 25A6718B51E;
        Wed, 23 Feb 2022 16:37:47 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.82.80.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 78A7718B51D;
        Wed, 23 Feb 2022 16:37:43 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Han-Wen Nienhuys via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Han-Wen Nienhuys <hanwen@google.com>,
        Han-Wen Nienhuys <hanwenn@gmail.com>
Subject: Re: [PATCH v3 0/7] reftable: avoid reading and writing empty keys
References: <pull.1185.v2.git.git.1645106124.gitgitgadget@gmail.com>
        <pull.1185.v3.git.git.1645469170.gitgitgadget@gmail.com>
Date:   Wed, 23 Feb 2022 13:37:42 -0800
In-Reply-To: <pull.1185.v3.git.git.1645469170.gitgitgadget@gmail.com> (Han-Wen
        Nienhuys via GitGitGadget's message of "Mon, 21 Feb 2022 18:46:03
        +0000")
Message-ID: <xmqqk0dls1qx.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: D5689F90-94F0-11EC-9C39-C85A9F429DF0-77302942!pb-smtp20.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Han-Wen Nienhuys via GitGitGadget" <gitgitgadget@gmail.com> writes:

> this series makes sure that the object record does not have to consider
> empty keys (and therefore, a NULL memcpy destination)
>
> while we're at it add some more tests, and fix a naming mistake.

Looking good.  Let's mark it for 'next' and below soonish.

Thanks.

>
> Han-Wen Nienhuys (7):
>   Documentation: object_id_len goes up to 31
>   reftable: reject 0 object_id_len
>   reftable: add a test that verifies that writing empty keys fails
>   reftable: avoid writing empty keys at the block layer
>   reftable: ensure that obj_id_len is >= 2 on writing
>   reftable: add test for length of disambiguating prefix
>   reftable: rename writer_stats to reftable_writer_stats
>
>  Documentation/technical/reftable.txt |   2 +-
>  reftable/block.c                     |  27 ++++---
>  reftable/block_test.c                |   5 ++
>  reftable/reader.c                    |   5 ++
>  reftable/readwrite_test.c            | 105 ++++++++++++++++++++++++++-
>  reftable/reftable-writer.h           |   2 +-
>  reftable/writer.c                    |   9 ++-
>  7 files changed, 136 insertions(+), 19 deletions(-)
>
>
> base-commit: 45fe28c951c3e70666ee4ef8379772851a8e4d32
> Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-1185%2Fhanwen%2Fobj-id-len-v3
> Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-1185/hanwen/obj-id-len-v3
> Pull-Request: https://github.com/git/git/pull/1185
>
> Range-diff vs v2:
>
>  1:  80d29e8f269 = 1:  80d29e8f269 Documentation: object_id_len goes up to 31
>  2:  4c1a19fc4ae ! 2:  68e7bc32ff8 reftable: reject 0 object_id_len
>      @@ Commit message
>           reftable: reject 0 object_id_len
>       
>           The spec says 2 <= object_id_len <= 31. We are lenient and allow 1,
>      -    but we forbid 0, so we can we can be sure that we never read a
>      -    0-length key.
>      +    but we forbid 0, so we can be sure that we never read a 0-length key.
>       
>           Signed-off-by: Han-Wen Nienhuys <hanwen@google.com>
>       
>  3:  600b115f8b1 = 3:  8b5aebdb07a reftable: add a test that verifies that writing empty keys fails
>  4:  ba036ee8543 ! 4:  a9372cacd1b reftable: avoid writing empty keys at the block layer
>      @@ reftable/block.c: int block_reader_first_key(struct block_reader *br, struct str
>        	if (n < 0)
>        		return n;
>       +	if (!key->len)
>      -+		return -1;
>      ++		return REFTABLE_FORMAT_ERROR;
>        
>        	return 0;
>        }
>  5:  2bd3d44ba57 = 5:  0b8a42399dd reftable: ensure that obj_id_len is >= 2 on writing
>  6:  82d36ee0e0d = 6:  bdccd969475 reftable: add test for length of disambiguating prefix
>  7:  c6ffdb3471c = 7:  72499a14e38 reftable: rename writer_stats to reftable_writer_stats
