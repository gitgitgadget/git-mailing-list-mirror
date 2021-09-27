Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F363CC433F5
	for <git@archiver.kernel.org>; Mon, 27 Sep 2021 20:51:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DA65161052
	for <git@archiver.kernel.org>; Mon, 27 Sep 2021 20:51:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236955AbhI0Uws (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 27 Sep 2021 16:52:48 -0400
Received: from pb-smtp20.pobox.com ([173.228.157.52]:50839 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236868AbhI0Uwr (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 27 Sep 2021 16:52:47 -0400
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 1D53F14147A;
        Mon, 27 Sep 2021 16:51:09 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=w1TXCmFRctBtJXrbCZTsxr00wpuxYSY4oclpN/
        tWeEU=; b=UlvADuv1c+9nZdgjxMcXJbOB/nV/XU7zdxsHx+vjjbQ6FNR4+nZfdG
        tbm2A47t48Zt/Y6O16Hte17ZjPvuncQgOamCogRcsNEKM3sMo6UV60gm8tYdiurD
        3A5jkMXeAA3Z+v6FqECixxhxM97rhMC8gdVDaJu20xghX1JW03O0U=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 1495B141479;
        Mon, 27 Sep 2021 16:51:09 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.133.2.91])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 7BADE141478;
        Mon, 27 Sep 2021 16:51:06 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Elijah Newren <newren@gmail.com>
Cc:     Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, matheus.bernardino@usp.br, stolee@gmail.com,
        vdye@github.com,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Derrick Stolee <derrickstolee@github.com>
Subject: Re: [PATCH v4 00/13] Sparse-checkout: modify 'git add', 'git rm',
 and 'git mv' behavior
References: <pull.1018.v3.git.1632159937.gitgitgadget@gmail.com>
        <pull.1018.v4.git.1632497954.gitgitgadget@gmail.com>
        <CABPp-BEks6ntKbVAK2_eJCYXejSArFKEgD5v28W2K5RAHCjp0A@mail.gmail.com>
Date:   Mon, 27 Sep 2021 13:51:05 -0700
In-Reply-To: <CABPp-BEks6ntKbVAK2_eJCYXejSArFKEgD5v28W2K5RAHCjp0A@mail.gmail.com>
        (Elijah Newren's message of "Mon, 27 Sep 2021 08:51:22 -0700")
Message-ID: <xmqq35pppwsm.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: A2B9F648-1FD4-11EC-A9CA-F327CE9DA9D6-77302942!pb-smtp20.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Elijah Newren <newren@gmail.com> writes:

>>   2:  c7dedb41291 !  2:  58389edc76c t1092: behavior for adding sparse files
>>      @@ t/t1092-sparse-checkout-compatibility.sh: test_sparse_match () {
>>       + file=$1 &&
>>       + for repo in sparse-checkout sparse-index
>>       + do
>>      -+         git -C $repo status --porcelain >$repo-out &&
>>      -+         ! grep "^A  $file\$" $repo-out &&
>>      -+         ! grep "^M  $file\$" $repo-out || return 1
>>      ++         # Skip "unmerged" paths
>>      ++         git -C $repo diff --staged --diff-filter=ACDMRTXB -- "$file" >diff &&
>
> Wouldn't this be more naturally spelled as --diff-filter=u ? (Note:
> lowercase 'u', not uppercase.)  Then you could drop the comment too.

Excellent.

>
> Other than that nit, this round looks good to me.  Feel free to add a
>
> Reviewed-by: Elijah Newren <newren@gmail.com>
