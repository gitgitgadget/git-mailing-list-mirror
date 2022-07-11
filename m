Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7446AC43334
	for <git@archiver.kernel.org>; Mon, 11 Jul 2022 22:53:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230435AbiGKWxF (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 11 Jul 2022 18:53:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47086 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231145AbiGKWxD (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 11 Jul 2022 18:53:03 -0400
Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B47D8691E9
        for <git@vger.kernel.org>; Mon, 11 Jul 2022 15:53:02 -0700 (PDT)
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id B8AC3136835;
        Mon, 11 Jul 2022 18:53:01 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=nTsXxP1Nn3Cu
        lUpf9TQzeEkrc8XLQCnIwfF1YfBvFTc=; b=SdazIXBNyMtjRVga/t7WfMxB7BTY
        KFjUVbUaDBcZlcl4VuCKS8B4GGuNd++ZOR2z6FirOZdzQ0nFxoYESr1z9XNrJkqj
        oUJkQVQ1FMjSNH/mUH+VdIPxctWJRAsKKddc8Whfsq5aZ4e9u1mWM0VBXphpjvMy
        eJgk0LmCGvVzKbg=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id A8461136834;
        Mon, 11 Jul 2022 18:53:01 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.83.92.57])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 75A7F136832;
        Mon, 11 Jul 2022 18:53:00 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "brian m. carlson" <sandals@crustytoothpaste.net>
Cc:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        git@vger.kernel.org, rsbecker@nexbridge.com
Subject: Re: [RFC PATCH 2/4] .clang-format: Add a BitFieldColonSpacing=None
 rule
References: <YstJl+5BPyR5RWnR@tapette.crustytoothpaste.net>
        <RFC-cover-0.4-00000000000-20220711T110019Z-avarab@gmail.com>
        <RFC-patch-2.4-cb69bfa0d0d-20220711T110019Z-avarab@gmail.com>
        <YsynY24oV47q7YxU@tapette.crustytoothpaste.net>
Date:   Mon, 11 Jul 2022 15:52:59 -0700
In-Reply-To: <YsynY24oV47q7YxU@tapette.crustytoothpaste.net> (brian
        m. carlson's message of "Mon, 11 Jul 2022 22:42:43 +0000")
Message-ID: <xmqqbktvl0s4.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 36C06308-016C-11ED-96E4-CB998F0A682E-77302942!pb-smtp2.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"brian m. carlson" <sandals@crustytoothpaste.net> writes:

> On 2022-07-11 at 11:37:26, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason wrote=
:
>> Formatting bitfield as "unsigned foo:1" is the usual style in this
>> project, not "unsigned foo : 1", which clang-format will use by
>> default.
>>=20
>> Before & after this change running "make style-all-diff-apply" will
>> yield:
>>=20
>> 	582 files changed, 32029 insertions(+), 29794 deletions(-)
>> 	579 files changed, 32065 insertions(+), 29818 deletions(-)
>>=20
>> However this highlights a major limitation in this approach, because
>> clang-format v12 or newer is required for this rule, but that version
>> was only released in April 2021.
>
> This isn't supported on Debian stable, which has clang 11.  I think we
> should expect that to be a viable development target here, and I know
> it's what some Git developers actually use.
>
> I think for now we should drop this patch, and we can reconsider it in
> the future.

Earlier, somebody said "things that are not explicitly spelled out
in the guidelines, pick the more prevailing style", but I wonder
which one between "unsigned foo:1" and "unsigned foo : 1" is more
common in the current code.

Also, I am a bit curious why nobody has brought up the checkpatch
script we can borrow from the Linux kernel project.  I used to check
incoming patches before applying them and it was fairly effective in
catching malformed code.
