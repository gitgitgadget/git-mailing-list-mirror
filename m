Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3099C28D13
	for <git@archiver.kernel.org>; Tue, 23 Aug 2022 01:09:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239084AbiHWBJu (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 22 Aug 2022 21:09:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39898 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239058AbiHWBJs (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 22 Aug 2022 21:09:48 -0400
Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC88257E00
        for <git@vger.kernel.org>; Mon, 22 Aug 2022 18:09:46 -0700 (PDT)
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id E59DA1AF0A8;
        Mon, 22 Aug 2022 21:09:45 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=hp+Eef4JV4+C
        wFXZihPHPg3J1r6yjBvXBp6jJq/qH38=; b=m32qu/JPZ7B6pdEW+nktwzZc7Y+w
        ENoaSGOrLX9gAKeO+CqeVRHoAefSQa+zOi2m1x1W8EKTfsPTmbKTOPYPUvBZd4Yu
        BpIskzs0QSSeG9+YxmUp3/TWCNCOwi5vfaH7b8biHNCmH0eyVqTD6rNBwZQHHEEc
        ZFPo5DgL+GuntpU=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id DDC611AF0A7;
        Mon, 22 Aug 2022 21:09:45 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.83.5.33])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 89EB81AF0A5;
        Mon, 22 Aug 2022 21:09:42 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH] promisor-remote: fix xcalloc() argument order
References: <20220822213408.662482-1-szeder.dev@gmail.com>
        <xmqqh7249b8d.fsf@gitster.g>
Date:   Mon, 22 Aug 2022 18:09:41 -0700
In-Reply-To: <xmqqh7249b8d.fsf@gitster.g> (Junio C. Hamano's message of "Mon,
        22 Aug 2022 15:14:58 -0700")
Message-ID: <xmqq5yijahpm.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 44EB9990-2280-11ED-A3F0-CBA7845BAAA9-77302942!pb-smtp21.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

> ...  FWIW, "make coccicheck" with what I happen to have
> notices it.

Oops, that was a serious typo.  "notices" -> "fails to notice".

> $ spatch version
> spatch version 1.1.1 compiled with OCaml version 4.13.1
> Flags passed to the configure script: --prefix=3D/usr --sysconfdir=3D/e=
tc --libdir=3D/usr/lib --enable-ocaml --enable-python --enable-opt
> OCaml scripting support: yes
> Python scripting support: yes
> Syntax of regular expressions: PCRE
>
> Anyway, the patch is correct.
>
> Thanks, will queue.
>
>> Signed-off-by: SZEDER G=C3=A1bor <szeder.dev@gmail.com>
>> ---
>>  promisor-remote.c | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/promisor-remote.c b/promisor-remote.c
>> index 5b33f88bca..68f46f5ec7 100644
>> --- a/promisor-remote.c
>> +++ b/promisor-remote.c
>> @@ -146,7 +146,7 @@ static void promisor_remote_init(struct repository=
 *r)
>>  	if (r->promisor_remote_config)
>>  		return;
>>  	config =3D r->promisor_remote_config =3D
>> -		xcalloc(sizeof(*r->promisor_remote_config), 1);
>> +		xcalloc(1, sizeof(*r->promisor_remote_config));
>>  	config->promisors_tail =3D &config->promisors;
>> =20
>>  	repo_config(r, promisor_remote_config, config);
