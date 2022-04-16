Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E3EFC433EF
	for <git@archiver.kernel.org>; Sat, 16 Apr 2022 00:28:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229784AbiDPAal (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 15 Apr 2022 20:30:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34308 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229561AbiDPAal (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 15 Apr 2022 20:30:41 -0400
Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 56D43D112B
        for <git@vger.kernel.org>; Fri, 15 Apr 2022 17:28:10 -0700 (PDT)
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 3B66D10E125;
        Fri, 15 Apr 2022 20:28:09 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=jaP1SNdz9OLl
        f+gV2Hw4pkE/pSH+kzQLTVpFFvzo9co=; b=tkLnNqGL/q1S0sEod7A8zJyRsBbR
        +bKWtN0Kdz9JqSVi7m6VMzNVW+aIjkR/CH29IBkmYh8G8aGVZFpKnbbCYU+H2AvZ
        cxlbNVCE4kRanZ3RO1chmoOx9N9XL8rgJsaSFXcrZEEMyksLpln0yreh9z/hwknu
        m/af118sDE45y8c=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 3448E10E123;
        Fri, 15 Apr 2022 20:28:09 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.105.84.173])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 9BF2610E120;
        Fri, 15 Apr 2022 20:28:08 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Carlo Arenas <carenas@gmail.com>
Cc:     git@vger.kernel.org, phillip.wood@talktalk.net, avarab@gmail.com
Subject: Re: [PATCH 2/2] config.mak.dev: alternative workaround to gcc 12
 warning in http.c
References: <20220415123922.30926-1-carenas@gmail.com>
        <20220415231342.35980-1-carenas@gmail.com>
        <20220415231342.35980-3-carenas@gmail.com>
        <xmqqh76taplg.fsf@gitster.g>
        <CAPUEspj4zu-59qxoVPMDGwMvWmu977WRDe7=t0if7raz=H24AQ@mail.gmail.com>
Date:   Fri, 15 Apr 2022 17:28:06 -0700
In-Reply-To: <CAPUEspj4zu-59qxoVPMDGwMvWmu977WRDe7=t0if7raz=H24AQ@mail.gmail.com>
        (Carlo Arenas's message of "Fri, 15 Apr 2022 17:02:57 -0700")
Message-ID: <xmqqwnfp98ix.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 17230512-BD1C-11EC-9254-CB998F0A682E-77302942!pb-smtp2.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Carlo Arenas <carenas@gmail.com> writes:

> this would be IMHO a better fix than the one currently queued in
> ab/http-gcc-12-workaround and indeed squashes the warning with the gcc
> 12 version that is likely to be released with Fedora 36,=20

That is an excellent news, as ...

> but notice
> that it was proposed before[1] and apparently didn't work with the
> version of the compiler that =C3=86var was using at that time, as
> documented in the commit message.

... I was the one who suggested it, and I remember that it didn't
work for =C3=86var back then.  If the problem with the version =C3=86var =
had
is no longer there, that does sound like a good thing.  We can take
the patch you posted and then post release we can apply the "clear
the .finished member as we are done with the slot" fix, which is a
good hygiene regardless of any compiler warning issue.

> Either way, my hope is (assuming this series will go earlier than the
> other one), that a revert to this commit is included at the end of
> ab/http-gcc-12-workaround, instead of adding any code changes to this
> series.

At this point, my inclination is to merge these two DEVELOPER_CFLAGS
changes before the 2.36 final gets tagged.

Thanks.
