Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B3CB8207BD
	for <e@80x24.org>; Mon, 24 Apr 2017 01:18:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1163985AbdDXBS1 (ORCPT <rfc822;e@80x24.org>);
        Sun, 23 Apr 2017 21:18:27 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:63989 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1163959AbdDXBSZ (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 23 Apr 2017 21:18:25 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 48E6E801A7;
        Sun, 23 Apr 2017 21:18:23 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=/vGSWnnci9Nh
        G0Uqc26CiZ9fdUM=; b=RWkYpyG5IKBK5isMlmIWHSErOfBd2hAO3564L6HzItT9
        F5zs5DdcZi+6Zbs5S1fGyOaF6heWimjlqfGOhQK45a6NNrpy+g68j9oFM2D9F4jQ
        VvNfDplZ5CMnc+IfmJnsLctyvfVeUkp77S12w12GWZksh9zyY5xGUHVF2twWtR0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=gKUlG8
        oqj+l7dHcS9P+9ltOHJUYnH29kLFKSi5aSdH507qsC4CT6Z4UEqhITaB6NoDtXio
        A6wRYdEOqacjyPDrrMadNdzOWNK0dB0Z+aKZl683qx36bCcivrFaXpZtku5P6wC8
        c+ocLFHY7jd+CbqcwByvJlmVhPjj1iuhO5e90=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 38351801A6;
        Sun, 23 Apr 2017 21:18:23 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 807A8801A5;
        Sun, 23 Apr 2017 21:18:22 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Michael J Gruber <git@grubix.eu>
Cc:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Jiang Xin <worldhello.net@gmail.com>,
        Lars Schneider <larsxschneider@gmail.com>
Subject: Re: [BUG] test suite broken with GETTEXT_POISON=YesPlease
References: <CACBZZX62+acvi1dpkknadTL827mtCm_QesGSZ=6+UnyeMpg8+Q@mail.gmail.com>
        <e7aed763-cf46-4d7e-1b11-0a7a65b8f496@grubix.eu>
Date:   Sun, 23 Apr 2017 18:18:21 -0700
In-Reply-To: <e7aed763-cf46-4d7e-1b11-0a7a65b8f496@grubix.eu> (Michael
        J. Gruber's message of "Fri, 21 Apr 2017 16:47:12 +0200")
Message-ID: <xmqqwpaa38o2.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1.91 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: E89A2E2A-288B-11E7-9AE6-C260AE2156B6-77302942!pb-smtp2.pobox.com
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Michael J Gruber <git@grubix.eu> writes:

> =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason venit, vidit, dixit 20.04.2017 2=
3:58:
>> As a refresh of everyone's memory (because mine needed it). This is a
>> feature I added back in 2011 when the i18n support was initially
>> added.
>>=20
>> There was concern at the time that we would inadvertently mark
>> plumbing messages for translation, particularly something in a shared
>> code path, and this was a way to hopefully smoke out those issues with
>> the test suite.
>>=20
>> However compiling with it breaks a couple of dozen tests, I stopped
>> digging when I saw some broke back in 2014.
>>=20
>> What should be done about this? I think if we're going to keep them
>> they need to be run regularly by something like Travis (Lars CC'd),
>> however empirical evidence suggests that not running them is just fine
>> too, so should we just remove support for this test mode?
>>=20
>> I don't care, but I can come up with the patch either way, but would
>> only be motivated to write the one-time fix for it if some CI system
>> is actually running them regularly, otherwise they'll just be subject
>> to bitrotting again.
>
> I use that switch when I change something that involves l10n, but
> usually I run specific tests only. To be honest: I have to make sure no=
t
> to get confused by (nor forget one of) the build flag GETTEXT_POISON an=
d
> the environment variable GIT_GETTEXT_POISON. I'm not sure I always
> tested what I meant to test...

To be quite honest, I have always felt that we are just as likely
inadvertently use test_i18ncmp when we should use test_cmp (and vice
versa) as we would mark plumbing messages with _() by mistake with
this approach, and even with constant monitoring by something like
Travis, GETTEXT_POISON may be able to catch mistakes only some of
the time (i.e. when we do not make mistakes in writing our tests).
Without constant monitoring, I agree that the mechanism does not
work well to catch our mistakes.

