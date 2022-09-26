Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4DD2AC07E9D
	for <git@archiver.kernel.org>; Mon, 26 Sep 2022 18:19:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229899AbiIZSTu (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 26 Sep 2022 14:19:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33552 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229903AbiIZSTY (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 26 Sep 2022 14:19:24 -0400
Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6633713CDA
        for <git@vger.kernel.org>; Mon, 26 Sep 2022 11:13:02 -0700 (PDT)
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 5CC281C6249;
        Mon, 26 Sep 2022 14:13:01 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=L+UE0BLu33G6
        RwjeEK6aP4ApDQ3PgaKW+HzCcI6AgBs=; b=csZy1g0m2HcwU2DUepleZ4BIp8q9
        kbHyL4lUeOisF1WyqsyLneSdX1d6pndQ/bGWhg5NpNfnTnflJ1FMivxYlBhM6BdL
        DKwIiJ0R7vSzIuaSfavH4lFHiWGQhq5NTgL8roFGIXY0/8qB4nPtQom45hX5O/zl
        snucMB62bOIfS0A=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 567DB1C6247;
        Mon, 26 Sep 2022 14:13:01 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.83.5.33])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 2A94F1C61FD;
        Mon, 26 Sep 2022 14:12:57 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?Q?Rub=C3=A9n?= Justo <rjusto@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH] branch: description for non-existent branch errors
References: <c333cc4b-12a1-82b6-0961-1c42080dad15@gmail.com>
        <858edf12-67b1-5e2c-dd2e-3eb476530803@gmail.com>
Date:   Mon, 26 Sep 2022 11:12:55 -0700
In-Reply-To: <858edf12-67b1-5e2c-dd2e-3eb476530803@gmail.com>
 (=?utf-8?Q?=22Rub=C3=A9n?= Justo"'s
        message of "Sun, 25 Sep 2022 00:52:30 +0200")
Message-ID: <xmqqleq6ovh4.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: D9007FF4-3DC6-11ED-978D-B31D44D1D7AA-77302942!pb-smtp21.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Rub=C3=A9n Justo <rjusto@gmail.com> writes:

> When the repository does not yet has commits, some errors describe that

"has" -> "have".

>  builtin/branch.c | 14 ++++++++++++--
>  1 file changed, 12 insertions(+), 2 deletions(-)

Tests to protect the new behaviour from getting broken by future
developers are missing.

> diff --git a/builtin/branch.c b/builtin/branch.c
> index 55cd9a6e99..5ca35064f3 100644
> --- a/builtin/branch.c
> +++ b/builtin/branch.c
> @@ -538,6 +538,13 @@ static void copy_or_rename_branch(const char *oldn=
ame, const char *newname, int
>  			die(_("Invalid branch name: '%s'"), oldname);
>  	}
> =20
> +	if (copy && !ref_exists(oldref.buf)) {
> +		if (!strcmp(head, oldname))
> +			die(_("No commit on branch '%s' yet."), oldname);
> +		else
> +			die(_("No branch named '%s'."), oldname);
> +	}

Let's not make it worse by starting the die() message with capital
letters, even though the existing "git branch" error messages are
already mixture that they need to be cleaned up later.

Thanks.
