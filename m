Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6CD30C433EF
	for <git@archiver.kernel.org>; Thu, 23 Sep 2021 01:23:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4E25C61130
	for <git@archiver.kernel.org>; Thu, 23 Sep 2021 01:23:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238813AbhIWBY4 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 22 Sep 2021 21:24:56 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:52980 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238177AbhIWBYz (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 22 Sep 2021 21:24:55 -0400
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 6D26FEB6B2;
        Wed, 22 Sep 2021 21:23:24 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=5fkdYy/E0fCg
        kseooAua/8zPUIuzAkHl1R/Nx0M+tgs=; b=jpAomMH/c50OS545qv4b+pFxBqnt
        0GqILoZI0NG3hzPh92FfLVPuLPl3xvjPk3UTv14jD9ffDlcTlG5ONhjFH3Az7v4Z
        AMWrhmFsRReijq1TNZvGPaI5OHHftwHvSiQDW4G2fpIyUdXDlTvVuOC/b5IwJMbn
        motL5WBEYxu5YP4=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 644D8EB6B1;
        Wed, 22 Sep 2021 21:23:24 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.133.2.91])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id B9158EB6B0;
        Wed, 22 Sep 2021 21:23:23 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     Ramsay Jones <ramsay@ramsayjones.plus.com>,
        Jeff King <peff@peff.net>, git@vger.kernel.org,
        Denton Liu <liu.denton@gmail.com>
Subject: Re: [PATCH 0/3] Makefile: make "sparse" and "hdr-check" non-.PHONY
References: <cover-0.3-00000000000-20210921T224944Z-avarab@gmail.com>
        <YUqQzn5vFDpbF5dM@coredump.intra.peff.net>
        <c13b050c-abb9-c669-b92c-930f2b43ce10@ramsayjones.plus.com>
        <YUttpgkU6eCOxMj/@coredump.intra.peff.net>
        <82c3d9fc-32ff-c38a-cb44-873af1fb83d1@ramsayjones.plus.com>
        <xmqqsfxw42c1.fsf@gitster.g> <87pmt05bww.fsf@evledraar.gmail.com>
Date:   Wed, 22 Sep 2021 18:23:22 -0700
In-Reply-To: <87pmt05bww.fsf@evledraar.gmail.com> (=?utf-8?B?IsOGdmFyIEFy?=
 =?utf-8?B?bmZqw7Zyw7A=?= Bjarmason"'s
        message of "Thu, 23 Sep 2021 03:07:04 +0200")
Message-ID: <xmqqtuic2igl.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: D86BD5CA-1C0C-11EC-A32B-CD991BBA3BAF-77302942!pb-smtp2.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com> writes:

> I've got some WIP efforts in other areas to do that for some other
> rules.
>
> The problem is that you need to "mkdir .shrapnel" to create a
> ".shrapnel/revision.sp". So you need the ".shrapnel/revision.sp" to
> depend on the ".shrapnel".
>
> Except you'll find that the na=C3=AFve implementation of that fails, si=
nce
> any file you create will bump the mtime of the containing directory, so
> you'll keep re-making ".shrapnel/revision.sp" because ".shrapnel"
> changed, because ".shrapnel/revision.sp" changed...

We depend on GNU make anyway.  Isn't its "order-only-prerequisites"
feature what you exactly want to use for the above?

