Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6C92CE7A81
	for <git@archiver.kernel.org>; Fri, 22 Sep 2023 22:47:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230115AbjIVWrm (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 22 Sep 2023 18:47:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32822 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230081AbjIVWrl (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 22 Sep 2023 18:47:41 -0400
Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4435BE8
        for <git@vger.kernel.org>; Fri, 22 Sep 2023 15:47:35 -0700 (PDT)
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id E7CFB2B206;
        Fri, 22 Sep 2023 18:47:34 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:in-reply-to:references:date:message-id:mime-version
        :content-type; s=sasl; bh=QbC7m/HLNCKhvz8ONb4//IZzupIyi3mnSUYApI
        Edy/o=; b=Z4z/CuFF4y7TuuSvMV52/jE66Pvp8Y3j4bZ3Ao5yRKhHTC+lq2fevj
        fuw9wsiKvslZcdvKHCRQnjl+Imoil/Tgg00Pu94YNiIehiNnh3ldoHv47uBr0Bk5
        Lqk9mSIpUE2TH7INlK+6CbTOUC4YnAPf9enpsRjQAU/Oqvc0PS4vA=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id DFD652B205;
        Fri, 22 Sep 2023 18:47:34 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.153.120])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 7254F2B203;
        Fri, 22 Sep 2023 18:47:31 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Linus Arver via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Glen Choo <glencbz@gmail.com>,
        Christian Couder <chriscool@tuxfamily.org>,
        Phillip Wood <phillip.wood123@gmail.com>,
        Linus Arver <linusa@google.com>
Subject: Re: [PATCH v3 0/9] Trailer readability cleanups
In-Reply-To: <pull.1563.v3.git.1695412245.gitgitgadget@gmail.com> (Linus Arver
        via GitGitGadget's message of "Fri, 22 Sep 2023 19:50:36 +0000")
References: <pull.1563.v2.git.1694240177.gitgitgadget@gmail.com>
        <pull.1563.v3.git.1695412245.gitgitgadget@gmail.com>
Date:   Fri, 22 Sep 2023 15:47:29 -0700
Message-ID: <xmqq8r8xyge6.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 0392EDCA-599A-11EE-9F11-A19503B9AAD1-77302942!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Linus Arver via GitGitGadget" <gitgitgadget@gmail.com> writes:

> These patches were created while digging into the trailer code to better
> understand how it works, in preparation for making the trailer.{c,h} files
> as small as possible to make them available as a library for external users.
> This series was originally created as part of [1], but are sent here
> separately because the changes here are arguably more subjective in nature.
> I think Patch 1 is the most important in this series. The others can wait,
> if folks are opposed to adding them on their own merits at this point in
> time.

Hmph, as we discussed, these changes have already been cooking in
'next' for some time:

    13211ae23f trailer: separate public from internal portion of trailer_iterator
    c2a8edf997 trailer: split process_input_file into separate pieces
    94430d03df trailer: split process_command_line_args into separate functions
    ee8c5ee08c trailer: teach find_patch_start about --no-divider
    d2be104085 trailer: rename *_DEFAULT enums to *_UNSPECIFIED
    b5e75f87b5 trailer: use offsets for trailer_start/trailer_end

and I thought we agreed that we'll park them in 'next' and do
whatever necessary fix-up on top as incremental patches?  The first
three patches in this iteration seems to be identical to the
previous round, so I can ignore them and keep the old iteration, but
the remainder of this series are replacements that are suitable when
the series was still out of 'next', but they are no longer usable
once the series is in 'next'.

I could revert and discard [4-6/6] of the previous iteration out of
'next' and have only the first three (which I thought have been
adequately reviewed without remaining issues) graduate to 'master',
if it makes it easier to fix this update on top, but I'd rather not
to encourage people to form a habit of reverting changes out of
'next'.

Thanks.
