Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9F95C433F5
	for <git@archiver.kernel.org>; Mon, 27 Sep 2021 21:54:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 92FD160FF2
	for <git@archiver.kernel.org>; Mon, 27 Sep 2021 21:54:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237336AbhI0V4W (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 27 Sep 2021 17:56:22 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:62603 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237237AbhI0V4W (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 27 Sep 2021 17:56:22 -0400
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id DF3D9EB0BA;
        Mon, 27 Sep 2021 17:54:42 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=B4sLGc6McvWZ
        RLziHunL08zDhINYSYxmsAI1D1Cr+Sw=; b=rh7k4df75B6r02A6S6B5qmcM856Q
        4gKsFEseS4owW23BjNbohlFLMQc9odgyjHTJCUiGADfkAagYI2Y7CfL5hlNEITZd
        AnH9hQ00ATsmb3P2zzGuX9O88btNtcE+ZmgGyWh8/b8ywKIXybIqDCAi6wimISNe
        xxgSvi2bEXzEesY=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id D561BEB0B9;
        Mon, 27 Sep 2021 17:54:42 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.133.2.91])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 45A69EB0B8;
        Mon, 27 Sep 2021 17:54:42 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Jeff King <peff@peff.net>,
        Martin =?utf-8?Q?=C3=85gren?= <martin.agren@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Johannes Sixt <j6t@kdbg.org>,
        Phillip Wood <phillip.wood123@gmail.com>
Subject: Re: [PATCH v2 3/5] *.h _INIT macros: don't specify fields equal to 0
References: <cover-0.5-00000000000-20210927T003330Z-avarab@gmail.com>
        <cover-v2-0.5-00000000000-20210927T124407Z-avarab@gmail.com>
        <patch-v2-3.5-590220bbdcc-20210927T124407Z-avarab@gmail.com>
Date:   Mon, 27 Sep 2021 14:54:41 -0700
In-Reply-To: <patch-v2-3.5-590220bbdcc-20210927T124407Z-avarab@gmail.com>
        (=?utf-8?B?IsOGdmFyIEFybmZqw7Zyw7A=?= Bjarmason"'s message of "Mon, 27 Sep
 2021 14:54:26
        +0200")
Message-ID: <xmqqk0j1ofa6.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 851B5678-1FDD-11EC-97A9-CD991BBA3BAF-77302942!pb-smtp2.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason  <avarab@gmail.com> writes:

> -#define IPC_CLIENT_CONNECT_OPTIONS_INIT { \
> -	.wait_if_busy =3D 0, \
> -	.wait_if_not_found =3D 0, \
> -	.uds_disallow_chdir =3D 0, \
> -}
> +#define IPC_CLIENT_CONNECT_OPTIONS_INIT { 0 }

The original explicitly initializes the members using designated
init, and the loss somewhat feels like a temporary regression, but
as long as the new norm is

 - If there is *no* member that is initialized to non-zero value, we
   use { 0 }, and

 - Otherwise, we only explicitly initialize members to non-zero
   value using designated initializers

this conversion is perfectly fine.
