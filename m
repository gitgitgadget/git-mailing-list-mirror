Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C285C07E96
	for <git@archiver.kernel.org>; Thu, 15 Jul 2021 16:29:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E8787613F0
	for <git@archiver.kernel.org>; Thu, 15 Jul 2021 16:29:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231313AbhGOQcJ (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 15 Jul 2021 12:32:09 -0400
Received: from pb-smtp21.pobox.com ([173.228.157.53]:63499 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229899AbhGOQcI (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 15 Jul 2021 12:32:08 -0400
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id EC93B136453;
        Thu, 15 Jul 2021 12:29:14 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=8Wg77fIzgXPEV2jB5TCga7J/cgsNzn9qyHhMUA
        TvaWA=; b=bdaJ5RAa+lEWZWl3R8mY5z1YCNvWGNc3lWXArOHB3iQ5L9HqsU0Gjq
        +D2jy3E5d6KsjWcIqJ2CDIV1wQRNQMKosewZhpvfXED4ELc6cWYEueDLkUUXtml3
        jJDyptrDiaS6BM6qMJj00aI6N0orgP4EdG4JkEN86YAIos0pmnmOw=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id E417A136451;
        Thu, 15 Jul 2021 12:29:14 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.3.135])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 67FCC136450;
        Thu, 15 Jul 2021 12:29:12 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Fabian Stelzer <fs@gigacodes.de>
Cc:     Fabian Stelzer via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Han-Wen Nienhuys <hanwen@google.com>,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        "Randall S. Becker" <rsbecker@nexbridge.com>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        Hans Jerry Illikainen <hji@dyntopia.com>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [PATCH v3 2/9] ssh signing: add documentation
References: <pull.1041.v2.git.git.1626092359713.gitgitgadget@gmail.com>
        <pull.1041.v3.git.git.1626264613.gitgitgadget@gmail.com>
        <2f8452f6570b1811682863441020a6e43fc556c7.1626264613.git.gitgitgadget@gmail.com>
        <xmqq35sgwtga.fsf@gitster.g>
        <cf9aaa48-ea49-e3c2-9909-486d9a3f7aac@gigacodes.de>
Date:   Thu, 15 Jul 2021 09:29:10 -0700
In-Reply-To: <cf9aaa48-ea49-e3c2-9909-486d9a3f7aac@gigacodes.de> (Fabian
        Stelzer's message of "Thu, 15 Jul 2021 10:48:29 +0200")
Message-ID: <xmqqfswftuax.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: C9D5D66E-E589-11EB-BD95-FA9E2DDBB1FC-77302942!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Fabian Stelzer <fs@gigacodes.de> writes:

>>> +gpg.ssh.keyring::
>>> ...
> maybe keeeping the name "allowedSignersFile" like its called in the
> ssh manpage will make this clearer without needing a lot of extra
> explanation?

Yup, that sounds like an excellent way to present this to our users.

> SSH has nothing compared to the gpg trust levels. Your key is either
> in the allowed signers file or it is not. However even if it is not in
> the file then the signature might still be "Good" but has no matching 
> principal to it. To be able to differentiate the two "Good" cases i
> used the existing gpg trust levels. This way if you set
> gpg.mintrustlevel = fully then the signatures with no matching key in
> the allowed signers file will fail to verify. Otherwise they will
> verify but show a message that no principal matched with this key.

Sounds sensible.  Our task is to make sure that readers (not me, who
have already been spoon-fed the answer by you just now) would reach
the above understanding by just reading what we put in the
documentation.

Thanks.
