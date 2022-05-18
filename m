Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6BF56C433EF
	for <git@archiver.kernel.org>; Wed, 18 May 2022 16:31:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240264AbiERQbq (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 18 May 2022 12:31:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38380 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240301AbiERQbo (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 18 May 2022 12:31:44 -0400
Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1BCA73EF29
        for <git@vger.kernel.org>; Wed, 18 May 2022 09:31:34 -0700 (PDT)
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 5CC0B18BD21;
        Wed, 18 May 2022 12:30:49 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:message-id:mime-version:content-type
        :content-transfer-encoding; s=sasl; bh=ptnSN4YTfdPtmAqTcU2i8v/8k
        bBlvfzQGKZLZwt33Hw=; b=N+4ZSQ7M0DmiWgYocTEmIu0QoeojyCxzdWtjOKRUD
        2zAiNZ6ctOkt9iWC6NUL6Z6MGQxB+a6ml33JQgqMetKbPwXKUm0coydwBuvRfmNQ
        JE79rfpWzopTlnnFddIImcbBVwTDhXQMNShtCNRFF8nTYLrYppuUBkiAczM2g5Rd
        u8=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 562FB18BD1F;
        Wed, 18 May 2022 12:30:49 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.83.65.128])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id C4FEB18BD1E;
        Wed, 18 May 2022 12:30:45 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH] commit: fix "author_ident" leak
References: <cover-0.2-00000000000-20220216T081844Z-avarab@gmail.com>
        <xmqqzgjmcqlg.fsf@gitster.g>
        <220517.86fsl86z1s.gmgdl@evledraar.gmail.com>
Date:   Wed, 18 May 2022 09:30:44 -0700
Message-ID: <xmqqtu9mx0p7.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: DE4EEDDA-D6C7-11EC-BB3D-CBA7845BAAA9-77302942!pb-smtp21.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com> writes:

> But even accounting for that, I don't see what the "more maintainable"
> here refers to. The approach I suggested would s/UNLEAK/strbuf_release/
> in the 4th hunk, but otherwise be equivalent.

Judicious use of UNLEAK() has documentation value to tell readers
which use of pointer variables need to be explicitly released, and
which pointer variables can just implicitly released by going out of
scope at the end.  There are also a few other small added benefits
(they do not have to be changed when the helper needed to do the
real release changes, and not doing an explicit real release on
resources when there no need to is conceptually cleaner).  But they
are icing on the cake.

Sorry for a late reply---I go offline every other Tuesday and
yesterday was such a Tuesday.
