Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9DA4AC433E0
	for <git@archiver.kernel.org>; Mon, 22 Feb 2021 23:40:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 648E564DA5
	for <git@archiver.kernel.org>; Mon, 22 Feb 2021 23:40:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230430AbhBVXjv (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 22 Feb 2021 18:39:51 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:51417 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229996AbhBVXjv (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 22 Feb 2021 18:39:51 -0500
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id DD9D5B5EBC;
        Mon, 22 Feb 2021 18:39:08 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=eeEpLNQfTflnVak8KYTsTDJIfMw=; b=DsLe4p
        ZWumnXDNwBqx6PkUmG2QiraKLc8Mpm9OzmdPFO5533MLcVKCiWgW/48tcJ4L51mo
        j/QSY8UXnkSwR2JFgRcQW4pXtyC2PRKbNiX3Sb3vozXlA4i8ex5z9tZFK1i76QfC
        ehsULLovHxVmKbVS6jszlxnxzu+BtPdt2oMYk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=KoK3e+j8k/l5MWTyIv4yvzqWSrf05gTM
        AMumssYZG4gtm0T3E/3ljWzYkNMPbOVdOv4z3D6eimyUa7YqEDgR2KKncmJKeoZH
        83nj6JpQGaHf5o1nG20UC2t7l0jBdkAqnh+URzh2jyAbrZ1qYeYRFcvXcN0jMYgy
        BELMilYBhl8=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id D41BAB5EBA;
        Mon, 22 Feb 2021 18:39:08 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 1F8EDB5EB9;
        Mon, 22 Feb 2021 18:39:08 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Alex Henrie <alexhenrie24@gmail.com>
Cc:     git@vger.kernel.org, liu.denton@gmail.com
Subject: Re: [PATCH v2] rebase: add a config option for --no-fork-point
References: <20210220051025.4672-1-alexhenrie24@gmail.com>
Date:   Mon, 22 Feb 2021 15:39:07 -0800
In-Reply-To: <20210220051025.4672-1-alexhenrie24@gmail.com> (Alex Henrie's
        message of "Fri, 19 Feb 2021 22:10:25 -0700")
Message-ID: <xmqqr1l765b8.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1.90 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 2833D514-7567-11EB-B624-74DE23BA3BAF-77302942!pb-smtp2.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Alex Henrie <alexhenrie24@gmail.com> writes:

> +test_expect_success 'rebase.forkPoint set to false' '
> +	test_config rebase.forkPoint false &&
> +	test_rebase "G F C E D B A"
> +'
> +
> +test_expect_success 'rebase.forkPoint set to false and then to true' '
> +	test_config_global rebase.forkPoint false &&
> +	test_config rebase.forkPoint true &&
> +	test_rebase "G F E D B A"
> +'
> +
> +test_expect_success 'rebase.forkPoint set to false and command line says --fork-point' '
> +	test_config rebase.forkPoint false &&
> +	test_rebase "G F E D B A" --fork-point
> +'
> +
> +test_expect_success 'rebase.forkPoint set to true and command line says --no-fork-point' '
> +	test_config rebase.forkPoint true &&
> +	test_rebase "G F C E D B A" --no-fork-point
> +'

All of these four look dubious, as test_rebase is defined to run its
own test_expect_success in it.

