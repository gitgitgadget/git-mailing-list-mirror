Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2A18C433FE
	for <git@archiver.kernel.org>; Thu,  3 Dec 2020 18:14:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 66B9C207A8
	for <git@archiver.kernel.org>; Thu,  3 Dec 2020 18:14:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726479AbgLCSNo (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 3 Dec 2020 13:13:44 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:53497 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726309AbgLCSNo (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 3 Dec 2020 13:13:44 -0500
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 0C169A6475;
        Thu,  3 Dec 2020 13:13:01 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=N6fg9uANsPVx
        ZSH33/35gr1Ojqo=; b=uuwmpN2OPS5c2tw+xaIAHjgTBaHVvUzqNIc2t3Y+gW4p
        yGvM/VbJQVS15Y+iSacGB5DxxzUXXBB/MleffiUigXxedEr+l9GP7A9VjB4g+8LK
        a9vMyAhMrXyIQ/pshAHHRHGG8DuI/Wr0szD3ewKVWO0C+Cjv1V+JAT+e7yfcGls=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=CqDrjd
        uC9ZQf9V8Cpn9oqRwiEWS+gzT9+0QQleLScn6T+TgW9wmskWVDoQNyIgqdpxt1i9
        WWwkeIASjPxjkMujp5jozu3xDDWLFxHSl1pRNRpdmQm6xFIbVo7z8hovnivTGDDn
        /hzP1um0WgUOuFwICWiuJxc4hYFjA6Gaft+ls=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id BE739A6474;
        Thu,  3 Dec 2020 13:13:00 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.75.7.245])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id EEC90A6473;
        Thu,  3 Dec 2020 13:12:59 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Peter =?utf-8?Q?K=C3=A4stle?= <peter.kaestle@nokia.com>
Cc:     Philippe Blain <levraiphilippeblain@gmail.com>,
        Ralf Thielow <ralf.thielow@gmail.com>,
        Git mailing list <git@vger.kernel.org>
Subject: Re: BUG in fetching non-checked out submodule
References: <CAN0XMOLiS_8JZKF_wW70BvRRxkDHyUoa=Z3ODtB_Bd6f5Y=7JQ@mail.gmail.com>
        <CC0FA973-E37A-4BD3-B5A2-1436DD8DF16F@gmail.com>
        <xmqqzh2vkdu8.fsf@gitster.c.googlers.com>
        <04968f5c-c8bd-c57e-d646-7c9f7691e1a8@nokia.com>
        <CADtb9DxTgEWfOF7jDGGt3eQSCaaqeiyJfS4V-e0SyPenE2SXWA@mail.gmail.com>
        <0b6a34a0-428e-5fc4-307d-1217b112659c@nokia.com>
Date:   Thu, 03 Dec 2020 10:12:59 -0800
In-Reply-To: <0b6a34a0-428e-5fc4-307d-1217b112659c@nokia.com> ("Peter
        =?utf-8?Q?K=C3=A4stle=22's?= message of "Thu, 3 Dec 2020 16:33:37 +0100")
Message-ID: <xmqqzh2uhi6s.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 2D36B9FA-3593-11EB-8EF8-74DE23BA3BAF-77302942!pb-smtp2.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Peter K=C3=A4stle <peter.kaestle@nokia.com> writes:

> On quick glance this sounds plausible, but to fully understand it I
> need to put some effort in reading this code again.  I hope to do so=20
> tomorrow.  We can then compile a new set of patches including this
> real fix and Ralf's and my test case.
>
> Thanks for digging into it.

Yeah, thanks, both for noticing problem so quickly and started
digging to find the real solution.

By the way, as to the "if this were originally two patches, we could
have saved the test that expects failure" you raised, I do not think
it is a good idea to optimize for cases where changes turn out
problematic and have to get reverted.
