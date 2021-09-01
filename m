Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6129C432BE
	for <git@archiver.kernel.org>; Wed,  1 Sep 2021 17:44:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A8D1461026
	for <git@archiver.kernel.org>; Wed,  1 Sep 2021 17:44:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346603AbhIARpq (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 1 Sep 2021 13:45:46 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:65229 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346596AbhIARpq (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 1 Sep 2021 13:45:46 -0400
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 0FEC9E5958;
        Wed,  1 Sep 2021 13:44:48 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=+KqifIh92Hv3
        0UJbn6dkcK+5019FDAybVnloInPrzyQ=; b=MngrgmViq7YHyIkVn/qDePdNOQjx
        3vHurbw3QWbI7QIiJ0/+UTaB5iRaly6VU8I4TScSDZMrcM1z9bfDC5ee39UX7esU
        677hn92L5m93zNBhayFqrrCYeoTHHZUehrteL1Pgx/LVXRqn047af+JMEBkAQK1S
        ChMXocl5jfw9um4=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 05EC6E5957;
        Wed,  1 Sep 2021 13:44:48 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.116.162])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 7271EE5956;
        Wed,  1 Sep 2021 13:44:47 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Clemens Fruhwirth <clemens@endorphin.org>,
        Jan =?utf-8?Q?Pokorn=C3=BD?= <poki@fnusa.cz>,
        Corentin BOMPARD <corentin.bompard@etu.univ-lyon1.fr>
Subject: Re: [PATCH v4] pull, fetch: fix segfault in --set-upstream option
References: <patch-v3-1.1-68899471206-20210830T144020Z-avarab@gmail.com>
        <patch-v4-1.1-0caa9a89a86-20210831T135212Z-avarab@gmail.com>
        <xmqqfsupwose.fsf@gitster.g> <87h7f5we6q.fsf@evledraar.gmail.com>
Date:   Wed, 01 Sep 2021 10:44:46 -0700
In-Reply-To: <87h7f5we6q.fsf@evledraar.gmail.com> (=?utf-8?B?IsOGdmFyIEFy?=
 =?utf-8?B?bmZqw7Zyw7A=?= Bjarmason"'s
        message of "Tue, 31 Aug 2021 22:20:46 +0200")
Message-ID: <xmqqfsuoqjg1.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 4CC21F3C-0B4C-11EC-AE17-D601C7D8090B-77302942!pb-smtp1.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com> writes:

>> If we all agree that die() is a better action, that must be done
>> now, or it will become never once the change is released to the
>> field.
>
> Because someone might have been relying on the current behavior of
> segfaulting to stop their script? And a mere warning() would break
> things for them by having the script "work" if this patch were to make
> it into a release?

No, because someone WILL start rely on the warning() behaviour,
expecting that the "fixed" command will now run to completion
without exiting with non-zero status.  Once that happens, it will
become impossible to flip it to die().

