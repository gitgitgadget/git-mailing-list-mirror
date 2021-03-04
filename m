Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85BE2C4332B
	for <git@archiver.kernel.org>; Thu,  4 Mar 2021 01:08:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 642B064E99
	for <git@archiver.kernel.org>; Thu,  4 Mar 2021 01:08:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353082AbhCDBDk (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 3 Mar 2021 20:03:40 -0500
Received: from pb-smtp21.pobox.com ([173.228.157.53]:53506 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377113AbhCDAe6 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 3 Mar 2021 19:34:58 -0500
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 12D2B10F359;
        Wed,  3 Mar 2021 19:34:17 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=pZXzUoGZONS3
        uTX7qdPknCDkklI=; b=O9+jR7tdZvuUD/WCdKYzCiCwi4dAcSa93AoNe5nEaZG8
        rdn2ObSke28eRr61zQ4GbYjEssO51DJ63/f8vmWaQmhxfKZfCdtaoVDWBzKSlMFV
        wyPsY57GqyQzm5Q86WNcQLoyIjcqRHYutnwV0o5GQ1C2fgrhBCC+Kn3yTO5vJKQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=OGt7w2
        JGLyUoLiZlcyhb6F5e9dDgSdRWsh8/6G4tb8xafoR3Sj0t0QsNMqvb/fv85dcJwi
        Rej9/ohcmCds5JF0vQOrvedcrneGOM6+4RQ+uETYIuqOBUGggA2tEKKaeJgXyYUz
        YlSyqCRMqH2nx+ZscDwISdKhWHCx4ANt3tGxk=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 0C66110F357;
        Wed,  3 Mar 2021 19:34:17 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 5321110F355;
        Wed,  3 Mar 2021 19:34:14 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Jeff King <peff@peff.net>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Carlo Marcelo Arenas =?utf-8?Q?Bel=C3=B3n?= 
        <carenas@gmail.com>
Subject: Re: [PATCH v2 00/10] grep/pcre2: memory allocation fixes
References: <20210204210556.25242-1-avarab@gmail.com>
        <20210218000728.13995-1-avarab@gmail.com>
Date:   Wed, 03 Mar 2021 16:34:12 -0800
In-Reply-To: <20210218000728.13995-1-avarab@gmail.com> (=?utf-8?B?IsOGdmFy?=
 =?utf-8?B?IEFybmZqw7Zyw7A=?=
        Bjarmason"'s message of "Thu, 18 Feb 2021 01:07:18 +0100")
Message-ID: <xmqq8s73hi4b.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1.90 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 5892A98A-7C81-11EB-990C-D609E328BF65-77302942!pb-smtp21.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason  <avarab@gmail.com> writes:

> Now based on "master", when I sent v1[1] it dependen on other
> in-flight topics of mine.

This has been in "Needs review" state for too long, so I looked at
them myself.  Aside from a few minor issues, they all made sense to
me.

Thanks.


