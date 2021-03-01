Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10776C433DB
	for <git@archiver.kernel.org>; Mon,  1 Mar 2021 21:47:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C8FF360235
	for <git@archiver.kernel.org>; Mon,  1 Mar 2021 21:47:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243758AbhCAVqU (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 1 Mar 2021 16:46:20 -0500
Received: from pb-smtp21.pobox.com ([173.228.157.53]:53202 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244477AbhCAVno (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 1 Mar 2021 16:43:44 -0500
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id BF44C1245DA;
        Mon,  1 Mar 2021 16:43:02 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=mKsVB6DxsPaQ
        LhlRmT75yICectM=; b=xc15k7yg+XAddp6bRgNT4KkbMQ/RdJH935gSQV2+qFsj
        +JsmumuaeYgAsf3IEIDS+7KGWF7yfS3iHduJ+oGVQl5N+UdfkCqaZtOOAo4/g5TV
        qyVthEpoCOQEyWY8XW4ZjPAurggN+D3MynoSQacUn2q10ykAnypDuDNjTL1ZATk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=Uk0qk8
        PGtL5f+ezinCtlJ3fsSsmJG16I/zd9eujTN4u0tu1gV81vAsn/SPstfvQxqQ8Uwt
        rMnN+WSSJa9nw4bLBiIUAj2e3xRhXKxE3S/9a1+yfjCA7VoWlZV8aZMB63ZEYhHL
        tNFowK6y+1cchA/5EfiUH6u8i8uGHfClMibIE=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id B6EE01245D9;
        Mon,  1 Mar 2021 16:43:02 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 03D241245D6;
        Mon,  1 Mar 2021 16:42:59 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Eric Wong <e@80x24.org>,
        Benno Evers <benno@bmevers.de>, Jean Privat <jean@pryen.org>,
        =?utf-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>
Subject: Re: [PATCH 05/10] describe tests: convert setup to use test_commit
References: <20200223125102.6697-1-benno@bmevers.de>
        <20210228195414.21372-6-avarab@gmail.com>
Date:   Mon, 01 Mar 2021 13:42:58 -0800
In-Reply-To: <20210228195414.21372-6-avarab@gmail.com> (=?utf-8?B?IsOGdmFy?=
 =?utf-8?B?IEFybmZqw7Zyw7A=?=
        Bjarmason"'s message of "Sun, 28 Feb 2021 20:54:09 +0100")
Message-ID: <xmqqmtvmo8il.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1.90 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 17C60010-7AD7-11EB-BE47-D609E328BF65-77302942!pb-smtp21.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason  <avarab@gmail.com> writes:

> Convert the setup of the describe tests to use test_commit when
> possible. This makes use of the new --annotated-tag option to
> test_commit.

Much nicer ;-)

>  t/t6120-describe.sh | 58 ++++++++++-----------------------------------
>  1 file changed, 13 insertions(+), 45 deletions(-)
