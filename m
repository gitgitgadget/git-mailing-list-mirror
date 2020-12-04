Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57349C433FE
	for <git@archiver.kernel.org>; Fri,  4 Dec 2020 20:19:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 16E9D22CA0
	for <git@archiver.kernel.org>; Fri,  4 Dec 2020 20:19:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728708AbgLDUSr (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 4 Dec 2020 15:18:47 -0500
Received: from pb-smtp21.pobox.com ([173.228.157.53]:53654 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728124AbgLDUSq (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 4 Dec 2020 15:18:46 -0500
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id B1C1911B1AC;
        Fri,  4 Dec 2020 15:18:04 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=Ta5Ot2Z/L0br
        E1Gpy7MlGO5dtWI=; b=mk/OFJtxynIKB2bMm8zUud3zITQRcuCQeBswMmvAEDce
        LIFhGxp2w83mGQR5Y0GO4ecQWspcYydvaFRQjyopTlGe0K8IocOqD6Ew9wTCXYrP
        sV2K01xe/+ZwBYXCFP6WfzdlxkY6/Kyg7m4hW7c5bh0YLbbK5ONEJLwgREd4nHI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=HpxaWl
        jqDvb8GOOEnF52j1xYhWV7uaMUpQ63tR5LMWVkd5S8RbUpsO+p/68KqHv2/bToIf
        4h02nIzf8t/IdF17btB5NIrIOVIMwuyHj0Nwws2A5OhQo1r3+7X5+WiqiCMmyPj6
        4y397MN/VNeKl+JKnklUnCTZAhl3IJV8xpZVA=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id A936111B1AB;
        Fri,  4 Dec 2020 15:18:04 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 8D1EC11B1A5;
        Fri,  4 Dec 2020 15:18:01 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Derrick Stolee <stolee@gmail.com>
Cc:     Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>,
        Abhishek Kumar <abhishekkumar8222@gmail.com>,
        git@vger.kernel.org, szeder.dev@gmail.com, me@ttaylorr.com,
        Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee <dstolee@microsoft.com>,
        =?utf-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>
Subject: Re: [PATCH 13/15] chunk-format: create chunk reading API
References: <pull.804.git.1607012215.gitgitgadget@gmail.com>
        <6801e231f7414444a272f2ea87dcc6f60f29e25a.1607012215.git.gitgitgadget@gmail.com>
        <xmqq5z5ih6v1.fsf@gitster.c.googlers.com>
        <a7be6d74-373e-e18e-b915-487bab28f438@gmail.com>
Date:   Fri, 04 Dec 2020 12:17:59 -0800
In-Reply-To: <a7be6d74-373e-e18e-b915-487bab28f438@gmail.com> (Derrick
        Stolee's message of "Fri, 4 Dec 2020 08:47:03 -0500")
Message-ID: <xmqq8sade360.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: CEED5634-366D-11EB-88D5-D609E328BF65-77302942!pb-smtp21.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Derrick Stolee <stolee@gmail.com> writes:

> On 12/3/2020 5:17 PM, Junio C Hamano wrote:
>> "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com> writes:
>>=20
>>> From: Derrick Stolee <dstolee@microsoft.com>
>>>
>>> Now that the chunk-format API has a consistent mechanism for writing
>>> file formats based on chunks, let's extend it to also parse chunk-bas=
ed
>>> files during read.
>>=20
>> Heads-up.  The generation-data work by Abhishek would conflict with
>> the way how this refactors the way the beginning offset of each
>> chunk is found.
>
> Right! I should have checked against 'seen'. Abhishek's work should
> take precedence and I can adapt on top of his topic. For now, feel
> free to keep this topic out of 'seen' while we address the worth
> of the topic (re: Ren=C3=A9's concerns).

Sure.  We may want to do [PATCH 11/15] even if the "worth of the
topic" discussion ends up negative, though.

Thanks.
