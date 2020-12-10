Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2C7EC433FE
	for <git@archiver.kernel.org>; Thu, 10 Dec 2020 02:21:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 84B4D23A7C
	for <git@archiver.kernel.org>; Thu, 10 Dec 2020 02:21:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728517AbgLJCVl (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 9 Dec 2020 21:21:41 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:63898 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728471AbgLJCVl (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 9 Dec 2020 21:21:41 -0500
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 210278A922;
        Wed,  9 Dec 2020 21:20:53 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=4evFC8SjEavcSAqT0OQ5zyyHZbM=; b=EPapA7
        KURVDlzO7ArYv4Tw6Sjf7iMjv/mWD2yIswaJLUaBZodZWTRrKlc5DjY1RaVt6XCO
        aq459gsivyM+lG6kISuWe2O5mK+lyGM0bTj+xy/r0yObmRoypz4M74HZGBaOUhae
        AiYnYTqZBXIkaO8lv7pCw8rC6iMFLz7+30yMc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=YiNzs37EhPMTtl2oGK/2VUNduPpQrU09
        LMAeGz9wEx2aEfuQuo82lTSWlmJKd78O2npgSvonRjIMV9XIg4HBQAMlDQtC/AnN
        W5bBXO2UB3e3+Uruk8nZaJMVn0vU0ZIQL77raAApt8xf0TI6rrIvZgYO6GeM8qjP
        S6IpG7Szi+8=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 17E508A921;
        Wed,  9 Dec 2020 21:20:53 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 942ED8A920;
        Wed,  9 Dec 2020 21:20:52 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Elijah Newren <newren@gmail.com>
Subject: Re: [PATCH 3/7] diffcore-rename: rename num_create to num_targets
References: <pull.929.git.git.1607223276.gitgitgadget@gmail.com>
        <30381addc5ca9f2b5299835020716291c7fe8d68.1607223276.git.gitgitgadget@gmail.com>
Date:   Wed, 09 Dec 2020 18:20:52 -0800
In-Reply-To: <30381addc5ca9f2b5299835020716291c7fe8d68.1607223276.git.gitgitgadget@gmail.com>
        (Elijah Newren via GitGitGadget's message of "Sun, 06 Dec 2020
        02:54:32 +0000")
Message-ID: <xmqqpn3ixuyj.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 53898754-3A8E-11EB-B324-74DE23BA3BAF-77302942!pb-smtp2.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com> writes:

> From: Elijah Newren <newren@gmail.com>
>
> Files added since the base commit serve as targets for rename detection.
> While it is true that added files can be thought of as being "created"
> when they are added IF they have no pairing file that they were renamed
> from, and it is true we start out not knowing what the pairings are, it
> seems a little odd to think in terms of "file creation" when we are
> looking for "file renames".  Rename the variable to avoid this minor
> point of confusion.

This is probably subjective.  

I've always viewed the rename detection as first collecting a set of
deleted paths and a set of created paths, and then trying to find a
good mapping from the former into the latter, so I find num_create a
lot more intuitive than num_targets.

But the remaining elements in the latter set are counted in the
counter "rename_dst_nr", so we clearly are OK to call the elements
of the latter set "the destination" (of a rename), which contrasts
very well with "the source" (of a rename), which is how the deleted
paths are counted with rename_src_nr.

When doing -C and -C -C, the "source" set has not just deleted but
also the preimage of the modified paths, so "source" is a more
appropriate name than "delete".  From that point of view,
"destination" is a more appropriate name for "create" because it
contrasts well with "source".

You silently renamed num_create to num_targets in 1/7 without
justification while adding num_sources.  Perhaps we should go back
to that step and use num_destinations to match?  The result would be
using words <dst, src> that pair with each other much better than
introducing "target" to an existing mix of <create==dst, src> to
make it <target==dst, src>.

