Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C095C64E75
	for <git@archiver.kernel.org>; Wed, 25 Nov 2020 23:12:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D467420B1F
	for <git@archiver.kernel.org>; Wed, 25 Nov 2020 23:12:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="UzpAt3Qc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730491AbgKYXMO (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 25 Nov 2020 18:12:14 -0500
Received: from pb-smtp20.pobox.com ([173.228.157.52]:65076 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730060AbgKYXMN (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 25 Nov 2020 18:12:13 -0500
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id F3474FD01E;
        Wed, 25 Nov 2020 18:12:11 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=Kebh5A1Y7+s3ICSeBBboL6lxgoU=; b=UzpAt3
        QcWofFM87KQl73cWvk6H21zrKGtumt9P4XZASrcIUeM+tv9PNwizY3b7nhsp4jz5
        qW79iQp+hD9UUS6KU2+OGhN60eVxI1FCmoSenFLjzdqlH3wXIrJZn0wyxOpZZki1
        ZRBljA8dCSSL82TTZg1xw+2a2uejm2QSp6KTI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=j0IagSgO3LD7eed0aQ2qoUhXR76Y6nlN
        BJjCeMlGUvzqmOwleQi2oUdiBqyBCXjAVZZ1T+aorXQyYULdQuAerUH90Yy2M9do
        2GtVoZS/gKwGW9Az8mEF1U0LxnEXq/5lOykxtYWlyXrCGCLGkHCAJC7mvOXWP+aT
        scg3ss8iRZM=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id E0A94FD01D;
        Wed, 25 Nov 2020 18:12:11 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 29F63FD01C;
        Wed, 25 Nov 2020 18:12:09 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Randall S. Becker" <rsbecker@nexbridge.com>
Cc:     "'Han-Wen Nienhuys via GitGitGadget'" <gitgitgadget@gmail.com>,
        <git@vger.kernel.org>, "'Han-Wen Nienhuys'" <hanwenn@gmail.com>,
        "'Han-Wen Nienhuys'" <hanwen@google.com>
Subject: Re: [PATCH] move sleep_millisec to git-compat-util.h
References: <pull.922.git.git.1606245012068.gitgitgadget@gmail.com>
        <xmqq8saqifu3.fsf@gitster.c.googlers.com>
        <011801d6c2ae$dcdbaad0$96930070$@nexbridge.com>
        <xmqqy2iqf7uf.fsf@gitster.c.googlers.com>
        <018301d6c371$37bf6820$a73e3860$@nexbridge.com>
Date:   Wed, 25 Nov 2020 15:12:07 -0800
In-Reply-To: <018301d6c371$37bf6820$a73e3860$@nexbridge.com> (Randall
        S. Becker's message of "Wed, 25 Nov 2020 16:23:22 -0500")
Message-ID: <xmqqy2ipav5k.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: A47631D8-2F73-11EB-94C2-E43E2BB96649-77302942!pb-smtp20.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Randall S. Becker" <rsbecker@nexbridge.com> writes:

> I just chatted with my team and we think that sticking with the existing
> poll call is probably better in the long term. We are planning to try to get
> git to work using PUT threads - but that is a longer project for a whole
> slew of reasons. It involves pulling all or most of the FLOSS stuff out, or
> making that configurable to use FLOSS when not using threads and not using
> FLOSS when using threads. It might be useful, however, to use usleep()
> instead of poll(NULL) when threading is used on most platforms as it is a
> more effective way of context switching between threads than select().

Yeah, if usleep() is portable enough, that would probably be the
ideal direction to go.

