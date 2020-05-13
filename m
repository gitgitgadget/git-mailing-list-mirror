Return-Path: <SRS0=6HsL=63=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D25EC433E0
	for <git@archiver.kernel.org>; Wed, 13 May 2020 15:35:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8E41C206F5
	for <git@archiver.kernel.org>; Wed, 13 May 2020 15:35:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="ibHDnopa"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389299AbgEMPfl (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 13 May 2020 11:35:41 -0400
Received: from pb-smtp21.pobox.com ([173.228.157.53]:55520 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389127AbgEMPfk (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 13 May 2020 11:35:40 -0400
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 10604C41DA;
        Wed, 13 May 2020 11:35:39 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=gFasZyRp2xEDFfikds9wesJjBXA=; b=ibHDno
        pa/QV9bU4f6YqzeX8JzD27YUVSS4L103LzKCyHeo0gU2V+YYSev6u1DoXGyO2vXp
        xcQtynpEgeglb68NX1OLAf+gkvTaJkCC3YvmPlbB8JKwTHTlrIMkCdN/f/kkZmIa
        gDUSNxz1wP2ZU4BxBn4UlceBUKAmvSZ8mPGDw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=uPLB/S5K0JXIM1i0in4HXC52UQkMi+zF
        C3+WJdhQ2xoBTb1QpkQQ02qmREimUrOt8oPgMSu7tolZSo/frk2GFs0GbCsqAffi
        zCkxwngEseTNMOQkFave6SFkAy4tBkwZRICV2C5m/iiAh86viLsvASmyZD4AIlVM
        P/g0lu4w3h8=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 08BBEC41D9;
        Wed, 13 May 2020 11:35:39 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.231.104.69])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 4795AC41D8;
        Wed, 13 May 2020 11:35:36 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Guillaume Galeazzi <guillaume.galeazzi@gmail.com>
Cc:     "Guillaume G. via GitGitGadget" <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Subject: Re: [PATCH] submodule--helper.c: add only-active to foreach
References: <pull.631.git.1589099162707.gitgitgadget@gmail.com>
        <xmqq8shxc7ct.fsf@gitster.c.googlers.com>
        <cf25c55e-e0c8-6374-3adf-84f4314869e9@gmail.com>
Date:   Wed, 13 May 2020 08:35:34 -0700
In-Reply-To: <cf25c55e-e0c8-6374-3adf-84f4314869e9@gmail.com> (Guillaume
        Galeazzi's message of "Wed, 13 May 2020 07:17:30 +0200")
Message-ID: <xmqqwo5fvoe1.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 64114288-952F-11EA-B6C7-8D86F504CC47-77302942!pb-smtp21.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Guillaume Galeazzi <guillaume.galeazzi@gmail.com> writes:

>> 	git submodule foreach --trait=is-active ...
>> 	git submodule foreach --trait=!is-active ...
>> 	git submodule foreach --trait=is-populated ...
>>
>> to allow iterating only on submodules with/without given trait (I am
>> not suggesting the actual option name, but merely making sure that
>> 'is-active' is not anything special but one of the possibilities
>> that can be used to limit the iteration using the same mechanism).
>
> The idea that other candidate are possible seem good. But then users
> will need combination like is-active && !is-populated. ...
> ... this would allow combination with the is active filter and the
> previous example would be
>
>         git submodule--helper --is-active --is-populated=false <cmd>

There is no difference between that and

	git submodule--helper --trait=is-active --trait=is-populated

so I fail to see what new you are proposing, sorry.

