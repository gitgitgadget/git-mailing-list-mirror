Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19F4BC433DB
	for <git@archiver.kernel.org>; Tue,  9 Mar 2021 20:48:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C3E956522E
	for <git@archiver.kernel.org>; Tue,  9 Mar 2021 20:48:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231467AbhCIUsW (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 9 Mar 2021 15:48:22 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:56325 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231732AbhCIUr4 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 9 Mar 2021 15:47:56 -0500
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 2E93DAB775;
        Tue,  9 Mar 2021 15:47:56 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=zS/ZwpOyyrxbKy0P7W723bqqgUQ=; b=i0Gow3
        2MnHGecP/9fV7ncDum/iMpGlSdDv4GMb8YqH1JJ242qWoXQb8/W7/aYcQlQxhC7G
        G/QmSf9RPVuxArqqvAkMBUhMvAE+I3jJ1osdJxxfHp0ECwO5zV9YlsUOCaQGfCxz
        aupAO5JJYcfd9Y6Cj2uQWCzOx31j6S8F8RaeY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=Q3QzNMN+70ZFGn850G/W69NVQXlIFUT1
        NvVRa1BAj9uWiNQSoTNk9DNKzBEI2e+g67zVwct0SAYbtJs0mUPYZ/vMXWZKg1Vn
        TOiT0IW0HUi1VWTZZWFV8WGT1bHzwLjC9f1CskFdvHOAQS/Av+fgiJ4zwlQs8XR8
        u++uoV1kMmI=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 24DD5AB773;
        Tue,  9 Mar 2021 15:47:56 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id B033EAB771;
        Tue,  9 Mar 2021 15:47:55 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Shourya Shukla <periperidip@gmail.com>
Cc:     christian.couder@gmail.com, git@vger.kernel.org,
        levraiphilippeblain@gmail.com
Subject: Re: [PATCH v2 1/1] rm: stage submodule removal from '.gitmodules'
 when using '--cached'
References: <20210218184931.83613-1-periperidip@gmail.com>
        <20210222172623.69313-1-periperidip@gmail.com>
        <20210222172623.69313-2-periperidip@gmail.com>
        <xmqqo8gb7vf9.fsf@gitster.g> <20210307164644.GA8702@konoha>
        <xmqqblbu907p.fsf@gitster.c.googlers.com>
        <20210309071324.GA14404@konoha>
Date:   Tue, 09 Mar 2021 12:47:55 -0800
In-Reply-To: <20210309071324.GA14404@konoha> (Shourya Shukla's message of
        "Tue, 9 Mar 2021 12:43:24 +0530")
Message-ID: <xmqqsg54yryc.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1.90 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: B99037F2-8118-11EB-8923-D152C8D8090B-77302942!pb-smtp1.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Shourya Shukla <periperidip@gmail.com> writes:

> Ahhh. Understood and will work on it. BTW then when does
> GITMODULES_INDEX even fulfill its purpose? Its name can confuse anyone
> into thinking what it made me think: it is the index copy of the
> gitmodules.

I do not offhand know where in our codebase we use it (I am not a
submodule person).

Perhaps get_sha1(":.gitmodules", sha1)?  Even then, I'd probably
prefer to see it spelled as

	get_sha1(":" GITMODULES_FILE, sha1)

with token concatenation.

> Is it something which is to be changed in the near future?

Sorry, I do not understand the question.
