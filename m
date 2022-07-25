Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 511C5C433EF
	for <git@archiver.kernel.org>; Mon, 25 Jul 2022 18:58:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234107AbiGYS6U (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 25 Jul 2022 14:58:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60240 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229544AbiGYS6T (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 25 Jul 2022 14:58:19 -0400
Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23D17D10F
        for <git@vger.kernel.org>; Mon, 25 Jul 2022 11:58:19 -0700 (PDT)
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id C905B1A3D31;
        Mon, 25 Jul 2022 14:58:18 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=dRO3WUnZiCS/zEEJBs9vOWLq1GWx5SC3Ee+z+O
        6kuuI=; b=YS70GJ2QdsE2WBtmTjZ28MdZpH5ayVL/+EuwM0nwoNCOnKammhdT5F
        L8BJwWfWGye4L5zDWxttkwjdINwVc7M83eTM0d+nLoR3k4kRAon6YcZwo5rUxzVV
        q9COBYGmoJti4I1t1UT0ecKV9cG4OxjFDB/Gw/jvQwxu0TrEimRno=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id B81731A3D30;
        Mon, 25 Jul 2022 14:58:18 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.105.40.190])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 665591A3D2B;
        Mon, 25 Jul 2022 14:58:15 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Siddharth Asthana <siddharthasthana31@gmail.com>
Cc:     git@vger.kernel.org, phillip.wood123@gmail.com,
        congdanhqx@gmail.com, christian.couder@gmail.com, avarab@gmail.com,
        Johannes.Schindelin@gmx.de, johncai86@gmail.com
Subject: Re: [PATCH v6 0/4] Add support for mailmap in cat-file
References: <20220716074055.1786231-1-siddharthasthana31@gmail.com>
        <20220718195102.66321-1-siddharthasthana31@gmail.com>
Date:   Mon, 25 Jul 2022 11:58:14 -0700
In-Reply-To: <20220718195102.66321-1-siddharthasthana31@gmail.com> (Siddharth
        Asthana's message of "Tue, 19 Jul 2022 01:20:58 +0530")
Message-ID: <xmqqpmht3tq1.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: BD2E695A-0C4B-11ED-9190-C85A9F429DF0-77302942!pb-smtp20.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Siddharth Asthana <siddharthasthana31@gmail.com> writes:

> Changes in v6:
> - The function rewrite_ident_line() returns the difference between the
>   new and the old length of the ident line. We were not using this
>   information and instead parsing the buffer again to look for the line
>   ending. This patch set starts using that information to update the
>   buf_offset value in commit_rewrite_person().
> - This patch set also tweaks the commit_rewrite_person() so that it is
>   easier to understand and avoids unnecessary parsing of the buffer
>   wherever possible.
>
> Siddharth Asthana (4):
>   revision: improve commit_rewrite_person()
>   ident: move commit_rewrite_person() to ident.c
>   ident: rename commit_rewrite_person() to apply_mailmap_to_header()
>   cat-file: add mailmap support
>
>  Documentation/git-cat-file.txt |  6 +++
>  builtin/cat-file.c             | 43 +++++++++++++++++++-
>  cache.h                        |  6 +++
>  ident.c                        | 74 ++++++++++++++++++++++++++++++++++
>  revision.c                     | 50 ++---------------------
>  t/t4203-mailmap.sh             | 59 +++++++++++++++++++++++++++
>  6 files changed, 190 insertions(+), 48 deletions(-)

I haven't seen any comments or objections to this round.  Are people
happy about it going forward?  I am planning to merge it to 'next'
and down to 'master' soonish.

Thanks.
