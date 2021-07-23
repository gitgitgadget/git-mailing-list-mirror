Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8F04C4338F
	for <git@archiver.kernel.org>; Fri, 23 Jul 2021 17:32:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D0CC460EE2
	for <git@archiver.kernel.org>; Fri, 23 Jul 2021 17:32:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232676AbhGWQvi (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 23 Jul 2021 12:51:38 -0400
Received: from pb-smtp20.pobox.com ([173.228.157.52]:63641 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231979AbhGWQvc (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 23 Jul 2021 12:51:32 -0400
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id AAFA81555D8;
        Fri, 23 Jul 2021 13:32:05 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=/XPKngaSaGJej0hP6ngnDG9sKab0Pl7oTHcekE
        3PCDg=; b=Knm6IJiPag57AbEeyWewYWm1im9yvYdy/rU45Cd1R9hA+mkw9gRRUa
        RUzw0F5pVAFOpVLAogv0GziCSBs0ll2sGZrp9tCLz4ucar+5pZTTfsdkGSS9HNuO
        gn1xTodeDuUgD3O4zr4HTb4Wj/NWtSxpWYDK9nQWeJNu5JdkKchOI=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id A36E81555D7;
        Fri, 23 Jul 2021 13:32:05 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.196.71.182])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id EADED1555D3;
        Fri, 23 Jul 2021 13:32:02 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Han-Wen Nienhuys via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Han-Wen Nienhuys <hanwenn@gmail.com>,
        Han-Wen Nienhuys <hanwen@google.com>
Subject: Re: [PATCH v2 08/11] t1410: mark test as REFFILES
References: <pull.1052.git.git.1626718050.gitgitgadget@gmail.com>
        <pull.1052.v2.git.git.1626989327.gitgitgadget@gmail.com>
        <f931a26de58e3cc7bb6522fab47e934aca7dc776.1626989327.git.gitgitgadget@gmail.com>
Date:   Fri, 23 Jul 2021 10:32:01 -0700
In-Reply-To: <f931a26de58e3cc7bb6522fab47e934aca7dc776.1626989327.git.gitgitgadget@gmail.com>
        (Han-Wen Nienhuys via GitGitGadget's message of "Thu, 22 Jul 2021
        21:28:44 +0000")
Message-ID: <xmqqo8atndgu.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: E48D4A16-EBDB-11EB-A16C-D5C30F5B5667-77302942!pb-smtp20.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Han-Wen Nienhuys via GitGitGadget" <gitgitgadget@gmail.com> writes:

> From: Han-Wen Nienhuys <hanwen@google.com>
>
> In reftable, one cannot take a lock on an individual ref.
>
> Signed-off-by: Han-Wen Nienhuys <hanwen@google.com>
> ---
>  t/t1410-reflog.sh | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)

Makes sense, I guess, but it makes it sound as if you can only take
a big single lock to freeze everything (as opposed to being able to
work on independent refs in parallel).  Is that what you meant to
say?

A file somewhere in .git/refs/ directory shouldn't be a way to lock
a ref in the reftable world, either, so it doubly makes sense.

> diff --git a/t/t1410-reflog.sh b/t/t1410-reflog.sh
> index 27b9080251a..d42f067ff8c 100755
> --- a/t/t1410-reflog.sh
> +++ b/t/t1410-reflog.sh
> @@ -374,7 +374,9 @@ test_expect_failure 'reflog with non-commit entries displays all entries' '
>  	test_line_count = 3 actual
>  '
>  
> -test_expect_success 'reflog expire operates on symref not referrent' '
> +# This test takes a lock on an individual ref; this is not supported in
> +# reftable.
> +test_expect_success REFFILES 'reflog expire operates on symref not referrent' '
>  	git branch --create-reflog the_symref &&
>  	git branch --create-reflog referrent &&
>  	git update-ref referrent HEAD &&
