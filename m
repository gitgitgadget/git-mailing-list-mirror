Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CDA0EC4338F
	for <git@archiver.kernel.org>; Wed, 28 Jul 2021 18:05:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AD7B860EE2
	for <git@archiver.kernel.org>; Wed, 28 Jul 2021 18:05:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229690AbhG1SFm (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 28 Jul 2021 14:05:42 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:61699 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229581AbhG1SFm (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 28 Jul 2021 14:05:42 -0400
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id D0F50D9412;
        Wed, 28 Jul 2021 14:05:39 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=GsZzibNP88nm
        9ZYgw8NmXzmOT0nP8ABKWeTwEl5zROY=; b=GosW4FAax8wCMpJG5iEEJrA4MymZ
        lWqvgss0dwtIXSBJ5j5wiejHaF1uLdvqZqeprC2pVnmiIGFKijyBP++4Z4QbmgrF
        XhofcwebPYIUuIfdQEZ9SMbR7EhBvAy2MMx9kqecxtNQvnLxHo2A5a8jDZPInIhL
        IR6Bw9bPOhwQi8w=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id C79C5D9410;
        Wed, 28 Jul 2021 14:05:39 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.196.71.182])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 4A796D940E;
        Wed, 28 Jul 2021 14:05:39 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Philip Oakley <philipoakley@iee.email>
Subject: Re: [PATCH v7 3/3] bundle doc: elaborate on rev<->ref restriction
References: <cover-0.3-00000000000-20210702T112254Z-avarab@gmail.com>
        <cover-0.3-0000000000-20210727T002001Z-avarab@gmail.com>
        <patch-3.3-88e7ad1cf4-20210727T002001Z-avarab@gmail.com>
Date:   Wed, 28 Jul 2021 11:05:38 -0700
In-Reply-To: <patch-3.3-88e7ad1cf4-20210727T002001Z-avarab@gmail.com>
 (=?utf-8?B?IsOGdmFyCUFybmZqw7Zyw7A=?= Bjarmason"'s message of "Tue, 27 Jul
 2021 02:24:21 +0200")
Message-ID: <xmqqa6m69uvh.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 6A738DE8-EFCE-11EB-B99F-FD8818BA3BAF-77302942!pb-smtp2.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason  <avarab@gmail.com> writes:

> +Revisions must accompanied by reference names to be packaged in a
> +bundle, since the header of the bundle is in a format similar to 'git
> +show-ref'.

As I already said in the review of v6, I do not think "header has a
format similar to show-ref" is not something we need to say so
prominently to the user.


The reason we should give readers why they must give refs while
creating a bundle, I think, is because the only way to access the
contents of the bundle is to fetch refs from it, and the refs given
to the command when the bundle was created becomes the refs that can
be fetched from the bundle.

And that is what the readers should be told here, I think.


> +More than one reference may be packaged, and more than one basis can
> +be specified.  The objects packaged are those not contained in the
> +union of the given bases.
> +
> +The 'git bundle create' command resolves the reference names for you
> +using the same rules as `git rev-parse --abbrev-ref=3Dloose`. Each
> +basis can be specified explicitly (e.g. `^master~10`), or implicitly
> +(e.g. `master~10..master`, `--since=3D10.days.ago master`).

Also, we introduced "prerequisite objects" in the previous step, but
here we say "basis".  The readers would be helped greatly if we were
a bit more consistent.

> ...
> +A revision name or a range whose right-hand-side cannot be resolved to
> +a reference is not accepted:
> +
> +----------------
> +$ git bundle create HEAD.bundle $(git rev-parse HEAD)
> +fatal: Refusing to create empty bundle.
> +$ git bundle create master-yesterday.bundle master~10..master~5
> +fatal: Refusing to create empty bundle.
> +----------------

This is a good example, as Philip already said.

Thanks.
