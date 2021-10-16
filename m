Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D8CBC433EF
	for <git@archiver.kernel.org>; Sat, 16 Oct 2021 18:04:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5BB6F6115C
	for <git@archiver.kernel.org>; Sat, 16 Oct 2021 18:04:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244485AbhJPSGQ (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 16 Oct 2021 14:06:16 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:58715 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234167AbhJPSGO (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 16 Oct 2021 14:06:14 -0400
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 9675BDFF0A;
        Sat, 16 Oct 2021 14:04:05 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=JQ2JVQda89A1
        u0ORb6xtwhcZUhgN02Fk+Uu+iZ1GePM=; b=Q/O6oW/ZQW0l84p44SHB145FmK9D
        bbWKtYswroG4v87othR/9cqp+JudFwT+csYDxxf6rbBJV270NCEzad5WEihX67K8
        tmd64MlZqtM7mUn0sYbMuVKyAUN+azx22PWZ2CioVHsUdmTggnVqajPhVG5LQ7Oi
        4JHdKT+5WXnfyD4=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 8B9D3DFF09;
        Sat, 16 Oct 2021 14:04:05 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.133.2.91])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id E2F64DFF07;
        Sat, 16 Oct 2021 14:04:04 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Phillip Wood <phillip.wood123@gmail.com>,
        =?utf-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>,
        Emily Shaffer <emilyshaffer@google.com>,
        Bagas Sanjaya <bagasdotme@gmail.com>
Subject: Re: [PATCH v2 00/13] hook.[ch]: new library to run hooks + simple
 hook conversion
References: <cover-v2-00.13-00000000000-20211015T093918Z-avarab@gmail.com>
        <xmqqbl3p4wgz.fsf@gitster.g> <874k9hecro.fsf@evledraar.gmail.com>
Date:   Sat, 16 Oct 2021 11:04:03 -0700
In-Reply-To: <874k9hecro.fsf@evledraar.gmail.com> (=?utf-8?B?IsOGdmFyIEFy?=
 =?utf-8?B?bmZqw7Zyw7A=?= Bjarmason"'s
        message of "Sat, 16 Oct 2021 07:47:04 +0200")
Message-ID: <xmqqwnmc3kz0.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 733F7E70-2EAB-11EC-AF09-62A2C8D8090B-77302942!pb-smtp1.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com> writes:

> I haven't looked into worktree-add.sh failure (and from what Eric says
> it seems unrelated), but all the rest is due to a mismerge of
> reset.c. The diff here at the end on top of "seen" fixes it[1].

Ahh, of course.

The "update_refs()" call is what replaces the
big block that had a bit of conflict in the way how a hook is run,
where the original made a call to run_hook_le() now we set up an
opt structure and make a call to run_hooks_oneshot().  Dropping the
call to it would of course mean no hooks would be run from there X-<.

Thanks.
