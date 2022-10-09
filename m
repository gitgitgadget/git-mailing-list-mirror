Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57540C4332F
	for <git@archiver.kernel.org>; Sun,  9 Oct 2022 05:12:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229669AbiJIFFa (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 9 Oct 2022 01:05:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37598 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229602AbiJIFF1 (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 9 Oct 2022 01:05:27 -0400
Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64ED02B1A5
        for <git@vger.kernel.org>; Sat,  8 Oct 2022 22:05:26 -0700 (PDT)
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 7BF22151AEC;
        Sun,  9 Oct 2022 01:05:25 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=ioitVyGjKurr
        Y67Bxb8mAiO/cbDWYQDokSdPGdHBs64=; b=gNFRYduRE/+cchmy256rxhqOmfNQ
        rRb71ebPBQpFf5dN7Fmi7i0WZGSzbINk0F8FhWH+lhlFi7dvaplMjdI4znksspej
        TC6bUMoq+PIKNy9iQqewuCOQn35m4kECWtsd3vh2y2/QE7EO1NLTVPbEgFw54xyi
        aeR/mITyxya5mYE=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 747C7151AE9;
        Sun,  9 Oct 2022 01:05:25 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.83.5.33])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id DC2BE151AE8;
        Sun,  9 Oct 2022 01:05:24 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?Q?Rub=C3=A9n?= Justo <rjusto@gmail.com>
Cc:     Eric Sunshine <sunshine@sunshineco.com>,
        Git List <git@vger.kernel.org>,
        Bagas Sanjaya <bagasdotme@gmail.com>
Subject: Re: [PATCH v3] branch: description for non-existent branch errors
References: <c333cc4b-12a1-82b6-0961-1c42080dad15@gmail.com>
        <930ff836-a5c4-0e85-517d-39645f00cd31@gmail.com>
        <8d627a2c-923f-181f-a03b-15f370c4dd0f@gmail.com>
        <CAPig+cT+Yeh95p-2PgMDYz+_AxeEA72i-zLuQu11QEyWAt8kiA@mail.gmail.com>
        <7a332503-d267-6d2c-c2bd-d072411ca408@gmail.com>
Date:   Sat, 08 Oct 2022 22:05:23 -0700
In-Reply-To: <7a332503-d267-6d2c-c2bd-d072411ca408@gmail.com>
 (=?utf-8?Q?=22Rub=C3=A9n?= Justo"'s
        message of "Sat, 8 Oct 2022 10:54:12 +0200")
Message-ID: <xmqq4jwda8oc.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: FBD36B86-478F-11ED-B3A1-307A8E0A682E-77302942!pb-smtp2.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Rub=C3=A9n Justo <rjusto@gmail.com> writes:

> Thanks, I didn't know about $SQ.
>
> 	'\''$current'\'' vs $SQ$current$SQ vs ${SQ}$current${SQ}
>
> I also find ugly that escaping, but I think is harder to read and
> error prone to use $SQ here.. :-/

The ONLY case when $SQ shines is when the string that comes inside
the single-quote pair begins with a non-alnum.  $SQ$current$SQ is
semi-readable, but if the string begins with an alnum, then you'd be
forced to say ${SQ}current${SQ} (the first one must be inside braces
because you do not want to refer to a variable whose name is
SQcurrent, the second one wants to be inside braces for symmetry),
which is ugly.

The rhythm of '\'' is not so bad, once you get used to seeing them.
${SQ}...${SQ} is a bit too loud.
