Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4A42C20323
	for <e@80x24.org>; Wed, 22 Mar 2017 19:42:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1759530AbdCVTmF (ORCPT <rfc822;e@80x24.org>);
        Wed, 22 Mar 2017 15:42:05 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:62057 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1759267AbdCVTkG (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 22 Mar 2017 15:40:06 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 78F4D7B464;
        Wed, 22 Mar 2017 15:38:44 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=fxtfeBf0hdjZjZ+ylyxLuJTuY3I=; b=jjkiDI
        1/o9S0E3oJeOsuynQ5aoicraRMQP0b50PcnXJD0xE7t4cF3dTrr6J/v2wRZQlm0z
        qZx2E1JvrvoMpQ8lms3c4UTzPFoLUvPuS6aNv4JcoUr/OdPIZZEao6y8Ws8cC0cK
        iUOS70DzgVvBRVuOzH4x1ajCag55tNnqvXZ0o=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=yCVKql4dOSxTy6G3/o7kKdRgtH/gNhW1
        X7xxzkgDw+zvFaCsLuGsYLEEu5lWbLQvOGuYinP1aQyR5uG9xYouqKl9RhlOuLs4
        G9EuaIhRWSRWpMe1ES2k2S3elpCp79Y26pB4h6m3MHC7FV5xwt0lfqFKLgDovxLR
        U6SHPB+fznw=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 71FC57B463;
        Wed, 22 Mar 2017 15:38:44 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id D6A357B462;
        Wed, 22 Mar 2017 15:38:43 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     git@jeffhostetler.com
Cc:     git@vger.kernel.org, peff@peff.net,
        Jeff Hostetler <jeffhost@microsoft.com>
Subject: Re: [PATCH 0/6] thread lazy_init_name_hash
References: <1490202865-31325-1-git-send-email-git@jeffhostetler.com>
Date:   Wed, 22 Mar 2017 12:38:42 -0700
In-Reply-To: <1490202865-31325-1-git-send-email-git@jeffhostetler.com>
        (git@jeffhostetler.com's message of "Wed, 22 Mar 2017 17:14:19 +0000")
Message-ID: <xmqqshm5je4d.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1.91 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 28B93B22-0F37-11E7-89E2-FC50AE2156B6-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

git@jeffhostetler.com writes:

> From: Jeff Hostetler <jeffhost@microsoft.com>
>
> This patch series is a performance optimization for
> lazy_init_name_hash() in name-hash.c on very large
> repositories.
>
> This change allows lazy_init_name_hash() to optionally
> use multiple threads when building the the_index.dir_hash
> and the_index.name_hash hashmaps.  The original code path
> has been preserved and is used when the repo is small or
> the system does not have sufficient CPUs.
>
> A helper command (t/helper/test-lazy-init-name-hash) was
> created to demonstrate performance differences and validate
> output.  For example, use the '-p' option to compare both
> code paths on a large repo.
>
> During our testing on the Windows source tree (3.1M
> files, 500K folders, 450MB index), this change reduced
> the runtime of lazy_init_name_hash() from 1.4 to 0.27
> seconds.
>
> This patch series replaces my earlier
>      * jh/memihash-opt (2017-02-17) 5 commits
> patch series.

Ahh.  I was scratching my head trying to remember why some of these
look so familiar.  [PATCH v2 ...] would have helped.

Thank you for an update.

>
> Jeff Hostetler (6):
>   name-hash: specify initial size for istate.dir_hash table
>   hashmap: allow memihash computation to be continued
>   hashmap: Add disallow_rehash setting
>   name-hash: perf improvement for lazy_init_name_hash
>   name-hash: add test-lazy-init-name-hash
>   name-hash: add perf test for lazy_init_name_hash
>
>  Makefile                            |   1 +
>  cache.h                             |   1 +
>  hashmap.c                           |  29 ++-
>  hashmap.h                           |  25 ++
>  name-hash.c                         | 490 +++++++++++++++++++++++++++++++++++-
>  t/helper/test-lazy-init-name-hash.c | 264 +++++++++++++++++++
>  t/perf/p0004-lazy-init-name-hash.sh |  19 ++
>  7 files changed, 820 insertions(+), 9 deletions(-)
>  create mode 100644 t/helper/test-lazy-init-name-hash.c
>  create mode 100644 t/perf/p0004-lazy-init-name-hash.sh
