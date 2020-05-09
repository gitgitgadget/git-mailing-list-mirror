Return-Path: <SRS0=Fs4s=6X=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD206C28CBC
	for <git@archiver.kernel.org>; Sat,  9 May 2020 16:51:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8420321582
	for <git@archiver.kernel.org>; Sat,  9 May 2020 16:51:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="T+PGfZko"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728058AbgEIQvP (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 9 May 2020 12:51:15 -0400
Received: from pb-smtp20.pobox.com ([173.228.157.52]:57872 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727810AbgEIQvP (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 9 May 2020 12:51:15 -0400
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 48E97DF62E;
        Sat,  9 May 2020 12:51:13 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=tuWlUlT1QaZKHQbeV7dHal1DfJk=; b=T+PGfZ
        koRdn8SIpL4MM4wr9Z4BaHwjSXHyLQ3Zs3qLuqh43lmKgKYuCYb+UP8wYwIE+p+G
        uIGfIP9HXJ0ppUMccHQQiGFhuJmUClMJ+fJSsRQuEGZnrV2CUDz0+Vpan8yTPREB
        jB8BPt/9+FeL4YV3OYC+Vs1MbyFww3sb1eoU4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=SRHBRwqy3HSkC/59qx/KBFmN4oAlbDu2
        cWlAKO/JJGzSwhTZHPhFKIt9VELzGKgRE9TS/lhA3+TXkyP/XFF7Mb5nq4iEDnsi
        LggBBL77Q6Yrfstsypveun7wtgAtDRlJyJsXZ6wsSTutFG9QdO/6Jyi5f6OX/OTn
        vIHzRc4yzIM=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 410A0DF62D;
        Sat,  9 May 2020 12:51:13 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 8811FDF62B;
        Sat,  9 May 2020 12:51:10 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Son Luong Ngoc via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Son Luong Ngoc <sluongng@gmail.com>
Subject: Re: [PATCH v3 1/3] midx: teach "git multi-pack-index repack" honor "git repack" configurations
References: <pull.626.v2.git.1588758194.gitgitgadget@gmail.com>
        <pull.626.v3.git.1589034270.gitgitgadget@gmail.com>
        <a925307d4c57506f5236e60dc1390998e186cf26.1589034270.git.gitgitgadget@gmail.com>
Date:   Sat, 09 May 2020 09:51:08 -0700
In-Reply-To: <a925307d4c57506f5236e60dc1390998e186cf26.1589034270.git.gitgitgadget@gmail.com>
        (Son Luong Ngoc via GitGitGadget's message of "Sat, 09 May 2020
        14:24:28 +0000")
Message-ID: <xmqq7dxlvypv.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 490C330C-9215-11EA-9183-B0405B776F7B-77302942!pb-smtp20.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Son Luong Ngoc via GitGitGadget" <gitgitgadget@gmail.com> writes:

> From: Son Luong Ngoc <sluongng@gmail.com>
>
> Previously, when the "repack" subcommand of "git multi-pack-index" command
> creates new packfile(s), it does not call the "git repack" command but
> instead directly calls the "git pack-objects" command, and the
> configuration variables meant for the "git repack" command, like
> "repack.usedaeltabaseoffset", are ignored.

When we talk about the current state of the code (i.e. before
applying this patch), we do not say "previously".  It's not like you
are complaining about a recent breakage, e.g. "previously X worked
like this but since change Y, it instead works like that, which
breaks Z".

> This patch ensured "git multi-pack-index" checks the configuration
> variables used by "git repack" and passes the corresponding options to
> the underlying "git pack-objects" command.

We write this part in imperative mood, as if we are giving an order
to the codebase to "become like so".  We do not give an observation
about the patch or the author ("This patch does X, this patch also
does Y", "I do X, I do Y").

Taking these two together, perhaps like:

    When the "repack" subcommand of "git multi-pack-index" command
    creates new packfile(s), it does not call the "git repack"
    command but instead directly calls the "git pack-objects"
    command, and the configuration variables meant for the "git
    repack" command, like "repack.usedaeltabaseoffset", are ignored.

    Check the configuration variables used by "git repack" ourselves
    in "git multi-index-pack" and pass the corresponding options to
    underlying "git pack-objects".

> Note that `repack.writeBitmaps` configuration is ignored, as the
> pack bitmap facility is useful only with a single packfile.

Good.

> +	int delta_base_offset = 1;
> +	int use_delta_islands = 0;

These give the default values for two configurations and over there
builtin/repack.c has these lines:

    17	static int delta_base_offset = 1;
    18	static int pack_kept_objects = -1;
    19	static int write_bitmaps = -1;
    20	static int use_delta_islands;
    21	static char *packdir, *packtmp;

When somebody is tempted to update these to change the default used
by "git repack", it should be easy to notice that such a change must
be accompanied by a matching change to the lines you are introducing
in this patch, or we'll be out of sync.

The easiest way to avoid such a problem may be to stop bypassing
"git repack" and calling "pack-objects" ourselves.  That is the
reason why the configuration variables honored by "git repack" are
ignored in this codepath in the first place.  But that is not the
approach we are taking, so we need a reasonable way to tell those
who update this file and builtin/repack.c to make matching changes.
At the very least, perhaps we should give a comment above these two
lines in this file, e.g.

	/*
	 * when updating the default for these configuration
	 * variables in builtin/repack.c, these must be adjusted
	 * to match.
	 */
	int delta_base_offset = 1;
	int use_delta_islands = 0;

or something like that.

With that, the rest of the patch makes sense.

Thanks.
