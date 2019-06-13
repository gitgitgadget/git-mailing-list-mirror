Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DD4C91F462
	for <e@80x24.org>; Thu, 13 Jun 2019 15:56:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731631AbfFMP4f (ORCPT <rfc822;e@80x24.org>);
        Thu, 13 Jun 2019 11:56:35 -0400
Received: from pb-smtp21.pobox.com ([173.228.157.53]:51198 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726655AbfFMP4f (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 13 Jun 2019 11:56:35 -0400
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id A53A07FB36;
        Thu, 13 Jun 2019 11:56:32 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=z3R12/WJ1ylU
        z6Kdxpi7uVZCurY=; b=V4OlCIXpUNL3eN2AscGeIEVkDfdsbxGh4wyWtNbMVIzY
        B6tMvjRQiYZFjUpsWL6hB7ML3lDu5Kp+rcu4zUTw6ElUDLT+XGIoIPkCoPCGriNX
        /NypClKCemeKTAKBcEcrrQfCY2xyw1BlLcVTxguJ4HQEoV5Vt0LENX+iNZMCs2U=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=fCmfsR
        YFYXR1Fz92/989khXkyJwyg5OWbX5OtF99SJJcPDQ4kMALoGHxI3vxx/KgX+JzZK
        1CRSGgfG8gjtsTlWVYSBILQss7Xug5x5SgYXn3/pJglTgX8tZ0fz+NTaRPBwK6Pi
        PFxVTGvWNzecqM6uhCPUAi1OoaburHRu/z/PI=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 9D1A47FB35;
        Thu, 13 Jun 2019 11:56:32 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id BDF977FB34;
        Thu, 13 Jun 2019 11:56:29 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>
Cc:     Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH 1/1] ci: split the `linux-gcc` job into two jobs
References: <pull.266.git.gitgitgadget@gmail.com>
        <ac102169ec6f47b8be1fe69b4798de385f102af8.1560430430.git.gitgitgadget@gmail.com>
        <20190613153354.GC31952@szeder.dev>
Date:   Thu, 13 Jun 2019 08:56:25 -0700
In-Reply-To: <20190613153354.GC31952@szeder.dev> ("SZEDER =?utf-8?Q?G?=
 =?utf-8?Q?=C3=A1bor=22's?= message of
        "Thu, 13 Jun 2019 17:33:54 +0200")
Message-ID: <xmqqv9x9wkba.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: CED206F0-8DF3-11E9-A1A4-8D86F504CC47-77302942!pb-smtp21.pobox.com
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

SZEDER G=C3=A1bor <szeder.dev@gmail.com> writes:

> On Thu, Jun 13, 2019 at 05:53:51AM -0700, Johannes Schindelin via GitGi=
tGadget wrote:
>> From: Johannes Schindelin <johannes.schindelin@gmx.de>
>>=20
>> This job was abused to not only run the test suite in a regular way bu=
t
>> also with all kinds of `GIT_TEST_*` options set to non-default values.
>>=20
>> Let's split this into two
>
> Why...?
>
>> with the `linux-gcc` job running the default
>> test suite, and the newly-introduced `linux-gcc-extra` job running the
>> test suite in the "special" ways.
>>=20
>> Technically, we would have to build Git only once, but it would not be
>> obvious how to teach Travis to transport build artifacts, so we keep i=
t
>> simple and just build Git in both jobs.

I had the same reaction.

If it said something like:

    There is no logical reason why these extras need to be tied to
    the linux-gcc platform.  instead of tying the extra
    configuration tests only to linux-gcc, split it so that they are
    also run on all other combinations, and this is merely a first
    step of doing so

it might at least have been possible to judge if the motivation is
sane, but the proposed log message, while it is quite clear what is
being done and what its shortcomings are, is silent on why we would
want to do this in the first place, and that makes it even harder to
swallow the shortcomings.

Thanks.
