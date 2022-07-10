Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C26B5C433EF
	for <git@archiver.kernel.org>; Sun, 10 Jul 2022 05:34:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229619AbiGJFeO (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 10 Jul 2022 01:34:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43792 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229482AbiGJFeN (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 10 Jul 2022 01:34:13 -0400
Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6BCCF14D11
        for <git@vger.kernel.org>; Sat,  9 Jul 2022 22:34:11 -0700 (PDT)
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 9D92C192BE7;
        Sun, 10 Jul 2022 01:34:10 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=cten09dP8MljJRPfFu3+g6LwuPy8qi1HtGWu8u
        OEmbo=; b=xkywNrTY9M/Wx2mQgk4qJD8ZgPvP9ICCIAeHF8gRzXy/4F84oKgwlZ
        gYIBYxGSUOzbPHY1IG03w/++fWvlQVc5KmtY4bgmDJUJfQqsXxRwbwnLqZphZIhy
        RhgVoGCnM3ChhB0ZTBT4XS0NnI9ZqA2zjqUhx4sQU2RjjWFk0Cq5M=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 95E80192BE5;
        Sun, 10 Jul 2022 01:34:10 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.83.92.57])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 49B71192BE4;
        Sun, 10 Jul 2022 01:34:07 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Siddharth Asthana <siddharthasthana31@gmail.com>
Cc:     git@vger.kernel.org, phillip.wood123@gmail.com,
        congdanhqx@gmail.com, christian.couder@gmail.com, avarab@gmail.com,
        Johannes.Schindelin@gmx.de, johncai86@gmail.com
Subject: Re: [PATCH v3 0/4] Add support for mailmap in cat-file
References: <20220707161554.6900-1-siddharthasthana31@gmail.com>
        <20220709154149.165524-1-siddharthasthana31@gmail.com>
Date:   Sat, 09 Jul 2022 22:34:06 -0700
In-Reply-To: <20220709154149.165524-1-siddharthasthana31@gmail.com> (Siddharth
        Asthana's message of "Sat, 9 Jul 2022 21:11:45 +0530")
Message-ID: <xmqqv8s5sf8x.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: EADD780A-0011-11ED-8FAE-CBA7845BAAA9-77302942!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Siddharth Asthana <siddharthasthana31@gmail.com> writes:

> = Patch Organization
>
> - The first patch improves the commit_rewrite_person() by restricting it 
>   to traverse only through the header part of the commit object buffer.
>   It also adds an argument called headers which the callers can pass. 
>   The function will replace idents only on these  passed headers. 
>   Thus, the caller won't have to make repeated calls to the function.
> - The second patch moves commit_rewrite_person() to ident.c to expose it
>   as a public function so that it can be used to replace idents in the
>   headers of desired objects.
> - The third patch renames commit_rewrite_person() to a name which
>   describes its functionality clearly. It is renamed to
>   apply_mailmap_to_header().
> - The last patch adds mailmap support to the git cat-file command. It
>   adds the required documentation and tests as well.
>
> Changes in v3:
> - The decl-after-statement warnings have been fixed in all the patches.
> - In commit_rewrite_person(), the data type of linelen and i variables
>   have been changed from int to size_t.
> - The return type of replace_idents_using_mailmap() function, size_t,
>   has been explicitly typecasted to unsigned long using the
>   cast_size_t_to_ulong() helper method.

https://github.com/git/git/actions/runs/2642867380 seems to tell us
that tests added by this series are broken on Windows.  I am not
sure what exactly in this series depends on being LF-only system,
but the symptom makes me suspect that is the cause of the problem.

