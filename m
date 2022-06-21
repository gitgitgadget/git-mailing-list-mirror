Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16E89C43334
	for <git@archiver.kernel.org>; Tue, 21 Jun 2022 15:59:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353178AbiFUP7O (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 21 Jun 2022 11:59:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43400 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353443AbiFUP6k (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 21 Jun 2022 11:58:40 -0400
Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EBEA2EB7
        for <git@vger.kernel.org>; Tue, 21 Jun 2022 08:58:38 -0700 (PDT)
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 8F2E6198398;
        Tue, 21 Jun 2022 11:58:38 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=tyoVwgeZGjHf
        DpOjifjo856GSLiARsZCOdROWx62Sv4=; b=uVNAUhlZ4qSJ4RCSgLqMhGKROI3D
        hBSx10EX7m+TwIhqk+0tokkesWhpThpMYyGPAbPdMRo9SW7AczrW3R5T5VlGiWty
        OwsrTFIigYa0wMWqNoKUaz3jYMikzojbQals+jxfEn57I6neuyQMJDCRtcfrFdPg
        OawQY9nn4kfhbTI=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 871D1198397;
        Tue, 21 Jun 2022 11:58:38 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.82.80.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 9AB1719838B;
        Tue, 21 Jun 2022 11:58:34 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>
Cc:     Taylor Blau <me@ttaylorr.com>, git@vger.kernel.org,
        avarab@gmail.com, derrickstolee@github.com, jrnieder@gmail.com,
        larsxschneider@gmail.com, tytso@mit.edu
Subject: Re: [PATCH v5 16/17] builtin/gc.c: conditionally avoid pruning
 objects via loose
References: <cover.1638224692.git.me@ttaylorr.com>
        <cover.1653088640.git.me@ttaylorr.com>
        <43c14eec0762170393c5e9681c3d5ef8fa60c96c.1653088640.git.me@ttaylorr.com>
        <157741e2-cd06-9304-bb21-c67c2cbd923e@web.de>
Date:   Tue, 21 Jun 2022 08:58:33 -0700
In-Reply-To: <157741e2-cd06-9304-bb21-c67c2cbd923e@web.de> (=?utf-8?Q?=22R?=
 =?utf-8?Q?en=C3=A9?= Scharfe"'s
        message of "Sun, 19 Jun 2022 07:38:50 +0200")
Message-ID: <xmqqv8suhuty.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 01496720-F17B-11EC-8D8C-CBA7845BAAA9-77302942!pb-smtp21.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Ren=C3=A9 Scharfe <l.s.r@web.de> writes:

> Am 21.05.22 um 01:18 schrieb Taylor Blau:
>> diff --git a/Documentation/git-gc.txt b/Documentation/git-gc.txt
>> index 853967dea0..ba4e67700e 100644
>> --- a/Documentation/git-gc.txt
>> +++ b/Documentation/git-gc.txt
>> @@ -54,6 +54,11 @@ other housekeeping tasks (e.g. rerere, working tree=
s, reflog...) will
>>  be performed as well.
>>
>>
>> +--cruft::
>> +	When expiring unreachable objects, pack them separately into a
>> +	cruft pack instead of storing the loose objects as loose
>> +	objects.
>
> The last part looks tautological.  How about:
>
> --- >8 ---
> Subject: [PATCH] gc: simplify --cruft description
>
> Remove duplicate "loose objects".
>
> Signed-off-by: Ren=C3=A9 Scharfe <l.s.r@web.de>
> ---

Sounds good.  Will apply.

Thanks.

>  Documentation/git-gc.txt | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
>
> diff --git a/Documentation/git-gc.txt b/Documentation/git-gc.txt
> index ba4e67700e..0af7540a0c 100644
> --- a/Documentation/git-gc.txt
> +++ b/Documentation/git-gc.txt
> @@ -56,8 +56,7 @@ be performed as well.
>
>  --cruft::
>  	When expiring unreachable objects, pack them separately into a
> -	cruft pack instead of storing the loose objects as loose
> -	objects.
> +	cruft pack instead of storing them as loose objects.
>
>  --prune=3D<date>::
>  	Prune loose objects older than date (default is 2 weeks ago,
> --
> 2.36.1
