Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D894C433DB
	for <git@archiver.kernel.org>; Sun, 21 Mar 2021 16:50:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5D2D26193A
	for <git@archiver.kernel.org>; Sun, 21 Mar 2021 16:50:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230039AbhCUQts (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 21 Mar 2021 12:49:48 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:51065 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230010AbhCUQtT (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 21 Mar 2021 12:49:19 -0400
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 2E5DFA8149;
        Sun, 21 Mar 2021 12:49:19 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=I3AANeCshEPQgbkoz+s+LlKOxdQ=; b=iqspYE
        FI1zP/wAlFRACG9Jbwe6U0g96b3zriptzbsFiry/azR6Z369pechLKw9z9/5o+v8
        +pCw5cPsNHOMvlEZ2qASe+OKaWFVIteXBxlEkaYbvoOeQFx8klVzlMCJWoETwoH5
        jVNoQ9IuQnHm24JA0UQVjN/o1/v9021aZwsoI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=eO412g/VOW+9+qCLS3wupcEWqoHqOmir
        13TGU8MWf6bKV8P+PoZsrJ++wm+776UFdZ19cXCyf9XA/m0GNobhtQBg9UjvW9Sj
        Idu10Spk5TEM69g09+ge1/KcyPeMN0+DWo96Zt5rIuQRIC4Q5a9vWc7e1y827wmQ
        TAknN2359ZM=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 23849A8148;
        Sun, 21 Mar 2021 12:49:19 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id A362FA8146;
        Sun, 21 Mar 2021 12:49:18 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Bagas Sanjaya <bagasdotme@gmail.com>
Cc:     ZheNing Hu via GitGitGadget <gitgitgadget@gmail.com>,
        "Bradley M. Kuhn" <bkuhn@sfconservancy.org>,
        Brandon Casey <drafnel@gmail.com>,
        Shourya Shukla <periperidip@gmail.com>,
        Christian Couder <christian.couder@gmail.com>,
        Rafael Silva <rafaeloliveira.cs@gmail.com>,
        =?utf-8?B?xJBvw6BuIFRy4bqnbiBDw7RuZw==?= Danh 
        <congdanhqx@gmail.com>, Jeff King <peff@peff.net>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        ZheNing Hu <adlternative@gmail.com>, git@vger.kernel.org
Subject: Re: [PATCH v2 2/2] [GSOC] interpret-trailer: easy parse trailer value
References: <pull.911.git.1616251299.gitgitgadget@gmail.com>
        <pull.911.v2.git.1616317134.gitgitgadget@gmail.com>
        <8b8b236a4ffb81a8c6be3f320b878cea1d0f9d7a.1616317135.git.gitgitgadget@gmail.com>
        <1722fbad-6ff3-444f-ad3f-59e37b640fc7@gmail.com>
Date:   Sun, 21 Mar 2021 09:49:18 -0700
In-Reply-To: <1722fbad-6ff3-444f-ad3f-59e37b640fc7@gmail.com> (Bagas Sanjaya's
        message of "Sun, 21 Mar 2021 16:17:37 +0700")
Message-ID: <xmqq1rc8cv01.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1.90 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 60E4C356-8A65-11EB-B5AB-D152C8D8090B-77302942!pb-smtp1.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Bagas Sanjaya <bagasdotme@gmail.com> writes:

> will be in the trailer (for example because <email1> is primary email). So a disambiguation
> prompt should be added, something like:

No, it just should error out without going interactive.
