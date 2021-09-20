Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F17B8C433EF
	for <git@archiver.kernel.org>; Mon, 20 Sep 2021 21:30:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C7EC8611AF
	for <git@archiver.kernel.org>; Mon, 20 Sep 2021 21:30:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238343AbhITVbe (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 20 Sep 2021 17:31:34 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:65181 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239999AbhITV3c (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 20 Sep 2021 17:29:32 -0400
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 289BFF762F;
        Mon, 20 Sep 2021 17:28:04 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:message-id:mime-version:content-type
        :content-transfer-encoding; s=sasl; bh=zxZtvqwI++I8oBovOeT/qr15t
        lCR0OAZDKeiYddu/BU=; b=l7UtUacbv7Gjh4JlBE3hS2qmLcvY7liVKHs7MB2aN
        TBumi0D6Aw0FWUrI1SruK4tTKWJwpYXXnc2doLEu3UJ7jnsu8Rkplaso89dQO8Q0
        59BfspsGGua1/0VXiD6fY/lLKnTI+KnMxy0iVbPugVenC29fA0iWbkPptR7y2eaz
        o4=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 0782EF762E;
        Mon, 20 Sep 2021 17:28:04 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.133.2.91])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 4A9D8F762D;
        Mon, 20 Sep 2021 17:28:03 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Atharva Raykar <raykar.ath@gmail.com>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnI=?= =?utf-8?B?w7A=?= Bjarmason 
        <avarab@gmail.com>
Cc:     avarab@gmail.com, christian.couder@gmail.com,
        emilyshaffer@google.com, git@vger.kernel.org, jrnieder@gmail.com,
        kaartic.sivaraam@gmail.com, pc44800@gmail.com,
        periperidip@gmail.com
Subject: Re: [PATCH v2 5/8] submodule: move core cmd_update() logic to C
References: <20210907115932.36068-1-raykar.ath@gmail.com>
        <20210916103241.62376-1-raykar.ath@gmail.com>
        <20210916103241.62376-6-raykar.ath@gmail.com>
Date:   Mon, 20 Sep 2021 14:28:02 -0700
Message-ID: <xmqqk0jb9btp.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: A326061A-1A59-11EC-8C63-CD991BBA3BAF-77302942!pb-smtp2.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Atharva Raykar <raykar.ath@gmail.com> writes:

> +static int update_submodules(struct update_data *update_data)
> +{
> +	int i, res =3D 0;
> +	struct submodule_update_clone suc =3D SUBMODULE_UPDATE_CLONE_INIT;
> +
> +	update_clone_from_update_data(&suc, update_data);
> +	run_processes_parallel_tr2(suc.max_jobs, update_clone_get_next_task,
> +				   update_clone_start_failure,
> +				   update_clone_task_finished, &suc, "submodule",
> +				   "parallel/update");
> + ...

As ab/config-based-hooks-base topic from =C3=86var changes the way this
helper function gets called at 73367f2f (run-command: add stdin
callback for parallelization, 2021-09-02) and then again in 2aba2f5f
(run-command: allow capturing of collated output, 2021-09-02), this
part needs to be adjusted when the topics collide in 'seen'.

I _think_ I've resolved conflict correctly, but please double-check
the result when today's integration result is pushed out later, both
of you.

Thanks.
