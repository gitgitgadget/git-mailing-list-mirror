Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 377A3C433F5
	for <git@archiver.kernel.org>; Tue,  7 Sep 2021 18:27:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 14FE161103
	for <git@archiver.kernel.org>; Tue,  7 Sep 2021 18:27:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345837AbhIGS2y (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 7 Sep 2021 14:28:54 -0400
Received: from pb-smtp21.pobox.com ([173.228.157.53]:55388 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236461AbhIGS2v (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 7 Sep 2021 14:28:51 -0400
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 5AF7C1438C6;
        Tue,  7 Sep 2021 14:27:45 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=8WRgc34A1P5a
        3K2Z4o+CF8mL7jah1+wNSUI52ST6P48=; b=jptcC019t6FTiYm2JYTcFZc5U2NV
        yIN/SjJDXBlrkeBXqxCIOG7PYQJiNhJ9NCaliseAGsPltzlCHLEMiPUGj5Jc8+/3
        qm7h1B/S1GpdFA+3vk0RR/rDjG0qaGUBsOnC0xlKxRP+VZ34GDlSIvK9g+2ranAX
        2clo9Q2eLoDl0uc=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 53DF21438C5;
        Tue,  7 Sep 2021 14:27:45 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.196.172.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 85B071438C4;
        Tue,  7 Sep 2021 14:27:42 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Eric Wong <e@80x24.org>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Johannes Sixt <j6t@kdbg.org>
Subject: Re: [PATCH v2 0/7] Drop support for git rebase --preserve-merges
References: <pull.195.git.1574542242.gitgitgadget@gmail.com>
        <pull.195.v2.git.1630497435.gitgitgadget@gmail.com>
        <xmqqk0k0ndbq.fsf@gitster.g> <87y28anq98.fsf@evledraar.gmail.com>
Date:   Tue, 07 Sep 2021 11:27:40 -0700
In-Reply-To: <87y28anq98.fsf@evledraar.gmail.com> (=?utf-8?B?IsOGdmFyIEFy?=
 =?utf-8?B?bmZqw7Zyw7A=?= Bjarmason"'s
        message of "Mon, 06 Sep 2021 08:58:13 +0200")
Message-ID: <xmqqpmtkb5r7.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 4A1AB728-1009-11EC-A055-98D80D944F46-77302942!pb-smtp21.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com> writes:

> On Wed, Sep 01 2021, Junio C Hamano wrote:
>
>> "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
>> writes:
>>
>>> In 427c3bd28ab (rebase: deprecate --preserve-merges, 2019-03-11) (whi=
ch was
>>> included in v2.22.0), we officially deprecated the --preserve-merges
>>> backend. Over two years later, it is time to drop that backend, and h=
ere is
>>> a patch series that does just that.
>>
>> A good goal.  There is no remaining use case where (a fictitious and
>> properly working version of) "--preserve-merges" option cannot be
>> replaced by "--rebase-merges", is it?  I somehow had a feeling that
>> the other Johannes (sorry if it weren't you, j6t) had cases that the
>> former worked better, but perhaps I am mis-remembering things.
>
> Fair enough. To be clear I think this series is fine as-is, we've just
> usually done "now that this function is dead, rm it" as part of the
> series that makes it dead, so I figured fixups/squashes to change those
> parts would be welcome & integrated, likewise Alban Gruin's suggestions
> in <62fbd389-28f5-76e5-d3f3-5510415a7bf5@gmail.com>.
>
> But the git-sh-i18n.sh change and/or his suggestions can be done after
> this lands...

I have this funny feeling that the "Fair enough" is thrown at a
comment that you didn't intend to ;-)
