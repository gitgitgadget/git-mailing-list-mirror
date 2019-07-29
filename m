Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4681A1F462
	for <e@80x24.org>; Mon, 29 Jul 2019 16:13:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728271AbfG2QNC (ORCPT <rfc822;e@80x24.org>);
        Mon, 29 Jul 2019 12:13:02 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:61554 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727651AbfG2QNC (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 29 Jul 2019 12:13:02 -0400
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id C5A0D15A828;
        Mon, 29 Jul 2019 12:12:59 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=MFeq5jN9uSXi
        Gx9QEPwHdd/V/UY=; b=xtMfSz9Ower3/f5RvHVRVxnUIatQiKd9DDqMM90vR2tc
        nhjJbK123QSJDYjFJdQ2/pBmn6QBplV+Yppm8paSfl379RUD3bmucB0iuLC/acJ9
        dPw9zCiXdLSVwtilX2W7KUbZPKAB9gWGfQucCihucmPbu0Fqg2XJPXnCQziakWc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=gtRtOi
        TEEwlLesZnhNjQjZvV4FKKbg24Egl7M+PDjLfCHZ503FQl447JEMigBDh21cDznr
        nUI8Kq4hWpP3djvZ2T9XgsAET5qD9zc/7wJDIXTiMtZS6XqtYuM3SS+nBN2/Pqzl
        HbeuB4vCUIQOX0s0TMiOJKAZk18kICyscSGqI=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id ACA9815A826;
        Mon, 29 Jul 2019 12:12:59 -0400 (EDT)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id E986415A825;
        Mon, 29 Jul 2019 12:12:58 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org,
        Carlo Marcelo Arenas =?utf-8?Q?Bel=C3=B3n?= 
        <carenas@gmail.com>, Beat Bolli <dev+git@drbeat.li>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH v2 0/8] grep: PCRE JIT fixes + ab/no-kwset fix
References: <20190724151415.3698-1-avarab@gmail.com>
        <20190726150818.6373-1-avarab@gmail.com>
        <xmqqpnlwmthc.fsf@gitster-ct.c.googlers.com>
        <87y30h5h8v.fsf@evledraar.gmail.com>
Date:   Mon, 29 Jul 2019 09:12:57 -0700
In-Reply-To: <87y30h5h8v.fsf@evledraar.gmail.com> (=?utf-8?B?IsOGdmFyIEFy?=
 =?utf-8?B?bmZqw7Zyw7A=?= Bjarmason"'s
        message of "Mon, 29 Jul 2019 11:20:48 +0200")
Message-ID: <xmqqpnlsvmye.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: BB6C540C-B21B-11E9-8563-72EEE64BB12D-77302942!pb-smtp2.pobox.com
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com> writes:

> I have some fix-for-the-fix and was going to submit a v3 of this series=
,
> but I think the more responsible thing to do at this point, especially
> with various patches from Carlo that need to be integrated in one way o=
r
> another, is to back it out until the outstanding issues are addressed.
>
> If it's not too much trouble, would you mind reverting just the two
> patches at the tip of ab/no-kwset in "next"? I.e.
>
>     b65abcafc7 ("grep: use PCRE v2 for optimized fixed-string search", =
2019-07-01)
>     48de2a768c ("grep: remove the kwset optimization", 2019-07-01)

As we'd be in pre-release freeze soonish, let me revert the merge to
'next' and drop these two tip commits from the topic branch (keeping
the earlier parts), and ask you two to work together to get the
pcre-jit stuff into a good shape.

Thanks.
