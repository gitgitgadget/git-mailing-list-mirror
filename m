Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC689C433DB
	for <git@archiver.kernel.org>; Mon, 29 Mar 2021 18:46:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9A7AF6195D
	for <git@archiver.kernel.org>; Mon, 29 Mar 2021 18:46:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230271AbhC2SqS (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 29 Mar 2021 14:46:18 -0400
Received: from pb-smtp20.pobox.com ([173.228.157.52]:60234 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230435AbhC2SqK (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 29 Mar 2021 14:46:10 -0400
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id A36EC1244CE;
        Mon, 29 Mar 2021 14:46:10 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=BailA8sirKZD
        iA8tH60jUfhV9YY=; b=FqilmG6uQTGnmIOd+DS1Wjm/CaL1pCBjAvoc4T8B2U8o
        8kD7aTM3EMA1PkT2YYxQUnO/8u0Gzc1svE9SqI2QTcS6K4xPhb0WhJwd9JEtbUxL
        ErKOkA5O4j38rsGq/my+Hx+NEu1rvwSqAnLk7RjJdxk2JiF6DWFUZtMA/Aqgx7o=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=HTDQIf
        q33dmsI1IY5DSu5SQUeW4IbPZMHfBC/9AsxO7tyZeZode7GU3o50u/pKUoTfQyb8
        HXn213IBgaFUrTz6AlWpB5Ps8R/qiY7RgSctAkR+6MH+/Zqkt4UkjK4Wn3FrpZIQ
        OE6AchvVMxSMT/DxXxeJsC1cW6LhotlQYamfM=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 9D1111244CD;
        Mon, 29 Mar 2021 14:46:10 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id E94D21244CC;
        Mon, 29 Mar 2021 14:46:07 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Jeff King <peff@peff.net>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH v2 3/5] Makefile: don't needlessly "rm $@ $@+" before
 "mv $@+ $@"
References: <20210307132001.7485-1-avarab@gmail.com>
        <cover-0.6-00000000000-20210329T161723Z-avarab@gmail.com>
        <patch-3.6-96e2338ed8e-20210329T161723Z-avarab@gmail.com>
Date:   Mon, 29 Mar 2021 11:46:06 -0700
In-Reply-To: <patch-3.6-96e2338ed8e-20210329T161723Z-avarab@gmail.com>
 (=?utf-8?B?IsOGdmFyCUFybmZqw7Zyw7A=?= Bjarmason"'s message of "Mon, 29 Mar
 2021 18:20:10 +0200")
Message-ID: <xmqqft0dkdch.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1.90 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 060EACC0-90BF-11EB-91A7-E43E2BB96649-77302942!pb-smtp20.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason  <avarab@gmail.com> writes:

>     rm -f thing thing+
>     prepare contents for thing >thing+
>     mv thing+ thing
> ...
> But I think guarding against "mv" failing is a step too far in
> paranoia,...

If mv fails the $(MAKE) rule would fail, so it is OK.  It may leave
thing+ behind, but there is no reason to expect why you would be
able to rm it the next time, so from that point of view, it is OK to
drop the first "rm -f thing+", I would think.  The only case I can
thing of that would help is when you are sharing the working tree
with your team member, the directories are writable to both of you,
but somehow the other person creates thing+ with 0644 or 0755 mode
bits.  You cannot redirect into thing+ the other person left behind,
but you can "rm -f thing+ && cmd >$thing+" (or "cmd -o $thing+") in
such a situation, and that is probably where the pattern comes from
---i.e. simple hygiene.
