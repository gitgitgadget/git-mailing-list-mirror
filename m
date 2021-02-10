Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A493C433DB
	for <git@archiver.kernel.org>; Wed, 10 Feb 2021 22:07:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5A5EE64E6B
	for <git@archiver.kernel.org>; Wed, 10 Feb 2021 22:07:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232894AbhBJWHu (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 10 Feb 2021 17:07:50 -0500
Received: from pb-smtp21.pobox.com ([173.228.157.53]:56723 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233035AbhBJWH1 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 10 Feb 2021 17:07:27 -0500
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 19A5811630F;
        Wed, 10 Feb 2021 17:06:44 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=jS0GURPuHVr7
        slIR+5lyPJRR858=; b=Tv+21j1sl5bEgO6wAp5tYxfBm3gISLko0Es5TE7on/7x
        mgqsyZxKhVGLaSVf+cchOpAcZcMCH3p2EnLLI4AfF5A9rKA8u8GRWJIATO+ld9k3
        +FDmplvNLtjn7oQIMBAMBQzzoyyCGsgNeiF9cVLt9RSXhAGZr1a4Zz6qliEuWM0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=bxlWfD
        Sqt6WYqvYbFRqbpO/CQ2nZfQfWAX28tOHzoGpuUy1UrVO4ZRTa1wbcD8ztzc3iWI
        JEpNQOZA8ap0J8ykkhSNbRPMSaQkIAJt7vhceMqr6SKKI8Ett7B3kFsT3nO0pNPU
        nWO3oJQG+MkyppROT1+umJNO1/okuS6ssNVUc=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 120E011630E;
        Wed, 10 Feb 2021 17:06:44 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 7E99111630B;
        Wed, 10 Feb 2021 17:06:41 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>,
        Jiang Xin <zhiyou.jx@alibaba-inc.com>
Subject: Re: [PATCH 01/12] test-lib: remove check_var_migration
References: <20210209214159.22815-1-avarab@gmail.com>
        <20210209214159.22815-2-avarab@gmail.com>
Date:   Wed, 10 Feb 2021 14:06:39 -0800
In-Reply-To: <20210209214159.22815-2-avarab@gmail.com> (=?utf-8?B?IsOGdmFy?=
 =?utf-8?B?IEFybmZqw7Zyw7A=?=
        Bjarmason"'s message of "Tue, 9 Feb 2021 22:41:48 +0100")
Message-ID: <xmqqa6sb1ssw.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1.90 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 41348394-6BEC-11EB-9C52-D609E328BF65-77302942!pb-smtp21.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason  <avarab@gmail.com> writes:

> Remove the check_var_migration() migration helper. This was added back
> in [1], [2] and [3] to warn users to migrate from e.g. the
> "GIT_FSMONITOR_TEST" name to "GIT_TEST_FSMONITOR".
>
> I daresay that having been warning about this since late 2018 (or
> v2.20.0) was sufficient time to give everyone interested a heads-up
> about moving to the new names.

As this is not end-user facing backward-compatibility issue, I am
perfectly fine with the abbreviated schedule.

Queued.

