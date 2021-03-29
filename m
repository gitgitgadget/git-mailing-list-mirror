Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11597C433E0
	for <git@archiver.kernel.org>; Mon, 29 Mar 2021 22:34:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C92166198E
	for <git@archiver.kernel.org>; Mon, 29 Mar 2021 22:34:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231594AbhC2WeV (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 29 Mar 2021 18:34:21 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:59322 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233298AbhC2Wb4 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 29 Mar 2021 18:31:56 -0400
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id B36EDB8F24;
        Mon, 29 Mar 2021 18:31:54 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=9STbSpXt4gS6
        /ZJ154zsVTbzQLM=; b=uFYpbVI6zVJZw5cRk2/l8Wbo4tIb6gc7HKthcaUqRfk8
        xYUiilirJ6P9LSmvOPlLtXXnWyt0fJYkspWEwq8hFCpIGjV53mldAJsSpSJofQ5w
        784L5cJagHLwcvDLlJOSjHAa2wrAenKDkQ6Mtkng8gCVW+nhI0VmgRUC5ny2PGc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=dvui7w
        oKP2eIW6pAx1eg5HasOmLZRFFRsAdbw75SSyli9Mf88gV0pnwkrOREk6W7/VfAz/
        xmDxDyljZnZrAgxJCfwEpnStIHF8hn5SBDJL9kSHvww18JMO4Jz0XAumwzE7HePe
        ysyT1dNKjL85nXV/YXdaVVGFdA+x73WzuBhgE=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id AB19FB8F23;
        Mon, 29 Mar 2021 18:31:54 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 361E3B8F21;
        Mon, 29 Mar 2021 18:31:54 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Jeff King <peff@peff.net>,
        Andreas =?utf-8?Q?F?= =?utf-8?Q?=C3=A4rber?= 
        <andreas.faerber@web.de>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH 4/6] Makefile: make INSTALL_SYMLINKS affect the build
 directory
References: <cover-0.6-00000000000-20210329T161723Z-avarab@gmail.com>
        <cover-0.7-00000000000-20210329T162327Z-avarab@gmail.com>
        <patch-4.7-1089ca3d184-20210329T162327Z-avarab@gmail.com>
Date:   Mon, 29 Mar 2021 15:31:53 -0700
In-Reply-To: <patch-4.7-1089ca3d184-20210329T162327Z-avarab@gmail.com>
 (=?utf-8?B?IsOGdmFyCUFybmZqw7Zyw7A=?= Bjarmason"'s message of "Mon, 29 Mar
 2021 18:31:42 +0200")
Message-ID: <xmqqo8f1h9ra.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1.90 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 904324BA-90DE-11EB-9529-74DE23BA3BAF-77302942!pb-smtp2.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason  <avarab@gmail.com> writes:

> Change the INSTALL_SYMLINKS flag to also affect whether a built-in
> like e.g. git-fetch is a symlink or not in git's build directory.
>
> This doesn't matter for anything other than as an aid to developers
> who might be confused about their build not matching the installation,
> and who'd like to be reminded that e.g. "git-fetch" is a built-in by
> "ls" coloring appropriately it as a symlink.

I am not with the cause and hence not very interested in this
"feature".

When there are multiple possible reasons why something is made into
a symbolic link, the symlink-ness in the build directory cannot
fundamentally mirror the symlink-ness in the installation, no?
"git" and "git-fetch" may be in the same directory in the build, but
their installation directories are different, so they may be
hardlinked in the former but they may be turned into symlinks in the
latter.

