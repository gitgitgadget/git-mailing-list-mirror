Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A786C433F5
	for <git@archiver.kernel.org>; Wed, 27 Oct 2021 23:49:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5EE7B61073
	for <git@archiver.kernel.org>; Wed, 27 Oct 2021 23:49:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229585AbhJ0XwU (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 27 Oct 2021 19:52:20 -0400
Received: from pb-smtp20.pobox.com ([173.228.157.52]:55546 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229437AbhJ0XwT (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 27 Oct 2021 19:52:19 -0400
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id BE61815B9DC;
        Wed, 27 Oct 2021 19:49:53 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=+Dh331UAKXWm
        SMmerDhX1SOTsR2hCoqaqEXpxxzbdew=; b=F347E80Mb5J/HNXN15ciLYLPoj5H
        gm7I6T9Thj0x0eVb3AzGCwcbIGjsLUMtJ7+qZSXsyPjy6jTBZXwh216qVYU0EFg3
        z+wvxekD9B9ZBkeakgQek4sUdHxojCqt3+IY4TFlqtJIOXCHb9Co7H8WSnueLJ5q
        WkmqFxsrw4ov6tE=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id B75F115B9DB;
        Wed, 27 Oct 2021 19:49:53 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.133.2.91])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 2101215B9D4;
        Wed, 27 Oct 2021 19:49:51 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Taylor Blau <me@ttaylorr.com>
Cc:     git@vger.kernel.org, avarab@gmail.com, dstolee@microsoft.com,
        peff@peff.net
Subject: Re: [PATCH v2 0/9] midx: clean up t5319 under 'SANITIZE=leak'
References: <cover.1635282024.git.me@ttaylorr.com>
Date:   Wed, 27 Oct 2021 16:49:49 -0700
In-Reply-To: <cover.1635282024.git.me@ttaylorr.com> (Taylor Blau's message of
        "Tue, 26 Oct 2021 17:01:00 -0400")
Message-ID: <xmqqv91it4de.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 937E6BAA-3780-11EC-BBC3-F327CE9DA9D6-77302942!pb-smtp20.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Taylor Blau <me@ttaylorr.com> writes:

> Here is a small-ish update to my series which makes t5319 leak-free (i.=
e., it
> passes even when Git is compiled with SANITIZE=3Dleak). It is based on
> ab/only-single-progress-at-once (so I dropped the cherry-picked patch t=
owards
> the end from =C3=86var).

The range-diff was almost unreadable, so I looked at the difference
relative to the previous tip (i.e. "git diff @{1}").  I spotted two
classes of changes, one is where and how "struct child_process" gets
cleared, the other is how midx-related filenames are released.  I
think the latter changes are improvements, and among the former, the
"write_oid() was never called, so cmd was left unused" change does
look an improvement, but I do not know about the others.

Thanks.
