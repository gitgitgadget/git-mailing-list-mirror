Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8341B1F97E
	for <e@80x24.org>; Sat, 24 Nov 2018 01:48:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729231AbeKXMfa (ORCPT <rfc822;e@80x24.org>);
        Sat, 24 Nov 2018 07:35:30 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:57427 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728578AbeKXMf3 (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 24 Nov 2018 07:35:29 -0500
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id F33BE1264E7;
        Fri, 23 Nov 2018 20:48:55 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:in-reply-to:references:date:message-id:mime-version
        :content-type; s=sasl; bh=GSUI2KLE9lKGd1QGTvb5Q2crN34=; b=v2gfCT
        UCTaCpucjdjBBVHq6VQnufJDBa73jjGeOHx67e+z+kPu/Ka7qwZb4FDbKWoz7jXI
        jXhe0PKKzEhtN3ok9R7iuUgbOylGwfyqTQQWhvO0jvw1GeslcRcZ0NqqM4VCIeuV
        fuCvFgOnkxH4Ycu6oiUu61jv3Ba7j39DNLvKM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:in-reply-to:references:date:message-id:mime-version
        :content-type; q=dns; s=sasl; b=Odxn7CKBXJ3le1UPbJaRCHdlXT0ogLGK
        6QhcBPKDq18uV5JvQQYVxQ/1oWl/7WkxaFWKhg2UX0KmjQDuNIuwlMoYY6+T2cJ4
        zM92p8HTDUMYP/ZNhO/MxaxSArJVlQCay/ppX64yN9ZVfnEX59ZVZbAj8O0ZQOex
        eTeYE/CnwWA=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id EB4CC1264E6;
        Fri, 23 Nov 2018 20:48:55 -0500 (EST)
Received: from pobox.com (unknown [35.187.50.168])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 636FE1264E5;
        Fri, 23 Nov 2018 20:48:55 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     =?utf-8?B?0J7Qu9GPINCi0LXQu9C10LbQvdCw0Y8=?= 
        <olyatelezhnaya@gmail.com>, Jeff King <peff@peff.net>,
        Christian Couder <christian.couder@gmail.com>,
        SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>,
        git <git@vger.kernel.org>
Subject: Re: [RFC PATCH 1/5] ref-filter: add objectsize:disk option
In-Reply-To: <nycvar.QRO.7.76.6.1811221232370.41@tvgsbejvaqbjf.bet> (Johannes
        Schindelin's message of "Thu, 22 Nov 2018 12:33:52 +0100 (STD)")
References: <CAL21BmnoZuRih3Ky66_Tk0PweD36eZ6=fbY3jGumRcSJ=Bc_pQ@mail.gmail.com>
        <01020166f76d845f-1a02a31e-5094-4b27-974d-a23811066c58-000000@eu-west-1.amazonses.com>
        <xmqqr2fq3n1j.fsf@gitster-ct.c.googlers.com>
        <nycvar.QRO.7.76.6.1811121300520.39@tvgsbejvaqbjf.bet>
        <20181112131247.GL3956@sigill.intra.peff.net>
        <xmqqwophyc9s.fsf@gitster-ct.c.googlers.com>
        <CAL21BmmK_ZS=wuGXRLj=s0=dqMvUWFiLLBZWx5ymnFjyasX=sA@mail.gmail.com>
        <xmqqa7m39swq.fsf@gitster-ct.c.googlers.com>
        <nycvar.QRO.7.76.6.1811221232370.41@tvgsbejvaqbjf.bet>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
Date:   Sat, 24 Nov 2018 10:48:54 +0900
Message-ID: <xmqqmupz454p.fsf@gitster-ct.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 1A38E166-EF8B-11E8-AA60-BFB3E64BB12D-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> To fix this, I prepared a GitGitGadget PR
> (https://github.com/gitgitgadget/git/pull/87) and will submit it as soon
> as I am satisfied that the build works.

Thanks.  This won't be in the upcoming release anyway, so we can fix
it up without "oops, let's pile another fix on it" if we wanted to
after the release by kicking it back to 'pu', but in the meantime,
keeping the tip of 'next' free from known breakage certainly is a
sensible thing to do.

