Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48D92C433E0
	for <git@archiver.kernel.org>; Sun, 28 Mar 2021 06:17:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 146C5619A9
	for <git@archiver.kernel.org>; Sun, 28 Mar 2021 06:17:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229724AbhC1GNG (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 28 Mar 2021 02:13:06 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:59160 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229538AbhC1GMm (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 28 Mar 2021 02:12:42 -0400
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 7EB75AA146;
        Sun, 28 Mar 2021 02:12:41 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=ghs0mt5qR3wb
        cIf3tEpa29LYtKg=; b=jw672RoieQCVgj7mimaRtunBw0QsOS1rhrMAfAawXcMm
        uJNkohqNvexYJYWZZzluc5lTWXXXQWJ0Os81C5XZLoCK252UG/xS7P8la8SKeP23
        eGmJ+SYuCjx8K9hPkDpweNpfY5GfI7j4qPZANkQibLhQoBMMEFIf/srOCINaBvI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=ksaNXi
        J/Mw0e7+8KddY6hVPHpltPgAdGDh5aaobe7n7bMaZjB0ZBIf45jkkwPFWmLTBPrt
        QaRYu+4O0khZZWO+LtOKyVgpP/F4QWY4MC9Kt9IQk7JKhmJlMy5lpe41FF2jkwC4
        BtNqSoud4ZEdqE2MxTgdGIMjcBEG84/LVVo+I=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 67D0FAA144;
        Sun, 28 Mar 2021 02:12:41 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id C837FAA143;
        Sun, 28 Mar 2021 02:12:40 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Jeff Hostetler <jeffhost@microsoft.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Jeff King <peff@peff.net>
Subject: Re: [PATCH 4/4] usage.c: add a non-fatal bug() function to go with
 BUG()
References: <cover-0.5-00000000000-20210328T022343Z-avarab@gmail.com>
        <patch-4.5-515d146cac8-20210328T022343Z-avarab@gmail.com>
Date:   Sat, 27 Mar 2021 23:12:40 -0700
In-Reply-To: <patch-4.5-515d146cac8-20210328T022343Z-avarab@gmail.com>
 (=?utf-8?B?IsOGdmFyCUFybmZqw7Zyw7A=?= Bjarmason"'s message of "Sun, 28 Mar
 2021 04:26:03 +0200")
Message-ID: <xmqqh7kvolgn.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1.90 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 9A178BAA-8F8C-11EB-934C-74DE23BA3BAF-77302942!pb-smtp2.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason  <avarab@gmail.com> writes:

> Add a bug() function that works like error() except the message is
> prefixed with "bug:" instead of "error:".
>
> The reason this is needed is for e.g. the fsck code. If we encounter
> what we'd consider a BUG() in the middle of fsck traversal we'd still
> like to try as hard as possible to go past that object and complete
> the fsck, instead of hard dying. A follow-up commit will introduce
> such a use in object-file.c.

Reading the description above, i.e. "to go past that object", the
assumed use case seems to be to deal with a data error, not a
program bug (which is where we use BUG()---e.g. one helper function
in the fsck code detected that the caller wasn't careful enough to
vet the data it has and called it with incoherent data).  If we find
a tree entry whose mode bits implies that the object recorded in the
entry ought to be a blob, and later find out that the object turns
out to be a tree, that is a corrupt repository and the code that
detected is not buggy (and we shouldn't use BUG(), of course).

So, ... I am skeptical.  If the code is prepared to handle breakage,
we would not want to die, but then I am not sure why it has to be
different from error().
