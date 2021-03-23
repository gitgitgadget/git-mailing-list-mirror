Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E38BC433DB
	for <git@archiver.kernel.org>; Tue, 23 Mar 2021 22:41:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 45511619D9
	for <git@archiver.kernel.org>; Tue, 23 Mar 2021 22:41:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234158AbhCWWlE (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 23 Mar 2021 18:41:04 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:61973 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233903AbhCWWk6 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 23 Mar 2021 18:40:58 -0400
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id D7F02B7FD6;
        Tue, 23 Mar 2021 18:40:56 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=B51AcxYP80OX
        DgYl/zURb00zFSI=; b=iBoYsZATpYdYsbAgQ5AhqR+AgpbNd1yk1/2g5pVU+4PZ
        J1FeNdiQnEpa1iugwjgerjxBzkT4XKuCaWvk1VR4HyGzYmdQ+uVYIV4bNqOqfklW
        JP+bGcqOT1C1DBSXAZMJXAKukUESKoyS4Prgtpkopm9nBEjS2DbbFGZuqsfKHag=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=YbEegP
        zRyWqrVayn1eaX6UcAPdE6vJ5bk/I1CJatyXxhOKNoTasV+J/LcPICJ/bMbt70OG
        lpMJuvazfWqIjwR6M4VYpKXXLCe7eKA+2dCKtJqj9ecp9IIG71mbIZ6b+2F9ZZNf
        MfbTNrl3QH7s1PfcnaQyWU36wLT4EXVT/fLdY=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id B95FAB7FD5;
        Tue, 23 Mar 2021 18:40:56 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 3CA41B7FD4;
        Tue, 23 Mar 2021 18:40:56 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Emily Shaffer <emilyshaffer@google.com>
Cc:     git@vger.kernel.org, Robert Foss <robert.foss@linaro.org>,
        Drew DeVault <sir@cmpwn.com>,
        Rafael Aquini <aquini@redhat.com>,
        Marcelo Arenas =?utf-8?Q?Bel=C3=B3n?= <carenas@gmail.com>
Subject: Re: [PATCH v3] git-send-email: Respect core.hooksPath setting
References: <20210323162718.1143982-1-robert.foss@linaro.org>
        <patch-1.1-cc0ba73974a-20210323T173032Z-avarab@gmail.com>
Date:   Tue, 23 Mar 2021 15:40:55 -0700
In-Reply-To: <patch-1.1-cc0ba73974a-20210323T173032Z-avarab@gmail.com>
 (=?utf-8?B?IsOGdmFyCUFybmZqw7Zyw7A=?= Bjarmason"'s message of "Tue, 23 Mar
 2021 18:33:27 +0100")
Message-ID: <xmqqeeg51ojs.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1.90 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: D4DB6C50-8C28-11EB-813A-74DE23BA3BAF-77302942!pb-smtp2.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason  <avarab@gmail.com> writes:

> From: Robert Foss <robert.foss@linaro.org>
>
> get-send-email currently makes the assumption that the
> 'sendemail-validate' hook exists inside of the repository.
>
> Since the introduction of 'core.hooksPath' configuration option in
> 867ad08a261 (hooks: allow customizing where the hook directory is,
> 2016-05-04), this is no longer true.
>
> Instead of assuming a hardcoded repo relative path, query
> git for the actual path of the hooks directory.
>
> Signed-off-by: Robert Foss <robert.foss@linaro.org>
> Signed-off-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com=
>
> ---
>
> Here's a v3 that fixes various issues with Robert's v2. Range-diff &
> updated patch below.
>
> The advice I had in the v1 feedback about GetHooksPath was bad, just
> having it be a new accessor is better. It's not like anyone is calling
> this in a loop.

How urgent is this "fix".  I am wondering if Emily's "git hook"
automatically fix this for us when it comes.
