Return-Path: <SRS0=TxkB=AV=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3EEAAC433E0
	for <git@archiver.kernel.org>; Fri, 10 Jul 2020 19:25:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EFBD22076A
	for <git@archiver.kernel.org>; Fri, 10 Jul 2020 19:25:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="X3C3/q+g"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727961AbgGJTZR (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 10 Jul 2020 15:25:17 -0400
Received: from pb-smtp20.pobox.com ([173.228.157.52]:58291 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726965AbgGJTZR (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 10 Jul 2020 15:25:17 -0400
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id D8A92D17C4;
        Fri, 10 Jul 2020 15:25:15 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=86jBINnjyNy/3gwFOljtUf8/Vko=; b=X3C3/q
        +gsgy9zrJAItxsECvi7cDjnpvXs5qLtACW+RTMdtHgL3TZ7JyeCRbSAZEVl5nXbM
        UORvmevA7G7sdMpew2//wjh/9/rXcuJtVeMurDc/+84KqkdDSECoV5Xc4iMfFME0
        L1NQmk8wTj+IBDhUZN8/xM7CHx2yxJGEUnsAU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=NdSRghMrN6FkLRWO9K7eRlAFSSaU5w0g
        2VvWyvdQ2ZqpHNPjRq21zHFwB8ukTgfccJLu0ivCAkFKXlFf8p/7cSiufUabwzHe
        oUAMyDNmb0oc+aplImmt1fHQXP1IXjYwqZ6doxSu0aS9Bb031RPvAdtDL2MLmXhE
        W6g3m7gCRpI=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id D09A5D17C3;
        Fri, 10 Jul 2020 15:25:15 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.196.173.25])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 0B185D17C2;
        Fri, 10 Jul 2020 15:25:12 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Han-Wen Nienhuys via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Han-Wen Nienhuys <hanwenn@gmail.com>
Subject: Re: [PATCH v2 0/3] Remove special casing for PSEUDOREF updates
References: <pull.673.git.1594056572.gitgitgadget@gmail.com>
        <pull.673.v2.git.1594329108.gitgitgadget@gmail.com>
Date:   Fri, 10 Jul 2020 12:25:11 -0700
In-Reply-To: <pull.673.v2.git.1594329108.gitgitgadget@gmail.com> (Han-Wen
        Nienhuys via GitGitGadget's message of "Thu, 09 Jul 2020 21:11:45
        +0000")
Message-ID: <xmqqwo3btboo.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 139C6C56-C2E3-11EA-B103-F0EA2EB3C613-77302942!pb-smtp20.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Han-Wen Nienhuys via GitGitGadget" <gitgitgadget@gmail.com> writes:

> This gets rid of the special casing code for pseudorefs in refs.c
>
> This is in preparation for reftable.
>
> v2
>
>  * remove special casing of non-HEAD pseudorefs; update t1400 and t1405
>    accordingly
>  * open question: should git-update-ref.txt be updated, when it talks about
>    logAllRefUpdates?

This does make writing ORIG_HEAD and friends a lot more heavyweight
that just "write a 40-byte text file on the filesystem to remember
it for a short while", and it becomes even so with the whole reflog
thing, but I think it is a good longer term direction to go.  

Others may disagree, though.

In any case, if we are changing the behaviour with these patches, we
should update the documentation.

Thanks.


