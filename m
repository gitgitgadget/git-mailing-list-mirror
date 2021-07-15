Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF32BC636CA
	for <git@archiver.kernel.org>; Thu, 15 Jul 2021 18:58:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9B25F613E5
	for <git@archiver.kernel.org>; Thu, 15 Jul 2021 18:58:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242291AbhGOTBb (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 15 Jul 2021 15:01:31 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:54077 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235622AbhGOTAS (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 15 Jul 2021 15:00:18 -0400
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 7CF88DBE38;
        Thu, 15 Jul 2021 14:57:23 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=JftVbn/NARuC
        R3rzq3Sqds0U06bBPim7eNqzJjk/jS0=; b=yAcBeIWpLDupORw/nRew5MWUqADw
        QeZE+t8vAg6uS/fLzcASemedrrD9w/+sAGG9PZiGvGAgrHarrFdPPTYqRPYfhDu8
        Cl0X4BpTo7Pc4CuRlFQlHIp/f7eTy8ad1I8fQBsbnUE5WmjjUqISrVwvz/FT6F1g
        FlQQ86DP4SIRYyE=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 72968DBE37;
        Thu, 15 Jul 2021 14:57:23 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.3.135])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id ED97DDBE36;
        Thu, 15 Jul 2021 14:57:22 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     Philippe Blain via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org,
        =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>,
        Brandon Williams <bwilliamseng@gmail.com>,
        Felipe Contreras <felipe.contreras@gmail.com>,
        Ryan Zoeller <rtzoeller@rtzoeller.com>,
        SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>,
        Philippe Blain <levraiphilippeblain@gmail.com>
Subject: Re: [PATCH] parse-options: don't complete option aliases by default
References: <pull.996.git.1626353925051.gitgitgadget@gmail.com>
        <8735sfzgkg.fsf@evledraar.gmail.com>
Date:   Thu, 15 Jul 2021 11:57:22 -0700
In-Reply-To: <8735sfzgkg.fsf@evledraar.gmail.com> (=?utf-8?B?IsOGdmFyIEFy?=
 =?utf-8?B?bmZqw7Zyw7A=?= Bjarmason"'s
        message of "Thu, 15 Jul 2021 18:16:26 +0200")
Message-ID: <xmqqy2a7s8vh.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 7D03A838-E59E-11EB-A02F-FD8818BA3BAF-77302942!pb-smtp2.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com> writes:

> I'm a bit biased here since I like --recursive better, but let's not
> drag that whole argument up again. I don't find the argument in
> bb62e0a99fc (clone: teach --recurse-submodules to optionally take a
> pathspec, 2017-03-17) convincing enough to have moved such a prominent
> use-case to a longer option name.

I do agree that it is a separate topic to pick one or the other as
the primary.  I think this change means that the users no longer
need to stop after hitting a tab:

    clone --recurs<TAB>

and instead get to "clone --recurse-submodules" right away, which is
a positigve change.  Of course, if the separate topic swaps which is
the canonical and which is the alias, the same user would get the
new canonical one right away from the same state.

So it does look like a good change to me.
