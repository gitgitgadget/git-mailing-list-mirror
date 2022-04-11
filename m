Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0DD78C433EF
	for <git@archiver.kernel.org>; Mon, 11 Apr 2022 23:07:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229898AbiDKXJh (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 11 Apr 2022 19:09:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60316 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229540AbiDKXJf (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 11 Apr 2022 19:09:35 -0400
Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 115C111C18
        for <git@vger.kernel.org>; Mon, 11 Apr 2022 16:07:19 -0700 (PDT)
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 0FEAD11272D;
        Mon, 11 Apr 2022 19:07:19 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=kQXa+V7S6g7X
        We49m1OlwtvIKVNSNB0yHN8/s+yIKoY=; b=JfmU5/u/gEr5CKnoMtw5qKVgaN0H
        1wOaKy6YRMmve0J7QX03TpmCGLxRo+UtB3JNGVU2N+T13tBIFgSYxlp540aKyddD
        Oib1aycfE9Aj1aBYGb02q8VNChCZG0ggyUNv7kBF3DJmzRjdoI2AC/YK7wtXc0WO
        79+q+3W3UsC3wTc=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id E0DEE11272C;
        Mon, 11 Apr 2022 19:07:18 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.185.214.157])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 34BFB11272B;
        Mon, 11 Apr 2022 19:07:18 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     Phillip Wood via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Elia Pinto <gitter.spiros@gmail.com>,
        Phillip Wood <phillip.wood@dunelm.org.uk>
Subject: Re: [PATCH] tests: make SANITIZE=address imply TEST_NO_MALLOC_CHECK
References: <pull.1210.git.1649507317350.gitgitgadget@gmail.com>
        <220411.86bkx7i8qi.gmgdl@evledraar.gmail.com>
Date:   Mon, 11 Apr 2022 16:07:17 -0700
In-Reply-To: <220411.86bkx7i8qi.gmgdl@evledraar.gmail.com> (=?utf-8?B?IsOG?=
 =?utf-8?B?dmFyIEFybmZqw7Zyw7A=?=
        Bjarmason"'s message of "Mon, 11 Apr 2022 23:50:11 +0200")
Message-ID: <xmqqk0bvfcd6.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 2268E3F2-B9EC-11EC-8627-CB998F0A682E-77302942!pb-smtp2.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com> writes:

> I wonder why we have to justify that we'll only turn on
> TEST_NO_MALLOC_CHECK if it's SANITIZE=3Daddress.
>
> I.e. we also have SANITIZE=3Dundefined, wouldn't it be more future-proo=
f
> to just say that these analysis options are mutually exclusive by
> default?

Given that the SANITIZE mechanism itself allows more than one to be
requested at the same time, it is unclear to me why other checks
like undefined needs to exclude checks done by other mechanisms like
MALLOC_CHECK_ by default.  If I correctly read under-the-three-dash
commentary Phillip wrote, it's not like that use of MALLOC_CHECK_
inherently interferes with the way SANITIZE=3Dundefined wants to work,
no?

