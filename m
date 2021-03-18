Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56C2FC433DB
	for <git@archiver.kernel.org>; Thu, 18 Mar 2021 20:57:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 25FA164EFD
	for <git@archiver.kernel.org>; Thu, 18 Mar 2021 20:57:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230391AbhCRU4m (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 18 Mar 2021 16:56:42 -0400
Received: from pb-smtp21.pobox.com ([173.228.157.53]:65342 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231191AbhCRU43 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 18 Mar 2021 16:56:29 -0400
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 6D105123860;
        Thu, 18 Mar 2021 16:56:29 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=MuX7nXswYE0oxDms/d7ruY0qqpA=; b=j8DpRK
        1Kxrr05I8LInr8w0qGmjPIMFv818l3yo5MAD+iZcM6nF4NRCI7c7sz53AqxBbPjg
        hIhQPys7sG34BcPRAzla8Kuu53h9LqP9kYq1TYMDZFfbm/6SPVquH2oX59qNRWe5
        g/Bqdc5/0KFvoVRi7y215Ph5PjPQ4lWWIHAV0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=nglqrix2E86aIF7X+mMzBTU2fAqoMZY5
        YPaCnaLfzigRRELMhZja0S45Xgjudj1ImI0vfb960N0lSPW8szco7R1EQ5n38reI
        S5ZtBt3L+susKuASwXqOjS98dN6gH9PIT/nkIJYW3952U7ROsOsz7rGL8lN57xJq
        ljPdcht8Tvs=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 4EF1412385F;
        Thu, 18 Mar 2021 16:56:29 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 65F7612385E;
        Thu, 18 Mar 2021 16:56:25 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Matheus Tavares <matheus.bernardino@usp.br>
Cc:     git@vger.kernel.org, christian.couder@gmail.com,
        git@jeffhostetler.com
Subject: Re: [PATCH 0/5] Parallel Checkout (part 2)
References: <cover.1616015337.git.matheus.bernardino@usp.br>
Date:   Thu, 18 Mar 2021 13:56:23 -0700
In-Reply-To: <cover.1616015337.git.matheus.bernardino@usp.br> (Matheus
        Tavares's message of "Wed, 17 Mar 2021 18:12:18 -0300")
Message-ID: <xmqqft0srxjc.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1.90 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 671547EA-882C-11EB-847E-D609E328BF65-77302942!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Matheus Tavares <matheus.bernardino@usp.br> writes:

> This is the next step in the parallel checkout implementation. An
> overview of the complete series can be seen at [1]. 
>
> The last patch in this series adds a design doc, so it may help to
> review it first. Also, there is no need to have any familiarity with
> part-1, as this part doesn't have any semantic dependency with that.
>
> This series is based on the merge of 'mt/parallel-checkout-part-1' and
> 'master', so that it can use the "brew cast" fix and the latest security
> fix (both from master), to run the tests. (The merge is textually
> clean, but it needs a small semantic fix: the '#include "entry.h"'
> addition in builtin/stash.c).

Let's redo part-1 on top of 'master' first without such a merge; it
has been out of 'next' so we can do so easily without wanting for
the tip of 'next' to get rewound.



>
> Parallel-checkout-specific tests will be added in part-3.
>
> [1]: https://lore.kernel.org/git/cover.1604521275.git.matheus.bernardino@usp.br/
>
> Matheus Tavares (5):
>   unpack-trees: add basic support for parallel checkout
>   parallel-checkout: make it truly parallel
>   parallel-checkout: add configuration options
>   parallel-checkout: support progress displaying
>   parallel-checkout: add design documentation
>
>  .gitignore                                    |   1 +
>  Documentation/Makefile                        |   1 +
>  Documentation/config/checkout.txt             |  21 +
>  Documentation/technical/parallel-checkout.txt | 262 ++++++++
>  Makefile                                      |   2 +
>  builtin.h                                     |   1 +
>  builtin/checkout--helper.c                    | 142 ++++
>  entry.c                                       |  17 +-
>  git.c                                         |   2 +
>  parallel-checkout.c                           | 624 ++++++++++++++++++
>  parallel-checkout.h                           | 111 ++++
>  unpack-trees.c                                |  19 +-
>  12 files changed, 1198 insertions(+), 5 deletions(-)
>  create mode 100644 Documentation/technical/parallel-checkout.txt
>  create mode 100644 builtin/checkout--helper.c
>  create mode 100644 parallel-checkout.c
>  create mode 100644 parallel-checkout.h
