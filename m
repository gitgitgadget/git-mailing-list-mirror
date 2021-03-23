Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 094AAC433C1
	for <git@archiver.kernel.org>; Tue, 23 Mar 2021 20:43:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D118461574
	for <git@archiver.kernel.org>; Tue, 23 Mar 2021 20:43:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233590AbhCWUmm (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 23 Mar 2021 16:42:42 -0400
Received: from pb-smtp21.pobox.com ([173.228.157.53]:57869 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233621AbhCWUmV (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 23 Mar 2021 16:42:21 -0400
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id F25CF12D5F8;
        Tue, 23 Mar 2021 16:42:20 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=/V44e3pikQeU
        GD6QR2sg7GnY784=; b=JS8CRN0R7j1doPjSxMZgcpKRs6w9e0m41Kkn0GROQRVj
        7z3x+OQDOBsltylk0tt7zfl3TUh0BmH3XQBjxo2Xe2ZMrT/a0+7ftkkbQgIhdQuj
        jxn9uMaq2+Hwizw/PoTKN/JHdOmRfJRj0sPitMUO0CfCN+BNUOMFJkQVKCP08LM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=TtW8dD
        5MlnA6SjvUC9v/kyddXLXzYQPO1sDG+fDTm6Y6SaprlaKHwoo7rXkFB9JW2CGAla
        zZRR4zsMN7WFd6Gs02or5LA+yZfRDH3cHcd4btnhje+N56TJlz6ZcjEZMNyubXzL
        XpYgwCDifAOdEMAkTKr8IgsywpAtnoFJbhOQI=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id EAD2312D5F6;
        Tue, 23 Mar 2021 16:42:20 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 1B25612D5F5;
        Tue, 23 Mar 2021 16:42:17 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Phillip Wood <phillip.wood123@gmail.com>
Subject: Re: [PATCH] rebase: remove transitory rebase.useBuiltin setting & env
References: <20190318110152.27246-1-avarab@gmail.com>
        <patch-1.1-df026b00b67-20210323T152302Z-avarab@gmail.com>
Date:   Tue, 23 Mar 2021 13:42:15 -0700
In-Reply-To: <patch-1.1-df026b00b67-20210323T152302Z-avarab@gmail.com>
 (=?utf-8?B?IsOGdmFyCUFybmZqw7Zyw7A=?= Bjarmason"'s message of "Tue, 23 Mar
 2021 16:23:58 +0100")
Message-ID: <xmqqv99h1u1k.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1.90 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 41850232-8C18-11EB-8059-D609E328BF65-77302942!pb-smtp21.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason  <avarab@gmail.com> writes:

> It's been more than long enough for those users to get a headsup about
> this. So remove all the scaffolding that was left inplace after
> d03ebd411c6. I'm also removing the documentation entry, if anyone
> still has this left in their configuration they can do some source
> archaeology to figure out what it used to do, which makes more sense
> than exposing every git user reading the documentation to this legacy
> configuration switch.

OK, this concludes the long journey of replacing the scripted "git
rebase" with its reimplementation in C by removing the last trace
of the former.

It would be nice to have Acks from those involved in the
reimplementation effort, to celebrate the occasion.

> Signed-off-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com=
>
> ---
>  Documentation/config/rebase.txt |  7 -------
>  builtin/rebase.c                | 11 -----------
>  t/t3400-rebase.sh               | 16 ----------------
>  3 files changed, 34 deletions(-)
>
> diff --git a/Documentation/config/rebase.txt b/Documentation/config/reb=
ase.txt
> index 214f31b451f..8c979cb20f2 100644
> --- a/Documentation/config/rebase.txt
> +++ b/Documentation/config/rebase.txt
> @@ -1,10 +1,3 @@
> -rebase.useBuiltin::
> -	Unused configuration variable. Used in Git versions 2.20 and
> -	2.21 as an escape hatch to enable the legacy shellscript
> -	implementation of rebase. Now the built-in rewrite of it in C
> -	is always used. Setting this will emit a warning, to alert any
> -	remaining users that setting this now does nothing.
> -
