Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1723FC433EF
	for <git@archiver.kernel.org>; Thu, 18 Nov 2021 20:54:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E5782610FC
	for <git@archiver.kernel.org>; Thu, 18 Nov 2021 20:53:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231392AbhKRU47 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 18 Nov 2021 15:56:59 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:51117 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231179AbhKRU47 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 18 Nov 2021 15:56:59 -0500
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 28029102EEB;
        Thu, 18 Nov 2021 15:53:58 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=IM3qguN73tTb
        7Sw0HE2lFo3byrapc4+l5um/XeIxc7M=; b=l21M7DtxBxD2Bcp8UmNG8pBdoGV3
        Xg8ftuvFqJYuO+wzcsCA8mBGi3X7b1PhXLQzfNZz1wOFJp/E8AgC81aCCS0CSKeW
        abgAWHDNjLhSFlWp40R7Eo1qfHlAgLr+jJoxeNtW0F2G+e5BWoHIXoObW5TmtBXa
        p5r9epns0flHGh8=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 1F1EE102EEA;
        Thu, 18 Nov 2021 15:53:58 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.133.2.91])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 82BC3102EE9;
        Thu, 18 Nov 2021 15:53:57 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Carlo Marcelo Arenas =?utf-8?Q?Bel=C3=B3n?= <carenas@gmail.com>
Cc:     Hamza Mahfooz <someguy@effective-light.com>, git@vger.kernel.org,
        =?utf-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>,
        Andreas Schwab <schwab@linux-m68k.org>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Subject: Re: [PATCH 1/2] grep/pcre2: limit the instances in which UTF mode
 is enabled
References: <20211118084143.279174-1-someguy@effective-light.com>
        <CAPUEspi5-urxZxHCsAWjyLxPWDfaYCK7nqGBL8FejU=n=qcFrQ@mail.gmail.com>
        <YZasJWuysic3OWS1@carlos-mbp.lan>
Date:   Thu, 18 Nov 2021 12:53:56 -0800
In-Reply-To: <YZasJWuysic3OWS1@carlos-mbp.lan> ("Carlo Marcelo Arenas
 =?utf-8?Q?Bel=C3=B3n=22's?=
        message of "Thu, 18 Nov 2021 11:40:21 -0800")
Message-ID: <xmqqo86hw5gb.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: A6254804-48B1-11EC-8E6B-62A2C8D8090B-77302942!pb-smtp1.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Carlo Marcelo Arenas Bel=C3=B3n <carenas@gmail.com> writes:

> I have to admit that adding to a complex condition might be obscuring
> some other edge case, and indeed the fact the test passed even without
> this fix is concerning.
>
> From my reading of what =C3=86var suggested originally[1], it would see=
m that
> the new is_log condition should be on an branch of its own, and more co=
de
> should be needed to make sure the contents we are going to use are inde=
ed
> utf8 by the time it hits pcre2_*match() before setting it.

At least, let's not consider pursuing this approach to pile on more
iffy code on top of broken code in the release.  Unless I hear
otherwise, I am leaning to revert the whole three patches of the
original series and call it a day for both 'maint' (for 2.34.1) and
'master'.

Thanks.
