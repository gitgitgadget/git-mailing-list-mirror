Return-Path: <SRS0=7OUv=6W=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15452C35280
	for <git@archiver.kernel.org>; Fri,  8 May 2020 01:17:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B956D208DB
	for <git@archiver.kernel.org>; Fri,  8 May 2020 01:17:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="g0NptN4r"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726948AbgEHBR3 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 7 May 2020 21:17:29 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:64871 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726495AbgEHBR2 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 7 May 2020 21:17:28 -0400
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 787A0459FF;
        Thu,  7 May 2020 21:17:26 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=ZJWchw7s+b1U
        FuGA1eEhlTrGudw=; b=g0NptN4ri3srgCcyvSkIa4SvHLXugBtysebFwmO4og/x
        zNEhyoW10e85yMibCRzB6cO3J0LXL9t7HZf4BCUGNa5eAc2MwS8914LpEwFlkv4H
        0hWITmsbzzAkNPv95gm1g528RYZe5XvkVew/FzyXkSgr6EcBC0rANvpFZzLnfvk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=e+8+so
        3ZtIaiUL9RrR3xD/CcU9fDcvR4Nb7SJeHq2/+bLOInTh5SOqC3LT8HPPYjeJKZ3j
        PxuYdRv33JT4GCI/zy2dMBG7Cl1HaZeKECxEm7O9GgUMKLbHP/0S9mgDMkrMUdy2
        zTvszEPutXdeKCvriDSD1YqrEcmSMuouG0cb8=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 70490459FE;
        Thu,  7 May 2020 21:17:26 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id ED3D8459FC;
        Thu,  7 May 2020 21:17:25 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Carlo Marcelo Arenas =?utf-8?Q?Bel=C3=B3n?= <carenas@gmail.com>
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        git@vger.kernel.org, congdanhqx@gmail.com
Subject: Re: [PATCH] t/test_lib: avoid naked bash arrays in file_lineno
References: <20200507055118.69971-1-carenas@gmail.com>
        <nycvar.QRO.7.76.6.2005072139300.56@tvgsbejvaqbjf.bet>
        <20200508005817.GA24664@Carlos-MBP>
Date:   Thu, 07 May 2020 18:17:25 -0700
In-Reply-To: <20200508005817.GA24664@Carlos-MBP> ("Carlo Marcelo Arenas
        =?utf-8?Q?Bel=C3=B3n=22's?= message of "Thu, 7 May 2020 17:58:17 -0700")
Message-ID: <xmqqpnbf1aze.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: AD61F8CA-90C9-11EA-AAD8-D1361DBA3BAF-77302942!pb-smtp2.pobox.com
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Carlo Marcelo Arenas Bel=C3=B3n <carenas@gmail.com> writes:

> On Thu, May 07, 2020 at 09:52:12PM +0200, Johannes Schindelin wrote:
>> On Wed, 6 May 2020, Carlo Marcelo Arenas Bel=C3=B3n wrote:
>> >
>> > Enclose the bash specific code inside an eval to avoid parsing error=
s
>> > and while at it, simplify the logic so that instead of traversing th=
e
>> > callstack just pop the two topmost entries that are required.
>>=20
>> I would be okay with that, but that's not what the patch does:
>
> FWIW that was the intention, but luckily Junio quickly predicted it was
> most likely buggy and so has been since made obsolete by:
>
>   https://lore.kernel.org/git/20200507175706.19986-1-carenas@gmail.com/

Heh, don't give me too much credit.  I just noticed that they cannot
be implementing the same thing, but I couldn't tell if the new
behaviour was something you two agreed to be better, and asked for a
clarification.

In any case, the "just protect with eval '' block to avoid hurting
other shells" version should be the first step.  Improving it
further is a separate topic.

Thanks.
