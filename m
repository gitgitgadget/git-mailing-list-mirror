Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7BAB5C433EF
	for <git@archiver.kernel.org>; Wed,  5 Jan 2022 23:29:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245393AbiAEX3h (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 5 Jan 2022 18:29:37 -0500
Received: from pb-smtp21.pobox.com ([173.228.157.53]:61691 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245401AbiAEX3e (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 5 Jan 2022 18:29:34 -0500
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 1D7F117C0B8;
        Wed,  5 Jan 2022 18:29:33 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=BH8QB+H4pRtDSoWxRxu7q9ZFI6IIdi0G4uwLrh
        XTsWE=; b=jWZXhbWsG8FdT86R5iW51IM+uLwZAhtdy1P1QgJjp/hmpi7WN8B4s6
        +mYIcqGO/n7IiQ07xgjmycwAh7/+Xe0/DEjRzaRL2B8+6MBAqyij/eU9GhYaB/SP
        2sCc3wVtZkzJ4LwEMztEGKVyaS/nTFONivvhgtujm6MkaDDKSpD9k=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 150EC17C0B7;
        Wed,  5 Jan 2022 18:29:33 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.133.2.91])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 7CC4717C0B6;
        Wed,  5 Jan 2022 18:29:29 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Elijah Newren <newren@gmail.com>
Cc:     Lessley Dennington <lessleydennington@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Derrick Stolee <stolee@gmail.com>
Subject: Re: Bug report - sparse-checkout ignores prefix when run in
 subdirectories
References: <29f0410e-6dfa-2e86-394d-b1fb735e7608@gmail.com>
        <xmqqsfu1g64s.fsf@gitster.g>
        <CABPp-BH5woi6KY7OBpnsS-M2EmgLHii9zs8rSwrgcPFkOAvn_A@mail.gmail.com>
Date:   Wed, 05 Jan 2022 15:29:28 -0800
In-Reply-To: <CABPp-BH5woi6KY7OBpnsS-M2EmgLHii9zs8rSwrgcPFkOAvn_A@mail.gmail.com>
        (Elijah Newren's message of "Wed, 5 Jan 2022 15:19:58 -0800")
Message-ID: <xmqqbl0pg3s7.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 5443BBF8-6E7F-11EC-877B-CBA7845BAAA9-77302942!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Elijah Newren <newren@gmail.com> writes:

> So, should "**.py" go directly into the sparse-checkout file as-is, or
> be translated to "my/current/subdir/**.py" first?
>
> Maybe translating is always fine, or maybe we want to throw an error
> when: (not using cone mode and prefix is non-empty and any patterns
> are provided).
>
> Thoughts?

Perhaps allow things like ":(glob,icase,top)frotz" to be passed and
treating them as pathspec is the most sensible way to go outside the
cone mode?  As far as I understand, the cone mode is a strict subset
that is straight-jacketed into "no patterns allowed, just concrete
directory names and nothing else" for simplicity, so it is perfectly
OK for these two to be taking different things.
